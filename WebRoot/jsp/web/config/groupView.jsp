<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
GroupDTO groupDto = (GroupDTO)model.get("groupDto");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�׷� ����</title>
<link href="<%= request.getContextPath() %>/css/common_1.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
</head>
<form name="groupVeiwFrm">
<input name="GroupID" type="hidden"   value="<%=StringUtil.nvl(groupDto.getGroupID(),"") %>"   />
<input name="GroupName" type="hidden"   value="<%=StringUtil.nvl(groupDto.getGroupName(),"") %>"   />
</form>
</html>
<script>
//var gTitle = parent.document.getElementsByName("groupTitle");
var titleTxt = "";
parent.$('#groupTitle').html("[<%=StringUtil.nvl(groupDto.getGroupName(),"") %>] ��������");

<%-- gTitle[0].innerText='[<%=StringUtil.nvl(groupDto.getGroupName(),"") %>] �׷����     �ѽ���ȣ �Ҵ� ����:<%=StringUtil.nvl(groupDto.getFaxCnt(),"")%>'; --%>
<%-- gTitle[1].innerText='<%=StringUtil.nvl(groupDto.getGroupName(),"") %>'; --%>
</script>