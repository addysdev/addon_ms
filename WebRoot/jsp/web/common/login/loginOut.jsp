<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.web.common.waf.*" %>

<%
	System.out.println("Logout.jsp started..");
	BaseEntity entity = SessionManager.getInstance().getBaseEntity(request);
	
	if(entity!=null){
		String userid = entity.getAttribute("userid");
		System.out.println("userid : " + userid);

		if( userid != null ) {
			SessionManager.logout(request);
		}
	}	
	System.out.println("Logout.jsp ended..");
%>
<html>
<head>
<title>
로그아웃 완료
</title>
<script>
	try{
		window.setTimeOut("5000", "self.close()");
	}catch(e){
	}

	function closeWin(){

		if(parent.parent!=null){
			parent.parent.self.close();
		}else if(parent!=null){
			parent.self.close();
		}else{
			self.close();
		}


	}
</script>
<link href="<%= request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#EFF3F6">
<br><p><br><p><br><p><br><p><br><p><br><p><br><p>
<table width="97%" height="25%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
	</tr>
</table>
<table width='246' border='0' align='center'>
<tr align='center'>
	<td>
	<img src='<%= request.getContextPath()%>/image/back/logout.gif'>
	<br><br>
	<input name='message2' type='text' id='message2' readonly style='font-weight:bold;font-size:12;color:#C62F74;width:90%;text-align:center;background-color:transparent;border:none' value='로그아웃 되었습니다.' border='none'>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr align='center'>
	<td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','<%= request.getContextPath()%>/image/back/button/bt_close_over.gif','',1)" href="<%= request.getContextPath()%>/index.jsp" target="new"><img src="<%= request.getContextPath()%>/image/back/button/bt_close.gif" name="Image3" width="64" height="20" border="0" style=cursor:hand  onClick="javascript:closeWin();"></a>
	</td>
</tr>
</table>
</body>
</html>
<%
	System.gc();
%>