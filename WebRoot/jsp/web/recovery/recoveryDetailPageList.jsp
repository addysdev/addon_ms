<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.util.StringUtil"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.config.CompanyDTO"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%

	String curPage = (String) model.get("curPage");
    CompanyDTO companyDto = (CompanyDTO) model.get("companyDto");
    String GroupID = (String) model.get("GroupID");
    String GroupName = (String) model.get("GroupName");
    String RecoveryCode = (String) model.get("RecoveryCode");
  
    String IngYN = (String) model.get("IngYN");
    String RegYN = (String) model.get("RegYN");
    
    String UseGroupID=(String) model.get("UseGroupID");
    
    String displayy="";
	String displayn="";
	String displayExport="none";
	String displaySave="none";
	
	if("N".equals(RegYN)){
		displayy="none";
		displayn="inline";
		if("Y".equals(IngYN) && "G00000".equals(UseGroupID)){
			displaySave="inline";
			displayExport="inline";
		}
	}else{
		displayy="inline ";
		displayn="none";
		if("Y".equals(IngYN) && "G00000".equals(UseGroupID)){
			displaySave="none";
			displayExport="inline";
		}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>ȸ�� ��� ����Ȳ</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}

function goRecoveryProcSave(index){

	if(!confirm('['+$('#ProductName_'+index).val()+"] �� ���� ȸ��ó���� �Ϸ��Ͻðڽ��ϱ�?")){
		return;
	}
    var checkVal='Y';
    
	//jQuery Ajax
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Recovery.do?cmd=recoveryProcSave",
		type : "post",
		dataType : "text",
		async : true,
		data : {
			"RecoveryCode" : "<%=RecoveryCode%>",
			"ProductCode"		: $('#ProductCode_'+index).val(),
			"RecoveryResultCnt" : $('#RecoveryResultCnt_'+index).val(),
			"RecoveryCheck" 		: checkVal ,
			"RecoveryMemo"		: encodeURIComponent($('#RecoveryMemo_'+index).val())
		},
		success : function(data, textStatus, XMLHttpRequest){
			if(data =='Y' || data=='N'){ //Update Success
				alert("������ �����߽��ϴ�.");
				document.getElementById("procimage_"+index).src='<%=request.getContextPath()%>/images/btn_change.gif';
				
				if(data =='Y'){		//��üó������ Ȯ��(��ϿϷ��ΰ��)
					
					document.getElementById("recoveryCreateId").style.display='inline';
					document.getElementById("SaveProcId").style.display='inline';

				}
			}else{
				alert("������ �����߽��ϴ�.");
			}
		},
		error : function(request, status, error){
			alert("code :"+request.status + "\r\nmessage :" + request.responseText);
		}
	});
}
function goRegResult(){
	
	if(!confirm('���ó���� �Ϸ� �Ͻðڽ��ϱ�?\nó���Ͻ� ȸ�� ������ ������ �Ұ����մϴ�.')){
		return;
	}

	//jQuery Ajax
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Recovery.do?cmd=recoveryProcClose",
		type : "post",
		dataType : "text",
		async : true,
		data : {
			"RecoveryCode" : "<%=RecoveryCode%>"
		},
		success : function(data, textStatus, XMLHttpRequest){

			if(data =='1'){ //Update Success
				alert("�Ϸ�ó���� �����߽��ϴ�.");
			
				document.getElementById("SaveProcId").style.display='none';
			
				if(document.RecoveryDetailFrom.ProductCode.length>1){
					for (i=0; i< document.RecoveryDetailFrom.ProductCode.length;i++){
						
							document.getElementById("RecoveryResultCntN_"+i).style.display='none';
							document.getElementById("RecoveryMemoN_"+i).style.display='none';
							document.getElementById("RecoveryResultN_"+i).style.display='none';
							
							document.getElementById("RecoveryResultCntY_"+i).style.display='inline';
							document.getElementById("RecoveryMemoY_"+i).style.display='inline';
							document.getElementById("RecoveryResultY_"+i).style.display='inline';
					}
				}else{
						document.getElementById("RecoveryResultCntN_0").style.display='none';
						document.getElementById("RecoveryMemoN_0").style.display='none';
						document.getElementById("RecoveryResultN_0").style.display='none';
						
						document.getElementById("RecoveryResultCntY_0").style.display='inline';
						document.getElementById("RecoveryMemoY_0").style.display='inline';
						document.getElementById("RecoveryResultY_0").style.display='inline';
				}

			}else{
				alert("�Ϸ�ó���� �����߽��ϴ�.");
			}
		},
		error : function(request, status, error){
			alert("code :"+request.status + "\r\nmessage :" + request.responseText);
		}
	});

	
}
function goRecoveryExcel(){
	
	alert('���� �غ���');
	return;
	var frm = document.RecoveryDetailFrom;
	frm.action = "<%=request.getContextPath()%>/H_Order.do?cmd=recoveryExcelDetailPageList";	
	frm.method = "POST";
	frm.submit();
	
}
//Ŀ��  ���� ó�� ��
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<%=ld.getPageScript("RecoveryDetailFrom", "curPage", "goPage")%>
<body   <%=BODYEVENT %>  class="body_bgAll">
	<form method="post" name=RecoveryDetailFrom  id=RecoveryDetailFrom action="<%=request.getContextPath()%>/H_Recovery.do?cmd=recoveryDetailPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">
<!-- ���̾ƿ� ���� -->
<div class="ly_pop_new">
	<!-- ���̺� : ���� -->
	<div id="code_origin">
	<br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>ȸ�� ��� ��ü ����</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
     <caption>ȸ�� ��� ��ü ����</caption>
            <thead>
                <tr>
                    <th   scope="col" >��ü��</th>
                    <th   scope="col" >��ȭ</th>
                    <th   scope="col" >�ڵ���(SMS)</th>
                    <th   scope="col" >Email</th>
                    <th   scope="col" >FAX</th>
                    <th   scope="col" >�����</th>
                    <th   scope="col" >��ǰ���</th>
                </tr>
            </thead>
            <tbody>
             <tr style="cursor:hand;background-color:#FAFAFA;" >    
              <input type="hidden" name="CompanyName"  value="<%=companyDto.getCompanyName()%>">  
              <input type="hidden" name="CompanyPhone"  value="<%=companyDto.getCompanyPhone()%>">   
              <input type="hidden" name="ChargeName"  value="<%=companyDto.getChargeName()%>"> 
              <input type="hidden" name="GroupName"  value="<%=GroupName%>">      

                    <td>
                    <p><%=companyDto.getCompanyName()%></p></td>
                     <td>
                    <p><%=companyDto.getCompanyPhone()%></p></td>
                    <td>
                    <p><%=companyDto.getMobilePhone()%></p></td>
                    <td>
                    <p><%=companyDto.getEmail()%></p></td>
                    <td>
                    <p><%=companyDto.getFaxNumber() %></td>
	                </p></td>
                    <td>
                    <p><%=companyDto.getChargeName()%></p></td>
                    <td>
                    <p><%=GroupName%></p></td>
                </tr>
            </tbody>
        </table>
  	</div>
	<br>
	</br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>
      
    <font style="fontWeight:bold; color:blue" ><a href="javascript:goRecoveryExcel()"  id="recoveryCreateId" style="display:<%=displayExport%>">[ȸ�� ����Ʈ ����]</a>
   <a href="javascript:goRegResult()" id="SaveProcId" style="display:<%=displaySave%>"><img src="<%=request.getContextPath()%>/images/btn_lypop_save.gif" title="��ϿϷ�" /></a></font> 
   <font style="fontWeight:bold; color:blue" ><a href="<%=request.getContextPath()%>/fileDownServlet?ServerID=99&filePath=Recovery&sFileName=<%=RecoveryCode%>.html"><img src="<%=request.getContextPath()%>/images/addys-btn_add_05.gif" title="ȸ���ڵ�ٿ�ε�" /></a></font> 
	</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>ȸ�� ��� ����Ȳ</caption>
            <thead>
                <tr>
                    <th   scope="col" >��ȣ</th>
                    <th   scope="col" >������</th>
                    <th   scope="col" >��ǰ��</th>
                    <th   scope="col" >���<br>��Ȳ</th>
                    <th   scope="col" >����<br>����</th>
                    <th   scope="col" >ȸ��<br>����</th>
                    <th   scope="col" >ȸ��<br>�޸�</th>
                    <th   scope="col" >���<br>����</th>
                    <th   scope="col" >���<br>�޸�</th>
                    <th   scope="col" >ó��</th>
                </tr>
            </thead>
            <tbody>
		<%
		if (ld.getItemCount() > 0) {
			
			int i = 0;
			
			String imagename="btn_lypop_save.gif";
			
			while (ds.next()) {	
				
				//�ο���󺯰� ����
				int num = 0;
	
				
				String rowClass="";
				
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
                    <p><%=i+1%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("Group1Name")%></p></td>              
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("ProductName")%></p></td>
                    <td style="cursor: pointer" >
                    <p> <%=ds.getInt("StockCnt")%></p></td>
                    <td style="cursor: pointer" >
                    <p> <%=ds.getInt("LossAddCnt")%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getInt("RecoveryCnt")%></p></td>
                    <td style="cursor: pointer" >
                    <p> <%=ds.getString("Memo")%></p></td>
                    <input type="hidden" name="ProductCode" id="ProductCode_<%=i %>" value="<%=ds.getString("ProductCode")%>">
                    <input type="hidden"  id="ProductName_<%=i %>" value="<%=ds.getString("ProductName")%>">
                    <%
                    
	                   if("N".equals(ds.getString("RecoveryCheck"))){
	                	   imagename="btn_save.gif";
		               	}else{
		               	  imagename="btn_change.gif";
		               	}
	                 %>
	                 <td style="cursor: pointer"  id="RecoveryResultCntY_<%=i %>" style="display:<%=displayy%>">
                    <p> <%=ds.getInt("RecoveryResultCnt")%></p></td>
                     <td style="cursor: pointer"  id="RecoveryMemoY_<%=i%>"  style="display:<%=displayy%>" >
                    <p> <%=ds.getString("RecoveryMemo")%></p></td>
                    <td style="cursor: pointer"  id="RecoveryResultY_<%=i %>"   style="display:<%=displayy%>">
                    <p>ȸ���Ϸ�</p></td>   
                    
                     
                     
                     <td style="cursor: pointer"   id="RecoveryResultCntN_<%=i%>" style="display:<%=displayn%>">
                     <p> <input type="text" size="2" name="RecoveryResultCnt" id="RecoveryResultCnt_<%=i%>"  maxlength="3" value="<%=ds.getInt("RecoveryResultCnt")%>"  dispName="" onKeyUp="recoveryCal('<%=i %>')"  /></p></td>
                     <td style="cursor: pointer" id="RecoveryMemoN_<%=i%>"  style="display:<%=displayn%>">
                    <p> <input type="text" size="15" name="RecoveryMemo" id="RecoveryMemo_<%=i%>"  maxlength="100" value="<%=ds.getString("RecoveryMemo")%>"   dispName="" /></p></td>
              
              
                    
                     <td style="cursor: pointer"   id="RecoveryResultN_<%=i %>" style="display:<%=displayn%>">
                    <p>
                      <a href="javascript:goRecoveryProcSave('<%=i %>');"><img id="procimage_<%=i %>" src="<%=request.getContextPath()%>/images/<%=imagename %>" title="ó��"></a></p></td>   
                    
                   </tr>

             <!-- :: loop :: -->
			<%
				i++;
					}
				} else {
			%>
			<tr>
				<td colspan="10" >ȸ����� ����Ȳ �̷��� �����ϴ�.</td>
			</tr>
			<%
				}
			%>
            </tbody>
        </table>
  	</div>
  </div>
  </div>
  </form>
</body>
</html>

