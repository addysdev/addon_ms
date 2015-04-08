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
<title>그룹관리</title>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree.js"/></script>
	<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function(){
		$("#tree").dynatree({
			checkbox: false, //체크박스 주기
			selectMode :3, //체크박스 모드
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 1, //폴더 클릭 옵션
			minExpandLevel : 2, //최초 보일 레벨
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
			        
			        //최상위 폴더에는 들어가지 않도록 체크
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
			        		message = "["+upNodeName[2]+"] 의 아래로 ["+nodeName[2]+"] 그룹을 이동하시겠습니까?";
							break;
			        	}
			        	case "before" : {
			        		message = "["+upNodeName[2]+"] 의 위로 ["+nodeName[2]+"] 그룹을 이동하시겠습니까?";
							break;
			        	}
			        	case "over" : {
			        		message = "["+upNodeName[2]+"] 의 안으로 ["+nodeName[2]+"] 그룹을 이동하시겠습니까?";
							break;
			        	}
			        }
			        
			        if(confirm(message)){
			        	
			         
			        
			        sourceNode.move(node, hitMode);
			        
			        /**
			         * sourceNode는 드래그하는 대상
			         * node는 드래그해서 들어가는 대상
			         */
			        
			        //해당 들어가는 상위 폴더의 key값
			        /*
			        console.log(sourceNode.parent.data.key);
			       	console.log(node.parent.data.key);
			        console.log(sourceNode.parent);
			        console.log(node);
			        */
			        //console.log(hitMode);

			        //이동하는 대상의 상위폴더가 같은 경우
			        if(hitMode == "after" || hitMode == "before"){
			        	
			        	var childList = sourceNode.parent.childList; //이동하는 폴더의 상위 폴더내의 개수
				    	var NodeID = new Array(); 
			        	
				    	var upNodeKey = node.parent.data.key.split('|');
				    	var selectNodeKey = sourceNode.data.key.split('|');
				    	
			        	for(var x=0; x<childList.length; x++){
			        		
				    		var nodeKey = childList[x].data.key.split('|');
				    		
				    		//console.log(nodeKey[0]+"|"+(x+1));
				    		NodeID.push(nodeKey[0]+"|"+(x+1)); //이동된 상위폴더의 모든 node 와 sortNum을 배열로 저장
				    		
				    	}
			        	jQuery.ajaxSettings.traditional = true; //Array 넘길시 ajax setting 필수
			    		
			    		//ID값과 sortNum을 update
			    		
			    		$.ajax({
							url : "<%= request.getContextPath()%>/H_Group.do?cmd=changeGroupSort",
							type : "post",
							dataType : "text",
							async : true,
							data : {
								"NodeID" : NodeID,
								"JobGb" : 1,	//같은 위치 이동일때 처리 구분
								"UpNodeID" : upNodeKey[0],
								"Step" : upNodeKey[1],
								"SelectNodeID" : selectNodeKey[0]
							},
							success : function(data, textStatus, XMLHttpRequest){
								if(data == "1"){
									parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+upNodeKey[0]+'&GroupStep='+upNodeKey[1];
								}else{
									alert("그룹 이동 실패!");
								}
								//console.log(data);								
							},
							error : function(request, status, error){
								alert("code :"+request.status + "<br>message :" + request.responseText);
							}
						});
			        	
			        	
			        //상위폴더 안으로 이동 시
			        }else if(hitMode == "over"){
			        	
			        	var childList = sourceNode.parent.childList; //이동하는 폴더의 상위 폴더내의 개수
				    	var NodeID = new Array(); 
			        	
				    	var upNodeKey = node.data.key.split('|'); 
				    	var selectNodeKey = sourceNode.data.key.split('|');
				    	
			        	for(var x=0; x<childList.length; x++){
			        		
				    		var nodeKey = childList[x].data.key.split('|');
				    		
				    		//console.log(nodeKey[0]+"|"+(x+1));
				    		NodeID.push(nodeKey[0]+"|"+(x+1)); //이동된 상위폴더의 모든 node 와 sortNum을 배열로 저장
				    		
				    	}
			        	jQuery.ajaxSettings.traditional = true; //Array 넘길시 ajax setting 필수
			    		
			    		//ID값과 sortNum을 update
			    		
			    		$.ajax({
							url : "<%= request.getContextPath()%>/H_Group.do?cmd=changeGroupSort",
							type : "post",
							dataType : "text",
							async : true,
							data : {
								"NodeID" : NodeID,
								"JobGb" : 1,	//같은 위치 이동일때 처리 구분
								"UpNodeID" : upNodeKey[0],
								"Step" : upNodeKey[1],
								"SelectNodeID" : selectNodeKey[0]
							},
							success : function(data, textStatus, XMLHttpRequest){
								if(data == "1"){
									parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+upNodeKey[0]+'&GroupStep='+upNodeKey[1];
								}else{
									alert("그룹 이동 실패!");
								}
								//console.log(data);
							},
							error : function(request, status, error){
								alert("code :"+request.status + "<br>message :" + request.responseText);
							}
						});
			        }//if else 끝
			        }//confirm 끝
			    	
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
				
				//Tree 생성
				
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
					
					//폴더인지 아닌지 정의
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
		//해당 GroupID로 검색후 해당 GroupID의 Step, name을 가져온다.
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
			parent.$('#evNm').html('<dt id="jobTitle">평가대상 업무 리스트</dt><dt> - 평가대상자 : '+userNm+'</dt>');
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
			
			//해당 group을 tree에서 삭제하고 종료
			//return false 없을 시 오류
			if(groupid == key[0]){
				node.remove();
				return false;
			}
		});
	}
	
	function modifyGroup(data, groupid, groupName){
		$("#tree").dynatree("getRoot").visit(function(node){
			
			var key = node.data.key.split("|");
			
			//해당 group을 tree에서 삭제하고 종료
			//return false 없을 시 오류
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
		<a href="#" id="btnToggleExpand">모두 펼치기</a>
		|
		<a href="#" id="btnToggleExpand2">모두 접기</a>
	</p>
	<div id="tree" style="margin-left:-8px; width: 225px; width: 323px\9; width: 225px\0/IE8+9; height: 405px; height: 393px\9; height: 403px\0/IE8+9;" name="selNodes">
		
	</div>
	</form>
	
</body>
</html>
<script>
//조회결과에 따라 상위 폴더 오픈처리
</script>
<%-- </head>
<body id="dtree" style="">

<form name="treeFrm">
  <div class="dtree">
    <p>
      <a href="javascript: d.openAll();">모두 펼치기</a>
      |
      <a href="javascript: d.closeAll();">모두 접기</a>
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