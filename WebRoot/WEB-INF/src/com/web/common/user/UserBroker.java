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
     * ����� ĳ�� ������ �����´�.
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
     * req�� �ؼ��ؼ� ���� �α����� �� UserId�� ��ȯ�Ѵ�.
     * 
     * @return �α����� �� UserId, �α��� ���� �ʾҴٸ� null�� ��ȯ
     */
    public static final String getUserId(HttpServletRequest req) {
        HttpSession session = req.getSession();
        String userId = (String)session.getAttribute(LOGIN_USERID);
        
        if(userId == null) return "";         
                
        return StringUtil.nvl(userId);
    }
    /**
     * ����� �̸��� �����´�.
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
     * GroupID�� �����´�.
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
     * Group���� �����´�.
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
     * DID�� �����´�.
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
     * Email�� �����´�.
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
