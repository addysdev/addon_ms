package com.web.common.recovery;

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

import com.web.common.order.OrderDTO;
import com.web.common.config.CompanyDTO;
import com.web.common.recovery.RecoveryDTO;

public class RecoveryDAO extends AbstractDAO {

	/**
	 * 발주 대상 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO reTargetPageList(RecoveryDTO recoveryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_reTargetInquiry ( ? ,  ? ,? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(recoveryDto.getChUserID()); //세션 아이디
		sql.setString(recoveryDto.getGroupID()); //
		sql.setString(recoveryDto.getvSearchType()); //
		sql.setString(recoveryDto.getvSearch()); //
		sql.setInteger(recoveryDto.getnRow()); //리스트 갯수
		sql.setInteger(recoveryDto.getnPage()); //현제 페이지
		sql.setString(recoveryDto.getJobGb()); //
		
		try{
			retVal=broker.executePageProcedure(sql,recoveryDto.getnPage(),recoveryDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	/**
	 * 구매처 정보
	 * @param userid
	 * @return 
	 * @throws DAOException
	 */
	public CompanyDTO companyInfo(CompanyDTO comapnyDto) throws DAOException{

		String procedure = "{ CALL ap_mgCompanySelect ( ? ,?  ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(comapnyDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(comapnyDto.getChUserID()); // 
		sql.setString(comapnyDto.getCompanyCode()); //
		
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 comapnyDto = new CompanyDTO();
			 
			 while(ds.next()){ 
				
				comapnyDto.setCompanyCode(ds.getString("CompanyCode"));
				comapnyDto.setCompanyName(ds.getString("CompanyName"));
				comapnyDto.setCompanyPhone(ds.getString("CompanyPhoneFormat"));
				comapnyDto.setPostCode(ds.getString("PostCode"));
				comapnyDto.setAddress1(ds.getString("Address1"));	
				comapnyDto.setFaxNumber(ds.getString("FaxNumberFormat"));
				comapnyDto.setMobilePhone(ds.getString("MobilePhoneFormat"));
				comapnyDto.setEmail(ds.getString("Email"));
				comapnyDto.setChargeName(ds.getString("ChargeName"));
				
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
		
		return comapnyDto;
	}
	
	/**
	 * 발주대상  상세 리스트.   
	 * @param    조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO reTargetDetailPageList(RecoveryDTO recoveryDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_reTargetDetailInquiry ( ? , ? , ? , ? , ?  , ?) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(recoveryDto.getChUserID()); //
		sql.setString(recoveryDto.getGroupID()); //
		sql.setString(recoveryDto.getCompanyCode()); //
		sql.setInteger(recoveryDto.getnRow()); //리스트 갯수
		sql.setInteger(recoveryDto.getnPage()); //현제 페이지
		sql.setString(recoveryDto.getJobGb()); //

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
	 * 회수 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int recoveryRegist(RecoveryDTO recoveryDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_reRecoveryRegist ( ?, ? , ? ,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(recoveryDto.getChUserID()); //세션 아이디
		sql.setString(recoveryDto.getRecoveryCode()); 
		sql.setString(recoveryDto.getGroupID()); 
		sql.setString(recoveryDto.getCompanyCode()); 
		
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
	 * 회수 정보를 등록한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int recoveryDetailRegist(String logid,String[] recoverys, String recoverycode) throws DAOException{
		
		String procedure = " { CALL ap_reRecoveryDetailRegist ( ? , ? , ? , ? , ? , ? ,?) } ";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; recoverys != null && i<recoverys.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(recoverys[i], "|");
				
				batch.add(recoverycode);			
				batch.add(StringUtil.nvl(r_data[0],"")); 
				batch.add(StringUtil.nvl(r_data[1],0)); 
				batch.add(StringUtil.nvl(r_data[2],0)); 
				batch.add(StringUtil.nvl(r_data[3],0)); 
				batch.add(StringUtil.nvl(r_data[4],"")); 
				batch.add(StringUtil.nvl(r_data[5],"")); 
				batchList.add(batch);

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
	 * 회수 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO recoveryPageList(RecoveryDTO recoveryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_reRecoveryInquiry ( ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(recoveryDto.getChUserID()); //세션 아이디
		sql.setString(recoveryDto.getFrDate()); //
		sql.setString(recoveryDto.getToDate()); //
		sql.setString(recoveryDto.getGroupID()); //
		sql.setString(recoveryDto.getvSearchType()); //
		sql.setString(recoveryDto.getvSearch()); //
		sql.setInteger(recoveryDto.getnRow()); //리스트 갯수
		sql.setInteger(recoveryDto.getnPage()); //현제 페이지
		sql.setString(recoveryDto.getJobGb()); //
		
		try{
			retVal=broker.executePageProcedure(sql,recoveryDto.getnPage(),recoveryDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	/**
	 * 회수 상세 리스트.   
	 * @param    조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO recoveryDetailPageList(RecoveryDTO recoveryDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_reRecoveryDetailInquiry ( ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(recoveryDto.getChUserID()); //
		sql.setString(recoveryDto.getRecoveryCode()); //
		sql.setInteger(recoveryDto.getnRow()); //리스트 갯수
		sql.setInteger(recoveryDto.getnPage()); //현제 페이지
		sql.setString(recoveryDto.getJobGb()); //

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
	 * 회수처리 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int recoveryProcSave(RecoveryDTO recoveryDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_reRecoveryProcSave ( ?, ? , ? ,? , ? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(recoveryDto.getChUserID()); //세션 아이디
		sql.setString(recoveryDto.getRecoveryCode()); 
		sql.setString(recoveryDto.getProductCode()); 
		sql.setString(recoveryDto.getRecoveryCheck()); 
		sql.setInteger(recoveryDto.getRecoveryResultCnt()); 
		sql.setString(recoveryDto.getRecoveryMemo()); 
		
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
	 * 구매처 정보
	 * @param userid
	 * @return 
	 * @throws DAOException
	 */
	public String recoveryIngYN(RecoveryDTO recoveryDto) throws DAOException{

		String procedure = "{ CALL ap_reRecoveryIngSelect ( ? ) }";

		String ingYN ="";
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(recoveryDto.getRecoveryCode()); //
		
		try{
			
			 ds = broker.executeProcedure(sql);

			 while(ds.next()){ 
				
				 ingYN=ds.getString("RecoveryResult");
				
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
		
		return ingYN;
	}
	/**
	 * 구매처리 완료
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int recoveryProcClose(RecoveryDTO recoveryDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_reRecoveryProcClose ( ?, ?  ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(recoveryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(recoveryDto.getChUserID()); //세션 아이디
		sql.setString(recoveryDto.getRecoveryCode()); 
		
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
}
