<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.web.framework.data.DataSet" %>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ page import="com.web.common.util.*"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%
	String SessionUserID = StringUtil.nvl(dtoUser.getUserId(),"");//사용자 ID
	String SessionUserName = StringUtil.nvl(dtoUser.getUserNm(),"");//사용자명
	String fileName = SessionUserName+"_"+SessionUserID;
	
	response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("KSC5601"),"8859_1")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
.xl65
	{mso-style-parent:style0;
	mso-number-format:"\@";}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>로그인 이력 리스트</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6> 로그인 이력 리스트 </font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
				<td align="center"><strong>로그인 일시</strong></td>
                <td align="center"><strong>사용자&nbsp;(ID)</strong></td>
                <td align="center"><strong>로그인 채널</strong></td>
                <td align="center"><strong>Client IP</strong></td>
                <td align="center"><strong>Client OS</strong></td>
                <td align="center"><strong>Browser version</strong></td>
                <td align="center"><strong>기타 정보</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {	
		
		//if(ds != null) {
		//		for(int i=0; i<ld.getItemCount(); i++) {
		%>
			<tr bgcolor="#FFFFFF" height="23">
			
				<td align="center">&nbsp;<%=ds.getString("LoginDateTime")%></td>					                
                <td align="center">&nbsp;<%=ds.getString("LoginUser")%></td>
                <td align="center">&nbsp;<%=ds.getString("LoginProgram")%></td>
                <td align="center">&nbsp;<%=ds.getString("ClientIP")%></td>
                <td align="center">&nbsp;<%=ds.getString("ClientOS")%></td>
                <td align="center">&nbsp;<%=ds.getString("ClientBrowserVersion")%></td>
                <td align="center">&nbsp;<%=ds.getString("Description")%></td>
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="7" align="center" class="td5">게시물이 없습니다.</td>
			</tr>
		<%
			}
		%>
		</table>
		</td>
	</tr>
</table>									
</body>
</html>
