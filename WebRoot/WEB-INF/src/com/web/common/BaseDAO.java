package com.web.common;

import java.io.BufferedWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

import oracle.sql.CLOB;

import com.web.common.util.LogUtil;
import com.web.framework.persist.QueryStatement;
import com.web.framework.persist.SqlBroker;
import com.web.framework.util.StringUtil;

public class BaseDAO {
	private Connection conn = null;
	private Class strClass = null;
	private SqlBroker broker = null;
	private final boolean useSqlDebug = true;
	Logger log = LogUtil.instance().getLogger("consoleLogger");
	
	public BaseDAO(){
		this.strClass = getClass();
	}
	public BaseDAO(Class strClass) {
		this.strClass = strClass;
	}
	/**
	 * 외부 Connection 사용할경우 사용함.
	 * @param strClass
	 * @param conn
	 */
	public BaseDAO(Class strClass, Connection conn) {
		this.strClass = strClass;
		this.conn = conn;
	}
	
	public Connection getConn() {
		return conn;
	}
	/**
	 * Connection 정보를 얻어옴.
	 * @throws Exception
	 */
	private void getConnection() throws Exception{
    	try {
			if( conn == null ){
				broker = new SqlBroker();
				conn = broker.getConnection();

			}
    	} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}
	/**
	 * Transaction 시작.
	 * @throws Exception
	 */
    public void startTransaction() throws Exception {
    	try {
	    	getConnection();
	    	conn.setAutoCommit(false);
    	} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
    }
    /**
     * Transaction 사용시에 반드시 써야함.
     * @throws Exception
     */
    public void commitTransaction() throws Exception {
    	try {
	    	if( conn != null )
	    		conn.commit();
    	} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
    }
    /**
     * Connection 닫기.
     * Transaction 사용시에 반드시 finally문에 써야함.
     * @throws Exception
     */
	public void endTransaction() throws Exception  {
		try{
			if( conn != null ){
				conn.rollback();
	    		conn.close();
	    		conn = null;
	    		log.debug("[" + strClass.getName() + " ] Connection End ");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}
	/**
	 * insert, update시에 사용.
	 * @param args
	 * @param query
	 * @return int
	 * @throws Exception
	 */
	public int executeQuery(QueryStatement qs)throws Exception{
		PreparedStatement pstmt = null;
		int iRtn = 0;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());	
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}

			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			iRtn = pstmt.executeUpdate();		
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");

			if( conn.getAutoCommit() ){
				commitTransaction();
			}
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			if( pstmt != null){
				pstmt.close();
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return iRtn;
	}
	public boolean executeQueryClob(QueryStatement qs, String strClob)throws Exception{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				CLOB clob = (CLOB)rs.getObject(1);
	     	 	Writer writer = new BufferedWriter(clob.getCharacterOutputStream());
	     	    writer.write(strClob);
	     	    writer.close();
	     	    writer = null;
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
			
			if( conn.getAutoCommit() ){
				commitTransaction();
			}
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
			return false;
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			return false;
		}finally{
			if( pstmt != null){
				pstmt.close();
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return true;
	}
	public HashMap executeQueryOne(QueryStatement qs)throws Exception{
		PreparedStatement pstmt = null;
		ResultSetMetaData rsMD = null;
		ResultSet rs = null;

		HashMap mRs = null;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			rsMD = rs.getMetaData();
			int iColumn = rsMD.getColumnCount();
			int iLoop = 0;
			StringBuffer output = null;
			Reader input = null;
			char[] buffer= null;
			int byteRead = 0;
			if (rs.next()) {
				mRs = new HashMap();
				iLoop = 0;
				while( iLoop < iColumn){
					if(rsMD.getColumnTypeName(iLoop+1).equals("CLOB")){
						output = new StringBuffer();
						input = rs.getCharacterStream(rsMD.getColumnName(iLoop+1).toUpperCase());

						if(input != null){
							buffer = new char[1024];
							byteRead = 0;
							while((byteRead=input.read(buffer,0,1024))!=-1){
								output.append(buffer,0,byteRead);
							}
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(output.toString()));
							input.close();							
						}else{
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), "");
						}
					} else {
						mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(rs.getString(rsMD.getColumnName(iLoop+1))).trim() );
					}
					iLoop++;
				}
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
			
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
			}catch(SQLException exc){
				log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return mRs;
	}
	public String executeQueryFrist(QueryStatement qs)throws Exception{
		PreparedStatement pstmt = null;
		ResultSetMetaData rsMD = null;
		ResultSet rs = null;

		String mRs = "";
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			rsMD = rs.getMetaData();
			int iColumn = rsMD.getColumnCount();
			int iLoop = 0;
			StringBuffer output = null;
			Reader input = null;
			char[] buffer= null;
			int byteRead = 0;
			if (rs.next()) {
				iLoop = 0;
				if( iLoop < iColumn){
					if(rsMD.getColumnTypeName(iLoop+1).equals("CLOB")){
						output = new StringBuffer();
						input = rs.getCharacterStream(rsMD.getColumnName(iLoop+1).toUpperCase());

						if(input != null){
							buffer = new char[1024];
							byteRead = 0;
							while((byteRead=input.read(buffer,0,1024))!=-1){
								output.append(buffer,0,byteRead);
							}
							mRs = StringUtil.nvl(output.toString());
							input.close();							
						}else{
							mRs = "";
						}
					} else {
						mRs = StringUtil.nvl(rs.getString(rsMD.getColumnName(iLoop+1))).trim();
					}
					iLoop++;
				}
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
			
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
			}catch(SQLException exc){
				log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return mRs;
	}
	/**
	 * list시에 사용.
	 * @param args
	 * @param query
	 * @return ArrayList
	 * @throws Exception
	 */
	public ArrayList executeQueryList(QueryStatement qs)throws Exception{
		PreparedStatement pstmt = null;
		ResultSetMetaData rsMD = null;
		ResultSet rs = null;

		ArrayList lRtn = null;
		HashMap mRs = null;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			rsMD = rs.getMetaData();
			int iColumn = rsMD.getColumnCount();
			int iLoop = 0;
			StringBuffer output = null;
			Reader input = null;
			char[] buffer= null;
			int byteRead = 0;
			lRtn = new ArrayList();
			while (rs.next()) {
				mRs = new HashMap();
				iLoop = 0;
				while( iLoop < iColumn){
					if(rsMD.getColumnTypeName(iLoop+1).equals("CLOB")){
						output = new StringBuffer();
						input = rs.getCharacterStream(rsMD.getColumnName(iLoop+1).toUpperCase());

						if(input != null){
							buffer = new char[1024];
							byteRead = 0;
							while((byteRead=input.read(buffer,0,1024))!=-1){
								output.append(buffer,0,byteRead);
							}
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(output.toString()));
							input.close();							
						}else{
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), "");
						}
					} else {
						mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(rs.getString(rsMD.getColumnName(iLoop+1))).trim() );
					}
					iLoop++;
				}
				lRtn.add(mRs);
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
			}catch(SQLException exc){
				log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return lRtn;
	}
	public LinkedList executeQueryLink(QueryStatement qs)throws Exception{
		PreparedStatement pstmt = null;
		ResultSetMetaData rsMD = null;
		ResultSet rs = null;

		LinkedList lRtn = null;
		HashMap mRs = null;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			rsMD = rs.getMetaData();
			int iColumn = rsMD.getColumnCount();
			int iLoop = 0;
			StringBuffer output = null;
			Reader input = null;
			char[] buffer= null;
			int byteRead = 0;
			lRtn = new LinkedList();
			while (rs.next()) {
				mRs = new HashMap();
				iLoop = 0;
				while( iLoop < iColumn){
					if(rsMD.getColumnTypeName(iLoop+1).equals("CLOB")){
						output = new StringBuffer();
						input = rs.getCharacterStream(rsMD.getColumnName(iLoop+1).toUpperCase());

						if(input != null){
							buffer = new char[1024];
							byteRead = 0;
							while((byteRead=input.read(buffer,0,1024))!=-1){
								output.append(buffer,0,byteRead);
							}
							mRs.put(rsMD.getColumnName(iLoop+1).toUpperCase(), StringUtil.nvl(output.toString()));
							input.close();							
						}else{
							mRs.put(rsMD.getColumnName(iLoop+1).toUpperCase(), "");
						}
					} else {
						mRs.put(rsMD.getColumnName(iLoop+1).toUpperCase(), StringUtil.nvl(rs.getString(rsMD.getColumnName(iLoop+1))).trim() );
					}
					iLoop++;
				}
				lRtn.add(mRs);
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
			}catch(SQLException exc){
				log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return lRtn;
	}
	public ArrayList executeQueryAddList(QueryStatement qs, ArrayList oldList)throws Exception{
		PreparedStatement pstmt = null;
		ResultSetMetaData rsMD = null;
		ResultSet rs = null;

		HashMap mRs = null;
		try {
			long t1 = System.currentTimeMillis();
			getConnection();
			
			pstmt = conn.prepareStatement(qs.getSql());
			if( qs.getParam() != null && qs.getParam().size() > 0){
				setBinding(pstmt, qs.getParam() );
			}
			if( useSqlDebug ){
				log.debug("[" + strClass.getName() + ":" + qs.getKey() +" ]"+getDebugQuery(qs));
			}
			rs = pstmt.executeQuery();
			rsMD = rs.getMetaData();
			int iColumn = rsMD.getColumnCount();
			int iLoop = 0;
			StringBuffer output = null;
			Reader input = null;
			char[] buffer= null;
			int byteRead = 0;
			while (rs.next()) {
				mRs = new HashMap();
				iLoop = 0;
				while( iLoop < iColumn){
					if(rsMD.getColumnTypeName(iLoop+1).equals("CLOB")){
						output = new StringBuffer();
						input = rs.getCharacterStream(rsMD.getColumnName(iLoop+1).toUpperCase());

						if(input != null){
							buffer = new char[1024];
							byteRead = 0;
							while((byteRead=input.read(buffer,0,1024))!=-1){
								output.append(buffer,0,byteRead);
							}
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(output.toString()));
							input.close();							
						}else{
							mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), "");
						}
					} else {
						mRs.put(rsMD.getColumnName(iLoop+1).toLowerCase(), StringUtil.nvl(rs.getString(rsMD.getColumnName(iLoop+1))).trim() );
					}
					iLoop++;
				}
				oldList.add(mRs);
			}
			long t2 = System.currentTimeMillis();
			log.debug("[" + strClass.getName() + " ] execute time:[" + (t2-t1)/1000.0 + "] seconds");	
		}catch(SQLException sqle){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + sqle.getMessage(), sqle);
		}catch(Exception exc){
			conn.rollback();
			log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
			}catch(SQLException exc){
				log.error("[" + strClass.getName() + " ] " + exc.getMessage(), exc);
			}
			if( conn.getAutoCommit() ){
				endTransaction();
			}
		}    		
		return oldList;
	}
	protected void setBinding(PreparedStatement stmt, List bindVars) throws SQLException {
		int len = 0;
		try{
			if(bindVars != null) len = bindVars.size();
			
			for (int i=0; i < len; i++)
			{
				Object bind = bindVars.get(i);
				if(bind == null){
					stmt.setString(i+1, null);
					continue;
				}
					
				if (bind instanceof String) {
					stmt.setString(i+1, (String)bind);
				} else if (bind instanceof Integer) { 
					stmt.setInt(i+1, ((Integer)bind).intValue());
				} else if (bind instanceof Long) {
					stmt.setLong(i+1,((Long)bind).longValue());
				} else if (bind instanceof StringBuffer) {
					String value = ((StringBuffer)bind).toString();
					StringReader sr = new StringReader(value);
					stmt.setCharacterStream(i+1, sr, value.length());
				} else if (bind instanceof Timestamp) {
					stmt.setTimestamp(i+1, (Timestamp)bind);
				} else	if (bind instanceof Date) {
					java.sql.Date d = new java.sql.Date(((Date)bind).getTime());
					stmt.setDate(i+1, d);
				} else if(bind instanceof Float){
					stmt.setFloat(i+1, ((Float)bind).floatValue());
				} else if(bind instanceof Double){
					stmt.setDouble(i+1, ((Double)bind).doubleValue());
				} else {
					stmt.setObject(i+1, bind);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}	
	protected String getDebugQuery(QueryStatement qs){

		StringBuffer debugQuery = null;
		List l = qs.getParam();
		String sql = qs.getSql();
		if(l !=null && l.size() > 0){
			
			debugQuery = new StringBuffer(StringUtil.ReplaceAll(sql, "?", "&$!#$"));
			
			for(int x=0; x < qs.getParam().size(); x++)
				debugQuery = new StringBuffer(StringUtil.replaceFirst(debugQuery.toString(), "&$!#$", "'"+ l.get(x) +"'"));

			return debugQuery.toString();
		}
		else
			return sql;
	}
}
