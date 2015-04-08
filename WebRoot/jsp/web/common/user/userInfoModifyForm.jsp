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
<title>���� ��������</title>
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
	observer = window.setTimeout("init()", 100); // 0.1�ʸ��� Ȯ��

}

function goSave(){

	var frm = document.UserInfoModifyForm; 
	var invalid = ' ';	//���� üũ
	
	if(frm.Password.value == '' || frm.RePassword.value == ''){
		alert("��й�ȣ�� �Է��� �ּ���.");
		return;
	}
	
	if(frm.Password.value.indexOf(invalid) > -1 || frm.RePassword.value.indexOf(invalid) > -1){
		alert("��й�ȣ�� ������ ���� �� �����ϴ�.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value) {
		alert("�Է��Ͻ� ��й�ȣ�� ���Է��Ͻ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		return;
	}

	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%=request.getContextPath()%>/H_Common.do?cmd=userInfoModify';
		//alert(frm.action);
		frm.submit();
	}
}

//�������� ����
function goCallSave(){

	var frm = document.UserInfoModifyForm; 
	var invalid = ' ';	//���� üũ
		

	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%=request.getContextPath()%>/H_Common.do?cmd=userCallInfoModify';
		//alert(frm.action);
		frm.submit();
	}
}
	
</script>
</head>

<!-- ó���� ���� -->
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
<!-- ó���� ���� -->
<body id="popup" onLoad="init()" class="pop_body_bgAll">
<form method="post" name="UserInfoModifyForm" action="<%=request.getContextPath()%>/H_User.do?cmd=userInfoModify">
    <!-- ���̾ƿ� ���� -->
	<div id="wrap_400">
	
	      <!-- TOP Ÿ��Ʋ ���� -->
	      <div id="header">
	          <div class="pop_top">
	              <p><img src="<%=request.getContextPath()%>/images/popup/text_myinfo.gif" alt="My Info" /></p>
	          </div>
	      </div>
	      <!-- TOP Ÿ��Ʋ �� -->
	  
	      <!-- ���������� ���� -->
	      <div id="pop_contents">

	      <!-- ���̺� ���� -->
		  <div class="pop_list_box">
				<p class="listNm"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div id="obform" class="tbl_type_out">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th width="145px">����� ID <strong class="blueTxt" title="�ʼ��Է�">*</strong></th> 
	                            <td scope="col" class="input_box_dark"><input name="ID" type="text" size="25" value='<%=StringUtil.nvl(userDto.getUserID(), "") %>' readOnly/></td>
	                        </tr>
	                        <tr>
	                            <th >����ڸ� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td scope="col"  class="input_box_dark">
	                                <input name="Name" type="text" size="25" value='<%=StringUtil.nvl(userDto.getUserName(), "") %>' readOnly/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>���� ��й�ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="Ori_Password" type="password" size="25" value=''/></td>
	                        </tr>
	                        <tr>
	                            <th>�ű� ��й�ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="Password" type="password" size="25" value=''/></td>
	                        </tr>
	                        <tr>
	                            <th>�ű� ��й�ȣ ���Է� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th> 
	                            <td scope="col" class="input_box"><input name="RePassword" type="password" size="25" value=''/></td>
	                        </tr>
	                    </tbody>
	                </table>
			   </div>
			   </div>
			   <!-- ���̺� �� -->
			   <!-- bottom ���� -->
				<div id="bottom">
					<div class="bottom_top"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="����" /></a><a href="javascript:window.close()"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a></div>
				</div>
				<!-- bottom �� -->

	  	</div>
		<!-- ���������� �� -->
	</div>
	<!-- ���̾ƿ� �� -->
</body>
</html>