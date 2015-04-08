<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.config.ProductDTO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//세션 권한관련 정보 START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//사용자 계정
	//세션 권한관련 정보 END
	
	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt");
	int searchTab = (Integer) model.get("searchTab");

	String aselect = "";
	String bselect = "";
	String cselect = "";
	String dselect = "";
	String eselect = "";

	if (searchGb.equals("1")) { 		//사용자명(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //사용자 ID(ID)
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("3")) { //팩스번호(FaxNo)
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	} else if (searchGb.equals("4")) { //전화번호(OfficeTellNo)
		searchtxt = (String) model.get("searchtxt");
		dselect = "selected";
	} else if (searchGb.equals("5")) { //그룹ID(GroupID)
		searchtxt = (String) model.get("searchtxt");
		eselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>제품 관리</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
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

//검색
function goSearch() {
	var obj=document.ProductForm;
	var gubun=obj.searchGb.value;
	var invalid = '';	//공백 체크
	
	if(gubun=='1'){

		if(obj.searchtxt.value=='' ){
			alert('제품명을 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('제품코드를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' ){
			alert('구매처 정보를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.searchtxt.value=='' ){
			alert('바코드를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='5'){
		if(obj.searchtxt.value=='' ){
			alert('진행여부를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
		if(obj.searchtxt.value=='Y' || obj.searchtxt.value=='N'){
			
			
		}else{
			
			alert('진행여부는 Y 또는 N으로 검색 가능합니다.');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}

	obj.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productPageList";
	if(observerkey==true){return;}
	openWaiting();
	obj.curPage.value='1';
	obj.submit();
}
//체크 박스 선택 삭제(다건/단건) 
function goDelete(){
	
	var frm = document.ProductForm;
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
		alert("삭제할 품목을 선택해 주세요!")
	} else {
		if(!confirm("정말로 삭제하시겠습니까?"))
			return;
		
		frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productDeletes";
		frm.submit();
	}
}
//Excel Export
function goExcel() {
	var frm = document.ProductForm;
	frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productExcelList";	
	frm.submit();
	frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productPageList";
}
//전체 선택시 검색박스 disable
function searchChk() {
	var obj = document.ProductForm;

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

//user등록 팝업
function goRegistForm() {
	$('[name=productRegistForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 610,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=productRegistForm');

		}
	});
}
//제품 수정 팝업
function goModifyForm(productcode) {
	$('[name=productModifyForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 620,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=productModifyForm',{
				'productcode' : productcode
			});
		}
	});
}


//excel update 팝업
function goExcelUpdate(){
	$('[name=companyExcelForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 390,
		width : 420,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=companyExcelForm');
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
<%=ld.getPageScript("ProductForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=ProductForm action="<%=request.getContextPath()%>/H_Master.do?cmd=productPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- 레이아웃 시작 -->
		<div class="wrap_bgL">
			<!-- 서브타이틀 영역 : 시작 -->
			<div class="sub_title">
    			<p class="titleP">Master 정보관리</p>
			</div>
			<!-- 서브타이틀 영역 : 끝 -->

		<!-- 검색 영역 : 시작 -->
        <div id="seach_box" >
    	<!-- 검색 > 팩스검색 : 시작 ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- 팩스검색 text : CSS로 컨트롤함 -->
          	       
            <input type="hidden" name="AuthOption" value="Group">

    		<!-- 검색 > 그룹 셀렉박스 : 시작-->
    		    		
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- 셀렉트 박스 -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>전체</option>
                       <option value="1" <%=aselect%>>품목코드</option>
                       <option value="2" <%=bselect%>>품목명</option>
                       <option value="3" <%=cselect%>>구매처</option>
                       <option value="4" <%=dselect%>>바코드</option>
                       <option value="5" <%=eselect%>>진행여부</option>
                   </select>
               </p>
			           
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- 검색 text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- 조회 버튼 --> 
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="거래처 일괄등록" /></a></p>  <!-- 사용자정보 일괄등록 아이콘 -->

                   <!-- 검색 끝-->
    	<!-- 검색 > 그룹 셀렉박스 : 끝-->
		</div>

		</div>
	<!-- 검색 영역 : 끝 -->     
			<!-- 테이블 : 시작 -->
			<div id="code_origin" class="list_box">
			<!-- 오른쪽 버튼 시작 -->
	                <div class="btn_box" id="regBt">
	                    <p><a href="javascript:goRegistForm();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="등록" /></a></p>
	 				</div>
			  <!-- 오른쪽 버튼 끝 -->
			<ul class="listNm">
				<li>전체건수 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>건</span></li>
				<li class="last">현재페이지 <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>제품관리</caption>
		            <thead>
		                <tr>
		               	  <th width="30px"><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
		                  <th>품목코드</th>
		                  <th>바코드</th>
		                  <th>품목명</th>
		                  <th>구매처</th>
		                  <th>진행여부</th>
		                  <th>최초등록일자</th>
		                  <th>최종수정일자</th>
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
                <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                              
             
		                <input type="hidden" name="seqs" >
		                	<td><input name="checkbox" type="checkbox" value="<%=ds.getString("ProductCode")%>" /></td>
		                    <td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("ProductCode")%>');"><%=ds.getString("ProductCode")%></td>
							<td><%=ds.getString("BarCode")%></td>
							<td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("ProductCode")%>');"><%=ds.getString("ProductName")%></td>
							<td><%=ds.getString("CompanyName") %></td>
							<td><%=ds.getString("IngYN")%></td>
							<td><%=ds.getString("CreateDateTime")%></td>
							<td><%=ds.getString("UpdateDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="7">게시물이 없습니다.</td>
					</tr>
					<!-- <script>
						goSearch();
					</script> -->
					<%
						}
					%>
					<!-- 리스트 하단 버튼 영역 : 시작 -->
					<tr id="list_btn_box">
						<td colspan="8">선택된 항목 삭제<input type="hidden" name="IdongGb" value="Y"><span class="btn"><a href="javascript:goDelete();"><img src="<%=request.getContextPath()%>/images/sub/btn_delete_02.gif" title="삭제" /></a></span><!-- 버튼 -->
						</td>
					</tr>
					<!--리스트 하단 버튼 영역 : 끝 -->
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
<div name="productRegistForm" title="제품등록폼"></div>
<div name="productModifyForm" title="제품수정폼"></div>
<div name="companyExcelForm" title="거래처정보 일괄등록"></div>
</body>
</html>
