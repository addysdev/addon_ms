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
String menuAuth="";//�޴�����

CodeParam codeParam = new CodeParam(); */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����� ���</title>
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
				case "" : alert("����� ��� �ߺ� üũ ����!");break;
				case "1": 
					$('#UserModify #chkAlert').attr("color","red");
					$('#UserModify #chkAlert').show().html("�̹� ��� ���Դϴ�.");break;
				case "2":
					$('#UserModify #chkAlert').attr("color","red");
					$('#UserModify #chkAlert').show().html("��� �Ұ����մϴ�.");break;
				case "0":
					$('#UserModify #chkAlert').attr("color","blue");
					$('#UserModify #chkAlert').show().html("��� �����մϴ�.");break;
				}	
			
			/*
			if(data != 0){
				check=1;		
			}
			*/
		},
		error : function(request, status, error){
			alert("�ߺ�üũ ����!");
		}
	});
	}
	
}

// ���
function goModify(){
	
	var frm = document.UserModify; 
	
	if(confirm("�������� �� ���� �Ͻðڽ��ϱ�?")){
		
	}else{
		return;
	}

	if(frm.userName.value.length == 0){
		alert("����� �̸��� �Է��ϼ���");
		return;
	}
	
	if(frm.GroupName.value.length == 0){
		alert("������ �����ϼ���.");
		return;
	}

	if(frm.RePassword.value.length == 0 && frm.Password.value.length > 0){
		alert("��й�ȣ ���Է��ϼ���.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value){
		alert("��й�ȣ�� �ٸ��ϴ�.");
		return;
	}


	frm.submit();

}

//user���� ���� �˾�
function goGroupForm2(userid) {
	$('#userGroupForm2').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm2')
		},
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userGroupTree',{
				"FormName" : "UserModify",
				"PopName" : "userGroupForm2"
				
			});
		}
	});
}

//user ��ȸ���� ���� �˾�
function goSearchAuthForm2(userid) {
	$('#userSearchAuthForm2').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm2')
		},
		open:function(){
			
			//�˾� ������ url
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
		$('#UserModify #chkPwAlert').show().html("��й�ȣ�� �ٸ��ϴ�.");
	}else{
		$('#UserModify #chkPwAlert').attr("color","blue");
		$('#UserModify #chkPwAlert').show().html("��й�ȣ�� �����ϴ�.");
	}
	
	if(rePw == ""){
		$('#UserModify #chkPwAlert').hide();
	}
}

//��ȸ���� �˶����� ����
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
	  <!-- ���������� -->
	  <div class="ly_pop_new">
	      <!-- ���̺� ���� -->
				<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div id="userForm2" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">����ڸ� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="userName" id="userName" maxlength="30" value="<%=userDto.getUserName() %>" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>�����ID <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<%=userDto.getUserID() %>
	                            	 <input type="hidden" name="employeeID" id="employeeID" value="<%=userDto.getUserID()%>"/>
	                            	<%-- <input type="text" size="20" name="employeeID" id="employeeID" maxlength="20" value="<%=userDto.getUserID() %>" tabindex="3" onkeyup="fnDuplicateCheck2(this.value)" style="IME-MODE : disabled"/> --%>
	                            	<!-- <font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font> -->
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>��ȭ��ȣ</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="OfficeTellNo" maxlength="14" value="<%=userDto.getOfficePhoneFormat() %>" tabindex="4" dispName="�ѽ���ȣ" onKeyUp="format_phone(this);"/></td>
	                        </tr>
	                      <tr>
	                          <th>���� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
									<input type="text" size="20" name="GroupName"  id="GroupName" value="<%=userDto.getGroupName() %>" tabindex="4" dispName="�Ҽ�" onKeyUp="" readonly="readonly" onclick="javascript:goGroupForm2()"/>
									<input name="GroupID" id="GroupID" type="hidden"  value="<%=userDto.getGroupID() %>" /><a href="javascript:goGroupForm2()" id="GroupBt" title="��ȸ" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- ��ȸ��ư -->
	                			</td>
	                        </tr>	      
	                        <tr>
	                            <th>��뿩��</th>
	                            <td><input type="radio" name="UseYN" id="radio3" value="Y" checked /> <span class="vm">���</span>
	  								<input type="radio" name="UseYN" id="radio4" value="N" /><span class="vm"> �̻��</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>�ű� ��й�ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="password" name="Password" size="20" maxlength="50" value="" tabindex="5"/></td>
	                        </tr>
	                        <tr>
	                            <th>�ű� ��й�ȣ ���Է� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<input type="password" size="20" name="RePassword" maxlength="50" value="" tabindex="6" 
	                            	onkeyup="checkPw(this.value)"	/>
	                            	<font style="display: none;" id="chkPwAlert" >��й�ȣ�� �ٸ��ϴ�.</font>	                            
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   
			   <!-- ���̾ƿ� �����˾� -->
			   <div id="userGroupForm2" title="��������"></div>
			   <div id="userSearchAuthForm2" title="��ȸ���Ѽ���"></div>
			   <!-- ���̾ƿ� �����˾� �� -->
			   
	           <!-- ���̺� �� -->
			   <!-- bottom ���� -->
				<div class="ly_foot"><a href="javascript:goModify()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="����" /></a><a href="javascript:goClosePop('userModifyForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
				<!-- bottom �� -->
			</div>
			<iframe class="sbBlind sbBlind_userModifyForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
			<!-- �������� -->
		</div>
</form>
</body>
</html>
