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
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 


	//세션 권한관련 정보 START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//사용자 계정
	String excelEnabledCheck="";//엑셀 조회권한
	String authID=StringUtil.nvl(dtoUser.getAuthid(),"");//팩스조회권한
	String authUpGroupID="";//팩스조회 상위 권한 
	String authGroupStep="";//팩스조회권한 단계
	String groupUserAuthYN="";//팩스조회권한 옵션(개인포함여부)
	String groupUserAuthYNOption="";//개인팩스 포함시 추가옵션
	String search_authID ="";//조회조건 return
	String SearchAuthBox ="";//조회조건 return
	String sGroup1 = "";//조회조건 return
	String sGroup2 = "";//조회조건 return
	String sGroup3 ="";//조회조건 return
	String sGroup4 ="";//조회조건 return
	String sGroup5 ="";//조회조건 return
	//세션 권한관련 정보 END

	CommonDAO comDao=new CommonDAO();
	
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
<title>계정 관리</title>
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

//등록, 활성화 계정, 비활성화 계정 눌렀을때 실행
function selectTab(num){
	var obj = document.UserForm;
	obj.searchTab.value = num;
	
	
	obj.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
	if(observerkey==true){return;}
	openWaiting();
	//obj.curPage.value='1';
	obj.submit();
}


//검색
function goSearch() {
	var obj=document.UserForm;
	//var obj2=document.UserRegist;
	var gubun=obj.searchGb.value;
	var invalid = '';	//공백 체크
	
	

	if(gubun=='1'){

		if(obj.searchtxt.value=='' ){
			alert('사용자 이름을 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('사용자 ID를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' ){
			alert('팩스번호를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.searchtxt.value=='' ){
			alert('전화번호를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='5'){
		if(obj.searchtxt.value=='' ){
			alert('그룹ID를 입력해 주세요');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	if(obj.AuthID.value=='S'){
		obj.AuthID.value='';
	}
	obj.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
	if(observerkey==true){return;}
	openWaiting();
	obj.curPage.value='1';
	obj.submit();
}
//수정 팝업
function goDetail(ID){

	    if(true){
	
			var url = "<%=request.getContextPath()%>/H_User.do?cmd=userModifyForm";
			var params = "&UserID=" + ID;
		
			if(openWin != 0) {
				  openWin.close();
			}
			
			openWin=window.open(url + params, "", "width=400, height=475,toolbar=no, menubar=no, scrollbars=no, status=no");
       }else{
    	   
    	   alert('외부 조직에 대한 수정 권한이 없습니다.');
    	   return;
    	   
       }
}
//등록 팝업
function goRegist() {
	if(openWin != 0) {
		  openWin.close();
	}
	openWin=window.open("<%=request.getContextPath()%>/H_User.do?cmd=userRegistForm","","width=400, height=442, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
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
	
	var frm = document.UserForm;
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
		
		frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userDeletes";
		frm.submit();
	}
}
//Excel Export
function goExcel() {
	var frm = document.UserForm;
	frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userExcelList";	
	frm.submit();
	frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
}
//전체 선택시 검색박스 disable
function searchChk() {
	var obj = document.UserForm;

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
	$('[name=userRegistForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 420,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userRegistForm');

		}
	});
}
//user수정 팝업
function goModifyForm(userid) {
	$('[name=userModifyForm]').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 420,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userModifyForm',{
				'UserID' : userid
			});
		}
	});
}


//excel update 팝업
function goExcelUpdate(){
	$('[name=userExcelForm]').dialog({
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
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userExcelForm');
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
	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("UserForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=UserForm action="<%=request.getContextPath()%>/H_User.do?cmd=userPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<!-- <input type="hidden" name="users" value="">
		<input type="hidden" name="SearchGroup" value=""> -->
		<input type="hidden" name="searchTab" value="<%=searchTab%>">

		<!-- 레이아웃 시작 -->
		<div class="wrap_bgL">
			<!-- 서브타이틀 영역 : 시작 -->
			<div class="sub_title">
    			<p class="titleP">계정관리</p>
				<ul class="seachNm">
					<li style="cursor: pointer;" onclick="selectTab('1')">등록 <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getTotCount(),"0")) %>명</span></li>
					<li style="cursor: pointer;" onclick="selectTab('2')">활성화 계정 <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getUseYN_YCount(),"0")) %>명</span></li>
					<li style="cursor: pointer;" onclick="selectTab('3')">비활성화 계정 <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getUseYN_NCount() ,"0")) %>명</span></li>
				</ul>
			</div>
			<!-- 서브타이틀 영역 : 끝 -->

		<!-- 검색 영역 : 시작 -->
        <div id="seach_box" >
    	<!-- 검색 > 팩스검색 : 시작 ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- 팩스검색 text : CSS로 컨트롤함 -->
			          	
          	<!--input type="hidden" name="AuthID" value="<%=authID%>"--><!-- 조회용 사용자 or 그룹아이디 -->
          	<!--input type="hidden" name="AuthGroup" value="<%=groupUserAuthYN%>"--><!-- 조회용 사용자 포함여부 옵션 -->
          	<input type="hidden" name="AuthID" value="G0000000"><!-- 조회용 사용자 or 그룹아이디 -->
          	<input type="hidden" name="AuthGroup" value="Y"><!-- 조회용 사용자 포함여부 옵션 -->
          	<input type="hidden" name="cmUserID" value="<%=userId%>"><!-- 사용자 ID(공통용) -->
          	<input type="hidden" name="cmAuthID" value="<%=authID%>"><!-- 그룹 권한 ID(공통용) -->
          	<input type="hidden" name="cmUpAuthID" value="<%=authUpGroupID%>"><!-- 그룹 상위 권한 ID(공통용) -->
          	<input type="hidden" name="cmAuthStep" value="<%=authGroupStep%>"><!-- 그룹 Step(공통용) -->
          	<input type="hidden" name="SearchAuthBox" value="<%=SearchAuthBox%>"><!-- 조회용 셀렉트 박스명(선택) -->
          	<input type="hidden" name="sGroup1" value="<%=sGroup1%>"><!-- 조회용 셀렉트 박스명 -->
          	<input type="hidden" name="sGroup2" value="<%=sGroup2%>"><!-- 조회용 셀렉트 박스명 -->
          	<input type="hidden" name="sGroup3" value="<%=sGroup3%>"><!-- 조회용 셀렉트 박스명 -->
          	<input type="hidden" name="sGroup4" value="<%=sGroup4%>"><!-- 조회용 셀렉트 박스명 -->
          	<input type="hidden" name="sGroup5" value="<%=sGroup5%>"><!-- 조회용 셀렉트 박스명 -->
          	       
            <input type="hidden" name="AuthOption" value="Group">

    		<!-- 검색 > 그룹 셀렉박스 : 시작-->
    		    		
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- 셀렉트 박스 -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>전체</option>
                       <option value="1" <%=aselect%>>사용자명</option>
                       <option value="2" <%=bselect%>>ID</option>
                       <option value="3" <%=cselect%>>그룹명</option>
                   </select>
               </p>
			           
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- 검색 text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- 조회 버튼 --> 
	                  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="엑셀 다운로드" /></a></p> <!-- 엑셀 아이콘 -->
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="사용자정보 일괄등록" /></a></p>  <!-- 사용자정보 일괄등록 아이콘 -->
	                  <!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="엑셀 업로드" /> </p> <!-- 엑셀 아이콘 --> 

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
		        <caption>계정관리</caption>
		            <thead>
		                <tr>
		               	  <th width="30px"><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
		                  <th>사용자명</th>
		                  <th>ID</th>
		                  <th>그룹명</th>
		                  <th>전화번호</th>
		                  <th>사용여부</th>
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
						
					String DIDformat ="";
					if(!ds.getString("FaxNumCnt").equals("")){
						if(ds.getString("FaxNumCnt").equals("1")){
							DIDformat = ds.getString("DID");
						}else{
							DIDformat = ds.getString("DID")+" ("+ ds.getString("FaxNumCnt")+")";
						}
						 
					}
	            %>	
	            <!-- 확인 미확인 구분 볼드처리 끝 -->
		                <input type="hidden" name="seqs" >
		                	<td><input name="checkbox" type="checkbox" value="<%=ds.getString("UserID")%>" /></td>
		                    <td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("UserID")%>');"><%=ds.getString("UserName")%></td>
							<td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("UserID")%>');"><%=ds.getString("UserID")%></td>
							<td><%=ds.getString("GroupName") %></td>
							<td><%=ds.getString("OfficePhoneFormat")%></td>
							<td><%=ds.getString("UseYN")%></td>
							<td><%=ds.getString("CreateDateTime")%></td>
							<td><%=ds.getString("UpdateDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
						i++;
							}
						} else {
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
<div name="userRegistForm" title="사용자등록폼"></div>
<div name="userModifyForm" title="사용자수정폼"></div>
<div name="userExcelForm" title="사용자정보 일괄등록"></div>
</body>
</html>
<!-- <script>
	searchChk();
</script> -->