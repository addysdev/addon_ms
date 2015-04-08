<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.user.UserDAO"%>
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
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
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

// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = '#FEFADA'; 

}


function fnLayerout(index,rowclass){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = rowclass;
	
}
//Ŀ��  ���� ó�� ��

//�ش� �ּҷ� ����
function goSelected(addressname,faxno){
	$('#CustomerName').val(addressname); //������ ��(����)
	$('#FaxNo').val(faxno);	//������ �ѽ���ȣ
	//goClose($('#addressList').val('addressList'));
	//this.close();
	
	$('#addressList').dialog('close');
}

<%--
	function goPageAjax(page,type){
		
		//�˻� Valueüũ ����
		var obj=document.AddressForm;
		var gubun=obj.searchGb.value;
		 if(gubun=='1'){
			if(obj.searchtxt.value==''){
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
		 
		//jQuery Ajax
		$('#curPage').val(page);

		$.ajax({
			url : "<%= request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame",
			type : "post",
			dataType : "html",
			async : false,
			data : {
				"curPage" : $('#curPage').val(),
				"searchtxt" : encodeURIComponent($('[name=searchtxt]').val()),
				"searchGb" : $('#searchGb').val()
			},
			success : function(data, textStatus, XMLHttpRequest){
				$('#containerLy').html(data);
			},
			error : function(request, status, error){
				alert("code :"+request.status + "\r\nmessage :" + request.responseText);
			}
		}); 
	}
--%>

	//��� a�±� _self �� ������.
	//������� ���� ����¡ ���� ������ ��ȯ�� window �˾� ��������.(���Ŀ� LISTDTO �����ӿ� a�±׺κ� ��������ߵ�.)
	$(function(){
		$('a').attr("target","_self");
	});
	
	
	
	<%--
	//üũ �ڽ� ���� ����(�ٰ�/�ܰ�) 
	function goMove(){
		
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
	--%>
	
	<%--
	//üũ �ڽ� ���� �̵�(�ٰ�/�ܰ�) 
function goMove(){
		var frm = document.AddressForm;
		var checkYN;
		var checks=0;
		var data;
			
	if(frm.seqs.length>1){
		for(i=0; i<frm.seqs.length; i++){
			if(frm.checkbox[i].checked==true){
			checkYN='Y';
			checks++;
			}else{
			checkYN='N'
			}
			frm.seqs[i].value=fillSpace(frm.checkbox[i].value)+'|'+fillSpace(checkYN);
			//alert(frm.seqs[i].value);
		}	
	}else{
		if(frm.checkbox.checked==true){
			checkYN='Y';
			checks++;
		}else{
			checkYN='N'
		}
		frm.seqs.value=fillSpace(frm.checkbox.value)+'|'+fillSpace(checkYN);
	}
	//parent.document.AddressMove.test.value;
	submit();
}
--%>

//üũ�ڽ� ��ü����.
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


//�ѽ� ������ üũ �� (������)����Ʈ�� �̵�.
function goMoveBtn(){
	var chkCount = $('input:checkbox:checked').length; //checkbox Count.
 
	if(chkCount > 11){
		alert('�ѽ� �����߽��� ������(�ִ� 10�����)�Դϴ�. �������� Ȯ���ϼ���.');
		return;
	}else{
		parent.goMove();
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
	obj.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame";
	if(observerkey==true){return;}
	openWaiting( );
	obj.curPage.value='1';
	obj.submit();
}

</script>
</head>
<body onload="init()">
<div id="containerLy">
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
	<form method="post" id="AddressForm" name=AddressForm action="<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame">
		<input type="hidden" name="curPage" id="curPage" value="<%=curPage%>" />
		<!-- <input type="hidden" name="users" value=""> -->
		<!-- <input type="hidden" name="SearchGroup" value=""> -->
		<!-- ���������� ���� -->
		<div class="AddressPageListPop">
		<!-- ����Ÿ��Ʋ ���� : ���� -->
		<div class="popi_sub_title">
			<p class="pop_titleP">�� �ּҷ� ����Ʈ</p>
		</div>
		<!-- ����Ÿ��Ʋ ���� : �� -->

		<!-- �˻� ���� : ���� -->
		<div id="seach_box" class="pop_seach_box">
			<div id="seach">
				<!-- �˻�Ÿ��Ʋ <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p> -->
				<p class="input_box"> <!-- ����Ʈ �ڽ� -->
					<select id="searchGb" name="searchGb" onChange="searchChk()">
						<option value="" checked>��ü</option>
						<option value="1" <%=aselect%>>����ڸ�</option>
						<option value="2" <%=bselect%>>�ѽ���ȣ</option>
					</select>
				</p> 
				<p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goPageAjax()" style="ime-mode:inactive;width:70px; width:74px\9;" class="seach_text" /> </p> <!-- �˻� text box -->
				<p class="btn"><a href="javascript:goSearch()" target="_self"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p>
				<!-- ��ȸ ��ư -->
				<!--  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="���� �ٿ�ε�" /></a> </p> <!-- ���� ������ -->
				<!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="���� ���ε�" /> </p> <!-- ���� ������ -->
			</div>
			<!-- �˻� ��-->
		</div>
		<!-- �˻� ���� : �� -->

		<!-- ���̺� : ���� -->
		<div id="code_origin" class="pop_list_box">
			<%--
			<!-- ������ ��ư ���� -->
	                <div class="btn_box">
	                    <p><a href="javascript:goRegist();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="���" /></a></p>
	 				</div>
			 --%>
			<!-- ������ ��ư �� -->
			<ul class="listNm">
				<li>��ü�Ǽ� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>��</span></li>
				<li class="last">���������� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
				<caption>�ּҷ� ����</caption>
				<colgroup>
					<col width="10%" />
					<col width="25%" />
					<col width="30%" />
					<col width="35%" />
				</colgroup>
				<thead>
					<tr>
						<th><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
						<th>����ڸ�</th>
						<th>�ѽ���ȣ</th>
						<th>Email</th>
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
				<%--
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
				 <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >
				 --%>
				 		<tr>
		                	<input type="hidden" name="seqs" />
		                	<td><input name="checkbox" id="ch" type="checkbox" value="<%=ds.getInt("Seq") %>|<%=ds.getString("AddressName")%>|<%=ds.getString("FaxNoFormat")%>" /></td>
		                    <td><%=ds.getString("AddressName")%></td>
							<td><%=ds.getString("FaxNoFormat")%></td>
							<td><%=ds.getString("Email")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
						i++;
							}
						} else {
					%>
					<tr>
						<td colspan="4">�Խù��� �����ϴ�.</td>
					</tr>
					<%
						}
					%>
					<!-- ����Ʈ �ϴ� ��ư ���� : ���� -->
					<tr id="list_btn_box">
						<td colspan="4" class="choiceMove">���õ� �׸� �̵�<span class="btn"><a href="javascript:goMoveBtn()"><img src="<%=request.getContextPath()%>/images/sub/btn_move.gif" title="�̵�" /></a><span class="btn"></span><!-- ��ư -->
						</td>
					</tr>
					<!--����Ʈ �ϴ� ��ư ���� : �� -->
				</tbody>
				</table>
			</div>
		</div>
		<!-- ���̺� �� -->
		<!-- ������ �ѹ� �̹����� ó�� -->
		<div id="Pagging" ><%=ld.getPagging("goPage")%></div>
		<!-- ������ �ѹ� �� -->
		</div>
		<!-- ���������� �� -->
</form>
</div>
</body>
</html>
<script>
	searchChk();
</script>
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