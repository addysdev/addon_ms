package com.web.webaction.common.action;

import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.SocketException;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.data.DataSet;
import com.web.framework.persist.ListDTO;
import com.web.framework.struts.StrutsDispatchAction;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.FtpUtil;
import com.web.framework.util.InJectionFilter;
import com.web.framework.util.StringUtil;

import com.web.common.CommonDAO;
import com.web.common.user.UserDAO;
import com.web.common.user.UserDTO;
import com.web.common.user.UserBroker;
import com.web.common.util.DateUtil;
import com.web.common.config.GroupDAO;
import com.web.common.config.GroupDTO;
import com.web.common.BaseAction;
import com.web.common.StateDTO;


public class CommonAction extends StrutsDispatchAction{

	public static String NAS_PATH = config.getString("framework.nas.path");
	public static String TEMP_PATH = config.getString("framework.tempimage.path");
	
	/**
	 * ���� ������ ���� ó��
	 */
	public CommonAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * ��� ������ ȣ��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward top(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//��� top ������
	
		return actionMapping.findForward("top");
	}
	/**
	 * �ʱ������� ȣ��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward initPage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		String initUrl = StringUtil.nvl(request.getParameter("initUrl"),"");
	    String startDate=StringUtil.nvl(request.getParameter("startDate"),"");
	    String endDate=StringUtil.nvl(request.getParameter("endDate"),"");
		
		
		model.put("initUrl",initUrl);
		model.put("startDate",startDate);
		model.put("endDate",endDate);
	
		return actionMapping.findForward("initPage");
	}
	
	/**
	 * �ٿ�ε� ������ ȣ��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward downLoadForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		return actionMapping.findForward("downLoadForm");
	}
	/**
	 * ��ܼ��� �� ��ó���Ǽ�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward inboundState(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "inboundState action start");

		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		
		CommonDAO comDao=new CommonDAO();
		StateDTO stateDto=new StateDTO();

		stateDto.setUserID(USERID);
		
		stateDto=comDao.inboundState(stateDto);
		
		model.put("stateDto",stateDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "inboundState action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
		return actionMapping.findForward("inStateXML");
	}
	
	/**
	 * ����ȭ��Ǽ��� ���������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward inboundMainState(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "inboundState action start");

		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		
		CommonDAO comDao=new CommonDAO();
		StateDTO stateDto=new StateDTO();
		
		stateDto.setUserID(USERID);
		
		//stateDto=comDao.inboundState(stateDto);
		
		model.put("stateDto",stateDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "inboundState action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
		return actionMapping.findForward("MainXML");
	}
	
	
	/**
	 * ����� �˻� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward userSearchList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userSearch action start");
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
			
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
	  
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(10);
		userDto.setnPage(curPageCnt); 

		ListDTO ld = userDao.userPageList(userDto);
		
	    model.put("listInfo",ld);
	   
	    model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt); 
	    
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userSearchList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		  
		return actionMapping.findForward("userSearchList");
	}
	
	/**
	 * My Info ����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward userInfoModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userInfoModifyForm action start");

		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setUserID(USERID);
		
		userDto = userDao.userView(userDto);
		
		if(userDto == null){
			msg = "����� ������ �����ϴ�.";	
	    }
		
		model.put("userDto", userDto);
	    model.put("msg", msg);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userInfoModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("userInfoModifyForm");
	}
	
	/**
	 * My Info ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userInfoModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userInfoModify action start");
		
		String USERID = UserBroker.getUserId(request);
		String ID = StringUtil.nvl(request.getParameter("ID"),"");

//		�α��� ó�� 

		if(USERID.equals("") || (!USERID.equals(ID))){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			�α��� ó�� ��.
		
		
		CommonDAO commDao = new CommonDAO();
		UserDTO userDto = new UserDTO();
		UserDAO userDao = new UserDAO();
		
		userDto.setLogid(logid);
		userDto.setUserID(USERID);
		
		//���� �������� �����´�.
		userDto = userDao.userView(userDto);
		
		String Ori_Password = StringUtil.nvl(request.getParameter("Ori_Password"),"");
		
		//���ڵ�
		Ori_Password=userDao.setPasswdEncode(Ori_Password);
		
		if(userDto.getPassword().equals(Ori_Password)){
			String Password = StringUtil.nvl(request.getParameter("Password"),"");

			

			int retVal=0;
			String msg="";
			
			
			userDto.setLogid(logid);
			userDto.setUserID(USERID);
			
			Password=userDao.setPasswdEncode(Password);
			
			userDto.setPassword(Password);
			
			
			retVal=commDao.userModify(userDto);
			
			if(retVal==-1){
				msg="��������!";
			}else if(retVal==0){
				msg="��������!";
			}else{
				msg="�����Ϸ�!";
				
			}
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userInfoModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return alertPopupClose(model, msg,"");
		}else{ //���� ��й�ȣ�� �ٸ����
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userInfoModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

			String msg="���� ��й�ȣ�� �ٸ��ϴ�.";
			
			model.put("userDto", userDto);
			
			return alertAndExit(model, msg,request.getContextPath()+"/H_Common.do?cmd=userInfoModifyForm","");
			//return alertPopupClose(model, msg,"");
		}
	}
	
	
	/**
	 * Group ���� �������� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward authFrame(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//���� �������� �����´�.
		
		return actionMapping.findForward("authFrame");
	}
	/**
	 * Group ���� ����Ʈ�� �����´�. (�ѽ���ȸ ������ �������ֱ� ���� �׷�Ʈ�� ����Ʈ-���α����� ���Ե�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authTreeList
	 * @throws Exception
	 */
	public ActionForward authTreeList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupTreeList action start");
		
		String groupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		int groupStep = StringUtil.nvl(request.getParameter("GroupStep"),0);

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(groupID);
		groupDto.setGroupStep(groupStep);
		groupDto.setJobGb("AUTHLIST");
		
		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",groupID);
		model.put("GroupStep",""+groupStep);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authTreeList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authTreeList");
	}
	/**
	 * ����� ��ȸ �������� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward userFrame(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//����� ��ȸ �������� �����´�.
		
		return actionMapping.findForward("userFrame");
	}
	/**
	 * �׷캰 ����� ����Ʈ�� �����´�. (�׷� ����� Ʈ������ ����� �˻� ��� Ʈ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userTreeList
	 * @throws Exception
	 */
	public ActionForward userTreeList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userTreeList action start");
		
		String userID = StringUtil.nvl(request.getParameter("UserID"),"");

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setUserID(userID);
		groupDto.setJobGb("GROUPUSER");
		
		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userTreeList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userTreeList");
	}
	
	/**
	 * ���� �׷� ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return faxNoList
	 * @throws Exception
	 */
	public ActionForward groupComboList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupComboList action start");
		
		String groupid = StringUtil.nvl(request.getParameter("groupid"),"");
		
		CommonDAO commonDao = new CommonDAO();
		
		ListDTO ld = commonDao.groupAuthList(logid,groupid);

		model.put("listInfo",ld);	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupComboList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupListXML");
	}

	/**
	 * ���� �׷� ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return faxNoList
	 * @throws Exception
	 */
	public ActionForward SearchReciveResultTypeGroup(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "SearchReciveResultTypeGroup action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.

		String CodeGroupID = StringUtil.nvl(request.getParameter("codegroupid"),"");

		log.trace(logid, "SearchReciveResultTypeGroup codegroupid " + CodeGroupID );
		
		
		CommonDAO commonDao = new CommonDAO();
		
		//ListDTO ld = commonDao.SearchReciveResultTypeList( logid, CodeGroupID );

		//model.put("listInfo",ld);	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "SearchReciveResultTypeGroup action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("SearchReciveResultTypeGroupXML");
	}

	
	/**
	 * Group ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupSelectTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupSelectTree action start");
		
		String groupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		int groupStep = StringUtil.nvl(request.getParameter("GroupStep"),0);

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(groupID);
		groupDto.setGroupStep(groupStep);
		groupDto.setJobGb("LIST");
		
		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",groupID);
		model.put("GroupStep",""+groupStep);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupSelectTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupSelectTree");
	}
	
	/**
	 * AuthGroup ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward authGroupSelectTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
	//log action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "SearchReciveResultTypeGroup action start");
			
			//�α��� ó�� 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			//�α��� ó�� ��.

		String authid = StringUtil.nvl(request.getParameter("authid"),"G00001");
		int AuthGroupStep = StringUtil.nvl(request.getParameter("AuthGroupStep"),1);
		String Gubun = StringUtil.nvl(request.getParameter("Gubun"),"");

		GroupDAO authGroupDao = new GroupDAO();
		GroupDTO authGroupDto = new GroupDTO();
		
		authGroupDto.setLogid(logid);
		authGroupDto.setChUserID(USERID);
		authGroupDto.setGroupID(authid);
		authGroupDto.setGroupStep(AuthGroupStep);
		authGroupDto.setJobGb("SUBAUTH");
		
		ArrayList<GroupDTO> grouplist =authGroupDao.groupTreeList(authGroupDto);
		
		model.put("grouplist",grouplist);
		model.put("AuthGroupID",authGroupDto);
		model.put("AuthGroupStep",""+AuthGroupStep);
		model.put("Gubun",Gubun);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authGroupSelectTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authGroupSelectTree");
	}

	/**
	 * �����/�׷� ��ȸ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward searchMain(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "searchMain action start");

		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "searchMain action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("searchMain");
	}
	/**
	 * �׷� ��ȸ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward searchGroupTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "searchGroupTree action start");

		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		String GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),"1");

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		groupDto.setJobGb("LIST");

		ArrayList<GroupDTO> grouplist = groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",GroupID);
		model.put("GroupStep",GroupStep);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "searchGroupTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("searchGroupTree");
	}
	/**
	 * ����� ��ȸ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward searchUserList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "searchUserList action start");

		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
		
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

		//����Ʈ
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(5);
		userDto.setnPage(curPageCnt);
		userDto.setvGroupID(vGroupID);
		userDto.setvInitYN(vInitYN);
		userDto.setSearchTab(searchTab);
	    
		ListDTO ld = userDao.userPageList(userDto);
		
		//ī��Ʈ ����
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
		log.trace(logid, "searchUserList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("searchUserList");
	}
	
}