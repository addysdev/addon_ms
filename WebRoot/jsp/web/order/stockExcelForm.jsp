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
	
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//사용자 그룹
	String groupNm=StringUtil.nvl(dtoUser.getGroupname(),"");//사용자 그룹명
	
	CodeParam codeParam = new CodeParam();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title></title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script language="javascript">
//초기세팅
$(document).ready(function(){
	$('#calendarData3').datepicker({
		maxDate:0,
		prevText: "이전",
		nextText: "다음",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["일","월","화","수","목","금","토"],
		monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		changeMonth: true,
	    changeYear: true
	});
});
function showCalendar2(){
	
	   $('#calendarData3').datepicker("show");
}
function goSaveExcel(){
	
	
	var frm=document.stockRegistFrm; //form객체세팅
	var groupname='';

	if(frm.stockDate.value==''){		
		alert('재고현황 일자를 선택하세요');
		return;
	}

	if('<%=groupId%>'=='G00000'){
		
		if(frm.GroupID.selectedIndex==0){
			
			alert('등록하실 재고 대상 지점을 선택하셔야 합니다.');
			return;
			
		}
		
		groupname=frm.GroupID[frm.GroupID.selectedIndex].text;
		
	}else{	
		groupname=frm.GroupName.value;
	}

	if(!confirm("["+groupname+"] 의 "+frm.stockDate.value+"일자\n재고현황을 등록 하시겠습니까?")){
		return;
   }
	
	if(frm.stockFile.value==''){		
		alert('업로드할 파일을 선택하세요');
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
 *  파일 확장자명 체크
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
			alert(ext+'파일은 전송이 불가능합니다.\nxls 파일로 업로드 하세요.');
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
    <h1 class="title_lft"><span class="title_rgt"> 일괄등록</span></h1>
  </div> -->
  <!-- //title -->
  <!-- contents -->
  <div id="contents" class="userExcelup">
   <form name="stockRegistFrm" method="post"  action="<%= request.getContextPath() %>/H_Order.do?cmd=stockExcelImport" enctype="multipart/form-data">
    <!-- form_area -->
	<div class="form_area">
    <fieldset>
      <legend>등록파일 선택</legend>
        <span>업로드 할 <em class="bold">엑셀파일</em></span><input type="file"  name="stockFile" />
    </fieldset>
	</div>
    <!-- //form_area -->
    <!-- caution_area -->
    <div class="caution_area">
      <h3>등록할 재고현황 정보 선택</h3>
      <ul>
        <li>재고 현황일자 선택 : <input  name="stockDate" id="calendarData3" value="" type="text" size="8" style="width:60px;" class="in_txt"  dispName="날짜" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			<!-- 달력이미지 시작 -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar2()" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- 달력이미지 끝 --></li>
        <li>재고 대상지점 선택 : <%
        	if(groupId.equals("G00000")){
									    codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("선택");
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
      <h3>업로드시 주의사항</h3>
      <ul>
        <li>업로드 대상의 재고현황 일자와 지점을 꼭 선택해야 합니다.
          <br />
        <li>엑셀파일로 사용자 정보를 일괄 업데이트 할 수 있습니다.
          <br />
          <span>(확장자가 xls 인 엑셀 파일만 업로드 가능합니다.)</span> </li>
         <li>재고현황 정보 excel파일 양식이 틀릴 경우 등록실패 됩니다.</li>
        <li>파일 업로드 결과는 서버의 log 경로에서 확인이 가능합니다.</li>
      </ul>
    </div>
    <!-- //caution_area -->
 </form>
  </div>
  <!-- //contents -->
  <!-- button -->
  <div class="ly_foot">
    <a href="javascript:goSaveExcel()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="등록" /></a> <a href="javascript:goClosePop('stockExcelForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
  </div>
  <!-- //button -->
  <iframe class="sbBlind sbBlind_userExcelForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
</div>
</body>
</html>