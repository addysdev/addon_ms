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
String menuAuth="";//�޴�����

CodeParam codeParam = new CodeParam();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����� ���</title>
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
				case "" : alert("�����ID �ߺ� üũ ����!");break;
				case "1": 
					$('#UserRegist #chkAlert').attr("color","red");
					$('#UserRegist #chkAlert').show().html("�̹� ��� ���Դϴ�.");break;
				case "2":
					$('#UserRegist #chkAlert').attr("color","red");
					$('#UserRegist #chkAlert').show().html("��� �Ұ����մϴ�.");break;
				case "0":
					$('#UserRegist #chkAlert').attr("color","blue");
					$('#UserRegist #chkAlert').show().html("��� �����մϴ�.");break;
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
function goSave(){
	var frm = document.UserRegist; 
	if(frm.userName.value.length == 0){
		alert("����� �̸��� �Է��ϼ���");
		return;
	}
	
	if(frm.employeeID.value.length == 0){
		alert("�����ID�� �Է��ϼ���");
		return;
	}
	
	if($('#UserRegist #chkAlert').attr("color")== "red"){
		alert("�����ID�� Ȯ���ϼ���");
		return;
	}
	
	if(frm.GroupName.value.length == 0){
		alert("������ �����ϼ���.");
		return;
	}
	
	if(frm.Password.value.length == 0){
		alert("��й�ȣ�� �Է��ϼ���.");
		return;
	}
	
	if(frm.RePassword.value.length == 0){
		alert("��й�ȣ ���Է��ϼ���.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value){
		alert("��й�ȣ�� �ٸ��ϴ�.");
		return;
	}
	

	frm.submit();

}

//user�׷� ���� �˾�
function goGroupForm(userid) {
	var GroupID = $('#UserRegist #GroupID').val();
	
	if(GroupID != ""){
		if(confirm("���� ���� �� �ѽ���ȣ�� �ʱ�ȭ�˴ϴ�.\n�����Ͻðڽ��ϱ�?")){
			$('#UserRegist #DID').val("");
		}else{
			return;
		}
	}
	
	
	
	$('#userGroupForm').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userGroupTree',{
				"FormName" : "UserRegist",
				"PopName" : "userGroupForm"
			});
		}
	});
}

//user ��ȸ���� ���� �˾�
function goSearchAuthForm(userid) {
	$('#userSearchAuthForm').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 350,
		width : 300,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userSearchAuthTree',{
				"FormName" : "UserRegist"
			});
		}
	});
}

//user �ѽ���ȣ ���� �˾�
function goSearchFaxNum() {
	
	//GroupID ���õǾ����� Ȯ��
	var GroupID = $('#UserRegist #GroupID').val();
	if(GroupID == ""){
		alert("���� ���� �� �ѽ���ȣ�� ������ �ּ���.");
		return;
	}else{
		
	}
	
	$('#UserRegistfaxNumList').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 450,
		width : 450,
		modal : true,
		position : {
			my : 'left',
			at : 'right',
			of : $('#userForm')
		},
		open:function(){
			//�˾� ������ url
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
		$('#UserRegist #chkPwAlert').show().html("��й�ȣ�� �ٸ��ϴ�.");
	}else{
		$('#UserRegist #chkPwAlert').attr("color","blue");
		$('#UserRegist #chkPwAlert').show().html("��й�ȣ�� �����ϴ�.");
	}
	
	if(rePw == ""){
		$('#UserRegist #chkPwAlert').hide();
	}
}


</script>
</head>
<!-- ó���� ���� -->
<!-- ó���� ���� -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=UserRegist id="UserRegist"  action="<%=request.getContextPath()%>/H_User.do?cmd=userRegist">
	  
	  <!-- ���������� -->
	  <div class="ly_pop_new">
	      <!-- ���̺� ���� -->
				<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">����ڸ� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="userName" id="userName" maxlength="30" value="" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>�����ID <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="employeeID" id="employeeID" maxlength="20" value="" tabindex="3" onkeyup="fnDuplicateCheck(this.value)" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>��ȭ��ȣ</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="OfficeTellNo" maxlength="14" value="" tabindex="4" dispName="�ѽ���ȣ" onKeyUp="format_phone(this);"/></td>
	                        </tr>
	                      <tr>
	                          <th>���� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
								<input type="text" size="20" name="GroupName"  id="GroupName" value="" tabindex="4" dispName="����" onKeyUp="" readonly="readonly" onclick="javascript:goGroupForm()"/>
								<input name="GroupID" id="GroupID" type="hidden"  value="" /><a href="javascript:goGroupForm()" id="GroupBt" title="��ȸ" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- ��ȸ��ư -->
	                			</td>
	                        </tr>	      
	                        <tr>
	                            <th>��뿩��</th>
	                            <td><input type="radio" name="UseYN" id="radio3" value="Y" checked /> <span class="vm">���</span>
	  								<input type="radio" name="UseYN" id="radio4" value="N" /><span class="vm"> �̻��</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>��й�ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="password" name="Password" size="20" maxlength="50" value="" tabindex="5"/></td>
	                        </tr>
	                        <tr>
	                            <th>��й�ȣ ���Է� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<input type="password" size="20" name="RePassword" maxlength="50" value="" tabindex="6" 
	                            	onkeyup="checkPw(this.value)"	/>
	                            	<font style="display: none;" id="chkPwAlert" >��й�ȣ�� �ٸ��ϴ�.</font>	                            
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   
			   <!-- ���̾ƿ� �׷��˾� -->
			   <div id="userGroupForm" title="��������"></div>
			   <div id="userSearchAuthForm" title="��ȸ���Ѽ���"></div>
			   <!-- ���̾ƿ� �׷��˾� �� -->
			   
	           <!-- ���̺� �� -->
			   <!-- bottom ���� -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="���" /></a><a href="javascript:goClosePop('userRegistForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
				<!-- bottom �� -->
			</div>
			<!-- �������� -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
			</div>
</form>
</body>
</html>
