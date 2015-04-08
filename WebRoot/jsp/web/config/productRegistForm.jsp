<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
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
<title>��ǰ ���</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
//ID check 
function fnDuplicateCheck(val) {
	if($('#productRegist [name=productCode]').val() == ""){
		$('#productRegist #chkAlert').hide();
	}else{
		
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Master.do?cmd=productDupCheck",
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"productcode" : val
		},
		success : function(data, textStatus, XMLHttpRequest){
			//alert(data);
				switch (data){
				case "" : alert("��ǰ�ڵ� �ߺ� üũ ����!");break;
				case "1": 
					$('#productRegist #chkAlert').attr("color","red");
					$('#productRegist #chkAlert').show().html("�̹� ��� ���Դϴ�.");break;
				case "2":
					$('#productRegist #chkAlert').attr("color","red");
					$('#productRegist #chkAlert').show().html("��� �Ұ����մϴ�.");break;
				case "0":
					$('#productRegist #chkAlert').attr("color","blue");
					$('#productRegist #chkAlert').show().html("��� �����մϴ�.");break;
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
// ����
function goSave(){
	
	var frm = document.productRegist; 
	if(frm.productName.value.length == 0){
		alert("ǰ���� �Է��ϼ���");
		return;
	}
	
	if(frm.productCode.value.length == 0){
		alert("ǰ���ڵ带 �Է��ϼ���");
		return;
	}
	
	if($('#productRegist #chkAlert').attr("color")== "red"){
		alert("ǰ���ڵ带 Ȯ���ϼ���");
		return;
	}
	
	if(frm.CompanyCode.value.length == 0){
		alert("����ó�� �����ϼ���.");
		return;
	}

	if(confirm(frm.productName.value+"ǰ���� ��� �Ͻðڽ��ϱ�?")){
		frm.submit();
	}else{
		return;
	}

}
</script>
</head>
<!-- ó���� ���� -->
<!-- ó���� ���� -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=productRegist id="productRegist"  action="<%=request.getContextPath()%>/H_Master.do?cmd=productRegist">
	  
	  <!-- ���������� -->
	  <div class="ly_pop_new">
	      <!-- ���̺� ���� -->
				<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">ǰ��� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="35" name="productName" id="productName" maxlength="30" value="" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>ǰ���ڵ� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="productCode" id="productCode" maxlength="20" value="" tabindex="3" onkeyup="fnDuplicateCheck(this.value)" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>���ڵ�</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="BarCode" maxlength="14" value="" tabindex="4" dispName="���ڵ�" /></td>
	                        </tr>
	                       <tr>
	                            <th>����ó <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<%
									    codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("����");
										codeParam.setName("CompanyCode");
										codeParam.setSelected(""); 
										codeParam.setEvent(""); 
										out.print(CommonUtil.getCodeListCompany(codeParam)); 
									%>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>�԰�ܰ�</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="ProductPrice" maxlength="14" value="" tabindex="4" dispName="�԰�ܰ�" /></td>
	                        </tr>
	                       <tr>
	                            <th>�ΰ�������</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="VatRate" maxlength="14" value="" tabindex="4" dispName="�ΰ�������" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�1</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1" maxlength="14" value="" tabindex="4" dispName="���ڵ�" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�1��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                         <tr>
	                            <th>�׷�2</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�2��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>      
	                         <tr>
	                            <th>�׷�3</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�3��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>            
	                    </tbody>
	                </table>
			   </div>
	           <!-- ���̺� �� -->
			   <!-- bottom ���� -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="���" /></a><a href="javascript:goClosePop('productRegistForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
				<!-- bottom �� -->
			</div>
			<!-- �������� -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
			</div>
</form>
</body>
</html>
