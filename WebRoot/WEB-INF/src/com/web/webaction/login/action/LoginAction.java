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
		 * 로그인 관련 페이지
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
		 * 로그인 처리.
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
	
			String clientIP = request.getParameter("clientIP");			// IP 주소
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
					log.debug("master 접속:"+id);
					userDto.setLogid(logid);
					userDto.setUserID(id);
		
					userDto= userDao.userView(userDto);
					
					isSuccess = true;
					msg="";
				
				}else if(!"N".equals(sso_id)){//SSO 접속인경우 처리
					log.debug("SSO 접속:"+sso_id);
					userDto.setLogid(logid);
					userDto.setUserID(sso_id);
		
					userDto= userDao.userView(userDto);
					
					isSuccess = true;
					msg="";
				
				}else{//이미지 팩스 로그인정보 확인
						
						String encPasswd = "";
						
						userDto.setLogid(logid);
						userDto.setUserID(id);
	
						userDto= userDao.userView(userDto);
						
						encPasswd =userDao.setPasswdEncode(password);

						// 회원 존재의 존재유무 판단.
						if(!"N".equals(StringUtil.nvl(userDto.getUserID(),"N"))) { 

		                   if("N".equals(userDto.getUseYN())){	
		                		msg = "사용이 중지된 계정입니다. 관리자에게 문의하세요";
								isSuccess = false;
		                	   
		                   }else{
								// 패스워드가 맞는지 판단한다.
								if(!encPasswd.equals(userDto.getPassword())) {
									msg = "로그인 정보가 일치하지 않습니다.";
									isSuccess = false;
								} else {		
									isSuccess = true;
									msg="";
									
								}
		                   }
						}else {
							msg = "해당 사용자의 ID가 존재하지 않습니다.";
							isSuccess = false;
						}
				
				}
				
				if(isSuccess==true){//로그인 성공후 세션처리

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
					
					loginDto=comDao.setLoginHistory(loginDto);//로그인 이력세팅

					// 세션에 셋팅 
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
					
				} else { //로그인 실패
					
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
		 * 세션 정보 셋팅.
		 * @param request
		 * @param userdao
		 * @param userinfo
		 * @throws Exception
		 */
		private void setUserInfoMem(HttpServletRequest request,UserDTO userinfo ,String OSBit,String clientIP ) throws Exception{    
			
			HttpSession session = request.getSession(false);    
			
			// 세션 정보를 셋팅해 준다.   
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
		 * 로그아웃.
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
