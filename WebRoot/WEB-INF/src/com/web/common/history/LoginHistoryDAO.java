package com.web.common.history;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;

import org.apache.commons.lang.StringUtils;

import com.web.framework.data.DataSet;
import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;
import com.web.framework.persist.AbstractDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.persist.ListDTO;
import com.web.framework.persist.ListStatement;
import com.web.framework.persist.QueryStatement;
import com.web.common.history.LoginHistoryDTO;

public class LoginHistoryDAO extends AbstractDAO {
	/**
	 * �α��� �̷� ����Ʈ.   
	 * @param loginHistoryDto   �˻� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO loginPageList(LoginHistoryDTO loginHistoryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_hsLoginListInquiry ( ? , ? , ? , ? , ? , ?, ? , ?) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(loginHistoryDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(""); //���� ���̵�
		sql.setString(loginHistoryDto.getFrDate()); //�˻�������
		sql.setString(loginHistoryDto.getToDate()); //�˻�������
		sql.setString(loginHistoryDto.getvSearchType()); //�˻�����
		sql.setString(loginHistoryDto.getvSearch()); //�˻���
		sql.setInteger(loginHistoryDto.getnRow()); //����Ʈ ����
		sql.setInteger(loginHistoryDto.getnPage()); //���� ������
		sql.setString(loginHistoryDto.getJobGb()); //sp ����

		try{
			retVal=broker.executePageProcedure(sql,loginHistoryDto.getnPage(),loginHistoryDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	/**
	 * �α��� �̷� ����Ʈ. (Excel)  
	 * @param loginHistoryDto   �˻� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO loginExcelList(LoginHistoryDTO loginHistoryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_hsLoginListInquiry ( ? , ? , ? , ? , ? , ?, ? , ?) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(loginHistoryDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(""); //���� ���̵�
		sql.setString(loginHistoryDto.getFrDate()); //�˻�������
		sql.setString(loginHistoryDto.getToDate()); //�˻�������
		sql.setString(loginHistoryDto.getvSearchType()); //�˻�����
		sql.setString(loginHistoryDto.getvSearch()); //�˻���
		sql.setInteger(loginHistoryDto.getnRow()); //����Ʈ ����
		sql.setInteger(loginHistoryDto.getnPage()); //���� ������
		sql.setString(loginHistoryDto.getJobGb()); //sp ����

		try{
			retVal=broker.executeListProcedure(sql);
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
}