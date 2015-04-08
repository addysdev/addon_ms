<%@ page errorPage="/jsp/imagefax/common/error.jsp" %>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.web.framework.util.FileUtil"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL");

	boolean bLogin = BaseAction.isSession(request);			
	UserMemDTO dtoUser = new UserMemDTO();					
	if(bLogin == true)
		dtoUser = BaseAction.getSession(request);
	
	String domianname=FileUtil.DOMAIN_NAME;
	
	String BODYEVENT="";
	
	if("hifax.hi-portal.co.kr".equals(domianname)){

 		BODYEVENT = "oncontextmenu='return false' ondragstart='return false' onselectstart='return false'";
	
	}
%>