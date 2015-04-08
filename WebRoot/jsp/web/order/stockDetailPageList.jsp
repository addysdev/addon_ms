<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.util.StringUtil"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%

	String curPage = (String) model.get("curPage");
	String stockdate = (String) model.get("stockdate");
	String groupid = (String) model.get("groupid");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>������Ȳ</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}

//Ŀ��  ���� ó�� ��
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<%=ld.getPageScript("StockDetailFrom", "curPage", "goPage")%>
<body   <%=BODYEVENT %>  class="body_bgAll">
	<form method="post" name=StockDetailFrom action="<%=request.getContextPath()%>/H_Order.do?cmd=stockDetailPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<input type="hidden" name="stockdate" value="<%=stockdate%>">
		<input type="hidden" name="groupid" value="<%=groupid%>">
<!-- ���̾ƿ� ���� -->
<div class="ly_pop_new">
	<!-- ���̺� : ���� -->
	<div id="code_origin">
    <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>������Ȳ</caption>
            <thead>
                <tr>
                    <th   scope="col" >ǰ���ڵ�</th>
                    <th   scope="col" >ǰ���</th>
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
                    <p><%=ds.getString("ProductCode")%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("ProductName")%></p></td>              
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("StockCnt")%></p></td>
                </tr>
             <!-- :: loop :: -->
			<%
				i++;
					}
				} else {
			%>
			<tr>
				<td colspan="3" >������Ȳ �̷��� �����ϴ�.</td>
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
