<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.ComCodeDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
ArrayList<ComCodeDTO> authlist = (ArrayList)model.get("authlist");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>소속관리</title>
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
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
		function goPopup(authid){
			
		   var url='<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuDetailTree&authid='+authid;
		
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
		
		d.add('AUTH','-1','권한','','','','images/tree/folder.gif' );
		
		<%	

		if(authlist.size() > 0){	
		int i = 0;
		String cateid="";
		String upcateid="AUTH";
		String searchResult="0";
		String userid="";
		String userIcon=",'','','','images/tree/folder.gif'";

			for(int j=0; j < authlist.size(); j++ ){	
				ComCodeDTO dto = authlist.get(j);
				
				cateid=dto.getCode();
				
	    %>
		//트리구성
	    d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" value="<%=upcateid%>" id=upCateId style="vertical-align : bottom" name="checkName" onClick=selectCheck("<%=cateid%>",this) ><input type=hidden id=cateId value="<%=cateid%>" ><font onClick=selectUser("<%=dto.getCode()%>","<%=dto.getName()%>"); id=fontId  title=<%=dto.getCode()%> ><%=dto.getName()%></font>' <%=userIcon%> );

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
d.openAll();//기본 트리를 전체오픈시킨다.
</script>
