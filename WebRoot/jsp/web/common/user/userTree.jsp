<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%
ArrayList<GroupDTO> grouplist = (ArrayList)model.get("grouplist");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>�׷����</title>
	<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body>
<form name="treeFrm">
<div class="dtree">
	<p><a href="javascript: d.openAll();">��� ��ġ��</a> | <a href="javascript: d.closeAll();">��� ����</a></p>
	<script type="text/javascript">
		<!--
		//����� ���ý� ���ø� ȿ���� ����� ���̵�� �׷���� opener�� �������ش�.
		 function selectUser(userid,groupname){
			
			if(userid==''){
				return;
			}
		    
	    	names=eval("document.all.fontId");

	    	for(i=0;i<names.length;i++){

	    		if(names[i].title==userid){
	    			names[i].style.fontWeight="bold";
			    	names[i].style.color="green";
	    		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
	    		}
	    	}

            if(parent.opener.USER_ID==userid){
            	
            	alert('�̰�����ڰ� �����ΰ� ������� �̰��� �Ұ��� �մϴ�.');
            	return;
            }
	    	parent.opener.userSet(userid,groupname);//opener �� ����� ���� ����
	    	parent.close();
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
				
				if(!userid.equals("")){//�׷��� �ƴ� ������� ��� ����� �̹����� ǥ�����ش�.
					userIcon=",'#','','','images/tree/people.gif'";
				}else{
					userIcon=",'#','','','images/tree/folder.gif'";
				}

	    %>
		//Ʈ������
	    d.add('<%=cateid%>','<%=upcateid%>','<font onClick=selectUser("<%=dto.getUserID()%>","<%=dto.getGroupName()%>"); id=fontId title=<%=dto.getUserID()%> ><%=dto.getGroupName()%></font>' <%=userIcon%> );
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
//��ȸ����� ���� ������ �����ش�
<%	
if(grouplist.size() > 0){	

String userId="";
String searchResult="";

	for(int k=0; k < grouplist.size(); k++ ){	
		GroupDTO dto = grouplist.get(k);

		searchResult=dto.getSearchResult();
		userId=dto.getUserID();
		
	//	System.out.println("[searchResult]:"+searchResult+":[ī�װ���]:"+dto.getGroupName()+":[����� ID]:"+userId);
		if(0<k && k<grouplist.size() && searchResult.equals("1")){
			if(userId.equals("")){
				//System.out.println(dto.getGroupName()+"<<<����.>>>");
				%>
				d.o(<%=k%>);	
				<%
			}else{
				//System.out.println(dto.getGroupName()+"<<<�����Ѵ�.>>>");
				%>
				selectUser('<%=dto.getUserID()%>','<%=dto.getGroupName()%>');	
				<%
			}
		}
	}
}
%>
parent.document.UserSearchFrm.UserID.focus();
</script>
