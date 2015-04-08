<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="com.web.framework.data.DataSet" %>
<%@ page import="com.web.common.CommonDAO"%>
<%@ page import="java.util.*" %>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.common.user.UserDTO" %>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ include file="/jsp/web/common/base.jsp"%>


<%
	String fileName = "orderExcelList.xls";
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
<title>������ǥ ����Ʈ</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	String GroupID=(String)model.get("GroupID");
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
				<td align="center"><strong>����(8)</strong></td>
				<td align="center"><strong>����(2)</strong></td>
				<td align="center"><strong>����(4)</strong></td>
				<td align="center"><strong>�ŷ�ó�ڵ�(30)</strong></td>
				<td align="center"><strong>�ŷ�ó��(50)</strong></td>
				<td align="center"><strong>������Ʈ�ڵ�(14)</strong></td>
				<td align="center"><strong>â���ڵ�(5)</strong></td>
				<td align="center"><strong>������ڵ�(30)</strong></td>
				<td align="center"><strong>��ǥ����(200)</strong></td>
				<td align="center"><strong>�޸�(200)</strong></td>
				<td align="center"><strong>ǰ���ڵ�(20)</strong></td>
				<td align="center"><strong>ǰ���(100)</strong></td>
				<td align="center"><strong>���ݸ�(50)</strong></td>
				<td align="center"><strong>����(12)</strong></td>
				<td align="center"><strong>�ܰ�(12)</strong></td>
				<td align="center"><strong>���ް���(14)</strong></td>
				<td align="center"><strong>�ΰ���(14)</strong></td>
				<td align="center"><strong>����(200)</strong></td>
				<td align="center"><strong>�δ���(12)</strong></td>
				<td align="center"><strong>ecount</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--����Ʈ---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			double ordercnt=0;
			double orderprice=0;
			double totalprice=0;
			double vat=0;
			
			while (ds.next()) {	
		
			String DIDformat ="";
			
		%>
			<tr bgcolor="#FFFFFF" height="23">
			    <td align="center">&nbsp;<%=DateTimeUtil.getDate()%></td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;<%=ds.getString("CompanyCode")%></td>
				<td align="center">&nbsp;<%=ds.getString("CompanyName")%></td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;<%=GroupID %></td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;<%=ds.getString("ProductCode")%></td>
				<td align="center">&nbsp;<%=ds.getString("ProductName")%></td>
				<td align="center">&nbsp;</td>
				<%
				
				ordercnt=ds.getInt("OrderResultCnt");
				orderprice=ds.getInt("OrderResultPrice");
				totalprice=ordercnt*orderprice;
				vat=totalprice*0.1;
				
				%>
				
				<td align="center">&nbsp;<%=NumberUtil.getPriceFormat((long)ordercnt)%></td>
				<td align="center">&nbsp;<%=NumberUtil.getPriceFormat((long)orderprice)%></td>
				<td align="center">&nbsp;<%=NumberUtil.getPriceFormat((long)totalprice)%></td>
				<td align="center">&nbsp;<%=NumberUtil.getPriceFormat((long)vat)%></td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;</td>
				<td align="center">&nbsp;ecount</td>
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="20" align="center" class="td5">����Ÿ�� �����ϴ�.</td>
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
