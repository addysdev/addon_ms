
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page errorPage="/jsp/web/common/error.jsp" %>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ page import ="com.web.common.CommonDAO"%>
<%@ page import ="com.web.common.config.AuthDAO"%>
<%@ page import ="com.web.common.config.MenuDTO"%>
<%@ page import ="com.web.common.config.AuthDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");

boolean bLogin = BaseAction.isSession(request);			
UserMemDTO dtoUser = new UserMemDTO();					
if(bLogin == true)
	dtoUser = BaseAction.getSession(request);

String domianname=FileUtil.DOMAIN_NAME;
String BODYEVENT="oncontextmenu='return false' ondragstart='return false' onselectstart='return false'";

String userid = StringUtil.nvl(dtoUser.getUserId(),"");//사용자 ID
String name = StringUtil.nvl(dtoUser.getUserNm(),"");//사용자명

AuthDAO authDao = new AuthDAO();
AuthDTO authDto = new AuthDTO();

authDto.setUserID(userid);
ArrayList<MenuDTO> menulist  =  authDao.userAuthMenuTree(authDto);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>GNB</title>
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/globalize.js"/></script>

<script type="text/javascript">
//contextroot
contextroot='<%= request.getContextPath()%>';

//세션체크
if('<%=bLogin%>'=='false'){//
	//parent.location.href='<%= request.getContextPath()%>/H_Login.do?cmd=loginForm';
}
//로그아웃
function logout() {

	parent.location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=loginOff';
	
}
//새로고침(logo선택시)
function reflesh(){
	
    parent.location.href = '<%= request.getContextPath()%>/H_Login.do?cmd=main';
    
}
//메뉴이동
function goMenu(url){
	
	if(url=='w'){
		alert('서비스 준비중');
		return;
	}
	parent.mainFrame.openWaiting( );
	parent.mainFrame.location.href ='<%= request.getContextPath()%>'+url;
	
}

//사용자정보
function goMyInfo(){

	var url='<%=request.getContextPath() %>/H_Common.do?cmd=userInfoModifyForm';
    var top, left,scroll;
    var loc='center';
    var width='400';
    var height='350';

	if(scroll == null || scroll == '')	scroll='0';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	  if(openWin != 0) {
		   openWin.close();
	   }

	   openWin = window.open(url, 'Outbound', option);
   	
}

//주소록 페이지가기
function goAddressPage(){

	var url='<%=request.getContextPath() %>/H_Address.do?cmd=AddressPageList';
    var top, left,scroll;
    var loc='center';
    
    var sizeGb = '<%=userid.substring(0,1) %>';
    if(sizeGb=='Z'){
    	var width = '500';
    	var height='600';
    } else {
    	var width='1000';
        var height='700';
    }
   
	if(scroll == null || scroll == '')	scroll='0';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	  if(openWin != 0) {
		   openWin.close();
	   }

	   openWin = window.open(url, 'Outbound', option);
   	
}
function interval(method,secval){//interval에따른 시간차 함수 호출

	setTimeout(method,secval);
	
}
function inboundState(){
	
	var secval='60000';//60초단위

    var requestUrl='<%= request.getContextPath() %>/H_Common.do?cmd=inboundState';
	var inboundCnt=0;
	var waitCnt=0;
	
	var xmlhttp = null;
	var xmlObject = null;
	var resultText = null;
	
	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlhttp.open("GET", requestUrl, false);
	xmlhttp.send(requestUrl);

	resultText = xmlhttp.responseText;

	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	xmlObject.loadXML(resultText);

	inboundCnt=xmlObject.documentElement.childNodes.item(0).text;
	waitCnt=xmlObject.documentElement.childNodes.item(1).text;
	
	document.getElementById("inboundcnt").innerText=addCommaStr(inboundCnt)+'건';
	document.getElementById("waitcnt").innerText=addCommaStr(waitCnt)+'건';
	
	interval('inboundState()',secval);	
}

function browser_Event(){
	
	var width = document.documentElement.clientWidth;
	
	 if(event.clientY < 0 && event.clientX > (width / 2)  ){
		 
	 logout();
	 
	 this.close;

	} else {
		
		if(document.readyState=="complete"){
			//새로고침
//			alert( "브라우저 갱신");

		} else if(document.readyState=="loading"){

			//다른 페이지 이동
//			alert( "브라우저 타 페이지 이동");
		}
	}
} 
function addressInfo(){
	
	   var top,left,scroll,url;
	   var width='400';
	   var height='500';
	   var loc='center';
	   var resizable='no';
	   
	   
			 url='<%=request.getContextPath() %>/H_OutboundBox.do?cmd=userSearchPageList&vInitYN=Y&UserGroupType=UserSearch';
			 width='695';
			 height='510';
			 resizable='yes'
	   
	   if(scroll == null || scroll == '')	scroll='0';
	   if(loc != null) {
		   top	 = screen.height/2 - height/2 - 50;
		   left = screen.width/2 - width/2 + 600 ;
	   } else {
		   top  = 10;
		   left = 10;
	   }
	   
	   var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable='+resizable+',location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

//	   if(addrWin != 0) {
//		   addrWin.close();
//	   }

	   addrWin = window.open(url, 'Address', option);
}

</script>
</head>
<body id="gnb" name = "CommTop" onunload="browser_Event()" onload="MM_preloadImages('<%=request.getContextPath()%>/images/top/menu_01_on.jpg','<%=request.getContextPath()%>/images/top/menu_01_on.jpg')">
<!-- 레이아웃 시작 -->
<div id="gnb_wrap">
<div id="gnb_wrapL"><!-- 왼쪽 배경 -->
	<!-- 로고 시작 -->
	<div id="gnb_logo">
		<h1>
			<%--<a href="javascript:reflesh();"><img src="<%=request.getContextPath()%>/images/top/logo.jpg" title="Addys 시스템" /></a> --%>
			<a href="javascript:reflesh();"><img src="<%=request.getContextPath()%>/images/top/addys-logo.jpg" title="Addys 시스템" /></a>
		</h1>
	</div>
	<!-- 로고 끝 -->
	<!-- 최상단메뉴 시작 -->
	<div id="top_set">
		<ul>
			<li>사용자 : <span class="bar"><strong><%=name %>(<%=userid %>)</strong></span></li>
			<li><span class="bar"><a href="javascript:logout();">Logout</a></span></li>
			<li><span class="whiteTxt bar"><a href="javascript:goMyInfo();">My info</a></span></li>
			<!-- li><span class="whiteTxt addr"><a href="javascript:goAddressPage();">주소록관리</a></span></li-->
		</ul>
	</div>
	<!-- 최상단 메뉴 끝 -->

	<!-- gnb 메인메뉴 랩 시작 -->
	<div id="gnb_menu_wrap">
		<!-- gnb 메인메뉴 시작 -->
		<div id="gnb_menu">
			<!-- 메뉴시작 -->
			<div id="menu">
				<ul>
					<!-- 발주관리 시작 -->
					<li  id="M10000" style="display:lnline" class="dep1">
					<a href="javascript:;" target="_top" onclick="MM_nbGroup('down','group1','menu_01','<%=request.getContextPath()%>/images/top/addys-menu_01_on.jpg',1)" onmouseover="MM_nbGroup('over','menu_01','<%=request.getContextPath()%>/images/top/addys-menu_01_on.jpg','<%=request.getContextPath()%>/images/top/addys-menu_01_on.jpg',1)" onmouseout="MM_nbGroup('out')"><img src="<%=request.getContextPath()%>/images/top/addys-menu_01.jpg" alt="" name="menu_01" border="0" id="menu_01" title="발주" onclick="MM_showHideLayers('apDiv1','','show')" onmouseover="MM_showHideLayers('apDiv1','','show')" onmouseout="MM_showHideLayers('apDiv1','','hide')" onload="" /></a>
						<!-- 서브메뉴 : 발주관리 시작 -->
						<div id="apDiv1" onclick="MM_showHideLayers('apDiv1','','show')" onmouseover="MM_showHideLayers('apDiv1','','show')" onmouseout="MM_showHideLayers('apDiv1','','hide')" >
							<ul class="sub_menu">
								  <li id="M13000" style="display:lnline"><a class="s" href="javascript:goMenu('/H_Order.do?cmd=stockPageList');MM_nbGroup('down','group1','menu_01','<%=request.getContextPath()%>/images/top/menu_01_on.jpg',1)">재고현황 관리</a></li>
							      <li id="M11000" style="display:lnline"><a class="s" href="javascript:goMenu('/H_Order.do?cmd=targetPageList');MM_nbGroup('down','group1','menu_01','<%=request.getContextPath()%>/images/top/menu_01_on.jpg',1)">발주 리스트</a></li>
							      <li id="M12000" style="display:lnline"><a class="s" href="javascript:goMenu('/H_Order.do?cmd=orderPageList');MM_nbGroup('down','group1','menu_01','<%=request.getContextPath()%>/images/top/menu_01_on.jpg',1)">검수 리스트</a></li>
							  </ul>
						</div>
						<!-- 서브메뉴 : 발주관리 끝 -->
					</li>
					<!-- 발주관리 끝 -->
					<!-- 회수관리 시작 -->
					<li  id="M20000" style="display:lnline" class="dep1">
					<a href="javascript:;" target="_top" onclick="MM_nbGroup('down','group2','menu_02','<%=request.getContextPath()%>/images/top/addys-menu_02_on.jpg',1)" onmouseover="MM_nbGroup('over','menu_02','<%=request.getContextPath()%>/images/top/addys-menu_02_on.jpg','<%=request.getContextPath()%>/images/top/addys-menu_02_on.jpg',1)" onmouseout="MM_nbGroup('out')"><img src="<%=request.getContextPath()%>/images/top/addys-menu_02.jpg" alt="" name="menu_02" border="0" id="menu_02" title="회수" onclick="MM_showHideLayers('apDiv2','','show')" onmouseover="MM_showHideLayers('apDiv2','','show')" onmouseout="MM_showHideLayers('apDiv2','','hide')" onload=""  /></a>
						<!-- 서브메뉴 : 회수관리시작 -->
						<div id="apDiv2" onclick="MM_showHideLayers('apDiv2','','show')" onmouseover="MM_showHideLayers('apDiv2','','show')" onmouseout="MM_showHideLayers('apDiv2','','hide')" >
							<ul class="sub_menu">
								<li  id="M21000" style="display:lnline"><a class="s" href="javascript:goMenu('/H_Recovery.do?cmd=reTargetPageList');MM_nbGroup('down','group2','menu_02','<%=request.getContextPath()%>/images/top/menu_02_on.jpg',1)">회수 리스트</a></li>
							    <li  id="M22000" style="display:lnline"><a class="s" href="javascript:goMenu('/H_Recovery.do?cmd=recoveryPageList');MM_nbGroup('down','group2','menu_02','<%=request.getContextPath()%>/images/top/menu_02_on.jpg',1)">회수완료 리스트</a></li>
							</ul>
							<iframe class="sbBlind"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
						</div>
						<!-- 서브메뉴 :  회수관리(임시)끝 -->
					</li>
					<!-- 회수관리 끝 -->
					<!-- 관리 시작 -->
					<li id="M50000" style="display:none" class="dep1">
					<a href="javascript:;" target="_top" onclick=";MM_nbGroup('down','group5','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)" onmouseover="MM_nbGroup('over','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)" onmouseout="MM_nbGroup('out')"><img src="<%=request.getContextPath()%>/images/top/menu_07.jpg" alt="" name="menu_07" border="0" id="menu_07" title="관리" onclick="MM_showHideLayers('apDiv7','','show')" onmouseover="MM_showHideLayers('apDiv7','','show')" onmouseout="MM_showHideLayers('apDiv7','','hide')" onload="" /></a>
						<!-- 서브메뉴 : 설정(관리) 시작 -->
						<div id="apDiv7" onclick="MM_showHideLayers('apDiv7','','show')" onmouseover="MM_showHideLayers('apDiv7','','show')" onmouseout="MM_showHideLayers('apDiv7','','hide')" >
							<ul class="sub_menu">
								<li id="M51000" style="display:none"><a class="s" href="javascript:goMenu('/H_User.do?cmd=userPageList&vInitYN=N');MM_nbGroup('down','group5','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)">계정관리</a></li>
								<li id="M52000" style="display:none"><a class="s" href="javascript:goMenu('/H_Group.do?cmd=groupManage');MM_nbGroup('down','group5','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)">조직관리</a></li>
								<li id="M53000" style="display:none"><a class="s" href="javascript:goMenu('/H_Auth.do?cmd=authManage');MM_nbGroup('down','group5','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)">메뉴권한관리</a></li>
								<li id="M54000" style="display:none"><a class="s" href="javascript:goMenu('/H_Master.do?cmd=productPageList');MM_nbGroup('down','group5','menu_07','<%=request.getContextPath()%>/images/top/menu_07_on.jpg',1)">Master 정보관리</a></li>
							</ul>
							<iframe class="sbBlind sbBlind_mu04"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
						</div>
						<!-- 서브메뉴 : 설정(관리) 끝 -->
					</li>
					<!-- 관리 끝 -->
				</ul>
			</div>
			<!-- 메뉴 끝 -->
		</div>
		<!-- gnb 메인메뉴 끝 -->
	</div>
	<!-- gnb 메인메뉴 랩 끝 -->
</div><!-- 왼쪽 배경 -->
</div>
<!-- 레이아웃 끝 -->

<div class="clear"></div>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px;_top:300px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
	<table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
		<tr>
			<td align=center height=middle style="margin-top: 10px;">
				<table width=220 height=120 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/sub/loadingBar_bg.gif" >
					<tr>
						<td align=center style="padding-top:30px"><img src="<%=request.getContextPath()%>/images/sub/loader4.gif" width="32" height="32" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<!-- 처리중 종료 -->
<%= CommonUtil.getMenuAuth(menulist) %>
</body>
</html>