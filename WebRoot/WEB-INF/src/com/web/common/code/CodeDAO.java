/*
 * Created on 2006. 2. 1.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.web.common.code;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.web.common.BaseDAO;
import com.web.common.util.LogUtil;
import com.web.framework.data.DataSet;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ISqlStatement;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.ListStatement;
import com.web.framework.persist.QueryStatement;

/**
 * @author 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CodeDAO extends AbstractDAO {

Logger logger = LogUtil.instance().getLogger("consoleLogger");
	
	public DataSet getCodeList(String smlcode) throws DAOException{
	     return  getCodeList(smlcode, "");
	}

	public DataSet getCodeList(String smlcode,String useyn) throws DAOException{
		int totCount = 0;

		 StringBuffer sb = new StringBuffer();
		 QueryStatement sql = new QueryStatement();
		 sb.append(" SELECT BIG_CD, SML_CD, CD_NM, CD_DESC,USE_YN ");
		 sb.append(" FROM T_CODE ");
		 sb.append(" WHERE SML_CD = ? ");
		 sql.setString(smlcode);

		 if(!useyn.equals("")) {
		 	sb.append(" AND USE_YN = ? ");
		 	sql.setString(useyn);
		 }

		 sql.setSql(sb.toString());

		 logger.debug("[getCodeList]" + sql.toString());

		 DataSet ds = null;
		 try{
			 ds = broker.executeQuery(sql);
		 }catch(Exception e){
		      e.printStackTrace();
		      logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		return ds;
	}
	public ListDTO getBigPageList(CodeDTO codeDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		StringBuffer sb = new StringBuffer();
		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			sql.setAlias(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setSelect(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setFrom(" T_CODE ");
			sb.append(" BIG_CD = '*' ");

			if(!codeDto.getSearchGb().equals("") && !codeDto.getSearchtxt().equals("")) {
				sb.append(" AND "+codeDto.getSearchGb()+" LIKE ? ");
				sql.setString("%"+codeDto.getSearchtxt()+"%");
			}

			sql.setWhere(sb.toString());
			sql.setOrderby(" SML_CD asc");

			//---- 디버그 출력
			logger.debug("[getCodePageList]" + sql.toString());

			//---- 쿼리실행 및 반환값 설정
			retVal = broker.executeListQuery(sql, curpage, listScale, pageScale);
			return retVal;
		}catch(SQLException e){
			logger.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			logger.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}
	}
	public ListDTO getSmlPageList(CodeDTO codeDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		StringBuffer sb = new StringBuffer();
		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			sql.setAlias(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setSelect(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setFrom(" T_CODE ");
			sb.append(" BIG_CD <> '*' ");

			sb.append(" AND SML_CD = ? ");
			sql.setString(codeDto.getSmlCd());

			sql.setWhere(sb.toString());
			sql.setOrderby(" BIG_CD asc");

			//---- 디버그 출력
			logger.debug("[getSmlPageList]" + sql.toString());

			//---- 쿼리실행 및 반환값 설정
			retVal = broker.executeListQuery(sql, curpage, listScale, pageScale);
			return retVal;
		}catch(SQLException e){
			logger.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			logger.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}
	}
	public ListDTO getCodePageList(CodeDTO codeDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		StringBuffer sb = new StringBuffer();
		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			sql.setAlias(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setSelect(" BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sql.setFrom(" T_CODE ");
			sb.append(" SML_CD = ? ");
			sql.setString(codeDto.getSmlCd());

			if(!codeDto.getSearchGb().equals("") && !codeDto.getSearchtxt().equals("")) {
				sb.append(" AND "+codeDto.getSearchGb()+" LIKE ? ");
				sql.setString("%"+codeDto.getSearchtxt()+"%");
			}

			sql.setWhere(sb.toString());
			sql.setOrderby(" BIG_CD asc");

			//---- 디버그 출력
			logger.debug("[getCodePageList]" + sql.toString());

			//---- 쿼리실행 및 반환값 설정
			retVal = broker.executeListQuery(sql, curpage, listScale, pageScale);
			return retVal;
		}catch(SQLException e){
			logger.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			logger.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}
	}

	public int addCode(CodeDTO codeDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" INSERT INTO T_CODE(BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN, REG_ID, REG_DT) ");
		 sb.append(" VALUES(?,?,?,?,?,?,Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')) ");
		 sql.setSql(sb.toString());

		 sql.setString(codeDto.getBigCd());
		 sql.setString(codeDto.getSmlCd());
		 sql.setString(codeDto.getCdNm());
		 sql.setString(codeDto.getCdDesc());
		 sql.setString(codeDto.getUseYn());
		 sql.setString(codeDto.getRegId());

		 logger.debug("[addCode]" + sql.toString());
		 try{
		     retVal = broker.executeUpdate(sql);
		 }catch(Exception e){
			 logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return retVal;
	}

	public CodeDTO getCodeInfo(String bigcd, String smlcd) throws DAOException{
		 int totCount = 0;
		 CodeDTO codeDto = new CodeDTO();
		 StringBuffer sb = new StringBuffer();

		 sb.append(" SELECT BIG_CD, SML_CD, CD_NM, CD_DESC,USE_YN ");
		 sb.append(" FROM T_CODE ");
		 sb.append(" WHERE BIG_CD = ? AND SML_CD = ? ");

		 QueryStatement sql = new QueryStatement();
		 sql.setSql(sb.toString());
		 sql.setString(bigcd);
		 sql.setString(smlcd);

		 logger.debug("[getCodeInfo]" + sql.toString());

		 DataSet ds = null;
		 try{
			 ds = broker.executeQuery(sql);

			 if(ds.next()){
			 	codeDto.setBigCd(ds.getString("BIG_CD"));
			 	codeDto.setSmlCd(ds.getString("SML_CD"));
			 	codeDto.setCdNm(ds.getString("CD_NM"));
			 	codeDto.setCdDesc(ds.getString("CD_DESC"));
			 	codeDto.setUseYn(ds.getString("USE_YN"));
			 }
		 }catch(Exception e){
		      e.printStackTrace();
		      logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			if(ds!=null) { ds.close(); ds = null; }
		 }

		return codeDto;
	}

	 public int existCode(String bigcd, String smlcd)  throws DAOException  {
	     int totCount = 0;
	     StringBuffer sb = new StringBuffer();
	     sb.append(" SELECT count(*) CNT ");
	     sb.append(" FROM T_CODE ");
	     sb.append(" WHERE BIG_CD = ? AND SML_CD = ? ");
	     QueryStatement sql = new QueryStatement();
	     sql.setSql(sb.toString());
	     sql.setString(bigcd);
	     sql.setString(smlcd);
	     logger.debug("[getCodeInfo]" + sql.toString());
	     DataSet ds = null;
	     try
	     {
	         ds = broker.executeQuery(sql);
	         if(ds.next())
	             totCount = ds.getInt("CNT");
	     }
	     catch(Exception e)
	     {
	         e.printStackTrace();
	         logger.error(e.getMessage());
	         throw new DAOException(e.getMessage());
	     }
	     try
	     {
	     }
	     finally
	     {
	         if(ds != null)
	         {
	             ds.close();
	             ds = null;
	         }
	     }
	     return totCount;
	 }

	public int modifyCode(CodeDTO codeDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" UPDATE T_CODE SET  ");
		 sb.append(" BIG_CD = ?, ");
		 sb.append(" CD_NM = ?, CD_DESC = ?, ");
		 sb.append(" USE_YN = ?, MOD_ID = ?, ");
		 sb.append(" MOD_DT = Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ");
		 sb.append(" WHERE BIG_CD = ? AND SML_CD = ? ");

		 sql.setSql(sb.toString());

		 sql.setString(codeDto.getBigCd());
		 sql.setString(codeDto.getCdNm());
		 sql.setString(codeDto.getCdDesc());
		 sql.setString(codeDto.getUseYn());
		 sql.setString(codeDto.getModId());
		 sql.setString(codeDto.getBigCd());
		 sql.setString(codeDto.getSmlCd());

		 logger.debug("[modifyCode]" + sql.toString());
		 try{
		     retVal = broker.executeUpdate(sql);
		 }catch(Exception e){
			 logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return retVal;
	}

	public boolean delCode(String gubun, String bigcd, String smlcd) throws DAOException{
		 boolean retVal = false;
		 ISqlStatement[] sqlArray;
		 QueryStatement sql = null;
		 StringBuffer sb = null;

		 if(smlcd.equals("*")) {
		 	sqlArray = new ISqlStatement[2];

			sql = new QueryStatement();
			sb = new StringBuffer();
			sb.append(" DELETE T_CODE  ");
			sb.append(" WHERE SML_CD = ? ");

			sql.setSql(sb.toString());
			sql.setString(bigcd);

			sqlArray[0] = sql;

			sql = new QueryStatement();
			sb = new StringBuffer();
			sb.append(" DELETE  T_CODE  ");
			sb.append(" WHERE BIG_CD = ? AND SML_CD = '*' ");
			sql.setSql(sb.toString());
			sql.setString(bigcd);

			sqlArray[1] = sql;
		 }else{
		 	sqlArray = new ISqlStatement[1];
			sql = new QueryStatement();
			sb = new StringBuffer();
			sb.append(" DELETE FROM T_CODE  ");
			sb.append(" WHERE BIG_CD = ? AND SML_CD = ? ");

			sql.setSql(sb.toString());
			sql.setString(bigcd);
			sql.setString(smlcd);

			sqlArray[0] = sql;
		 }

		 logger.debug("[delCode]" + sql.toString());
		 try{
		     retVal = broker.executeUpdate(sqlArray);
		 }catch(Exception e){
			 logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return retVal;
	}


	public CodeDTO[] getCodeSet(String smlcode) throws DAOException{
	     return  getCodeSet(smlcode, "", "");
	}

	public CodeDTO[] getCodeSet(String smlcode,String useyn) throws DAOException{
		return  getCodeSet(smlcode, useyn, "");
	}
	public ArrayList getCodeUseList(String smlcode,String useyn) throws Exception{
		ArrayList alRtn = null;
		BaseDAO dao = null;
		QueryStatement qs = null;
		StringBuffer sbSql = null;
		try {
			dao = new BaseDAO(this.getClass());
			qs = new QueryStatement();
			sbSql = new StringBuffer();

			sbSql.append(" SELECT BIG_CD, SML_CD, CD_NM, CD_DESC, USE_YN ");
			sbSql.append(" FROM T_CODE ");
			sbSql.append(" WHERE SML_CD = ? and use_yn = 'Y' order by big_cd ");
			qs.setSql(sbSql.toString());
			qs.setString(smlcode);

			alRtn = dao.executeQueryList(qs);

		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		} finally {
			dao.endTransaction();
		}
		return alRtn;
	}


	public CodeDTO[] getCodeSet(String smlcode,String useyn,String where) throws DAOException{
		int totCount = 0;

		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT BIG_CD, SML_CD, CD_NM, CD_DESC,USE_YN ");
		sb.append(" FROM T_CODE ");
		sb.append(" WHERE SML_CD = ? ");
		sql.setString(smlcode);

		if(!useyn.equals("")) {
			sb.append(" AND USE_YN = ? ");
			sql.setString(useyn);
		}
		if(where != null && !where.equals("")) {
			sb.append(" AND "+where+" ");
		}

		sb.append(" ORDER BY BIG_CD ");
		sql.setSql(sb.toString());

		logger.debug("[getCodeSet]" + sql.toString());

		DataSet ds = null;
		CodeDTO[] codeSet = null;
		CodeDTO code = null;
		Vector vc = new Vector();
		try{
			ds = broker.executeQuery(sql);
			while(ds.next()){
				code = new CodeDTO();
				code.setBigCd(ds.getString("BIG_CD"));
				code.setSmlCd(ds.getString("SML_CD"));
				code.setCdNm(ds.getString("CD_NM"));
				code.setCdDesc(ds.getString("CD_DESC"));
				code.setUseYn(ds.getString("USE_YN"));
				code.setRegId(ds.getString("REG_ID"));
				vc.add(code);
			}
			codeSet = new CodeDTO[vc.size()];
			for(int i=0; i<vc.size();i++)
				codeSet[i] = (CodeDTO)vc.get(i);

		}catch(Exception e){
		    e.printStackTrace();
		    logger.error(e.getMessage());
		 	throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}

		return codeSet;
	}

	public CodeDTO[] getCodeSet2(String smlcode,String useyn,String where) throws DAOException{
		int totCount = 0;

		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT BIG_CD, SML_CD, CD_NM, CD_DESC,USE_YN ");
		sb.append(" FROM T_CODE ");
		sb.append(" WHERE SML_CD = ? ");
		sql.setString(smlcode);

		if(!useyn.equals("")) {
			sb.append(" AND USE_YN = ? ");
			sql.setString(useyn);
		}
		if(where != null && !where.equals("")) {
			sb.append(" AND "+where+" ");
		}

		sb.append(" ORDER BY cd_nm ");
		sql.setSql(sb.toString());

		logger.debug("[getCodeSet]" + sql.toString());

		DataSet ds = null;
		CodeDTO[] codeSet = null;
		CodeDTO code = null;
		Vector vc = new Vector();
		try{
			ds = broker.executeQuery(sql);
			while(ds.next()){
				code = new CodeDTO();
				code.setBigCd(ds.getString("BIG_CD"));
				code.setSmlCd(ds.getString("SML_CD"));
				code.setCdNm(ds.getString("CD_NM"));
				code.setCdDesc(ds.getString("CD_DESC"));
				code.setUseYn(ds.getString("USE_YN"));
				code.setRegId(ds.getString("REG_ID"));
				vc.add(code);
			}
			codeSet = new CodeDTO[vc.size()];
			for(int i=0; i<vc.size();i++)
				codeSet[i] = (CodeDTO)vc.get(i);

		}catch(Exception e){
		    e.printStackTrace();
		    logger.error(e.getMessage());
		 	throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}

		return codeSet;
	}
}
