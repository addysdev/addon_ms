<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import="com.web.common.recovery.RecoveryDTO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//세션 권한관련 정보 START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//사용자 계정
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//사용자 그룹
	//세션 권한관련 정보 END
    CodeParam codeParam = new CodeParam();
	
	String curPage = (String) model.get("curPage");
	String vGroupID = (String) model.get("vGroupID");
	String vSearchType = (String) model.get("vSearchType");
	String vSearch = (String) model.get("vSearch");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	
	String select = "";
	String aselect = "";
	String bselect = "";
	String cselect = "";
	String dselect = "";
	
	if (vSearchType.equals("0")) { 		//회수번호
		vSearch = (String) model.get("vSearch");
		select = "selected";
	} else if (vSearchType.equals("1")) { 		//회수자
		vSearch = (String) model.get("vSearch");
		aselect = "selected";
	} else if (vSearchType.equals("2")) { //구매처
		vSearch = (String) model.get("vSearch");
		bselect = "selected";
	}else if (vSearchType.equals("3")) { //회수상태
		vSearch = (String) model.get("vSearch");
		cselect = "selected";
	}else if (vSearchType.equals("4")) { //등록상태
		vSearch = (String) model.get("vSearch");
		dselect = "selected";
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>회수 관리</title>
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
//셀렉트 조건 옵션
function searchChk() {
	var obj = document.OrderForm;

	if (obj.vSearchType[0].selected == true) {
		obj.vSearch.disabled = true;
		obj.vSearch.value = '';
	} else {
		obj.vSearch.disabled=false;
	}
}
//검색
function goSearch() {
	var obj=document.RecoveryForm;
	
var gubun=obj.vSearchType.value;
	
	if(gubun=='0'){
		
		if(obj.vSearch.value=='' ){
			alert('회수번호를 입력해 주세요');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='1'){

		if(obj.vSearch.value=='' ){
			alert('회수자를 입력해 주세요');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.vSearch.value=='' ){
			alert('구매처를 입력해 주세요');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.vSearch.value=='' ){
			alert('회수여부를 입력해 주세요');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
		if(obj.vSearch.value=='Y' || obj.vSearch.value=='N'){
			
			
		}else{
			
			alert('회수여부는 Y 또는 N으로 검색 가능합니다.');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.vSearch.value=='' ){
			alert('등록여부를 입력해 주세요');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
		if(obj.vSearch.value=='Y' || obj.vSearch.value=='N'){
			
			
		}else{
			
			alert('등록여부는 Y 또는 N으로 검색 가능합니다.');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}

	obj.action = "<%=request.getContextPath()%>/H_Recovery.do?cmd=recoveryPageList";
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

function goRecoveryDetail(recoverycode,companycode,groupid,groupname,IngYN,RegYN){
	$('[name=recoveryDetailPageList]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 850,
		width : 1100,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			$(this).load('<%=request.getContextPath()%>/H_Recovery.do?cmd=recoveryDetailPageList',{
				'RecoveryCode' : recoverycode,
				'CompanyCode' : companycode,
				'GroupID' : groupid,
				'GroupName' : encodeURIComponent(groupname) ,
				'IngYN' : IngYN,
				'RegYN' : RegYN 
			});
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
<%=ld.getPageScript("RecoveryForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=RecoveryForm action="<%=request.getContextPath()%>/H_Recovery.do?cmd=recoveryPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- 레이아웃 시작 -->
		<div class="wrap_bgL">
			<!-- 서브타이틀 영역 : 시작 -->
			<div class="sub_title">
    			<p class="titleP">회수 리스트</p>
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
		    
			<p class="psr input_box">
            <%
            
            if("G00000".equals(groupId)){

			    codeParam = new CodeParam();
				codeParam.setType("select"); 
				codeParam.setStyleClass("td3");
				codeParam.setFirst("전체");
				codeParam.setName("vGroupID");
				codeParam.setSelected(vGroupID); 
				codeParam.setEvent(""); 
				out.print(CommonUtil.getCodeListGroup(codeParam)); 

            }else{
            %>
            	<input type="hidden" name="vGroupID" value="<%=groupId%>">
            <%
            }
            %>
            </p>
              <p class="input_box"> <!-- 셀렉트 박스 -->
                   <select name="vSearchType"  onchange="searchChk()">
                       <option value="" checked>전체</option>
                       <option value="0" <%=select%>>회수번호</option>
                       <option value="1" <%=aselect%>>회수자</option>
                       <option value="2" <%=bselect%>>구매처</option>
                       <option value="3" <%=cselect%>>회수여부</option>
                       <option value="4" <%=dselect%>>등록여부</option>
                   </select>
               </p>
	           <p class="input_box"><input type="text" name="vSearch" id="textfield" maxlength="20"  value="<%=vSearch%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- 검색 text box -->
             <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- 조회 버튼 --> 
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
		        <caption>발주대상 관리</caption>
		            <thead>
		                <tr>
		               	  <th>회수번호</th>
		               	  <th>회수일자</th>
		               	  <th>회수자</th>
		                  <th>조직</th>
		                  <th>구매처</th>
                          <th>회수상태</th>
                          <th>등록상태</th>
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
		                	<td style="cursor: pointer" onclick="goRecoveryDetail('<%=ds.getString("RecoveryCode")%>','<%=ds.getString("CompanyCode") %>','<%=ds.getString("GroupID")%>',
		                	'<%=ds.getString("GroupName")%>','<%=ds.getString("IngYN")%>','<%=ds.getString("RegYN")%>');"><%=ds.getString("RecoveryCode")%></td>
							<td><%=ds.getString("RecoveryDateTime")%></td>
							<td><%=ds.getString("RecoveryUserName")%>(<%=ds.getString("RecoveryUserID")%>)</td>
							<td><%=ds.getString("GroupName")%>(<%=ds.getString("RecovertUserID")%>)</td>
							<td><%=ds.getString("CompanyName")%>(<%=ds.getString("CompanyCode")%>)</td>
							<td><%=ds.getString("IngResult") %></td>
							<td><%=ds.getString("RegResult") %></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="7">회수건이 없습니다.</td>
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
<div name="recoveryDetailPageList" title="회수 상세 품목"></div>
</body>
</html>
