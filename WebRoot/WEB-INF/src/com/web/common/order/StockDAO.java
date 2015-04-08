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
	 * �����Ȳ ����Ʈ.   
	 * @param userDto   ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO stockPageList(StockDTO stockDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_odStockInquiry ( ? , ? , ? , ? , ? , ? ,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(stockDto.getChUserID()); //���� ���̵�
		sql.setString(stockDto.getFrDate()); //
		sql.setString(stockDto.getToDate()); //
		sql.setInteger(stockDto.getnRow()); //����Ʈ ����
		sql.setInteger(stockDto.getnPage()); //���� ������
		sql.setString(stockDto.getGroupID()); //
		sql.setString("PAGE"); //sp ����
		

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
	 * �����Ȳ �� ����Ʈ.   
	 * @param    ���� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO stockDetailPageList(StockDTO stockDto) throws DAOException {
		
		ListDTO retVal = null;
		String procedure = " { CALL ap_odStockDetailInquiry ( ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(stockDto.getStockDate()); //
		sql.setString(stockDto.getGroupID()); //
		sql.setInteger(stockDto.getnRow()); //����Ʈ ����
		sql.setInteger(stockDto.getnPage()); //���� ������
		sql.setString("LIST"); //sp ����
		

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
	 * �����Ȳ ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int stockRegist(StockDTO stockDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odStockRegist ( ?, ? , ? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(stockDto.getChUserID()); //���� ���̵�
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
	 * ��� ����Ȳ ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int stockDetailRegist(StockDTO stockDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_odStockDetailRegist ( ?, ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(stockDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(stockDto.getChUserID()); //���� ���̵�
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
	 * ����� EXCEL import
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
			//log���� ����
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));
			
			//����� spȣ��κ�
			retVal = stockRegist(stockDto);

			if(retVal == -1){
				log_result = "��� ���� - SQL Error!!";
				failcnt++;
			}else if(retVal ==0){
				log_result = "��� ���� - ��� �ȵ�";
				failcnt++;
			}else{

				for(int i=0;i<stocks.size();i++){
					
					StockDTO stockDetailDto = stocks.get(i);
	
					log_stockdate= stockDetailDto.getStockDate();
					log_groupid= stockDetailDto.getGroupID();
					log_productcode= stockDetailDto.getProductCode();
					
					//��� spȣ��κ�
					retVal = stockDetailRegist(stockDetailDto);
	
					if(retVal == -1){
						log_result = "��� ���� - SQL Error!!";
						failcnt++;
					}else if(retVal ==0){
						log_result = "��� ���� - ��� �ȵ�";
						failcnt++;
					}else{
						log_result = "��� ����  - Code : "+stockDetailDto.getStockDate();
						successcnt++;
					}
	
					if(i==0){
						out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[STOCKDATE: "+log_stockdate+"]"+"[STOCKGROUP: "+log_groupid+"]"+"[PRODUCTCODE: "+log_productcode+"]"+"[RESULT : "+log_result+"]");
					}else{
						out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[STOCKDATE : "+log_stockdate+"]"+"[STOCKGROUP: "+log_groupid+"]"+"[PRODUCTCODE: "+log_productcode+"]"+"[RESULT : "+log_result+"]");
					}
				}
				
			}
			
			importResult="�� : "+stocks.size()+"�� �� �����Ǽ� : "+successcnt+"�� ���аǼ� : "+failcnt+"�� \\n����α״� WAS���["+LOG_PATH+"] �� "+filename+".log ���Ͽ��� Ȯ�ΰ����մϴ�.";
				
			out.close();
			
		}catch (Exception e) {
			System.err.println(e); 
			importResult="���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!![SQL Error]";
		}finally{
			
			
			
			try{ if(out != null) out.close(); } catch(Exception e){}
			
		}
		
		return importResult;
		
	}
	
}
