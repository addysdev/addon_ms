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
<title>구매전표 리스트</title>
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
				<td align="center"><strong>일자(8)</strong></td>
				<td align="center"><strong>구분(2)</strong></td>
				<td align="center"><strong>순번(4)</strong></td>
				<td align="center"><strong>거래처코드(30)</strong></td>
				<td align="center"><strong>거래처명(50)</strong></td>
				<td align="center"><strong>프로젝트코드(14)</strong></td>
				<td align="center"><strong>창고코드(5)</strong></td>
				<td align="center"><strong>담당자코드(30)</strong></td>
				<td align="center"><strong>전표일자(200)</strong></td>
				<td align="center"><strong>메모(200)</strong></td>
				<td align="center"><strong>품목코드(20)</strong></td>
				<td align="center"><strong>품목명(100)</strong></td>
				<td align="center"><strong>구격명(50)</strong></td>
				<td align="center"><strong>수량(12)</strong></td>
				<td align="center"><strong>단가(12)</strong></td>
				<td align="center"><strong>공급가액(14)</strong></td>
				<td align="center"><strong>부가세(14)</strong></td>
				<td align="center"><strong>적요(200)</strong></td>
				<td align="center"><strong>부대비용(12)</strong></td>
				<td align="center"><strong>ecount</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
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
				<td colspan="20" align="center" class="td5">데이타가 없습니다.</td>
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
