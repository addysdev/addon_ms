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

	if (searchGb.equals("1")) { 	//사용자명(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //팩스번호
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
<title>주소록 관리</title>
<script>
var openWin=0;//팝업객체
var isSearch=0;

//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	searchChk();
}

//전체 선택시 검색박스 disable
function searchChk() {
	var obj = document.AddressForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}

//검색
function goSearch() {
	var obj=document.AddressForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//공백 체크
	
	if ( isSearch == 0 ) {
		isSearch = 1;
		return
	}

	if(gubun=='1'){
		if(obj.searchtxt.value=='' ){
			alert('사용자 이름을 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('팩스번호를 입력해 주세요');
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

//체크박스 전체 선택
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
//체크 박스 선택 삭제(다건/단건) 
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
		alert("삭제할 사용자를 선택해 주세요!")
	} else {
		if(!confirm("정말로 삭제하시겠습니까?"))
			return;
		
		frm.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressDeletes";
		frm.submit();
	}
}


// 커서  색상 처리 시작

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



//커서  색상 처리 끝


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


//주소록 등록  레이아웃 팝업
$(function(){
	$('#addressRegist').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 435,
		width : 450,
		autoOpen : false,
		modal : true
	
	});
});

//주소록 등록
function formAddressRegistPop(){
	//주소록 등록  레이아웃 팝업
	$( "#addressRegist" ).dialog( "open" );
	
}

//주소록 등록처리
function goSave(){
	
	//Ajax 넘겨줄 Data 변수 선언
	var AddressName = $('[name=AddressName]').val();
	var FaxNo1 = $('[name=FaxNo1]').val();
	var FaxNo2 = $('[name=FaxNo2]').val();
	var FaxNo =  $('[name=FaxNo1]').val() +"-"+ $('[name=FaxNo2]').val();	
	var OfficePhone = $('[name=OfficePhone]').val();
	var MobilePhone = $('[name=MobilePhone]').val();
	var Email = $('[name=Email]').val();
	var Memo = $('[name=Memo]').val();
	var faxNoLenRe = FaxNo2.replace("-","").length;	// 팩스번호 뒷자리 으로 길이 체크.
	//alert(faxNoLenRe);
	//ajax submit
	
	if(AddressName == ""){
		alert('사용자명을 입력해주세요.');
		return;
	}
	
	if(FaxNo1 == ""){
		alert('팩스 지역번호를 선택해주세요.');
		return;
	}
	
	if(FaxNo2 == ""){
		alert('팩스 번호 뒷자리를 입력해주세요.');
		return;
	}
	
	if(FaxNo == ""){
		alert('팩스번호를 입력해주세요.');
		return;
	}

	if($('#FaxNoCheck').val() == "1"){
		alert("팩스번호를 확인해주세요.");
		return;
	}
	
	if($('#FaxNoCheck2').val() == "2"){
		alert("팩스번호 자리 수를 확인해주세요.");
		return;
	}

	if($('#FaxNoCheck2').val() == "3"){
		alert("올바른 팩스번호를 입력해주세요.");
		return;
	}
	
	var requestUrl='<%=request.getContextPath()%>/H_Address.do?cmd=AddressRegist';
			
	//중복안되는 양식분류명일 때 ajax로 등록
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
			
			//결과 메시지 처리부분.
			if(data==-1){
				alert('시스템 오류입니다.!');
			}else if(data==0){
				alert('등록을 실패했습니다!');
			}else{
				alert('등록을 성공했습니다!');
			}	
			location.href='<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList';
		},
		error : function(request, status, error){
			alert("Jquery Ajax Error : [등록 실패]");
		}
	});	
}


/*등록 레이아웃 닫힘
  Description:레이아웃 팝업 사용 시 function,name.id,변수명 을 다르게 지정해줘야한다.
  	                    해당 데이터 값들 및 함수들을 제대로 읽어오지 못하는 경우 발생.
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

//팩스번호 중복체크 Jquery Ajax
function fnDuplicateCheck(val) {
	//var FaxNo1 = $('[name=FaxNo1]').val()+'-';	//FaxNo2(지역번호) -값으로 아래 로직에서 불가한 팩스번호 입력시 Alert을위해사용.
	var FaxNo2 = $('[name=FaxNo2]').val();	    //FaxNo2(뒷번호) 값 셋팅
	var rplFaxNo2 = FaxNo2.replace("-","");	    //FaxNo2("-"자동 치환해준 부분 중복확인을위해 replace)
	var faxNoSumVal = $('[name=FaxNo1]').val() + rplFaxNo2;	 //DB에 담아줄 FaxNo1+FaxNo2=FaxNo(0212341234)로 합쳐서 중복확인하기
	var faxSumNo = FaxNo1+FaxNo2;
	var faxNoLenRe = FaxNo2.replace("-","").length;	// 팩스번호 뒷자리로 길이 체크.(7자리와 8자리만 허용함.)
	var faxNoLenSp = FaxNo2.split("-").length;	    // 팩스번호 뒷자리 (-)개수로 길이 체크.

	//지역번호 선택 안했을때 show.
	if($('[name=FaxNo1]').val() == ""){ 
		$('#chkAlert').attr("color", "red");
		$('#chkAlert').show().html("지역번호를 선택해주세요.");
	//팩스뒷번호 입력 안했을때 hide 	
	}else if($('[name=FaxNo2]').val() == ""){
		$('#chkAlert').hide();
	//팩스뒷번호 7,8자리 미만 일 경우.
	}else if(faxNoLenRe == 1 || faxNoLenRe == 2 || faxNoLenRe == 3 || faxNoLenRe == 4 || faxNoLenRe == 5 || faxNoLenRe == 6){
		  $('#chkAlert').attr("color","black");
		  $('#chkAlert').show().html("팩스 뒷번호는 (-)을 제외한 7~8자리<br> <font color='red'>(ex:123-1234,1234-1234)</font>까지 입력하셔야 정상 등록됩니다.");
		  $('#FaxNoCheck').val(""); //case check value
		  $('#FaxNoCheck2').val("2"); //case check value
	//FaxNo "-" 가 2개가 없을경우(ex[032-123-1234]) -갯수 체크로 팩스번호 체크시작.
	}else if(faxNoLenSp != 2){
			$('#chkAlert').attr("color","black");
			$('#chkAlert').show().html("<br> *팩스번호 입력 시 <font color='red'>지역번호</font>를 반드시 포함한  <br> 올바른 팩스번호를 입력해야 <font color='red'>(ex:02-1234-1234)</font> <br>(-)포맷으로 올바르게 입력됩니다.");
			$('#FaxNoCheck').val(""); //case check value
			$('#FaxNoCheck2').val("3"); //case check value
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
					$('#chkAlert').attr("color","red");
					$('#chkAlert').show().html("이미 등록 되 있는 팩스번호입니다.");
					$('#FaxNoCheck').val(data); //case chekc value
					break;
				case "0":
					$('#chkAlert').attr("color","blue");
					$('#chkAlert').show().html("사용 가능한 팩스번호 입니다.");
					$('#FaxNoCheck').val(data); //case check value
					$('#FaxNoCheck2').val(data); //case check value
					break;
				}	
		},
		error : function(request, status, error){
			alert("중복체크 오류!");
		}
	});
	}
}

//주소록 상세/수정 레이아웃 팝업
function formAddressEditPop(Seq){

	$('#AddressEdit').dialog({
		resizable : false, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 415,
		width : 450,
		//autoOpen : false,
		modal : true,
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Address.do?cmd=AddressView',
				{'Seq' : Seq});
			//레이아웃 바깥쪽 클릭 시 팝업 닫히도록 세팅
			/*
			$('.ui-widget-overlay').bind('click',function(){
                $('#JobRegistPop').dialog('close');
            });
			*/
			
		}
	});
	
}

<%-- 현재사용안함(2013.07.29).
//해당 지역번호 매핑 지역명 보여주기.
/*
 * 
function codeMapping(val){
	
	//document.getElementById("codebookId").value=val;
	//alert(val);
	var areaVal = "지역명 : "+val;
	//alert(areaVal);
	//alert($('#codebookId').val() = val);
	$('#codebookId').html(areaVal);
	(val != "")? document.AddressForm : location.href = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageList";
}
 */
	--%>

//Excel 일괄등록 팝업
 function goExcelUpdate(){
 	$('#AddressExcelForm').dialog({
 		resizable : true, //사이즈 변경 불가능
 		draggable : true, //드래그 불가능
 		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
 		
 		height : 550,
 		width : 420,
 		modal : true,
 		/* position : {
 			my : 'left top',
 			at : 'right top',
 			of : $('#regBt')
 		}, */
 		open:function(){
 			
 			//팝업 가져올 url
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

		<!-- 레이아웃 시작 -->
		<div id="wrap_1000">
		
		<!-- TOP 타이틀 시작 -->
			<div id="header">
				<div class="pop_top">
					<p><img src="<%=request.getContextPath()%>/images/popup/text_AddressPageList.gif" alt="운영자 매뉴얼" /></p> <!-- 타이틀 이미지필요. -->
				</div>
			</div>
			<!-- TOP 타이틀 끝 -->
		</div>

		<!-- 메인컨텐츠 시작 -->
		<div id="pop_contents">
		
		<!-- 검색 영역 : 시작 -->
        <div id="seach_box" class="pop_seach_box">
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- 셀렉트 박스 -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>전체</option>
                       <option value="1" <%=aselect%>>사용자명</option>
                       <option value="2" <%=bselect%>>팩스번호</option>
                   </select>
               </p> 
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- 검색 text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" title="검색"/></a> </p> <!-- 조회 버튼 --> 
	                  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="엑셀 다운로드" /></a> </p> <!-- 엑셀 아이콘 -->
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="내 주소록정보 일괄등록" /></a></p>  <!-- 내 주소록정보 일괄등록 아이콘 -->
	                  <!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="엑셀 업로드" /> </p> <!-- 엑셀 아이콘 --> 
			</div>
                   <!-- 검색 끝-->
    	<!-- 검색 > 그룹 셀렉박스 : 끝-->
		</div>
	<!-- 검색 영역 : 끝 -->     
			<!-- 테이블 : 시작 -->
			<div id="code_origin" class="pop_list_box">
			<!-- 오른쪽 버튼 시작 -->
	                <div class="btn_box">
	                    <p><a href="javascript:formAddressRegistPop();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="등록" /></a></p>
	 				</div>
			  <!-- 오른쪽 버튼 끝 -->
			<ul class="listNm">
				<li>전체건수 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>건</span></li>
				<li class="last">현재페이지 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out" style="zoom:1;">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>주소록 관리</caption>
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
		                  <th>사용자명</th>
		                  <th>팩스번호</th>
		                  <th>Email</th>
		                  <th>메모</th>
		                </tr>
		            </thead>
		            <tbody>
		            <!-- :: loop :: -->
					<!--리스트---------------->
					<%
						if (ld.getItemCount() > 0) {
							int i = 0;
							while (ds.next()) {
								
						//로우색상변경 시작
						int num = 0;
						String rowClass="";
						
						num = i % 2;
						
						if(num==1){
							rowClass="#FAFAFA";
						
						}else{
							rowClass="#FFFFFF";
							
						}
						//로우색상변경 끝  
						
						%>
				<%----%>
				<!-- 확인 미확인 구분 볼드처리 시작-->	
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
	            <!-- 확인 미확인 구분 볼드처리 끝 -->
				 
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
						<td colspan="5">게시물이 없습니다.</td>
					</tr>
					<script>
						goSearch();
					</script>
					<%
						}
					%>
					<!-- 리스트 하단 버튼 영역 : 시작 -->
					<tr id="list_btn_box">
						<td colspan="5">선택된 항목 삭제<input type="hidden" name="IdongGb" value="Y"><span class="btn"><a href="javascript:goDelete();"><img src="<%=request.getContextPath()%>/images/sub/btn_delete_02.gif" title="삭제" /></a></span><!-- 버튼 -->
						</td>
					</tr>
					<!--리스트 하단 버튼 영역 : 끝 -->
		          </tbody>
		        </table>
			</div>
		    <!-- 테이블 끝 -->
		    
		    <!-- 페이지 넘버 이미지로 처리 -->
		    <div id="Pagging"><%=ld.getPagging("goPage")%></div>
			<!-- 페이지 넘버 끝 -->
		</div>
		<!-- 메인컨텐츠 끝 -->
	</div>
	<!-- 레이아웃 끝 -->

	<!-- layer popup : 주소록 등록-->
	<div id="addressRegist" title="주소록 등록">
	<!-- 팩스번호 확인 체크 시작. -->
	<input type="hidden" id="FaxNoCheck" name="FaxNoCheck" value=""/>
	<input type="hidden" id="FaxNoCheck2" name="FaxNoCheck2" value=""/>
	<!-- 팩스번호 확인 체크 끝. -->
		<fieldset>
		<!-- 컨텐츠시작 -->
		<div class="ly_pop_new">
			<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
							<tr>
	                            <th style="width:110px;">이름 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="20" name="AddressName" maxlength="25" value="" tabindex="1"/></td>
	                        </tr>
	                        	<tr>
	                        		
									<th>팩스번호 <strong class="blueTxt" title="필수입력">*</strong></th>
									<td class="input_box">
									
									<%
										CodeParam codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("선택");
										codeParam.setName("FaxNo1");
										codeParam.setSelected(""); 
										codeParam.setEvent("javascript:fnDuplicateCheck();"); 
										out.print(CommonUtil.getCodeListHanSeq(codeParam,"6")); 
									%>
									- 
									<input name="FaxNo2" type="text" value="" size="13"  maxlength="9" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this); fnDuplicateCheck(this.value);"  tabindex="3"  />
									<!-- FaxNo1 + FaxNo2 = FaxNo(최종 DB Insert 될 값) -->
									<input name="FaxNo" type="hidden" value=""></input>
									<br/>
									<font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font>
									<!-- 
									<br/><span class="ico_arr_g grayTxt">팩스번호 입력시<span class="blueTxt">&nbsp;&nbsp;지역번호</span>를 반드시 <span class="blueTxt">포함</span>해야합니다.</span>
									 -->
									</td>
								</tr>
	                        <tr>
	                            <th>전화번호(집/회사)</th>
	                            <td class="input_box">
                                <input type="text" name="OfficePhone" size="15" maxlength="13" value="" tabindex="4" dispName="(집/회사)전화번호"  onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
	                        </tr>
	                        <tr>
	                        	<th>휴대폰 번호</th>
	                            <td class="input_box"><input type="text" size="15" name="MobilePhone" maxlength="13" value="" tabindex="5" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" /></td>
	                        </tr> 
	                        <tr>
	                            <th>E-Mail</th>
	                            <td class="input_box"><input type="text" size="28" name="Email" maxlength="50" value="" tabindex="6"/></td>
	                        </tr>
	                        
	                        <tr>
	                            <th>메모</th>
	                            <td class="input_box"><textarea name="Memo" value="" style="ime-mode:active;width:285px; height:40px;" tabindex="7" onKeyUp="js_Str_ChkSub('500', this)" dispName="메모"></textarea></td>
	                        </tr>
					</tbody>
					</table>
				</div>
		<!-- bottom 시작 -->
		<div  class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="등록" /></a><a href="javascript:offVisibleReg();"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a></div>
		</div>
		<!-- 컨텐츠끝 -->
		</fieldset>
		<iframe class="sbBlind sbBlind_AddressEdit"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
	</div>
	<!-- //layer popup : 주소록 등록 -->

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
<div id="AddressEdit" title="주소록 상세정보"></div>
<div id="AddressExcelForm" title="주소록정보 일괄등록"></div>
</body>
</html>
<script>
	searchChk();
</script>

