<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
ArrayList<GroupDTO> arrlist = (ArrayList)model.get("grouplist");
String GroupID = (String)model.get("GroupID");
String GroupStep = (String)model.get("GroupStep");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>�׷� Ʈ��</title>
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body>
<form name="treeFrm">
<div class="dtree">
	<p><a href="javascript: d.openAll();">��� ��ġ��</a> | <a href="javascript: d.closeAll();">��� ����</a></p>
	<script type="text/javascript">
		<!--
		//�׷� ���ý� ���ø� ȿ���� �׷���̵�� �׷���� opener�� �������ش�.
	    function selectGroup(groupid,groupname){
	    
	    	names=eval("document.all.fontId");

	    	for(i=0;i<names.length;i++){

	    		if(names[i].title==groupid){
	    			names[i].style.fontWeight="bold";
			    	names[i].style.color="green";
	    		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
	    		}
	    	}
	    	
	    	parent.opener.groupSet(groupid,groupname);//openr�� �׷��� �������ش�.
	    	parent.close();
	    }

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
	    //Ʈ������
		d.add('<%=cateid%>','<%=upcateid%>','<font onClick=selectGroup("<%=dto.getGroupID()%>","<%=dto.getGroupName()%>"); id=fontId title=<%=dto.getGroupID()%> ><%=dto.getGroupName()%></font>','#','','','images/tree/folder.gif');	
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
//��ȸ����� ���� ���� ���� ����ó��
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
</script>