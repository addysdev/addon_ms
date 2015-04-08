<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> arrlist = (ArrayList)model.get("grouplist");
String Gubun=(String)model.get("Gubun");

boolean bLogin = BaseAction.isSession(request);			
UserMemDTO dtoUser = new UserMemDTO();					
if(bLogin == true)
	dtoUser = BaseAction.getSession(request);

String userId=StringUtil.nvl(dtoUser.getUserId(),"");//사용자 계정
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>조회권한 선택</title>
<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree.js"/></script>
<script type="text/javascript">
	
	$(function(){
		
		$("#tree").dynatree({
			checkbox: false, //체크박스 주기
			//selectMode :3, //체크박스 모드
			fx: { height: "toggle", duration: 100 },
			autoCollapse: false,
			clickFolderMode : 1, //폴더 클릭 옵션
			minExpandLevel : 2, //최초 보일 레벨
			onClick : function(node){
				var key = node.data.key.split("|");
				//선택정보를 꺼내서 액션처리
				//selectNode(key[0],key[1],key[2], node.data.key);
			},
			onDblClick : function(node){
				var key = node.data.key.split("|");
				//선택정보를 꺼내서 액션처리
				selectNode(key[0],key[1],key[2], node.data.key);
			},
			activeVisible : true,
				
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
			        if(node.parent !== sourceNode.parent){
			          return false;
			        }
			        // Don't allow dropping *over* a node (would create a child)
			        return ["before", "after"];
			      },
			      onDrop: function(node, sourceNode, hitMode, ui, draggable) {
			    	//$('#test').text(sourceNode.parent.childList);
			        /** This function MUST be defined to enable dropping of items on
			         *  the tree.
			         */
			      }
			}
		});
	
		var rootNode = $("#tree").dynatree("getRoot");
		<%
		if(arrlist.size() > 0){
			int i = 0;
			String cateid="";
			String upcateid="";
			
			for(int j=0; j < arrlist.size(); j++ ){	
				GroupDTO dto = arrlist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				
				//Tree 생성
				if(j == 0){
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getGroupName().replace("\n", "<br>")%>",
						tooltip: "<%=dto.getGroupName().replace("\n", "<br>")%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getGroupStep()%>|<%=dto.getGroupName()%>",
						icon : '<%= request.getContextPath() %>/css/skin-vista/folder_docs.gif'
					});
				<%
				}else{
					if(cateid.equals(userId)){
							%>
							var <%=cateid%> = rootNode.addChild({
								title: "<%=dto.getGroupName()%>",
								//tooltip: "<%=dto.getGroupName()%>",
								isFolder: true,
								key : "<%=cateid%>|<%=dto.getGroupStep()%>|<%=dto.getGroupName()%>",
								icon : '<%= request.getContextPath() %>/images/tree/base.gif'
							});
							<%
						}else{
							%>
							var <%=cateid%> = <%=upcateid%>.addChild({
								title: "<%=dto.getGroupName()%>",
								//tooltip: "<%=dto.getGroupName()%>",
								isFolder: true,
								key : "<%=cateid%>|<%=dto.getGroupStep()%>|<%=dto.getGroupName()%>"
							});
	
							<%	
						}
					}
			}
		}
		%>
		
		$("#btnToggleOpen").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		
		$("#btnToggleClose").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
	});
	
	//선택노드처리
	function selectNode(id, step,name, key){
	 
		 groupSelect(id,name);	
	
		 $('#authGroupTree').dialog('close');
	 }

</script>
</head>

<body>
<form>
	<p class="dynatreeT" style="padding:0 0 10px 0;">
	    <br>
		<a href="#" id="btnToggleOpen">모두 펼치기</a>
		|
		<a href="#" id="btnToggleClose">모두 접기</a>
	</p>
	<div id="tree" style="margin-left:-8px; width: 290px; height: 300px; name="selNodes">
	<iframe class="sbBlind sbBlind_authGroupSelectTree"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
	</div>
	</form>
</body>
</html>