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
<title>재고상세현황</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// 커서  색상 처리 시작

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}

//커서  색상 처리 끝
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
<!-- 레이아웃 시작 -->
<div class="ly_pop_new">
	<!-- 테이블 : 시작 -->
	<div id="code_origin">
    <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>재고상세현황</caption>
            <thead>
                <tr>
                    <th   scope="col" >품목코드</th>
                    <th   scope="col" >품목명</th>
                    <th   scope="col" >재고수량</th>
                </tr>
            </thead>
            <tbody>
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {	
				
				//로우색상변경 시작
				int num = 0;
				String rowClass="";
				
				num = i % 2;
				
				if(num==1){
					rowClass="#FAFAFA";
				
				}else{
					rowClass="#FFFFFF";
					
				}
				//로우색상변경 끝
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
				<td colspan="3" >재고상세현황 이력이 없습니다.</td>
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
