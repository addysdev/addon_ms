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

import com.web.common.order.StockDTO;

public class StockDAO extends AbstractDAO {

	/**
	 * 재고현황 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO stockPageList(StockDTO stockDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_odStockInquiry ( ? , ? , ? , ? , ? , ? ,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(stockDto.getChUserID()); //세션 아이디
		sql.setString(stockDto.getFrDate()); //
		sql.setString(stockDto.getToDate()); //
		sql.setInteger(stockDto.getnRow()); //리스트 갯수
		sql.setInteger(stockDto.getnPage()); //현제 페이지
		sql.setString(stockDto.getGroupID()); //
		sql.setString("PAGE"); //sp 구분
		

		try{
			retVal=broker.executePageProcedure(sql,stockDto.getnPage(),stockDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	
	/**
	 * 재고현황 상세 리스트.   
	 * @param    조직 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO stockDetailPageList(StockDTO stockDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_odStockDetailInquiry ( ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(stockDto.getStockDate()); //
		sql.setString(stockDto.getGroupID()); //
		sql.setInteger(stockDto.getnRow()); //리스트 갯수
		sql.setInteger(stockDto.getnPage()); //현제 페이지
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
	 * 재고현황 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int stockRegist(StockDTO stockDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odStockRegist ( ?, ? , ? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(stockDto.getChUserID()); //세션 아이디
		sql.setString(stockDto.getStockDate()); 
		sql.setString(stockDto.getGroupID()); 
		sql.setString(stockDto.getGroupName()); 
		
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
	 * 재고 상세현황 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int stockDetailRegist(StockDTO stockDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odStockDetailRegist ( ?, ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
				
		sql.setString(stockDto.getChUserID()); //세션 아이디
		sql.setString(stockDto.getStockDate()); 
		sql.setString(stockDto.getGroupID()); 
		sql.setString(stockDto.getGroupName()); 
		sql.setString(stockDto.getProductCode()); 
		sql.setInteger(stockDto.getStockCnt()); 
		
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
	
	protected static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	public static String LOG_PATH = config.getString("framework.importlog.path");
	/**
	 * 사용자 EXCEL import
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String stockListImport(StockDTO stockDto,ArrayList<StockDTO> stocks,String filename){
		
		String importResult="";
		int successcnt=0;
		int failcnt=0;
		
		String log_stockdate="";
		String log_groupid="";
		String log_productcode="";
		
		String log_result="";
		
		BufferedWriter out = null;
		
		int retVal = -1;
		
		try {
			//log파일 생성
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));
			
			//재고등록 sp호출부분
			retVal = stockRegist(stockDto);

			if(retVal == -1){
				log_result = "등록 오류 - SQL Error!!";
				failcnt++;
			}else if(retVal ==0){
				log_result = "등록 실패 - 등록 안됨";
				failcnt++;
			}else{

				for(int i=0;i<stocks.size();i++){
					
					StockDTO stockDetailDto = stocks.get(i);
	
					log_stockdate= stockDetailDto.getStockDate();
					log_groupid= stockDetailDto.getGroupID();
					log_productcode= stockDetailDto.getProductCode();
					
					//등록 sp호출부분
					retVal = stockDetailRegist(stockDetailDto);
	
					if(retVal == -1){
						log_result = "등록 오류 - SQL Error!!";
						failcnt++;
					}else if(retVal ==0){
						log_result = "등록 실패 - 등록 안됨";
						failcnt++;
					}else{
						log_result = "등록 성공  - Code : "+stockDetailDto.getStockDate();
						successcnt++;
					}
	
					if(i==0){
						out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[STOCKDATE: "+log_stockdate+"]"+"[STOCKGROUP: "+log_groupid+"]"+"[PRODUCTCODE: "+log_productcode+"]"+"[RESULT : "+log_result+"]");
					}else{
						out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[STOCKDATE : "+log_stockdate+"]"+"[STOCKGROUP: "+log_groupid+"]"+"[PRODUCTCODE: "+log_productcode+"]"+"[RESULT : "+log_result+"]");
					}
				}
				
			}
			
			importResult="총 : "+stocks.size()+"건 중 성공건수 : "+successcnt+"건 실패건수 : "+failcnt+"건 \\n결과로그는 WAS경로["+LOG_PATH+"] 의 "+filename+".log 파일에서 확인가능합니다.";
				
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
