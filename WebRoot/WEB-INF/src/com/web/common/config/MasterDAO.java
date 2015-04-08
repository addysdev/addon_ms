package com.web.common.config;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.web.framework.configuration.Configuration;
import com.web.framework.configuration.ConfigurationFactory;
import com.web.framework.data.DataSet;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.QueryStatement;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.StringUtil;

import com.web.common.config.CompanyDTO;
import com.web.common.history.LoginHistoryDTO;

public class MasterDAO extends AbstractDAO {

	/**
	 * 제품 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO productPageList(ProductDTO productDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgProductInquiry ( ? , ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(productDto.getChUserID()); //세션 아이디
		sql.setString(productDto.getvSearchType()); //검색구분
		sql.setString(productDto.getvSearch()); //검색어
		sql.setInteger(productDto.getnRow()); //리스트 갯수
		sql.setInteger(productDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분
		

		try{
			retVal=broker.executePageProcedure(sql,productDto.getnPage(),productDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * 구입처 리스트.   
	 * @param    조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO companyPageList(CompanyDTO companyDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgCompanyInquiry ( ? , ? , ? , ? , ? , ? , ?, ?, ?) } ";

		QueryStatement sql = new QueryStatement();
		sql.setKey(companyDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(companyDto.getChUserID()); //세션 아이디
		sql.setString(companyDto.getvSearchType()); //검색구분
		sql.setString(companyDto.getvSearch()); //검색어
		sql.setInteger(companyDto.getnRow()); //리스트 갯수
		sql.setInteger(companyDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분
		
		try{
			retVal=broker.executePageProcedure(sql,companyDto.getnPage(),companyDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * 제품 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int productRegist(ProductDTO productDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_mgProductRegist ( ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(productDto.getChUserID()); //세션 아이디
		sql.setString(productDto.getProductCode());
		sql.setString(productDto.getBarCode());
		sql.setString(productDto.getProductName());
		sql.setString(productDto.getCompanyCode());
		sql.setString(productDto.getGroup1());
		sql.setString(productDto.getGroup1Name());
		sql.setString(productDto.getGroup2());
		sql.setString(productDto.getGroup2Name());
		sql.setString(productDto.getGroup3());
		sql.setString(productDto.getGroup3Name());
		sql.setInteger(productDto.getProductPrice());
		sql.setString(productDto.getVatRate());
		
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
	 * 구매처 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int companyRegist(CompanyDTO companyDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_mgCompanyRegist ( ?, ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(companyDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
			
		sql.setString(companyDto.getChUserID()); //
		sql.setString(companyDto.getCompanyCode()); //
		sql.setString(companyDto.getCompanyName()); //
		sql.setString(companyDto.getCompanyPhone()); //
		sql.setString(companyDto.getPostCode()); //
		sql.setString(companyDto.getAddress1()); //
		sql.setString(companyDto.getFaxNumber()); //
		sql.setString(companyDto.getMobilePhone()); //
		sql.setString(companyDto.getEmail()); //
		sql.setString(companyDto.getChargeName()); //
		
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
	 * 구매처 삭제
	 * @param 
	 * @return retVal int
	 * @throws DAOException
	 */
	public int companyDeletes() throws Exception{
			
			int retVal = -1;
			
			String procedure = " { CALL ap_mgCompanyDelete () } ";
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(""); //로그아이디
			sql.setSql(procedure); //프로시져 명
					
		
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
	 * 제품 정보
	 * @param userid
	 * @return userDto 사용자 정보
	 * @throws DAOException
	 */
	public ProductDTO productView(ProductDTO productDto) throws DAOException{

		String procedure = "{ CALL ap_mgProductSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(productDto.getChUserID()); // 세션 아이디
		sql.setString("SELECT"); // sp구분
		sql.setString(productDto.getProductCode()); // ProductCode

		try{
			
			 ds = broker.executeProcedure(sql);
			
			 productDto = new ProductDTO();
			 
			 while(ds.next()){ 
				
				productDto.setProductCode(ds.getString("ProductCode"));
				productDto.setProductName(ds.getString("ProductName"));
				productDto.setBarCode(ds.getString("BarCode"));
				productDto.setCompanyName(ds.getString("CompanyName"));
				productDto.setCompanyCode(ds.getString("CompanyCode"));
				productDto.setRecoveryYN(ds.getString("RecoveryYN"));
				productDto.setGroup1(ds.getString("Group1"));
				productDto.setGroup1Name(ds.getString("Group1Name"));
				productDto.setGroup2(ds.getString("Group2"));
				productDto.setGroup2Name(ds.getString("Group2Name"));
				productDto.setGroup3(ds.getString("Group3"));
				productDto.setGroup3Name(ds.getString("Group3Name"));
				productDto.setProductPrice(ds.getInt("ProductPrice"));
				productDto.setVatRate(ds.getString("VatRate"));
			  
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
		
		return productDto;
	}
	
	/**
	 * 제품 수정
	 * @param 
	 * @return retVal int
	 * @throws DAOException
	 */
	public int productModify(ProductDTO productDto) throws Exception{
			
			int retVal = -1;
			
			String procedure = " { CALL ap_mgProductModify (  ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(productDto.getLogid()); //로그아이디
			sql.setSql(procedure); //프로시져 명
					
			sql.setString(productDto.getChUserID()); //세션 아이디
			sql.setString(productDto.getProductCode());
			sql.setString(productDto.getBarCode());
			sql.setString(productDto.getProductName());
			sql.setString(productDto.getCompanyCode());
			sql.setString(productDto.getRecoveryYN());
			sql.setString(productDto.getGroup1());
			sql.setString(productDto.getGroup1Name());
			sql.setString(productDto.getGroup2());
			sql.setString(productDto.getGroup2Name());
			sql.setString(productDto.getGroup3());
			sql.setString(productDto.getGroup3Name());
			sql.setInteger(productDto.getProductPrice());
			sql.setString(productDto.getVatRate());
		
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
	 * 제품 정보를 삭제한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int productDeletes(String logid,String[] prods, String USERID) throws DAOException{
		
		String procedure = " { CALL ap_mgProductDelete ( ? , ? ) } ";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; prods != null && i<prods.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(prods[i], "|");
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
	public ListDTO productExcelList(ProductDTO productDto) throws DAOException{
			
    	    String procedure = " { CALL ap_mgProductInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,? ) } ";

			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();

			sql.setKey(productDto.getLogid()); //로그아이디
			sql.setSql(procedure); //프로시져 명
			sql.setString(productDto.getChUserID()); //세션 아이디
			sql.setString(productDto.getvSearchType()); //검색구분
			sql.setString(productDto.getvSearch()); //검색어
			sql.setInteger(productDto.getnRow()); //리스트 갯수
			sql.setInteger(productDto.getnPage()); //현제 페이지
			sql.setString("LIST"); //sp 구분
		
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
	* 제품 중복 체크
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String productDupCheck(ProductDTO productDto, String jobGb) throws DAOException{

		String procedure = " { CALL ap_mgProductSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(productDto.getLogid());				//로그아이디
		sql.setString(productDto.getChUserID());		//세션아이디
		sql.setString(jobGb);			//SP구분
		sql.setString(productDto.getProductCode());		//사용자 아이디

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
	* 구매처 중복 체크
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String companyDupCheck(CompanyDTO companyDto, String jobGb) throws DAOException{

		String procedure = " { CALL ap_mgCompanySelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(companyDto.getLogid());				//로그아이디
		sql.setString(companyDto.getChUserID());		//세션아이디
		sql.setString(jobGb);			//SP구분
		sql.setString(companyDto.getCompanyCode());		//구매처 아이디

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
	
	protected static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	public static String LOG_PATH = config.getString("framework.importlog.path");
	/**
	 * 사용자 EXCEL import
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String companyListImport(ArrayList<CompanyDTO> coms,String filename){
		
		String importResult="";
		int successcnt=0;
		int failcnt=0;
		
		String log_comcode="";
		String log_comname="";
		String log_comphone="";
		String log_postcode="";
		String log_address1="";
		String log_faxnum="";
		String log_mobilephone="";
		String log_email="";
		String log_chargename="";
		
		String log_result="";
		
		String log_comschk="";

		BufferedWriter out = null;
		
		int retVal = -1;
		
		try {
			//log파일 생성
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));
			
			//삭제 sp호출부분
			retVal = companyDeletes();
/*
			if(retVal == -1){
				log_result = "삭제 오류 - SQL Error!!";
				failcnt++;
			}else if(retVal ==0){
				log_result = "삭제 실패 - 등록 안됨";
				failcnt++;
			}else{
*/
				for(int i=0;i<coms.size();i++){
					
					CompanyDTO companyDto = coms.get(i);
	
					log_comcode= companyDto.getCompanyCode();
					log_comname= companyDto.getCompanyName();
					log_comphone= companyDto.getCompanyPhone();
					log_postcode= companyDto.getPostCode();
					log_address1= companyDto.getAddress1();
					log_faxnum= companyDto.getFaxNumber();
					log_mobilephone= companyDto.getMobilePhone();
					log_email= companyDto.getEmail();
					log_chargename= companyDto.getChargeName();

					//등록 sp호출부분
					retVal = companyRegist(companyDto);
	
					if(retVal == -1){
						log_result = "등록 오류 - SQL Error!!";
						failcnt++;
					}else if(retVal ==0){
						log_result = "등록 실패 - 등록 안됨";
						failcnt++;
					}else{
						log_result = "등록 성공  - Code : "+companyDto.getCompanyCode();
						successcnt++;
					}
	
					if(i==0){
						out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[COMPANYCODE: "+log_comcode+"]"+"[RESULT : "+log_result+"]");
					}else{
						out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[COMPANYCODE : "+log_comcode+"]"+"[RESULT : "+log_result+"]");
					}
				}
				
//			}
			
			importResult="총 : "+coms.size()+"건 중 성공건수 : "+successcnt+"건 실패건수 : "+failcnt+"건 \\n결과로그는 WAS경로["+LOG_PATH+"] 의 "+filename+".log 파일에서 확인가능합니다.";
				
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
	 * 로그인 이력 리스트. (Excel)  
	 * @param loginHistoryDto   검색 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO safeStockList(SafeStockDTO safeStockDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgSafeStockInquiry ( ? , ? ) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(safeStockDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(safeStockDto.getChUserID()); //세션 아이디
		sql.setString(safeStockDto.getProductCode()); //제품코드

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
	 * 메모등록
	 * @param commInboundDto
	 * @return retVal
	 * @throws DAOException
	 */	
	public int safeStockSave(SafeStockDTO safeStockDto) throws DAOException{
		
		String procedure = " { CALL ap_mgSafeStockSave ( ? ,? ,? ,? ,?) } ";
		
		int retVal = 0;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(safeStockDto.getLogid());					//로그아이디
		
		sql.setString(safeStockDto.getChUserID());				//
		sql.setString(safeStockDto.getProductCode());					//
		sql.setString(safeStockDto.getGroupID());					//
		sql.setInteger(safeStockDto.getSafeStockCnt());				//
		sql.setString(safeStockDto.getProcYN());				//
		
		sql.setSql(procedure);
	
		try{

			retVal=broker.executeProcedureUpdate(sql);

		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}		
		return retVal;	
    }
}
