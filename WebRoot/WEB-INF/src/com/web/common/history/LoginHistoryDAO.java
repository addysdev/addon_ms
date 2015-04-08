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
	 * 로그인 이력 리스트.   
	 * @param loginHistoryDto   검색 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO loginPageList(LoginHistoryDTO loginHistoryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_hsLoginListInquiry ( ? , ? , ? , ? , ? , ?, ? , ?) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(loginHistoryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(""); //세션 아이디
		sql.setString(loginHistoryDto.getFrDate()); //검색시작일
		sql.setString(loginHistoryDto.getToDate()); //검색종료일
		sql.setString(loginHistoryDto.getvSearchType()); //검색구분
		sql.setString(loginHistoryDto.getvSearch()); //검색어
		sql.setInteger(loginHistoryDto.getnRow()); //리스트 갯수
		sql.setInteger(loginHistoryDto.getnPage()); //현제 페이지
		sql.setString(loginHistoryDto.getJobGb()); //sp 구분

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
	 * 로그인 이력 리스트. (Excel)  
	 * @param loginHistoryDto   검색 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO loginExcelList(LoginHistoryDTO loginHistoryDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp_hsLoginListInquiry ( ? , ? , ? , ? , ? , ?, ? , ?) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(loginHistoryDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(""); //세션 아이디
		sql.setString(loginHistoryDto.getFrDate()); //검색시작일
		sql.setString(loginHistoryDto.getToDate()); //검색종료일
		sql.setString(loginHistoryDto.getvSearchType()); //검색구분
		sql.setString(loginHistoryDto.getvSearch()); //검색어
		sql.setInteger(loginHistoryDto.getnRow()); //리스트 갯수
		sql.setInteger(loginHistoryDto.getnPage()); //현제 페이지
		sql.setString(loginHistoryDto.getJobGb()); //sp 구분

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