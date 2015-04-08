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
	 * ��ǰ ����Ʈ.   
	 * @param userDto   ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO productPageList(ProductDTO productDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgProductInquiry ( ? , ? , ? , ? , ? , ? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(productDto.getChUserID()); //���� ���̵�
		sql.setString(productDto.getvSearchType()); //�˻�����
		sql.setString(productDto.getvSearch()); //�˻���
		sql.setInteger(productDto.getnRow()); //����Ʈ ����
		sql.setInteger(productDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����
		

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
	 * ����ó ����Ʈ.   
	 * @param    ���� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO companyPageList(CompanyDTO companyDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgCompanyInquiry ( ? , ? , ? , ? , ? , ? , ?, ?, ?) } ";

		QueryStatement sql = new QueryStatement();
		sql.setKey(companyDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(companyDto.getChUserID()); //���� ���̵�
		sql.setString(companyDto.getvSearchType()); //�˻�����
		sql.setString(companyDto.getvSearch()); //�˻���
		sql.setInteger(companyDto.getnRow()); //����Ʈ ����
		sql.setInteger(companyDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����
		
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
	 * ��ǰ ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int productRegist(ProductDTO productDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_mgProductRegist ( ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(productDto.getChUserID()); //���� ���̵�
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
	 * ����ó ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int companyRegist(CompanyDTO companyDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL ap_mgCompanyRegist ( ?, ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(companyDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
			
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
	 * ����ó ����
	 * @param 
	 * @return retVal int
	 * @throws DAOException
	 */
	public int companyDeletes() throws Exception{
			
			int retVal = -1;
			
			String procedure = " { CALL ap_mgCompanyDelete () } ";
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(""); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
					
		
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
	 * ��ǰ ����
	 * @param userid
	 * @return userDto ����� ����
	 * @throws DAOException
	 */
	public ProductDTO productView(ProductDTO productDto) throws DAOException{

		String procedure = "{ CALL ap_mgProductSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(productDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure);  //���ν��� ��
		sql.setString(productDto.getChUserID()); // ���� ���̵�
		sql.setString("SELECT"); // sp����
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
	 * ��ǰ ����
	 * @param 
	 * @return retVal int
	 * @throws DAOException
	 */
	public int productModify(ProductDTO productDto) throws Exception{
			
			int retVal = -1;
			
			String procedure = " { CALL ap_mgProductModify (  ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(productDto.getLogid()); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
					
			sql.setString(productDto.getChUserID()); //���� ���̵�
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
	 * ��ǰ ������ �����Ѵ�.(�ٰ�ó��)
	 * @param logid �α׾��̵�
	 * @param users ID(check) �迭
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
	public ListDTO productExcelList(ProductDTO productDto) throws DAOException{
			
    	    String procedure = " { CALL ap_mgProductInquiry ( ? , ? , ? , ? , ? , ?, ?, ? ,? ) } ";

			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();

			sql.setKey(productDto.getLogid()); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
			sql.setString(productDto.getChUserID()); //���� ���̵�
			sql.setString(productDto.getvSearchType()); //�˻�����
			sql.setString(productDto.getvSearch()); //�˻���
			sql.setInteger(productDto.getnRow()); //����Ʈ ����
			sql.setInteger(productDto.getnPage()); //���� ������
			sql.setString("LIST"); //sp ����
		
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
	* ��ǰ �ߺ� üũ
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String productDupCheck(ProductDTO productDto, String jobGb) throws DAOException{

		String procedure = " { CALL ap_mgProductSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(productDto.getLogid());				//�α׾��̵�
		sql.setString(productDto.getChUserID());		//���Ǿ��̵�
		sql.setString(jobGb);			//SP����
		sql.setString(productDto.getProductCode());		//����� ���̵�

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
	* ����ó �ߺ� üũ
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String companyDupCheck(CompanyDTO companyDto, String jobGb) throws DAOException{

		String procedure = " { CALL ap_mgCompanySelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(companyDto.getLogid());				//�α׾��̵�
		sql.setString(companyDto.getChUserID());		//���Ǿ��̵�
		sql.setString(jobGb);			//SP����
		sql.setString(companyDto.getCompanyCode());		//����ó ���̵�

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
	 * ����� EXCEL import
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
			//log���� ����
			out = new BufferedWriter(new FileWriter(	LOG_PATH+File.separator+filename+".log"));
			
			//���� spȣ��κ�
			retVal = companyDeletes();
/*
			if(retVal == -1){
				log_result = "���� ���� - SQL Error!!";
				failcnt++;
			}else if(retVal ==0){
				log_result = "���� ���� - ��� �ȵ�";
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

					//��� spȣ��κ�
					retVal = companyRegist(companyDto);
	
					if(retVal == -1){
						log_result = "��� ���� - SQL Error!!";
						failcnt++;
					}else if(retVal ==0){
						log_result = "��� ���� - ��� �ȵ�";
						failcnt++;
					}else{
						log_result = "��� ����  - Code : "+companyDto.getCompanyCode();
						successcnt++;
					}
	
					if(i==0){
						out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[COMPANYCODE: "+log_comcode+"]"+"[RESULT : "+log_result+"]");
					}else{
						out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[COMPANYCODE : "+log_comcode+"]"+"[RESULT : "+log_result+"]");
					}
				}
				
//			}
			
			importResult="�� : "+coms.size()+"�� �� �����Ǽ� : "+successcnt+"�� ���аǼ� : "+failcnt+"�� \\n����α״� WAS���["+LOG_PATH+"] �� "+filename+".log ���Ͽ��� Ȯ�ΰ����մϴ�.";
				
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
	 * �α��� �̷� ����Ʈ. (Excel)  
	 * @param loginHistoryDto   �˻� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO safeStockList(SafeStockDTO safeStockDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL ap_mgSafeStockInquiry ( ? , ? ) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(safeStockDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(safeStockDto.getChUserID()); //���� ���̵�
		sql.setString(safeStockDto.getProductCode()); //��ǰ�ڵ�

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
	 * �޸���
	 * @param commInboundDto
	 * @return retVal
	 * @throws DAOException
	 */	
	public int safeStockSave(SafeStockDTO safeStockDto) throws DAOException{
		
		String procedure = " { CALL ap_mgSafeStockSave ( ? ,? ,? ,? ,?) } ";
		
		int retVal = 0;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(safeStockDto.getLogid());					//�α׾��̵�
		
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
