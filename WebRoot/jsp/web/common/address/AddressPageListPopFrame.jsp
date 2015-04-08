<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.user.UserDAO"%>
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
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
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

//해당 주소록 선택
function goSelected(addressname,faxno){
	$('#CustomerName').val(addressname); //수신자 명(고객명)
	$('#FaxNo').val(faxno);	//수신자 팩스번호
	//goClose($('#addressList').val('addressList'));
	//this.close();
	
	$('#addressList').dialog('close');
}

<%--
	function goPageAjax(page,type){
		
		//검색 Value체크 시작
		var obj=document.AddressForm;
		var gubun=obj.searchGb.value;
		 if(gubun=='1'){
			if(obj.searchtxt.value==''){
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
		 
		//jQuery Ajax
		$('#curPage').val(page);

		$.ajax({
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
		}); 
	}
--%>

	//모든 a태그 _self 로 지정함.
	//사용이유 현재 페이징 으로 페이지 전환시 window 팝업 생성때문.(추후에 LISTDTO 프레임웍 a태그부분 변경해줘야됨.)
	$(function(){
		$('a').attr("target","_self");
	});
	
	
	
	<%--
	//체크 박스 선택 삭제(다건/단건) 
	function goMove(){
		
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
	--%>
	
	<%--
	//체크 박스 선택 이동(다건/단건) 
function goMove(){
		var frm = document.AddressForm;
		var checkYN;
		var checks=0;
		var data;
			
	if(frm.seqs.length>1){
		for(i=0; i<frm.seqs.length; i++){
			if(frm.checkbox[i].checked==true){
			checkYN='Y';
			checks++;
			}else{
			checkYN='N'
			}
			frm.seqs[i].value=fillSpace(frm.checkbox[i].value)+'|'+fillSpace(checkYN);
			//alert(frm.seqs[i].value);
		}	
	}else{
		if(frm.checkbox.checked==true){
			checkYN='Y';
			checks++;
		}else{
			checkYN='N'
		}
		frm.seqs.value=fillSpace(frm.checkbox.value)+'|'+fillSpace(checkYN);
	}
	//parent.document.AddressMove.test.value;
	submit();
}
--%>

//체크박스 전체선택.
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


//팩스 수신인 체크 후 (수신인)리스트로 이동.
function goMoveBtn(){
	var chkCount = $('input:checkbox:checked').length; //checkbox Count.
 
	if(chkCount > 11){
		alert('팩스 동보발신은 수신인(최대 10명까지)입니다. 수신인을 확인하세요.');
		return;
	}else{
		parent.goMove();
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
	obj.action = "<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame";
	if(observerkey==true){return;}
	openWaiting( );
	obj.curPage.value='1';
	obj.submit();
}

</script>
</head>
<body onload="init()">
<div id="containerLy">
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
	<form method="post" id="AddressForm" name=AddressForm action="<%=request.getContextPath()%>/H_Address.do?cmd=AddressPageListPopFrame">
		<input type="hidden" name="curPage" id="curPage" value="<%=curPage%>" />
		<!-- <input type="hidden" name="users" value=""> -->
		<!-- <input type="hidden" name="SearchGroup" value=""> -->
		<!-- 메인컨텐츠 시작 -->
		<div class="AddressPageListPop">
		<!-- 서브타이틀 영역 : 시작 -->
		<div class="popi_sub_title">
			<p class="pop_titleP">내 주소록 리스트</p>
		</div>
		<!-- 서브타이틀 영역 : 끝 -->

		<!-- 검색 영역 : 시작 -->
		<div id="seach_box" class="pop_seach_box">
			<div id="seach">
				<!-- 검색타이틀 <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p> -->
				<p class="input_box"> <!-- 셀렉트 박스 -->
					<select id="searchGb" name="searchGb" onChange="searchChk()">
						<option value="" checked>전체</option>
						<option value="1" <%=aselect%>>사용자명</option>
						<option value="2" <%=bselect%>>팩스번호</option>
					</select>
				</p> 
				<p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goPageAjax()" style="ime-mode:inactive;width:70px; width:74px\9;" class="seach_text" /> </p> <!-- 검색 text box -->
				<p class="btn"><a href="javascript:goSearch()" target="_self"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p>
				<!-- 조회 버튼 -->
				<!--  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="엑셀 다운로드" /></a> </p> <!-- 엑셀 아이콘 -->
				<!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="엑셀 업로드" /> </p> <!-- 엑셀 아이콘 -->
			</div>
			<!-- 검색 끝-->
		</div>
		<!-- 검색 영역 : 끝 -->

		<!-- 테이블 : 시작 -->
		<div id="code_origin" class="pop_list_box">
			<%--
			<!-- 오른쪽 버튼 시작 -->
	                <div class="btn_box">
	                    <p><a href="javascript:goRegist();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="등록" /></a></p>
	 				</div>
			 --%>
			<!-- 오른쪽 버튼 끝 -->
			<ul class="listNm">
				<li>전체건수 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>건</span></li>
				<li class="last">현재페이지 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
				<caption>주소록 관리</caption>
				<colgroup>
					<col width="10%" />
					<col width="25%" />
					<col width="30%" />
					<col width="35%" />
				</colgroup>
				<thead>
					<tr>
						<th><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
						<th>사용자명</th>
						<th>팩스번호</th>
						<th>Email</th>
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
				<%--
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
				 <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >
				 --%>
				 		<tr>
		                	<input type="hidden" name="seqs" />
		                	<td><input name="checkbox" id="ch" type="checkbox" value="<%=ds.getInt("Seq") %>|<%=ds.getString("AddressName")%>|<%=ds.getString("FaxNoFormat")%>" /></td>
		                    <td><%=ds.getString("AddressName")%></td>
							<td><%=ds.getString("FaxNoFormat")%></td>
							<td><%=ds.getString("Email")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
						i++;
							}
						} else {
					%>
					<tr>
						<td colspan="4">게시물이 없습니다.</td>
					</tr>
					<%
						}
					%>
					<!-- 리스트 하단 버튼 영역 : 시작 -->
					<tr id="list_btn_box">
						<td colspan="4" class="choiceMove">선택된 항목 이동<span class="btn"><a href="javascript:goMoveBtn()"><img src="<%=request.getContextPath()%>/images/sub/btn_move.gif" title="이동" /></a><span class="btn"></span><!-- 버튼 -->
						</td>
					</tr>
					<!--리스트 하단 버튼 영역 : 끝 -->
				</tbody>
				</table>
			</div>
		</div>
		<!-- 테이블 끝 -->
		<!-- 페이지 넘버 이미지로 처리 -->
		<div id="Pagging" ><%=ld.getPagging("goPage")%></div>
		<!-- 페이지 넘버 끝 -->
		</div>
		<!-- 메인컨텐츠 끝 -->
</form>
</div>
</body>
</html>
<script>
	searchChk();
</script>
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