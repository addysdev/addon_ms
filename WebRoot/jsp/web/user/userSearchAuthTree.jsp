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
String FormName = (String)model.get("FormName");
String UserID   = (String)model.get("UserID");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<title>조회권한선택</title>
<link href="<%= request.getContextPath() %>/css/popupLy.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.dynatree-1.2.4.js"/>
<link href="<%= request.getContextPath() %>/css/skin/ui.dynatree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	$("#tree<%=FormName%>2").dynatree({
		checkbox: false, //체크박스 주기
		selectMode :3, //체크박스 모드
		fx: { height: "toggle", duration: 100 },
		autoCollapse: true,
		clickFolderMode : 1, //폴더 클릭 옵션
		minExpandLevel : 2, //최초 보일 레벨
		onActivate : function(node){
			
			$('#<%=FormName%> #searchAuth').val(node.data.title);
			$('#<%=FormName%> #searchAuthID').val(node.data.key);
			$('#userSearchAuthForm').dialog('close');
			$('#userSearchAuthForm2').dialog('close');
		}
		
	});

	var rootNode = $("#tree<%=FormName%>2").dynatree("getRoot");
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
						icon : '<%= request.getContextPath() %>/images/tree/base.gif'
					});
				<%
				}else{
					if(cateid.equals("G99999")){
						%>
						var <%=cateid%> = rootNode.addChild({
							title: "<%=dto.getGroupName()%>",
							//tooltip: "<%=dto.getGroupName()%>",
							isFolder: true,
							key : "<%=cateid%>",
							icon : '<%= request.getContextPath() %>/images/tree/base.gif'
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
			<div id="tree<%=FormName%>2" style="margin-top:10px; margin-left:-8px; width: 250px; width: 248px\9; width: 250px\0/IE8+9; height: 215px; height: 203px\9; height: 213px\0/IE8+9;" name="selNodes"></div>
			<iframe class="sbBlind sbBlind_userGroupTree"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
	</form>		
</body>
</html>