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
	<title>�ҼӰ���</title>
	
	<!-- <link rel="StyleSheet" href="<%= request.getContextPath() %>/css/hueres.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script> -->
	<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
	<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree-1.2.4.js"></script>
	<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
	
	
<script type="text/javascript">
	$(function(){
		$("#tree").dynatree({
			checkbox: true, //üũ�ڽ� �ֱ�
			selectMode :2, //üũ�ڽ� ���
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 3, //���� Ŭ�� �ɼ�
			minExpandLevel : 2 //���� ���� ����,
			
			/* onClick : function(node){
				
				var formid = node.data.key.split("|");
				
				//�ش� node key������ �Լ��� ����(User�� ��쿡�� �Լ� ����)
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
				//Tree ����
				if(j == 0){
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						icon : '<%= request.getContextPath() %>/images/tree/base.gif',
						select : <%=checked%>
					});
				<%
				}else{
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getMenuName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getMenuName()%>|Folder",
						select : <%=checked%>
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
	
		$("#tree").dynatree("getRoot").visit(function(node){
			node.expand(true);
		});
			
		
	});

	
	
</script>
</head>

<body>
<form name="treeFrm">
	<p class="dynatreeT">
		<a href="#" id="btnToggleExpand">��� ��ġ��</a>
		|
		<a href="#" id="btnToggleExpand2">��� ����</a>
		<!-- 
		|
		<a href="#" id="btnDisable">������</a>
		 -->
		<span id="treeError"></span>
	</p>
	<div id="tree"  style="width: 100%; height: 415px;" name="selNodes" >
		
	</div>
	
	</form>
</body>
</html>
	
<%-- </head>
<body id="dtree" >
<form name="treeFrm">
<div class="dtree">
	<p><a href="javascript: d.openAll();">��� ��ġ��</a> | <a href="javascript: d.closeAll();">��� ����</a></p>
	<script type="text/javascript">
		<!--
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck(upcateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(cateids[i].value==upcateid){
					document.treeFrm.checkName[i].checked=objcheck;	
				}

			}
			
			for(j=0;j<upcateids.length;j++){
			
				if(document.treeFrm.checkName[j].checked==true){
					
					upSelectCheck(upcateids[j].value,objcheck);
					if(objcheck==false){
					document.treeFrm.checkName[j].checked=false;
					}
				}
			}
		}
		//����ī�װ� üŷ�Լ�
		function upSelectCheck(upcateid,objcheck){
			
			var checkid=upcateid;
			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(cateids[i].value==checkid){				
					checkid=upcateids[i].value;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		//�޴����ý� �Լ�(������)
		function selectMenu(menuid){
			
			names=eval("document.all.fontId");
			
		  	for(i=0;i<names.length;i++){
		
		  		if(names[i].title==menuid){
		  		names[i].style.fontWeight="bold";
		    	names[i].style.color="green";
		    	//document.treeFrm.checkName[i].checked=true;	
		  		}else{
		    	names[i].style.fontWeight="";
		    	names[i].style.color="";
		    	//document.treeFrm.checkName[i].checked=false;	
		  		}
		  	}
			
		}
		
		
		
		
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
	   //Ʈ������
		d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" <%=auth%> value=<%=upcateid%> id=upCateId class="chk" name="checkName" onClick=selectCheck(<%=upcateid%>,this) ><input type=hidden id=cateId value=<%=cateid%> ><a href=javascript:selectCheck(<%=upcateid%>,this)><font id=fontId  title=<%=dto.getMenuID()%> ><%=dto.getMenuName()%></font></a>','#','','','images/tree/folder.gif' );

		<%
			}
		}
		%>
		//Ʈ������
		document.write(d);
		d.openAll();//�⺻ Ʈ���� ��ü���½�Ų��.
		//-->
	</script>
</div>
</form>
</body>
</html>

<%-- 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>�ҼӰ���</title>
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body>
<form name="treeFrm">
<div class="dtree">
	<p><a href="javascript: d.openAll();">��� ��ġ��</a> | <a href="javascript: d.closeAll();">��� ����</a></p>
	<script type="text/javascript">
		<!--
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck(upcateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(cateids[i].value==upcateid){
					document.treeFrm.checkName[i].checked=objcheck;	
				}

			}
			
			for(j=0;j<upcateids.length;j++){
			
				if(document.treeFrm.checkName[j].checked==true){
					
					upSelectCheck(upcateids[j].value,objcheck);
					if(objcheck==false){
					document.treeFrm.checkName[j].checked=false;
					}
				}
			}
		}
		//����ī�װ� üŷ�Լ�
		function upSelectCheck(upcateid,objcheck){
			
			var checkid=upcateid;
			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(cateids[i].value==checkid){				
					checkid=upcateids[i].value;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		//�޴����ý� �Լ�(������)
		function selectMenu(menuid){
			
			names=eval("document.all.fontId");
			
		  	for(i=0;i<names.length;i++){
		
		  		if(names[i].title==menuid){
		  		names[i].style.fontWeight="bold";
		    	names[i].style.color="green";
		    	//document.treeFrm.checkName[i].checked=true;	
		  		}else{
		    	names[i].style.fontWeight="";
		    	names[i].style.color="";
		    	//document.treeFrm.checkName[i].checked=false;	
		  		}
		  	}
			
		}
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
	   //Ʈ������
		d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" value=<%=upcateid%> id=upCateId style="vertical-align : bottom" name="checkName" onClick=selectCheck(<%=upcateid%>,this) ><input type=hidden id=cateId value=<%=cateid%> ><input type=hidden name=menutype value=<%=dto.getMenuType()%> ><font id=fontId  title=<%=dto.getMenuID()%> ><%=dto.getMenuName()%></font>','#','','','images/tree/folder.gif' );

		<%
			}
		}
		%>
		//Ʈ������
		document.write(d);
		d.openAll();//�⺻ Ʈ���� ��ü���½�Ų��.
		//-->
	</script>
</div>
</form>
</body>
</html>
 --%>