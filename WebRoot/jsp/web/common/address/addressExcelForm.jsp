<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	String importResult = StringUtil.nvl((String)model.get("importResult"),"");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title></title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="javascript">
//�ʱ⼼��
<%-- function init() {

	closeWaiting(); //ó���� �޼��� ��Ȱ��ȭ

	if('<%=importResult%>'!=''){
		alert('<%=importResult%>');
	}

} --%>
function goSaveExcel(){

	var frm=document.AddressRegistForm; //form��ü����

	 if(frm.addressFile.value == ""){
		
		alert('���ε��� xls������ ÷���ϼ���');
		return;
		
	}else if(!isImageFile(frm.addressFile.value)){

		return; 				
    } 
	
	openWaiting();
	frm.action = "<%=request.getContextPath() %>/H_Address.do?cmd=AddressExcelImport";
	frm.submit();
}
/**
 *  ���� Ȯ���ڸ� üũ
 *
 **/
function isImageFile( obj ) {
	var strIdx = obj.lastIndexOf( '.' ) + 1;
	//alert(strIdx);
	if ( strIdx == 0 ) {
		return false;
	} else {
		var ext = obj.substr( strIdx ).toLowerCase();
		if ( ext == "xls") {
			return true;
		} else {
			alert(ext+' ������ ������ �Ұ����մϴ�.');
			return false;
		}
	}
}


//���̾ƿ� �˾� �ݱ� ��ư �Լ�
function goClosePop(formName){
	$('#AddressExcelForm').dialog('close');
}
</script>
</head>
<%-- <div id="waitwindow" style=" position:absolute; left:0">
  <div class="wait" style="" >
    <img src="<%= request.getContextPath()%>/images/loading.gif" width="32" height="32" style="left:0;" >
  </div>
</div> --%>
<body onLoad="init()" style="background:none">
<div id="wrap">
  <!-- title -->
  <!-- <div class="title">
    <h1 class="title_lft"><span class="title_rgt">��������� �ϰ����</span></h1>
  </div> -->
  <!-- //title -->
  <!-- contents -->
  <div id="contents" class="userExcelup">
    <!-- form_area -->
	<div class="form_area">
    <fieldset>
      <legend>������� ����</legend>
      <form name="AddressRegistForm" method="post"  action="<%= request.getContextPath() %>/H_Address.do?cmd=AddressExcelImport" enctype="multipart/form-data">
        <span>���ε� �� <em class="bold">��������</em></span><input type="file"  name="addressFile" />
      </form>
    </fieldset>
	</div>
    <!-- //form_area -->
    <!-- caution_area -->
    <div class="caution_area">
      <h3>���ε�� ���ǻ���</h3>
      <ul>
        <li>�������Ϸ� ����� ������ �ϰ� ������Ʈ �� �� �ֽ��ϴ�.
          <br />
          <span>(Ȯ���ڰ� xls �� ���� ���ϸ� ���ε� �����մϴ�.)</span> </li>
        <li class="cmt">�������� ���ε� ����� �ٿ�ε� �մϴ�. <a href="<%= request.getContextPath() %>/fileDownServlet?rFileName=AddressUploadFormat.xls&sFileName=AddressUploadFormat.xls&filePath=/down"><strong class="blueTxt">[��Ĵٿ�ε�]</strong></a>
          <br />
     <span>(�ٿ������ ����� ù��° Ÿ��Ʋ�� ���� ���ּҷ� ������ �����մϴ�.)</span> </li>
        <li>�ѽ���ȣ �Է½� �ѽ���ȣ�� �ߺ� �� ��� ��Ͻ��� �˴ϴ�.</li>
        <li>���� ���ε� ����� ������ log ��ο��� Ȯ���� �����մϴ�.</li>
      </ul>
    </div>
    <!-- //caution_area -->
  </div>
  <!-- //contents -->
  <!-- button -->
  <div class="ly_foot">
    <a href="javascript:goSaveExcel()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="���" /></a> <a href="javascript:goClosePop()"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
  </div>
  <!-- //button -->
  <iframe class="sbBlind sbBlind_userExcelForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
</div>
</body>
</html>