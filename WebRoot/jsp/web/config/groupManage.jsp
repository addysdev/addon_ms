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
<title>���� ����</title>
<style></style>
<script>
//tablememo ����
function onVisible(){
	var arrAddFrm = document.getElementsByName("groupAddForm");
	arrAddFrm[0].style.display = "block";
}

//��� ���̾ƿ� ����
function offVisible() {
	/* var arrAddFrm = document.getElementsByName("groupAddForm");
	arrAddFrm[0].style.display = "none"; */
	//alert("123");
	$('#groupRegist').dialog('close'); 
}

/* function pre_doCheck(){
	
	if(document.groupManageFrm.GroupName.value==''){
		alert('�߰��Ͻ� �������� �Է��ϼ���.');
		return;
	}
	var result=doCheck(document.groupManageFrm.GroupName.value);

	if(result==1){
		alert('�߰��Ͻ� �������� �̹� ������Դϴ�.');
		documnet.groupManageFrm.GroupName.value='';
	}else if(result==2){
		alert('�߰��Ͻ� �������� ���������� �ֽ��ϴ�.');
		documnet.groupManageFrm.GroupName.value='';
	}else{
		alert('��밡���� ������ �Դϴ�.');
	}
	
}
 */
 
 
//���� �߰�
	function goInsert(){
		var key = $('[name=NodeKey]').val();
		var groupid = document.group.groupVeiwFrm.GroupID.value;
		var insertGroupid=$('[name=IGroupID]').val();
		var groupname = $('[name=GroupName]').val();
		var result = $('#chkValidation').val();
		
		if(insertGroupid == ''){
			
			$('#alertMassage').html("<font color='red'>�������̵� �Է��Ͽ� �ּ���</font>");
			$('#chkValidation_id').val("0");
			return;
		}
		
		if(groupname == ''){
			
			$('#alertMassage').html("<font color='red'>�������� �Է��Ͽ� �ּ���</font>");
			$('#chkValidation').val("0");
			return;
		}

		if(result == 0){
			return;
		}else if(result ==1){
			
			var requestUrl='<%=request.getContextPath()%>/H_Group.do?cmd=groupControl';
			
			//�ߺ��ȵǴ� �������� �� ajax�� ���
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
					//���� �߰� �� groupOrderList refresh
					group.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupView&GroupID='+selectedGroup[0];
					list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+selectedGroup[0]+'&GroupStep='+selectedGroup[1];
					
					//���ε� �� tree�� ���� ����
					document.tree.updateGroup(data, key,groupname);
					
					$( "#groupRegist" ).dialog( "close" ); //��� ���� �� ���̾ƿ� �ݱ�
					
				},
				error : function(request, status, error){
					alert("���� ��� ����");
				}
			});	
		}else{
			return;
		}
}

//���� �߰� ���̾ƿ� �˾�
$(function(){
	$('#groupRegist').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
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

//�����߰� ��ư ������ �� ����
function groupRegistPop(){
	var groupName = document.group.groupVeiwFrm.GroupID.value;

	if(groupName == ''){
		alert("������ �����Ͽ� �ּ���");
		return;
	}
	$('#CId').val("");
	$('#CName').val("");
	$('#alertMassage').html("<font color='black'>* �������� �Է��Ͽ� �ּ���</font>");
	$( "#groupRegist" ).dialog( "open" );
	
}

function chkGroupName(){
	var groupName = $('#CName').val();
	
	//Ű �Է� �� �ǽð����� ajax�� �ߺ� üũ
	if(groupName == ""){
		$('#alertMassage').html("<font color='black'>�������� �Է��Ͽ� �ּ���</font>");
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
					$('#alertMassage').html("<font color='red'>�̹� ��ϵ� �������Դϴ�</font>");
					$('#chkValidation').val("0");
				}else if(data == 2){
					$('#alertMassage').html("<font color='red'>�̹� ������ �������Դϴ�</font>");
					$('#chkValidation').val("0");
				}else if(data == 0){
					$('#alertMassage').html("<font color='blue'>��� ������ �������Դϴ�</font>");
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
	
	//Ű �Է� �� �ǽð����� ajax�� �ߺ� üũ
	if(groupId == ""){
		$('#alertMassage').html("<font color='black'>����ID�� �Է��Ͽ� �ּ���</font>");
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
					$('#alertMassage').html("<font color='red'>�̹� ��ϵ� �������̵��Դϴ�</font>");
					$('#chkValidation_id').val("0");
				}else if(data == 2){
					$('#alertMassage').html("<font color='red'>�̹� ������ �������̵��Դϴ�</font>");
					$('#chkValidation_id').val("0");
				}else if(data == 0){
					$('#alertMassage').html("<font color='blue'>��� ������ �������̵��Դϴ�</font>");
					$('#chkValidation_id').val("1");
				}
			},
			error : function(request, status, error){
				alert("code :"+request.status + "<br>message :" + request.responseText);
			}
		});	
	}
	
	
}

//�ѽ���ȣ ��ȸ ���̾ƿ� �˾�
function faxNumList(){
	var GroupID = document.group.groupVeiwFrm.GroupID.value;
	$('#faxNumList').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
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
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Group.do?cmd=groupFaxNumList',{
				"GroupID" : GroupID
			});
		}
	});
	$( "#faxNumList" ).dialog( "open" );
}

//�ѽ���ȣȮ�� ���̾ƿ� �˾�
function groupFaxNumListPop(){
	
	//�ѽ���ȣ�߰� ��ư ������ �� ����
	
	var groupName = document.group.groupVeiwFrm.GroupID.value;

	if(groupName == ''){
		alert("������ �����Ͽ� �ּ���");
		return;
	}
	$('#CName').val("");
	//$('#alertMassage').html("<font color='black'>* �������� �Է��Ͽ� �ּ���</font>");
	
	var nodeKey = $('[name=NodeKey]').val().split("|");
	$('#groupFaxNumInfo').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
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
			
			//�˾� ������ url
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
	<!-- ���̾ƿ����� -->
	<div class="wrap_bgL">
		<!-- ����Ÿ��Ʋ ���� : ���� -->
		<div class="sub_title">
			<p class="titleP">��������</p>
		</div>
		<!-- ����Ÿ��Ʋ ���� : �� -->
		<!-- contents -->
		<div class="manage_box">
			<!-- //manage -->
			<div class="manage">
				<!-- ���� -->
				<div class="groupTree">
					<dl class="move_btn">
						<dt>��������</dt>
					</dl>
					<ul class="tree">
						<iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupTreeList&GroupID=G00001&GroupStep=1" id="tree" name="tree" frameborder="0" class="" scrolling="no"></iframe>
					</ul>
				</div>
				<!-- //���� -->
				<!-- �������� -->
				<div class="groupList">
					<dl class="move_btn move_btn00">
						<dt id="groupTitle" name="groupTitle"></dt>
						<dd id="groupInsertBt">
							<a href="javascript:groupRegistPop()" class="btn_groupReg"><span class="blind">�����߰�</span></a>
						</dd>
						
					</dl>
					<!-- �������� ������ -->
					<div class="groupStep"><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupView" width="0" height="0" id="group" name="group" frameborder="0" scrolling="no"></iframe></div>
					<!-- ����Ʈ ������ -->
					<div class="grouolist"><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupOrderList" name="list" frameborder="0" scrolling="no"></iframe></div>
				</div>
				<!-- //�������� -->
			</div>
			<!-- manage// -->
		</div>
		<!-- contents -->
	</div>
	<!-- ���̾ƿ����� -->
	</form>

	<!-- layer popup : �����߰� -->
	<input type="hidden" name="NodeKey"/>
	<div id="groupRegist" class="ly_pop ly_pop_group" title="���� �߰�">
		<div id="alertMassage" class="text_guide">* �������� �Է��Ͽ� �ּ���</div>
		<fieldset>
			<legend>�����߰�</legend>
			<div class="ly_body">
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
						<tr>
							<th><label for="CName">����ID</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation_id" id="chkValidation_id"/><input name="IGroupID" id="CId" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupId()" /></td>
						   	</tr>
						<tr>
							<th><label for="CName">������</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation" id="chkValidation"/><input name="GroupName" id="CName" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupName()" /></td>
						</tr>
						<tr id="list_btn_box">
							<td colspan="2">���õ� <strong id="groupTitle" class="blueTxt boldNo">����</strong>�� <strong class="blueTxt boldNo">��������</strong>���� �߰��˴ϴ�.</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</fieldset>
		<div class="ly_foot"><a href="javascript:goInsert()" class="btn_save"><span class="blind" >����</span></a>
		<a href="javascript:offVisible();" class="btn_cancel"><span class="blind">���</span></a></div>
	</div>
	<!-- //layer popup : �����߰� -->
	<div id="faxNumList" title="�ѽ���ȣ ���"></div>
	<div id="groupFaxNumInfo" title="�ѽ���ȣ Ȯ��"></div>
</body>
</html>