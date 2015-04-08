<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%

ArrayList<GroupDTO> grouplist = (ArrayList)model.get("grouplist");
//String AuthID=(String)model.get("AuthID");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>소속관리</title>
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
			minExpandLevel : 2, //최초 보일 레벨,
			onClick : function(node){
				
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
				*/
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
			
			for(int j=0; j < grouplist.size(); j++ ){	
				GroupDTO dto = grouplist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				
				
				//cateid=cateid.substring(1);
				//upcateid=upcateid.substring(1);
				
				searchResult = dto.getSearchResult();
				if("1".equals(searchResult)){
					checked = true;
				}else{
					checked = false;
				}
				
				//Tree 생성
				if(j == 0){
				%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getGroupName()%>",
						tooltip: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>|<%=dto.getGroupName()%>|Folder",
						icon : '<%= request.getContextPath() %>/images/tree/base.gif'
					});
				<%
				}else{
					//폴더인지 아닌지 정의
					if(dto.getUserID().equals("")){
							%>
							var <%=cateid%> = <%=upcateid%>.addChild({
								title: "<%=dto.getGroupName()%>",
								tooltip: "<%=dto.getGroupName()%>",
								isFolder: true,
								key : "<%=cateid%>|<%=dto.getGroupName()%>|Folder"
							});
							<%
						}else{
					%>
							<%=upcateid%>.addChild({
								title: "<%=dto.getGroupName()%>",
								tooltip: "<%=dto.getGroupName()%>",
								key : "<%=dto.getUserID()%>|<%=dto.getGroupName()%>|User",
								icon : '<%=request.getContextPath()%>/images/tree/people.gif'
							});
					<%	
					}
					
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
	
		
		//사용자 선택시 선택명 효과및 사용자메뉴권한 트리 팝업을 해준다.
		function selectUser(userid,groupname){
			//alert(userid +" / "+groupname);
			
			if(userid == ''){
				return;
			}else{
				parent.tabYN='Y';
				
				parent.userInfo.location.href='<%= request.getContextPath() %>/H_Auth.do?cmd=userAuthMenuTree&userid='+userid;
				parent.$('#userInfoLayer').show();
				parent.$('.tap_open').hide();
				
				
				//var userInfoLayer= parent.document.getElementsByName("userInfoLayer");
				//userInfoLayer[0].style.display="block";
				
			}
			
			
			
			
		  }
				
	});

	
	
	
</script>
</head>

<body>
<form>
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
	<div id="tree"  style="width: 100%; height: 415px;" name="selNodes" >
		
	</div>
	</form>
</body>
</html>

<%-- 
</head>

<body>
<form name="treeFrm">
<div class="dtree">
	<p><a href="javascript: d.openAll();">모두 펼치기</a> | <a href="javascript: d.closeAll();">모두 접기</a></p>
	<script type="text/javascript">
		<!--
		var openWin=0;//사용자 메뉴권한 트리 팝업객체
		
		//선택카테고리의 하위카테고리를 체킹한다
		function selectCheck(cateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//상위카테고리
			var cateids=eval("document.all.cateId");//카테고리

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==cateid){
					document.treeFrm.checkName[i].checked=objcheck;	
				}

			}
			
			for(j=0;j<upcateids.length;j++){
			
				if(document.treeFrm.checkName[j].checked==true){
					
					subSelectCheck(cateids[j].value,objcheck);
					if(objcheck==false){
					document.treeFrm.checkName[j].checked=false;
					}
				}
			}
		}
		//하위카테고리 체킹함수
		function subSelectCheck(cateid,objcheck){
			
			var upcate=cateid;
			var upcateids=eval("document.all.upCateId");//상위카테고리
			var cateids=eval("document.all.cateId");//카테고리

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==upcate){				
					upcate=cateid;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		
		//사용자별 메뉴권한 창 팝업
		function goPopup(userid){
			
		   var url='<%= request.getContextPath() %>/H_Auth.do?cmd=userAuthMenuTree&userid='+userid+'&AuthID=<%=AuthID%>';
		
		   var top, left, scroll;
		   var width='352';
		   var height='560';
		   
			if(scroll == null || scroll == '')	scroll='0';
				top	 = 150;
				left = 1000;

			var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

			if(openWin != 0) {
				  openWin.close();
			}
			openWin = window.open(url, 'POP', option);
		}
		//사용자 선택시 선택명 효과및 사용자메뉴권한 트리 팝업을 해준다.
		function selectUser(userid,groupname){
		
			if(userid==''){
				return;
			}
			   
			  	names=eval("document.all.fontId");
			
			  	for(i=0;i<names.length;i++){
			
			  		if(names[i].title==userid){
			  		names[i].style.fontWeight="bold";
			    	names[i].style.color="green";
			    	//document.treeFrm.checkName[i].checked=true;	
			  		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
			    	//document.treeFrm.checkName[i].checked=false;	
			  		}
			  	}
			  	goPopup(userid);//사용자 메뉴권한 팝업
		  }

		d = new dTree('d');
		d.clearCookie();
		<%	

		if(grouplist.size() > 0){	
		int i = 0;
		String cateid="";
		String upcateid="";
		String searchResult="0";
		String userid="";
		String userIcon=",'','','','images/tree/folder.gif'";

			for(int j=0; j < grouplist.size(); j++ ){	
				GroupDTO dto = grouplist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				
				cateid=cateid.substring(1);
				upcateid=upcateid.substring(1);
				
				searchResult=dto.getSearchResult();
				
				userid=dto.getUserID();
				
				if(!userid.equals("")){//그룹이 아닌 사용자의 경우 사용자 이미지로 표기해준다.
					userIcon=",'#','','','images/tree/people.gif'";
				}else{
					userIcon=",'#','','','images/tree/folder.gif'";
				}

	    %>
		//트리구성
	    d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" value="<%=upcateid%>" id=upCateId style="vertical-align : bottom" name="checkName" onClick=selectCheck("<%=cateid%>",this) ><input type=hidden id=cateId value="<%=cateid%>" ><font onClick=selectUser("<%=dto.getUserID()%>","<%=dto.getGroupName()%>"); id=fontId  title=<%=dto.getUserID()%> ><%=dto.getGroupName()%></font>' <%=userIcon%> );
		

		<%
			}
		}
		%>
		//트리생성
		document.write(d);
		//-->
	</script>
</div>
</form>
</body>
</html>
<script>
//조회결과에 따라 상위 폴더 오픈처리
<%	
if(grouplist.size() > 0){	

String userId="";
String searchResult="0";

	for(int k=0; k < grouplist.size(); k++ ){	
		GroupDTO dto = grouplist.get(k);

		//searchResult=dto.getSearchResult();
		userId=dto.getUserID();
		
		//System.out.println("[searchResult]:"+searchResult+":[카테고리명]:"+dto.getGroupName()+":[사용자 ID]:"+userId);
		if(0<k && k<grouplist.size() && searchResult.equals("1")){
			if(userId.equals("")){
				//System.out.println(dto.getGroupName()+"<<<연다.>>>");
				%>
				d.o(<%=k%>);	
				<%
			}else{
				//System.out.println(dto.getGroupName()+"<<<선택한다.>>>");
				%>
				selectUser('<%=dto.getUserID()%>','<%=dto.getGroupName()%>');
				<%
			}
		}
	}
}
%>
d.closeAll();//기본 트리를 전체오픈시킨다.
parent.document.UserSearchFrm.UserID.focus();
</script>
 --%>