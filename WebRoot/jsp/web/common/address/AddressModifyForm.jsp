<%@page import="org.apache.struts.taglib.tiles.AddTag"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.user.UserDTO"%>
<%@ page import ="com.web.common.address.AddressDTO"%>
<%@ page import ="com.web.common.user.UserDAO"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ include file ="/jsp/web/common/base.jsp" %>
<%
	AddressDTO addrDto = (AddressDTO)model.get("addrDto"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ּҷ� ���� �󼼺���</title>
<script>

var observer;//ó����
//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
}
<%--
function goSave(){

	var frm = document.AddressEdit; 
	var invalid = ' ';	//���� üũ
	
	if(frm.AddressName.value.length == 0){
		alert("����� �̸��� �Է��ϼ���.");
		return;
	}
	if(frm.FaxNo.value.length == 0){
		alert("�ѽ���ȣ�� �Է��ϼ���.");
		return;
	} 
	
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%=request.getContextPath()%>/H_Address.do?cmd=AddressModify';
		//alert(frm.action);
		frm.submit();
	}
}
--%>

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

//�ѽ���ȣ �ߺ�üũ Jquery Ajax
var ori_FaxNo = "<%=addrDto.getFaxNo()%>"; 
function fnDuplicateCheck2(val) {
	var FaxNo4 = $('[name=FaxNo4]').val();	//rplFaxNo4(�޹�ȣ) �� ����
	var rplFaxNo4 = FaxNo4.replace("-","");	//FaxNo2("-"�ڵ� ġȯ���� �κ� �ߺ�Ȯ�������� replace)
	var faxNoSumVal = $('[name=FaxNo3]').val() + rplFaxNo4;	 //DB�� ����� FaxNo1+FaxNo2=FaxNo(0212341234)�� ���ļ� �ߺ�Ȯ���ϱ�
	var faxNoLenRe = FaxNo4.replace("-","").length;	// �ѽ���ȣ ���ڸ��� ���� üũ.(7�ڸ��� 8�ڸ��� �����.)
	var faxNoLenSp = FaxNo4.split("-").length;	// �ѽ���ȣ ���ڸ� (-)���� ���� üũ.

	//DB�� �ִ� ���� ����Ÿ ������ �ѽ� ��ȣ �Է½ÿ� �ߺ�üũ(X) ��� ������.
	if(ori_FaxNo==faxNoSumVal){
		$('#AddressEdit #chkAlert').hide();
	//������ȣ ���� ������ ��� ���� show	
	}else if($('#AddressEdit [name=FaxNo3]').val() == ""){
		$('#AddressEdit #chkAlert').attr("color", "red");
		$('#AddressEdit #chkAlert').show().html("������ȣ�� �������ּ���.");
	//�ѽ� ���ڸ���ȣ �Է� ������ ��� ���� hide	
	}else if($('#AddressEdit [name=FaxNo4]').val() == ""){
		$('#AddressEdit #chkAlert').hide();
	//�ѽ� ���ڸ���ȣ 7,8�ڸ� �̸��� ���.
	}else if(faxNoLenRe == 1 || faxNoLenRe == 2 || faxNoLenRe == 3 || faxNoLenRe == 4 || faxNoLenRe == 5 || faxNoLenRe == 6){
		  $('#AddressEdit #chkAlert').attr("color","black");
		  $('#AddressEdit #chkAlert').show().html("�ѽ� �޹�ȣ�� (-)�� ������ 7~8�ڸ�<br> <font color='red'>(ex:123-1234,1234-1234)</font>���� �Է��ϼž� ���� ��ϵ˴ϴ�.");	
	//FaxNo "-" �� 2���� �������(ex[032-123-1234]) -���� üũ�� �ѽ���ȣ üũ����.
	}else if(faxNoLenSp != 2){
			$('#AddressEdit #chkAlert').attr("color","black");
			$('#AddressEdit #chkAlert').show().html("<br> *�ѽ���ȣ �Է� �� <font color='red'>������ȣ</font>�� �ݵ�� ������  <br> �ùٸ� �ѽ���ȣ�� �Է��ؾ� <font color='red'>(ex:02-1234-1234)</font> <br>(-)�������� �ùٸ��� �Էµ˴ϴ�.");
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
					$('#AddressEdit #chkAlert').attr("color","red");
					$('#AddressEdit #chkAlert').show().html("�̹� ��� �� �ִ� �ѽ���ȣ�Դϴ�.");break;
				case "0":
					$('#AddressEdit #chkAlert').attr("color","blue");
					$('#AddressEdit #chkAlert').show().html("��� ������ �ѽ���ȣ �Դϴ�.");break;
				}	
		},
		error : function(request, status, error){
			alert("�ߺ�üũ ����!");
		}
	});
	}
}

//�ּҷ� ����ó��
function goUpdate(){

	//Ajax �Ѱ��� Data ���� ����
	var Seq = $('[name=Seq]').val();
	var AddressName = $('#AddressName').val();
	var FaxNo = $('[name=FaxNo3]').val() + "-" + $('[name=FaxNo4]').val();
	var FaxNo3 = $('[name=FaxNo3]').val();
	var FaxNo4 = $('[name=FaxNo4]').val();
	var OfficePhone = $('#OfficePhone').val();
	var MobilePhone = $('#MobilePhone').val();
	var Email = $('#Email').val();
	var Memo = $('#Memo').val();
	//ajax submit
	
	if(AddressName == ""){
		alert('����ڸ��� �Է����ּ���.');
		return;
	}
	
	if(FaxNo3 == ""){
		alert('�ѽ� ������ȣ�� �������ּ���.');
		return;
	}
	
	if(FaxNo4 == ""){
		alert('�ѽ� ��ȣ ���ڸ��� �Է����ּ���.');
		return;
	}
	
	if(FaxNo == ""){
		alert('�ѽ���ȣ�� �Է����ּ���.');
		return;
	}
	
	if($('#AddressEdit #chkAlert').attr("color") == "red"){
		alert("�ѽ���ȣ�� Ȯ�����ּ���.");
		return;
	}
	
	if($('#AddressEdit #chkAlert').attr("color") == "black"){
		alert("�ѽ���ȣ �ڸ����� Ȯ�����ּ���.");
		return;
	}
	
	var requestUrl='<%=request.getContextPath()%>/H_Address.do?cmd=AddressModify';
			
	//�ߺ��ȵǴ� ��ĺз����� �� ajax�� ���
	$.ajax({
		url : requestUrl,
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"Seq" : Seq,
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
				alert('�ý��� �����Դϴ�!');
			}else if(data==0){
				alert('������ �����߽��ϴ�!');
			}else{
				alert('������ �����߽��ϴ�!');
			}	
			location.href='<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList';
		},
		error : function(request, status, error){
			alert("Jquery Ajax Error : [��� ����]");
		}
	});	
}



/*���� �˾� ���̾ƿ� ����
  Description:���̾ƿ� �˾� ��� �� function,name.id,������ �� �ٸ��� ����������Ѵ�.
  	                    �ش� ������ ���� �� �Լ����� ����� �о���� ���ϴ� ��� �߻�.
*/
function offVisibleUpdt() {
	/* var arrAddFrm = document.getElementsByName("formGroupAddForm");
	arrAddFrm[0].style.display = "none"; */
	//alert("123");
	$('#AddressEdit').dialog('close'); 
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
	
	
	
<body id="popup">
	<!-- ������ �Ѱ��� �� ���� -->
				<input type="hidden" name="Seq" value="<%=addrDto.getSeq()%>" /><!-- ���� �ε��� Ű-->
				<input type="hidden" name="UserID" value="<%=addrDto.getUserID()%>" /><!-- ������ ���̵� �������� �ʴ� �� -->
				<input type="hidden" name="ori_FaxNo" value="<%=addrDto.getFaxNo() %>" /><!-- DB�� ������ �ִ� FaxNo(���� ��ȣ�� �����Ҷ� �ߺ�üũ �� DB ����ϱ� ����) -->
				<!-- ������ �Ѱ��� �� �� -->
	<!-- layer popup : �ּҷ� ��/����-->
		<fieldset>
		<div class="ly_pop_new">
			<p class="text_guide"><strong class="blueTxt">*</strong> ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
							<tr>
	                            <th style="width:110px;">�̸� <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" id="AddressName" name="AddressName" maxlength="25" value="<%=addrDto.getAddressName()%>" tabindex="1"/></td>
	                        </tr>
	                        	<tr>
									<th>�ѽ���ȣ <strong class="blueTxt" title="�ʼ��Է�">*</strong></th>
									<td class="input_box">
									<%
									    //���� DB Į�� FaxNumber �Ѱ��� �ѽ���ȣ ���� �ֱ� ������.
									    //Select �ؿ� �� �ʵ尡 ������ �����Ƿ� - ������ �ѽ����� ��ȣ �� �޹�ȣ�� ������ Select �ؾ��Ѵ�.
									    //���������� �����͸� DB�� ���� ���� javascript �κп��� FaxNo ������ ��ȣ�� ������ ���� ���ļ� Update ���ش�. 
										String faxNo=StringUtil.nvl(addrDto.getFaxNoFormat(),"-");
										int indexx=faxNo.indexOf("-");
										String areaNo = faxNo.substring(0,indexx);    //�ѽ�������ȣ 
										String lastFaxNo = faxNo.substring(indexx+1); //�ѽ� �� ��ȣ 
										System.out.println("�ѽ�������ȣ:"+areaNo); //02-12341234 032-12341234
										System.out.println("�ѽ� �� ��ȣ:"+lastFaxNo);
									%>
									<%
										CodeParam codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("����");
										codeParam.setName("FaxNo3"); //���̾ƿ� �˾� ��ϰ� name�ٸ��� �� ������ ���̾ƿ� �˾��� open�ϴ� �θ��������� ���Ƽ� ���� ����� �о���� ����.
										codeParam.setSelected(areaNo); 
										codeParam.setEvent("javascript:fnDuplicateCheck2();"); 
										out.print(CommonUtil.getCodeListHanSeq(codeParam,"6")); 
									%>
									-
									<!-- ���̾ƿ� �˾� ��ϰ� name�ٸ��� �� ������ ���̾ƿ� �˾��� open�ϴ� �θ��������� ���Ƽ� ���� ����� �о���� ����.  -->
									<input id="FaxNo4" name="FaxNo4" type="text" value="<%=lastFaxNo %>" size="13"  maxlength="9" onkeydown="MaskPhon(this);" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this); fnDuplicateCheck2(this.value);" tabindex="3"  />
									<!-- FaxNo1 + FaxNo2 = FaxNo(���� DB Insert �� ��) -->
									<input name="FaxNo" type="hidden" value="<%=addrDto.getFaxNo()%>"></input>
									<br/>
									<font style="display: none;" id="chkAlert" >�̹� ��� ���Դϴ�.</font>
									<!-- 
									<br/><span class="ico_arr_g grayTxt">�ѽ���ȣ �Է½�<br /><span class="blueTxt">&nbsp;&nbsp;������ȣ</span>�� �ݵ�� <span class="blueTxt">����</span>�ؾ��մϴ�.</span>
									 -->
									</td>
								</tr>
	                        <tr>
	                            <th>��ȭ��ȣ(��/ȸ��)</th>
	                            <td class="input_box">
                                <input type="text" id="OfficePhone" name="OfficePhone" size="15" maxlength="13" value="<%=addrDto.getOfficePhoneFormat()%>" tabindex="4" dispName="(��/ȸ��)��ȭ��ȣ" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
	                        </tr>
	                        <tr>
	                        	<th>�޴��� ��ȣ</th>
	                            <td class="input_box"><input type="text" size="15" id="MobilePhone" name="MobilePhone" maxlength="13" value="<%=addrDto.getMobilePhoneFormat()%>" tabindex="5" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" /></td>
	                        </tr> 
	                        <tr>
	                            <th>E-Mail</th>
	                            <td class="input_box"><input type="text" size="28" id="Email" name="Email" maxlength="50" value="<%=addrDto.getEmail()%>" tabindex="6"/></td>
	                        </tr>
	                        
	                        <tr>
	                            <th>�޸�</th>
	                            <td class="input_box"><textarea  id="Memo" name="Memo" value="<%=addrDto.getMemo()%>" style="ime-mode:active;width:285px; height:40px; " tabindex="7" onKeyUp="js_Str_ChkSub('500', this)" dispName="�޸�"><%=addrDto.getMemo()%></textarea></td>
	                        </tr>
					</tbody>
					</table>
				</div>
		<!-- ���̺� �� -->
		<!-- bottom ���� -->
		<div class="ly_foot"><a href="javascript:goUpdate();"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="����" /></a><a href="javascript:offVisibleUpdt();"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a></div>
		<!-- bottom �� -->
			<iframe class="sbBlind sbBlind_AddressEdit"></iframe><!-- ie6 ����Ʈ�ڽ� ���� �ذ���-->
			</div>
		</fieldset>
	<!-- //layer popup : �ּҷ� ��/���� -->

</body>
</html>
<scirpt>
<%--
document.projectView.target_year.value='<%=target_year%>';
document.projectView.target_month.value='<%=target_month%>';
document.projectView.Start_Hour.value='<%=Start_Hour%>';
document.projectView.Start_Minute.value='<%=Start_Minute%>';
document.projectView.End_Hour.value='<%=End_Hour%>';
document.projectView.End_Minute.value='<%=End_Minute%>';
 --%>
</scirpt>