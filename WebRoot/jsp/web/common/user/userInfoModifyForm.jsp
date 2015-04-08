<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.user.UserDAO"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.CommonDAO"%>

<%@ include file="/jsp/web/common/base.jsp"%>

<%
	CommonDAO comDao=new CommonDAO();
	UserDTO userDto = (UserDTO)model.get("userDto");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>나의 정보수정</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script>

var observer;

function init() {

	openWaiting();

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100); // 0.1초마다 확인

}

function goSave(){

	var frm = document.UserInfoModifyForm; 
	var invalid = ' ';	//공백 체크
	
	if(frm.Password.value == '' || frm.RePassword.value == ''){
		alert("비밀번호를 입력해 주세요.");
		return;
	}
	
	if(frm.Password.value.indexOf(invalid) > -1 || frm.RePassword.value.indexOf(invalid) > -1){
		alert("비밀번호에 공백을 넣을 수 없습니다.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value) {
		alert("입력하신 비밀번호가 재입력하신 비밀번호와 일치하지 않습니다.");
		return;
	}

	if(confirm("수정 하시겠습니까?")){
		frm.action='<%=request.getContextPath()%>/H_Common.do?cmd=userInfoModify';
		//alert(frm.action);
		frm.submit();
	}
}

//배정여부 수정
function goCallSave(){

	var frm = document.UserInfoModifyForm; 
	var invalid = ' ';	//공백 체크
		

	if(confirm("수정 하시겠습니까?")){
		frm.action='<%=request.getContextPath()%>/H_Common.do?cmd=userCallInfoModify';
		//alert(frm.action);
		frm.submit();
	}
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
<body id="popup" onLoad="init()" class="pop_body_bgAll">
<form method="post" name="UserInfoModifyForm" action="<%=request.getContextPath()%>/H_User.do?cmd=userInfoModify">
    <!-- 레이아웃 시작 -->
	<div id="wrap_400">
	
	      <!-- TOP 타이틀 시작 -->
	      <div id="header">
	          <div class="pop_top">
	              <p><img src="<%=request.getContextPath()%>/images/popup/text_myinfo.gif" alt="My Info" /></p>
	          </div>
	      </div>
	      <!-- TOP 타이틀 끝 -->
	  
	      <!-- 메인컨텐츠 시작 -->
	      <div id="pop_contents">

	      <!-- 테이블 시작 -->
		  <div class="pop_list_box">
				<p class="listNm"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div id="obform" class="tbl_type_out">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th width="145px">사용자 ID <strong class="blueTxt" title="필수입력">*</strong></th> 
	                            <td scope="col" class="input_box_dark"><input name="ID" type="text" size="25" value='<%=StringUtil.nvl(userDto.getUserID(), "") %>' readOnly/></td>
	                        </tr>
	                        <tr>
	                            <th >사용자명 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td scope="col"  class="input_box_dark">
	                                <input name="Name" type="text" size="25" value='<%=StringUtil.nvl(userDto.getUserName(), "") %>' readOnly/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>기존 비밀번호 <strong class="blueTxt" title="필수입력">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="Ori_Password" type="password" size="25" value=''/></td>
	                        </tr>
	                        <tr>
	                            <th>신규 비밀번호 <strong class="blueTxt" title="필수입력">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="Password" type="password" size="25" value=''/></td>
	                        </tr>
	                        <tr>
	                            <th>신규 비밀번호 재입력 <strong class="blueTxt" title="필수입력">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="RePassword" type="password" size="25" value=''/></td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   </div>
			   <!-- 테이블 끝 -->
			   <!-- bottom 시작 -->
				<div id="bottom">
					<div class="bottom_top"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="수정" /></a><a href="javascript:window.close()"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a></div>
				</div>
				<!-- bottom 끝 -->

	  	</div>
		<!-- 메인컨텐츠 끝 -->
	</div>
	<!-- 레이아웃 끝 -->
</body>
</html>