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
	//(�Ϲݹ���,���,��ĵ)�߽� ���������� �޾ƿ� ����
	String FormName = (String)model.get("FormName"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>������ ����Ʈ</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/common_1.js"></script>

<script>
//�� �ּҷ� ��� �����θ���Ʈ �� �̵���Ű��.
function goMove(){
	var frm = AddressPopListFrame.AddressForm;
	var addrInfo = ''; //���õ� �ּҷ� ����(�̸�|�ѽ���ȣ ��)
	var addrSp = '';   //���õ� �ּҷ� ���� �и�(�̸�,�ѽ���ȣ ��)
	var checks=0;	   //checked �� ++ arr ��.
	var addrEnc = '';

//�����߽��� ���� ������ �ٰ� �̵��϶�.
	if(frm.seqs.length>1){
		for(i=0; i<frm.seqs.length; i++){
			if(frm.checkbox[i].checked==true){
			checks++;
			frm.seqs[i].value=fillSpace(frm.checkbox[i].value);

				if(frm.seqs[i].value != ''){
					addrInfo=frm.seqs[i].value;
					//alert(addrInfo);
					addrSp=addrInfo.split('|');
					//alert("name:"+addrSp[0]);
					//alert("faxno:"+addrSp[1]);
					//alert(addrEnc);
					//alert(addrInfo);
					//alert(addrSp[0].length);
					//alert(addrSp[0]);
					//var test = addrSp[0].length;
					//alert(test);
					//console.log(addrSp[0]+"//"+rightVal); //�ش� ���� üũ �Լ� 
					//console.log(rightVal);
					//������ value���� ������ append
					//alert(rightVal);
					
					
					
					var rightVal1 = $('#RevData [value='+addrSp[0]+']').length; //addrSp[0]�� ��ü ������.length; ���̷� �ִ��� ������ üũ���ִ� ����.	
					var RevCount1 = $('[name=seqval]').length; //�ش� name�� �� value ��(������ ����Ʈ ��� �������� ���� ����.)
		
					//���� �߽� 10����� üũ ����.	
					if(RevCount1 > 9){ //Checkbox Arr üũ�� �������� �̵� ��Ű�Ƿ� (RevCount > 9)9�� ������ Arr�� 0���� �����ϱ⶧��.
						alert('�ѽ� ���� �߽��� �ִ� 10����� �����մϴ�.');
						return;
					}	
					//������ ����Ʈ�� ������ �������� �ִ���  üũ �� �̵��Ұ�.
					if(rightVal1 == 0){
						$('#RevData', document).append("<tr id='TR_"+addrSp[0]+"'><td><a href=\"javascript:goDelete("+addrSp[0]+")\" target=\"_self\"><img src=\"<%= request.getContextPath() %>/images/sub/minus-circle.gif\" title=\"�������\"/></a></td><td>"+addrSp[1]+"</td><td>"+addrSp[2]+"</td><input type='hidden' id='seqval' name='seqval' value="+addrSp[0]+"></input><input type='hidden' id='CustomerName' name='CustomerName_"+addrSp[0]+"' value="+addrSp[1]+"></input><input type='hidden' id='FaxNo' name='FaxNo_"+addrSp[0]+"' value="+addrSp[2]+"></input></tr>");	
					} 
				} 
			}	
		}
//�ѽ� ������ �ܰ� �϶�.		
	}else{
		if(frm.checkbox.checked==true){
			frm.seqs.value=fillSpace(frm.checkbox.value);
				
				if(frm.seqs.value != ''){
					addrInfo=frm.seqs.value;
					//alert(addrInfo);
					addrSp=addrInfo.split('|');
					//alert("name:"+addrSp[0]);
					//alert("faxno:"+addrSp[1]);
					//alert(addrEnc);
					//alert(addrInfo);
					//alert(addrSp[0].length);
				
					//var test = addrSp[0].length;
					//alert(test);
				
					//console.log(addrSp[0]+"//"+rightVal); //�ش� ���� üũ �Լ� 
					//console.log(rightVal);
					//������ value���� ������ append
					//alert(rightVal);
					
				
					
				var rightVal2 = $('#RevData [value='+addrSp[0]+']').length; //addrSp[0]�� ��ü ������.length; ���̷� �ִ��� ������ üũ���ִ� ����.	
				var RevCount2 = $('[name=seqval]').length; //�ش� name�� �� value ��(������ ����Ʈ ��� �������� ���� ����.)
	
				//���� �߽� 10����� üũ ����.	
				if(RevCount2 > 9){ //Checkbox Arr üũ�� �������� �̵� ��Ű�Ƿ� (RevCount > 9)9�� ������ Arr�� 0���� �����ϱ⶧��.
					alert('�ѽ� ���� �߽��� �ִ� 10����� �����մϴ�.');
					return;
				}	
				//������ ����Ʈ�� ������ �������� �ִ���  üũ �� �̵��Ұ�.
				if(rightVal2 == 0){
					$('#RevData', document).append("<tr id='TR_"+addrSp[0]+"'><td><a href=\"javascript:goDelete("+addrSp[0]+")\" target=\"_self\"><img src=\"<%= request.getContextPath() %>/images/sub/minus-circle.gif\" title=\"�������\"/></a></td><td>"+addrSp[1]+"</td><td>"+addrSp[2]+"</td><input type='hidden' id='seqval' name='seqval' value="+addrSp[0]+"></input><input type='hidden' id='CustomerName' name='CustomerName_"+addrSp[0]+"' value="+addrSp[1]+"></input><input type='hidden' id='FaxNo' name='FaxNo_"+addrSp[0]+"' value="+addrSp[2]+"></input></tr>");	
				} 
			} 
		}	
	}
}
//������ ����Ʈ ����ϱ�.
function goDelete(seqval){

	$('[id=TR_'+seqval+']').remove();
}
//������ ����Ʈ ��ü ����ϱ�.
function goAllDelete(){
var rev_Tr =	$('#RevData tr').length; //append �� tr ���̰�(����)
var rev_Td =	$('#RevData td').length; //append �� td ���̰�(����)
var rev_SeqPk =	$('#RevData [name=seqval]').length; //append �� Seq value Pk ���̰�(����)
var rev_a_tag = $('#RevData a').length; //append �� �����̹��� �±� ���̰�(����)
var rev_Name = $('#RevData #CustomerName').length; //append �� ������ �̸� ���̰�(����)
var rev_Fax = $('#RevData #FaxNo').length; //append �� �ѽ���ȣ ���̰�(����)

	if(rev_Tr==0 && rev_Td==0 && rev_SeqPk==0 && rev_a_tag==0 && rev_Name==0 && rev_Fax==0){
		
		alert('��ü ��������� �������� �������� �ʽ��ϴ�.');
	
	}else{
		
		$('#RevData tr').remove();
		$('#RevData td').remove();
		$('#RevData [name=seqval]').remove();
		$('#RevData a').remove();
		$('#RevData #CustomerName').remove();
		$('#RevData #FaxNo').remove();
	}

}
//������ ����Ʈ ���� �����ϱ�.
function goSelected(){
	//ajax�� form submit
	
	var seqLen = $('[name=seqval]').length;  //�ش� name�� �� value ��(������ ����Ʈ ��� �������� ���� ����.)
	var nameData = "";       //�ѽ� �߽� �������� �������� (,ó����)Data��.(������)
	var faxNoData = "";      //�ѽ� �߽� �������� �������� (,ó����)Data��.(�ѽ���ȣ)
	var nameDataView = "";   //�ѽ� �߽����� �������� (Viewing)Data��.(������)
	var faxNoDataView = "";  //�ѽ� �߽����� �������� (Viewing)Data��.(�ѽ���ȣ)
	var nameDataTitle = "";  //�ѽ� �߽����� �������� (Title="")Data��.(������)
	var faxNoDataTitle = ""; //�ѽ� �߽����� �������� (Title="")Data��.(�ѽ���ȣ)
	
	for(var x=0; x< seqLen; x++){
		var seqval = $('[name=seqval]').eq(x).val(); //�ش� name�� �� value ��
		var data1 = $('[name=CustomerName_'+seqval+']').val(); //�ش� name + seqval(index pk)�� val(������ �����ڸ�) ��
		var data2 = $('[name=FaxNo_'+seqval+']').val();	//�ش� name + seqval(index pk)�� val(������ �ѽ���ȣ) ��
		
		//������ �����ϱ� ����(���� ���� �߽��� ��� �����θ�:test1,test2 �޸� ó���� ����)
		if(x == 0){
		nameData += data1; //������ �Ѹ��϶�
		nameDataView += data1; 
		}else{
		nameData += ","+data1; //������ �������϶�.
		nameDataView;
		nameDataTitle += data1+"<br>";
		}
		
		//������ �ѽ���ȣ �����ϱ� ����(���� ���� �߽��� ��� �ѽ���ȣ:02-1234-1234,02-4321-4321 �޸� ó������)
		if(x == 0){
		faxNoData += data2; //������ �Ѹ��϶� �ѽ���ȣ
		faxNoDataView += data2;
		}else{
		faxNoData += ","+data2; //������ �������϶� �ѽ���ȣ 
		faxNoDataView;
		faxNoDataTitle += data2+"<br>";
		}
		
	}
	
	if(x == 1){	
		
	<%=FormName%>.CustomerName.value = nameDataView; 				//�ѽ� ������ 1���� ��� ������ View Data �� (������)
	<%=FormName%>.FaxNo.value = faxNoDataView;       				//�ѽ� ������ 1���� ��� ������ View Data �� (�ѽ���ȣ)
	<%=FormName%>.CustomerName.title = nameData;	 				//�ѽ� ������ 1���� ��� View Tooltip title="��(������)"
	<%=FormName%>.FaxNo.title = faxNoData;    		 				//�ѽ� ������ 1���� ��� View Tooltip title="��(�ѽ���ȣ)"
	<%=FormName%>.CustomerNameData.value = nameData; 				//���� �ѽ� �߽� �������� �Ѱ��� Data�� (������)
	<%=FormName%>.FaxNoData.value = faxNoData;      			    //���� �ѽ� �߽� �������� �Ѱ��� Data�� (�ѽ���ȣ)
	<%=FormName%>.NowRegist.checked = true;          				//�ѽ� ������ 1���� ��� checked(o)
	<%=FormName%>.CustomerName.readOnly = false;	 				//�ѽ� ������ 1���� ��� text box ��������(������)
	<%=FormName%>.FaxNo.readOnly = false;			 				//�ѽ� ������ 1���� ��� text box ��������(�ѽ���ȣ)
	document.getElementById("CustomerName").style.background = "";  //üũ�ڽ� ���� �� text box ȸ������ ����.(������)
	document.getElementById("FaxNo").style.background = ""; 		//üũ�ڽ� ���� �� text box ȸ������ ����.(�ѽ���ȣ)
	
	}else if(x>1){	
	var RevCount = x - 1 //������ ������ �� ���� ǥ�� �ϱ����� ��ü Data ���� -1 ����.
	<%=FormName%>.CustomerName.value = nameDataView+" ��"+RevCount+"��";     //�����߽� 1�� �̻��� ��� ������ View Data��(������)
	<%=FormName%>.FaxNo.value = faxNoDataView+" ��"+RevCount+"��";           //�����߽� 1�� �̻��� ��� ������ View Data��(�ѽ���ȣ)
	<%=FormName%>.CustomerName.title = nameDataTitle;        			    //�����߽� 1�� �̻��� ��� ������ View Tooltip title="��(������)"
	<%=FormName%>.FaxNo.title = faxNoDataTitle;       				        //�����߽� 1�� �̻��� ��� ������ View Tooltip title="��(�ѽ���ȣ)"
	<%=FormName%>.CustomerNameData.value = nameData;                        //���� �ѽ� �߽� �������� �Ѱ��� (�޸�ó����)Data��(������)
	<%=FormName%>.FaxNoData.value = faxNoData;                              //���� �ѽ� �߽� �������� �Ѱ��� (�޸�ó����)Data��(�ѽ���ȣ)
	<%=FormName%>.NowRegist.checked = false;                                //�ѽ� ������ 1�� �̻�(�����߽�)�� ���  checked(x)
	<%=FormName%>.CustomerName.readOnly = true;							    //�ѽ� ������ 1�� �̻�(�����߽�)�� ��� text box �����Ұ�(������)
	<%=FormName%>.FaxNo.readOnly = true;								    //�ѽ� ������ 1�� �̻�(�����߽�)�� ��� text box �����Ұ�(�ѽ���ȣ)
	document.getElementById("CustomerName").style.background = "#e5e5e5";   //üũ�ڽ� ���� �� text box ȸ������ ����.(������)
	document.getElementById("FaxNo").style.background = "#e5e5e5";          //üũ�ڽ� ���� �� text box ȸ������ ����.(�ѽ���ȣ)
	}
	
	if(nameData != ''){		
	$('#addressList').dialog('close');
	alert('�ѽ� ������ ������ �Ϸ��Ͽ����ϴ�.');
	}else{
	alert(' �ѽ� �������� ���� �����ʽ��ϴ�.\n �ּҷ� ����Ʈ���� ������ üũ �̵� �� �����ϱ⸦ �����ּ���.');
	}
	
	<%-- $.ajax({
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
	}); --%> 
	
	//alert(seqval);
	//alert(CustomerName);
	//alert(FaxNo);
	
}

/*�� �ּҷ� ���̾ƿ� �˾� �ݱ�(�Ϲݹ����߽�,��Ĺ߽�,��ĵ�߽� ����)
  Description : ���̾ƿ� �˾� close �� a link�� ó���Ͽ� �˾��� �ϳ� ������ ������ �߻���.
  				ó����� �ش� script a link�� target="_self" �� �־��ָ� �ذ��. 
*/
function closeAddressPop(){
	$('#addressList').dialog('close');
}

</script>
</head>
<!-- ó���� ���� -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
	<table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
		<tr>
			<td align=center height=middle style="margin-top: 10px;">
				<table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
					<tr>
						<td align=center height=middle>
							<img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<!-- ó���� ���� -->
<body id="popup" onLoad = "init()">
	<form  method="post" name="AddressMove" action="<%=request.getContextPath()%>/H_User.do?cmd=userRegist">
	<!-- ���̾ƿ� ���� -->
	<div id="AddressPageListPop">
		<!-- ���������� ���� -->
		<div id="pop_contents">
			<!-- ��� ��ü ���� -->
			<div class="form_all">
				<!-- �ѽ���� ���� ��Ʈ ���� -->
				<div class="form_lft">
					<!-- AddressPageListPop.jsp �˻�or ����Ʈ ���������� ����  -->
					<iframe src="<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame" id="AddressPopListFrame" name="AddressPopListFrame" frameborder="0" class="" scrolling="no" width="306" height="594"></iframe>
					<!-- AddressPageListPop.jsp �˻�or ����Ʈ ���������� ����  ��-->
				</div>
				<!-- �ѽ���� ���� ��Ʈ �� -->
				<!-- ȭ��ǥ ���� -->
				<div class="arrow_addlist"><span class="blind">�ּҷ� ���� �̵�</span></div>
				<!-- ȭ��ǥ �� -->
				<!-- �߼۾�� �ۼ� ��Ʈ ���� -->
				<div class="form_rgt">
					<!-- ����Ÿ��Ʋ ���� : ���� -->
					<div class="pop_sub_title">
						<p class="pop_titleP">������ ����Ʈ</p>
					</div>
					<!-- ����Ÿ��Ʋ ���� : �� -->
					<!-- �ּ����� : ���� -->
					<div class="listGuide"><span class="blueTxt_b">���ּҷ����� �ѽ� �߽��ϱ�</span><br />1. ���� �� �ּҷ� ����Ʈ���� �߽��� �ѽ� ������<br />&nbsp;&nbsp;&nbsp;���� �� �̵� ��ư�� ������.<br />2. ���õ� �����(������)�� ���� Ȯ�� �� �����ϱ�<br />&nbsp;&nbsp;&nbsp;��ư�� ������.<br /><span class="blueTxt letter_S">* Tip : �ѽ� ���� �߽��� �ִ� 10�� ���� �����մϴ�. *</span></div>
					<!-- �ּ����� : �� -->
					<!-- �߼۾�� �ۼ� ���̺� ���� -->
					<div class="pop_list_box">
						<div class="tbl_type_out">
							<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
								<caption>�ּҷ� ����</caption>
								<colgroup>
									<col width="10%" />
									<col width="40%" />
									<col width="50%" />
								</colgroup>
								<thead>
								<tr>
									<th><a href="javascript:goAllDelete()" target="_self"><img src="<%= request.getContextPath() %>/images/sub/minus-allcircle.gif" title="��ü���"/></a></th>
									<th>����ڸ�</th>
									<th>�ѽ���ȣ</th>
								</tr>
								</thead>
								<tbody id="RevData">
								</tbody>
							</table>
						</div>
					</div>
					<!-- �߼۾�� �ۼ� ���̺� �� -->
					<!-- bottom ���� -->
					<div id="bottom">
						<div class="bottom_top"> <a href="javascript:goSelected()" target="_self"><img src="<%= request.getContextPath() %>/images/popup/btn_choice.gif" title="�����ϱ�"  /></a></div>
					</div>
					<!-- bottom �� -->
				</div>
				<!-- �߼۾�� �ۼ� ��Ʈ �� -->
			</div>
			<!-- ��� ��ü �� -->
			
			<!-- bottom ���� -->
			<div id="bottom">
				<div class="bottom_top"><a href="javascript:closeAddressPop();" target="_self"><img src="<%= request.getContextPath() %>/images/sub/btn_cancel.gif" title="���" /></a></div>
			</div>
			<!-- bottom �� -->
		</div>
		<!-- ���������� �� -->
		<iframe class="sbBlind sbBlind_addressList"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
	</div>
	<!-- ���̾ƿ� �� -->
	</form>
</body>
</html>
