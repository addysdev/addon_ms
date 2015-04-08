package com.web.common.user;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import cis.internal.util.EncryptUtil;

import com.web.framework.configuration.Configuration;
import com.web.framework.configuration.ConfigurationFactory;
import com.web.framework.data.DataSet;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.QueryStatement;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.StringUtil;

import com.web.common.config.GroupDTO;
import com.web.common.util.Base64Util;
import com.web.common.user.UserDTO;

import cis.internal.util.EncryptUtil;

public class UserDAO extends AbstractDAO {

	/**
	 * ���� ����Ʈ.   
	 * @param userDto   ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO userPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,?, ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getvSearchType()); //�˻�����
		sql.setString(userDto.getvSearch()); //�˻���
		sql.setInteger(userDto.getnRow()); //����Ʈ ����
		sql.setInteger(userDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����
		sql.setString(userDto.getUseYN()); //��뿩��
		sql.setString(userDto.getvGroupID());
		sql.setString(userDto.getvInitYN());//�ʱ�ɼ�
		sql.setInteger(userDto.getSearchTab());//�˻� ��
		

		try{
			retVal=broker.executePageProcedure(sql,userDto.getnPage(),userDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * ���� ����Ʈ.   
	 * @param userDto   ���� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO groupPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp10_mgGroupFaxNumberInquiry ( ? , ? , ? , ? , ? , ? , ?, ?, ?) } ";

		QueryStatement sql = new QueryStatement();
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getvSearchType()); //�˻�����
		sql.setString(userDto.getvSearch()); //�˻���
		sql.setInteger(userDto.getnRow()); //����Ʈ ����
		sql.setInteger(userDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����
		sql.setString(userDto.getvInitYN());
		sql.setString("");
		sql.setString(userDto.getvGroupID());
		
		
		try{
			retVal=broker.executePageProcedure(sql,userDto.getnPage(),userDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * ����ڰ��� ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
public int userRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserRegist ( ?, ? , ? , ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getUserID()); //����� ���̵�
		sql.setString(userDto.getUserName()); //����� ��
		sql.setString(userDto.getGroupID()); //�׷���̵�
		sql.setString(userDto.getPassword()); //�н�����
		sql.setString(userDto.getOfficePhone()); //�繫�� ��ȭ��ȣ
		sql.setString(userDto.getUseYN()); //��뿩��
		
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
	 * ����ڰ��� Back
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userBackRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserRegist (  ? , ? , ? , ? , ? , ?, ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getUserID()); //����� ���̵�
		sql.setString(userDto.getUserName()); //����� ��
		sql.setString(userDto.getGroupID()); //�׷���̵�
		sql.setString(userDto.getAuthID()); //���Ѿ��̵�
		sql.setString(userDto.getPassword()); //�н�����
		sql.setString(userDto.getOfficePhone()); //�繫�� ��ȭ��ȣ
		//sql.setString(userDto.getMobliePhone()); //����� ��ȭ��ȣ
		//sql.setString(userDto.getEmail()); //�̸���
		//sql.setString(userDto.getIP()); //IP
		//sql.setString(userDto.getHostName()); //HOSTNAME
		sql.setString(userDto.getUseYN()); //��뿩��
		sql.setString(userDto.getAlarmYN()); //�˶�����
		sql.setString(userDto.getDID()); //�ѽ���ȣ
		
		try{

			retVal=broker.executeBackProcedureUpdate(sql);
			
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
	 * ���� ����
	 * @param userid
	 * @return userDto ����� ����
	 * @throws DAOException
	 */
	public UserDTO userView(UserDTO userDto) throws DAOException{

		String procedure = "{ CALL hp_mgUserSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure);  //���ν��� ��
		sql.setString(userDto.getChUserID()); // ���� ���̵�
		sql.setString("SELECT"); // sp����
		sql.setString(userDto.getUserID()); //����� ���̵�

		try{
			
			 ds = broker.executeProcedure(sql);
			
			 userDto = new UserDTO();
			 
			 while(ds.next()){ 
				
				userDto.setUserID(ds.getString("UserID"));
				 userDto.setUserName(ds.getString("UserName"));
			    userDto.setPassword(ds.getString("Password"));
				userDto.setGroupID(ds.getString("GroupID"));
				userDto.setGroupName(ds.getString("GroupName"));
				userDto.setAuthID(ds.getString("AuthID"));	
				userDto.setAuthName(ds.getString("AuthName"));
				userDto.setDID(ds.getString("DID"));
				userDto.setDIDFormat(ds.getString("DIDFormat"));
				userDto.setGroupFaxView(ds.getString("GroupFaxView"));
				userDto.setOfficePhone(ds.getString("OfficePhone"));
				userDto.setOfficePhoneFormat(ds.getString("OfficePhoneFormat"));
				userDto.setMobliePhone(ds.getString("MobliePhone"));
				userDto.setMobliePhoneFormat(ds.getString("MobliePhoneFormat"));
				userDto.setEmail(ds.getString("Email"));
				userDto.setIP(ds.getString("IP"));
 				userDto.setHostName(ds.getString("HostName"));
 				userDto.setExcelAuth(ds.getString("ExcelAuth"));
 				userDto.setAlarmYN(ds.getString("AlarmYN"));
 				userDto.setUseYN(ds.getString("UseYN"));
 				userDto.setEchoYN(ds.getString("CallBackYN"));
 				userDto.setViewFlag(ds.getString("ViewFlag"));
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
		
		return userDto;
	}
	
	/**
	 * ����ڰ��� ����
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
public int userModify(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserModify (?, ?, ?, ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getUserID()); //����� ���̵�
		sql.setString(userDto.getUserName()); //����� ��
		sql.setString(userDto.getGroupID()); //�׷���̵�
		sql.setString(userDto.getPassword()); //�н�����
		sql.setString(userDto.getOfficePhone()); //�繫�� ��ȭ��ȣ
		sql.setString(userDto.getUseYN()); //��뿩��
		
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
	 * ���� ������ �����Ѵ�.(�ٰ�ó��)
	 * @param logid �α׾��̵�
	 * @param users ID(check) �迭
	 * @return int
	 * @throws DAOException
	 */	
	public int userDeletes(String logid,String[] users, String USERID) throws DAOException{
		
		String procedure = " { CALL hp_mgUserDelete ( ? , ? ) } ";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; users != null && i<users.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(users[i], "|");
				if(r_data[1].equals("Y")){
				
				batch.add(USERID);							//���� ���̵�
				batch.add(StringUtil.nvl(r_data[0],"")); 	//����� ���̵�
				
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
		}finally{
			return retVal;
		}

    }
	/**
	 * ����� EXCEL ����Ʈ 
	 * @param userDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO userExcelList(UserDTO userDto) throws DAOException{
			
    	    String procedure = " { CALL hp_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,? ) } ";

			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();

			sql.setKey(userDto.getLogid()); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
			sql.setString(userDto.getChUserID()); //���� ���̵�
			sql.setString(userDto.getvSearchType()); //�˻�����
			sql.setString(userDto.getvSearch()); //�˻���
			sql.setInteger(userDto.getnRow()); //����Ʈ ����
			sql.setInteger(userDto.getnPage()); //���� ������
			sql.setString("LIST"); //sp ����
			sql.setString(userDto.getUseYN()); //��뿩��
			sql.setString(userDto.getvGroupID());
			sql.setString(userDto.getvInitYN());//�ʱ�ɼ�

			sql.setSql(procedure);
			
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
	 * ����� Count ������ �����´�
	 * @param userDto ����� ����
	 * @return userDto
	 * @throws DAOException
	 */

	public UserDTO userTotCount(UserDTO userDto) throws DAOException {
		
		String procedure = " { CALL hp_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//�α׾��̵�
		sql.setString(userDto.getChUserID());		//���Ǿ��̵�
		sql.setString("COUNT");			//SP����
		sql.setString("");		//����� ���̵�

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				userDto = new UserDTO();
				userDto.setTotCount(ds.getString("TotCount"));
				userDto.setUseYN_NCount(ds.getString("UseYN_NCount"));
				userDto.setUseYN_YCount(ds.getString("UseYN_YCount"));
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return userDto;
	}
	/**
	* ����� �ߺ� üũ
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String userDupCheck(UserDTO userDto, String jobGb) throws DAOException{

		String procedure = " { CALL hp_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//�α׾��̵�
		sql.setString(userDto.getChUserID());		//���Ǿ��̵�
		sql.setString(jobGb);			//SP����
		sql.setString(userDto.getUserID());		//����� ���̵�

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				result=ds.getString("Result");
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return result;			
	}
	/**
	 * �н����带 ���ڵ��Ѵ�.
	 * @param userid
	 * @return
	 * @throws DAOException
	 */
	public String setPasswdEncode(String passwd) throws DAOException{
		 
		 String result = "";		

		 try{
			// Base64Util b64=new Base64Util();
			// result=b64.encode(passwd.getBytes());
			 result=EncryptUtil.encrypt(passwd);
			 
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return result;   
	}
	/**
	 * �н����带 ���ڵ��Ѵ�.
	 * @param userid
	 * @return
	 * @throws DAOException
	 */
	public String setPasswdDecode(String passwd) throws DAOException{
		 
		byte[] result = null;		

		 try{
			 Base64Util b64=new Base64Util();
			 result=b64.decode(passwd);
			 
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return result.toString();   
	}

	public ListDTO userFaxNumList(UserDTO userDto) throws DAOException {
		
		String procedure = " { CALL hp_mgUserFaxNumberList ( ? , ? , ? , ? , ? , ? ) } ";

		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getGroupID()); //����� ���̵�
		sql.setString(userDto.getSearchGb()); //�˻�����
		sql.setString(userDto.getSearchTxt()); //�˻���
		sql.setInteger(userDto.getnRow()); //����Ʈ ����
		sql.setInteger(userDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����

		sql.setSql(procedure);
		
		try{
			retVal=broker.executePageProcedure(sql,userDto.getnPage(),userDto.getnRow());
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}
		return retVal;
	}
	
	
	protected static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	public static String LOG_PATH = config.getString("framework.importlog.path");
	/**
	 * ����� EXCEL import
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String userListImport(ArrayList<UserDTO> users,String filename){
		
		String importResult="";
		int successcnt=0;
		int failcnt=0;
		
		String log_userid="";
		String log_username="";
		String log_officephone="";
		String log_groupid="";
		String log_useryn="";
		String log_password="";
		
		String log_result="";
		
		String log_userchk="";
		String log_groupidchk="";
		
		String password="";
		

		BufferedWriter out = null;
		
		int retVal = -1;

		try {
			//log���� ����
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));

			for(int i=0;i<users.size();i++){
				
				UserDTO userDto = users.get(i);

				log_userid		= userDto.getUserID();
				log_username	= userDto.getUserName();
				log_groupid		= userDto.getGroupID();
				password=userDto.getPassword().trim();
				
				log_userchk=userDupCheck(userDto, "DUPLICATE");//userid �ߺ�üũ
				
				if("1".equals(log_userchk)){
					
					log_result="��Ͻ���-�ߺ��� ����� ID�Դϴ�.";
					failcnt++;
				}else if("2".equals(log_userchk)){	
					log_result="��Ͻ���-�����Ǿ��� ����� ID�Դϴ�.";
					failcnt++;
				}else{
					
					
					userDto.setUserID(log_groupid);		
					
					log_groupidchk=userDupCheck(userDto,"G_CHECK");//groupüũ
					
					if(!"1".equals(log_groupidchk)){
						
						log_result="��Ͻ���-��ϵ��� ���� �Ҽ��ڵ��Դϴ�.";
						failcnt++;
					
					}else{
						
						userDto.setUserID(log_userid);
						userDto.setPassword(setPasswdEncode(password));
									
						//��� spȣ��κ�
						retVal = userRegist(userDto);

						if(retVal == -1){
							log_result = "��� ���� - SQL Error!!";
							failcnt++;
						}else if(retVal ==0){
							log_result = "��� ���� - ��� �ȵ�";
							failcnt++;
						}else{
							log_result = "��� ����  - ID : "+userDto.getUserID();
							successcnt++;
						}
								
					}
				}

				if(i==0){
					out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[RESULT : "+log_result+"]");
				}else{
					out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[RESULT : "+log_result+"]");
				}
			}

			
			importResult="�� : "+users.size()+"�� �� �����Ǽ� : "+successcnt+"�� ���аǼ� : "+failcnt+"�� \\n����α״� WAS���["+LOG_PATH+"] �� "+filename+".log ���Ͽ��� Ȯ�ΰ����մϴ�.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
			importResult="���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!![SQL Error]";
		}finally{
			
			
			
			try{ if(out != null) out.close(); } catch(Exception e){}
			
		}
		
		return importResult;
		
	}
	/**
	 * ����� EXCEL import (Backup DB)
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String userListBackImport(ArrayList<UserDTO> users,String filename){
		
		String importResult="";
		int successcnt=0;
		int failcnt=0;
		
		String log_userid="";
		String log_username="";
		String log_officephone="";
		String log_groupid="";
		String log_did="";
		String log_authid="";
		String log_alarmyn="";
		String log_useryn="";
		String log_password="";
		
		String log_result="";
		
		String log_userchk="";
		String log_didchk="";
		String log_groupidchk="";
		String log_authidchk="";
		String log_extensionnochk="";
		
		String password="";
		
		String serverID="";
		String hostName="";

		BufferedWriter out = null;
		
		int retVal = -1;

		try {
			//log���� ����
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));

			for(int i=0;i<users.size();i++){
				
				UserDTO userDto = users.get(i);

				log_userid		= userDto.getUserID();
				log_username	= userDto.getUserName();
				log_did		 	= userDto.getDID();
				log_groupid		= userDto.getGroupID();
				log_authid		= userDto.getAuthID();
				password=userDto.getPassword().trim();
				
				log_userchk=userDupCheck(userDto, "DUPLICATE");//userid �ߺ�üũ
				
				if("1".equals(log_userchk)){
					
					log_result="��Ͻ���-����� ID�� �ߺ��Դϴ�.";
					failcnt++;
				}else if("2".equals(log_userchk)){	
					log_result="��Ͻ���-�����Ǿ��� ����� ID�Դϴ�.";
					failcnt++;
				}else{
				
					userDto.setUserID(log_did);		
					//userDto.setDID(log_did);
					
					log_didchk = userDupCheck(userDto,"DID_CHECK");
					
					if("1".equals(log_didchk)){
						
						log_result="��Ͻ���-��ϵ��� ���� FAX ��ȣ�Դϴ�.";
						failcnt++;
						
					}else{
						
						userDto.setUserID(log_groupid);		
						
						log_groupidchk=userDupCheck(userDto,"GROUP_CHECK");//phoneip �ߺ�üũ
						
						if(!"1".equals(log_groupidchk)){
							
							log_result="��Ͻ���-��ϵ��� ���� �Ҽ��ڵ��Դϴ�.";
							failcnt++;
						
						}else{
							userDto.setUserID(log_authid);		
							
							log_authidchk=userDupCheck(userDto,"GROUP_CHECK");//phoneip �ߺ�üũ
							
							if(!"1".equals(log_authidchk)){
								
								log_result="��Ͻ���-��ϵ��� ���� ��ȸ���� �ڵ��Դϴ�.";
								failcnt++;
								
							}else{
								
								userDto.setUserID(log_userid);
								userDto.setPassword(setPasswdEncode(password));
								
								
								//��� spȣ��κ�
								retVal = userBackRegist(userDto);
								//serverID=userDto.getServerID();
								hostName=StringUtil.nvl(userDto.getHostName(),"");
								
								
								if(retVal == -1){
									log_result = "��� ���� - SQL Error!!";
									failcnt++;
								}else if(retVal ==0){
									log_result = "��� ���� - ��� �ȵ�";
									failcnt++;
								}else{
									log_result = "��� ����  - ID : "+userDto.getUserID();
									successcnt++;
								}
								/*if("".equals(hostName)){
									log_result="��Ͻ���-SQL Error!!";
									failcnt++;
								}else if("N".equals(hostName)){
									log_result="��Ͻ���-���뼭���� ����� �Ҵ��� �Ұ����մϴ�.(��� ����ڼ� �ʰ�)";
									failcnt++;
								}else{
									log_result="����ID : ("+serverID+") HostName : ("+hostName+") ��ϼ���";
									successcnt++;
								}*/
							}
						}
										
					}
				}

				if(i==0){
					out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_did+"]"+"[RESULT : "+log_result+"]");
				}else{
					out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_did+"]"+"[RESULT : "+log_result+"]");
				}
			}

			
			importResult="�� : "+users.size()+"�� �� �����Ǽ� : "+successcnt+"�� ���аǼ� : "+failcnt+"�� \\n����α״� WAS���["+LOG_PATH+"] �� "+filename+".log ���Ͽ��� Ȯ�ΰ����մϴ�.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
		
		}finally{
			
			importResult="���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!![SQL Error]";
			
			try{ if(out != null) out.close(); } catch(Exception e){}
			
		}
		
		return importResult;
		
	}
	
	
	public ListDTO userFaxNumInfo(UserDTO userDto) throws DAOException {
		String procedure = " { CALL hp_mgUserFaxNumInfo ( ? ) } ";

		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getUserID()); //�׷� ���̵�
		//sql.setString(userDto.getSearchGb()); //�˻�����
		//sql.setString(userDto.getSearchTxt()); //�˻���
		//sql.setInteger(userDto.getnRow()); //����Ʈ ����
		///sql.setInteger(userDto.getnPage()); //���� ������
		//sql.setString("PAGE"); //sp ����

		sql.setSql(procedure);
		
		try{
			retVal=broker.executeListProcedure(sql);
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}
		return retVal;
	}
	
	
	public int userDeleteFaxNum(UserDTO userDto) {
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserDeleteFaxNum ( ? , ? , ? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getUserID()); //user ���̵�
		sql.setString(userDto.getDID()); //�ѽ���ȣ
		

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

	public int userRegistFaxNum(UserDTO userDto) {
		int retVal = -1;
		
		return retVal;	
	}

	public int changeDIDInfo(UserDTO userDto) {
		int retVal = -1;
		
		return retVal;
	}
	
}
