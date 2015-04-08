<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.user.UserDTO"%>
<%@ page import ="com.web.common.user.UserDAO"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ include file ="/jsp/web/common/base.jsp" %>
<%
UserDTO userDto = (UserDTO)model.get("userDto");
/* String userid=StringUtil.nvl(dtoUser.getUserId(),"");
String menuAuth="";//메뉴권한

CodeParam codeParam = new CodeParam(); */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사용자 등록</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>

//ID check 
var ori_ID = "<%=userDto.getUserID()%>";
function fnDuplicateCheck2(val) {
	if(ori_ID == val){
		$('#UserModify #chkAlert').attr("color","blue");
		$('#UserModify #chkAlert').hide();
	}else if($('#UserModify [name=employeeID]').val() == ""){
		$('#UserModify #chkAlert').hide();
	}else{
	
	$.ajax({
		url : "<%= request.getContextPath()%>/H_User.do?cmd=userDupCheck",
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"userid" : val
		},
		success : function(data, textStatus, XMLHttpRequest){
				switch (data){
				case "" : alert("사용자 사번 중복 체크 오류!");break;
				case "1": 
					$('#UserModify #chkAlert').attr("color","red");
					$('#UserModify #chkAlert').show().html("이미 사용 중입니다.");break;
				case "2":
					$('#UserModify #chkAlert').attr("color","red");
					$('#UserModify #chkAlert').show().html("사용 불가능합니다.");break;
				case "0":
					$('#UserModify #chkAlert').attr("color","blue");
					$('#UserModify #chkAlert').show().html("사용 가능합니다.");break;
				}	
			
			/*
			if(data != 0){
				check=1;		
			}
			*/
		},
		error : function(request, status, error){
			alert("중복체크 오류!");
		}
	});
	}
	
}

// 등록
function goModify(){
	
	var frm = document.UserModify; 
	
	if(confirm("계정정보 를 수정 하시겠습니까?")){
		
	}else{
		return;
	}

	if(frm.userName.value.length == 0){
		alert("사용자 이름을 입력하세요");
		return;
	}
	
	if(frm.GroupName.value.length == 0){
		alert("조직을 선택하세요.");
		return;
	}

	if(frm.RePassword.value.length == 0 && frm.Password.value.length > 0){
		alert("비밀번호 재입력하세요.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value){
		alert("비밀번호가 다릅니다.");
		return;
	}


	frm.submit();

}

//user조직 선택 팝업
function goGroupForm2(userid) {
	$('#userGroupForm2').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm2')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userGroupTree',{
				"FormName" : "UserModify",
				"PopName" : "userGroupForm2"
				
			});
		}
	});
}

//user 조회권한 선택 팝업
function goSearchAuthForm2(userid) {
	$('#userSearchAuthForm2').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm2')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userSearchAuthTree',{
				"FormName" : "UserModify",
				"UserID" : "<%=userDto.getUserID()%>"
			});
		}
	});
}

function checkPw(rePw){
	var Pw = $('#UserModify [name=Password]').val();
	
	if(Pw != rePw){
		$('#UserModify #chkPwAlert').attr("color","red");
		$('#UserModify #chkPwAlert').show().html("비밀번호가 다릅니다.");
	}else{
		$('#UserModify #chkPwAlert').attr("color","blue");
		$('#UserModify #chkPwAlert').show().html("비밀번호가 같습니다.");
	}
	
	if(rePw == ""){
		$('#UserModify #chkPwAlert').hide();
	}
}

//조회권한 알람여부 세팅
$(function(){
	
	var useYN 	= "<%=userDto.getUseYN()%>";
	
	switch (useYN){
	case "Y" : 
		$('#UserModify #radio3').attr("checked","checked");
		break;
	case "N" : 
		$('#UserModify #radio4').attr("checked","checked");
		break;
	}
	
});

</script>
</head>
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=UserModify id="UserModify"  action="<%=request.getContextPath()%>/H_User.do?cmd=userModify">
	  <input type="hidden" name="ori_DID" value="<%=userDto.getDID()%>"/>
	  <!-- 컨텐츠시작 -->
	  <div class="ly_pop_new">
	      <!-- 테이블 시작 -->
				<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div id="userForm2" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">사용자명 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="userName" id="userName" maxlength="30" value="<%=userDto.getUserName() %>" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>사용자ID <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<%=userDto.getUserID() %>
	                            	 <input type="hidden" name="employeeID" id="employeeID" value="<%=userDto.getUserID()%>"/>
	                            	<%-- <input type="text" size="20" name="employeeID" id="employeeID" maxlength="20" value="<%=userDto.getUserID() %>" tabindex="3" onkeyup="fnDuplicateCheck2(this.value)" style="IME-MODE : disabled"/> --%>
	                            	<!-- <font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font> -->
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>전화번호</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="OfficeTellNo" maxlength="14" value="<%=userDto.getOfficePhoneFormat() %>" tabindex="4" dispName="팩스번호" onKeyUp="format_phone(this);"/></td>
	                        </tr>
	                      <tr>
	                          <th>조직 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
									<input type="text" size="20" name="GroupName"  id="GroupName" value="<%=userDto.getGroupName() %>" tabindex="4" dispName="소속" onKeyUp="" readonly="readonly" onclick="javascript:goGroupForm2()"/>
									<input name="GroupID" id="GroupID" type="hidden"  value="<%=userDto.getGroupID() %>" /><a href="javascript:goGroupForm2()" id="GroupBt" title="조회" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- 조회버튼 -->
	                			</td>
	                        </tr>	      
	                        <tr>
	                            <th>사용여부</th>
	                            <td><input type="radio" name="UseYN" id="radio3" value="Y" checked /> <span class="vm">사용</span>
	  								<input type="radio" name="UseYN" id="radio4" value="N" /><span class="vm"> 미사용</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>신규 비밀번호 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="password" name="Password" size="20" maxlength="50" value="" tabindex="5"/></td>
	                        </tr>
	                        <tr>
	                            <th>신규 비밀번호 재입력 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<input type="password" size="20" name="RePassword" maxlength="50" value="" tabindex="6" 
	                            	onkeyup="checkPw(this.value)"	/>
	                            	<font style="display: none;" id="chkPwAlert" >비밀번호가 다릅니다.</font>	                            
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   
			   <!-- 레이아웃 조직팝업 -->
			   <div id="userGroupForm2" title="조직선택"></div>
			   <div id="userSearchAuthForm2" title="조회권한선택"></div>
			   <!-- 레이아웃 조직팝업 끝 -->
			   
	           <!-- 테이블 끝 -->
			   <!-- bottom 시작 -->
				<div class="ly_foot"><a href="javascript:goModify()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="수정" /></a><a href="javascript:goClosePop('userModifyForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
				<!-- bottom 끝 -->
			</div>
			<iframe class="sbBlind sbBlind_userModifyForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
			<!-- 컨텐츠끝 -->
		</div>
</form>
</body>
</html>
