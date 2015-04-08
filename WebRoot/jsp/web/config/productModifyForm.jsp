<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.config.ProductDTO"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ include file ="/jsp/web/common/base.jsp" %>
<%
String userid=StringUtil.nvl(dtoUser.getUserId(),"");
String menuAuth="";//�޴�����

ProductDTO productDto = (ProductDTO)model.get("productDto");

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
	if($('#productModify [name=employeeID]').val() == ""){
		$('#productModify #chkAlert').hide();
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
					$('#productModify #chkAlert').attr("color","red");
					$('#productModify #chkAlert').show().html("�̹� ��� ���Դϴ�.");break;
				case "2":
					$('#productModify #chkAlert').attr("color","red");
					$('#productModify #chkAlert').show().html("��� �Ұ����մϴ�.");break;
				case "0":
					$('#productModify #chkAlert').attr("color","blue");
					$('#productModify #chkAlert').show().html("��� �����մϴ�.");break;
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
	var frm = document.productModify; 
	
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

	if(frm.Recovery[0].checked==true){
		frm.RecoveryYN.value='N';
	}else{
		frm.RecoveryYN.value='Y';	
	}
	
	if(frm.RecoveryYN.value=='Y'){
		if(confirm(frm.productName.value+"ǰ���� ȸ�� �Ͻðڽ��ϱ�?\nȸ���� ��� ������ ������ ������� ������ 0 �� �Ǹ�\n�������� ȸ����� ���Ե˴ϴ�.")){
			frm.submit();
		}else{
			return;
		}
	}else{
		if(confirm(frm.productName.value+"ǰ���� ���� �Ͻðڽ��ϱ�?")){
			frm.submit();
		}else{
			return;
		}
	}
}

//������� ���� ���̾ƿ� �˾�
function safeStockList(){
	
	if( document.productModify.RecoveryYN.value=='Y'){

		alert('ȸ�� ���¿��� ������� ������ �Ұ����մϴ�.\n���°��� ������·� �����Ͽ� ������ ��ȸ�Ͻʽÿ�.');
		return;
	}
	
	
	$('#safeStockList').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 450,
		width : 450,
		autoOpen : false,
		modal : true,
		
		position : {
			my: 'left',
			at: 'right',
			of: $('#safeStoks')
		},
		
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=safeStockList',{
				"productcode" : $('#productCode').val() 
			});
		}
	});
	$( "#safeStockList" ).dialog( "open" );
}
//���࿩�� ����
$(function(){
	
	var RecoveryYN 	= "<%=productDto.getRecoveryYN()%>";
	var frm = document.productModify; 
	
	switch (RecoveryYN){
	case "N" : 
		 $('#productModify #radio1').attr("checked","checked");
		break;
	case "Y" : 
		 $('#productModify #radio2').attr("checked","checked");
		break;
	}

});
</script>
</head>
<!-- ó���� ���� -->
<!-- ó���� ���� -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=productModify id="productModify"  action="<%=request.getContextPath()%>/H_Master.do?cmd=productModify">
	  
	  <!-- ���������� -->
	  <div class="ly_pop_new">
	      <!-- ���̺� ���� -->
				<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">ǰ��� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="35" name="productName" id="productName" maxlength="30"  value="<%=productDto.getProductName() %>" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>ǰ���ڵ� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="productCode" id="productCode" readOnly maxlength="20" value="<%=productDto.getProductCode() %>"  tabindex="3" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>���ڵ�</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="BarCode" maxlength="14" value="<%=productDto.getBarCode() %>"  tabindex="4" dispName="���ڵ�" onKeyUp="format_phone(this);"/></td>
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
										codeParam.setSelected(productDto.getCompanyCode()); 
										codeParam.setEvent(""); 
										out.print(CommonUtil.getCodeListCompany(codeParam)); 
									%>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>����������</th>
	                            <input type="hidden" name="RecoveryYN" value="<%=productDto.getRecoveryYN()%>">
	                            <td>
	                            ����:
	                            <%
	                            	if(productDto.getRecoveryYN().equals("Y")){
	                            %>
	                            	   ȸ��
	                            <%		
	                            	}else{
	                             %>
	                             ����
	                              <%		
	                            	}
	                            %>
	                            <input type="radio" name="Recovery" id="radio1" value="N"  /> <span class="vm">����</span>
	  								<input type="radio" name="Recovery" id="radio2" value="Y" /><span class="vm"> ȸ��</span>
	  								<a href="javascript:safeStockList()" id="safeStoks" title="��ȸ" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- ��ȸ��ư -->
	                            </td>
	                        </tr>
	                          <tr>
	                            <th>�԰�ܰ�</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="ProductPrice" maxlength="14" value="<%=productDto.getProductPrice()%>" tabindex="4" dispName="�԰�ܰ�" /></td>
	                        </tr>
	                       <tr>
	                            <th>�ΰ�������</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="VatRate" maxlength="14" value="<%=productDto.getVatRate()%>" tabindex="4" dispName="�ΰ�������" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�1</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1" maxlength="14" value="<%=productDto.getGroup1() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�1��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1name" maxlength="14" value="<%=productDto.getGroup1Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                         <tr>
	                            <th>�׷�2</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2" maxlength="14" value="<%=productDto.getGroup2() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�2��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2name" maxlength="14" value="<%=productDto.getGroup2Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>      
	                         <tr>
	                            <th>�׷�3</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3" maxlength="14" value="<%=productDto.getGroup3() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>�׷�3��</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3name" maxlength="14" value="<%=productDto.getGroup3Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>              

	                    </tbody>
	                </table>
			   </div>
			   <!-- ���̾ƿ� �׷��˾� -->
			   <div id="safeStockList" title="����������"></div>
			   <!-- ���̾ƿ� �׷��˾� �� -->
			   
	           <!-- ���̺� �� -->
			   <!-- bottom ���� -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="����" /></a><a href="javascript:goClosePop('productModifyForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
				<!-- bottom �� -->
			</div>
			<!-- �������� -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
			</div>
</form>
</body>
</html>
