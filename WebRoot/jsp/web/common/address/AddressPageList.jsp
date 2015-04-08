<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.user.UserDAO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ page import="com.web.common.CodeParam"%>
<%@ include file="/jsp/web/common/base.jsp"%>

<% 
	
	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt"); 

	String aselect = "";
	String bselect = "";

	if (searchGb.equals("1")) { 	//����ڸ�(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //�ѽ���ȣ
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath() %>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/common_1.js"></script>
<title>�ּҷ� ����</title>
<script>
var openWin=0;//�˾���ü
var isSearch=0;

//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	
	searchChk();
}

//��ü ���ý� �˻��ڽ� disable
function searchChk() {
	var obj = document.AddressForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}

//�˻�
function goSearch() {
	var obj=document.AddressForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//���� üũ
	
	if ( isSearch == 0 ) {
		isSearch = 1;
		return
	}

	if(gubun=='1'){
		if(obj.searchtxt.value=='' ){
			alert('����� �̸��� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('�ѽ���ȣ�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	obj.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList";
	if(observerkey==true){return;}
	openWaiting( );
	obj.curPage.value='1';
	obj.submit();
}

//üũ�ڽ� ��ü ����
function fnCheckAll(objCheck) {
	  var arrCheck = document.getElementsByName('checkbox');
	  
	  for(var i=0; i<arrCheck.length; i++){
	  	if(objCheck.checked) {
	    	arrCheck[i].checked = true;
	    } else {
	    	arrCheck[i].checked = false;
	    }
	 }
}
//üũ �ڽ� ���� ����(�ٰ�/�ܰ�) 
function goDelete(){
	
	var frm = document.AddressForm;
	var checkYN;
	var checks=0;

	if(frm.seqs.length>1){
		for(i=0;i<frm.seqs.length;i++){
			if(frm.checkbox[i].checked==true){
				checkYN='Y';
				checks++;
			}else{
				checkYN='N';
			}
			frm.seqs[i].value=fillSpace(frm.checkbox[i].value)+'|'+fillSpace(checkYN);
		}
	}else{
		if(frm.checkbox.checked==true){
			checkYN='Y';
			checks++;
		}else{
			checkYN='N';
		}
		frm.seqs.value=fillSpace(frm.checkbox.value)+'|'+fillSpace(checkYN);

	}
	if (checks == 0){
		alert("������ ����ڸ� ������ �ּ���!")
	} else {
		if(!confirm("������ �����Ͻðڽ��ϱ�?"))
			return;
		
		frm.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressDeletes";
		frm.submit();
	}
}


// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	alert('a');
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = '#FEFADA'; 

}


function fnLayerout(index,rowclass){
	alert('a');
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = rowclass;
	
}



//Ŀ��  ���� ó�� ��


//��ȭ��ȣ ���� �Է½� üũ �� - ����
function MaskPhon( obj ) { 

	 obj.value =  PhonNumStr( obj.value ); //������ ������ PhonNumStr function ����.

} 

//��ȭ��ȣ ���� �Է½� üũ �� - ����
function PhonNumStr( str ){ 

	 var RegNotNum  = /[^0-9]/g; 

	 var RegPhonNum = ""; 

	 var DataForm   = ""; 

	 // return blank     

	 if( str == "" || str == null ) return ""; 

	 // delete not number

	 str = str.replace(RegNotNum,'');    

	 if( str.length < 4 ) return str; 


	 if( str.length > 3 && str.length < 7 ) { 

	   	DataForm = "$1-$2"; 

		 RegPhonNum = /([0-9]{3})([0-9]+)/; 

	 } else if(str.length == 7 ) {

		 DataForm = "$1-$2"; 

		 RegPhonNum = /([0-9]{3})([0-9]{4})/; 

	 // �� ��ȭ��ȣ ���ڸ��� - ������ replace �� ��� ���ǽ�.
	 } else if(str.length == 8 ) {

		 DataForm = "$1-$2"; 

		 RegPhonNum = /([0-9]{4})([0-9]{4})/; 
		 
	 } else if(str.length == 9 ) {

		 DataForm = "$1-$2-$3"; 

		 RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 

	 } else if(str.length == 10){ 

		 if(str.substring(0,2)=="02"){

			 DataForm = "$1-$2-$3"; 

			 RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 

		 }else{

			 DataForm = "$1-$2-$3"; 

			 RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;

		 }

	 } else if(str.length > 10){ 

		 DataForm = "$1-$2-$3"; 

		 RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 

	 } 


	 while( RegPhonNum.test(str) ) {  

		 str = str.replace(RegPhonNum, DataForm);  

	 } 

	 return str; 

} 


//�ּҷ� ���  ���̾ƿ� �˾�
$(function(){
	$('#addressRegist').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 435,
		width : 450,
		autoOpen : false,
		modal : true
	
	});
});

//�ּҷ� ���
function formAddressRegistPop(){
	//�ּҷ� ���  ���̾ƿ� �˾�
	$( "#addressRegist" ).dialog( "open" );
	
}

//�ּҷ� ���ó��
function goSave(){
	
	//Ajax �Ѱ��� Data ���� ����
	var AddressName = $('[name=AddressName]').val();
	var FaxNo1 = $('[name=FaxNo1]').val();
	var FaxNo2 = $('[name=FaxNo2]').val();
	var FaxNo =  $('[name=FaxNo1]').val() +"-"+ $('[name=FaxNo2]').val();	
	var OfficePhone = $('[name=OfficePhone]').val();
	var MobilePhone = $('[name=MobilePhone]').val();
	var Email = $('[name=Email]').val();
	var Memo = $('[name=Memo]').val();
	var faxNoLenRe = FaxNo2.replace("-","").length;	// �ѽ���ȣ ���ڸ� ���� ���� üũ.
	//alert(faxNoLenRe);
	//ajax submit
	
	if(AddressName == ""){
		alert('����ڸ��� �Է����ּ���.');
		return;
	}
	
	if(FaxNo1 == ""){
		alert('�ѽ� ������ȣ�� �������ּ���.');
		return;
	}
	
	if(FaxNo2 == ""){
		alert('�ѽ� ��ȣ ���ڸ��� �Է����ּ���.');
		return;
	}
	
	if(FaxNo == ""){
		alert('�ѽ���ȣ�� �Է����ּ���.');
		return;
	}

	if($('#FaxNoCheck').val() == "1"){
		alert("�ѽ���ȣ�� Ȯ�����ּ���.");
		return;
	}
	
	if($('#FaxNoCheck2').val() == "2"){
		alert("�ѽ���ȣ �ڸ� ���� Ȯ�����ּ���.");
		return;
	}

	if($('#FaxNoCheck2').val() == "3"){
		alert("�ùٸ� �ѽ���ȣ�� �Է����ּ���.");
		return;
	}
	
	var requestUrl='<%=request.getContextPath()%>/H_Address.do?cmd=AddressRegist';
			
	//�ߺ��ȵǴ� ��ĺз����� �� ajax�� ���
	$.ajax({
		url : requestUrl,
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"AddressName" : encodeURIComponent(AddressName),
			"FaxNo" : FaxNo,
			"OfficePhone" : OfficePhone,
			"MobilePhone" : MobilePhone,
			"Email" : Email,
			"Memo" : encodeURIComponent(Memo)
		},
		success : function(data, textStatus, XMLHttpRequest){
			
			//��� �޽��� ó���κ�.
			if(data==-1){
				alert('�ý��� �����Դϴ�.!');
			}else if(data==0){
				alert('����� �����߽��ϴ�!');
			}else{
				alert('����� �����߽��ϴ�!');
			}	
			location.href='<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList';
		},
		error : function(request, status, error){
			alert("Jquery Ajax Error : [��� ����]");
		}
	});	
}


/*��� ���̾ƿ� ����
  Description:���̾ƿ� �˾� ��� �� function,name.id,������ �� �ٸ��� ����������Ѵ�.
  	                    �ش� ������ ���� �� �Լ����� ����� �о���� ���ϴ� ��� �߻�.
*/
function offVisibleReg() {
	$('#addressRegist').dialog('close'); 
	$('[name=AddressName]').val("");
	$('[name=FaxNo1]').val("");
	$('[name=FaxNo2]').val("");
	$('[name=OfficePhone]').val("");
	$('[name=MobilePhone]').val("");
	$('[name=Email]').val("");
	$('[name=Memo]').val("");
	$('#chkAlert').text("");
	
}

//�ѽ���ȣ �ߺ�üũ Jquery Ajax
function fnDuplicateCheck(val) {
	//var FaxNo1 = $('[name=FaxNo1]').val()+'-';	//FaxNo2(������ȣ) -������ �Ʒ� �������� �Ұ��� �ѽ���ȣ �Է½� Alert�����ػ��.
	var FaxNo2 = $('[name=FaxNo2]').val();	    //FaxNo2(�޹�ȣ) �� ����
	var rplFaxNo2 = FaxNo2.replace("-","");	    //FaxNo2("-"�ڵ� ġȯ���� �κ� �ߺ�Ȯ�������� replace)
	var faxNoSumVal = $('[name=FaxNo1]').val() + rplFaxNo2;	 //DB�� ����� FaxNo1+FaxNo2=FaxNo(0212341234)�� ���ļ� �ߺ�Ȯ���ϱ�
	var faxSumNo = FaxNo1+FaxNo2;
	var faxNoLenRe = FaxNo2.replace("-","").length;	// �ѽ���ȣ ���ڸ��� ���� üũ.(7�ڸ��� 8�ڸ��� �����.)
	var faxNoLenSp = FaxNo2.split("-").length;	    // �ѽ���ȣ ���ڸ� (-)������ ���� üũ.

	//������ȣ ���� �������� show.
	if($('[name=FaxNo1]').val() == ""){ 
		$('#chkAlert').attr("color", "red");
		$('#chkAlert').show().html("������ȣ�� �������ּ���.");
	//�ѽ��޹�ȣ �Է� �������� hide 	
	}else if($('[name=FaxNo2]').val() == ""){
		$('#chkAlert').hide();
	//�ѽ��޹�ȣ 7,8�ڸ� �̸� �� ���.
	}else if(faxNoLenRe == 1 || faxNoLenRe == 2 || faxNoLenRe == 3 || faxNoLenRe == 4 || faxNoLenRe == 5 || faxNoLenRe == 6){
		  $('#chkAlert').attr("color","black");
		  $('#chkAlert').show().html("�ѽ� �޹�ȣ�� (-)�� ������ 7~8�ڸ�<br> <font color='red'>(ex:123-1234,1234-1234)</font>���� �Է��ϼž� ���� ��ϵ˴ϴ�.");
		  $('#FaxNoCheck').val(""); //case check value
		  $('#FaxNoCheck2').val("2"); //case check value
	//FaxNo "-" �� 2���� �������(ex[032-123-1234]) -���� üũ�� �ѽ���ȣ üũ����.
	}else if(faxNoLenSp != 2){
			$('#chkAlert').attr("color","black");
			$('#chkAlert').show().html("<br> *�ѽ���ȣ �Է� �� <font color='red'>������ȣ</font>�� �ݵ�� ������  <br> �ùٸ� �ѽ���ȣ�� �Է��ؾ� <font color='red'>(ex:02-1234-1234)</font> <br>(-)�������� �ùٸ��� �Էµ˴ϴ�.");
			$('#FaxNoCheck').val(""); //case check value
			$('#FaxNoCheck2').val("3"); //case check value
			return;
	//�ߺ�üũ ����
	}else{

	$.ajax({
		url : "<%= request.getContextPath()%>/H_Address.do?cmd=addrDupCheck",
		type : "post",
		dataType : "text",
		async : false,
		data : {
		
			"FaxNo" : faxNoSumVal
		},
		success : function(data, textStatus, XMLHttpRequest){
			//console.log(data);
			//alert(data);
			
				switch (data){
				
				case "" : alert("�ѽ���ȣ �ߺ� üũ ����!");break;
				case "1": 
					$('#chkAlert').attr("color","red");
					$('#chkAlert').show().html("�̹� ��� �� �ִ� �ѽ���ȣ�Դϴ�.");
					$('#FaxNoCheck').val(data); //case chekc value
					break;
				case "0":
					$('#chkAlert').attr("color","blue");
					$('#chkAlert').show().html("��� ������ �ѽ���ȣ �Դϴ�.");
					$('#FaxNoCheck').val(data); //case check value
					$('#FaxNoCheck2').val(data); //case check value
					break;
				}	
		},
		error : function(request, status, error){
			alert("�ߺ�üũ ����!");
		}
	});
	}
}

//�ּҷ� ��/���� ���̾ƿ� �˾�
function formAddressEditPop(Seq){

	$('#AddressEdit').dialog({
		resizable : false, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 415,
		width : 450,
		//autoOpen : false,
		modal : true,
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Address.do?cmd=AddressView',
				{'Seq' : Seq});
			//���̾ƿ� �ٱ��� Ŭ�� �� �˾� �������� ����
			/*
			$('.ui-widget-overlay').bind('click',function(){
                $('#JobRegistPop').dialog('close');
            });
			*/
			
		}
	});
	
}

<%-- ���������(2013.07.29).
//�ش� ������ȣ ���� ������ �����ֱ�.
/*
 * 
function codeMapping(val){
	
	//document.getElementById("codebookId").value=val;
	//alert(val);
	var areaVal = "������ : "+val;
	//alert(areaVal);
	//alert($('#codebookId').val() = val);
	$('#codebookId').html(areaVal);
	(val != "")? document.AddressForm : location.href = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList";
}
 */
	--%>

//Excel �ϰ���� �˾�
 function goExcelUpdate(){
 	$('#AddressExcelForm').dialog({
 		resizable : true, //������ ���� �Ұ���
 		draggable : true, //�巡�� �Ұ���
 		closeOnEscape : true, //ESC ��ư �������� ����
 		
 		height : 550,
 		width : 420,
 		modal : true,
 		/* position : {
 			my : 'left top',
 			at : 'right top',
 			of : $('#regBt')
 		}, */
 		open:function(){
 			
 			//�˾� ������ url
 			$(this).load('<%=request.getContextPath()%>/H_Address.do?cmd=AddressExcelForm');
 		}
 	});
 }
 
//Excel Export
 function goExcel() {
 	var frm = document.AddressForm;
 	frm.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressExcelList";	
 	frm.submit();
 	frm.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList";	
 }
 
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("AddressForm", "curPage", "goPage")%>
<body onload="init()" class="pop_body_bgAll">
	<form method="post" name="AddressForm" action="<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>" />
		<!-- <input type="hidden" name="SearchGroup" value=""> -->

		<!-- ���̾ƿ� ���� -->
		<div id="wrap_1000">
		
		<!-- TOP Ÿ��Ʋ ���� -->
			<div id="header">
				<div class="pop_top">
					<p><img src="<%=request.getContextPath()%>/images/popup/text_AddressPageList.gif" alt="��� �Ŵ���" /></p> <!-- Ÿ��Ʋ �̹����ʿ�. -->
				</div>
			</div>
			<!-- TOP Ÿ��Ʋ �� -->
		</div>

		<!-- ���������� ���� -->
		<div id="pop_contents">
		
		<!-- �˻� ���� : ���� -->
        <div id="seach_box" class="pop_seach_box">
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- ����Ʈ �ڽ� -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>��ü</option>
                       <option value="1" <%=aselect%>>����ڸ�</option>
                       <option value="2" <%=bselect%>>�ѽ���ȣ</option>
                   </select>
               </p> 
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- �˻� text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" title="�˻�"/></a> </p> <!-- ��ȸ ��ư --> 
	                  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="���� �ٿ�ε�" /></a> </p> <!-- ���� ������ -->
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="�� �ּҷ����� �ϰ����" /></a></p>  <!-- �� �ּҷ����� �ϰ���� ������ -->
	                  <!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="���� ���ε�" /> </p> <!-- ���� ������ --> 
			</div>
                   <!-- �˻� ��-->
    	<!-- �˻� > �׷� �����ڽ� : ��-->
		</div>
	<!-- �˻� ���� : �� -->     
			<!-- ���̺� : ���� -->
			<div id="code_origin" class="pop_list_box">
			<!-- ������ ��ư ���� -->
	                <div class="btn_box">
	                    <p><a href="javascript:formAddressRegistPop();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="���" /></a></p>
	 				</div>
			  <!-- ������ ��ư �� -->
			<ul class="listNm">
				<li>��ü�Ǽ� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>��</span></li>
				<li class="last">���������� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out" style="zoom:1;">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>�ּҷ� ����</caption>
					<colgroup>
						<col width="30px" />
						<col width="15%" />
						<col width="15%" />
						<col width="30%" />
						<col width="*" />
					</colgroup>
		            <thead>
		                <tr>
		               	  <th><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
		                  <th>����ڸ�</th>
		                  <th>�ѽ���ȣ</th>
		                  <th>Email</th>
		                  <th>�޸�</th>
		                </tr>
		            </thead>
		            <tbody>
		            <!-- :: loop :: -->
					<!--����Ʈ---------------->
					<%
						if (ld.getItemCount() > 0) {
							int i = 0;
							while (ds.next()) {
								
						//�ο���󺯰� ����
						int num = 0;
						String rowClass="";
						
						num = i % 2;
						
						if(num==1){
							rowClass="#FAFAFA";
						
						}else{
							rowClass="#FFFFFF";
							
						}
						//�ο���󺯰� ��  
						
						%>
				<%----%>
				<!-- Ȯ�� ��Ȯ�� ���� ����ó�� ����-->	
					<% 
					
                 if (ds.getString("ImageOpenDate").equals("")){
	                    	
	            	%>
	                    	        
                <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >
                              
                <%
	                    }else {
	            %>
                 <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >               	
				<%
	                    }
						
	            %>	
	            <!-- Ȯ�� ��Ȯ�� ���� ����ó�� �� -->
				 
				 		<tr>
		                	<input type="hidden" name="seqs" />
		                	<td><input name="checkbox" type="checkbox" value="<%=ds.getInt("Seq")%>" /></td>
		                    <td title="<%=ds.getString("AddressName")%>" style="cursor: pointer" onclick="formAddressEditPop('<%=ds.getInt("Seq")%>');"><%=ds.getString("AddressName")%></td>
							<td title="<%=ds.getString("FaxNoFormat")%>"><%=ds.getString("FaxNoFormat")%></td>
							<td title="<%=ds.getString("Email")%>"><span class="ellipsis ellipsis_tl20"><%=ds.getString("Email")%></span></td>
							<td title="<%=ds.getString("Memo")%>" style="text-align:left !important;"><span class="ellipsis ellipsis_mo20"><%=ds.getString("Memo")%></span></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
						i++;
							}
						} else {
					%>
					<tr>
						<td colspan="5">�Խù��� �����ϴ�.</td>
					</tr>
					<script>
						goSearch();
					</script>
					<%
						}
					%>
					<!-- ����Ʈ �ϴ� ��ư ���� : ���� -->
					<tr id="list_btn_box">
						<td colspan="5">���õ� �׸� ����<input type="hidden" name="IdongGb" value="Y"><span class="btn"><a href="javascript:goDelete();"><img src="<%=request.getContextPath()%>/images/sub/btn_delete_02.gif" title="����" /></a></span><!-- ��ư -->
						</td>
					</tr>
					<!--����Ʈ �ϴ� ��ư ���� : �� -->
		          </tbody>
		        </table>
			</div>
		    <!-- ���̺� �� -->
		    
		    <!-- ������ �ѹ� �̹����� ó�� -->
		    <div id="Pagging"><%=ld.getPagging("goPage")%></div>
			<!-- ������ �ѹ� �� -->
		</div>
		<!-- ���������� �� -->
	</div>
	<!-- ���̾ƿ� �� -->

	<!-- layer popup : �ּҷ� ���-->
	<div id="addressRegist" title="�ּҷ� ���">
	<!-- �ѽ���ȣ Ȯ�� üũ ����. -->
	<input type="hidden" id="FaxNoCheck" name="FaxNoCheck" value=""/>
	<input type="hidden" id="FaxNoCheck2" name="FaxNoCheck2" value=""/>
	<!-- �ѽ���ȣ Ȯ�� üũ ��. -->
		<fieldset>
		<!-- ���������� -->
		<div class="ly_pop_new">
			<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
							<tr>
	                            <th style="width:110px;">�̸� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="AddressName" maxlength="25" value="" tabindex="1"/></td>
	                        </tr>
	                        	<tr>
	                        		
									<th>�ѽ���ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
									<td class="input_box">
									
									<%
										CodeParam codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("����");
										codeParam.setName("FaxNo1");
										codeParam.setSelected(""); 
										codeParam.setEvent("javascript:fnDuplicateCheck();"); 
										out.print(CommonUtil.getCodeListHanSeq(codeParam,"6")); 
									%>
									- 
									<input name="FaxNo2" type="text" value="" size="13"  maxlength="9" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this); fnDuplicateCheck(this.value);"  tabindex="3"  />
									<!-- FaxNo1 + FaxNo2 = FaxNo(���� DB Insert �� ��) -->
									<input name="FaxNo" type="hidden" value=""></input>
									<br/>
									<font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font>
									<!-- 
									<br/><span class="ico_arr_g grayTxt">�ѽ���ȣ �Է½�<span class="blueTxt">&nbsp;&nbsp;������ȣ</span>�� �ݵ�� <span class="blueTxt">����</span>�ؾ��մϴ�.</span>
									 -->
									</td>
								</tr>
	                        <tr>
	                            <th>��ȭ��ȣ(��/ȸ��)</th>
	                            <td class="input_box">
                                <input type="text" name="OfficePhone" size="15" maxlength="13" value="" tabindex="4" dispName="(��/ȸ��)��ȭ��ȣ"  onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
	                        </tr>
	                        <tr>
	                        	<th>�޴��� ��ȣ</th>
	                            <td class="input_box"><input type="text" size="15" name="MobilePhone" maxlength="13" value="" tabindex="5" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" /></td>
	                        </tr> 
	                        <tr>
	                            <th>E-Mail</th>
	                            <td class="input_box"><input type="text" size="28" name="Email" maxlength="50" value="" tabindex="6"/></td>
	                        </tr>
	                        
	                        <tr>
	                            <th>�޸�</th>
	                            <td class="input_box"><textarea name="Memo" value="" style="ime-mode:active;width:285px; height:40px;" tabindex="7" onKeyUp="js_Str_ChkSub('500', this)" dispName="�޸�"></textarea></td>
	                        </tr>
					</tbody>
					</table>
				</div>
		<!-- bottom ���� -->
		<div  class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="���" /></a><a href="javascript:offVisibleReg();"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a></div>
		</div>
		<!-- �������� -->
		</fieldset>
		<iframe class="sbBlind sbBlind_AddressEdit"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
	</div>
	<!-- //layer popup : �ּҷ� ��� -->

</form>
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px;_top:300px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
	<table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
		<tr>
			<td align=center height=middle style="margin-top: 10px;">
				<table width=220 height=120 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/sub/loadingBar_bg.gif" >
					<tr>
						<td align=center style="padding-top:30px"><img src="<%=request.getContextPath()%>/images/sub/loader4.gif" width="32" height="32" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<div id="AddressEdit" title="�ּҷ� ������"></div>
<div id="AddressExcelForm" title="�ּҷ����� �ϰ����"></div>
</body>
</html>
<script>
	searchChk();
</script>

