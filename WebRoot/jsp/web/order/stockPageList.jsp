<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.order.StockDTO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//세션 권한관련 정보 START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//사용자 계정
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//사용자 그룹
	//세션 권한관련 정보 END

	
	String curPage = (String) model.get("curPage");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	String GroupID = (String) model.get("GroupID");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>재고 관리</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
 var openWin=0;//팝업객체
var isSearch=0; 
 
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
	var obj=document.StockFrom;

	obj.action = "<%=request.getContextPath()%>/H_Order.do?cmd=stockPageList";
	if(observerkey==true){return;}
	openWaiting();
	obj.curPage.value='1';
	obj.submit();
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

function goStockDetail(stockdate,groupid){
	$('[name=stockDetailPageList]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 750,
		width : 620,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			$(this).load('<%=request.getContextPath()%>/H_Order.do?cmd=stockDetailPageList',{
				'stockdate' : stockdate,
				'groupid' : groupid
			});
		}
	});
}
//excel update 팝업
function goExcelUpdate(){
	$('[name=stockExcelForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 450,
		width : 420,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Order.do?cmd=stockExcelForm');
		}
	});
}

//레이아웃 팝업 닫기 버튼 함수
function goClosePop(formName){
	$('[name='+formName+"]").dialog('close');
}

</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("StockFrom", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=StockFrom action="<%=request.getContextPath()%>/H_Order.do?cmd=stockPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- 레이아웃 시작 -->
		<div class="wrap_bgL">
			<!-- 서브타이틀 영역 : 시작 -->
			<div class="sub_title">
    			<p class="titleP">재고 현황관리</p>
			</div>
			<!-- 서브타이틀 영역 : 끝 -->

		<!-- 검색 영역 : 시작 -->
        <div id="seach_box" >
    	<!-- 검색 > 팩스검색 : 시작 ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- 팩스검색 text : CSS로 컨트롤함 -->
    		<!-- 검색 > 그룹 셀렉박스 : 시작-->
    		    		
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
		    
			 <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- 조회 버튼 --> 
	         <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="재고현황 일괄등록" /></a></p>  <!-- 사용자정보 일괄등록 아이콘 -->

                   <!-- 검색 끝-->
    	<!-- 검색 > 그룹 셀렉박스 : 끝-->
		</div>

		</div>
	<!-- 검색 영역 : 끝 -->     
			<!-- 테이블 : 시작 -->
			<div id="code_origin" class="list_box">

			<ul class="listNm">
				<li>전체건수 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>건</span></li>
				<li class="last">현재페이지 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>재고현황 관리</caption>
		            <thead>
		                <tr>
		               	  <th>재고현황일자</th>
		                  <th>그룹아이디</th>
		                  <th>그룹명</th>
		                  <th>최종업데이트UserID</th>
		                  <th>최종업데이트UserName</th>
		                  <th>최종업데이트일자</th>
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
				<!-- 확인 미확인 구분 볼드처리 시작-->	
                       <tr name="tdonevent" id="tdonevent" style="background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                              
		                	<td style="cursor: pointer" onclick="goStockDetail('<%=ds.getString("StockDate")%>','<%=ds.getString("GroupID")%>');"><%=ds.getString("StockDate")%></td>
							<td><%=ds.getString("GroupID")%></td>
							<td><%=ds.getString("GroupName")%></td>
							<td><%=ds.getString("LastUserID") %></td>
							<td><%=ds.getString("UserName")%></td>
							<td><%=ds.getString("StockDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="6">게시물이 없습니다.</td>
					</tr>
					<!-- <script>
						goSearch();
					</script> -->
					<%
						}
					%>
					
		          </tbody>
		        </table>
			</div>
			</div>
		    <!-- 테이블 끝 -->
		    
		    <!-- 페이지 넘버 이미지로 처리 -->
		    <div id="Pagging"><%=ld.getPagging("goPage")%></div>
			<!-- 페이지 넘버 끝 -->

		</div>
		<!-- 레이아웃 끝 -->
</form>
<div name="stockDetailPageList" title="재고 상세 현황"></div>
<div name="stockExcelForm" title="재고현황 일괄등록"></div>
</body>
</html>
