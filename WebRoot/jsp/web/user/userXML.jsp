<%@ page contentType="text/xml; charset=euc-kr"  %>
<%@ page import ="java.util.Map"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	String result = (String)  model.get("result");
	System.out.println("RESULT"+result);
%>
<?xml version="1.0" encoding="euc-kr"?>

<xml-result>
		<result><%=result%></result>
</xml-result>