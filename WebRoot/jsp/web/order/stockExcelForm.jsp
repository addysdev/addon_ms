<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	String importResult = StringUtil.nvl((String)model.get("importResult"),"");
	
	boolean bLogin = BaseAction.isSession(request);			
	UserMemDTO dtoUser = new UserMemDTO();					
	if(bLogin == true)
		dtoUser = BaseAction.getSession(request);
	
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//����� �׷�
	String groupNm=StringUtil.nvl(dtoUser.getGroupname(),"");//����� �׷��
	
	CodeParam codeParam = new CodeParam();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title></title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script language="javascript">
//�ʱ⼼��
$(document).ready(function(){
	$('#calendarData3').datepicker({
		maxDate:0,
		prevText: "����",
		nextText: "����",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["��","��","ȭ","��","��","��","��"],
		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		changeMonth: true,
	    changeYear: true
	});
});
function showCalendar2(){
	
	   $('#calendarData3').datepicker("show");
}
function goSaveExcel(){
	
	
	var frm=document.stockRegistFrm; //form��ü����
	var groupname='';

	if(frm.stockDate.value==''){		
		alert('�����Ȳ ���ڸ� �����ϼ���');
		return;
	}

	if('<%=groupId%>'=='G00000'){
		
		if(frm.GroupID.selectedIndex==0){
			
			alert('����Ͻ� ��� ��� ������ �����ϼž� �մϴ�.');
			return;
			
		}
		
		groupname=frm.GroupID[frm.GroupID.selectedIndex].text;
		
	}else{	
		groupname=frm.GroupName.value;
	}

	if(!confirm("["+groupname+"] �� "+frm.stockDate.value+"����\n�����Ȳ�� ��� �Ͻðڽ��ϱ�?")){
		return;
   }
	
	if(frm.stockFile.value==''){		
		alert('���ε��� ������ �����ϼ���');
		return;
	}
	
	var imagechk=isImageFile( frm.stockFile.value );
	
	if(imagechk==false){
		return;
	}


	frm.stockDate.value=onlyNum(frm.stockDate.value);

	openWaiting();
	frm.action = "<%=request.getContextPath() %>/H_Order.do?cmd=stockExcelImport";
	frm.submit();
	goClosePop('stockExcelForm');
}
/**
 *  ���� Ȯ���ڸ� üũ
 *
 **/
function isImageFile( obj ) {
	var strIdx = obj.lastIndexOf( '.' ) + 1;
	if ( strIdx == 0 ) {
		return false;
	} else {
		var ext = obj.substr( strIdx ).toLowerCase();
		if ( ext == "xls") {
			return true;
		} else {
			alert(ext+'������ ������ �Ұ����մϴ�.\nxls ���Ϸ� ���ε� �ϼ���.');
			return false;
		}
	}
}

</script>
</head>
<body onLoad="init()" style="background:none">
<div id="wrap">
  <!-- title -->
  <!-- <div class="title">
    <h1 class="title_lft"><span class="title_rgt"> �ϰ����</span></h1>
  </div> -->
  <!-- //title -->
  <!-- contents -->
  <div id="contents" class="userExcelup">
   <form name="stockRegistFrm" method="post"  action="<%= request.getContextPath() %>/H_Order.do?cmd=stockExcelImport" enctype="multipart/form-data">
    <!-- form_area -->
	<div class="form_area">
    <fieldset>
      <legend>������� ����</legend>
        <span>���ε� �� <em class="bold">��������</em></span><input type="file"  name="stockFile" />
    </fieldset>
	</div>
    <!-- //form_area -->
    <!-- caution_area -->
    <div class="caution_area">
      <h3>����� �����Ȳ ���� ����</h3>
      <ul>
        <li>��� ��Ȳ���� ���� : <input  name="stockDate" id="calendarData3" value="" type="text" size="8" style="width:60px;" class="in_txt"  dispName="��¥" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			<!-- �޷��̹��� ���� -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar2()" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- �޷��̹��� �� --></li>
        <li>��� ������� ���� : <%
        	if(groupId.equals("G00000")){
									    codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("����");
										codeParam.setName("GroupID");
										codeParam.setSelected(groupId); 
										codeParam.setEvent(""); 
										out.print(CommonUtil.getCodeListGroup(codeParam)); 

									}else{
										out.print(groupNm);
									 %>
									 <input type="hidden" name="GroupID" value="<%=groupId%>">
									 <input type="hidden" name="GroupName" value="<%=groupNm%>">
									 <%  
									}									
									%>
	</li>
      </ul>
      <br>
      <h3>���ε�� ���ǻ���</h3>
      <ul>
        <li>���ε� ����� �����Ȳ ���ڿ� ������ �� �����ؾ� �մϴ�.
          <br />
        <li>�������Ϸ� ����� ������ �ϰ� ������Ʈ �� �� �ֽ��ϴ�.
          <br />
          <span>(Ȯ���ڰ� xls �� ���� ���ϸ� ���ε� �����մϴ�.)</span> </li>
         <li>�����Ȳ ���� excel���� ����� Ʋ�� ��� ��Ͻ��� �˴ϴ�.</li>
        <li>���� ���ε� ����� ������ log ��ο��� Ȯ���� �����մϴ�.</li>
      </ul>
    </div>
    <!-- //caution_area -->
 </form>
  </div>
  <!-- //contents -->
  <!-- button -->
  <div class="ly_foot">
    <a href="javascript:goSaveExcel()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="���" /></a> <a href="javascript:goClosePop('stockExcelForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
  </div>
  <!-- //button -->
  <iframe class="sbBlind sbBlind_userExcelForm"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
</div>
</body>
</html>