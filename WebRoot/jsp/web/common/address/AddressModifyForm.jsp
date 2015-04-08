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
<title>주소록 정보 상세보기</title>
<script>

var observer;//처리중
//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
}
<%--
function goSave(){

	var frm = document.AddressEdit; 
	var invalid = ' ';	//공백 체크
	
	if(frm.AddressName.value.length == 0){
		alert("사용자 이름을 입력하세요.");
		return;
	}
	if(frm.FaxNo.value.length == 0){
		alert("팩스번호를 입력하세요.");
		return;
	} 
	
	if(confirm("수정 하시겠습니까?")){
		frm.action='<%=request.getContextPath()%>/H_Address.do?cmd=AddressModify';
		//alert(frm.action);
		frm.submit();
	}
}
--%>

//전화번호 숫자 입력시 체크 후 - 생성
function MaskPhon( obj ) { 

	 obj.value =  PhonNumStr( obj.value ); //벨류값 있을시 PhonNumStr function 실행.

} 

//전화번호 숫자 입력시 체크 후 - 생성
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

	 // ↓ 전화번호 뒷자리만 - 단위로 replace 할 경우 조건식.
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

//팩스번호 중복체크 Jquery Ajax
var ori_FaxNo = "<%=addrDto.getFaxNo()%>"; 
function fnDuplicateCheck2(val) {
	var FaxNo4 = $('[name=FaxNo4]').val();	//rplFaxNo4(뒷번호) 값 셋팅
	var rplFaxNo4 = FaxNo4.replace("-","");	//FaxNo2("-"자동 치환해준 부분 중복확인을위해 replace)
	var faxNoSumVal = $('[name=FaxNo3]').val() + rplFaxNo4;	 //DB에 담아줄 FaxNo1+FaxNo2=FaxNo(0212341234)로 합쳐서 중복확인하기
	var faxNoLenRe = FaxNo4.replace("-","").length;	// 팩스번호 뒷자리로 길이 체크.(7자리와 8자리만 허용함.)
	var faxNoLenSp = FaxNo4.split("-").length;	// 팩스번호 뒷자리 (-)으로 길이 체크.

	//DB에 있는 기존 데이타 값으로 팩스 번호 입력시엔 중복체크(X) 등록 가능함.
	if(ori_FaxNo==faxNoSumVal){
		$('#AddressEdit #chkAlert').hide();
	//지역번호 선택 안했을 경우 툴팁 show	
	}else if($('#AddressEdit [name=FaxNo3]').val() == ""){
		$('#AddressEdit #chkAlert').attr("color", "red");
		$('#AddressEdit #chkAlert').show().html("지역번호를 선택해주세요.");
	//팩스 뒷자리번호 입력 안했을 경우 툴팁 hide	
	}else if($('#AddressEdit [name=FaxNo4]').val() == ""){
		$('#AddressEdit #chkAlert').hide();
	//팩스 뒷자리번호 7,8자리 미만일 경우.
	}else if(faxNoLenRe == 1 || faxNoLenRe == 2 || faxNoLenRe == 3 || faxNoLenRe == 4 || faxNoLenRe == 5 || faxNoLenRe == 6){
		  $('#AddressEdit #chkAlert').attr("color","black");
		  $('#AddressEdit #chkAlert').show().html("팩스 뒷번호는 (-)을 제외한 7~8자리<br> <font color='red'>(ex:123-1234,1234-1234)</font>까지 입력하셔야 정상 등록됩니다.");	
	//FaxNo "-" 가 2개가 없을경우(ex[032-123-1234]) -갯수 체크로 팩스번호 체크시작.
	}else if(faxNoLenSp != 2){
			$('#AddressEdit #chkAlert').attr("color","black");
			$('#AddressEdit #chkAlert').show().html("<br> *팩스번호 입력 시 <font color='red'>지역번호</font>를 반드시 포함한  <br> 올바른 팩스번호를 입력해야 <font color='red'>(ex:02-1234-1234)</font> <br>(-)포맷으로 올바르게 입력됩니다.");
			return;
	//중복체크 시작
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
				case "" : alert("팩스번호 중복 체크 오류!");break;
				case "1": 
					$('#AddressEdit #chkAlert').attr("color","red");
					$('#AddressEdit #chkAlert').show().html("이미 등록 되 있는 팩스번호입니다.");break;
				case "0":
					$('#AddressEdit #chkAlert').attr("color","blue");
					$('#AddressEdit #chkAlert').show().html("사용 가능한 팩스번호 입니다.");break;
				}	
		},
		error : function(request, status, error){
			alert("중복체크 오류!");
		}
	});
	}
}

//주소록 수정처리
function goUpdate(){

	//Ajax 넘겨줄 Data 변수 선언
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
		alert('사용자명을 입력해주세요.');
		return;
	}
	
	if(FaxNo3 == ""){
		alert('팩스 지역번호를 선택해주세요.');
		return;
	}
	
	if(FaxNo4 == ""){
		alert('팩스 번호 뒷자리를 입력해주세요.');
		return;
	}
	
	if(FaxNo == ""){
		alert('팩스번호를 입력해주세요.');
		return;
	}
	
	if($('#AddressEdit #chkAlert').attr("color") == "red"){
		alert("팩스번호를 확인해주세요.");
		return;
	}
	
	if($('#AddressEdit #chkAlert').attr("color") == "black"){
		alert("팩스번호 자리수를 확인해주세요.");
		return;
	}
	
	var requestUrl='<%=request.getContextPath()%>/H_Address.do?cmd=AddressModify';
			
	//중복안되는 양식분류명일 때 ajax로 등록
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
			
			//결과 메시지 처리부분.
			if(data==-1){
				alert('시스템 오류입니다!');
			}else if(data==0){
				alert('수정을 실패했습니다!');
			}else{
				alert('수정을 성공했습니다!');
			}	
			location.href='<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList';
		},
		error : function(request, status, error){
			alert("Jquery Ajax Error : [등록 실패]");
		}
	});	
}



/*수정 팝업 레이아웃 닫힘
  Description:레이아웃 팝업 사용 시 function,name.id,변수명 을 다르게 지정해줘야한다.
  	                    해당 데이터 값들 및 함수들을 제대로 읽어오지 못하는 경우 발생.
*/
function offVisibleUpdt() {
	/* var arrAddFrm = document.getElementsByName("formGroupAddForm");
	arrAddFrm[0].style.display = "none"; */
	//alert("123");
	$('#AddressEdit').dialog('close'); 
}
</script>
</head>
<!-- 처리중 시작 -->
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
<!-- 처리중 종료 -->
	
	
	
<body id="popup">
	<!-- 수정시 넘겨줄 값 시작 -->
				<input type="hidden" name="Seq" value="<%=addrDto.getSeq()%>" /><!-- 고유 인덱스 키-->
				<input type="hidden" name="UserID" value="<%=addrDto.getUserID()%>" /><!-- 생성자 아이디 수정되지 않는 값 -->
				<input type="hidden" name="ori_FaxNo" value="<%=addrDto.getFaxNo() %>" /><!-- DB에 가지고 있는 FaxNo(같은 번호로 수정할때 중복체크 후 DB 등록하기 위해) -->
				<!-- 수정시 넘겨줄 값 끝 -->
	<!-- layer popup : 주소록 상세/수정-->
		<fieldset>
		<div class="ly_pop_new">
			<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
							<tr>
	                            <th style="width:110px;">이름 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" id="AddressName" name="AddressName" maxlength="25" value="<%=addrDto.getAddressName()%>" tabindex="1"/></td>
	                        </tr>
	                        	<tr>
									<th>팩스번호 <strong class="blueTxt" title="필수입력">*</strong></th>
									<td class="input_box">
									<%
									    //현재 DB 칼럼 FaxNumber 한곳에 팩스번호 값을 넣기 때문에.
									    //Select 해올 때 필드가 나눠져 있으므로 - 단위로 팩스지역 번호 와 뒷번호를 나눠서 Select 해야한다.
									    //최종적으로 데이터를 DB에 넣을 때는 javascript 부분에서 FaxNo 나눠진 번호를 변수에 값을 합쳐서 Update 해준다. 
										String faxNo=StringUtil.nvl(addrDto.getFaxNoFormat(),"-");
										int indexx=faxNo.indexOf("-");
										String areaNo = faxNo.substring(0,indexx);    //팩스지역번호 
										String lastFaxNo = faxNo.substring(indexx+1); //팩스 뒷 번호 
										System.out.println("팩스지역번호:"+areaNo); //02-12341234 032-12341234
										System.out.println("팩스 뒷 번호:"+lastFaxNo);
									%>
									<%
										CodeParam codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("선택");
										codeParam.setName("FaxNo3"); //레이아웃 팝업 등록과 name다른게 준 이유는 레이아웃 팝업을 open하는 부모페이지가 같아서 값을 제대로 읽어오지 못함.
										codeParam.setSelected(areaNo); 
										codeParam.setEvent("javascript:fnDuplicateCheck2();"); 
										out.print(CommonUtil.getCodeListHanSeq(codeParam,"6")); 
									%>
									-
									<!-- 레이아웃 팝업 등록과 name다른게 준 이유는 레이아웃 팝업을 open하는 부모페이지가 같아서 값을 제대로 읽어오지 못함.  -->
									<input id="FaxNo4" name="FaxNo4" type="text" value="<%=lastFaxNo %>" size="13"  maxlength="9" onkeydown="MaskPhon(this);" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this); fnDuplicateCheck2(this.value);" tabindex="3"  />
									<!-- FaxNo1 + FaxNo2 = FaxNo(최종 DB Insert 될 값) -->
									<input name="FaxNo" type="hidden" value="<%=addrDto.getFaxNo()%>"></input>
									<br/>
									<font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font>
									<!-- 
									<br/><span class="ico_arr_g grayTxt">팩스번호 입력시<br /><span class="blueTxt">&nbsp;&nbsp;지역번호</span>를 반드시 <span class="blueTxt">포함</span>해야합니다.</span>
									 -->
									</td>
								</tr>
	                        <tr>
	                            <th>전화번호(집/회사)</th>
	                            <td class="input_box">
                                <input type="text" id="OfficePhone" name="OfficePhone" size="15" maxlength="13" value="<%=addrDto.getOfficePhoneFormat()%>" tabindex="4" dispName="(집/회사)전화번호" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
	                        </tr>
	                        <tr>
	                        	<th>휴대폰 번호</th>
	                            <td class="input_box"><input type="text" size="15" id="MobilePhone" name="MobilePhone" maxlength="13" value="<%=addrDto.getMobilePhoneFormat()%>" tabindex="5" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" /></td>
	                        </tr> 
	                        <tr>
	                            <th>E-Mail</th>
	                            <td class="input_box"><input type="text" size="28" id="Email" name="Email" maxlength="50" value="<%=addrDto.getEmail()%>" tabindex="6"/></td>
	                        </tr>
	                        
	                        <tr>
	                            <th>메모</th>
	                            <td class="input_box"><textarea  id="Memo" name="Memo" value="<%=addrDto.getMemo()%>" style="ime-mode:active;width:285px; height:40px; " tabindex="7" onKeyUp="js_Str_ChkSub('500', this)" dispName="메모"><%=addrDto.getMemo()%></textarea></td>
	                        </tr>
					</tbody>
					</table>
				</div>
		<!-- 테이블 끝 -->
		<!-- bottom 시작 -->
		<div class="ly_foot"><a href="javascript:goUpdate();"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="수정" /></a><a href="javascript:offVisibleUpdt();"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a></div>
		<!-- bottom 끝 -->
			<iframe class="sbBlind sbBlind_AddressEdit"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
			</div>
		</fieldset>
	<!-- //layer popup : 주소록 상세/수정 -->

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