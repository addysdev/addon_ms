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
		var openWin=0;//����� �޴����� Ʈ�� �˾���ü
		
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck(cateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

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
		//����ī�װ� üŷ�Լ�
		function subSelectCheck(cateid,objcheck){
			
			var upcate=cateid;
			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==upcate){				
					upcate=cateid;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		
		//����ں� �޴����� â �˾�
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
		//����� ���ý� ���ø� ȿ���� ����ڸ޴����� Ʈ�� �˾��� ���ش�.
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
			  	goPopup(userid);//����� �޴����� �˾�
		  }

		d = new dTree('d');
		d.clearCookie();
		
		d.add('AUTH','-1','����','','','','images/tree/folder.gif' );
		
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
		//Ʈ������
	    d.add('<%=cateid%>','<%=upcateid%>','<input type="checkbox" value="<%=upcateid%>" id=upCateId style="vertical-align : bottom" name="checkName" onClick=selectCheck("<%=cateid%>",this) ><input type=hidden id=cateId value="<%=cateid%>" ><font onClick=selectUser("<%=dto.getCode()%>","<%=dto.getName()%>"); id=fontId  title=<%=dto.getCode()%> ><%=dto.getName()%></font>' <%=userIcon%> );

		<%
			}
		}
		%>
		//Ʈ������
		document.write(d);
		//-->
	</script>
</div>
</form>
</body>
</html>
<script>
d.openAll();//�⺻ Ʈ���� ��ü���½�Ų��.
</script>
