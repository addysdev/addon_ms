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
String userid=StringUtil.nvl(dtoUser.getUserId(),"");
String menuAuth="";//메뉴권한

CodeParam codeParam = new CodeParam();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사용자 등록</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
//ID check 
function fnDuplicateCheck(val) {
	if($('#UserRegist [name=employeeID]').val() == ""){
		$('#UserRegist #chkAlert').hide();
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
			//alert(data);
				switch (data){
				case "" : alert("사용자ID 중복 체크 오류!");break;
				case "1": 
					$('#UserRegist #chkAlert').attr("color","red");
					$('#UserRegist #chkAlert').show().html("이미 사용 중입니다.");break;
				case "2":
					$('#UserRegist #chkAlert').attr("color","red");
					$('#UserRegist #chkAlert').show().html("사용 불가능합니다.");break;
				case "0":
					$('#UserRegist #chkAlert').attr("color","blue");
					$('#UserRegist #chkAlert').show().html("사용 가능합니다.");break;
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
function goSave(){
	var frm = document.UserRegist; 
	if(frm.userName.value.length == 0){
		alert("사용자 이름을 입력하세요");
		return;
	}
	
	if(frm.employeeID.value.length == 0){
		alert("사용자ID를 입력하세요");
		return;
	}
	
	if($('#UserRegist #chkAlert').attr("color")== "red"){
		alert("사용자ID를 확인하세요");
		return;
	}
	
	if(frm.GroupName.value.length == 0){
		alert("조직을 선택하세요.");
		return;
	}
	
	if(frm.Password.value.length == 0){
		alert("비밀번호를 입력하세요.");
		return;
	}
	
	if(frm.RePassword.value.length == 0){
		alert("비밀번호 재입력하세요.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value){
		alert("비밀번호가 다릅니다.");
		return;
	}
	

	frm.submit();

}

//user그룹 선택 팝업
function goGroupForm(userid) {
	var GroupID = $('#UserRegist #GroupID').val();
	
	if(GroupID != ""){
		if(confirm("조직 변경 시 팩스번호가 초기화됩니다.\n변경하시겠습니까?")){
			$('#UserRegist #DID').val("");
		}else{
			return;
		}
	}
	
	
	
	$('#userGroupForm').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userGroupTree',{
				"FormName" : "UserRegist",
				"PopName" : "userGroupForm"
			});
		}
	});
}

//user 조회권한 선택 팝업
function goSearchAuthForm(userid) {
	$('#userSearchAuthForm').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userSearchAuthTree',{
				"FormName" : "UserRegist"
			});
		}
	});
}

//user 팩스번호 선택 팝업
function goSearchFaxNum() {
	
	//GroupID 선택되었는지 확인
	var GroupID = $('#UserRegist #GroupID').val();
	if(GroupID == ""){
		alert("조직 선택 후 팩스번호를 선택해 주세요.");
		return;
	}else{
		
	}
	
	$('#UserRegistfaxNumList').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 450,
		width : 450,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userFaxNumList',{
				"FormName" : "UserRegist",
				"GroupID" : GroupID
			});
		},
		close:function(){
			if($('#UserRegist #DID').val() != ""){
				$('#UserRegist [name=EchoYN]').removeAttr("disabled");
				$('#UserRegist [name=AlarmYN]').removeAttr("disabled");
			}
		}
	});
}

function checkPw(rePw){
	var Pw = $('#UserRegist [name=Password]').val();
	
	if(Pw != rePw){
		$('#UserRegist #chkPwAlert').attr("color","red");
		$('#UserRegist #chkPwAlert').show().html("비밀번호가 다릅니다.");
	}else{
		$('#UserRegist #chkPwAlert').attr("color","blue");
		$('#UserRegist #chkPwAlert').show().html("비밀번호가 같습니다.");
	}
	
	if(rePw == ""){
		$('#UserRegist #chkPwAlert').hide();
	}
}


</script>
</head>
<!-- 처리중 시작 -->
<!-- 처리중 종료 -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=UserRegist id="UserRegist"  action="<%=request.getContextPath()%>/H_User.do?cmd=userRegist">
	  
	  <!-- 컨텐츠시작 -->
	  <div class="ly_pop_new">
	      <!-- 테이블 시작 -->
				<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">사용자명 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="userName" id="userName" maxlength="30" value="" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>사용자ID <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="employeeID" id="employeeID" maxlength="20" value="" tabindex="3" onkeyup="fnDuplicateCheck(this.value)" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>전화번호</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="OfficeTellNo" maxlength="14" value="" tabindex="4" dispName="팩스번호" onKeyUp="format_phone(this);"/></td>
	                        </tr>
	                      <tr>
	                          <th>조직 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
								<input type="text" size="20" name="GroupName"  id="GroupName" value="" tabindex="4" dispName="조직" onKeyUp="" readonly="readonly" onclick="javascript:goGroupForm()"/>
								<input name="GroupID" id="GroupID" type="hidden"  value="" /><a href="javascript:goGroupForm()" id="GroupBt" title="조회" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- 조회버튼 -->
	                			</td>
	                        </tr>	      
	                        <tr>
	                            <th>사용여부</th>
	                            <td><input type="radio" name="UseYN" id="radio3" value="Y" checked /> <span class="vm">사용</span>
	  								<input type="radio" name="UseYN" id="radio4" value="N" /><span class="vm"> 미사용</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>비밀번호 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="password" name="Password" size="20" maxlength="50" value="" tabindex="5"/></td>
	                        </tr>
	                        <tr>
	                            <th>비밀번호 재입력 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<input type="password" size="20" name="RePassword" maxlength="50" value="" tabindex="6" 
	                            	onkeyup="checkPw(this.value)"	/>
	                            	<font style="display: none;" id="chkPwAlert" >비밀번호가 다릅니다.</font>	                            
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   
			   <!-- 레이아웃 그룹팝업 -->
			   <div id="userGroupForm" title="조직선택"></div>
			   <div id="userSearchAuthForm" title="조회권한선택"></div>
			   <!-- 레이아웃 그룹팝업 끝 -->
			   
	           <!-- 테이블 끝 -->
			   <!-- bottom 시작 -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="등록" /></a><a href="javascript:goClosePop('userRegistForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
				<!-- bottom 끝 -->
			</div>
			<!-- 컨텐츠끝 -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
			</div>
</form>
</body>
</html>
