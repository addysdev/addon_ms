<%@ page contentType="text/xml; charset=euc-kr"  %>
<%@ page import ="java.util.Map"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	String encId = (String)  model.get("encId");
	String decId = (String)  model.get("decId");
	String encPassword = (String)  model.get("encPassword");
	System.out.println("encId"+encId);
	System.out.println("decId"+decId);
	System.out.println("encPassword"+encPassword);
%>
<?xml version="1.0" encoding="euc-kr"?>

<xml-result>
		<result><%=encId%></result>
		<result><%=decId%></result>
		<result><%=encPassword%></result>
</xml-result>