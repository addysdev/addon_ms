package com.web.webaction.history.action;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;
import com.web.framework.persist.ListDTO;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.BaseAction;
import com.web.common.history.LoginHistoryDAO;
import com.web.common.history.LoginHistoryDTO;

import com.web.common.user.UserBroker;
import com.web.common.user.UserDTO;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;

import com.web.framework.util.InJectionFilter;

public class HistoryAction extends StrutsDispatchAction{
	
	/**
	 * 로그인 이력 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward loginPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "loginPageList action start");
		
		String startDate = StringUtil.nvl(request.getParameter("startDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String endDate = StringUtil.nvl(request.getParameter("endDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		InJectionFilter inJectionFilter = new InJectionFilter();

		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
				BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 	
		
		LoginHistoryDAO loginHistoryDao = new LoginHistoryDAO();
		LoginHistoryDTO loginHistoryDto = new LoginHistoryDTO();
		
		loginHistoryDto.setLogid(logid);
		loginHistoryDto.setChUserID(USERID);
		loginHistoryDto.setFrDate(startDate);
		loginHistoryDto.setToDate(endDate);
		loginHistoryDto.setvSearchType(searchGb);
		loginHistoryDto.setvSearch(searchtxt);
		loginHistoryDto.setnRow(20);
		loginHistoryDto.setnPage(curPageCnt);
		loginHistoryDto.setJobGb("PAGE");
		
		ListDTO ld = loginHistoryDao.loginPageList(loginHistoryDto);
		
		model.put("listInfo",ld);	
		
		model.put("startDate",startDate);
		model.put("endDate",endDate);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "loginPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("loginPageList");
	}
	/**
	 * 로그인 이력 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward loginExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "loginExcelList action start");
		
		String startDate = StringUtil.nvl(request.getParameter("startDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String endDate = StringUtil.nvl(request.getParameter("endDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		InJectionFilter inJectionFilter = new InJectionFilter();
		
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 	
		
		LoginHistoryDAO loginHistoryDao = new LoginHistoryDAO();
		LoginHistoryDTO loginHistoryDto = new LoginHistoryDTO();
		
		loginHistoryDto.setLogid(logid);
		loginHistoryDto.setChUserID(USERID);
		loginHistoryDto.setFrDate(startDate);
		loginHistoryDto.setToDate(endDate);
		loginHistoryDto.setvSearchType(searchGb);
		loginHistoryDto.setvSearch(searchtxt);
		loginHistoryDto.setnRow(20);
		loginHistoryDto.setnPage(curPageCnt);
		loginHistoryDto.setJobGb("LIST");
		
		ListDTO ld = loginHistoryDao.loginExcelList(loginHistoryDto);
		
		model.put("listInfo",ld);	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "loginExcelList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("loginExcelList");
	}
	
}
