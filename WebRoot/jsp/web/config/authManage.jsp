<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�޴��� ���ٱ��� ����</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>

<script>
var observer;//ó����
//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
}
//��ȸ
function goSearch(){
	
	var obj=document.UserSearchFrm;
	var uid=document.UserSearchFrm.UserID.value;
	var invalid = ' ';	//���� üũ
	
	if(obj.UserID.value=='' || obj.UserID.value.indexOf(invalid) > -1){
		alert('��ȸ�� ID�� �Է��� �ּ���');
		obj.UserID.value="";
		obj.UserID.focus();
		return;
	}
	//openWaiting( );
	obj.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree&UserID='+uid;
	obj.target="grouptree";
	obj.submit();
	
}
//����ó��
function captureReturnKey(e) {
	 if(e.keyCode==13 && e.srcElement.type != 'textarea')
	 //return false;
	 goSearch();
}
//��������
function goAuthSave(){
	
	//User ���õ� ��ü�� �����´�.
	var node1 = grouptree.$("#tree").dynatree("getRoot"); //tree ��ü ����
	var selNodes1 = node1.tree.getSelectedNodes(); //���õ� Node�� �������� �Լ�
	
	//Menu ���õ� ��ü�� �����´�.
	var node2 = menutree.$('#tree').dynatree("getRoot");
	var selNodes2 = node2.tree.getSelectedNodes();
	
	//������ �ѱ������ ��� ��ü
	var nodeArray = new Array();
	var menuArray = new Array();
	//���õ� ����ڰ� ���� ���
	if(selNodes1.length == 0){
		alert("���õ� ����ڰ� �����ϴ�.");
		return;
	}
	
	//���õ� ����ڰ� 1�� �̻��϶�
	if(selNodes1.length >1){
		if(confirm("���õ� ����ڰ� 1�� �̻��Դϴ�. �����Ͻðڽ��ϱ�?")){
		}else{
			return;
		}
	}
	
	//1.���õ� User�� ID�� Array�� ����
	var selKeys1 = $.map(selNodes1, function(nodes1){
		var userId = nodes1.data.key.split("|"); // [0]:ID, [1]:Name, [2]:����(User,Folder)
		
		//User���� Folder���� ����
		if(userId[2] == "User"){
			nodeArray.push(userId[0]);	
		}
	});
	
	var selKeys2 = $.map(selNodes2, function(nodes2){
		var menuId = nodes2.data.key.split("|");
		
		menuArray.push(menuId[0]);
		
	});
	
	//ajax�� ���� �� ����Ϸ� alert
	//jQuery Ajax
	openWaiting();
	var check = 0;
	jQuery.ajaxSettings.traditional = true; //Array �ѱ�� ajax setting �ʼ�
	
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
				case -1 : alert("�������!"); break;
				case 0	: alert("�������!"); break;
				default : alert("����Ϸ�!");  break;
			}
			
		},
		error : function(request, status, error){
			alert("�������!");
		}
	});
	
	
	/* grouptree.$('#tree').dynatree("getroot").visit(function(node){
		alert("�̻�");
	}); */
	
	
	<%-- var frm=document.UserSearchFrm;
	var userfrm = grouptree.treeFrm;
	var menufrm = menutree.treeFrm;
	var users =eval("grouptree.document.all.fontId");
	var menus =eval("menutree.document.all.fontId"); 
	var checkYN;
	var checkucnt=0;
	var checkmcnt=0;
	
	
	
	//���ÿ��� �Ǵ�
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
		alert('���õ� ����� ������ �����ϴ�.');
		return;
	}
	
	//���ÿ��� �Ǵ�
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
		alert('���õ� �޴� ������ �����ϴ�.');
		return;
	}
	
	
	if(confirm("���õ� �������� ������ �����Ͻðڽ��ϱ�?")){
		
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
*	���̺�  hidden row �߰�
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
			alert('����ڸ� �����ϼž� �󼼺��Ⱑ �����մϴ�.');
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
	<!-- ���̾ƿ����� -->
	<div class="wrap_bgL">
		<!-- ����Ÿ��Ʋ ���� : ���� -->
		<div class="sub_title">
			<p class="titleP">�޴����Ѱ���</p>
		</div>
		<!-- ����Ÿ��Ʋ ���� : �� -->
		<!-- contents -->
		<div class="manage_box">
			<!-- //manage -->
			<div class="manage">
				<!-- �׷� -->
				<div class="groupTree">
					<dl class="move_btn">
						<dt>�׷캰 �����</dt>
					</dl>
					<ul class="tree">
						<iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authGroupTree" id="grouptree" name="grouptree" frameborder="0" class="" scrolling="no" marginwidth="0" marginheight="0" ></iframe>
					</ul>
				</div>
				<!-- //�׷� -->
				
				<!-- �޴����� -->
				<div class="groupTree2">
					<dl class="move_btn move_btn00">
						<dt>�޴����� ����</dt>
					</dl>
					<ul class="tree brLeft">
						<iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authMenuTree" id="menutree" name="menutree" frameborder="0" class="" scrolling="no" marginwidth="0" marginheight="0"></iframe>
					</ul>
				</div>
				<!-- //�޴����� -->
				
				 <!-- ���� -->
		        <div class="groupTree3">
				<em onclick="tabpAction();" class="tap_open" ><span class="blind">��������� ����</span></em>
		          <ul id="userInfoLayer" class="tree brLeft" style="display:none; ">
		              <iframe src="<%=request.getContextPath()%>/H_Auth.do?cmd=authMenuTree" id="userInfo"  name="userInfo" scrolling="no" frameborder="0" class="" marginwidth="0" marginheight="0"></iframe>
		          </ul>
		        </div>
        <!-- //���� -->
			</div>
			<!-- manage// -->
			<!-- ��ư���� -->
			<div class="bottom_btn">
				<a href="javascript:goAuthSave();"><img src="<%=request.getContextPath()%>/images/btn_lypop_save.gif" title="����"></a>
			</div>
			<!-- //��ư���� -->
		</div>
		<!-- contents -->
	</div>
	<!-- ���̾ƿ����� -->
	</form>

	<!-- layer popup : �׷��߰� -->
	<!-- <input type="hidden" name="NodeKey"/>
	<div id="groupRegist" class="ly_pop ly_pop_group" title="�׷� �߰�">
		<div id="alertMassage" class="text_guide">* �׷���� �Է��Ͽ� �ּ���</div>
		<fieldset>
			<legend>�׷��߰�</legend>
			<div class="ly_body">
				<div class="tbl_type_out">
					<table cellspacing="0" cellpadding="0" class="tbl_type">
					<tbody>
						<tr>
							<th><label for="CName">�׷��</label></th>
							<td class="input_box"><input type="hidden" name="chkValidation" id="chkValidation"/><input name="GroupName" id="CName" type="text" size="29" class="in_txt" maxlength="20" value="" onkeyup="chkGroupName()" /><a href="javascript:pre_doCheck();" class="btn_duplicate"><span class="blind">�ߺ�Ȯ��</span></a></td>
						</tr>
						<tr id="list_btn_box">
							<td colspan="2">���õ� <strong id="groupTitle" class="blueTxt boldNo">�׷�</strong>�� <strong class="blueTxt boldNo">�����׷�</strong>���� �߰��˴ϴ�.</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</fieldset>
		<div class="ly_foot"><a href="javascript:goInsert()" class="btn_save"><span class="blind" >����</span></a><a href="javascript:offVisible();" class="btn_cancel"><span class="blind">���</span></a></div>
	</div> -->
	<!-- //layer popup : �׷��߰� -->
</body>
</html>






<%-- 
<!-- ó���� ���� -->
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
<!-- ó���� ���� -->

<body>
<form name="GropuTreeFrm" method="post" action="<%= request.getContextPath() %>/H_Auth.do">
<input type="hidden" name="cmd" value="authGroupTree">
<input type="hidden" name="groupID" value="">
<input type="hidden" name="AuthID" value="12">
</form>
<form name="UserSearchFrm" method="post" onkeydown="return captureReturnKey(event)">
	<!-- ���̾ƿ� ���� -->
	<div id="wrap" class="wrap"  >
	
		<!-- ����Ÿ��Ʋ ���� ���� -->
		<div class="sub_title">
	        <p><img src="<%=request.getContextPath()%>/images/sub/text_mgMenu.gif" width="140" height="16" /></p> 
	        <!-- Ÿ��Ʋ �̹��������� ���� -->
	  	</div>
		<!-- ����Ÿ��Ʋ ���� �� -->
	               
	  	<!-- ���̺� ���� -->
		<div class="UserSearchFrm">
	    
	    	<!-- ������ ����� ���� -->
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
	        <!-- ������ ����� �� -->
	        
	        <!-- ȭ��ǥ ���� -->
	        <div class="arrow">
	            <p class="ar1"><img src="<%=request.getContextPath()%>/images/sub/arrow_right.gif" width="32" height="32" /></p>
	            <p class="ar2"><img src="<%=request.getContextPath()%>/images/sub/arrow_left.gif" width="32" height="32" /></p>            
	        </div>
	        <!-- ȭ��ǥ �� -->
	        
	        <!-- �޴���ȭ�� ���� -->
			<div class="menu_screen">
				<img src="<%=request.getContextPath()%>/images/sub/text_menuScreen.gif" width="89" height="14" style="margin-bottom:7px;"/>
            	<div class="tbl_out">
                    <iframe name="menutree" src="<%=request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&AuthID=12" frameborder="0" class="iframe" ></iframe>
                </div>
                <p class="btn"><a href="javascript:goAuthSave();"><img src="<%=request.getContextPath()%>/images/sub/btn_save.gif" width="42" height="21" title="����" /></a></p>
	   	    </div>
	        <!-- �޴���ȭ�� �� -->
	    </div>
	      <!-- �ӽõ���Ÿ �迭���̺� START --> 
        <table width="100%" height="0" border="0" cellpadding="0" cellspacing="0" id="defaultText">
        </table>
        <!-- �ӽõ���Ÿ �迭���̺� END -->
        <!--�߰�ROW :: START-->
        <table width="100%" border="0" cellpadding="0" cellspacing="0"   id="contentId">
        </table>
        <!--�߰�ROW :: END-->  
	    <div class="clear"></div>
	    <!-- ���̺� �� -->
	</div>
	<!-- ���̾ƿ� �� -->
 </form>   
</body>
</html>
<!-- ��ȸ���� �� ���� START -->
<!--td height="40" align="center" class="textField2">�����(ID)�˻� &nbsp;:&nbsp; 
  <input name="UserID" type="text" class="textField" id="textfield_search" />
  <img src="<%= request.getContextPath() %>/images/sub/spacer.gif" width="10" height="1" />
  <img src="<%= request.getContextPath() %>/images/sub/popup_btn_find.gif" width="45" height="23" border="0" align="absmiddle" usemap="#Map2" alt="��ȸ" title="��ȸ" onFocus="this.blur();" border="0"/>
  </td>
  <map name="Map2" id="Map2">
      <area shape="rect" coords="1,0,45,23" href="javascript:goSearch();" alt="��ȸ" title="��ȸ" />
    </map>-->
  <!-- ��ȸ���� �� ���� END --> --%>