<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>

<%
	String MenuAuthID = "";//장기손사 이관용 권한아이디

	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String SearchGroup = (String) model.get("SearchGroup");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	String searchtxt = (String) model.get("searchtxt");
	
	String excelEnabledCheck="";//엑셀 조회권한
	
	String select = "";
	String aselect = "";
	String bselect = "";
	String cselect = "";

	if (searchGb.equals("%")) { //all
		searchtxt = (String) model.get("searchtxt");
		select = "selected";
	} else if (searchGb.equals("1")) { //UserID
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //UserName
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("3")) { //ClientIP
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>로그인 이력</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script>

$(document).ready(function(){
	$('#calendarData1, #calendarData2').datepicker({
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
function showCalendar(div){

	   if(div == "1"){
	   	   $('#calendarData1').datepicker("show");
	   } else if(div == "2"){
		   $('#calendarData2').datepicker("show");
	   }  
}

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
//검색
function goSearch() {
	var obj=document.HistoryForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//공백 체크
	
	var dch=dateCheck(obj.startDate,obj.endDate,31);//검색조건 날짜체크 : 시작일,종료일,기간
	
	if (dch==false){
		return;
	}
	
	if(gubun=='1'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('사용자 ID를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('사용자 명을 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('Client IP를 입력해주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	if(observerkey==true){return;}
	openWaiting( );
	obj.curPage.value='1';
	obj.submit();

}
//전체 선택시 검색박스 disable
function searchChk() {
	var obj = document.HistoryForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}
//Excel Export
function goExcel() {
	var frm = document.HistoryForm;
	frm.action = "<%=request.getContextPath()%>/H_History.do?cmd=loginExcelList";	
	frm.submit();
}

// 커서  색상 처리 시작

function fnLayerover(index){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = '#FEFADA'; 

}


function fnLayerout(index,rowclass){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = rowclass;
	
}

//커서  색상 처리 끝

</script>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
   <table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
      <tr>
         <td align=center height=middle style="margin-top: 10px;">
            <table width=293 height=148 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/main/ing.gif" >
                  <tr>
                     <td align=center><img src="<%=request.getContextPath()%>/images/main/spacer.gif" width="1" height="50" /><img src="<%=request.getContextPath()%>/images/main/wait2.gif" width="242" height="16" /></td>
                  </tr>
            </table>
          </td>
       </tr>
    </table>
</div>
<!-- 처리중 종료 -->

<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();

	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("HistoryForm", "curPage", "goPage")%>

<body onLoad="init()" class="body_bgAll">
	<form method="post" name=HistoryForm action="<%=request.getContextPath()%>/H_History.do?cmd=loginPageList">
	<input type="hidden" name="curPage" value="<%=curPage%>">
	
	<!-- 레이아웃 시작 -->
<div class="wrap_bgL">
	<!-- 서브타이틀 영역 : 시작 -->
	<div class="sub_title">
    	<p class="titleP">로그인이력</p>
	</div>
	<!-- 서브타이틀 영역 : 끝 -->
   
  	<!-- 검색 영역 : 시작 -->
  	<div id="seach_box" >
   	<!-- 검색 > 팩스검색 : 시작 -->
   	<div id="seach">
		<p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
    		<!-- 조회시작일자-->
			<p class="psr input_box">
			<input  name="startDate" id="calendarData1" value="<%=startDate%>" type="text" size="8" style="width:60px;" class="in_txt"  dispName="날짜" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			<!-- 달력이미지 시작 -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar('1')" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- 달력이미지 끝 -->
		    </p>
            <!-- 조회죵료일자-->
			<p class="psr input_box">&nbsp;~&nbsp;
			 <input  name="endDate" id="calendarData2" value="<%=endDate%>" type="text" size="8" style="width:60px;" class="in_txt"  dispName="날짜" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			 <!-- 달력이미지 시작 -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar('2')" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- 달력이미지 끝 -->
		    </p>
          	<p class="btn"><a href="javascript:dateMove2('1',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="오늘" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_1day','','<%=request.getContextPath()%>/images/sub/btn_1day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_1day.gif" name="btn_1day" border="0" id="btn_1day" /></a></p> <!-- 오늘버튼 -->
        	<p class="btn"><a href="javascript:dateMove2('7',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="7일전" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_7day','','<%=request.getContextPath()%>/images/sub/btn_7day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_7day.gif" name="btn_7day" border="0" id="btn_prevDay" /></a></p> <!-- 7일전버튼 -->
            <p class="btn"><a href="javascript:dateMove2('15',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="15일전" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_15day','','<%=request.getContextPath()%>/images/sub/btn_15day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_15day.gif" name="btn_15day" border="0" id="btn_prevDay" /></a></p> <!-- 15일전버튼 -->
            <p class="btn"><a href="javascript:dateMove2('30',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="30일전" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_30day','','<%=request.getContextPath()%>/images/sub/btn_30day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_30day.gif" name="btn_30day" border="0" id="btn_prevDay" /></a></p> <!-- 15일전버튼 -->
       
           <!-- 검색조건 셀렉트 박스 영역 시작-->
           <p class="input_box"> <!-- 검색조건 셀렉트 박스 영역 -->
           	<select name="searchGb">
                 	<option value="%" <%=select%>>전체</option>
                <option value="1" <%=aselect%>>사용자 ID</option>
                <option value="2" <%=bselect%>>사용자 명</option>
                <option value="3" <%=cselect%>>Client IP</option>
               </select>
           </p>
           <p class="input_box"><input type="text" name="searchtxt" id="textfield" style="ime-mode:active;" class="seach_text" /> </p> <!-- 검색 text box -->
           <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" title="검색"/></a></p> <!-- 조회 버튼 -->
           <%
       	if(excelEnabledCheck.equals("Y")){
         	%>
           <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="엑셀 다운로드" /></a></p> <!-- 엑셀 버튼 --> 
            <%
       	}
           %> 
           <!-- 검색조건 셀렉트 박스 영역 종료-->
 		</div>
   	<!-- 검색 > 그룹 셀렉박스 : 끝-->
   	</div>
	<!-- 검색 영역 : 끝 -->
	<!-- 테이블 : 시작 -->
	<div id="code_origin" class="list_box">
		<ul class="listNm">
			<li>전체건수 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>건</span></li>
			<li class="last">현재페이지 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
		</ul>
		<div class="tbl_type_out">
			<table cellspacing="0" cellpadding="0" class="tbl_type loginPageList">
				<caption>로그인 이력</caption>
				<!-- <colgroup>
				<col width="5%"><col width=""><col width="5%" span="6">
				</colgroup> -->
				<thead>
					<tr>
						<th scope="col">로그인일시</th>
						<th scope="col">로그 아웃</th>
						<th scope="col">사용자(ID)</th>
						<!-- th scope="col">로그인<br />채널</th-->
						<th scope="col">Browser<br />version</th>
						<th scope="col">Client IP<br />
						<th scope="col">Client OS<br />
						<th scope="col">기타<br />정보</th>
					</tr>
				</thead>
				<tbody>
				<!-- :: loop :: -->
				<!--리스트---------------->
				<%
					if (ld.getItemCount() > 0) {
						int i = 0;
						 String BVer="";
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
					<!-- 확인 미확인 구분 볼드처리 시작-->	
					<%
						if (ds.getString("ImageOpenDate").equals("")){
					%>
					<tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');">
					<%
						}else {
					%>
					<tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');">
					<%
						}
					%>
					<!-- 확인 미확인 구분 볼드처리 끝 -->
						<td><%=ds.getString("LoginDateTime")%></td>
						<td><%=ds.getString("LogoutDateTime")%></td>
						<td><%=ds.getString("LoginUser")%></td>
						<!-- td><%=ds.getString("LoginProgram")%></td-->
					   <%
						        BVer=ds.getString("ClientBrowserVersion");
						
						        if(BVer.indexOf("FireFox")!=-1){
						        %>
						          <td><a class="ico_firefox"><span class="blind">파이어폭스</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }else if(BVer.indexOf("Chrome")!=-1){
						        %>
						          <td><a class="ico_chrome"><span class="blind">크롬</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }else{
						        %>
						          <td><a class="ico_ie"><span class="blind">익스플로러</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }
					    %>
						<td><%=ds.getString("ClientIP")%></td>
						<td><a class="ico_win"><span class="blind">윈도우7</span></a><%=ds.getString("ClientOS")%></td>
						<td class="align_left"><%=ds.getString("Description")%></td>
					</tr>
					<!-- :: loop :: -->
					<%
						i++;
						}
						} else {
					%>
					<tr>
						<td colspan="8">게시물이 없습니다.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 테이블 : 끝 -->
	<!-- 페이지 넘버 : 시작 -->
	<div id="Pagging"><%=ld.getPagging("goPage")%></div>
	<!-- 앞의 버튼을 전체 감싸는 span, 텍스트 각 각을 감싸는 span에  class="PaggingR" 추가
	<div id="Pagging"><span class="PaggingR"><span class="direction_off pd0"><img src="images/sub/btn_first_off.gif"></span><span class="direction_off pd0"><img src="images/sub/btn_prev_off.gif"></span></span><span class="PaggingR"><strong>1</strong></span><span class="PaggingR"><a href="javascript:goPage('2', '2')">2</a></span><span><span class="direction_off pd0"><img src="images/sub/btn_next_off.gif"></span><span class="direction_off pd0"><img src="images/sub/btn_last_off.gif"></span></span></div>
	-->
	<!-- 페이지 넘버 : 끝 -->
</div>
</form>
</body>
</html>