package com.web.common;

import java.sql.SQLException;
import java.util.ArrayList;

import jef.application.entity.PageVO;

import com.web.framework.data.DataSet;
import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.QueryStatement;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.StringUtil;

import com.web.common.user.UserDTO;

/**
 * @author 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CommonDAO extends AbstractDAO {

	public Log log = LogFactory.getLog(getClass());
	/**
	 * 
	 */
	public CommonDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * �ڵ� ����Ʈ�� �����´�.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeList(String codegroupid) throws DAOException{
	     
		ArrayList codeList = null;
		 DataSet ds = null;
		 
	     String procedure = "{ CALL hp10_cmCodeList ( ? , ? , ?) }";
		 
		 QueryStatement sql = new QueryStatement();
			
			sql.setKey("getCodeList"); //log key
			sql.setSql(procedure); //���ν��� ��
			sql.setString("");  //���� ���̵�
			sql.setString(codegroupid); //�ڵ�׷�
			sql.setString(""); //�ڵ� ���̵�
			
		 try{
			 ds = broker.executeProcedure(sql);
 
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(ds.next()){
				code = new ComCodeDTO();
				code.setCode(ds.getString("CodeID"));
				code.setName(ds.getString("CodeName"));
				codeList.add(code);
			 }
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return codeList;   
	}
	
	/**
	 * �ڵ� ����Ʈ(�⳪�ټ�)�� �����´�.(�ѽ�������ȣ �������� ��)
	 * Author : shbyeon.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListHanSeq(String codegroupid) throws DAOException{
		
		 ArrayList codeList = null;
		 DataSet ds = null;
		 
	     String procedure = "{ CALL hp_mgAddressAreaFaxNoSelect () }";
		 
		 QueryStatement sql = new QueryStatement();
			
			//sql.setKey("getCodeList"); //log key
			sql.setSql(procedure); //���ν��� ��
			//sql.setString("");  //���� ���̵�
			//sql.setString(codegroupid); //�ڵ�׷�
			//sql.setString(""); //�ڵ� ���̵�
			
		 try{
			 ds = broker.executeProcedure(sql);

			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(ds.next()){
				code = new ComCodeDTO();
				code.setCode(ds.getString("CodeID")); //�ڵ��(������)input box �� ������ ���� ��.
				code.setName(ds.getString("CodeName"));   //�ڵ�ID(������ȣ)select box �� ������ ��.
				codeList.add(code);
			 }
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return codeList;   
	}
	/*
	 * �ڵ� ����Ʈ(�⳪�ټ�)�� �����´�.
	 * Author : shbyeon.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListCompany() throws DAOException{
		
		 ArrayList codeList = null;
		 DataSet ds = null;
		 
	     String procedure = "{ CALL ap_mgCompanyInquiry ( ? ,? ,? ,? ,? ,?) }";
		 
		 QueryStatement sql = new QueryStatement();
			
		sql.setSql(procedure); //���ν��� ��
		sql.setString("");  
		sql.setString("");  
		sql.setString("");  
		sql.setInteger(20);  
		sql.setInteger(1);  
		sql.setString("LIST");  
		
		 try{
			 ds = broker.executeProcedure(sql);

			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(ds.next()){
				code = new ComCodeDTO();
				code.setCode(ds.getString("CompanyCode")); //input box �� ������ ���� ��.
				code.setName(ds.getString("CompanyName"));   //select box �� ������ ��.
				codeList.add(code);
			 }
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return codeList;   
	}
	/*
	 * �ڵ� ����Ʈ(�⳪�ټ�)�� �����´�.
	 * Author : shbyeon.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListGroup() throws DAOException{
		
		 ArrayList codeList = null;
		 DataSet ds = null;
		 
	     String procedure = "{ CALL hp_mgGroupInquiry ( ? ,? ,? ,? ,? ) }";
		 
		 QueryStatement sql = new QueryStatement();
			
		sql.setSql(procedure); //���ν��� ��
		sql.setString("");  
		sql.setString("G00000");  
		sql.setString("STEPLIST");  
		sql.setInteger(1); 
		sql.setString("");  
		
		 try{
			 ds = broker.executeProcedure(sql);

			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(ds.next()){
				code = new ComCodeDTO();
				code.setCode(ds.getString("GroupID")); //input box �� ������ ���� ��.
				code.setName(ds.getString("GroupName"));   //select box �� ������ ��.
				codeList.add(code);
			 }
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		return codeList;   
	}
	/**
	 * ����ڰ��� ����
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userModify(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_cmUserPWDModify ( ? , ? , ?  ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getUserID()); //���� ���̵�
		sql.setString(userDto.getUserID()); //����� ���̵�
		sql.setString(userDto.getPassword()); //�н�����
		
		try{

			retVal=broker.executeProcedureUpdate(sql);
			
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally
		{
			return retVal;
		}	
	}
	
	
	/**
	 * �α��� �̷� ���/����
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public LogInDTO setLoginHistory(LogInDTO loginDto) throws DAOException {
		
		String gubun=loginDto.getGubun();
		int Seq=loginDto.getSeq();
		String UserID=loginDto.getUserID();
		String LoginPathCode=loginDto.getLoginPathCode();
		String LoginType=loginDto.getLoginType();
		String ClientIP=loginDto.getClientIP();
		String ClientOS=loginDto.getClientOS();
		String ClientBrowserVersion=loginDto.getClientBrowserVersion();
		String Discription=loginDto.getDiscription();
		String SessionID = loginDto.getSessionID();

		String procedure = "{ CALL hp_cmLogging ( ? , ? , ? , ? , ? , ? , ? , ?  ) }";
		
		int retVal = 0;	
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("setLoginHistory"); //log key
		sql.setSql(procedure); //���ν��� ��
		sql.setString(UserID); //UserID
		sql.setString(LoginPathCode); //LoginPathCode
		sql.setString(LoginType); //LoginType
		sql.setString(ClientIP); //ClientIP
		sql.setString(ClientOS); //ClientOS
		sql.setString(ClientBrowserVersion); //ClientBrowserVersion
		sql.setString(Discription); //Discription
		sql.setString(SessionID);
		
		 try{

			 retVal = broker.executeProcedureUpdate(sql);
 
			 loginDto.setResult(retVal);

		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}

		return loginDto;	
    }
	
	/**
	 * �α׾ƿ� �̷� ���
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public int setLogoutHistory(LogInDTO loginDto) throws DAOException {
		int retVal = -1;
		
		String userid = loginDto.getUserID();
		String sessionid = loginDto.getSessionID();
		
		String procedure = "{ CALL hp_cmLogout ( ?, ? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("setLogoutHistory"); //log key
		sql.setSql(procedure); //���ν��� ��
		sql.setString(sessionid); //LoginPathCode
		sql.setString(userid);

		 try{

			 retVal = broker.executeProcedureUpdate(sql);

		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
		
		return retVal;
	}
	/**
	 * Group ���� ���� ����Ʈ 
	 * @param userDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO groupAuthList(String logid,String groupid) throws DAOException{
			
			String procedure = " { CALL hp10_cmGroupChildList ( ? , ? ) } ";
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setKey(logid); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
			sql.setString(""); //���� ���̵�
			sql.setString(groupid); //�׷� ���̵�
			
			try{
				retVal=broker.executeListProcedure(sql);
			}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
			}			
			return retVal;
		}
	
	/**
	 * ������Ż-���� �� Ȯ�� ���� 
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public StateDTO inboundState(StateDTO stateDto) throws DAOException {

		String procedure = "{ CALL hp_cmUserFaxCount ( ? ) }";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("inboundState"); //log key
		sql.setSql(procedure); //���ν��� ��
		sql.setString(stateDto.getUserID()); //UserID
		
		 try{

			 ds = broker.executeProcedure(sql);
			 if(ds.next()){
				stateDto = new StateDTO();
				stateDto.setInbundCnt(ds.getInt("InboundCount"));            //���ŰǼ�
				stateDto.setNonImageOpenCnt(ds.getInt("NonImageOpenCnt"));;  //���Ź�Ȯ�ΰǼ�
				
			 }

		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}

		return stateDto;	
    }
}
