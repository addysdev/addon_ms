<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>메뉴별 접근권한 관리</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>

<script>
var observer;//처리중
//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
}
//조회
function goSearch(){
	
	var obj=document.UserSearchFrm;
	var uid=document.UserSearchFrm.UserID.value;
	var invalid = ' ';	//공백 체크
	
	if(obj.UserID.value=='' || obj.UserID.value.indexOf(invalid) > -1){
		alert('조회할 ID를 입력해 주세요');
		obj.UserID.value="";
		obj.UserID.focus();
		return;
	}
	//openWaiting( );
	obj.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree&UserID='+uid;
	obj.target="grouptree";
	obj.submit();
	
}
//엔터처리
function captureReturnKey(e) {
	 if(e.keyCode==13 && e.srcElement.type != 'textarea')
	 //return false;
	 goSearch();
}
//권한저장
function goAuthSave(){
	
	//User 선택된 개체를 가져온다.
	var node1 = grouptree.$("#tree").dynatree("getRoot"); //tree 객체 접근
	var selNodes1 = node1.tree.getSelectedNodes(); //선택된 Node만 가져오는 함수
	
	//Menu 선택된 개체를 가져온다.
	var node2 = menutree.$('#tree').dynatree("getRoot");
	var selNodes2 = node2.tree.getSelectedNodes();
	
	//데이터 넘기기위에 담는 객체
	var nodeArray = new Array();
	var menuArray = new Array();
	//선택된 사용자가 없을 경우
	if(selNodes1.length == 0){
		alert("선택된 사용자가 없습니다.");
		return;
	}
	
	//선택된 사용자가 1명 이상일때
	if(selNodes1.length >1){
		if(confirm("선택된 사용자가 1명 이상입니다. 저장하시겠습니까?")){
		}else{
			return;
		}
	}
	
	//1.선택된 User의 ID를 Array에 저장
	var selKeys1 = $.map(selNodes1, function(nodes1){
		var userId = nodes1.data.key.split("|"); // [0]:ID, [1]:Name, [2]:구분(User,Folder)
		
		//User인지 Folder인지 구분
		if(userId[2] == "User"){
			nodeArray.push(userId[0]);	
		}
	});
	
	var selKeys2 = $.map(selNodes2, function(nodes2){
		var menuId = nodes2.data.key.split("|");
		
		menuArray.push(menuId[0]);
		
	});
	
	//ajax로 저장 후 저장완료 alert
	//jQuery Ajax
	openWaiting();
	var check = 0;
	jQuery.ajaxSettings.traditional = true; //Array 넘길시 ajax setting 필수
	
	$.ajax({
		url : "<%= request.getContextPath() %>/H_Auth.do?cmd=authRegist",
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"users" : nodeArray,
			"menus" : menuArray
		},
		success : function(data, textStatus, XMLHttpRequest){
			
			$('#waitwindow').hide();
			switch(data){
				case -1 : alert("저장오류!"); break;
				case 0	: alert("저장실패!"); break;
				default : alert("저장완료!");  break;
			}
			
		},
		error : function(request, status, error){
			alert("저장오류!");
		}
	});
	
	
	/* grouptree.$('#tree').dynatree("getroot").visit(function(node){
		alert("이상무");
	}); */
	
	
	<%-- var frm=document.UserSearchFrm;
	var userfrm = grouptree.treeFrm;
	var menufrm = menutree.treeFrm;
	var users =eval("grouptree.document.all.fontId");
	var menus =eval("menutree.document.all.fontId"); 
	var checkYN;
	var checkucnt=0;
	var checkmcnt=0;
	
	
	
	//선택여부 판단
	if(userfrm.checkName.length>1){
		for(i=0;i<userfrm.checkName.length;i++){
			if(userfrm.checkName[i].checked==true){
				if(users[i].title.trim()!=''){
					checkucnt++;
				}
			}
		}
	}else{
		if(userfrm.checkName.checked==true){
			if(users[i].title.trim()!=''){
				checkucnt++;
			}
		}
	}
	
	if(checkucnt==0){
		alert('선택된 사용자 정보가 없습니다.');
		return;
	}
	
	//선택여부 판단
	if(menufrm.checkName.length>1){
		for(i=0;i<menufrm.checkName.length;i++){
			if(menufrm.checkName[i].checked==true){
				checkmcnt++;
			}
		}
	}else{
		if(userfrm.checkName.checked==true){
			checkmcnt++;
		}
	}
	
	if(checkmcnt==0){
		alert('선택된 메뉴 정보가 없습니다.');
		return;
	}
	
	
	if(confirm("선택된 내용으로 권한을 저장하시겠습니까?")){
		
		if(userfrm.checkName.length>1){
			for(i=0;i<userfrm.checkName.length;i++){
				if(userfrm.checkName[i].checked==true){
					checkYN='Y';
				}else{
					checkYN='N';
				}

				doAddHiddenRowData(fillSpace(users[i].title),fillSpace(checkYN),'users');
			}
		}else{
			if(userfrm.checkName.checked==true){
				checkYN='Y';
			}else{
				checkYN='N';
			}
			doAddHiddenRowData(fillSpace(users.title),fillSpace(checkYN),'users');

		}
		
		if(menufrm.checkName.length>1){
			for(i=0;i<menufrm.checkName.length;i++){
				if(menufrm.checkName[i].checked==true){
					checkYN='Y';
				}else{
					checkYN='N';
				}
	
				doAddHiddenRowData(fillSpace(menus[i].title),fillSpace(checkYN),'menus');
			}
		}else{
			if(menufrm.checkName.checked==true){
				checkYN='Y';
			}else{
				checkYN='N';
			}
			doAddHiddenRowData(fillSpace(menus.title),fillSpace(checkYN),'menus');

		}
		
		openWaiting( );
		frm.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authRegist';
		frm.submit();
		
	} --%>
	
}
/*
*	테이블  hidden row 추가
*/
function doAddHiddenRowData(data,checkyn,name){

	defaultText.style.display='none';

	var rowCnt = contentId.rows.length;

	var newRow = contentId.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};

	var newCell = newRow.insertCell();
	newCell.innerHTML = '<input name="'+name+'" value="'+data+'|'+checkyn+'" type="hidden"  />';
}
var tabYN='N';
function tabpAction(){
	//var userInfoLayer = document.getElementsByName("userInfoLayer");
	var layerStyle = $('#userInfoLayer').css("display");
	
	if(layerStyle=='block'){
		$('#userInfoLayer').hide();
		$('.tap_open').show();
		//$('#userInfoLayer').hide();
		//userInfoLayer[0].style.display="none";
	}else{
		if(tabYN=='Y'){
			$('#userInfoLayer').show();
			$('.tap_open').hide();
			//$('#userInfoLayer').show();
		}else{
			alert('사용자를 선택하셔야 상세보기가 가능합니다.');
			return;
		}
	}
}
</script>
</head>
<body class="body_bgAll">
<form name="groupManageFrm">
	<!-- header -->
	<div><%@ include file="/jsp/web/common/main/top.jsp" %></div>
	<!-- //header -->
	<!-- 레이아웃시작 -->
	<div class="wrap_bgL">
		<!-- 서브타이틀 영역 : 시작 -->
		<div class="sub_title">
			<p class="titleP">메뉴권한관리</p>
		</div>
		<!-- 서브타이틀 영역 : 끝 -->
		<!-- contents -->
		<div class="manage_box">
			<!-- //manage -->
			<div class="manage">
				<!-- 그룹 -->
				<div class="groupTree">
					<dl class="move_btn">
						<dt>그룹별 사용자</dt>
					</dl>
					<ul class="tree">
						<iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authGroupTree" id="grouptree" name="grouptree" frameborder="0" class="" scrolling="no" marginwidth="0" marginheight="0" ></iframe>
					</ul>
				</div>
				<!-- //그룹 -->
				
				<!-- 메뉴권한 -->
				<div class="groupTree2">
					<dl class="move_btn move_btn00">
						<dt>메뉴권한 선택</dt>
					</dl>
					<ul class="tree brLeft">
						<iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authMenuTree" id="menutree" name="menutree" frameborder="0" class="" scrolling="no" marginwidth="0" marginheight="0"></iframe>
					</ul>
				</div>
				<!-- //메뉴권한 -->
				
				 <!-- 개별 -->
		        <div class="groupTree3">
				<em onclick="tabpAction();" class="tap_open" ><span class="blind">사용자정보 열기</span></em>
		          <ul id="userInfoLayer" class="tree brLeft" style="display:none; ">
		              <iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authMenuTree" id="userInfo"  name="userInfo" scrolling="no" frameborder="0" class="" marginwidth="0" marginheight="0"></iframe>
		          </ul>
		        </div>
        <!-- //개별 -->
			</div>
			<!-- manage// -->
			<!-- 버튼영역 -->
			<div class="bottom_btn">
				<a href="javascript:goAuthSave();"><img src="<%=request.getContextPath()%>/images/btn_lypop_save.gif" title="저장"></a>
			</div>
			<!-- //버튼영역 -->
		</div>
		<!-- contents -->
	</div>
	<!-- 레이아웃시작 -->
	</form>

	<!-- layer popup : 그룹추가 -->
	<!-- <input type="hidden" name="NodeKey"/>
	<div id="groupRegist" class="ly_pop ly_pop_group" title="그룹 추가">
		<div id="alertMassage" class="text_guide">* 그룹명을 입력하여 주세요</div>
		<fieldset>
			<legend>그룹추가</legend>
			<div class="ly_body">
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
						<tr>
							<th><label for="CName">그룹명</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation" id="chkValidation"/><input name="GroupName" id="CName" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupName()" /><a href="javascript:pre_doCheck();" class="btn_duplicate"><span class="blind">중복확인</span></a></td>
						</tr>
						<tr id="list_btn_box">
							<td colspan="2">선택된 <strong id="groupTitle" class="blueTxt boldNo">그룹</strong>의 <strong class="blueTxt boldNo">하위그룹</strong>으로 추가됩니다.</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</fieldset>
		<div class="ly_foot"><a href="javascript:goInsert()" class="btn_save"><span class="blind" >저장</span></a><a href="javascript:offVisible();" class="btn_cancel"><span class="blind">취소</span></a></div>
	</div> -->
	<!-- //layer popup : 그룹추가 -->
</body>
</html>






<%-- 
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

<body>
<form name="GropuTreeFrm" method="post" action="<%= request.getContextPath() %>/H_Auth.do">
<input type="hidden" name="cmd" value="authGroupTree">
<input type="hidden" name="groupID" value="">
<input type="hidden" name="AuthID" value="12">
</form>
<form name="UserSearchFrm" method="post" onkeydown="return captureReturnKey(event)">
	<!-- 레이아웃 시작 -->
	<div id="wrap" class="wrap"  >
	
		<!-- 서브타이틀 영역 시작 -->
		<div class="sub_title">
	        <p><img src="<%=request.getContextPath()%>/images/sub/text_mgMenu.gif" width="140" height="16" /></p> 
	        <!-- 타이틀 이미지변경은 여기 -->
	  	</div>
		<!-- 서브타이틀 영역 끝 -->
	               
	  	<!-- 테이블 시작 -->
		<div class="UserSearchFrm">
	    
	    	<!-- 조직별 사용자 시작 -->
			<div class="group_user">
				 <p style="display: inline-block;margin-bottom:5px;">
                <img src="<%=request.getContextPath()%>/images/sub/text_groupUser.gif" width="89" height="14" style="padding-bottom:2px" >
				 <%
                 CodeParam codeParam = new CodeParam();
                 codeParam.setType("select"); 
                 codeParam.setStyleClass("input_box") ;
                 codeParam.setName("SearchGroup");
                 codeParam.setSelected("GSA0100");
                 codeParam.setEvent("changeGroup()");
                 out.print(CommonUtil.getGroupList(codeParam,"12")); 
                 %>
                 </p>
            	<div class="tbl_out">
                    <iframe id="grouptree" name="grouptree" frameborder="0" class="iframe" src="<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree&groupID=GSA0100&AuthID=12"></iframe>
	        	</div>
            </div>
	        <!-- 조직별 사용자 끝 -->
	        
	        <!-- 화살표 시작 -->
	        <div class="arrow">
	            <p class="ar1"><img src="<%=request.getContextPath()%>/images/sub/arrow_right.gif" width="32" height="32" /></p>
	            <p class="ar2"><img src="<%=request.getContextPath()%>/images/sub/arrow_left.gif" width="32" height="32" /></p>            
	        </div>
	        <!-- 화살표 끝 -->
	        
	        <!-- 메뉴별화면 시작 -->
			<div class="menu_screen">
				<img src="<%=request.getContextPath()%>/images/sub/text_menuScreen.gif" width="89" height="14" style="margin-bottom:7px;"/>
            	<div class="tbl_out">
                    <iframe name="menutree" src="<%=request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&AuthID=12" frameborder="0" class="iframe" ></iframe>
                </div>
                <p class="btn"><a href="javascript:goAuthSave();"><img src="<%=request.getContextPath()%>/images/sub/btn_save.gif" width="42" height="21" title="저장" /></a></p>
	   	    </div>
	        <!-- 메뉴별화면 끝 -->
	    </div>
	      <!-- 임시데이타 배열테이블 START --> 
        <table width="100%" height="0" border="0" cellpadding="0" cellspacing="0" id="defaultText">
        </table>
        <!-- 임시데이타 배열테이블 END -->
        <!--추가ROW :: START-->
        <table width="100%" border="0" cellpadding="0" cellspacing="0"   id="contentId">
        </table>
        <!--추가ROW :: END-->  
	    <div class="clear"></div>
	    <!-- 테이블 끝 -->
	</div>
	<!-- 레이아웃 끝 -->
 </form>   
</body>
</html>
<!-- 조회영역 및 저장 START -->
<!--td height="40" align="center" class="textField2">사용자(ID)검색 &nbsp;:&nbsp; 
  <input name="UserID" type="text" class="textField" id="textfield_search" />
  <img src="<%= request.getContextPath() %>/images/sub/spacer.gif" width="10" height="1" />
  <img src="<%= request.getContextPath() %>/images/sub/popup_btn_find.gif" width="45" height="23" border="0" align="absmiddle" usemap="#Map2" alt="조회" title="조회" onFocus="this.blur();" border="0"/>
  </td>
  <map name="Map2" id="Map2">
      <area shape="rect" coords="1,0,45,23" href="javascript:goSearch();" alt="조회" title="조회" />
    </map>-->
  <!-- 조회영역 및 저장 END --> --%>