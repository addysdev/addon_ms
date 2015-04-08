package com.web.common.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.web.common.util.CommonUtil;
import com.web.framework.Constants;
import com.web.framework.util.StringUtil;

public class UserBroker implements Constants {
    private static UserBroker userBrokerins = null;
    /**
     *   
     */
    public UserBroker() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public static UserBroker getInstance(){  
	    if(userBrokerins == null) {
	        userBrokerins = new UserBroker();
	     }
	
	     return userBrokerins;
    }

    /**
     * 사용자 캐쉬 정보를 가져온다.
     * @param req
     * @return
     */
    public static final UserMemDTO getUserInfo(HttpServletRequest req){
		UserMemDTO user = null;
        HttpSession session = req.getSession();
        user = (UserMemDTO)session.getAttribute("USERINFO");
		
		return user;
    }
    
    /**
     * req를 해석해서 현재 로그인한 고객 UserId를 반환한다.
     * 
     * @return 로그인한 고객 UserId, 로그인 하지 않았다면 null을 반환
     */
    public static final String getUserId(HttpServletRequest req) {
        HttpSession session = req.getSession();
        String userId = (String)session.getAttribute(LOGIN_USERID);
        
        if(userId == null) return "";         
                
        return StringUtil.nvl(userId);
    }
    /**
     * 사용자 이름을 가져온다.
     * @param req
     * @return
     */
    public static final String getUserNm(HttpServletRequest req){
    	String userName = "";
        HttpSession session = req.getSession();
        userName = (String)session.getAttribute(LOGIN_USERNAME);
 
        return StringUtil.nvl(userName);
    }    
    /**
     * GroupID를 가져온다.
     * @param req
     * @return
     */
    public static final String getGroupID(HttpServletRequest req){
    	String groupID = "";
        HttpSession session = req.getSession();
        groupID = (String)session.getAttribute(LOGIN_GROUPID);
 
        return StringUtil.nvl(groupID);
    }    
    /**
     * Group명을 가져온다.
     * @param req
     * @return
     */
    public static final String getGroupNm(HttpServletRequest req){
    	String groupName = "";
        HttpSession session = req.getSession();
        groupName = (String)session.getAttribute(LOGIN_USERNAME);
 
        return StringUtil.nvl(groupName);
    }  
    /**
     * DID를 가져온다.
     * @param req
     * @return
     */
    public static final String getDIDNo(HttpServletRequest req){
    	String didno = "";
        HttpSession session = req.getSession();
        didno = (String)session.getAttribute("FAXNO");

        return StringUtil.nvl(didno);
    }
    /**
     * Email을 가져온다.
     * @param req
     * @return
     */
    public static final String getEmail(HttpServletRequest req){
    	String email = "";
        HttpSession session = req.getSession();
        email = (String)session.getAttribute("EMAIL");

        return StringUtil.nvl(email);
    }
  
}
