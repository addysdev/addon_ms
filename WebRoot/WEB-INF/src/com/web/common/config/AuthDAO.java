package com.web.common.config;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.web.framework.data.DataSet;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ISqlStatement;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.ListStatement;
import com.web.framework.persist.QueryStatement;
import com.web.framework.util.StringUtil;

import com.web.common.config.MenuDTO;
import com.web.common.config.AuthDTO;
import com.web.common.ComCodeDTO;

public class AuthDAO extends AbstractDAO {
	/**
	 * 메뉴별 화면 리스트(사용안함)
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList menuScreenTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp10_mgMenuScreenInquiry  () }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setScreenID(ds.getString("ScreenID"));
				 menuDto.setAuthType(ds.getString("AuthType"));
				 menuDto.setAuth(ds.getString("Auth"));
				 
				 arrlist.add(menuDto);
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		return arrlist;
	}
	/**
	 * 메뉴 리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList authMenuTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp_mgMenuTree  (?) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		sql.setString(authDto.getUserID());
		//sql.setString(authDto.getAuthID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setMenuStep(ds.getInt("MenuStep"));
				 menuDto.setMenuSort(ds.getInt("MenuSort"));
				 menuDto.setAuth(ds.getString("Auth"));

				 arrlist.add(menuDto);
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		return arrlist;
	}
	/**
	 * 사용자 권한 리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList userAuthMenuTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp_mgMenuTree  ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		sql.setString(authDto.getUserID());
		//sql.setString(authDto.getAuthID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setMenuStep(ds.getInt("MenuStep"));
				 menuDto.setMenuSort(ds.getInt("MenuSort"));
				 menuDto.setAuth(ds.getString("Auth"));
				 
				 arrlist.add(menuDto);
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		return arrlist;
	}
	/**
	 * 권한별 메뉴 리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList authMenuDetailTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp10_mgMenuAuthInquiry  ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		sql.setString(authDto.getAuthID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setMenuStep(ds.getInt("MenuStep"));
				 menuDto.setMenuSort(ds.getInt("MenuSort"));
				 menuDto.setAuth(ds.getString("AuthID"));

				 arrlist.add(menuDto);
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		return arrlist;
	}
	/**
	 * 메뉴 권한삭제
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public int authMenuDeletes(String logid ,String regid ,String[] authids ) throws DAOException{
		
		String procedure = "{ CALL hp10_mgMenuAuthDelete ( ? , ? ) }";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

			for(int i=0; authids != null && i<authids.length; i++){ 
				
				List batch=new Vector();
				
				r_data = StringUtil.getTokens(authids[i], "|");
				
				if(r_data[1].equals("Y")){
					
					userid=StringUtil.nvl(r_data[0],"");

					batch.add(regid);
					batch.add(userid);
					
					batchList.add(batch);
				}
				
			}

			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}

		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return retVal;	
    }
	/**
	 * 사용자 권한삭제
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public int authDeletes(String logid ,String regid ,String[] users ) throws DAOException{
		
		String procedure = "{ CALL hp_mgAuthDelete ( ? ) }";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

			for(int i=0; users != null && i<users.length; i++){ 
				
				List batch=new Vector();
				
				//r_data = StringUtil.getTokens(users[i], "|");
				
				//if(r_data[1].equals("Y")){
					
					//userid=StringUtil.nvl(r_data[0],"");

					//batch.add(regid);
					batch.add(users[i]);
					
					batchList.add(batch);
				//}
				
			}

			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}

		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return retVal;	
    }
	/**
	 * 메뉴 권한등록
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public int authMenuRegists(String logid ,String regid ,String[] authids ,String[] menus ) throws DAOException{
		
		String procedure = "{ CALL hp10_mgMenuAuthRegist ( ? , ? , ? ) }";
		
		String[] r_users=null;
		String[] r_menus=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

			for(int i=0; authids != null && i<authids.length; i++){ 
				
				r_users = StringUtil.getTokens(authids[i], "|");

				if(r_users[1].equals("Y") && !r_users[0].equals(" ")){
					
					userid=StringUtil.nvl(r_users[0],"");
					
					for(int j=0; menus != null && j<menus.length; j++){

						r_menus = StringUtil.getTokens(menus[j], "|");

						if(r_menus[1].equals("Y") ){
							
							List batch=new Vector();
							
							batch.add(regid.trim());
							batch.add(userid.trim());
							batch.add(r_menus[0].trim());

							batchList.add(batch);
						}
					
					}

				}
				
			}

			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}

		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return retVal;	
    }
	/**
	 * 사용자 권한등록
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public int authRegists(String logid ,String regid ,String[] users ,String[] menus ) throws DAOException{
		
		String procedure = "{ CALL hp_mgAuthRegist ( ? , ? ) }";
		
		String[] r_users=null;
		String[] r_menus=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

				for(int i=0; users != null && i<users.length; i++){
				
				//r_users = StringUtil.getTokens(users[i], "|");

				//if(r_users[1].equals("Y") && !r_users[0].equals(" ")){
					
					//userid=StringUtil.nvl(r_users[0],"");
					
					for(int j=0; menus != null && j<menus.length; j++){

						//r_menus = StringUtil.getTokens(menus[j], "|");
						
						//if(r_menus[1].equals("Y")){
							
							List batch=new Vector();
							
							batch.add(users[i].trim());
							batch.add(menus[j].trim());

							batchList.add(batch);
						}
					
					}

			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}

		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return retVal;	
    }
	/**
	 * 권한에 따른 그룹 리스트를 가져온다.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getGroupList(String authid) throws DAOException{
	    
		 ArrayList codeList = null;
		 DataSet ds = null;
		 
		 String procedure = "{ CALL hp10_mgGroupInquiryList ( ? , ? , ? , ? , ? , ? , ? , ? ) }";
		 
		 QueryStatement sql = new QueryStatement();
			
			sql.setKey("getGroupList"); //log key
			sql.setSql(procedure); //프로시져 명
			sql.setString("");  
			sql.setString("");
			sql.setString("");  
			sql.setInteger(15);  
			sql.setInteger(1);  
			sql.setString("");  
			sql.setString("");  
			sql.setString(authid);  
	
		 try{
			 ds = broker.executeProcedure(sql);

			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(ds.next()){
				code = new ComCodeDTO();
				code.setCode(ds.getString("GroupID"));
				code.setName(ds.getString("GroupName"));
				codeList.add(code);
			 }
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return codeList;   
 
	}
}
