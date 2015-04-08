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
	 * 계정 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO userPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,?, ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getvSearchType()); //검색구분
		sql.setString(userDto.getvSearch()); //검색어
		sql.setInteger(userDto.getnRow()); //리스트 갯수
		sql.setInteger(userDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분
		sql.setString(userDto.getUseYN()); //사용여부
		sql.setString(userDto.getvGroupID());
		sql.setString(userDto.getvInitYN());//초기옵션
		sql.setInteger(userDto.getSearchTab());//검색 탭
		

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
	 * 계정 리스트.   
	 * @param userDto   조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO groupPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp10_mgGroupFaxNumberInquiry ( ? , ? , ? , ? , ? , ? , ?, ?, ?) } ";

		QueryStatement sql = new QueryStatement();
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getvSearchType()); //검색구분
		sql.setString(userDto.getvSearch()); //검색어
		sql.setInteger(userDto.getnRow()); //리스트 갯수
		sql.setInteger(userDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분
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
	 * 사용자계정 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
public int userRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserRegist ( ?, ? , ? , ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getUserID()); //사용자 아이디
		sql.setString(userDto.getUserName()); //사용자 명
		sql.setString(userDto.getGroupID()); //그룹아이디
		sql.setString(userDto.getPassword()); //패스워드
		sql.setString(userDto.getOfficePhone()); //사무실 전화번호
		sql.setString(userDto.getUseYN()); //사용여부
		
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
	 * 사용자계정 Back
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userBackRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserRegist (  ? , ? , ? , ? , ? , ?, ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getUserID()); //사용자 아이디
		sql.setString(userDto.getUserName()); //사용자 명
		sql.setString(userDto.getGroupID()); //그룹아이디
		sql.setString(userDto.getAuthID()); //권한아이디
		sql.setString(userDto.getPassword()); //패스워드
		sql.setString(userDto.getOfficePhone()); //사무실 전화번호
		//sql.setString(userDto.getMobliePhone()); //모바일 전화번호
		//sql.setString(userDto.getEmail()); //이메일
		//sql.setString(userDto.getIP()); //IP
		//sql.setString(userDto.getHostName()); //HOSTNAME
		sql.setString(userDto.getUseYN()); //사용여부
		sql.setString(userDto.getAlarmYN()); //알람여부
		sql.setString(userDto.getDID()); //팩스번호
		
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
	 * 계정 정보
	 * @param userid
	 * @return userDto 사용자 정보
	 * @throws DAOException
	 */
	public UserDTO userView(UserDTO userDto) throws DAOException{

		String procedure = "{ CALL hp_mgUserSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(userDto.getChUserID()); // 세션 아이디
		sql.setString("SELECT"); // sp구분
		sql.setString(userDto.getUserID()); //사용자 아이디

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
	 * 사용자계정 수정
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
public int userModify(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgUserModify (?, ?, ?, ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getUserID()); //사용자 아이디
		sql.setString(userDto.getUserName()); //사용자 명
		sql.setString(userDto.getGroupID()); //그룹아이디
		sql.setString(userDto.getPassword()); //패스워드
		sql.setString(userDto.getOfficePhone()); //사무실 전화번호
		sql.setString(userDto.getUseYN()); //사용여부
		
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
	 * 계정 정보를 삭제한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
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
				
				batch.add(USERID);							//세션 아이디
				batch.add(StringUtil.nvl(r_data[0],"")); 	//사용자 아이디
				
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
	 * 사용자 EXCEL 리스트 
	 * @param userDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO userExcelList(UserDTO userDto) throws DAOException{
			
    	    String procedure = " { CALL hp_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,? ) } ";

			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();

			sql.setKey(userDto.getLogid()); //로그아이디
			sql.setSql(procedure); //프로시져 명
			sql.setString(userDto.getChUserID()); //세션 아이디
			sql.setString(userDto.getvSearchType()); //검색구분
			sql.setString(userDto.getvSearch()); //검색어
			sql.setInteger(userDto.getnRow()); //리스트 갯수
			sql.setInteger(userDto.getnPage()); //현제 페이지
			sql.setString("LIST"); //sp 구분
			sql.setString(userDto.getUseYN()); //사용여부
			sql.setString(userDto.getvGroupID());
			sql.setString(userDto.getvInitYN());//초기옵션

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
	 * 사용자 Count 정보를 가져온다
	 * @param userDto 사용자 정보
	 * @return userDto
	 * @throws DAOException
	 */

	public UserDTO userTotCount(UserDTO userDto) throws DAOException {
		
		String procedure = " { CALL hp_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//로그아이디
		sql.setString(userDto.getChUserID());		//세션아이디
		sql.setString("COUNT");			//SP구분
		sql.setString("");		//사용자 아이디

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
	* 사용자 중복 체크
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String userDupCheck(UserDTO userDto, String jobGb) throws DAOException{

		String procedure = " { CALL hp_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//로그아이디
		sql.setString(userDto.getChUserID());		//세션아이디
		sql.setString(jobGb);			//SP구분
		sql.setString(userDto.getUserID());		//사용자 아이디

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
	 * 패스워드를 인코딩한다.
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
	 * 패스워드를 디코딩한다.
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

		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(userDto.getGroupID()); //사용자 아이디
		sql.setString(userDto.getSearchGb()); //검색구분
		sql.setString(userDto.getSearchTxt()); //검색어
		sql.setInteger(userDto.getnRow()); //리스트 갯수
		sql.setInteger(userDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분

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
	 * 사용자 EXCEL import
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
			//log파일 생성
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));

			for(int i=0;i<users.size();i++){
				
				UserDTO userDto = users.get(i);

				log_userid		= userDto.getUserID();
				log_username	= userDto.getUserName();
				log_groupid		= userDto.getGroupID();
				password=userDto.getPassword().trim();
				
				log_userchk=userDupCheck(userDto, "DUPLICATE");//userid 중복체크
				
				if("1".equals(log_userchk)){
					
					log_result="등록실패-중복된 사용자 ID입니다.";
					failcnt++;
				}else if("2".equals(log_userchk)){	
					log_result="등록실패-삭제되었던 사용자 ID입니다.";
					failcnt++;
				}else{
					
					
					userDto.setUserID(log_groupid);		
					
					log_groupidchk=userDupCheck(userDto,"G_CHECK");//group체크
					
					if(!"1".equals(log_groupidchk)){
						
						log_result="등록실패-등록되지 않은 소속코드입니다.";
						failcnt++;
					
					}else{
						
						userDto.setUserID(log_userid);
						userDto.setPassword(setPasswdEncode(password));
									
						//등록 sp호출부분
						retVal = userRegist(userDto);

						if(retVal == -1){
							log_result = "등록 오류 - SQL Error!!";
							failcnt++;
						}else if(retVal ==0){
							log_result = "등록 실패 - 등록 안됨";
							failcnt++;
						}else{
							log_result = "등록 성공  - ID : "+userDto.getUserID();
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

			
			importResult="총 : "+users.size()+"건 중 성공건수 : "+successcnt+"건 실패건수 : "+failcnt+"건 \\n결과로그는 WAS경로["+LOG_PATH+"] 의 "+filename+".log 파일에서 확인가능합니다.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
			importResult="업로드를 실패했습니다.\\n업로드 양식에 맞는 데이타인지 확인하세요!![SQL Error]";
		}finally{
			
			
			
			try{ if(out != null) out.close(); } catch(Exception e){}
			
		}
		
		return importResult;
		
	}
	/**
	 * 사용자 EXCEL import (Backup DB)
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
			//log파일 생성
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));

			for(int i=0;i<users.size();i++){
				
				UserDTO userDto = users.get(i);

				log_userid		= userDto.getUserID();
				log_username	= userDto.getUserName();
				log_did		 	= userDto.getDID();
				log_groupid		= userDto.getGroupID();
				log_authid		= userDto.getAuthID();
				password=userDto.getPassword().trim();
				
				log_userchk=userDupCheck(userDto, "DUPLICATE");//userid 중복체크
				
				if("1".equals(log_userchk)){
					
					log_result="등록실패-사용자 ID가 중복입니다.";
					failcnt++;
				}else if("2".equals(log_userchk)){	
					log_result="등록실패-삭제되었던 사용자 ID입니다.";
					failcnt++;
				}else{
				
					userDto.setUserID(log_did);		
					//userDto.setDID(log_did);
					
					log_didchk = userDupCheck(userDto,"DID_CHECK");
					
					if("1".equals(log_didchk)){
						
						log_result="등록실패-등록되지 않은 FAX 번호입니다.";
						failcnt++;
						
					}else{
						
						userDto.setUserID(log_groupid);		
						
						log_groupidchk=userDupCheck(userDto,"GROUP_CHECK");//phoneip 중복체크
						
						if(!"1".equals(log_groupidchk)){
							
							log_result="등록실패-등록되지 않은 소속코드입니다.";
							failcnt++;
						
						}else{
							userDto.setUserID(log_authid);		
							
							log_authidchk=userDupCheck(userDto,"GROUP_CHECK");//phoneip 중복체크
							
							if(!"1".equals(log_authidchk)){
								
								log_result="등록실패-등록되지 않은 조회권한 코드입니다.";
								failcnt++;
								
							}else{
								
								userDto.setUserID(log_userid);
								userDto.setPassword(setPasswdEncode(password));
								
								
								//등록 sp호출부분
								retVal = userBackRegist(userDto);
								//serverID=userDto.getServerID();
								hostName=StringUtil.nvl(userDto.getHostName(),"");
								
								
								if(retVal == -1){
									log_result = "등록 오류 - SQL Error!!";
									failcnt++;
								}else if(retVal ==0){
									log_result = "등록 실패 - 등록 안됨";
									failcnt++;
								}else{
									log_result = "등록 성공  - ID : "+userDto.getUserID();
									successcnt++;
								}
								/*if("".equals(hostName)){
									log_result="등록실패-SQL Error!!";
									failcnt++;
								}else if("N".equals(hostName)){
									log_result="등록실패-녹취서버에 사용자 할당이 불가능합니다.(등록 사용자수 초과)";
									failcnt++;
								}else{
									log_result="서버ID : ("+serverID+") HostName : ("+hostName+") 등록성공";
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

			
			importResult="총 : "+users.size()+"건 중 성공건수 : "+successcnt+"건 실패건수 : "+failcnt+"건 \\n결과로그는 WAS경로["+LOG_PATH+"] 의 "+filename+".log 파일에서 확인가능합니다.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
		
		}finally{
			
			importResult="업로드를 실패했습니다.\\n업로드 양식에 맞는 데이타인지 확인하세요!![SQL Error]";
			
			try{ if(out != null) out.close(); } catch(Exception e){}
			
		}
		
		return importResult;
		
	}
	
	
	public ListDTO userFaxNumInfo(UserDTO userDto) throws DAOException {
		String procedure = " { CALL hp_mgUserFaxNumInfo ( ? ) } ";

		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(userDto.getUserID()); //그룹 아이디
		//sql.setString(userDto.getSearchGb()); //검색구분
		//sql.setString(userDto.getSearchTxt()); //검색어
		//sql.setInteger(userDto.getnRow()); //리스트 갯수
		///sql.setInteger(userDto.getnPage()); //현제 페이지
		//sql.setString("PAGE"); //sp 구분

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
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getUserID()); //user 아이디
		sql.setString(userDto.getDID()); //팩스번호
		

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
