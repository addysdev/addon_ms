<%@ page contentType="text/xml; charset=euc-kr"  %>
<%@ page import ="java.util.Map"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%@ page import ="com.web.framework.util.*"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	response.setHeader("Cache-Control","no-cache");
	GroupDTO groupDto = (GroupDTO)  model.get("groupDto");
	System.out.println("RESULT:"+groupDto.getResult());
	System.out.println("GROUPID:"+groupDto.getGroupID());
	System.out.println("GROUPSTEP:"+groupDto.getGroupStep());
%>
<?xml version="1.0" encoding="euc-kr"?>

<group-result>
		<result><%=StringUtil.nvl(""+groupDto.getResult(),"0")%></result>
		<result><%=StringUtil.nvl(groupDto.getGroupID(),"")%></result>
		<result><%=StringUtil.nvl(""+groupDto.getGroupStep(),"0")%></result>
</group-result>