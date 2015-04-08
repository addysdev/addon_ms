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
	 * �ּҷ� ����Ʈ.   
	 * @param addrDto   �ּҷ�  ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO addrPageList(AddressDTO addrDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgAddressInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		
		sql.setString(addrDto.getUserID()); //���� ���̵�
		sql.setString(addrDto.getvSearchType()); //�˻�����
		sql.setString(addrDto.getvSearch()); //�˻���
		sql.setInteger(addrDto.getnRow()); //����Ʈ ����
		sql.setInteger(addrDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����

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
	 * �ּҷ� ��� 
	 * @param addrDto �ּҷ� ����� ����
	 * @return retVal int
	 * @throws DAOException
	 */
	public int addrRegist(AddressDTO addrDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgAddressRegist ( ?, ?, ?, ?, ?, ?, ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
				
		sql.setString(addrDto.getUserID()); //�α��� ���� ���̵�
		sql.setString(addrDto.getAddressName()); //�ּҷ� ����� ��
		sql.setString(addrDto.getFaxNo()); //�ѽ���ȣ
		sql.setString(addrDto.getOfficePhone()); //�繫�� �Ǵ� �� ��ȭ��ȣ
		sql.setString(addrDto.getMobilePhone()); //�ڵ��� ��ȣ
		sql.setString(addrDto.getEmail()); //E-Mail
		sql.setString(addrDto.getMemo()); //�޸�
		
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
	 * �ּҷ� ������
	 * @param userid
	 * @return addrDto ����� ����
	 * @throws DAOException
	 */
	public AddressDTO addrView(AddressDTO addrDto) throws DAOException{

		String procedure = "{ CALL hp_mgAddressSelect ( ?,?,?,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid());    //�α׾��̵�
		sql.setSql(procedure);             //���ν��� ��
		sql.setInteger(addrDto.getSeq());  //���� �ε��� Ű
		System.out.println(addrDto.getSeq());
		sql.setString(addrDto.getUserID()); //����ڸ�
		System.out.println(addrDto.getUserID());
		sql.setString(addrDto.getFaxNo()); //�ѽ���ȣ
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
	* �ּҷ� �ѽ���ȣ �ߺ� üũ
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String addrDupCheck(AddressDTO addrDto) throws DAOException{

		String procedure = " { CALL hp_mgAddressSelect ( ? , ? , ?, ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(addrDto.getLogid());		//�α׾��̵�
		sql.setInteger(addrDto.getSeq());		//�ε����� ���� PK
		sql.setString(addrDto.getUserID());;    //����ڸ�
		sql.setString(addrDto.getFaxNo());		//�ѽ���ȣ
		sql.setString("DUPLICATE");				//SP����

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
	 * �ּҷ� ����� ���� ����
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int addrModify(AddressDTO addrDto) throws Exception{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_mgAddressModify (?,?,?,?,?,?,?,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setInteger(addrDto.getSeq());   //���� �ε��� Ű (PK)
		sql.setString(addrDto.getUserID()); //���� ���̵�(�ּҷ� ������ ���̵�)
		sql.setString(addrDto.getAddressName()); //�ּҷ� ����ڸ�
		sql.setString(addrDto.getFaxNo());   //�ѽ���ȣ
		sql.setString(addrDto.getOfficePhone()); //��,ȸ�� ��ȭ��ȣ
		sql.setString(addrDto.getMobilePhone()); //����� ��ȭ��ȣ
		sql.setString(addrDto.getEmail()); //�̸���
		sql.setString(addrDto.getMemo()); //�޸�

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
	 * �ּҷ� ����� ������ �����Ѵ�.(�ٰ�ó��)
	 * @param logid �α׾��̵�
	 * @param users_seq (check) SeqPk �迭
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
				
				batch.add(StringUtil.nvl(r_data[0],"")); 	//users_seq(Pk)���� �ε��� Ű
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
	 * �� �ּҷ� ���� Excel ����Ʈ.   
	 * @param  addrDto   �� �ּҷ� ����  ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO addressExcelList(AddressDTO addrDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_mgAddressInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();
		
		sql.setKey(addrDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		
		sql.setString(addrDto.getUserID()); //���� ���̵�
		sql.setString(addrDto.getvSearchType()); //�˻�����
		sql.setString(addrDto.getvSearch()); //�˻���
		sql.setInteger(addrDto.getnRow()); //����Ʈ ����
		sql.setInteger(addrDto.getnPage()); //���� ������
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
	 * ����� EXCEL import
	 * @param recordDto
	 * @return URL
	 * @throws Exception
	 */
	public  String addressListImport(ArrayList<AddressDTO> addrList,String filename){
		
		String importResult = "";
		//String importResult_Dao_Log= "";
		int successcnt=0;
		int failcnt=0;
		
		String log_userid="";       //����ID(����� ���)
		String log_addrname="";     //����ڸ�
		String log_faxno="";     //�ѽ���ȣ
		String log_officephone="";  //�� �Ǵ� ȸ�� ��ȭ��ȣ
		String log_mobilephone="";  //�޴��� ��ȣ
		String log_email=""; 		//�̸���
		String log_memo="";		    //�޸�
		
		String log_result="";		//��������
		String log_userAndfaxNoChk = ""; //����ڿ� �ѽ���ȣ �ߺ�üũ
		
		BufferedWriter out = null;
		
		int retVal = -1;

		try {
			//log���� ����
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

				log_userAndfaxNoChk=addrDupCheck(addrDto);//����� & �ѽ���ȣ �ߺ�üũ
			
				
				if(log_userAndfaxNoChk.equals("1")){
					
					log_result="��Ͻ���-�̹� �ּҷϿ� ��� ���ִ� ������Դϴ�. �� �ּҷ� �������� Ȯ�����ּ���.";
					failcnt++;
				
				}else if(log_userAndfaxNoChk.equals("0")){	
					log_result="��ϼ���-�� �ּҷ� �������� Ȯ�� ���ּ���.";
								
								
				//��� spȣ��κ�
				retVal = addrRegist(addrDto);

				if(retVal == -1){
					log_result = "��� ���� - SQL Error!!";
					failcnt++;
				}else if(retVal ==0){
					log_result = "��� ���� - ��� �ȵ�";
					failcnt++;
				}else{
					log_result = "��� ����  - ID : "+addrDto.getUserID();
					successcnt++;
				}
								
				}
	
			
				
				if(i==0){
					out.write("["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_faxno+"]"+"[RESULT : "+log_result+"]");
				}else{
					out.write("\n["+i+"][DATE : "+DateTimeUtil.getDate()+"]"+"[TIME : "+DateTimeUtil.getTime()+"]"+"[USERID : "+log_userid+"]"+"[DID : "+log_faxno+"]"+"[RESULT : "+log_result+"]");
				}
			}

				
			
			importResult=" �� : "+addrList.size()+"�� �� �����Ǽ� : "+successcnt+"�� ���аǼ� : "+failcnt+"�� \\n����α״� WAS���["+LOG_PATH+"] �� "+filename+".log ���Ͽ��� Ȯ�ΰ����մϴ�.";
				
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
