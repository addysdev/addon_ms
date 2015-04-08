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
//초기세팅
<%-- function init() {

	closeWaiting(); //처리중 메세지 비활성화

	if('<%=importResult%>'!=''){
		alert('<%=importResult%>');
	}

} --%>
function goSaveExcel(){

	var frm=document.userRegistFrm; //form객체세팅

	/* if(frm.userFile.value == ""){
		
		alert('업로드할 xls파일을 첨부하세요');
		return;
		
	}else if(!isImageFile(frm.userFile.value)){

		return; 				
    } */
	
	openWaiting();
	frm.action = "<%=request.getContextPath() %>/H_User.do?cmd=userExcelImport";
	frm.submit();
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
			alert(ext+'파일은 전송이 불가능합니다.');
			return false;
		}
	}
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
    <h1 class="title_lft"><span class="title_rgt">사용자정보 일괄등록</span></h1>
  </div> -->
  <!-- //title -->
  <!-- contents -->
  <div id="contents" class="userExcelup">
    <!-- form_area -->
	<div class="form_area">
    <fieldset>
      <legend>등록파일 선택</legend>
      <form name="userRegistFrm" method="post"  action="<%= request.getContextPath() %>/H_User.do?cmd=userExcelImport" enctype="multipart/form-data">
        <span>업로드 할 <em class="bold">엑셀파일</em></span><input type="file"  name="userFile" />
      </form>
    </fieldset>
	</div>
    <!-- //form_area -->
    <!-- caution_area -->
    <div class="caution_area">
      <h3>업로드시 주의사항</h3>
      <ul>
        <li>엑셀파일로 사용자 정보를 일괄 업데이트 할 수 있습니다.
          <br />
          <span>(확장자가 xls 인 엑셀 파일만 업로드 가능합니다.)</span> </li>
        <li class="cmt">엑셀파일 업로드 양식을 다운로드 합니다. <a href="<%= request.getContextPath() %>/fileDownServlet?rFileName=UserUploadFormat.xls&sFileName=UserUploadFormat.xls&filePath=/down"><strong class="blueTxt">[양식다운로드]</strong></a>
          <br />
          <span>(다운받으신 양식의 첫번째 타이틀에 맞춰 사용자정보를 저장합니다.)</span> </li>
        <li>사용자정보 입력시 사용자ID가 중복 될 경우 등록실패 됩니다.</li>
        <li>파일 업로드 결과는 서버의 log 경로에서 확인이 가능합니다.</li>
      </ul>
    </div>
    <!-- //caution_area -->
  </div>
  <!-- //contents -->
  <!-- button -->
  <div class="ly_foot">
    <a href="javascript:goSaveExcel()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="등록" /></a> <a href="javascript:goClosePop('userExcelForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
  </div>
  <!-- //button -->
  <iframe class="sbBlind sbBlind_userExcelForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
</div>
</body>
</html>
