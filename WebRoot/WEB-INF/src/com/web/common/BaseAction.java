package com.web.common;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.web.common.user.UserMemDTO;
import com.web.framework.logging.Log;
import com.web.framework.logging.LogFactory;
import com.web.framework.util.StringUtil;
import com.oreilly.servlet.MultipartRequest;

public class BaseAction  implements Serializable{
	private static boolean isParamDebug = true;								//parameter디버깅
	public static boolean isXMLDebug = false;								//XML디버깅
	public static String PARAMFAIL_MNG = "";								//param값 이상유무시메시지
	public static String ERROR_FORWARD = "/jsp/imagefax/common/error.jsp";	//에러페이지.
	
	
	
//	 TODO: Action Param Debug boolean.
	static Log log = LogFactory.getLog("BASE init");
	
	/**
	 * 세션정보를 셋팅하여 넘김.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static UserMemDTO getSession(HttpServletRequest req) throws Exception{
		UserMemDTO newUserInfo = null;
		try{
			HttpSession session = req.getSession(); 

			newUserInfo =  new UserMemDTO();
			newUserInfo.setUserId((String)session.getAttribute("USERID"));
			newUserInfo.setUserNm((String)session.getAttribute("USERNAME"));
			newUserInfo.setGroupid((String)session.getAttribute("GROUPID"));
			newUserInfo.setGroupname((String)session.getAttribute("GROUPNAME"));
			newUserInfo.setAuthid((String)session.getAttribute("AUTHID"));
			newUserInfo.setAuthname((String)session.getAttribute("AUTHNAME"));
			newUserInfo.setExcelauth((String)session.getAttribute("EXCELAUTH"));
			newUserInfo.setFaxno((String)session.getAttribute("FAXNO"));
			newUserInfo.setPhone((String)session.getAttribute("PHONE"));

			newUserInfo.setFaxnoFormat((String)session.getAttribute("FAXNOFOMAT"));
			newUserInfo.setPhoneFormat((String)session.getAttribute("PHONEFORMAT"));
			
			newUserInfo.setGroupfaxview((String)session.getAttribute("GROUPFAXVIEW"));

			if(newUserInfo == null || newUserInfo.getUserId().equals("")){
//				log.error("세션 작업중 오류", new Throwable());
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return newUserInfo;
	}
	/**
	 * 세션 유효 체크여부.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static boolean isSession(HttpServletRequest req) throws Exception {
		try{
			HttpSession session = req.getSession(false); 
			String userID =(String)session.getAttribute("USERID"); 
			if(userID == null || userID.equals("")){
				return false;
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return true;
	}
	public static void setLoginForward(HttpServletRequest request, String strAction, String strCmd) throws Exception{

		ArrayList l = new ArrayList();
		Enumeration e1 = request.getParameterNames(); 
		String name = null;
		String[] strTemp = null;
		HashMap m = null;
		int iCnt = 0;
		while (e1.hasMoreElements()){ 
		    name = e1.nextElement().toString(); 
		    if(request.getParameterValues(name) != null && request.getParameterValues(name).length > 1)
		    {
		    	strTemp = request.getParameterValues(name);
		    	for(int i = 0; i < strTemp.length; i++){
		    		m = new HashMap();
		    		if( StringUtil.isNotNull(strCmd) && "cmd".equals(name) ){
		    			m.put(name, strCmd);
		    		} else {
		    			m.put(name, strTemp[i]);
		    		}
		    		l.add(m);
		    	}
		    }
		    else
		    {
	    		m = new HashMap();
	    		if( StringUtil.isNotNull(strCmd) && "cmd".equals(name) ){
	    			m.put(name, strCmd);
	    		} else {
	    			m.put(name, request.getParameter(name));
	    		}
	    		l.add(m);
		    }
		    iCnt++;
		}

		HttpSession session = request.getSession(false); 
		session.setAttribute("LoginREQUEST", l);
		session.setAttribute("LoginCMD", strAction);
	}
	/**
	 * 파라메타 넘어온 값을 로그에 남김.
	 * 개발테스트용으로 씀.
	 * @param request
	 * @param strMsg
	 * @throws Exception
	 */
	public static void printPrameter(HttpServletRequest request, Class strMsg) throws Exception{
		if( isParamDebug ){
			Enumeration e1 = request.getParameterNames(); 
			String name = null;
			String[] strTemp = null;
			int iCnt = 0;
			log.debug("============================= Param Value Start ["+strMsg.getName()+"]===========");
			while (e1.hasMoreElements()){ 
			    name = e1.nextElement().toString(); 
			    if(request.getParameterValues(name) != null && request.getParameterValues(name).length > 1)
			    {
			    	strTemp = request.getParameterValues(name);
			    	for(int i = 0; i < strTemp.length; i++)
			    		log.debug("*= "+ iCnt + " \t[" + name + "\t:" + i + "]\t\t = \t" + strTemp[i]);
			    }
			    else
			    {
			    	log.debug("= " + iCnt + " \t[" + name + "]\t\t = \t" + request.getParameter(name));
			    }
			    iCnt++;
			}
		}
	}
	public static void printPrameter(MultipartRequest request, Class strMsg) throws Exception{
		if( isParamDebug ){
			Enumeration e1 = request.getParameterNames(); 
			String name = null;
			String[] strTemp = null;
			int iCnt = 0;
			log.debug("============================= Param Value Start ["+strMsg.getName()+"]===========");
			while (e1.hasMoreElements()){ 
			    name = e1.nextElement().toString(); 
			    if(request.getParameterValues(name) != null && request.getParameterValues(name).length > 1)
			    {
			    	strTemp = request.getParameterValues(name);
			    	for(int i = 0; i < strTemp.length; i++)
			    		log.debug("*= "+ iCnt + " \t[" + name + "\t:" + i + "]\t\t = \t" + strTemp[i]);
			    }
			    else
			    {
			    	log.debug("= " + iCnt + " \t[" + name + "]\t\t = \t" + request.getParameter(name));
			    }
			    iCnt++;
			}
		}
	}
	public static void printPrameter(HttpServletRequest request, String strMsg) throws Exception{
		if( isParamDebug ){
			Enumeration e1 = request.getParameterNames(); 
			String name = null;
			String[] strTemp = null;
			int iCnt = 0;
			log.debug("============================= Param Value Start ["+strMsg+"]===========");
			while (e1.hasMoreElements()){ 
			    name = e1.nextElement().toString(); 
			    if(request.getParameterValues(name) != null && request.getParameterValues(name).length > 1)
			    {
			    	strTemp = request.getParameterValues(name);
			    	for(int i = 0; i < strTemp.length; i++)
			    		log.debug("*= "+ iCnt + " \t[" + name + "\t:" + i + "]\t\t = \t" + strTemp[i]);
			    }
			    else
			    {
			    	log.debug("= " + iCnt + " \t[" + name + "]\t\t = \t" + request.getParameter(name));
			    }
			    iCnt++;
			}
		}
	}
	
	public static void SesseionLogout( String SesstionID, String UserID ) {

		CommonDAO comDao=new CommonDAO();
		LogInDTO loginDto=new LogInDTO();
		
		loginDto.setUserID( UserID );
		loginDto.setSessionID( SesstionID );
		
		try {
			comDao.setLogoutHistory(loginDto);
		} catch (Exception e) {
			
		}
	}
}
