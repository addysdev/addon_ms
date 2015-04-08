<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.web.framework.util.FileUtil"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.user.UserDAO"%>
<%@ page import="com.web.common.CommonDAO"%>

<%
Map model = (Map)request.getAttribute("MODEL");

boolean bLogin = BaseAction.isSession(request);
UserMemDTO dtoUser = new UserMemDTO();
//String UserID = dtoUser.getUserId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>시스템 에러</title>
<style type="text/css">
<!--
-->
</style>
<link href="<%= request.getContextPath() %>/css/imagefax.css" rel="stylesheet" type="text/css" />
  <script language="JavaScript" src="<%= request.getContextPath() %>/js/imagefax.js"></script>
  <script>
  	if('<%=bLogin%>'=='false'){
  		
//  		alert( '여기 아님??' );
 		alert('세션이 종료되어 로그아웃됩니다.');
  		
 		try{
  	  		parent.location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=loginOff';
			parent.location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=loginForm';
  		}catch(e){	
  	  		location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=loginOff';
  			location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=loginForm';
  		}
  		
	}
	function init() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}
</script>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
   <table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
      <tr>
         <td align=center height=middle style="margin-top: 10px;">
            <table width=293 height=148 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/main/ing.gif" >
                  <tr>
                     <td align=center><img src="<%=request.getContextPath()%>/images/main/spacer.gif" width="1" height="50" /><img src="<%=request.getContextPath()%>/images/main/wait2.gif" width="242" height="16" /></td>
                  </tr>
            </table>
          </td>
       </tr>
    </table>
</div>
<!-- 처리중 종료 -->
<body onload="init();">
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="mainbox">
  <tr>
    <td align="center" valign="middle"><table width="518" border="0" cellspacing="0" cellpadding="0">
      
      <!-- 에러테이블 (1) START-->
      <tr>
        <td><img src="<%= request.getContextPath() %>/images/sub/error_01.gif" width="518" height="111" /></td>
      </tr>
      <!-- 에러테이블 (1) END-->
      
      <!-- 에러테이블 (2) START-->
      <tr>
        <td style=" background:url(<%= request.getContextPath() %>/images/sub/error_02.gif); background-repeat:repeat-y;">
        
            <!-- 텍스트 메세지 테이블 START-->
            <table width="518" border="0" cellpadding="0" cellspacing="0" id="textBox">
              <tr>
                <td width="50">&nbsp;</td>
                <td><p><strong>요청하신 화면을 찾을 수 없습니다.</strong> <br>정확한 주소인지 확 인하시고 다시 접속해주시기 바랍니다.<br>
				동일한 문제가 지속적으로 발생하실 경우에<br>서비스 이용 문의 부탁드립니다.</p></td>
                <td width="50">&nbsp;</td>
              </tr>
            </table>
            <!-- 텍스트 메세지 테이블 END-->
        
        </td>
      </tr>
      <!-- 에러테이블 (2) END-->
      
      <!-- 에러테이블 (3) START-->
      <tr>
        <td><img src="<%= request.getContextPath() %>/images/sub/error_03.gif" width="518" height="49" /></td>
      </tr>
      <!-- 에러테이블 (3) END-->
      
    </table></td>
  </tr>
</table>

<map name="Map" id="Map">
  <area shape="rect" coords="0,1,58,58" href="#" alt="로그인" title="로그인" />
</map>
</body>
</html>
