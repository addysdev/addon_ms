package com.web.webaction.user.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;



import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.persist.ListDTO;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.BaseAction;
import com.web.common.address.AddressDTO;
import com.web.common.config.GroupDAO;
import com.web.common.config.GroupDTO;
import com.web.common.user.UserDAO;
import com.web.common.user.UserDTO;
import com.web.common.user.UserBroker;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;
import com.web.webaction.user.action.UserAction;

import com.web.framework.util.ByTimestampFileRenamePolicy;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.InJectionFilter;

import com.web.framework.data.DataSet;
import com.oreilly.servlet.MultipartRequest;

public class UserAction extends StrutsDispatchAction{

	public static String UPLOAD_PATH = config.getString("framework.fileupload.temppath");
	/**
	 * 계정관리 관리 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward userPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userPageList action start");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		int searchTab = StringUtil.nvl(request.getParameter("searchTab"),1);
		
		InJectionFilter inJectionFilter = new InJectionFilter();
		
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}
		
		String vGroupID = StringUtil.nvl(request.getParameter("vGroupID"),"");
		String vInitYN=StringUtil.nvl(request.getParameter("vInitYN"),"N");
	
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();

		//리스트
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(20);
		userDto.setnPage(curPageCnt);
		userDto.setvGroupID(vGroupID);
		userDto.setvInitYN(vInitYN);
		userDto.setSearchTab(searchTab);
	    
		ListDTO ld = userDao.userPageList(userDto);
		
		//카운트 정보
		UserDTO userDtoCount = userDao.userTotCount(userDto);
		
		model.put("totalInfo", userDtoCount );
		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    model.put("searchTab", searchTab);
	    
	    model.put("vGroupID",vGroupID);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("userPageList");
   	}
	
	/**
	 * 계정 등록 폼 (동작없음-폼만 호출)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward userRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userRegistForm action start");
		
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

		return actionMapping.findForward("userRegistForm");
	 }
	
	/**
	 * 계정 등록
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userRegist action start");
		
		
		String UserName = StringUtil.nvl(request.getParameter("userName"),"");
		String UserID = StringUtil.nvl(request.getParameter("employeeID"),"");
		String Password = StringUtil.nvl(request.getParameter("Password"),"");
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		String OfficePhone = StringUtil.nvl(request.getParameter("OfficeTellNo"),"");
		String UseYN = StringUtil.nvl(request.getParameter("UseYN"),"");
		String Description = StringUtil.nvl(request.getParameter("Description"),"");

		HtmlXSSFilter filter = new HtmlXSSFilter(true);
		UserName=filter.htmlSpecialChars(UserName);
		UserID=filter.htmlSpecialChars(UserID);
		Password=filter.htmlSpecialChars(Password);

		String msg="";
		
		String encPasswd="";
	
		int retVal=0;

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		encPasswd=userDao.setPasswdEncode(Password);
	
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setUserName(UserName);
		userDto.setUserID(UserID);
		userDto.setGroupID(GroupID);
		userDto.setOfficePhone(OfficePhone);
		userDto.setPassword(encPasswd);
		userDto.setUseYN(UseYN);
		userDto.setCreateUserID(USERID);
		userDto.setDescription(Description);
		
		retVal=userDao.userRegist(userDto);

		if(retVal==-1){
			msg="시스템 오류입니다.!";
		}else if(retVal==0){
			msg="등록을 실패했습니다!";
		}else{
			msg="등록을 성공했습니다!.";
		}			
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_User.do?cmd=userPageList","");
		//return closePopupReload(model, msg,"","", request.getContextPath()+"/H_User.do?cmd=userPageList");
	}
	
	/**
	 * 계정 상세정보
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userModifyForm
	 * @throws Exception
	 */
	public ActionForward userModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userModifyForm action start");
		
		String UserID = StringUtil.nvl(request.getParameter("UserID"),"");
		String UserName = StringUtil.nvl(request.getParameter("UserName"),"");
		String Password = StringUtil.nvl(request.getParameter("Password"),"");
		String msg ="";
		
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setUserID(UserID);
		userDto.setUserName(UserName);
		userDto.setPassword(Password);
		
		userDto = userDao.userView(userDto);
		
		if(userDto == null){
			msg = "사용자 정보가 없습니다.";	
	    }
		
		model.put("userDto", userDto);
	    model.put("msg", msg);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("userModifyForm");
	}
	
	/**
	 * 계정 정보를 수정한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userModify action start");
		
		
		String UserName = StringUtil.nvl(request.getParameter("userName"),"");
		String UserID = StringUtil.nvl(request.getParameter("employeeID"),"");
		String Password = StringUtil.nvl(request.getParameter("Password"),"");
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		String OfficePhone = StringUtil.nvl(request.getParameter("OfficeTellNo"),"");
		String UseYN = StringUtil.nvl(request.getParameter("UseYN"),"");

		HtmlXSSFilter filter = new HtmlXSSFilter(true);
		UserName=filter.htmlSpecialChars(UserName);
		UserID=filter.htmlSpecialChars(UserID);
		//ori_ID=filter.htmlSpecialChars(ori_ID);
		Password=filter.htmlSpecialChars(Password);

		String msg="";
		
		String encPasswd="";
	
		int retVal=0;

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		if(Password != ""){
			encPasswd=userDao.setPasswdEncode(Password);
		}
		
		
		System.out.println(encPasswd+"비번");
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setUserName(UserName);
		userDto.setUserID(UserID);
		userDto.setGroupID(GroupID);
		userDto.setOfficePhone(OfficePhone);
		userDto.setPassword(encPasswd);
		userDto.setUseYN(UseYN);
		userDto.setCreateUserID(USERID);
		
		retVal=userDao.userModify(userDto);
		
		if(retVal==-1){
			msg="수정오류!";
		}else if(retVal==0){
			msg="수정실패!";
		}else{
			msg="수정완료!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_User.do?cmd=userPageList","");
		//return closePopupReload(model, msg,"","", request.getContextPath()+"/H_User.do?cmd=userPageList");
	}
	/**
	 * 계정 정보를 삭제한다.(다건)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userDeletes(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userDeletes action start");
		
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.

		int retVal=-1;
		String msg="";
		
		String[] users = request.getParameterValues("seqs");
		UserDAO userDao = new UserDAO();

		retVal = userDao.userDeletes(logid,users, USERID);
		
		if(retVal==-1){
			msg="삭제오류!";
		}else if(retVal==0){
			msg="삭제실패!";
		}else{
			msg="삭제완료!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_User.do?cmd=userPageList","");	
		
	}
	
	/**
	 * 계정 정보 EXCEL EXPORT
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userExcelList
	 * @throws Exception
	 */
	public ActionForward userExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userExcelList action start");

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	    String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	    int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	    
		String vGroupID = StringUtil.nvl(request.getParameter("vGroupID"),"");
	    
	    InJectionFilter inJectionFilter = new InJectionFilter();
		
	    if(!"".equals(searchtxt.trim())){	        	
	    	searchtxt=inJectionFilter.filter(searchtxt.trim());
	    }
	
	    UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();

		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(10);
		userDto.setnPage(curPageCnt);
		
		ListDTO ld = userDao.userExcelList(userDto);
		
		model.put("listInfo",ld);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userExcelList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userExcelList");
	}
	
	/**
	 * 사용자 중복체크
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userXML
	 * @throws Exception
	 */
	public ActionForward userDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userDupCheck action start");
		
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		String UserID = StringUtil.nvl(request.getParameter("userid"),"");

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();

		userDto.setLogid(logid);
		userDto.setUserID(UserID);
		userDto.setChUserID(USERID);
		
		String result = userDao.userDupCheck(userDto, "DUPLICATE");
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(result);
		
		//model.put("result", result );
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return null;
	  //return actionMapping.findForward("userXML");
	}
	
	/**
	 * Group 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupTreeList
	 * @throws Exception
	 */
	public ActionForward userGroupTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userGroupTree action start");
		
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		String GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),"1");
		String FormName = StringUtil.nvl(request.getParameter("FormName"),"");
		String PopName = StringUtil.nvl(request.getParameter("PopName"),"");

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		groupDto.setJobGb("LIST");

		ArrayList<GroupDTO> grouplist = groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",GroupID);
		model.put("GroupStep",GroupStep);
		model.put("FormName", FormName);
		model.put("PopName", PopName);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userGroupTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userGroupTree");
	}
	
	
	/**
	 * GroupAuth 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupTreeList
	 * @throws Exception
	 */
	public ActionForward userSearchAuthTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userSearchAuthTree action start");
		
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		String GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),"1");
		String FormName = StringUtil.nvl(request.getParameter("FormName"),"");
		String UserID = StringUtil.nvl(request.getParameter("UserID"),"");
		
		
		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		groupDto.setJobGb("AUTHLIST");
		groupDto.setUserID(UserID);

		ArrayList<GroupDTO> grouplist = groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",GroupID);
		model.put("GroupStep",GroupStep);
		model.put("FormName", FormName);
		model.put("UserID", UserID);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userSearchAuthTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		return actionMapping.findForward("userSearchAuthTree");
	}
	
	/**
	 * 사용 가능한 FaxNum 리스트를 가져온다.
	 * @param <AddressDTo>
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupTreeList
	 * @throws Exception
	 */
	public <AddressDTo> ActionForward userFaxNumList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userFaxNumList action start");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		String GroupID 		= StringUtil.nvl(request.getParameter("GroupID"),"");
		String searchGb 	= StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt 	= StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt 		= StringUtil.nvl(request.getParameter("curPage"),1);
		String formName 	= StringUtil.nvl(request.getParameter("FormName"),"");
		
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setGroupID(GroupID);
		userDto.setSearchGb(searchGb);
		userDto.setSearchTxt(searchtxt);
		userDto.setnRow(5);
		userDto.setnPage(curPageCnt);
		
		
		ListDTO faxlist = userDao.userFaxNumList(userDto);
		
		model.put("faxlist",faxlist);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    model.put("FormName", formName);
	    model.put("GroupID", GroupID);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userFaxNumList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		return actionMapping.findForward("userFaxNumList");
	}
	
	
	
	/**
	 * 계정 EXCEL등록 폼 (동작없음-폼만 호출)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward userExcelForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userExcelForm action start");
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userExcelForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("userExcelForm");
	 }
	
	
	/**
	 * 사용자 정보 초기세팅(EXCEL)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception 
	 */
	public ActionForward userExcelImport(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userExcelImport action start");
		
		String USERID = UserBroker.getUserId(request);
		String msg = "";

		
		ArrayList<UserDTO> userList =new ArrayList();
	    
		MultipartRequest multipartRequest = new MultipartRequest( request,UPLOAD_PATH, 500*1024*1000, "euc-kr", new ByTimestampFileRenamePolicy());	
		
		File file=multipartRequest.getFile("userFile");
		String fileName=file.getName();
		int exeindex = fileName.indexOf(".");
		fileName=fileName.substring(0,exeindex-1);

		try{
			Workbook workbook = Workbook.getWorkbook(file);
			
			Sheet sheet = workbook.getSheet(0);
		    Cell myCell = null;
		    System.out.println("엑셀 총 로우 : "+sheet.getRows());
		    for(int h=4; h<sheet.getRows(); h++){
		    	UserDTO userDto = new UserDTO();
		    	String[] sItemTmp = new String[6]; 
		        for(int i=0;i<6;i++){
		           myCell = sheet.getCell(i+1,h); 
		           sItemTmp[i] = myCell.getContents(); 
		        }
		        
		        //빈칸인지 아닌지 체크
		        if(sItemTmp[0] != ""){

		        	userDto.setLogid(logid);
					userDto.setChUserID(USERID); //세션ID
					userDto.setUserName(sItemTmp[0]); //사용자명
					userDto.setUserID(sItemTmp[1]); //사용자ID
					userDto.setOfficePhone(sItemTmp[2]); //전화번호
					userDto.setGroupID(sItemTmp[3]); //그룹코드
					userDto.setUseYN(sItemTmp[4]); //사용여부
					userDto.setPassword(sItemTmp[5]); //비밀번호
					
			        userList.add(userDto);
		        }
		       
		    }
		    
		}catch (Exception e) {
			
			 msg = "업로드를 실패했습니다.\\n업로드 양식에 맞는 데이타인지 확인하세요!!";

		    //log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return alertAndExit(model,msg,request.getContextPath()+"/H_User.do?cmd=userPageList","");
			
		}
		
	    UserDAO userDao = new UserDAO();
	    
	    String importResult=userDao.userListImport(userList,fileName);
	    //백업DB 처리
	   // String bakImportResult=userDao.userListBackImport(userList,fileName);
			
	    //model.put("importResult", importResult);
	    //model.put("bakImportResult", bakImportResult);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		msg = importResult;
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_User.do?cmd=userPageList","");
	    //return actionMapping.findForward("userPageList");
	}
	
	/**
	 * 해당 user의 Fax번호를 가져온다.
	 * @param <AddressDTo>
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupTreeList
	 * @throws Exception
	 */
	public <AddressDTo> ActionForward userFaxNumInfo(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userFaxNumInfo action start");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		//String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		//String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		//int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		//String formName = StringUtil.nvl(request.getParameter("FormName"),"");
		String UserID = StringUtil.nvl(request.getParameter("UserID"),"");
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		//userDto.setSearchGb(searchGb);
		//userDto.setSearchTxt(searchtxt);
		//userDto.setnRow(5);
		//userDto.setnPage(curPageCnt);
		userDto.setUserID(UserID);
		
		
		ListDTO faxlist = userDao.userFaxNumInfo(userDto);
		
		model.put("faxlist",faxlist);
		model.put("UserID", UserID);
		model.put("GroupID", GroupID);
		//model.put("curPage",String.valueOf(curPageCnt));
	    //model.put("searchGb",searchGb);
	    //model.put("searchtxt",searchtxt);
	    //model.put("FormName", formName);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userFaxNumInfo action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		return actionMapping.findForward("userFaxNumInfo");
	}
	
	
	
	/**
	 * user 팩스번호 삭제
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception
	 */
	public ActionForward userDeleteFaxNum(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userDeleteFaxNum action start");
		
		String UserID		= StringUtil.nvl(request.getParameter("UserID"),"");
		String DID 			= StringUtil.nvl(request.getParameter("DID"),"");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		UserDAO userDao = new UserDAO();
		UserDTO  userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setUserID(UserID);
		userDto.setDID(DID);
		
		userDto.setLogid(logid);
		userDto.setGroupID(UserID);
		
		//DIDinfo 테이블에 Update
		int retVal = 0;
		retVal=userDao.userDeleteFaxNum(userDto);
		
		
		if(retVal !=1){
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print(retVal);
			
			return null;
		}else{
			//FaxInfo 가져오기
			ListDTO faxlist = userDao.userFaxNumInfo(userDto);
			
			model.put("faxlist",faxlist);
			model.put("UserID",UserID);
			//model.put("GroupStep",""+GroupStep);
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userDeleteFaxNum action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return actionMapping.findForward("userFaxNumInfo");
		}
		
	}
	
	
	/**
	 * user 팩스번호 등록
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception
	 */
	public ActionForward userRegistFaxNum(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userRegistFaxNum action start");
		
		String UserID		= StringUtil.nvl(request.getParameter("UserID"),"");
		String DID 			= StringUtil.nvl(request.getParameter("DID"),"");
		String AlarmYN 		= StringUtil.nvl(request.getParameter("AlarmYN"),"");
		String EchoYN	= StringUtil.nvl(request.getParameter("EchoYN"),"");
		
		/*System.out.println("GroupID : "+ GroupID);
		System.out.println("DID : "+ DID);
		System.out.println("AlarmYN : "+ AlarmYN);
		System.out.println("CallBackYN : "+ CallBackYN);*/
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		
		UserDAO  userDao = new UserDAO();
		UserDTO  userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setUserID(UserID);
		userDto.setDID(DID);
		userDto.setAlarmYN(AlarmYN);
		userDto.setEchoYN(EchoYN);
		
		
		//DIDinfo 테이블에 Insert
		int retVal = 0;
		retVal=userDao.userRegistFaxNum(userDto);
		
		
		if(retVal !=1){
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print(retVal);
			
			return null;
		}else{
			//FaxInfo 가져오기
			ListDTO faxlist = userDao.userFaxNumInfo(userDto);
			
			model.put("faxlist",faxlist);
			model.put("UserID",UserID);
			//model.put("GroupStep",""+GroupStep);
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userRegistFaxNum action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return actionMapping.findForward("userFaxNumInfo");
		}
		
	}
	
	
	
	/**
	 * user 팩스번호에 대한 정보 변경
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception
	 */
	public ActionForward changeDIDInfo(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "changeDIDInfo action start");
		
		String UserID		= StringUtil.nvl(request.getParameter("UserID"),"");
		String DID 			= StringUtil.nvl(request.getParameter("DID"),"");
		String AlarmYN 		= StringUtil.nvl(request.getParameter("AlarmYN"),"");
		String EchoYN	= StringUtil.nvl(request.getParameter("EchoYN"),"");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		UserDAO  userDao = new UserDAO();
		UserDTO  userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setUserID(UserID);
		userDto.setDID(DID);
		userDto.setAlarmYN(AlarmYN);
		userDto.setEchoYN(EchoYN);
		
		
		//DIDinfo 테이블에 Update
		int retVal = 0;
		retVal=userDao.changeDIDInfo(userDto);
		
		
		if(retVal !=1){
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print(retVal);
			
			return null;
		}else{
			//FaxInfo 가져오기
			ListDTO faxlist = userDao.userFaxNumInfo(userDto);
			
			model.put("faxlist",faxlist);
			model.put("UserID",UserID);
			//model.put("GroupStep",""+GroupStep);
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "changeDIDInfo action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return actionMapping.findForward("userFaxNumInfo");
		}
		
	}
	
	
	
	
	
}
