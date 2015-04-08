package com.web.common.address;

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

import com.web.common.util.Base64Util;
import com.web.common.user.UserDTO;
import com.web.common.address.AddressDTO;

import cis.internal.util.EncryptUtil;

public class AddressDAO extends AbstractDAO {

	protected static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	public static String LOG_PATH = config.getString("framework.importlog.path");
	
	/**
	 * 주소록 리스트.   
	 * @param addrDto   주소록  정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO addrPageList(AddressDTO addrDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgAddressInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		
		sql.setString(addrDto.getUserID()); //세션 아이디
		sql.setString(addrDto.getvSearchType()); //검색구분
		sql.setString(addrDto.getvSearch()); //검색어
		sql.setInteger(addrDto.getnRow()); //리스트 갯수
		sql.setInteger(addrDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분

		try{
			retVal=broker.executePageProcedure(sql,addrDto.getnPage(),addrDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * 주소록 등록 
	 * @param addrDto 주소록 사용자 정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int addrRegist(AddressDTO addrDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgAddressRegist ( ?, ?, ?, ?, ?, ?, ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(addrDto.getUserID()); //로그인 세션 아이디
		sql.setString(addrDto.getAddressName()); //주소록 사용자 명
		sql.setString(addrDto.getFaxNo()); //팩스번호
		sql.setString(addrDto.getOfficePhone()); //사무실 또는 집 전화번호
		sql.setString(addrDto.getMobilePhone()); //핸드폰 번호
		sql.setString(addrDto.getEmail()); //E-Mail
		sql.setString(addrDto.getMemo()); //메모
		
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
	 * 주소록 상세정보
	 * @param userid
	 * @return addrDto 사용자 정보
	 * @throws DAOException
	 */
	public AddressDTO addrView(AddressDTO addrDto) throws DAOException{

		String procedure = "{ CALL hp_mgAddressSelect ( ?,?,?,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid());    //로그아이디
		sql.setSql(procedure);             //프로시져 명
		sql.setInteger(addrDto.getSeq());  //고유 인덱스 키
		System.out.println(addrDto.getSeq());
		sql.setString(addrDto.getUserID()); //사용자명
		System.out.println(addrDto.getUserID());
		sql.setString(addrDto.getFaxNo()); //팩스번호
		System.out.println(addrDto.getFaxNo());
		sql.setString("SELECT");

		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 addrDto = new AddressDTO();
				 addrDto.setSeq(ds.getInt("Seq"));
				 addrDto.setUserID(ds.getString("UserID"));
				 addrDto.setAddressName(ds.getString("AddressName"));
				 addrDto.setFaxNo(ds.getString("FaxNo"));
				 addrDto.setFaxNoFormat(ds.getString("FaxNoFormat"));
				 addrDto.setOfficePhone(ds.getString("OfficePhone"));
				 addrDto.setOfficePhoneFormat(ds.getString("OfficePhoneFormat"));
				 addrDto.setMobilePhone(ds.getString("MobilePhone"));
				 addrDto.setMobilePhoneFormat(ds.getString("MobilePhoneFormat"));
				 addrDto.setEmail(ds.getString("Email"));
				 addrDto.setMemo(ds.getString("Memo"));
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
		
		return addrDto;
	}
	
	/**
	* 주소록 팩스번호 중복 체크
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String addrDupCheck(AddressDTO addrDto) throws DAOException{

		String procedure = " { CALL hp_mgAddressSelect ( ? , ? , ?, ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(addrDto.getLogid());		//로그아이디
		sql.setInteger(addrDto.getSeq());		//인덱스형 고유 PK
		sql.setString(addrDto.getUserID());;    //사용자명
		sql.setString(addrDto.getFaxNo());		//팩스번호
		sql.setString("DUPLICATE");				//SP구분

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
	 * 주소록 사용자 정보 수정
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int addrModify(AddressDTO addrDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgAddressModify (?,?,?,?,?,?,?,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setInteger(addrDto.getSeq());   //고유 인덱스 키 (PK)
		sql.setString(addrDto.getUserID()); //세션 아이디(주소록 생성자 아이디)
		sql.setString(addrDto.getAddressName()); //주소록 사용자명
		sql.setString(addrDto.getFaxNo());   //팩스번호
		sql.setString(addrDto.getOfficePhone()); //집,회사 전화번호
		sql.setString(addrDto.getMobilePhone()); //모바일 전화번호
		sql.setString(addrDto.getEmail()); //이메일
		sql.setString(addrDto.getMemo()); //메모

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
	 * 주소록 사용자 정보를 삭제한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users_seq (check) SeqPk 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int addrDeletes(String logid,String[] users_seq) throws DAOException{
		
		String procedure = " { CALL hp_mgAddressDelete ( ? ) } ";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; users_seq != null && i<users_seq.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(users_seq[i], "|");
				if(r_data[1].equals("Y")){
				
				batch.add(StringUtil.nvl(r_data[0],"")); 	//users_seq(Pk)고유 인덱스 키
				System.out.println("r_data:"+r_data);
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
	 * 내 주소록 관리 Excel 리스트.   
	 * @param  addrDto   내 주소록 관리  정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO addressExcelList(AddressDTO addrDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgAddressInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		
		sql.setString(addrDto.getUserID()); //세션 아이디
		sql.setString(addrDto.getvSearchType()); //검색구분
		sql.setString(addrDto.getvSearch()); //검색어
		sql.setInteger(addrDto.getnRow()); //리스트 갯수
		sql.setInteger(addrDto.getnPage()); //현제 페이지
		sql.setString("LIST"); //sp 구분

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
	 * 사용자 EXCEL import
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String addressListImport(ArrayList<AddressDTO> addrList,String filename){
		
		String importResult = "";
		//String importResult_Dao_Log= "";
		int successcnt=0;
		int failcnt=0;
		
		String log_userid="";       //세션ID(등록한 사람)
		String log_addrname="";     //사용자명
		String log_faxno="";     //팩스번호
		String log_officephone="";  //집 또는 회사 전화번호
		String log_mobilephone="";  //휴대폰 번호
		String log_email=""; 		//이메일
		String log_memo="";		    //메모
		
		String log_result="";		//성공여부
		String log_userAndfaxNoChk = ""; //사용자와 팩스번호 중복체크
		
		BufferedWriter out = null;
		
		int retVal = -1;

		try {
			//log파일 생성
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));

			for(int i=0;i<addrList.size();i++){
				
				AddressDTO addrDto = addrList.get(i);

				log_userid		= addrDto.getUserID();
				log_addrname	= addrDto.getAddressName();
				log_faxno		= addrDto.getFaxNo();
				log_officephone	= addrDto.getOfficePhone();
				log_mobilephone	= addrDto.getMobilePhone();
				log_email		= addrDto.getEmail();
				log_memo		= addrDto.getMemo();

				log_userAndfaxNoChk=addrDupCheck(addrDto);//사용자 & 팩스번호 중복체크
			
				
				if(log_userAndfaxNoChk.equals("1")){
					
					log_result="등록실패-이미 주소록에 등록 되있는 사용자입니다. 내 주소록 관리에서 확인해주세요.";
					failcnt++;
				
				}else if(log_userAndfaxNoChk.equals("0")){	
					log_result="등록성공-내 주소록 관리에서 확인 해주세요.";
								
								
				//등록 sp호출부분
				retVal = addrRegist(addrDto);

				if(retVal == -1){
					log_result = "등록 오류 - SQL Error!!";
					failcnt++;
				}else if(retVal ==0){
					log_result = "등록 실패 - 등록 안됨";
					failcnt++;
				}else{
					log_result = "등록 성공  - ID : "+addrDto.getUserID();
					successcnt++;
				}
								
				}
	
			
				
				if(i==0){
					out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_faxno+"]"+"[RESULT : "+log_result+"]");
				}else{
					out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_faxno+"]"+"[RESULT : "+log_result+"]");
				}
			}

				
			
			importResult=" 총 : "+addrList.size()+"건 중 성공건수 : "+successcnt+"건 실패건수 : "+failcnt+"건 \\n결과로그는 WAS경로["+LOG_PATH+"] 의 "+filename+".log 파일에서 확인가능합니다.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
			importResult="업로드를 실패했습니다.\\n업로드 양식에 맞는 데이타인지 확인하세요!![SQL Error]";
		
		}finally{
			
			try{ if(out != null) out.close(); } catch(Exception e){}
		}
		
		
		return importResult;
	}
	
	
}
