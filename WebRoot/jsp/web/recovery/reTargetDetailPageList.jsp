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

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>회수 대상 상세현황</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// 커서  색상 처리 시작

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}
function goRecovery(){
	
	var frm = document.RecoveryDetailForm;

	if(frm.seqs.length>1){
		for(i=0;i<frm.seqs.length;i++){
			frm.seqs[i].value=fillSpace(frm.ProductCode[i].value)+
			'|'+fillSpace(frm.recoveryCnt[i].value)+'|'+fillSpace(frm.stockCnt[i].value)+
			'|'+fillSpace(frm.lossAddCnt[i].value)+'|'+fillSpace(frm.memo[i].value)+'|'+fillSpace(frm.StockDate[i].value);
		}
	}else{
		
		frm.seqs.value=fillSpace(frm.ProductCode.value)+
		'|'+fillSpace(frm.recoveryCnt.value)+'|'+fillSpace(frm.stockCnt.value)+
		'|'+fillSpace(frm.lossAddCnt.value)+'|'+fillSpace(frm.memo.value)+'|'+fillSpace(frm.StockDate.value);

	}

	if(!confirm("회수 처리 하시겠습니까?\n회수코드는 회수리스트에서 다운 가능합니다."))
		return;

	openWaiting();
	frm.submit();
	goClosePop('reTargetDetailPageList');
	
}

function loosAddCal(index){

	var recovery=0;
	var loss=0;
	var frm=document.RecoveryDetailForm;

	if(frm.recoveryCnt.length>1){
		
		recovery=parseInt(frm.PreStockCnt[index].value);

		if(frm.lossAddCnt[index].value=='' || frm.lossAddCnt[index].value=='-'){
			loss=0;
		}else{
			loss=parseInt(frm.lossAddCnt[index].value,10);
	
		}
		
		frm.recoveryCnt[index].value=recovery+loss;
		
		if(frm.recoveryCnt[index].value < 0){
			
			alert('재고수량 보다 더 적게 가감하실 수 없습니다.');
			frm.recoveryCnt[index].value=frm.PreStockCnt[index].value;
			frm.lossAddCnt[index].value =0;
			return;
			
		}
		document.getElementById("recovery_"+index).innerText=frm.recoveryCnt[index].value;
		
	}else{
		
		recovery=parseInt(frm.PreStockCnt.value);
		

		if(frm.lossAddCnt.value=='' || frm.lossAddCnt.value=='-'){
			loss=0;
		}else{
			loss=parseInt(frm.lossAddCnt.value,10);
	
		}

		frm.recoveryCnt.value=recovery+loss;
		
		if(frm.recoveryCnt.value < 0){
			
			alert('재고수량 보다 더 적게 가감하실 수 없습니다.');
			frm.recoveryCnt.value=frm.PreStockCnt.value;
			frm.lossAddCnt.value =0;
			return;
			
		}
		document.getElementById("recovery_"+index).innerText=frm.recoveryCnt.value;
	}

	
}

//커서  색상 처리 끝
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<%=ld.getPageScript("RecoveryDetailForm", "curPage", "goPage")%>
<body   <%=BODYEVENT %>  class="body_bgAll">
	<form method="post" name=RecoveryDetailForm action="<%=request.getContextPath()%>/H_Recovery.do?cmd=recoveryProcess">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<input type="hidden" name="GroupID" value="<%=GroupID%>">
		<input type="hidden" name="CompanyCode" value="<%=companyDto.getCompanyCode()%>">
		<input type="hidden" name="GroupName" value="<%=GroupName%>">
<!-- 레이아웃 시작 -->
<div class="ly_pop_new">
	<!-- 테이블 : 시작 -->
	<div id="code_origin">
	<br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>회수 대상 업체정보</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>회수 대상 업체정보</caption>
            <thead>
                <tr>
                    <th   scope="col" >업체명</th>
                    <th   scope="col" >전화</th>
                    <th   scope="col" >핸드폰(SMS)</th>
                    <th   scope="col" >Email</th>
                    <th   scope="col" >FAX</th>
                    <th   scope="col" >담당자</th>
                    <th   scope="col" >납품장소</th>
                </tr>
            </thead>
            <tbody>
             <tr style="cursor:hand;background-color:#FAFAFA;" >                  
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
      <h3>&nbsp;<a href="javascript:goRecovery()"><img src="<%=request.getContextPath()%>/images/addys-btn_add_02.gif" title="회수" /></a>
     </h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>회수 대상 상세현황</caption>
            <thead>
                <tr>
                    <th   scope="col" >번호</th>
                    <th   scope="col" >제조사</th>
                    <th   scope="col" >상품명</th>
                    <th   scope="col" >재고<br>현황</th>
                    <th   scope="col" >가감<br>수량</th>
                    <th   scope="col" >메모</th>
                    <th   scope="col" >회수<br>수량</th>
                    <th   scope="col" >재고<br>일자</th>
                </tr>
            </thead>
            <tbody>
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			int ordercnt=0;
			int stockcnt=0;
			int safestock=0;
			
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
				stockcnt=ds.getInt("StockCnt");
				safestock=ds.getInt("SafeStock");
				ordercnt=safestock-stockcnt;
		%>
		
				 <input type="hidden" name="seqs" >
		        
		         <input type="hidden" name="ProductCode" value="<%=ds.getString("ProductCode")%>">
		         <input type="hidden" name="PreStockCnt"  value="<%=stockcnt%>">
                 <input type="hidden" name="recoveryCnt"  value="<%=stockcnt%>">
                 <input type="hidden" name="stockCnt" value="<%=stockcnt%>">  
                 <input type="hidden" name="StockDate" value="<%=ds.getString("StockDate")%>">

                <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                  
                    <td style="cursor: pointer" >
                    <p><%=i+1%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("Group1Name")%></p></td>              
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("ProductName")%></p></td>
                    <td style="cursor: pointer" >
                    <p><%=stockcnt%></p></td>
                     <td style="cursor: pointer" >
                    <p> <input type="text" size="2" name="lossAddCnt" id="lossadd_<%=i%>"  maxlength="3" value="0"  dispName="" onKeyUp="loosAddCal('<%=i %>')" /></p></td>
                    <td style="cursor: pointer" >
                    <p> <input type="text" size="30" name="memo" id="memo_<%=i%>"  maxlength="100" value=""  dispName="" /></p></td>
                     <td style="cursor: pointer"   >
                     <p id="recovery_<%=i%>" ><%=stockcnt%></p></td>               
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("StockDateFomat")%></p></td>
                </tr>
                
             <!-- :: loop :: -->
			<%
				i++;
					}
				} else {
			%>
			<tr>
				<td colspan="10" >회수대상 상세현황 이력이 없습니다.</td>
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
