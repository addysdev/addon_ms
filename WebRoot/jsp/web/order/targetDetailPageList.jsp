<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.util.StringUtil"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.util.DateUtil"%>
<%@ page import ="com.web.common.config.CompanyDTO"%>
<%@ include file="/jsp/web/common/base.jsp"%>

<%

	String curPage = (String) model.get("curPage");
    CompanyDTO companyDto = (CompanyDTO) model.get("companyDto");
    String GroupID = (String) model.get("GroupID");
    String GroupName = (String) model.get("GroupName");
    
    String toDate =  DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-");
    String deliveryDate = DateUtil.getDayInterval2(1);
    

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>발주 대상 상세현황</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">
$(document).ready(function(){
	$('#calendarData').datepicker({
		maxDate:0,
		prevText: "이전",
		nextText: "다음",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["일","월","화","수","목","금","토"],
		monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		changeMonth: true,
	    changeYear: true
	});
});
function showCalendars(){
	
	   $('#calendarData').datepicker("show");
}

// 커서  색상 처리 시작

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}
function goOrder(){
	
	var frm = document.OrderDetailFrom;

	if(frm.seqs.length>1){
		for(i=0;i<frm.seqs.length;i++){
			frm.seqs[i].value=fillSpace(frm.ProductCode[i].value)+
			'|'+fillSpace(frm.orderCnt[i].value)+'|'+fillSpace(frm.etc[i].value)+'|'+fillSpace(frm.stockCnt[i].value)+
			'|'+fillSpace(frm.safeStockCnt[i].value)+'|'+fillSpace(frm.lossCnt[i].value)+'|'+fillSpace(frm.addCnt[i].value)+
			'|'+fillSpace(frm.memo[i].value)+'|'+fillSpace(frm.Group1Name[i].value)+'|'+fillSpace(frm.ProductName[i].value)+'|'+fillSpace(frm.StockDate[i].value);
		}
	}else{
		
		frm.seqs.value=fillSpace(frm.ProductCode.value)+
		'|'+fillSpace(frm.orderCnt.value)+'|'+fillSpace(frm.etc.value)+'|'+fillSpace(frm.stockCnt.value)+
		'|'+fillSpace(frm.safeStockCnt.value)+'|'+fillSpace(frm.lossCnt.value)+'|'+fillSpace(frm.addCnt.value)+
		'|'+fillSpace(frm.memo.value)+'|'+fillSpace(frm.Group1Name.value)+'|'+fillSpace(frm.ProductName.value)+'|'+fillSpace(frm.StockDate.value);

	}
	
	if(frm.email.checked==true){	
		
		frm.EmailKey.value='Y';
		
		if(frm.emailaddr.value==''){
			
			alert('발주 대상 이메일 주소가 없습니다.');
			return;
		}
		
		if(frm.fax.checked==true){	
			
			frm.FAXKey.value='Y';
			
			if(frm.faxnum.value==''){
				
				alert('발주 대상 FAX 번호가 없습니다.');
				return;
			}
			
			if(!confirm("발주 처리 하시겠습니까?\n발주서는 이메일["+frm.emailaddr.value+"]  과\n팩스번호["+frm.faxnum.value+"]  로 전송됩니다."))
				return;
			
		}else{
		
			frm.FAXKey.value='N';
			
			if(!confirm("발주 처리 하시겠습니까?\n발주서는 이메일["+frm.emailaddr.value+"]  로 전송됩니다."))
				return;
			
		}


	}else{
		
		frm.EmailKey.value='N';

		if(frm.fax.checked==true){	
				
				frm.FAXKey.value='Y';
				
				if(frm.faxnum.value==''){
					
					alert('발주 대상 FAX 번호가 없습니다.');
					return;
				}
				
				if(!confirm("발주 처리 하시겠습니까?\n발주서는 팩스번호["+frm.faxnum.value+"]  로 전송됩니다."))
					return;
				
			}else{
			
				frm.FAXKey.value='N';
				
				if(!confirm("발주 처리 하시겠습니까?\n발주서는 발주리스트에서 다운 가능합니다."))
					return;
				
			}
			
	}
	openWaiting();
	frm.submit();
	goClosePop('targetDetailPageList');
	
}

function loosAddCal(index){

	var order=0;
	var loss=0;
	var frm=document.OrderDetailFrom;
	
	if(frm.orderCnt.length>1){
		
       order=parseInt(frm.PreOrderCnt[index].value);

		if(frm.lossCnt[index].value=='' || frm.lossCnt[index].value=='-'){
			loss=0;
		}else{
			loss=parseInt(frm.lossCnt[index].value,10);
	
		}
		
		frm.orderCnt[index].value=order+loss;
		
		if(frm.orderCnt[index].value < 0){
			
			alert('주문수량 보다 더 적게 가감하실 수 없습니다.');
			frm.orderCnt[index].value=frm.PreOrderCnt[index].value;
			frm.lossCnt[index].value =0;
			return;
			
		}
		document.getElementById("order_"+index).innerText=frm.orderCnt[index].value;
		
	}else{
		
		order=parseInt(frm.PreOrderCnt.value);
		

		if(frm.lossCnt.value=='' || frm.lossCnt.value=='-'){
			loss=0;
		}else{
			loss=parseInt(frm.lossCnt.value,10);
	
		}

		frm.orderCnt.value=order+loss;
		
		if(frm.orderCnt.value < 0){
			
			alert('주문수량 보다 더 적게 가감하실 수 없습니다.');
			frm.orderCnt.value=frm.PreOrderCnt.value;
			frm.lossCnt.value =0;
			return;
			
		}
		document.getElementById("order_"+index).innerText=frm.orderCnt.value;
	}

	
}

//커서  색상 처리 끝
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<%=ld.getPageScript("OrderDetailFrom", "curPage", "goPage")%>
<body   <%=BODYEVENT %>  class="body_bgAll">
<form method="post" name=OrderDetailFrom action="<%=request.getContextPath()%>/H_Order.do?cmd=orderProcess">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<input type="hidden" name="GroupID" value="<%=GroupID%>">
		<input type="hidden" name="CompanyCode" value="<%=companyDto.getCompanyCode()%>">
		<input type="hidden" name="FAXKey" value="N">
		<input type="hidden" name="EmailKey" value="Y">
		<input type="hidden" name="SMSKey" value="N">
<!-- 레이아웃 시작 -->
<div class="ly_pop_new">
	<!-- 테이블 : 시작 -->
	<div id="code_origin">
	<br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>발주 대상 업체정보</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>발주 대상 업체정보</caption>
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
              <input type="hidden" name="CompanyName"  value="<%=companyDto.getCompanyName()%>">  
              <input type="hidden" name="CompanyPhone"  value="<%=companyDto.getCompanyPhone()%>">   
              <input type="hidden" name="GroupName"  value="<%=GroupName%>">             
                    <td>
                    <p><%=companyDto.getCompanyName()%></p></td>
                     <td>
                    <p><%=companyDto.getCompanyPhone()%></p></td>
                    <td>
                    <p><input type="text" size="13" name="mobilephone" id="mobilephone" maxlength="20" value="<%=companyDto.getMobilePhone()%>"  dispName="모바일번호"  onKeyUp="format_phone(this);" /></p></td>
                    <td>
                    <p><input type="text" size="15" name="emailaddr" id="emailaddr"  maxlength="50" value="<%=companyDto.getEmail()%>"  dispName="" /></p></td>
                    <td>
                    <p> <input type="text" size="13" name="faxnum" maxlength="14" value="<%=companyDto.getFaxNumber() %>" tabindex="4" dispName="팩스번호" onKeyUp="format_phone(this);"/></td>
	                </p></td>
                    <td>
                    <p><input type="text" size="13" name="ChargeName" id="ChargeName"  maxlength="20" value="<%=companyDto.getChargeName()%>"  dispName="담당자" /></p></td>
                    <td>
                    <p><%=GroupName%></p></td>
                </tr>
                 <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                   <th>납품일자</th>
                    <td >
                    <p><input type="text" size="11" name="deliveryDate"  value="<%=deliveryDate %>" id="calendarData" dispName="날짜" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);"/>
                    	<!-- 달력이미지 시작 -->
						<span class="icon_calendar"><img border="0" onclick="showCalendars()" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
						<!-- 달력이미지 끝 -->
                    </p></td>
                   <th>납품방법</th>
                    <td colspan="2">
                    <p><input type="text" size="25" name="orderMethod" maxlength="100" value="택배배송"/></td>
                    <th>참조</th>
                    <td>
                    <p><input type="text" size="11" name="orderEtc" maxlength="100" value=""/></td>
                </tr>
                <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                    <th>비고</th>
                     <td colspan="2">
                    <p><input type="text" size="60" name="totalEtc" maxlength="100" value=""/></p></td>
                    <th>배송주소</th>
                    <td colspan="3">
                    <p><input type="text" size="70" name="deliveryAddr" maxlength="100" value=""/></td>
                </tr>
            </tbody>
        </table>
  	</div>
	<br>
	</br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3><input name="fax" type="checkbox"  disabled /> FAX <input name="email" type="checkbox"  checked/> Email <input name="sms" type="checkbox"  disabled/> SMS  &nbsp;<a href="javascript:goOrder()"><img src="<%=request.getContextPath()%>/images/addys-btn_add_01.gif" title="발주" /></a>
	</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>발주 대상 상세현황</caption>
            <thead>
                <tr>
                    <th   scope="col" >번호</th>
                    <th   scope="col" >제조사</th>
                    <th   scope="col" >상품명</th>
                    <th   scope="col" >비고</th>
                    <th   scope="col" >안전<br>재고</th>
                    <th   scope="col" >재고<br>현황</th>
                    <th   scope="col" >가감<br>수량</th>
                    <th   scope="col" >손실<br>수량</th>
                    <th   scope="col" >적요</th>
                    <th   scope="col" >발주<br>수량</th>
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
		         <input type="hidden" name="PreOrderCnt"  value="<%=ordercnt%>">
                 <input type="hidden" name="orderCnt"  value="<%=ordercnt%>">
                 <input type="hidden" name="safeStockCnt" value="<%=safestock%>">
                 <input type="hidden" name="stockCnt" value="<%=stockcnt%>">  
                 <input type="hidden" name="Group1Name" value="<%=ds.getString("Group1Name")%>">     
                 <input type="hidden" name="ProductName" value="<%=ds.getString("ProductName")%>">      
                 <input type="hidden" name="StockDate" value="<%=ds.getString("StockDate")%>">         
		        
                <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                  
                    <td style="cursor: pointer" >
                    <p><%=i+1%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("Group1Name")%></p></td>              
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("ProductName")%></p></td>
                     <td style="cursor: pointer" >
                    <p> <input type="text" size="15" name="etc" id="etc_<%=i%>"  maxlength="100" value=""  dispName="" /></p></td>
                     <td style="cursor: pointer" >
                    <p><%=safestock%></p></td>
                     <td style="cursor: pointer" >
                     <p><%=stockcnt%></p></td>
                     <td style="cursor: pointer" >
                    <p> <input type="text" size="2" name="lossCnt" id="loss_<%=i%>"  maxlength="3" value="0"  dispName="" onKeyUp="loosAddCal('<%=i %>')" /></p></td>
                     <td style="cursor: pointer" >
                    <p> <input type="text" size="2" name="addCnt" id="add_<%=i%>"  maxlength="3" value="0"  dispName=""  /></p></td>
                     <td style="cursor: pointer" >
                    <p> <input type="text" size="15" name="memo" id="memo_<%=i%>"  maxlength="100" value=""  dispName="" /></p></td>
                     <td style="cursor: pointer"   >
                     <p id="order_<%=i%>" ><%=ordercnt%></p></td>
                    
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
				<td colspan="11" >발주대상 상세현황 이력이 없습니다.</td>
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
