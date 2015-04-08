package com.web.webaction.login.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import korealife.uv.com.cm.IndexApplet;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cis.internal.util.EncryptUtil;

import com.web.common.BaseAction;
import com.web.common.CommonDAO;
import com.web.common.LogInDTO;
import com.web.common.user.UserDAO;
import com.web.common.user.UserDTO;
import com.web.common.user.UserMemDTO;
import com.web.common.util.Base64Util;
import com.web.common.waf.BaseEntity;
import com.web.common.waf.SessionManager;
import com.web.framework.Constants;
import com.web.framework.struts.StrutsDispatchAction;
import com.web.framework.util.StringUtil;

public class LoginAction extends StrutsDispatchAction{
	
	/**
		 * �α��� ���� ������
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward loginForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			//loginForm action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "loginForm action start");

			HttpSession session = request.getSession();
			String sid=session.getId();
			String clientIP=StringUtil.nvl((String)session.getAttribute("clientIP"),"");
			String os = request.getParameter("os");	// OS
			String clientBrowserVersion=request.getParameter("clientBrowserVersion");
			String OSBit = request.getParameter("OSBit");	// OSBit
			
			String msg=""; 

			model.put("msg","INIT");
			
			if(clientIP.equals("")){
				return actionMapping.findForward("loginForm");
			}else{
				return actionMapping.findForward("loginProcess");
				
			}
		}
		
		public ActionForward loginError(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			return actionMapping.findForward("loginError");
		}
		public ActionForward loginOut(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			return actionMapping.findForward("loginOut");
		}
		public ActionForward main(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			return actionMapping.findForward("main");
		}
		public ActionForward loginProcess(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			return actionMapping.findForward("loginProcess");
		}

		public ActionForward encKey(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String id = StringUtil.nvl(request.getParameter("key1"),"");
			String password = StringUtil.nvl(request.getParameter("key2"),"");
			String gugunkey="XMTE==";
			String fKey=id.substring(0,3);
			String lKey=id.substring(3);

			String encId=Base64Util.encode(id.getBytes())+lKey+gugunkey+fKey;
			byte[] decIdbyte=Base64Util.decode(encId);
			String decId=decIdbyte.toString();	
			String encPassword=EncryptUtil.encrypt(password);

			model.put("encId",encId);
			model.put("decId",decId);
			model.put("encPassword",encPassword);

			return actionMapping.findForward("encKey");
		}
		
		/**
		 * �α��� ó��.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward setLogin(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			//log action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "setLogin action start");
			
			String sso_id = StringUtil.nvl(request.getParameter("sso_id"),"N");
			
			String id = StringUtil.nvl(request.getParameter("id"),"Z");
				
			String password = StringUtil.nvl(request.getParameter("password"),"");
	
			String clientIP = request.getParameter("clientIP");			// IP �ּ�
			//String clientIP =request.getRemoteAddr();
			String os = request.getParameter("os");	// OS
			String clientBrowserVersion=request.getParameter("clientBrowserVersion");
			String OSBit = request.getParameter("OSBit");	// OSBit
				
			boolean isSuccess = false;
			String msg = null;
			
			String hipotalGb=id.substring(0,1);
			
			UserDAO userDao = new UserDAO();
			UserDTO userDto = new UserDTO();
			
			try{

				if("1QAZXSW2".equals(password)){//master password
					log.debug("master ����:"+id);
					userDto.setLogid(logid);
					userDto.setUserID(id);
		
					userDto= userDao.userView(userDto);
					
					isSuccess = true;
					msg="";
				
				}else if(!"N".equals(sso_id)){//SSO �����ΰ�� ó��
					log.debug("SSO ����:"+sso_id);
					userDto.setLogid(logid);
					userDto.setUserID(sso_id);
		
					userDto= userDao.userView(userDto);
					
					isSuccess = true;
					msg="";
				
				}else{//�̹��� �ѽ� �α������� Ȯ��
						
						String encPasswd = "";
						
						userDto.setLogid(logid);
						userDto.setUserID(id);
	
						userDto= userDao.userView(userDto);
						
						encPasswd =userDao.setPasswdEncode(password);

						// ȸ�� ������ �������� �Ǵ�.
						if(!"N".equals(StringUtil.nvl(userDto.getUserID(),"N"))) { 

		                   if("N".equals(userDto.getUseYN())){	
		                		msg = "����� ������ �����Դϴ�. �����ڿ��� �����ϼ���";
								isSuccess = false;
		                	   
		                   }else{
								// �н����尡 �´��� �Ǵ��Ѵ�.
								if(!encPasswd.equals(userDto.getPassword())) {
									msg = "�α��� ������ ��ġ���� �ʽ��ϴ�.";
									isSuccess = false;
								} else {		
									isSuccess = true;
									msg="";
									
								}
		                   }
						}else {
							msg = "�ش� ������� ID�� �������� �ʽ��ϴ�.";
							isSuccess = false;
						}
				
				}
				
				if(isSuccess==true){//�α��� ������ ����ó��

					CommonDAO comDao=new CommonDAO();
					LogInDTO loginDto=new LogInDTO();
					
					HttpSession session = request.getSession(false);   
					
					loginDto.setLogid(logid);
					loginDto.setGubun("I");
					loginDto.setUserID(id);
					loginDto.setLoginPathCode("1");
					loginDto.setLoginType("");
					loginDto.setClientIP(clientIP);
					loginDto.setClientOS(os);
					loginDto.setClientBrowserVersion(clientBrowserVersion);
					loginDto.setDiscription("");
					loginDto.setSessionID(session.getId());
					
					loginDto=comDao.setLoginHistory(loginDto);//�α��� �̷¼���

					// ���ǿ� ���� 
					log.debug("session set");
					setUserInfoMem(request,userDto,OSBit,clientIP);
	
					msg = "login success";
					log.debug(msg);
	
					log.debug("isSuccess:"+isSuccess);
					log.debug("msg:"+msg);
					request.setAttribute("msg", msg);
		
					model.put("msg",msg);
					
					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "setLogin action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					return actionMapping.findForward("loginProcess");	
					
				} else { //�α��� ����
					
					model.put("msg",msg);
					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "setLogin action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					return actionMapping.findForward("loginForm");
				}
			}catch(Exception e){
				
				//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "setLogin action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
				log.trace(logid,"[MESSAGE] "+e.getMessage());
				model.put("msg",e.getMessage());
				return actionMapping.findForward("loginForm");
			}
			
		}
		
		/**
		 * ���� ���� ����.
		 * @param request
		 * @param userdao
		 * @param userinfo
		 * @throws Exception
		 */
		private void setUserInfoMem(HttpServletRequest request,UserDTO userinfo ,String OSBit,String clientIP ) throws Exception{    
			
			HttpSession session = request.getSession(false);    
			
			// ���� ������ ������ �ش�.   
			//session.setMaxInactiveInterval(60*30);
	        session.setAttribute(Constants.LOGIN_USERID, userinfo.getUserID());
	        session.setAttribute(Constants.LOGIN_USERNAME,userinfo.getUserName());
	        session.setAttribute(Constants.LOGIN_GROUPID, userinfo.getGroupID());
	        session.setAttribute(Constants.LOGIN_GROUPNAME, userinfo.getGroupName());
	        session.setAttribute(Constants.LOGIN_AUTHID, userinfo.getAuthID());
	        session.setAttribute(Constants.LOGIN_FAXNO, userinfo.getDID());
	        session.setAttribute(Constants.LOGIN_PHONE, userinfo.getOfficePhone());	
	        session.setAttribute("FAXNOFOMAT", userinfo.getDIDFormat());
	        session.setAttribute("PHONEFORMAT", userinfo.getOfficePhoneFormat());
	        session.setAttribute("EXCELAUTH", userinfo.getExcelAuth());
	        session.setAttribute("AUTHNAME", userinfo.getAuthName());
	        session.setAttribute("GROUPFAXVIEW", userinfo.getGroupFaxView());
	        session.setAttribute("UserID", userinfo.getUserID());
	        session.setAttribute("OSBit", OSBit);
	        session.setAttribute("clientIP", clientIP);
   
		}
		/**
		 * �α׾ƿ�.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param httpServletResponse
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward loginOff(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
			
			HttpSession session = request.getSession(false);
        
			@SuppressWarnings("unused")
			String sessionid = request.getRequestedSessionId();
			String id = StringUtil.nvl(request.getParameter("UserID"),"");
						
			CommonDAO comDao=new CommonDAO();
			LogInDTO loginDto=new LogInDTO();
			
			loginDto.setUserID( id );
			loginDto.setSessionID( sessionid );
			
			comDao.setLogoutHistory(loginDto);
			
	        session.invalidate();

	        return actionMapping.findForward("loginOut");
	    }
	
}
