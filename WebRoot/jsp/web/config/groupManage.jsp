<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link type="text/css" href="<%= request.getContextPath()%>/css/common_2.css" rel="stylesheet" />
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<title>조직 관리</title>
<style></style>
<script>
//tablememo 열림
function onVisible(){
	var arrAddFrm = document.getElementsByName("groupAddForm");
	arrAddFrm[0].style.display = "block";
}

//등록 레이아웃 닫힘
function offVisible() {
	/* var arrAddFrm = document.getElementsByName("groupAddForm");
	arrAddFrm[0].style.display = "none"; */
	//alert("123");
	$('#groupRegist').dialog('close'); 
}

/* function pre_doCheck(){
	
	if(document.groupManageFrm.GroupName.value==''){
		alert('추가하실 조직명을 입력하세요.');
		return;
	}
	var result=doCheck(document.groupManageFrm.GroupName.value);

	if(result==1){
		alert('추가하실 조직명은 이미 사용중입니다.');
		documnet.groupManageFrm.GroupName.value='';
	}else if(result==2){
		alert('추가하실 조직명은 삭제내역이 있습니다.');
		documnet.groupManageFrm.GroupName.value='';
	}else{
		alert('사용가능한 조직명 입니다.');
	}
	
}
 */
 
 
//조직 추가
	function goInsert(){
		var key = $('[name=NodeKey]').val();
		var groupid = document.group.groupVeiwFrm.GroupID.value;
		var insertGroupid=$('[name=IGroupID]').val();
		var groupname = $('[name=GroupName]').val();
		var result = $('#chkValidation').val();
		
		if(insertGroupid == ''){
			
			$('#alertMassage').html("<font color='red'>조직아이디를 입력하여 주세요</font>");
			$('#chkValidation_id').val("0");
			return;
		}
		
		if(groupname == ''){
			
			$('#alertMassage').html("<font color='red'>조직명을 입력하여 주세요</font>");
			$('#chkValidation').val("0");
			return;
		}

		if(result == 0){
			return;
		}else if(result ==1){
			
			var requestUrl='<%=request.getContextPath()%>/H_Group.do?cmd=groupControl';
			
			//중복안되는 조직명일 때 ajax로 등록
			$.ajax({
				url : requestUrl,
				type : "post",
				dataType : "text",
				async : false,
				data : {
					"manageGb" : "I",
					"GroupID" : groupid,
					"IGroupID" : insertGroupid,
					"GroupName" : encodeURIComponent(groupname)
				},
				success : function(data, textStatus, XMLHttpRequest){
					var selectedGroup = key.split("|");
					//조직 추가 후 groupOrderList refresh
					group.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupView&GroupID='+selectedGroup[0];
					list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+selectedGroup[0]+'&GroupStep='+selectedGroup[1];
					
					//리로딩 후 tree에 조직 생성
					document.tree.updateGroup(data, key,groupname);
					
					$( "#groupRegist" ).dialog( "close" ); //등록 성공 시 레이아웃 닫기
					
				},
				error : function(request, status, error){
					alert("조직 등록 실패");
				}
			});	
		}else{
			return;
		}
}

//조직 추가 레이아웃 팝업
$(function(){
	$('#groupRegist').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 260,
		width : 330,
		autoOpen : false,
		modal : false,
		position : {
			my: 'left top',
			at: 'right top',
			of: $('.btn_groupReg')
			}
	});
});

//조직추가 버튼 눌렀을 때 실행
function groupRegistPop(){
	var groupName = document.group.groupVeiwFrm.GroupID.value;

	if(groupName == ''){
		alert("조직을 선택하여 주세요");
		return;
	}
	$('#CId').val("");
	$('#CName').val("");
	$('#alertMassage').html("<font color='black'>* 조직명을 입력하여 주세요</font>");
	$( "#groupRegist" ).dialog( "open" );
	
}

function chkGroupName(){
	var groupName = $('#CName').val();
	
	//키 입력 시 실시간으로 ajax로 중복 체크
	if(groupName == ""){
		$('#alertMassage').html("<font color='black'>조직명을 입력하여 주세요</font>");
	}else{
		$.ajax({
			url : "<%= request.getContextPath()%>/H_Group.do?cmd=checkGroupName",
			type : "post",
			dataType : "text",
			async : true,
			data : {
				"GroupName" : encodeURIComponent(groupName)
			},
			success : function(data, textStatus, XMLHttpRequest){

				if(data == 1){
					$('#alertMassage').html("<font color='red'>이미 등록된 조직명입니다</font>");
					$('#chkValidation').val("0");
				}else if(data == 2){
					$('#alertMassage').html("<font color='red'>이미 삭제된 조직명입니다</font>");
					$('#chkValidation').val("0");
				}else if(data == 0){
					$('#alertMassage').html("<font color='blue'>사용 가능한 조직명입니다</font>");
					$('#chkValidation').val("1");
				}
			},
			error : function(request, status, error){
				alert("code :"+request.status + "<br>message :" + request.responseText);
			}
		});	
	}
	
	
}
function chkGroupId(){
	var groupId = $('#CId').val();
	
	//키 입력 시 실시간으로 ajax로 중복 체크
	if(groupId == ""){
		$('#alertMassage').html("<font color='black'>조직ID을 입력하여 주세요</font>");
	}else{
		$.ajax({
			url : "<%= request.getContextPath()%>/H_Group.do?cmd=checkGroupId",
			type : "post",
			dataType : "text",
			async : true,
			data : {
				"GroupID" : encodeURIComponent(groupId)
			},
			success : function(data, textStatus, XMLHttpRequest){

				if(data == 1){
					$('#alertMassage').html("<font color='red'>이미 등록된 조직아이디입니다</font>");
					$('#chkValidation_id').val("0");
				}else if(data == 2){
					$('#alertMassage').html("<font color='red'>이미 삭제된 조직아이디입니다</font>");
					$('#chkValidation_id').val("0");
				}else if(data == 0){
					$('#alertMassage').html("<font color='blue'>사용 가능한 조직아이디입니다</font>");
					$('#chkValidation_id').val("1");
				}
			},
			error : function(request, status, error){
				alert("code :"+request.status + "<br>message :" + request.responseText);
			}
		});	
	}
	
	
}

//팩스번호 조회 레이아웃 팝업
function faxNumList(){
	var GroupID = document.group.groupVeiwFrm.GroupID.value;
	$('#faxNumList').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 450,
		width : 450,
		autoOpen : false,
		modal : true,
		position : {
			my: 'right top',
			at: 'right top',
			of: $('.btn_groupReg')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Group.do?cmd=groupFaxNumList',{
				"GroupID" : GroupID
			});
		}
	});
	$( "#faxNumList" ).dialog( "open" );
}

//팩스번호확인 레이아웃 팝업
function groupFaxNumListPop(){
	
	//팩스번호추가 버튼 눌렀을 때 실행
	
	var groupName = document.group.groupVeiwFrm.GroupID.value;

	if(groupName == ''){
		alert("조직을 선택하여 주세요");
		return;
	}
	$('#CName').val("");
	//$('#alertMassage').html("<font color='black'>* 조직명을 입력하여 주세요</font>");
	
	var nodeKey = $('[name=NodeKey]').val().split("|");
	$('#groupFaxNumInfo').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 450,
		width : 450,
		autoOpen : false,
		modal : true,
		position : {
			my: 'left top',
			at: 'right top',
			of: $('.btn_groupReg')
		},
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Group.do?cmd=groupFaxNumInfo',{
				"GroupID" : nodeKey[0]
			});
		}
	});
	$( "#groupFaxNumInfo" ).dialog( "open" );
		
	
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
			<p class="titleP">조직관리</p>
		</div>
		<!-- 서브타이틀 영역 : 끝 -->
		<!-- contents -->
		<div class="manage_box">
			<!-- //manage -->
			<div class="manage">
				<!-- 조직 -->
				<div class="groupTree">
					<dl class="move_btn">
						<dt>조직선택</dt>
					</dl>
					<ul class="tree">
						<iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupTreeList&GroupID=G00001&GroupStep=1" id="tree" name="tree" frameborder="0" class="" scrolling="no"></iframe>
					</ul>
				</div>
				<!-- //조직 -->
				<!-- 조직관리 -->
				<div class="groupList">
					<dl class="move_btn move_btn00">
						<dt id="groupTitle" name="groupTitle"></dt>
						<dd id="groupInsertBt">
							<a href="javascript:groupRegistPop()" class="btn_groupReg"><span class="blind">조직추가</span></a>
						</dd>
						
					</dl>
					<!-- 조직정보 프레임 -->
					<div class="groupStep"><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupView" width="0" height="0" id="group" name="group" frameborder="0" scrolling="no"></iframe></div>
					<!-- 리스트 프레임 -->
					<div class="grouolist"><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupOrderList" name="list" frameborder="0" scrolling="no"></iframe></div>
				</div>
				<!-- //조직관리 -->
			</div>
			<!-- manage// -->
		</div>
		<!-- contents -->
	</div>
	<!-- 레이아웃시작 -->
	</form>

	<!-- layer popup : 조직추가 -->
	<input type="hidden" name="NodeKey"/>
	<div id="groupRegist" class="ly_pop ly_pop_group" title="조직 추가">
		<div id="alertMassage" class="text_guide">* 조직명을 입력하여 주세요</div>
		<fieldset>
			<legend>조직추가</legend>
			<div class="ly_body">
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
						<tr>
							<th><label for="CName">조직ID</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation_id" id="chkValidation_id"/><input name="IGroupID" id="CId" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupId()" /></td>
						   	</tr>
						<tr>
							<th><label for="CName">조직명</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation" id="chkValidation"/><input name="GroupName" id="CName" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupName()" /></td>
						</tr>
						<tr id="list_btn_box">
							<td colspan="2">선택된 <strong id="groupTitle" class="blueTxt boldNo">조직</strong>의 <strong class="blueTxt boldNo">하위조직</strong>으로 추가됩니다.</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</fieldset>
		<div class="ly_foot"><a href="javascript:goInsert()" class="btn_save"><span class="blind" >저장</span></a>
		<a href="javascript:offVisible();" class="btn_cancel"><span class="blind">취소</span></a></div>
	</div>
	<!-- //layer popup : 조직추가 -->
	<div id="faxNumList" title="팩스번호 등록"></div>
	<div id="groupFaxNumInfo" title="팩스번호 확인"></div>
</body>
</html>