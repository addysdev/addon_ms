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
	//(일반문서,양식,스캔)발신 페이지에서 받아온 폼명
	String FormName = (String)model.get("FormName"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>수신인 리스트</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/common_1.js"></script>

<script>
//내 주소록 목록 수신인리스트 로 이동시키기.
function goMove(){
	var frm = AddressPopListFrame.AddressForm;
	var addrInfo = ''; //선택된 주소록 정보(이름|팩스번호 값)
	var addrSp = '';   //선택된 주소록 정보 분리(이름,팩스번호 값)
	var checks=0;	   //checked 된 ++ arr 값.
	var addrEnc = '';

//동보발신을 위한 수신인 다건 이동일때.
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
					//console.log(addrSp[0]+"//"+rightVal); //해당 벨류 체크 함수 
					//console.log(rightVal);
					//동일한 value값이 없을때 append
					//alert(rightVal);
					
					
					
					var rightVal1 = $('#RevData [value='+addrSp[0]+']').length; //addrSp[0]의 전체 벨류를.length; 길이로 있는지 없는지 체크해주는 변수.	
					var RevCount1 = $('[name=seqval]').length; //해당 name의 총 value 값(수신인 리스트 목록 가져오기 위해 사용됨.)
		
					//동보 발신 10명까지 체크 시작.	
					if(RevCount1 > 9){ //Checkbox Arr 체크로 수신인을 이동 시키므로 (RevCount > 9)9인 이유는 Arr는 0부터 시작하기때문.
						alert('팩스 동보 발신은 최대 10명까지 가능합니다.');
						return;
					}	
					//수신인 리스트에 동일한 수신인이 있는지  체크 후 이동불가.
					if(rightVal1 == 0){
						$('#RevData', document).append("<tr id='TR_"+addrSp[0]+"'><td><a href=\"javascript:goDelete("+addrSp[0]+")\" target=\"_self\"><img src=\"<%= request.getContextPath() %>/images/sub/minus-circle.gif\" title=\"선택취소\"/></a></td><td>"+addrSp[1]+"</td><td>"+addrSp[2]+"</td><input type='hidden' id='seqval' name='seqval' value="+addrSp[0]+"></input><input type='hidden' id='CustomerName' name='CustomerName_"+addrSp[0]+"' value="+addrSp[1]+"></input><input type='hidden' id='FaxNo' name='FaxNo_"+addrSp[0]+"' value="+addrSp[2]+"></input></tr>");	
					} 
				} 
			}	
		}
//팩스 수신인 단건 일때.		
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
				
					//console.log(addrSp[0]+"//"+rightVal); //해당 벨류 체크 함수 
					//console.log(rightVal);
					//동일한 value값이 없을때 append
					//alert(rightVal);
					
				
					
				var rightVal2 = $('#RevData [value='+addrSp[0]+']').length; //addrSp[0]의 전체 벨류를.length; 길이로 있는지 없는지 체크해주는 변수.	
				var RevCount2 = $('[name=seqval]').length; //해당 name의 총 value 값(수신인 리스트 목록 가져오기 위해 사용됨.)
	
				//동보 발신 10명까지 체크 시작.	
				if(RevCount2 > 9){ //Checkbox Arr 체크로 수신인을 이동 시키므로 (RevCount > 9)9인 이유는 Arr는 0부터 시작하기때문.
					alert('팩스 동보 발신은 최대 10명까지 가능합니다.');
					return;
				}	
				//수신인 리스트에 동일한 수신인이 있는지  체크 후 이동불가.
				if(rightVal2 == 0){
					$('#RevData', document).append("<tr id='TR_"+addrSp[0]+"'><td><a href=\"javascript:goDelete("+addrSp[0]+")\" target=\"_self\"><img src=\"<%= request.getContextPath() %>/images/sub/minus-circle.gif\" title=\"선택취소\"/></a></td><td>"+addrSp[1]+"</td><td>"+addrSp[2]+"</td><input type='hidden' id='seqval' name='seqval' value="+addrSp[0]+"></input><input type='hidden' id='CustomerName' name='CustomerName_"+addrSp[0]+"' value="+addrSp[1]+"></input><input type='hidden' id='FaxNo' name='FaxNo_"+addrSp[0]+"' value="+addrSp[2]+"></input></tr>");	
				} 
			} 
		}	
	}
}
//수신인 리스트 취소하기.
function goDelete(seqval){

	$('[id=TR_'+seqval+']').remove();
}
//수신인 리스트 전체 취소하기.
function goAllDelete(){
var rev_Tr =	$('#RevData tr').length; //append 된 tr 길이값(갯수)
var rev_Td =	$('#RevData td').length; //append 된 td 길이값(갯수)
var rev_SeqPk =	$('#RevData [name=seqval]').length; //append 된 Seq value Pk 길이값(갯수)
var rev_a_tag = $('#RevData a').length; //append 된 삭제이미지 태그 길이값(갯수)
var rev_Name = $('#RevData #CustomerName').length; //append 된 수신인 이름 길이값(갯수)
var rev_Fax = $('#RevData #FaxNo').length; //append 된 팩스번호 길이값(갯수)

	if(rev_Tr==0 && rev_Td==0 && rev_SeqPk==0 && rev_a_tag==0 && rev_Name==0 && rev_Fax==0){
		
		alert('전체 선택취소할 수신인이 존재하지 않습니다.');
	
	}else{
		
		$('#RevData tr').remove();
		$('#RevData td').remove();
		$('#RevData [name=seqval]').remove();
		$('#RevData a').remove();
		$('#RevData #CustomerName').remove();
		$('#RevData #FaxNo').remove();
	}

}
//수신인 리스트 최종 선택하기.
function goSelected(){
	//ajax로 form submit
	
	var seqLen = $('[name=seqval]').length;  //해당 name의 총 value 값(수신인 리스트 목록 가져오기 위해 사용됨.)
	var nameData = "";       //팩스 발신 엔진으로 전달해줄 (,처리된)Data값.(수신인)
	var faxNoData = "";      //팩스 발신 엔진으로 전달해줄 (,처리된)Data값.(팩스번호)
	var nameDataView = "";   //팩스 발신으로 전달해줄 (Viewing)Data값.(수신인)
	var faxNoDataView = "";  //팩스 발신으로 전달해줄 (Viewing)Data값.(팩스번호)
	var nameDataTitle = "";  //팩스 발신으로 전달해줄 (Title="")Data값.(수신인)
	var faxNoDataTitle = ""; //팩스 발신으로 전달해줄 (Title="")Data값.(팩스번호)
	
	for(var x=0; x< seqLen; x++){
		var seqval = $('[name=seqval]').eq(x).val(); //해당 name의 총 value 값
		var data1 = $('[name=CustomerName_'+seqval+']').val(); //해당 name + seqval(index pk)의 val(선택한 수신자명) 값
		var data2 = $('[name=FaxNo_'+seqval+']').val();	//해당 name + seqval(index pk)의 val(선택한 팩스번호) 값
		
		//수신인 선택하기 시작(현재 동보 발신의 경우 수신인명:test1,test2 콤마 처리를 해줌)
		if(x == 0){
		nameData += data1; //수신인 한명일때
		nameDataView += data1; 
		}else{
		nameData += ","+data1; //수신인 여러명일때.
		nameDataView;
		nameDataTitle += data1+"<br>";
		}
		
		//수신인 팩스번호 선택하기 시작(현재 동보 발신의 경우 팩스번호:02-1234-1234,02-4321-4321 콤마 처리해줌)
		if(x == 0){
		faxNoData += data2; //수신인 한명일때 팩스번호
		faxNoDataView += data2;
		}else{
		faxNoData += ","+data2; //수신인 여러명일때 팩스번호 
		faxNoDataView;
		faxNoDataTitle += data2+"<br>";
		}
		
	}
	
	if(x == 1){	
		
	<%=FormName%>.CustomerName.value = nameDataView; 				//팩스 수신인 1명일 경우 보여질 View Data 값 (수신인)
	<%=FormName%>.FaxNo.value = faxNoDataView;       				//팩스 수신인 1명일 경우 보여질 View Data 값 (팩스번호)
	<%=FormName%>.CustomerName.title = nameData;	 				//팩스 수신인 1명일 경우 View Tooltip title="값(수신인)"
	<%=FormName%>.FaxNo.title = faxNoData;    		 				//팩스 수신인 1명일 경우 View Tooltip title="값(팩스번호)"
	<%=FormName%>.CustomerNameData.value = nameData; 				//실제 팩스 발신 엔진으로 넘겨줄 Data값 (수신인)
	<%=FormName%>.FaxNoData.value = faxNoData;      			    //실제 팩스 발신 엔진으로 넘겨줄 Data값 (팩스번호)
	<%=FormName%>.NowRegist.checked = true;          				//팩스 수신인 1명일 경우 checked(o)
	<%=FormName%>.CustomerName.readOnly = false;	 				//팩스 수신인 1명일 경우 text box 수정가능(수신인)
	<%=FormName%>.FaxNo.readOnly = false;			 				//팩스 수신인 1명일 경우 text box 수정가능(팩스번호)
	document.getElementById("CustomerName").style.background = "";  //체크박스 선택 시 text box 회색으로 변경.(수신인)
	document.getElementById("FaxNo").style.background = ""; 		//체크박스 선택 시 text box 회색으로 변경.(팩스번호)
	
	}else if(x>1){	
	var RevCount = x - 1 //선택한 수신인 외 건을 표기 하기위해 전체 Data 에서 -1 해줌.
	<%=FormName%>.CustomerName.value = nameDataView+" 외"+RevCount+"명";     //동보발신 1명 이상일 경우 보여질 View Data값(수신인)
	<%=FormName%>.FaxNo.value = faxNoDataView+" 외"+RevCount+"건";           //동보발신 1명 이상일 경우 보여질 View Data값(팩스번호)
	<%=FormName%>.CustomerName.title = nameDataTitle;        			    //동보발신 1명 이상일 경우 보여질 View Tooltip title="값(수신인)"
	<%=FormName%>.FaxNo.title = faxNoDataTitle;       				        //동보발신 1명 이상일 경우 보여질 View Tooltip title="값(팩스번호)"
	<%=FormName%>.CustomerNameData.value = nameData;                        //실제 팩스 발신 엔진으로 넘겨줄 (콤마처리된)Data값(수신인)
	<%=FormName%>.FaxNoData.value = faxNoData;                              //실제 팩스 발신 엔진으로 넘겨줄 (콤마처리된)Data값(팩스번호)
	<%=FormName%>.NowRegist.checked = false;                                //팩스 수신인 1명 이상(동보발신)일 경우  checked(x)
	<%=FormName%>.CustomerName.readOnly = true;							    //팩스 수신인 1명 이상(동보발신)일 경우 text box 수정불가(수신인)
	<%=FormName%>.FaxNo.readOnly = true;								    //팩스 수신인 1명 이상(동보발신)일 경우 text box 수정불가(팩스번호)
	document.getElementById("CustomerName").style.background = "#e5e5e5";   //체크박스 해제 시 text box 회색으로 변경.(수신인)
	document.getElementById("FaxNo").style.background = "#e5e5e5";          //체크박스 해제 시 text box 회색으로 변경.(팩스번호)
	}
	
	if(nameData != ''){		
	$('#addressList').dialog('close');
	alert('팩스 수신인 선택을 완료하였습니다.');
	}else{
	alert(' 팩스 수신인이 존재 하지않습니다.\n 주소록 리스트에서 수신인 체크 이동 후 선택하기를 눌러주세요.');
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

/*내 주소록 레이아웃 팝업 닫기(일반문서발신,양식발신,스캔발신 공통)
  Description : 레이아웃 팝업 close 시 a link로 처리하여 팝업이 하나 열리는 현상이 발생함.
  				처리방법 해당 script a link에 target="_self" 를 넣어주면 해결됨. 
*/
function closeAddressPop(){
	$('#addressList').dialog('close');
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
<body id="popup" onLoad = "init()">
	<form  method="post" name="AddressMove" action="<%=request.getContextPath()%>/H_User.do?cmd=userRegist">
	<!-- 레이아웃 시작 -->
	<div id="AddressPageListPop">
		<!-- 메인컨텐츠 시작 -->
		<div id="pop_contents">
			<!-- 양식 전체 시작 -->
			<div class="form_all">
				<!-- 팩스양식 선택 세트 시작 -->
				<div class="form_lft">
					<!-- AddressPageListPop.jsp 검색or 리스트 아이프레임 시작  -->
					<iframe src="<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame" id="AddressPopListFrame" name="AddressPopListFrame" frameborder="0" class="" scrolling="no" width="306" height="594"></iframe>
					<!-- AddressPageListPop.jsp 검색or 리스트 아이프레임 시작  끝-->
				</div>
				<!-- 팩스양식 선택 세트 끝 -->
				<!-- 화살표 시작 -->
				<div class="arrow_addlist"><span class="blind">주소록 선택 이동</span></div>
				<!-- 화살표 끝 -->
				<!-- 발송양식 작성 세트 시작 -->
				<div class="form_rgt">
					<!-- 서브타이틀 영역 : 시작 -->
					<div class="pop_sub_title">
						<p class="pop_titleP">수신인 리스트</p>
					</div>
					<!-- 서브타이틀 영역 : 끝 -->
					<!-- 주석영역 : 시작 -->
					<div class="listGuide"><span class="blueTxt_b">내주소록으로 팩스 발신하기</span><br />1. 좌측 내 주소록 리스트에서 발신할 팩스 수신인<br />&nbsp;&nbsp;&nbsp;선택 후 이동 버튼을 누른다.<br />2. 선택된 사용자(수신인)을 최종 확인 후 선택하기<br />&nbsp;&nbsp;&nbsp;버튼을 누른다.<br /><span class="blueTxt letter_S">* Tip : 팩스 동보 발신은 최대 10명 까지 가능합니다. *</span></div>
					<!-- 주석영역 : 끝 -->
					<!-- 발송양식 작성 테이블 시작 -->
					<div class="pop_list_box">
						<div class="tbl_type_out">
							<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
								<caption>주소록 관리</caption>
								<colgroup>
									<col width="10%" />
									<col width="40%" />
									<col width="50%" />
								</colgroup>
								<thead>
								<tr>
									<th><a href="javascript:goAllDelete()" target="_self"><img src="<%= request.getContextPath() %>/images/sub/minus-allcircle.gif" title="전체취소"/></a></th>
									<th>사용자명</th>
									<th>팩스번호</th>
								</tr>
								</thead>
								<tbody id="RevData">
								</tbody>
							</table>
						</div>
					</div>
					<!-- 발송양식 작성 테이블 끝 -->
					<!-- bottom 시작 -->
					<div id="bottom">
						<div class="bottom_top"> <a href="javascript:goSelected()" target="_self"><img src="<%= request.getContextPath() %>/images/popup/btn_choice.gif" title="선택하기"  /></a></div>
					</div>
					<!-- bottom 끝 -->
				</div>
				<!-- 발송양식 작성 세트 끝 -->
			</div>
			<!-- 양식 전체 끝 -->
			
			<!-- bottom 시작 -->
			<div id="bottom">
				<div class="bottom_top"><a href="javascript:closeAddressPop();" target="_self"><img src="<%= request.getContextPath() %>/images/sub/btn_cancel.gif" title="취소" /></a></div>
			</div>
			<!-- bottom 끝 -->
		</div>
		<!-- 메인컨텐츠 끝 -->
		<iframe class="sbBlind sbBlind_addressList"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
	</div>
	<!-- 레이아웃 끝 -->
	</form>
</body>
</html>
