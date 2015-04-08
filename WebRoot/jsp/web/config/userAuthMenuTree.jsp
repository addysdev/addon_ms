<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.MenuDTO"%>
<%@ page import ="com.web.common.user.UserDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<MenuDTO> menulist = (ArrayList)model.get("menulist");
UserDTO userDto= (UserDTO)model.get("userDto");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>메뉴별 화면</title>
	<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
	<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree-1.2.4.js"></script>
	<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
	
<script type="text/javascript">
	$(function(){
		$("#tree").dynatree({
			checkbox: true, //체크박스 주기
			selectMode :3, //체크박스 모드
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 3, //폴더 클릭 옵션
			minExpandLevel : 2 //최초 보일 레벨,
			
			/* onClick : function(node){
				
				var formid = node.data.key.split("|");
				
				//해당 node key값으로 함수에 전달(User일 경우에만 함수 실행)
				if(formid[2] == 'User'){
					selectUser(formid[0],formid[1]);	
				}else{
					
				}
				
				
				/*
				var formRow = parent.$('#FormRow').val();
				if(formRow == formid[2]){
					parent.$('#itemRegBt').show();
				}else{
					parent.$('#itemRegBt').hide();
				}
				
			} */
			
		});

		var rootNode = $("#tree").dynatree("getRoot");
		<%
		if(menulist.size() > 0){
			int i = 0;
			String cateid="";
			String upcateid="";
			String searchResult="0";
			String userid="";
			boolean folderYN = false;
			boolean checked = false;
			
			for(int j=0; j < menulist.size(); j++ ){	
				MenuDTO dto = menulist.get(j);
				
				cateid=dto.getMenuID();
				upcateid=dto.getUpMenuID();
				
				
				//cateid=cateid.substring(1);
				//upcateid=upcateid.substring(1);
				
				searchResult = dto.getAuth();
				
				if(!searchResult.equals("N")){
					checked = true;
				}else{
					checked = false;
				}
				//Tree 생성
				if(j == 0){
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						icon : '<%= request.getContextPath() %>/images/tree/base.gif',
						select : <%=checked%>,
						unselectable : true
					});
				<%
				}else{
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						select : <%=checked%>,
						unselectable : true
					});
					<%
				}
				
			}

		}
		%>
			
			
		$("#btnToggleExpand").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		$("#btnToggleExpand2").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
		
		//모든 폴더 열기
		$("#tree").dynatree("getRoot").visit(function(node){
			node.expand(true);
		});
		
	});

	
	
	function selectOption(){

		var url;
		if($('[name=selectMenu]').attr("checked")=="checked"){
			url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=<%=userDto.getUserID()%>';
		}else{
			url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=';
		}
		parent.menutree.location.href=url;
		
	}
</script>
</head>

<body>
<form name="treeFrm">
<div class="manage_groupTree3">
	<dl class="move_btn">
		<dt><%=userDto.getGroupName() %> <span>|</span></dt>
		<dd><b><%=userDto.getUserName()%> (<%=userDto.getUserID() %>)</b></dd>
		<dd class="setting"><label for="setting"><input name="selectMenu" id="setting" type="checkbox" value="" class="chk" onclick="selectOption();" /> 선택정보로 메뉴세팅</label></dd>
	</dl>
	<em onclick="parent.tabpAction();" class="tap_clos"><span class="blind">사용자정보 열기</span></em>
	<p class="dynatreeT">
		<a href="#" id="btnToggleExpand">모두 펼치기</a>
		|
		<a href="#" id="btnToggleExpand2">모두 접기</a>
		<!-- 
		|
		<a href="#" id="btnDisable">사용안함</a>
		 -->
		<span id="treeError"></span>
	</p>
	<div id="tree" style="width: 100%; height: 415px;" name="selNodes" ></div>
</div>
</form>
</body>
</html>
<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script> --%>
<%--
<script>
function selectOption(){

	var url;

	if(document.treeFrm.selectMenu.checked==true){
		url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=<%=userDto.getUserID()%>';
	}else{
		url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=';
	}
	parent.menutree.location.href=url;
	
}
</script>
</head>
<body>
<form name="treeFrm">
  <!-- contents -->
  <div id="contents" class="authInfo">
    <dl class="move_btn">
      <dt><%=userDto.getGroupName() %> <span>|</span></dt>
      <dd><b><%=userDto.getUserName()%> (<%=userDto.getUserID() %>)</b></dd>
      <dd class="setting">
        <label for="setting">
          <input name="selectMenu" id="setting" type="checkbox" value="" class="chk" onclick="selectOption();" />
          선택정보로 메뉴세팅</label>
      </dd>
    </dl>
    <em class="tap_clos" onClick="parent.tabpAction();"><span class="blind">사용자정보 열기</span></em>
    <!-- dtree -->
    <div style="display:; background:#f00" >
    <div id="dtree" class="dtree" style="display:block; background:#f00">
      <p> <a href="javascript: d.openAll();">모두 펼치기</a> | <a href="javascript: d.closeAll();">모두 접기</a> </p>
      <script type="text/javascript">
					<!--
			
					d = new dTree('d');
					<%	
					
					if(menulist.size() > 0){	
					int i = 0;
					String cateid="";
					String upcateid="";
					String auth="";
			
						for(int j=0; j < menulist.size(); j++ ){	
							MenuDTO dto = menulist.get(j);
							
							cateid=dto.getMenuID();
							upcateid=dto.getUpMenuID();
							
							cateid=cateid.substring(1);
							upcateid=upcateid.substring(1);
							
							auth=dto.getAuth();
							
							if(!"N".equals(auth)){
								auth="checked";
							}else{
								auth="";
							}
							
				    %>
				    //트리구성
					d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" disabled  <%=auth%> class="chk"  name="checkName") ><font id=fontId  title=<%=dto.getMenuID()%> ><%=dto.getMenuName()%></font>','#','','','images/tree/folder.gif' );
			
					<%
						}
					}
					%>
					//트리생성
					document.write(d);
					d.openAll();//기본 트리를 전체오픈시킨다.
					//-->
				</script>
    </div>
    <!-- //dtree -->
  </div>
  </div>
  <p class="attention2">그룹추가시 선택된 그룹의 하위그룹으로 추가됩니다.</p>
  </div>
  <!-- //contents -->
</form>
</body>
</html>

--%>


<%--


<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.MenuDTO"%>
<%@ page import ="com.web.common.user.UserDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<MenuDTO> menulist = (ArrayList)model.get("menulist");
UserDTO userDto= (UserDTO)model.get("userDto");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>메뉴별 화면</title>
	<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/hueres.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree-1.2.4.js"></script>
	<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
	
<script type="text/javascript">
	$(function(){
		$("#tree").dynatree({
			checkbox: true, //체크박스 주기
			selectMode :3, //체크박스 모드
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 3, //폴더 클릭 옵션
			minExpandLevel : 2 //최초 보일 레벨,
			
			/* onClick : function(node){
				
				var formid = node.data.key.split("|");
				
				//해당 node key값으로 함수에 전달(User일 경우에만 함수 실행)
				if(formid[2] == 'User'){
					selectUser(formid[0],formid[1]);	
				}else{
					
				}
				
				
				/*
				var formRow = parent.$('#FormRow').val();
				if(formRow == formid[2]){
					parent.$('#itemRegBt').show();
				}else{
					parent.$('#itemRegBt').hide();
				}
				
			} */
			
		});

		var rootNode = $("#tree").dynatree("getRoot");
		<%
		if(menulist.size() > 0){
			int i = 0;
			String cateid="";
			String upcateid="";
			String searchResult="0";
			String userid="";
			boolean folderYN = false;
			boolean checked = false;
			
			for(int j=0; j < menulist.size(); j++ ){	
				MenuDTO dto = menulist.get(j);
				
				cateid=dto.getMenuID();
				upcateid=dto.getUpMenuID();
				
				
				//cateid=cateid.substring(1);
				//upcateid=upcateid.substring(1);
				
				searchResult = dto.getAuth();
				
				if(!searchResult.equals("N")){
					checked = true;
				}else{
					checked = false;
				}
				//Tree 생성
				if(j == 0){
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						icon : '<%= request.getContextPath() %>/images/tree/base.gif',
						select : <%=checked%>,
						unselectable : true
					});
				<%
				}else{
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						select : <%=checked%>,
						unselectable : true
					});
					<%
				}
				
			}

		}
		%>
			
			
		$("#btnToggleExpand").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		$("#btnToggleExpand2").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
		
		//모든 폴더 열기
		$("#tree").dynatree("getRoot").visit(function(node){
			node.expand(true);
		});
		
	});

	
	
	function selectOption(){

		var url;
		<%--
		if(document.treeFrm.selectMenu.checked==true){
			url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=<%=userDto.getUserID()%>';
		}else{
			url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=';
		}
		parent.menutree.location.href=url;
		--%>
	}
</script>
</head>

<body>
<form name="treeFrm">
	 <dl class="move_btn">
      <dt><%=userDto.getGroupName() %> <span>|</span></dt>
      <dd><b><%=userDto.getUserName()%> (<%=userDto.getUserID() %>)</b></dd>
      <dd class="setting">
        <label for="setting">
          <input name="selectMenu" id="setting" type="checkbox" value="" class="chk" onclick="selectOption();" />
          선택정보로 메뉴세팅</label>
      </dd>
    </dl>
     <em class="tap_clos" onClick="parent.tabpAction();"><span class="blind">사용자정보 열기</span></em>
     <p class="dynatreeT" style="padding:0 0 11px 8px; *padding-bottom:23px;">
		<a href="#" id="btnToggleExpand">모두 펼치기</a>
		|
		<a href="#" id="btnToggleExpand2">모두 접기</a>
		<!-- 
		|
		<a href="#" id="btnDisable">사용안함</a>
		 -->
		<span id="treeError"></span>
	</p>
	<div id="tree"  style="margin-left:0px; width: 524px; width: 524px\0/IE8+9; height: 413px; height: 403px\9; height: 413px\0/IE8+9;" name="selNodes" >
	</div>
	
	</form>
</body>
</html> 
<%--
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.MenuDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
ArrayList<MenuDTO> menulist = (ArrayList)model.get("menulist");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>사용자 메뉴권한</title>
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
	<link href="<%= request.getContextPath() %>/css/common_2.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body>
<form name="treeFrm">
        <!-- TOP 타이틀 시작 -->
        <div id="header">
            <div class="pop_top">
                <p><img src="../images/popup/text_userMenuManage.gif" alt="" width="200" height="44" /></p>
            </div>
        </div>
        <!-- TOP 타이틀 끝 -->
  
        <!-- 메인컨텐츠 시작 -->
        <div id="pop_contents" style="height:480px">
           <div class="dtree">
                  <p><a href="javascript: d.openAll();">모두 펼치기</a> | <a href="javascript: d.closeAll();">모두 접기</a></p>
                  <script type="text/javascript">
                      <!--
              
                      d = new dTree('d');
                      <%	
                      
                      if(menulist.size() > 0){	
                      int i = 0;
                      String cateid="";
                      String upcateid="";
                      String auth="0";
        
                          for(int j=0; j < menulist.size(); j++ ){	
                              MenuDTO dto = menulist.get(j);
                              
                              cateid=dto.getMenuID();
                              upcateid=dto.getUpMenuID();
                              
                              cateid=cateid.substring(1);
                              upcateid=upcateid.substring(1);
                              
                              auth=dto.getAuth();
                              
                      %>
                      //트리구성
                      d.add('<%=cateid%>','<%=upcateid%>','<%=dto.getMenuName()%>','#','','','images/tree/folder.gif' );
              
                      <%
                          }
                      }
                      %>
                      //트리생성
                      document.write(d);
                      d.openAll();//기본 트리를 전체오픈시킨다.
                      //-->
                  </script>
          </div>
        </div>
        <!-- 메인컨텐츠 끝 -->
</form>
</body>
</html>
 --%>