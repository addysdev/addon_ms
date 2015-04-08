<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> arrlist = (ArrayList)model.get("steplist");
String GroupID = (String)model.get("GroupID");
String GroupStep = (String)model.get("GroupStep");
String t_retVal = StringUtil.nvl((String)model.get("t_retVal"),"");
%>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"></script>
<script>
	function groupModifyForm(index, groupID){
		
		
		
		//var arrgroupdata = $('[id=groupdata]');//document.getElementsByName("groupdata");
		//var arrM_groupdata = document.getElementsByName("M_groupdata");
		//var arrM_groupRow = document.getElementsByName("groupRow");
		
		$('[id=groupRow]').eq(index).attr("class","selected"); //arrM_groupRow[index].className="selected";
		
		$('[id=groupdata]').eq(index).attr("style","display:none;"); //arrgroupdata[index].style.display = "none";
		$('[id=M_groupdata]').eq(index).attr("style","display:block;");  //arrM_groupdata[index].style.display = "block";
		
		var name = $('[name=group'+groupID+'] .groupName').text();
		$('[name=M_group'+groupID+'] [name=GroupName]').val(name);
		
		$('#chk'+groupID).val("0");
		$('#alert'+groupID).html("");
		
		
		
	}
	function groupCancel(index){
		
		/*
		var arrgroupdata = document.getElementsByName("groupdata");
		var arrM_groupdata = document.getElementsByName("M_groupdata");
		var arrM_groupRow = document.getElementsByName("groupRow");
		*/
		
		$('[id=groupRow]').eq(index).attr("class",""); //arrM_groupRow[index].className="";
		$('[id=groupdata]').eq(index).attr("style","display:block;");  //arrgroupdata[index].style.display = "block";
		$('[id=M_groupdata]').eq(index).attr("style","display:none;");  //arrM_groupdata[index].style.display = "none";
		
	}
	
	//�ش� �׷� ����
	function groupDelet(groupID){
		
		
		/* var frm=document.groupListForm;
		var groupid;
		
		if(frm.GroupID.length>1){
			
			groupid=frm.GroupID[index].value;	
		}else{
			groupid=frm.GroupID.value;
		} */

		if(confirm("���� ������ ���������� ������ �Ҽӵ� ����ڵ� �Բ� �����˴ϴ�.\n���� ���� �Ͻðڽ��ϱ�?")){

		}else{
			return;
		}
		
		var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=D';
		var result=0;
		
		$.ajax({
			url : requestUrl,
			type : "post",
			dataType : "text",
			async : false,
			data : {
				"GroupID" : groupID,
				"GroupName" : ""
			},
			success : function(data, textStatus, XMLHttpRequest){
				//console.log(data);
				var group = data.split("|");
				
				<%-- parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+group[0]+'&GroupStep='+group[1]; --%>
				parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+group[0]+'&GroupStep='+group[1];
				parent.tree.deleteGroup(data, groupID);
				
			},
			error : function(request, status, error){
				//alert("code :"+request.status + "<br>message :" + request.responseText);
				alert("�׷� ���� ����!");
			}
		});	
		
		<%-- var groupid='';
		var groupstep=1;
		
		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
	
	
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);
	
		resultText = xmlhttp.responseText;
	
		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
		
		result=xmlObject.documentElement.childNodes.item(0).text;
		groupid=xmlObject.documentElement.childNodes.item(1).text;
		groupstep=xmlObject.documentElement.childNodes.item(2).text;
	
		if(groupid!=null){
			alert('���������� �����߽��ϴ�.');
	    	parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
		}else{
			alert('���������� �����߽��ϴ�. �����ڿ��� �����ϼ���!');
		} --%>
		
	
}
function groupModify(index, groupID){
	
	var chkVal = $('#chk'+groupID).val();
	
	if(chkVal == 0){
		$('#alert'+groupID).html("<font color='red'>�����ϰų� �̹� ��� ���� �׷���Դϴ�.</font>");
		$('#chk'+groupID).val("0");
		return;
	}else if(chkVal == 1){
		if(confirm("���� ������ ������ �Ҽӵ� ����ڵ��� ���������� �Բ� �����˴ϴ�.\n���� ���� �Ͻðڽ��ϱ�?")){

		}else{
			return;
		}	
		
		var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=U';
		var groupName = $('[name=M_group'+groupID+'] [name=GroupName]').val();
		$.ajax({
			url : requestUrl,
			type : "post",
			dataType : "text",
			async : false,
			data : {
				"GroupID" : groupID,
				"GroupName" : encodeURIComponent(groupName)
			},
			success : function(data, textStatus, XMLHttpRequest){
				var group = data.split("|");
				
				<%-- parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+group[0]+'&GroupStep='+group[1]; --%>
				parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+group[0]+'&GroupStep='+group[1];
				parent.tree.modifyGroup(data, groupID, groupName);
				
				
			},
			error : function(request, status, error){
				//alert("code :"+request.status + "<br>message :" + request.responseText);
				alert("�׷� ���� ����!");
			}
		});	
	}
	<%-- var frm=document.groupListForm;
	var groupid='';
	var groupstep=1;
	var groupname;
	var result;
	
	if(frm.GroupID.length>1){	
		groupid=frm.GroupID[index].value;	
		groupname=frm.GroupName[index].value;
	}else{
		groupid=frm.GroupID.value;
		groupname=frm.GroupName.value;
	}
	
	result=parent.doCheck(groupname);
	
	if(result==1){
		alert('�����Ͻ� �������� �̹� ������Դϴ�.');
		return;
	}else if(result==2){
		alert('�����Ͻ� �������� ���������� �ֽ��ϴ�.');
		return;
	}

	if(confirm("���� ������ ������ �Ҽӵ� ����ڵ��� ���������� �Բ� �����˴ϴ�.\n���� ���� �Ͻðڽ��ϱ�?")){

	}else{
		return;
	}	
	
	var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=U&GroupID='+groupid+'&GroupName='+groupname;
	var result=0;
	var groupid='';
	var groupstep=1;
	
	var xmlhttp = null;
	var xmlObject = null;
	var resultText = null;


	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlhttp.open("GET", requestUrl, false);
	xmlhttp.send(requestUrl);

	resultText = xmlhttp.responseText;

	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	xmlObject.loadXML(resultText);
	
	result=xmlObject.documentElement.childNodes.item(0).text;
	groupid=xmlObject.documentElement.childNodes.item(1).text;
	groupstep=xmlObject.documentElement.childNodes.item(2).text;

	if(groupid!=null){
		alert('���� ������ �����߽��ϴ�.');
		parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
	}else{
		alert('���������� �����߽��ϴ�. �����ڿ��� �����ϼ���!');
		parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
	} --%>
	
}


//�ǽð� ������ üũ
function checkName(data, groupid){
	
	var ori_name = $('[name=group'+groupid+'] .groupName').text();
	var mod_name = $('[name=M_group'+groupid+'] [name=GroupName]').val();
	
	if(ori_name == mod_name){
		$('#alert'+groupid).html("<font color='black'>������ �׷���Դϴ�.</font>");
		$('#chk'+groupid).val("0");
		return;
	}else if(mod_name == ""){
		$('#alert'+groupid).html("<font color='black'>�׷���� �Է��Ͽ� �ּ���.</font>");
		$('#chk'+groupid).val("0");
		return;
	}else{
		$.ajax({
			url : "<%= request.getContextPath()%>/H_Group.do?cmd=checkGroupName",
			type : "post",
			dataType : "text",
			async : false,
			data : {
				"GroupName" : encodeURIComponent(data.value)
			},
			success : function(data, textStatus, XMLHttpRequest){
				if(data == 1){
					$('#alert'+groupid).html("<font color='red'>�̹� ��ϵ� �׷���Դϴ�.</font>");
					$('#chk'+groupid).val("0");
				}else if(data == 2){
					$('#alert'+groupid).html("<font color='red'>�̹� ��ϵ� �׷���Դϴ�.</font>");
					$('#chk'+groupid).val("0");
				}else if(data == 0){
					$('#alert'+groupid).html("<font color='blue'>��� ������ �׷���Դϴ�.</font>");
					$('#chk'+groupid).val("1");
				}
			},
			error : function(request, status, error){
				//alert("code :"+request.status + "<br>message :" + request.responseText);
				alert("�׷� ���� ����!");
			}
		});		
	}
}

</script>
<body>
<form name="groupListForm" method="post" >
  <div class="groupList_box">
    <ul class="list">
      <%	if(arrlist.size() > 0){
                      for(int j=0; j < arrlist.size(); j++ ){	
                          GroupDTO dto = arrlist.get(j);	
  %>
      <input type="hidden" name="GroupID" value="<%=dto.getGroupID()%>">
      <!-- ���ý� �� ���򺯰� class="selected" -->

      <li id="groupRow" class="">
        <!-- ���� -->
        <ul id="groupdata" class="group" style="display:block" name="group<%=dto.getGroupID()%>">
          <li class="groupId"><%=dto.getGroupID() %></li>
          <li class="bar">|</li>
          <li class="groupEdit"><a href="javascript:groupModifyForm(<%=j%>, '<%=dto.getGroupID()%>')">����</a></li>
          <li class="bar">|</li>
          <li class="groupDel"><a href="javascript:groupDelet('<%=dto.getGroupID()%>')">����</a></li>
          <li class="bar">|</li>
          <li class="groupName"><%=dto.getGroupName() %></li>
        </ul>
        <!-- //���� -->
        <!-- ���� -->
        <ul id="M_groupdata" class="group" style="display:none" name="M_group<%=dto.getGroupID()%>">
          <li class="groupId"><%=dto.getGroupID() %></li>
          <li class="bar">|</li>
           <li class="groupSave"><a href="javascript:groupModify(<%=j%>,'<%=dto.getGroupID()%>')">Ȯ��</a></li>
          <li class="bar">|</li>
          <li class="groupCancel"><a href="javascript:groupCancel(<%=j%>)">���</a></li>
          <li class="bar">|</li>
          <li class="groupName_modify">
            <input name="GroupName" type="text" class="in_txt" style="padding-top:4px; height:20px;" 
            value="<%=dto.getGroupName() %>" onkeyup="checkName(this, '<%=dto.getGroupID()%>')"/>
            <input type="hidden" name="chk<%=dto.getGroupID()%>" id="chk<%=dto.getGroupID()%>"/>
          </li>
          <li id="alert<%=dto.getGroupID()%>"></li>
         
        </ul>
        <!-- ���� -->
      </li>
      <!-- ���� -->
      <%
                                }
                            }
              %>
    </ul>
  </div>
</form>
</body>
<!-- //����Ʈ -->
