<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.util.StringUtil"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	String ProductCode= (String) model.get("ProductCode");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����������</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}

function goSafeProcSave(index){
	
	if(document.getElementById("ProcYN_"+index).value=='Y'){
		
		if(confirm("������� ������ ���� �Ͻðڽ��ϱ�?")){
			
		}else{
			return;
		}
		
	}else{
		
		if(confirm("������ ���·� �ٲٽðڽ��ϱ�?\n����� ������� ������ 0 �� �˴ϴ�.")){
			document.getElementById("SafeStock_"+index).value=0;
		}else{
			return;
		}
		
	}

	//jQuery Ajax
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Master.do?cmd=safeStockSave",
		type : "post",
		dataType : "text",
		async : true,
		data : {
			"GroupID" : $('#GroupID_'+index).val() ,
			"ProductCode" 		: "<%=ProductCode%>",
			"SafeStock" 		: $('#SafeStock_'+index).val() ,
			"ProcYN" 		: $('#ProcYN_'+index).val()
		},
		success : function(data, textStatus, XMLHttpRequest){
			if(data ==1){ //Update Success
				alert("������� ���� ������ �����߽��ϴ�.");
			}else{
				alert("������� ���� ������ �����߽��ϴ�.");
			}
		},
		error : function(request, status, error){
			alert("code :"+request.status + "\r\nmessage :" + request.responseText);
		}
	});

}

</script>
</head>

<body   <%=BODYEVENT %>  class="body_bgAll">
<!-- ���̾ƿ� ���� -->
<div class="ly_pop_new" >
	<!-- ���̺� : ���� -->
	<div id="code_origin">
    <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>����������</caption>
            <thead>
                <tr>
                    <th   scope="col" >������</th>
                    <th   scope="col" >����������</th>
                    <th   scope="col" >���࿩��</th>
                    <th   scope="col" >������</th>
                </tr>
            </thead>
            <tbody>
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {	
				
				//�ο���󺯰� ����
				int num = 0;
				String rowClass="";
				String SuccessYN="";
                String DisconnectResultCode="";
                String proselectedy="";
                String proselectedn="";
				
				num = i % 2;
				
				if(num==1){
					rowClass="#FAFAFA";
				
				}else{
					rowClass="#FFFFFF";
					
				}
				//�ο���󺯰� ��
		%>
                <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                  
                    <td style="cursor: pointer" >
                    <input type="hidden" name="GroupID_<%=i %>" id="GroupID_<%=i %>" value="<%=ds.getString("GroupID")%>">
                    <p><%=ds.getString("GroupName")%>(<%=ds.getString("GroupID")%>)</p></td>
                     <td style="cursor: pointer" >
                    <p>
                    <input type="text" size="5" name="SafeStock_<%=i %>" id="SafeStock_<%=i %>" maxlength="3" value="<%=ds.getInt("SafeStock")%>"  style="IME-MODE : disabled"/>
                    <td style="cursor: pointer" >
                    <p>
                    <%
                    	if("N".equals(ds.getString("ProcYN"))){
                    		proselectedy="";
                    		proselectedn="selected";
                    	}else{
                    		proselectedy="selected";
                    		proselectedn="";
                    	}
                    %>
                    <Select name="ProcYN_<%=i %>" id="ProcYN_<%=i %>">
                    	<option value="Y" <%=proselectedy %>>����</option>
                    	<option value="N"  <%=proselectedn %>>������</option>
                    </Select>
                     <td style="cursor: pointer" >
                    <p>
                      <a href="javascript:goSafeProcSave('<%=i %>','<%=ds.getString("GroupID")%>');"><img src="<%=request.getContextPath()%>/images/btn_lypop_save.gif" title="����"></a></p></td>   
                    </tr>
             <!-- :: loop :: -->
			<%
				i++;
					}
				} else {
			%>
			<tr>
				<td colspan="4" >������� �̷��� �����ϴ�.</td>
			</tr>
			<%
				}
			%>
            </tbody>
        </table>
  </div>
</body>
</html>
