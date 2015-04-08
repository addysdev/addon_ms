<%@ page contentType="text/xml; charset=euc-kr"  %>
<%@ page import ="java.util.Map"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();

%>
<?xml version="1.0" encoding="euc-kr"?>
<list>
<%
if (ld.getItemCount() > 0) {
	String GNAME="";
	while (ds.next()) {	
		GNAME=StringUtil.nvl(ds.getString("GroupName"),"").replaceAll("&","%26");
%>
<groupid><%=StringUtil.nvl(ds.getString("GroupID"),"")%></groupid>
<groupname><%=GNAME%></groupname>
<didno><%=StringUtil.nvl(ds.getString("GroupID"),"N")%></didno>
<%
	}
}
%>
</list>