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
    String OrderCode = (String) model.get("OrderCode");
    
    String Email = (String) model.get("Email");
    String FaxNumber = (String) model.get("FaxNumber");
    String MobilePhone = (String) model.get("MobilePhone");
    String OrderEtc = (String) model.get("OrderEtc");
    String OrderAdress = (String) model.get("OrderAdress");
    String IngYN = (String) model.get("IngYN");
    String BuyYN = (String) model.get("BuyYN");

    String ToTalOrderPrice = (String) model.get("ToTalOrderPrice");
    String ToTalVatPrice = (String) model.get("ToTalVatPrice");
    
    long TotalSupplyPrice=Long.parseLong(ToTalOrderPrice)+Long.parseLong(ToTalVatPrice);
    
  
    String UseGroupID=(String) model.get("UseGroupID");
    
	String displayy="";
	String displayn="";
	String displayExport="none";
	String displaySave="none";
	
	if("N".equals(companyDto.getBuyResult())){
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
<title>발주 대상 상세현황</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">


// 커서  색상 처리 시작

function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}

function orderCal(index){

	var cnt=0;
	var price=0;
	var totalprice=0;
	
	var vat=0.1;
	var vatprice=0;
	
	var frm=document.OrderDetailFrom;
	
	var comcnt=0;
	var comprice=0;
	var comtoprice=0;
	
	if(frm.OrderResultCnt.length>1){
		
		cnt=onlyNum(frm.OrderResultCnt[index].value);
		price=onlyNum(frm.OrderResultPrice[index].value);

		if(cnt==''){
			cnt=0;
		}
		if(price==''){
			price=0;
		}
	
		totalprice=price*cnt;

	}else{
		
		cnt=onlyNum(frm.OrderResultCnt.value);
		price=onlyNum(frm.OrderResultPrice.value);
		
		if(cnt==''){
			cnt=0;
		}
		if(price==''){
			price=0;
		}
		if(vat==''){
			vat=0.1;
		}
		totalprice=price*cnt;
	}

	document.getElementById("OrderResultCntY_"+index).innerText=addCommaStr(''+cnt);
	document.getElementById("OrderResultPriceY_"+index).innerText=addCommaStr(''+price);

	//document.getElementById("OrderResultCntN_"+index).innerText=addCommaStr(''+cnt);
	//document.getElementById("OrderResultPriceN_"+index).innerText=addCommaStr(''+price);
	
	document.getElementById("OrderPrice_"+index).innerText=addCommaStr(''+totalprice);
}

function goOrderProcSave(index){
	
	if(!confirm('['+$('#ProductName_'+index).val()+"] 에 대한 검수정보를 저장하시겠습니까?")){
		return;
	}
    var checkVal='Y';
    
	//jQuery Ajax
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Order.do?cmd=orderProcSave",
		type : "post",
		dataType : "text",
		async : true,
		data : {
			"OrderCode" : "<%=OrderCode%>",
			"ProductCode"		: $('#ProductCode_'+index).val(),
			"OrderResultCnt" : $('#OrderResultCnt_'+index).val(),
			"OrderResultPrice" : $('#OrderResultPrice_'+index).val(),
			"OrderCheck" 		: checkVal,
			"VatRate"		: $('#VatRate_'+index).val(),
			"OrderMemo"		: encodeURIComponent($('#OrderMemo_'+index).val())
		},
		success : function(data, textStatus, XMLHttpRequest){
			
			var resultdata =data.split(',');
			

			if(resultdata[0] =='Y' || resultdata[0]=='N'){ //Update Success
				alert("저장을 성공했습니다.");
			
				document.getElementById("procimage_"+index).src='<%=request.getContextPath()%>/images/btn_change.gif';
				document.getElementById("priceid").innerText='공급가 : '+resultdata[1] +'  부가세 : '+resultdata[2] +' 합계 : '+resultdata[3];
				
			/*
				document.getElementById("OrderResultCntN_"+index).style.display='none';
				document.getElementById("OrderResultPriceN_"+index).style.display='none';
				document.getElementById("OrderResultN_"+index).style.display='none';
				
				document.getElementById("OrderResultCntY_"+index).style.display='inline';
				document.getElementById("OrderResultPriceY_"+index).style.display='inline';
				document.getElementById("OrderResultY_"+index).style.display='inline';
*/
				if(resultdata[0]=='Y'){		//전체처리여부 확인(검수완료인경우)
		
					document.getElementById("orderCreateId").style.display='inline';
					document.getElementById("SaveProcId").style.display='inline';

				}
			}else{
				alert("저장을 실패했습니다.");
			}
		},
		error : function(request, status, error){
			alert("code :"+request.status + "\r\nmessage :" + request.responseText);
		}
	});
	
}
function goBuyResult(){
	
	if(!confirm('구매처리를 완료 하시겠습니까?\n처리하신 발주 내역은 변경이 불가능합니다.')){
		return;
	}

	//jQuery Ajax
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Order.do?cmd=orderProcClose",
		type : "post",
		dataType : "text",
		async : true,
		data : {
			"OrderCode" : "<%=OrderCode%>"
		},
		success : function(data, textStatus, XMLHttpRequest){

			if(data =='1'){ //Update Success
				alert("완료처리를 성공했습니다.");
			
				document.getElementById("SaveProcId").style.display='none';
			
				if(document.OrderDetailFrom.ProductCode.length>1){
					for (i=0; i< document.OrderDetailFrom.ProductCode.length;i++){
						
							document.getElementById("OrderResultCntN_"+i).style.display='none';
							document.getElementById("OrderResultPriceN_"+i).style.display='none';
							document.getElementById("VatRateN_"+i).style.display='none';
							document.getElementById("OrderMemoN_"+i).style.display='none';
							document.getElementById("OrderResultN_"+i).style.display='none';
							
							document.getElementById("OrderResultCntY_"+i).style.display='inline';
							document.getElementById("OrderResultPriceY_"+i).style.display='inline';
							document.getElementById("VatRateY_"+i).style.display='inline';
							document.getElementById("OrderMemoY_"+i).style.display='inline';
							document.getElementById("OrderResultY_"+i).style.display='inline';
					}
				}else{
						document.getElementById("OrderResultCntN_0").style.display='none';
						document.getElementById("OrderResultPriceN_0").style.display='none';
						document.getElementById("VatRateN_0").style.display='none';
						document.getElementById("OrderMemoN_0").style.display='none';
						document.getElementById("OrderResultN_0").style.display='none';
						
						document.getElementById("OrderResultCntY_0").style.display='inline';
						document.getElementById("OrderResultPriceY_0").style.display='inline';
						document.getElementById("VatRateY_0").style.display='inline';
						document.getElementById("OrderMemoY_0").style.display='inline';
						document.getElementById("OrderResultY_0").style.display='inline';
				}

			}else{
				alert("완료처리를 실패했습니다.");
			}
		},
		error : function(request, status, error){
			alert("code :"+request.status + "\r\nmessage :" + request.responseText);
		}
	});

	
}
function goOrderExcel(){
	
	var frm = document.OrderDetailFrom;
	frm.action = "<%=request.getContextPath()%>/H_Order.do?cmd=orderExcelDetailPageList";	
	frm.method = "POST";
	frm.submit();
	
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
	<form method="post" name=OrderDetailFrom action="<%=request.getContextPath()%>/H_Order.do?cmd=orderExcelDetailPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<input type="hidden" name="OrderCode"  value="<%=OrderCode%>"> 
		<input type="hidden" name="GroupID"  value="<%=GroupID%>">   
<!-- 레이아웃 시작 -->
<div class="ly_pop_new">
	<!-- 테이블 : 시작 -->
	<div id="code_origin">
	<br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>발주 대상 업체(주문) 정보</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
     <caption>발주 대상 업체(주문) 정보</caption>
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
              <input type="hidden" name="ChargeName"  value="<%=companyDto.getChargeName()%>"> 
              <input type="hidden" name="GroupName"  value="<%=GroupName%>">      

                    <td>
                    <p><%=companyDto.getCompanyName()%></p></td>
                     <td>
                    <p><%=companyDto.getCompanyPhone()%></p></td>
                    <td>
                    <p><%=MobilePhone%></p></td>
                    <td>
                    <p><%=Email%></p></td>
                    <td>
                    <p><%=FaxNumber %></td>
	                </p></td>
                    <td>
                    <p><%=companyDto.getChargeName()%></p></td>
                    <td>
                    <p><%=GroupName%></p></td>
                </tr>
                <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                   <th>납품일자</th>
                    <td >
                    <p><%=companyDto.getDeliveryDateFomat()%>
                    </p></td>
                   <th>납품방법</th>
                    <td colspan="2">
                    <p><%=companyDto.getDeliveryMethod()%></td>
                    <th>참조</th>
                    <td>
                    <p><%=companyDto.getDeliveryEtc()%></td>
                </tr>
                <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                    <th>비고</th>
                     <td colspan="2">
                    <p><%=OrderEtc %></p></td>
                    <th>배송주소</th>
                    <td colspan="3">
                    <p><%=OrderAdress %></td>
                </tr>
            </tbody>
        </table>
  	</div>
	<br>
	</br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>

   <font style="fontWeight:bold; color:blue" ><a href="javascript:goOrderExcel()"  id="orderCreateId" style="display:<%=displayExport%>"><img src="<%=request.getContextPath()%>/images/addys-btn_add_03.gif" title="구매전표생성" /></a>
   <a href="javascript:goBuyResult()" id="SaveProcId" style="display:<%=displaySave%>"><img src="<%=request.getContextPath()%>/images/btn_lypop_save.gif" title="구매완료" /></a></font> 
   <font style="fontWeight:bold; color:blue" ><a href="<%=request.getContextPath()%>/fileDownServlet?ServerID=99&filePath=Order&sFileName=<%=OrderCode%>.html"><img src="<%=request.getContextPath()%>/images/addys-btn_add_04.gif" title="발주서다운로드" /></a></font> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span id="priceid">공급가 : <%=ToTalOrderPrice %>  부가세 : <%=ToTalVatPrice %> 합계 : <%=TotalSupplyPrice %></span>
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
                    <th   scope="col" >약정<br>단가</th>
                    <th   scope="col" >구매<br>수량</th>
                    <th   scope="col" >단가</th>
                    <th   scope="col" >공급가</th>
                    <th   scope="col" >부가세<br>비율</th>
                    <th   scope="col" >발주<br>메모</th>
                   <th   scope="col" >처리</th>

                </tr>
            </thead>
            <tbody>
		<%
		if (ld.getItemCount() > 0) {
			
			int i = 0;
			int orderrcnt=0;
			int orderrprice=0;
			int ordertprice=0;

			String imagename="btn_lypop_save.gif";
			
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
				orderrcnt=ds.getInt("OrderResultCnt");
				orderrprice=ds.getInt("OrderResultPrice");
				ordertprice=orderrcnt*orderrprice;
		%>
                <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                  
                    <td style="cursor: pointer" >
                    <p><%=i+1%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("Group1Name")%></p></td>              
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("ProductName")%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getString("Etc")%></p></td>
                     <td style="cursor: pointer" >
                    <p><%=ds.getInt("SafeStock")%></p></td>
                     <td style="cursor: pointer" >
                    <p> <%=ds.getInt("StockCnt")%></p></td>
                    <td style="cursor: pointer" >
                    <p> <%=ds.getInt("LossCnt")%></p></td>
                    <td style="cursor: pointer" >
                    <p> <%=ds.getInt("AddCnt")%></p></td>
                     <td style="cursor: pointer" >
                    <p> <%=ds.getString("Memo")%></p></td>
                     <input type="hidden" name="ProductCode" id="ProductCode_<%=i %>" value="<%=ds.getString("ProductCode")%>">
                     <input type="hidden"  id="ProductName_<%=i %>" value="<%=ds.getString("ProductName")%>"> 
                   <%
                    
	                   if("N".equals(ds.getString("OrderCheck"))){
	                	   imagename="btn_save.gif";
		               	}else{
		               	  imagename="btn_change.gif";
		               	}
	                 %>
                    <td style="cursor: pointer" >
                    <p><%=ds.getInt("OrderCnt")%></p></td>
                     <td style="cursor: pointer" >
                    <p> <%=ds.getInt("ProductPrice")%></p></td>
                     <td style="cursor: pointer"  id="OrderResultCntY_<%=i %>" style="display:<%=displayy%>">
                    <p><%=NumberUtil.getPriceFormat(ds.getLong("OrderResultCnt"))%></p></td>
                   
                        <td style="cursor: pointer"  id="OrderResultCntN_<%=i %>" style="display:<%=displayn%>">
                    <p> <input type="text" size="2" name="OrderResultCnt" id="OrderResultCnt_<%=i%>"  maxlength="3" value="<%=ds.getInt("OrderResultCnt")%>"  dispName="" onKeyUp="orderCal('<%=i %>')"  /></p></td>
                 
                    <td style="cursor: pointer"  id="OrderResultPriceY_<%=i %>" style="display:<%=displayy%>">
                    <p><%=NumberUtil.getPriceFormat(ds.getLong("OrderResultPrice"))%></p></td>
                    
                      <td style="cursor: pointer"  id="OrderResultPriceN_<%=i %>" style="display:<%=displayn%>">
                    <p> <input type="text" size="5" name="OrderResultPrice" id="OrderResultPrice_<%=i%>"  maxlength="10" value="<%=ds.getInt("OrderResultPrice")%>"  dispName="" onKeyUp="orderCal('<%=i %>')"  /></p></td>

                     <td style="cursor: pointer" id="OrderPrice_<%=i %>" >
                    <p> <%=NumberUtil.getPriceFormat(ordertprice)%></p></td>
                   
                   
                    <td style="cursor: pointer" id="VatRateY_<%=i%>"  style="display:<%=displayy%>">
                    <p> <%=ds.getString("OrderVatRate")%></p></td>
                   
                    <td style="cursor: pointer" id="VatRateN_<%=i%>"  style="display:<%=displayn%>">
                    <p> <input type="text" size="2" name="VatRate" id="VatRate_<%=i%>"  maxlength="3" value="<%=ds.getString("OrderVatRate")%>"  dispName="" onKeyUp="orderCal('<%=i %>')"  /></p></td>
   
                    
              
                   <td style="cursor: pointer"  id="OrderMemoY_<%=i%>"  style="display:<%=displayy%>" >
                    <p> <%=ds.getString("OrderMemo")%></p></td>
                    
                      <td style="cursor: pointer" id="OrderMemoN_<%=i%>"  style="display:<%=displayn%>">
                    <p> <input type="text" size="15" name="OrderMemo" id="OrderMemo_<%=i%>"  maxlength="100" value="<%=ds.getString("OrderMemo")%>"   dispName="" /></p></td>
              
              
                    <td style="cursor: pointer"  id="OrderResultY_<%=i %>" style="display:<%=displayy%>">
                    <p>처리완료</p></td>
              
                     <td style="cursor: pointer"  id="OrderResultN_<%=i %>" style="display:<%=displayn%>">
                    <p>
                      <a href="javascript:goOrderProcSave('<%=i %>');"><img id="procimage_<%=i %>" src="<%=request.getContextPath()%>/images/<%=imagename %>" title="처리"></a></p></td>   

                   </tr>
                
             <!-- :: loop :: -->
			<%
				i++;
					}
				} else {
			%>
			<tr>
				<td colspan="10" >발주대상 상세현황 이력이 없습니다.</td>
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


