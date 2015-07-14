<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.net.*" %>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import ="cis.internal.util.EncryptUtil"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%


	String msg = StringUtil.nvl((String) model.get("msg"),"INIT").trim();
    String passkey=StringUtil.nvl((String) model.get("passkey"),"false").trim();

	String ipaddress = InetAddress.getLocalHost().getHostAddress();
	if (ipaddress == null) ipaddress = InetAddress.getLocalHost().getHostAddress();
	
	String sClientIP = request.getRemoteAddr();
	

	//쿠키 암호화 적용
	
	// SSO ID READ
	String sso_id=null;
	String uurl=null;
	
	sso_id=null;
	//sso_id="Z00003";
	
	uurl=request.getParameter("UURL");
	
	if(sso_id!=null){//SSO연동인경우
	/*
		String retCode= getEamSessionCheck(request,response);
	
		if(!retCode.equals("0")){//SSO 통합인증쿠키가 유효하지 않을경우
			msg="SSO 통합인증쿠키가 유효하지 않습니다.";
			//msg="SSO";
		}else{
			msg="SSO";
	
		}
		*/
		msg="SSO";
	}
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<title>addys</title>
<!--<link href="<%= request.getContextPath() %>/css/common_2.css" rel="stylesheet" type="text/css" />-->
<link href="<%= request.getContextPath() %>/css/login.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script>
function login(){
	
	var frm=document.loginForm;
	var sPath = window.location.pathname;
	var sSearch=window.location.search;
	var url='<%= request.getContextPath()%>'+sPath+sSearch;
	
	if( frm.saveId.checked == true ){
		setCookie("huation_UserId", frm.text_id.value);
	} else {
		setCookie("huation_UserId", "");
	}

	if(frm.text_id.value.length==0){
		alert('ID 를 입력하세요');
		return;
	}
	
//	if(frm.text_id.value.length==7){
//		frm.text_id.value = '0' + frm.text_id.value;
//	}
	
	
	if(frm.text_password.value.length==0){
		alert('Password 를 입력하세요');
		return;
	}
	/*
	if(frm.text_password.value.length<8 || frm.text_password.value.length>12){
		alert('Password 는 8~12자리입니다.');
		return;
	}
	*/
	var OSName = navigator.userAgent;
	var OSBit = navigator.userAgent;

/*
     64-bit IE on 64-bit Windows:
	 Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Win64; x64; Trident/4.0)
	 32-bit IE on 64-bit Windows:
	 Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0)
	 Incidentally, WOW64 stands for “Windows on Windows 64-bit.”
 */
    if(OSName.indexOf("NT 6.0") != -1) OSName="Windows Vista/2008";
    else if(OSName.indexOf("NT 6.1") != -1) OSName="Windows 7/2008 R2";
    else if(OSName.indexOf("NT 5.2") != -1) OSName="Windows Server 2003";
    else if(OSName.indexOf("NT 5.1") != -1) OSName="Windows XP";
    else if(OSName.indexOf("NT 5.0") != -1) OSName="Windows 2000";
    else if(OSName.indexOf("NT") != -1) OSName="Windows NT";
    else if(OSName.indexOf("9x 4.90") != -1) OSName="Windows Me";
    else if(OSName.indexOf("98") != -1) OSName="Windows 98";
    else if(OSName.indexOf("95") != -1) OSName="Windows 95";
    else if(OSName.indexOf("Win16") != -1) OSName="Windows 3.x";
    else if(OSName.indexOf("Windows") != -1) OSName="Windows";
    else if(OSName.indexOf("Linux") != -1) OSName="Linux";
    else if(OSName.indexOf("Macintosh") != -1) OSName="Macintosh";
    else OSName="";
	 
	if(OSBit.indexOf("Win64") != -1) OSBit="64bit";
    else  OSBit="32bit";

    var name = navigator.appName, BrowserInfo = navigator.appVersion;
	if(name == "Microsoft Internet Explorer")
	{
	    if(BrowserInfo.indexOf("MSIE 3.0") != -1) BrowserInfo = "Internet Explorer 3.0x";
		else if(BrowserInfo.indexOf("MSIE 4.0") != -1) BrowserInfo = "Internet Explorer 4.0x";
		else if(BrowserInfo.indexOf("MSIE 5.0") != -1) BrowserInfo = "Internet Explorer 5.0x";
		else if(BrowserInfo.indexOf("MSIE 6.0") != -1) BrowserInfo = "Internet Explorer 6.0x";
		else if(BrowserInfo.indexOf("MSIE 7.0") != -1) BrowserInfo = "Internet Explorer 7.0x";
		else if(BrowserInfo.indexOf("MSIE 8.0") != -1) BrowserInfo = "Internet Explorer 8.0x";
		else if(BrowserInfo.indexOf("MSIE 9.0") != -1) BrowserInfo = "Internet Explorer 9.0x";
		else if(BrowserInfo.indexOf("MSIE 10.0") != -1) BrowserInfo = "Internet Explorer 10.0x";
	}
	else if(name == "Netscape")
	{
	    if(BrowserInfo.indexOf("Chrome") != -1) {
	    	var versionFilter = BrowserInfo.substring(BrowserInfo.indexOf("Chrome")+"Chrome".length+1);
	    	BrowserInfo = "Chrome " + versionFilter.substring(0, versionFilter.indexOf(".")) + ".0x";
		}
	    else if(BrowserInfo.indexOf("Windows") != -1) BrowserInfo = "FireFox " + BrowserInfo.substring(0,3) + "x";
	    else BrowserInfo = "Unknown";
	}
	
	//var hiCisIcon = document.getElementById("cisShortCut");
	
	var clientIP = '';				// IP 주소
	var macAddress	= '';	// MAC 주소
	var hddSerialNo	= '';		// HDD Serial
	var cpu	= '';						// cup Serial
	var ram	= '';				// ram Serial
	var hddsize	='';			// HDD Size
	var os = OSName;					// OS
	/*
			alert("IP 주소 : " + clientIP + "\r\n" + 
			"MAC 주소 : " + macAddress+ "\r\n" + 
			"hddSerialNo  : " + hddSerialNo + "\r\n" + 
			"cpu  : " + cpu + "\r\n" + 
			"ram  : " + ram + "\r\n" + 
			"hddsize  : " + hddsize );
	*/

	
	frm.clientIP.value="<%=sClientIP%>";
	frm.os.value=os;
	frm.macAddress.value=macAddress;
	frm.hddSerialNo.value=hddSerialNo;
	frm.cpu.value=cpu;
	frm.ram.value=ram;
	frm.hddsize.value=hddsize;
	frm.clientBrowserVersion.value=BrowserInfo;
	frm.OSBit.value=OSBit;
	frm.action='<%= request.getContextPath()%>/H_Login.do';
	frm.cmd.value = 'setLogin';
	frm.rtnUrl.value=url;//escape(url);

	var tmpid=frm.text_id.value.toUpperCase();
	
	var tmppw=frm.text_password.value.toUpperCase();
	/*	
	var requestUrl='<%= request.getContextPath() %>/H_Login.do?cmd=encKey&key1='+tmpid+'&key2='+tmppw;

	var result1='';
	var result2='';
	var result3='';
	
	var xmlhttp = null;
	var xmlObject = null;
	var resultText = null;

	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlhttp.open("GET", requestUrl, false);
	xmlhttp.send(requestUrl);

	resultText = xmlhttp.responseText;

	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	xmlObject.loadXML(resultText);

	result1=xmlObject.documentElement.childNodes.item(0).text;
	result2=xmlObject.documentElement.childNodes.item(1).text;
	result3=xmlObject.documentElement.childNodes.item(2).text;
	
	//alert(result1);
	//alert(result2);
	//alert(result3);
	
	frm.id.value=result1;
	frm.password.value=result3;

	frm.text_id.value='';
	frm.text_password.value='';
	*/
	
	frm.id.value=tmpid;
	frm.password.value=tmppw;

	frm.submit();

}
function ssoLogin(){
	
	var frm=document.loginForm;
	var sPath = window.location.pathname;
	var sSearch=window.location.search;
	var url='<%= request.getContextPath()%>'+sPath+sSearch;
	
	var OSName = navigator.userAgent;
	var OSBit = navigator.userAgent;

    if(OSName.indexOf("NT 6.0") != -1) OSName="Windows Vista/2008";
    else if(OSName.indexOf("NT 6.1") != -1) OSName="Windows 7/2008 R2";
    else if(OSName.indexOf("NT 5.2") != -1) OSName="Windows Server 2003";
    else if(OSName.indexOf("NT 5.1") != -1) OSName="Windows XP";
    else if(OSName.indexOf("NT 5.0") != -1) OSName="Windows 2000";
    else if(OSName.indexOf("NT") != -1) OSName="Windows NT";
    else if(OSName.indexOf("9x 4.90") != -1) OSName="Windows Me";
    else if(OSName.indexOf("98") != -1) OSName="Windows 98";
    else if(OSName.indexOf("95") != -1) OSName="Windows 95";
    else if(OSName.indexOf("Win16") != -1) OSName="Windows 3.x";
    else if(OSName.indexOf("Windows") != -1) OSName="Windows";
    else if(OSName.indexOf("Linux") != -1) OSName="Linux";
    else if(OSName.indexOf("Macintosh") != -1) OSName="Macintosh";
    else OSName="";

	if(OSBit.indexOf("Win64") != -1) OSBit="64bit";
    else  OSBit="32bit";

    var name = navigator.appName, BrowserInfo = navigator.appVersion;
	if(name == "Microsoft Internet Explorer")
	{
	    if(BrowserInfo.indexOf("MSIE 3.0") != -1) BrowserInfo = "Internet Explorer 3.0x";
		else if(BrowserInfo.indexOf("MSIE 4.0") != -1) BrowserInfo = "Internet Explorer 4.0x";
		else if(BrowserInfo.indexOf("MSIE 5.0") != -1) BrowserInfo = "Internet Explorer 5.0x";
		else if(BrowserInfo.indexOf("MSIE 6.0") != -1) BrowserInfo = "Internet Explorer 6.0x";
		else if(BrowserInfo.indexOf("MSIE 7.0") != -1) BrowserInfo = "Internet Explorer 7.0x";
		else if(BrowserInfo.indexOf("MSIE 8.0") != -1) BrowserInfo = "Internet Explorer 8.0x";
		else if(BrowserInfo.indexOf("MSIE 9.0") != -1) BrowserInfo = "Internet Explorer 9.0x";
	}
	else if(name == "Netscape")
	{
	    if(BrowserInfo.indexOf("Chrome") != -1) {
	    	var versionFilter = BrowserInfo.substring(BrowserInfo.indexOf("Chrome")+"Chrome".length+1);
	    	BrowserInfo = "Chrome " + versionFilter.substring(0, versionFilter.indexOf(".")) + ".0x";
		}
	    else if(BrowserInfo.indexOf("Windows") != -1) BrowserInfo = "FireFox " + BrowserInfo.substring(0,3) + "x";
	    else BrowserInfo = "Unknown";
	}

	var hiCisIcon = document.getElementById("cisShortCut");
	
	var clientIP = hiCisIcon.isLocalIP;				// IP 주소
	var macAddress	= hiCisIcon.DefaultMAC;		// MAC 주소
	var hddSerialNo	= hiCisIcon.HddSerial;		// HDD Serial
	var cpu	= hiCisIcon.Pcinfo;							// cup Serial
	var ram	= hiCisIcon.Meminfo;						// ram Serial
	var hddsize	= hiCisIcon.IsHddUse;			// HDD Size
	var os = hiCisIcon.WinOS;							// OS

//	frm.clientIP.value=clientIP;
	frm.os.value=os;
	frm.macAddress.value=macAddress;
	frm.hddSerialNo.value=hddSerialNo;
	frm.cpu.value=cpu;
	frm.ram.value=ram;
	frm.hddsize.value=hddsize;
	frm.clientBrowserVersion.value=BrowserInfo;
	frm.OSBit.value=OSBit;
	frm.action='<%= request.getContextPath()%>/H_Login.do';
	frm.cmd.value = 'setLogin';
	frm.rtnUrl.value=url;//escape(url);

	frm.submit();

}
document.onkeypress = keyPress ;

function keyPress(){
	var ieKey = window.event.keyCode ;
	if( ieKey == 13 ){
		login();
	}
}

function loginInit(){

	var frm=document.loginForm;
    
	if('<%=msg %>'!='INIT'){
		alert('<%=msg %>');
		//location.href="/";
	}

	var cUserId = getCookie("huation_UserId");

	if( cUserId != null && trim(cUserId) != '' && cUserId != 'null' ){
		frm.text_id.value = getCookie("huation_UserId");
		frm.saveId.checked = true;
	}

	if(frm.text_id.value == "" ) {
		frm.text_id.focus();
	} else {
		frm.text_password.focus();
	}

}
function hiCisIconTest() {
	
	var hiCisIcon = document.getElementById("cisShortCut");
	
	var clientIP = hiCisIcon.isLocalIP;				// IP 주소
	var macAddress	= hiCisIcon.DefaultMAC;		// MAC 주소
	var hddSerialNo	= hiCisIcon.HddSerial;		// HDD Serial
	var cpu	= hiCisIcon.Pcinfo;							// cup Serial
	var ram	= hiCisIcon.Meminfo;						// ram Serial
	var hddsize	= hiCisIcon.IsHddUse;			// HDD Size
	var os = hiCisIcon.WinOS;							// OS
	
	alert("IP 주소 : " + clientIP + "\r\n" + 
			"MAC 주소 : " + macAddress+ "\r\n" + 
			"hddSerialNo  : " + hddSerialNo + "\r\n" + 
			"cpu  : " + cpu + "\r\n" + 
			"ram  : " + ram + "\r\n" + 
			"hddsize  : " + hddsize );
}

function axcisRegifail() {
	//alert("HiCisIcon 설치 실패!!!");
}
function scanDownload(){
	var OSBit = navigator.userAgent;
	
	location.href='<%=request.getContextPath()%>/fileDownServlet?rFileName=HF_IScan100_Setup.exe&sFileName=HF_IScan100_Setup.exe';
	
	/*
	if(OSBit.indexOf("Win64") != -1) {//64bit
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IScan100_Setup_x64.exe';
	
	}else {
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IScan100_Setup.exe';
		
	}
	*/
	
}
function moveindex(obj){
   return;
	var str=obj.value;

	if(str.length==6){
		document.loginForm.text_password.focus();
	}
	
}

function makeicon() {
	   var WshShell = new ActiveXObject('WScript.Shell'); 
	   strDesktop = WshShell.SpecialFolders('Desktop'); 
	   var oUrlLink = WshShell.CreateShortcut(strDesktop + '\\대한생명 이미지 팩스.url'); 
	   oUrlLink.TargetPath = 'http://callfax.korealife.com:8001';
	   oUrlLink.Save(); 	
}
</script>
</head>

<body id="login_wrap"  onload="loginInit();">
<%
	if("SSO".equals(msg)){
%>


 <form name = "loginForm" method = "post" >
	<input type="hidden" name="cmd" >
	<input type="hidden" name="rtnUrl">
	<input type="hidden" name="clientIP" value="<%=ipaddress %>">
	<input type="hidden" name="os">
	<input type="hidden" name="macAddress">
	<input type="hidden" name="hddSerialNo">
	<input type="hidden" name="cpu">
	<input type="hidden" name="ram">
	<input type="hidden" name="hddsize">
	<input type="hidden" name="clientBrowserVersion">
	<input type="hidden" name="OSBit">
	<input type="hidden" name="sso_id" value="<%=sso_id%>">
	<input type="hidden" name="id " value="0000000000">
	<input type="hidden" name="password">
	<input type="hidden" name="saveId">
	<input type="hidden" name="text_id">
	<input type="hidden" name="text_password">
</form>
<%
	}else{
%>
 <form name = "loginForm" method = "post" >
	<input type="hidden" name="cmd" >
	<input type="hidden" name="rtnUrl">
	<input type="hidden" name="clientIP" value="<%=ipaddress %>">
	<input type="hidden" name="os">
	<input type="hidden" name="macAddress">
	<input type="hidden" name="hddSerialNo">
	<input type="hidden" name="cpu">
	<input type="hidden" name="ram">
	<input type="hidden" name="hddsize">
	<input type="hidden" name="clientBrowserVersion">
	<input type="hidden" name="OSBit">
	<input type="hidden" name="sso_id" value="N">
	<input type="hidden" name="id">
	<input type="hidden" name="password">
	 <!-- 컨테이너 시작 -->
    <div id="login_container">
	
    	
        <!-- 로그인탑 시작 -->
    	<div id="login_top"><img src="<%= request.getContextPath() %>/images/login/addys-login_logo.jpg" alt="HUEFAX - Fax System Login" /></div>
		<!-- 로그인탑 끝 -->
        
        <!-- 로그인박스 시작 -->
		<div id="login_box"> 
           <table cellspacing="0" cellpadding="0" id="login">
              <tr>
                <td class="text"><img src="<%= request.getContextPath() %>/images/login/text_userid.gif" /></td>
                <td><input type="text" name="text_id" value="" maxlength="10" onKeyUp="moveindex(this);" tabindex="1" class="input" /></td>
                <td rowspan="2"><a href="javascript:login();"><img src="<%= request.getContextPath() %>/images/login/btn_login.gif" onmouseover="this.src='<%= request.getContextPath() %>/images/login/btn_login_on.gif'" onclick="this.src='<%= request.getContextPath() %>/images/login/btn_login_click.gif'" onmouseout="this.src='<%= request.getContextPath() %>/images/login/btn_login.gif'" title="Login" /></a></td>
              </tr>
              <tr>
                <td class="text"><img src="<%= request.getContextPath() %>/images/login/text_password.gif" /></td>
                <td><input type="password" name="text_password" maxlength="12" tabindex="2" class="input" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="idsave">
                  <input type="checkbox"  name="saveId" id="save_id" id="checkbox" />사용자ID 저장</td>
                 <td>&nbsp;</td>
              </tr>
            </table>
        </div> 
        <!-- 로그인박스 끝 -->
    </div>
    <!-- 컨테이너 끝 -->
 </form>
<%
	}
%>
</body>
</html>