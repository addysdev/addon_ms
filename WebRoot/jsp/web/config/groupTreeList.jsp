<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> grouplist = (ArrayList)model.get("grouplist");
String GroupID = (String)model.get("GroupID");
String GroupStep = (String)model.get("GroupStep");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�׷����</title>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree.js"/></script>
	<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function(){
		$("#tree").dynatree({
			checkbox: false, //üũ�ڽ� �ֱ�
			selectMode :3, //üũ�ڽ� ���
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 1, //���� Ŭ�� �ɼ�
			minExpandLevel : 2, //���� ���� ����
			onClick : function(node){
				//console.log(node.data.key);
				var key = node.data.key.split("|");
				selectNode(key[0],key[1],key[2], node.data.key);
				
			},
			
			
			//drag and drop
			dnd:{
				preventVoidMoves: true,
				onDragStart: function(node) {
					
			        /** This function MUST be defined to enable dragging for the tree.
			         *  Return false to cancel dragging of node.
			         */
			        return true;
			      },
			      onDragEnter: function(node, sourceNode) {
			    	
			        /** sourceNode may be null for non-dynatree droppables.
			         *  Return false to disallow dropping on node. In this case
			         *  onDragOver and onDragLeave are not called.
			         *  Return 'over', 'before, or 'after' to force a hitMode.
			         *  Return ['before', 'after'] to restrict available hitModes.
			         *  Any other return value will calc the hitMode from the cursor position.
			         */
			        // Prevent dropping a parent below another parent (only sort
			        // nodes under the same parent)
			        /* if(node.parent !== sourceNode.parent){
			          return true;
			        } */
			        // Don't allow dropping *over* a node (would create a child)
			        //console.log(node.parent.data.key);
			        
			        //�ֻ��� �������� ���� �ʵ��� üũ
		    		if(node.isDescendantOf(sourceNode)){
		              return false;
		            }
			        
			        
			        var nodeKey = node.parent.data.key.split("|");
			        if(nodeKey.length == 1){
			        	return false;
			        }else{
			        	return true;	
			        }
			        
			      },
			      onDrop: function(node, sourceNode, hitMode, ui, draggable) {
			    	//$('#test').text(sourceNode.parent.childList);
			        /** This function MUST be defined to enable dropping of items on
			         *  the tree.
			         */
			         
			        var message = "";
			        var nodeName = sourceNode.data.key.split("|");
			        var upNodeName = node.data.key.split("|");
			        
			        switch(hitMode){
			        	case "after" : {
			        		message = "["+upNodeName[2]+"] �� �Ʒ��� ["+nodeName[2]+"] �׷��� �̵��Ͻðڽ��ϱ�?";
							break;
			        	}
			        	case "before" : {
			        		message = "["+upNodeName[2]+"] �� ���� ["+nodeName[2]+"] �׷��� �̵��Ͻðڽ��ϱ�?";
							break;
			        	}
			        	case "over" : {
			        		message = "["+upNodeName[2]+"] �� ������ ["+nodeName[2]+"] �׷��� �̵��Ͻðڽ��ϱ�?";
							break;
			        	}
			        }
			        
			        if(confirm(message)){
			        	
			         
			        
			        sourceNode.move(node, hitMode);
			        
			        /**
			         * sourceNode�� �巡���ϴ� ���
			         * node�� �巡���ؼ� ���� ���
			         */
			        
			        //�ش� ���� ���� ������ key��
			        /*
			        console.log(sourceNode.parent.data.key);
			       	console.log(node.parent.data.key);
			        console.log(sourceNode.parent);
			        console.log(node);
			        */
			        //console.log(hitMode);

			        //�̵��ϴ� ����� ���������� ���� ���
			        if(hitMode == "after" || hitMode == "before"){
			        	
			        	var childList = sourceNode.parent.childList; //�̵��ϴ� ������ ���� �������� ����
				    	var NodeID = new Array(); 
			        	
				    	var upNodeKey = node.parent.data.key.split('|');
				    	var selectNodeKey = sourceNode.data.key.split('|');
				    	
			        	for(var x=0; x<childList.length; x++){
			        		
				    		var nodeKey = childList[x].data.key.split('|');
				    		
				    		//console.log(nodeKey[0]+"|"+(x+1));
				    		NodeID.push(nodeKey[0]+"|"+(x+1)); //�̵��� ���������� ��� node �� sortNum�� �迭�� ����
				    		
				    	}
			        	jQuery.ajaxSettings.traditional = true; //Array �ѱ�� ajax setting �ʼ�
			    		
			    		//ID���� sortNum�� update
			    		
			    		$.ajax({
							url : "<%= request.getContextPath()%>/H_Group.do?cmd=changeGroupSort",
							type : "post",
							dataType : "text",
							async : true,
							data : {
								"NodeID" : NodeID,
								"JobGb" : 1,	//���� ��ġ �̵��϶� ó�� ����
								"UpNodeID" : upNodeKey[0],
								"Step" : upNodeKey[1],
								"SelectNodeID" : selectNodeKey[0]
							},
							success : function(data, textStatus, XMLHttpRequest){
								if(data == "1"){
									parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+upNodeKey[0]+'&GroupStep='+upNodeKey[1];
								}else{
									alert("�׷� �̵� ����!");
								}
								//console.log(data);								
							},
							error : function(request, status, error){
								alert("code :"+request.status + "<br>message :" + request.responseText);
							}
						});
			        	
			        	
			        //�������� ������ �̵� ��
			        }else if(hitMode == "over"){
			        	
			        	var childList = sourceNode.parent.childList; //�̵��ϴ� ������ ���� �������� ����
				    	var NodeID = new Array(); 
			        	
				    	var upNodeKey = node.data.key.split('|'); 
				    	var selectNodeKey = sourceNode.data.key.split('|');
				    	
			        	for(var x=0; x<childList.length; x++){
			        		
				    		var nodeKey = childList[x].data.key.split('|');
				    		
				    		//console.log(nodeKey[0]+"|"+(x+1));
				    		NodeID.push(nodeKey[0]+"|"+(x+1)); //�̵��� ���������� ��� node �� sortNum�� �迭�� ����
				    		
				    	}
			        	jQuery.ajaxSettings.traditional = true; //Array �ѱ�� ajax setting �ʼ�
			    		
			    		//ID���� sortNum�� update
			    		
			    		$.ajax({
							url : "<%= request.getContextPath()%>/H_Group.do?cmd=changeGroupSort",
							type : "post",
							dataType : "text",
							async : true,
							data : {
								"NodeID" : NodeID,
								"JobGb" : 1,	//���� ��ġ �̵��϶� ó�� ����
								"UpNodeID" : upNodeKey[0],
								"Step" : upNodeKey[1],
								"SelectNodeID" : selectNodeKey[0]
							},
							success : function(data, textStatus, XMLHttpRequest){
								if(data == "1"){
									parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+upNodeKey[0]+'&GroupStep='+upNodeKey[1];
								}else{
									alert("�׷� �̵� ����!");
								}
								//console.log(data);
							},
							error : function(request, status, error){
								alert("code :"+request.status + "<br>message :" + request.responseText);
							}
						});
			        }//if else ��
			        }//confirm ��
			    	
			   	 }
			}
			
			
		});

		var rootNode = $("#tree").dynatree("getRoot");
		<%
		if(grouplist.size() > 0){
			int i = 0;
			String cateid="";
			String upcateid="";
			String searchResult="0";
			String userid="";
			boolean folderYN = false;
			boolean checked = false;
			int test = 0;
			for(int j=0; j < grouplist.size(); j++ ){	
				int totalCnt = 0;
				GroupDTO dto = grouplist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				
				//Tree ����
				
				if(j == 0){
				
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getGroupName()%>",
						tooltip: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getGroupStep()%>|<%=dto.getGroupName()%>",
						icon : '<%= request.getContextPath() %>/css/skin-vista/folder_docs.gif'
					});
				<%
				}else{
					
					//�������� �ƴ��� ����
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getGroupName()%>",
						tooltip: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getGroupStep()%>|<%=dto.getGroupName()%>"
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
		


				
	});

	
	
	function selectNode(id, step,name, key){
		//�ش� GroupID�� �˻��� �ش� GroupID�� Step, name�� �����´�.
		$.ajax({
			url : "<%= request.getContextPath()%>/H_Group.do?cmd=selectGroupInfo",
			type : "post",
			dataType : "text",
			async : false,
			data : {
				"GroupID" : id
			},
			success : function(data, textStatus, XMLHttpRequest){
				parent.group.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupView&GroupID='+id;
		    	parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+id+'&GroupStep='+data;
		    	parent.NodeKey.value= key;
		    	
		    	
			},
			error : function(request, status, error){
				alert("code :"+request.status + "<br>message :" + request.responseText);
			}
		});
		
		
		

		
		
		<%-- if(userid==''){
			return;
		}
		if(folderYN == "User"){
			parent.$('#evNm').html('<dt id="jobTitle">�򰡴�� ���� ����Ʈ</dt><dt> - �򰡴���� : '+userNm+'</dt>');
			parent.evaluationList.location.href='<%=request.getContextPath()%>/H_Evaluation.do?cmd=jobPageList&UserID='+userid;
		}else{
			return;
		} --%>
		    
		  
	  }
	
	function updateGroup(data, key ,groupName){
		//console.log(key);
		var insertGroup = data.split("|");
		var nodeKey = key.split("|");
		
		$("#tree").dynatree("getRoot").visit(function(node){
			if(node.data.key == key){
				var insertNode = node.addChild({
					title: groupName,
					tooltip: groupName,
					isFolder: true,
					key : data
				});	
			}
		});
		
	}
	
	function deleteGroup(data, groupid){
		$("#tree").dynatree("getRoot").visit(function(node){
			
			var key = node.data.key.split("|");
			
			//�ش� group�� tree���� �����ϰ� ����
			//return false ���� �� ����
			if(groupid == key[0]){
				node.remove();
				return false;
			}
		});
	}
	
	function modifyGroup(data, groupid, groupName){
		$("#tree").dynatree("getRoot").visit(function(node){
			
			var key = node.data.key.split("|");
			
			//�ش� group�� tree���� �����ϰ� ����
			//return false ���� �� ����
			if(groupid == key[0]){

				node.data.title = groupName;
				node.render();
				return false;
			}
		});
	}
	
</script>
</head>

<body>
<form>
	<p class="dynatreeT">
		<a href="#" id="btnToggleExpand">��� ��ġ��</a>
		|
		<a href="#" id="btnToggleExpand2">��� ����</a>
	</p>
	<div id="tree" style="margin-left:-8px; width: 225px; width: 323px\9; width: 225px\0/IE8+9; height: 405px; height: 393px\9; height: 403px\0/IE8+9;" name="selNodes">
		
	</div>
	</form>
	
</body>
</html>
<script>
//��ȸ����� ���� ���� ���� ����ó��
</script>
<%-- </head>
<body id="dtree" style="">

<form name="treeFrm">
  <div class="dtree">
    <p>
      <a href="javascript: d.openAll();">��� ��ġ��</a>
      |
      <a href="javascript: d.closeAll();">��� ����</a>
    </p>
    <script type="text/javascript">
	    function goGroup(groupid,step){
	    
	    	names=eval("document.all.selectName");
	    	checkes=eval("document.all.checkName");

	    	for(i=0;i<names.length;i++){

	    		if(names[i].title==groupid){
	    			names[i].style.fontWeight="bold";
			    	names[i].style.color="#F63";
			    	checkes[i].checked=true;
	    		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
			    	checkes[i].checked=false;
	    		}
	    	}
	    	
	    	parent.group.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupView&GroupID='+groupid;
	    	parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+groupid+'&GroupStep='+step;

	    	
	    }
		<!--
		d = new dTree('d');	
		d.clearCookie();
		<%	
		if(arrlist.size() > 0){	

		String cateid="";
		String upcateid="";
		String searchResult="";

			for(int j=0; j < arrlist.size(); j++ ){	
				GroupDTO dto = arrlist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				searchResult=dto.getSearchResult();

				cateid=cateid.substring(1);
				upcateid=upcateid.substring(1);

	    %>
		d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" id=upCateId class="chk" name="checkName" onClick=goGroup("<%=dto.getGroupID()%>","<%=dto.getGroupStep()%>"); ><a href=javascript:goGroup("<%=dto.getGroupID()%>","<%=dto.getGroupStep()%>")><font  id=selectName title=<%=dto.getGroupID()%> ><%=dto.getGroupName()%></font></a>','#','','','images/tree/folder.gif');	
		<%
			}
		}
		%>
		document.write(d);
		//-->
	</script>
  </div>
</form>
</body>
</html>
<script>
<%	
if(arrlist.size() > 0){	

String searchResult="";

	for(int k=0; k < arrlist.size(); k++ ){	
		GroupDTO dto = arrlist.get(k);

		searchResult=dto.getSearchResult();

		if(0<k && k<arrlist.size()-1 && searchResult.equals("1")){
			%>
			d.o(<%=k%>);	
			<%
		}
	}
}
%>
goGroup("<%=GroupID%>",<%=GroupStep%>);
d.openAll();
</script> --%>