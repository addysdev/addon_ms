package com.web.webaction.config.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.common.BaseDAO;
import com.web.framework.persist.DAOException;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.SiteNavigation;
import com.web.framework.persist.ListDTO;
import com.web.framework.util.InJectionFilter;
import com.web.framework.Constants;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.user.UserBroker;
import com.web.common.util.CommonUtil;
import com.web.common.user.UserMemDTO;
import com.web.common.user.UserConnectDTO;
import com.web.common.user.UserDAO;
import com.web.common.user.UserDTO;
import com.web.common.CommonDAO;
import com.web.common.ComCodeDTO;

import com.web.common.config.AuthDAO;
import com.web.common.config.AuthDTO;
import com.web.common.config.MenuDTO;
import com.web.common.config.GroupDAO;
import com.web.common.config.GroupDTO;

public class AuthAction extends StrutsDispatchAction{
	/**
	 * 메뉴접근권한 페이지를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authManageList
	 * @throws Exception
	 */
	public ActionForward authManage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authManage action start");
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authManage action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authManage");
	}
	/**
	 * GROUP별 사용자 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authGroupTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authGroupTree action start");
		
		String userID = StringUtil.nvl(request.getParameter("UserID"),"");
		//String groupID = StringUtil.nvl(request.getParameter("groupID"),"");
		//String AuthID = StringUtil.nvl(request.getParameter("AuthID"),"");

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setUserID(userID);
		//groupDto.setGroupID(groupID);
		groupDto.setJobGb("GROUPUSER");

		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);

		model.put("grouplist",grouplist);
		//model.put("AuthID",AuthID);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authGroupTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authGroupTree");
	}
	/**
	 * 권한 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authTree action start");

		CommonDAO comDao = new CommonDAO();

		ArrayList<ComCodeDTO> authlist =comDao.getCodeList("14");

		model.put("authlist",authlist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authTree");
	}
	/**
	 * MENU 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authMenuTree
	 * @throws Exception
	 */
	public ActionForward authMenuTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authMenuTree action start");
		
		String userid = StringUtil.nvl(request.getParameter("userid"),"");
		
		AuthDAO authDao = new AuthDAO();
		AuthDTO authDto = new AuthDTO();
		
		authDto.setLogid(logid);
		authDto.setUserID(userid);
		//authDto.setAuthID(AuthID);

		ArrayList<MenuDTO> menulist = authDao.authMenuTree(authDto);
		
		model.put("menulist",menulist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authMenuTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authMenuTree");
	}
	/**
	 * 권한별 메뉴 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authMenuDetailTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authMenuDetailTree action start");
		
		String authid = StringUtil.nvl(request.getParameter("authid"),"");

		AuthDAO authDao = new AuthDAO();
		AuthDTO authDto = new AuthDTO();
		authDto.setLogid(logid);
		authDto.setAuthID(authid);
		
		ArrayList<MenuDTO> menulist =authDao.authMenuDetailTree(authDto);

		model.put("menulist",menulist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authMenuDetailTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userAuthMenuTree");
	}
	/**
	 * 사용자별 권한 메뉴 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward userAuthMenuTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userAuthMenuTree action start");
		
		String userID = StringUtil.nvl(request.getParameter("userid"),"");
		String AuthID = StringUtil.nvl(request.getParameter("AuthID"),"");

		AuthDAO authDao = new AuthDAO();
		AuthDTO authDto = new AuthDTO();
		UserDAO userDao =new UserDAO();
		UserDTO userDto =new UserDTO();
		
		authDto.setLogid(logid);
		authDto.setUserID(userID);
		authDto.setAuthID(AuthID);
		
		userDto.setLogid(logid);
		userDto.setUserID(userID);
		
		ArrayList<MenuDTO> menulist =authDao.userAuthMenuTree(authDto);
		
		userDto = userDao.userView(userDto);
		
		model.put("menulist",menulist);
		model.put("userDto",userDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userAuthMenuTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userAuthMenuTree");
	}
	/**
	 * 메뉴별 권한을 등록한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authMenuRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authRegist action start");
		
//		로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
			if(USERID.equals("")){
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
	//			로그인 처리 끝.

		
		int retVal=-1;
		int retVals =-1;
		String msg="";

		String[] authids = request.getParameterValues("users");
		String[] menus = request.getParameterValues("menus");

		AuthDAO authDao = new AuthDAO();

		retVal =authDao.authMenuDeletes(logid,USERID,authids);// 이전 등록내용이 있을경우 삭제한다.
		
		if(retVal==-1){
			msg="저장오류!";
			return alertAndExit(model,msg,request.getContextPath()+"/H_Auth.do?cmd=authManage","");	
		}

		retVals = authDao.authMenuRegists(logid,USERID,authids,menus); //새로운 권한 등록

		if(retVals==-1){
			msg="저장오류!";
		}else if(retVals==0){
			msg="저장실패!";
		}else{
			msg="저장완료!";
		}
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Auth.do?cmd=authManage","");	
	
	}
	/**
	 * 사용자별 권한을 등록한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authRegist action start");
		
//		로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
			if(USERID.equals("")){
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
	//			로그인 처리 끝.

		
		int retVal=-1;
		int retVals =-1;
		String msg="";

		String[] users = request.getParameterValues("users");
		String[] menus = request.getParameterValues("menus");

		AuthDAO authDao = new AuthDAO();

		retVal =authDao.authDeletes(logid,USERID,users);// 이전 등록내용이 있을경우 삭제한다.
		
		
		if(retVal==-1){
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print(retVals);
			
			return null;	
		}

		retVals = authDao.authRegists(logid,USERID,users,menus); //새로운 권한 등록

		if(retVals==-1){
			msg="저장오류!";
		}else if(retVals==0){
			msg="저장실패!";
		}else{
			msg="저장완료!";
		}
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(retVals);
		
		return null;	
		//return alertAndExit(model,msg,request.getContextPath()+"/H_Auth.do?cmd=authManage","");	
	
	}
}
