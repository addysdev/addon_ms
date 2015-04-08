package com.web.common.order;

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
import com.web.common.recovery.RecoveryDTO;
import com.web.common.config.CompanyDTO;

public class OrderDAO extends AbstractDAO {

	/**
	 * 발주 대상 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO targetPageList(OrderDTO orderDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_odTargetInquiry ( ? , ? , ? , ? , ? , ? ,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(orderDto.getChUserID()); //세션 아이디
		sql.setString(orderDto.getGroupID()) ;
		sql.setString(orderDto.getvSearchType()); //
		sql.setString(orderDto.getvSearch()); //
		sql.setInteger(orderDto.getnRow()); //리스트 갯수
		sql.setInteger(orderDto.getnPage()); //현제 페이지
		sql.setString(orderDto.getJobGb()); //
		
		try{
			retVal=broker.executePageProcedure(sql,orderDto.getnPage(),orderDto.getnRow());
	
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
	 * 발주 구매처 정보
	 * @param userid
	 * @return 
	 * @throws DAOException
	 */
	public CompanyDTO orderCompanyInfo(CompanyDTO comapnyDto) throws DAOException{

		String procedure = "{ CALL ap_mgOrderCompanySelect ( ? ,? ,?  ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(comapnyDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(comapnyDto.getChUserID()); // 
		sql.setString(comapnyDto.getCompanyCode()); //
		sql.setString(comapnyDto.getOrderCode()); //
		
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
				
				comapnyDto.setBuyResult(ds.getString("BuyResult"));
				comapnyDto.setDeliveryDate(ds.getString("DeliveryDate"));
				comapnyDto.setDeliveryDateFomat(ds.getString("DeliveryDateFomat"));
				comapnyDto.setDeliveryEtc(ds.getString("DeliveryEtc"));
				comapnyDto.setDeliveryMethod(ds.getString("DeliveryMethod"));
				comapnyDto.setDeliveryCharge(ds.getString("DeliveryCharge"));
				
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
	public ListDTO targetDetailPageList(OrderDTO orderDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_odTargetDetailInquiry ( ? , ? , ? , ? , ?  , ?) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(orderDto.getChUserID()); //
		sql.setString(orderDto.getGroupID()); //
		sql.setString(orderDto.getCompanyCode()); //
		sql.setInteger(orderDto.getnRow()); //리스트 갯수
		sql.setInteger(orderDto.getnPage()); //현제 페이지
		sql.setString(orderDto.getJobGb()); //

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
	 * 발주 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int orderRegist(OrderDTO orderDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odOrderRegist ( ?, ? , ? ,? , ? , ? , ?, ?, ?, ?, ?, ? , ?, ?, ?, ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(orderDto.getChUserID()); //세션 아이디
		sql.setString(orderDto.getOrderCode()); 
		sql.setString(orderDto.getGroupID()); 
		sql.setString(orderDto.getCompanyCode()); 
		sql.setString(orderDto.getFAXKey()); 
		sql.setString(orderDto.getEmailKey()); 
		sql.setString(orderDto.getSMSKey()); 
		sql.setString(orderDto.getFaxnum()); 
		sql.setString(orderDto.getMobilephone()); 
		sql.setString(orderDto.getEmailaddr()); 
		sql.setString(orderDto.getOrderEtc()); 
		sql.setString(orderDto.getOrderAdress()); 
		sql.setString(orderDto.getDeliveryDate()); 
		sql.setString(orderDto.getDeliveryEtc()); 
		sql.setString(orderDto.getDeliveryMethod()); 
		sql.setString(orderDto.getDeliveryCharge()); 
		
		
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
	 * 발주 정보를 등록한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int orderDetailRegist(String logid,String[] orders, String ordercode) throws DAOException{
		
		String procedure = " { CALL ap_odOrderDetailRegist ( ? , ? , ? , ? , ? , ? , ? , ? , ? ,?) } ";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; orders != null && i<orders.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(orders[i], "|");
				
				batch.add(ordercode);			
				batch.add(StringUtil.nvl(r_data[0],"")); 
				batch.add(StringUtil.nvl(r_data[1],0)); 
				batch.add(StringUtil.nvl(r_data[2],"")); 
				batch.add(StringUtil.nvl(r_data[3],0)); 
				batch.add(StringUtil.nvl(r_data[4],0)); 
				batch.add(StringUtil.nvl(r_data[5],0)); 
				batch.add(StringUtil.nvl(r_data[6],0)); 
				batch.add(StringUtil.nvl(r_data[7],"")); 
				batch.add(StringUtil.nvl(r_data[10],"")); 
				
				
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
	 * 발주 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO orderPageList(OrderDTO orderDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_odOrderInquiry ( ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(orderDto.getChUserID()); //세션 아이디
		sql.setString(orderDto.getFrDate()); //
		sql.setString(orderDto.getToDate()); //
		sql.setString(orderDto.getGroupID()); //
		sql.setString(orderDto.getvSearchType()); //
		sql.setString(orderDto.getvSearch()); //
		sql.setInteger(orderDto.getnRow()); //리스트 갯수
		sql.setInteger(orderDto.getnPage()); //현제 페이지
		sql.setString(orderDto.getJobGb()); //
		
		try{
			retVal=broker.executePageProcedure(sql,orderDto.getnPage(),orderDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	/**
	 * 발주 상세 리스트.   
	 * @param    조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO orderDetailPageList(OrderDTO orderDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_odOrderDetailInquiry ( ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(orderDto.getChUserID()); //
		sql.setString(orderDto.getOrderCode()); //
		sql.setInteger(orderDto.getnRow()); //리스트 갯수
		sql.setInteger(orderDto.getnPage()); //현제 페이지
		sql.setString(orderDto.getJobGb()); //

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
	 * 발주처리 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int orderProcSave(OrderDTO orderDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odOrderProcSave ( ?, ? , ? ,? , ? ,? ,? ,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(orderDto.getChUserID()); //세션 아이디
		sql.setString(orderDto.getOrderCode()); 
		sql.setString(orderDto.getProductCode()); 
		sql.setString(orderDto.getOrderCheck()); 
		sql.setInteger(orderDto.getOrderResultCnt()); 
		sql.setInteger(orderDto.getOrderResultPrice()); 
		sql.setString(orderDto.getVatRate()); 
		sql.setString(orderDto.getOrderMemo()); 
		
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
	public String orderIngYN(OrderDTO orderDto) throws DAOException{

		String procedure = "{ CALL ap_odOrderIngSelect ( ? ) }";

		String ingYN ="";
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(orderDto.getOrderCode()); //
		
		try{
			
			 ds = broker.executeProcedure(sql);

			 while(ds.next()){ 
				
				 ingYN=ds.getString("OrderResult");
				
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
	public int orderProcClose(OrderDTO orderDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odOrderProcClose ( ?, ?  ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(orderDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(orderDto.getChUserID()); //세션 아이디
		sql.setString(orderDto.getOrderCode()); 
		
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
