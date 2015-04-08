<%@ page contentType="text/html; charset=euc-kr" isErrorPage="true" %>
<%
	request.setCharacterEncoding("euc-kr");

	String msgcode ="[0000]";// request.getAttribute("msgcode")==null?"":(String)request.getAttribute("msgcode");
	String msg = request.getAttribute("msg")==null?"":(String)request.getAttribute("msg");
%>
<html>
<head>
<title>Login Error</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">

<HTML>
<HEAD>
<TITLE>로그인에러</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
<style type="text/css">
<!--
td {
	font-family: "굴림", "굴림체", "돋움", "돋움체";
	font-size: 12px;
	color: #666666;
}
-->
</style>
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<!-- ImageReady Slices (로그인에러.psd) -->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
<TABLE WIDTH=410 BORDER=0 CELLPADDING=0 CELLSPACING=0>
        <TR> 
          <TD height="169" valign="middle"> 
            <table width="100%" height="100%" border="0" align="center" cellpadding="10" cellspacing="10" bgcolor="#cccccc">
              <tr>
                <td align="center" bgcolor="#FFFFFF"><%= "message code : " + msgcode%><br></td>
              </tr>
			  <tr>
                <td align="center" bgcolor="#FFFFFF"><%= "message : " + msg%><br></td>
              </tr>
            </table> 
          </TD>
        </TR>
        <TR> 
          <TD> <IMG SRC="<%= request.getContextPath() %>/image/back/le_04.gif" WIDTH=400 HEIGHT=10 ALT=""></TD>
        </TR>
      </TABLE>
	  <table width=410 border=0 cellpadding=0 cellspacing=0>
	<tr><td align=center>
	<a href="javascript:history.go(-1)"><IMG SRC="<%= request.getContextPath() %>/image/back/rtry.gif" ALT="" border='0'></a> &nbsp;&nbsp;
	<a href="javascript:window.close()"><IMG SRC="<%= request.getContextPath() %>/image/back/fin.gif" ALT="" border='0'></a>
	</td></tr>
</table>
    </td>
  </tr>
</table>

<!-- End ImageReady Slices -->
</HTML>