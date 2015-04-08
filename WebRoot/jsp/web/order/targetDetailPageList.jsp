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
<title>���� ��� ����Ȳ</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script type="text/javascript">
$(document).ready(function(){
	$('#calendarData').datepicker({
		maxDate:0,
		prevText: "����",
		nextText: "����",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["��","��","ȭ","��","��","��","��"],
		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		changeMonth: true,
	    changeYear: true
	});
});
function showCalendars(){
	
	   $('#calendarData').datepicker("show");
}

// Ŀ��  ���� ó�� ����

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
			
			alert('���� ��� �̸��� �ּҰ� �����ϴ�.');
			return;
		}
		
		if(frm.fax.checked==true){	
			
			frm.FAXKey.value='Y';
			
			if(frm.faxnum.value==''){
				
				alert('���� ��� FAX ��ȣ�� �����ϴ�.');
				return;
			}
			
			if(!confirm("���� ó�� �Ͻðڽ��ϱ�?\n���ּ��� �̸���["+frm.emailaddr.value+"]  ��\n�ѽ���ȣ["+frm.faxnum.value+"]  �� ���۵˴ϴ�."))
				return;
			
		}else{
		
			frm.FAXKey.value='N';
			
			if(!confirm("���� ó�� �Ͻðڽ��ϱ�?\n���ּ��� �̸���["+frm.emailaddr.value+"]  �� ���۵˴ϴ�."))
				return;
			
		}


	}else{
		
		frm.EmailKey.value='N';

		if(frm.fax.checked==true){	
				
				frm.FAXKey.value='Y';
				
				if(frm.faxnum.value==''){
					
					alert('���� ��� FAX ��ȣ�� �����ϴ�.');
					return;
				}
				
				if(!confirm("���� ó�� �Ͻðڽ��ϱ�?\n���ּ��� �ѽ���ȣ["+frm.faxnum.value+"]  �� ���۵˴ϴ�."))
					return;
				
			}else{
			
				frm.FAXKey.value='N';
				
				if(!confirm("���� ó�� �Ͻðڽ��ϱ�?\n���ּ��� ���ָ���Ʈ���� �ٿ� �����մϴ�."))
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
			
			alert('�ֹ����� ���� �� ���� �����Ͻ� �� �����ϴ�.');
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
			
			alert('�ֹ����� ���� �� ���� �����Ͻ� �� �����ϴ�.');
			frm.orderCnt.value=frm.PreOrderCnt.value;
			frm.lossCnt.value =0;
			return;
			
		}
		document.getElementById("order_"+index).innerText=frm.orderCnt.value;
	}

	
}

//Ŀ��  ���� ó�� ��
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
<!-- ���̾ƿ� ���� -->
<div class="ly_pop_new">
	<!-- ���̺� : ���� -->
	<div id="code_origin">
	<br>
	 <!-- caution_area -->
    <div class="caution_area">
      <h3>���� ��� ��ü����</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>���� ��� ��ü����</caption>
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
              <input type="hidden" name="GroupName"  value="<%=GroupName%>">             
                    <td>
                    <p><%=companyDto.getCompanyName()%></p></td>
                     <td>
                    <p><%=companyDto.getCompanyPhone()%></p></td>
                    <td>
                    <p><input type="text" size="13" name="mobilephone" id="mobilephone" maxlength="20" value="<%=companyDto.getMobilePhone()%>"  dispName="����Ϲ�ȣ"  onKeyUp="format_phone(this);" /></p></td>
                    <td>
                    <p><input type="text" size="15" name="emailaddr" id="emailaddr"  maxlength="50" value="<%=companyDto.getEmail()%>"  dispName="" /></p></td>
                    <td>
                    <p> <input type="text" size="13" name="faxnum" maxlength="14" value="<%=companyDto.getFaxNumber() %>" tabindex="4" dispName="�ѽ���ȣ" onKeyUp="format_phone(this);"/></td>
	                </p></td>
                    <td>
                    <p><input type="text" size="13" name="ChargeName" id="ChargeName"  maxlength="20" value="<%=companyDto.getChargeName()%>"  dispName="�����" /></p></td>
                    <td>
                    <p><%=GroupName%></p></td>
                </tr>
                 <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                   <th>��ǰ����</th>
                    <td >
                    <p><input type="text" size="11" name="deliveryDate"  value="<%=deliveryDate %>" id="calendarData" dispName="��¥" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);"/>
                    	<!-- �޷��̹��� ���� -->
						<span class="icon_calendar"><img border="0" onclick="showCalendars()" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
						<!-- �޷��̹��� �� -->
                    </p></td>
                   <th>��ǰ���</th>
                    <td colspan="2">
                    <p><input type="text" size="25" name="orderMethod" maxlength="100" value="�ù���"/></td>
                    <th>����</th>
                    <td>
                    <p><input type="text" size="11" name="orderEtc" maxlength="100" value=""/></td>
                </tr>
                <tr style="cursor:hand;background-color:#FAFAFA;" >                  
                    <th>���</th>
                     <td colspan="2">
                    <p><input type="text" size="60" name="totalEtc" maxlength="100" value=""/></p></td>
                    <th>����ּ�</th>
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
      <h3><input name="fax" type="checkbox"  disabled /> FAX <input name="email" type="checkbox"  checked/> Email <input name="sms" type="checkbox"  disabled/> SMS  &nbsp;<a href="javascript:goOrder()"><img src="<%=request.getContextPath()%>/images/addys-btn_add_01.gif" title="����" /></a>
	</h3>
    </div>
    <!-- //caution_area -->
	<br>
	 <div class="tbl_type_out">
        <table cellspacing="0" cellpadding="0" class="tbl_type align_CT">
        <caption>���� ��� ����Ȳ</caption>
            <thead>
                <tr>
                    <th   scope="col" >��ȣ</th>
                    <th   scope="col" >������</th>
                    <th   scope="col" >��ǰ��</th>
                    <th   scope="col" >���</th>
                    <th   scope="col" >����<br>���</th>
                    <th   scope="col" >���<br>��Ȳ</th>
                    <th   scope="col" >����<br>����</th>
                    <th   scope="col" >�ս�<br>����</th>
                    <th   scope="col" >����</th>
                    <th   scope="col" >����<br>����</th>
                    <th   scope="col" >���<br>����</th>
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
				<td colspan="11" >���ִ�� ����Ȳ �̷��� �����ϴ�.</td>
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
