<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="com.web.framework.data.DataSet" %>
<%@ page import="com.web.common.CommonDAO"%>
<%@ page import="java.util.*" %>
<%@ page import="com.web.common.user.UserDTO" %>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ include file="/jsp/web/common/base.jsp"%>


<%
	String fileName = "UserExcelList.xls";
	response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
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
<title>사용자계정 리스트</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6> 사용자 계정 리스트 </font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
				<td align="center"><strong>사용자명</strong></td>
				<td align="center"><strong>사용자ID</strong></td>
				<td align="center"><strong>소속명</strong></td>
				<td align="center"><strong>전화번호</strong></td>
				<td align="center"><strong>사용여부</strong></td>
				<td align="center"><strong>최초등록일자</strong></td>
				<td align="center"><strong>최종수정일자</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {	
		
			String DIDformat ="";
			
		%>
			<tr bgcolor="#FFFFFF" height="23">
				<td align="center">&nbsp;<%=ds.getString("UserName")%></td>
				<td>&nbsp;<%=ds.getString("UserID")%></td>
				<td>&nbsp;<%=ds.getString("GroupName")%></td>
				<td align="center">&nbsp;<%=ds.getString("OfficePhoneFormat")%></td>
				<td align="center">&nbsp;<%=ds.getString("UseYN")%></td>
				<td align="center">&nbsp;<%=ds.getString("CreateDateTime")%></td>
				<% 
					if (ds.getString("UpdateDateTime") == null){
				%>
				<td>&nbsp;</td>
				<%
					}else{
				%>
				<td align="center">&nbsp;<%=ds.getString("UpdateDateTime")%></td>
				<%
					}
				%>
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
