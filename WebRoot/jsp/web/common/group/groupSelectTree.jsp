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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<title>그룹선택</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree.js"/>
<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	$('#tree2 a').hover(function(){
		alert('123');
	});
	
	$("#tree2").dynatree({
		checkbox: false, //체크박스 주기
		selectMode :3, //체크박스 모드
		fx: { height: "toggle", duration: 100 },
		autoCollapse: true,
		clickFolderMode : 1, //폴더 클릭 옵션
		minExpandLevel : 2, //최초 보일 레벨
		onActivate : function(node){
			$('#StatisticsForm #GroupName').val(node.data.title);
			$('#StatisticsForm #GroupID').val(node.data.key);
			$('#GroupPop').dialog('close');
		}
		
	});

	var rootNode = $("#tree2").dynatree("getRoot");
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
					//tooltip: "<%=dto.getGroupName()%>",
					isFolder: true,
					key : "<%=cateid%>",
					icon : '<%= request.getContextPath() %>/css/skin-vista/folder_docs.gif'
				});
			<%
			}else{
				if(cateid.equals("G00000")){
					%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getGroupName()%>",
						//tooltip: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>",
						icon : '<%= request.getContextPath() %>/css/skin-vista/folder_docs.gif'
					});
					<%
				}else{
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getGroupName()%>",
						//tooltip: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>"
					});

					<%					
				}
			}
		}
	}
	%>
	
	
	
			
});

</script>
</head>
<body>
	<form action="">
			<div id="tree2" style="margin-top:18px; margin-left:-8px; width: 250px; width: 248px\9; width: 250px\0/IE8+9; height: 215px; height: 203px\9; height: 213px\0/IE8+9;" name="selNodes"></div>
	</form>		
</body>
</html>