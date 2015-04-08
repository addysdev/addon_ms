<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import="com.web.common.order.OrderDTO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//���� ���Ѱ��� ���� START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//����� ����
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//����� �׷�
	//���� ���Ѱ��� ���� END
    CodeParam codeParam = new CodeParam();
	
	String curPage = (String) model.get("curPage");
	String vGroupID = (String) model.get("vGroupID");
	String vSearchType = (String) model.get("vSearchType");
	String vSearch = (String) model.get("vSearch");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	
	String select = "";
	String aselect = "";
	String bselect = "";
	String cselect = "";
	String dselect = "";
	
	if (vSearchType.equals("0")) { 		//���ֹ�ȣ
		vSearch = (String) model.get("vSearch");
		select = "selected";
	} else if (vSearchType.equals("1")) { 		//������
		vSearch = (String) model.get("vSearch");
		aselect = "selected";
	} else if (vSearchType.equals("2")) { //����ó
		vSearch = (String) model.get("vSearch");
		bselect = "selected";
	}else if (vSearchType.equals("3")) { //�˼�����
		vSearch = (String) model.get("vSearch");
		cselect = "selected";
	}else if (vSearchType.equals("4")) { //���Ż���
		vSearch = (String) model.get("vSearch");
		dselect = "selected";
	}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>���ִ�� ����</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
 var openWin=0;//�˾���ü
var isSearch=0; 
 
$(document).ready(function(){
	$('#calendarData1, #calendarData2').datepicker({
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
function showCalendar(div){

	   if(div == "1"){
	   	   $('#calendarData1').datepicker("show");
	   } else if(div == "2"){
		   $('#calendarData2').datepicker("show");
	   }  
}

//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	
	searchChk();
}
//����Ʈ ���� �ɼ�
function searchChk() {
	var obj = document.OrderForm;

	if (obj.vSearchType[0].selected == true) {
		obj.vSearch.disabled = true;
		obj.vSearch.value = '';
	} else {
		obj.vSearch.disabled=false;
	}
}
//�˻�
function goSearch() {
	var obj=document.OrderForm;
	
var gubun=obj.vSearchType.value;
	
	if(gubun=='0'){
	
		if(obj.vSearch.value=='' ){
			alert('���ֹ�ȣ�� �Է��� �ּ���');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='1'){

		if(obj.vSearch.value=='' ){
			alert('�����ڸ� �Է��� �ּ���');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.vSearch.value=='' ){
			alert('����ó�� �Է��� �ּ���');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.vSearch.value=='' ){
			alert('�˼����θ� �Է��� �ּ���');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
		if(obj.vSearch.value=='Y' || obj.vSearch.value=='N'){
			
			
		}else{
			
			alert('�˼����δ� Y �Ǵ� N���� �˻� �����մϴ�.');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.vSearch.value=='' ){
			alert('���ſ��θ� �Է��� �ּ���');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
		if(obj.vSearch.value=='Y' || obj.vSearch.value=='N'){
			
			
		}else{
			
			alert('���ſ��δ� Y �Ǵ� N���� �˻� �����մϴ�.');
			obj.vSearch.value="";
			obj.vSearch.focus();
			return;
		}
	}



	obj.action = "<%=request.getContextPath()%>/H_Order.do?cmd=orderPageList";
	if(observerkey==true){return;}

	openWaiting();
	obj.curPage.value='1';

	obj.submit();
}


// Ŀ��  ���� ó�� ����

function fnLayerover(index){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = '#FEFADA'; 

}


function fnLayerout(index,rowclass){
	
	var tdonevent = document.getElementsByName("tdonevent");
	tdonevent[index].style.backgroundColor = rowclass;
	
}

function goOrderDetail(ordercode,companycode,groupid,groupname,Email,FaxNumber,MobilePhone,OrderEtc,OrderAdress,IngYN,BuyYN,ToTalOrderPrice,ToTalVatPrice){
	$('[name=orderDetailPageList]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 850,
		width : 1100,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			$(this).load('<%=request.getContextPath()%>/H_Order.do?cmd=orderDetailPageList',{
				'OrderCode' : ordercode,
				'CompanyCode' : companycode,
				'GroupID' : groupid,
				'GroupName' : encodeURIComponent(groupname) ,
				'Email' : encodeURIComponent(Email) ,
				'FaxNumber' : FaxNumber ,
				'MobilePhone' : MobilePhone ,
				'OrderEtc' : encodeURIComponent(OrderEtc) ,
				'OrderAdress' : encodeURIComponent(OrderAdress),
				'IngYN' : IngYN ,
				'BuyYN' : BuyYN ,
				'ToTalOrderPrice' : ToTalOrderPrice,
				'ToTalVatPrice' : ToTalVatPrice
			});
		}
	});
}

//���̾ƿ� �˾� �ݱ� ��ư �Լ�
function goClosePop(formName){
	$('[name='+formName+"]").dialog('close');
}
//Ŀ��  ���� ó��
function fnLayerover(index){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = '#FEFADA'; 

}
function fnLayerout(index,rowclass){
	
	document.getElementById("tdonevent_"+index).style.backgroundColor = rowclass;
	
}
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("OrderForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=OrderForm action="<%=request.getContextPath()%>/H_Order.do?cmd=orderPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- ���̾ƿ� ���� -->
		<div class="wrap_bgL">
			<!-- ����Ÿ��Ʋ ���� : ���� -->
			<div class="sub_title">
    			<p class="titleP">�˼� ����Ʈ</p>
			</div>
			<!-- ����Ÿ��Ʋ ���� : �� -->

		<!-- �˻� ���� : ���� -->
        <div id="seach_box" >
    	<!-- �˻� > �ѽ��˻� : ���� ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- �ѽ��˻� text : CSS�� ��Ʈ���� -->
    		<!-- �˻� > �׷� �����ڽ� : ����-->
    		    		
	    	<div id="seach">
			<p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
			
			 <!-- ��ȸ��������-->
			<p class="psr input_box">
			<input  name="startDate" id="calendarData1" value="<%=startDate%>" type="text" size="8" style="width:60px;" class="in_txt"  dispName="��¥" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			<!-- �޷��̹��� ���� -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar('1')" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- �޷��̹��� �� -->
		    </p>
            <!-- ��ȸ�շ�����-->
			<p class="psr input_box">&nbsp;~&nbsp;
			 <input  name="endDate" id="calendarData2" value="<%=endDate%>" type="text" size="8" style="width:60px;" class="in_txt"  dispName="��¥" maxlength="10"  onKeyUp="if(onlyNum(this.value).length==8) addDateFormat(this);" onBlur="if(onlyNum(this.value).length!=8) addDateFormat(this);" />
			 <!-- �޷��̹��� ���� -->
			<span class="icon_calendar"><img border="0" onclick="showCalendar('2')" src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif"></span>
			<!-- �޷��̹��� �� -->
		    </p>
		    
			<p class="psr input_box">
            <%
            
            if("G00000".equals(groupId)){

			    codeParam = new CodeParam();
				codeParam.setType("select"); 
				codeParam.setStyleClass("td3");
				codeParam.setFirst("��ü");
				codeParam.setName("vGroupID");
				codeParam.setSelected(vGroupID); 
				codeParam.setEvent(""); 
				out.print(CommonUtil.getCodeListGroup(codeParam)); 

            }else{
            %>
            	<input type="hidden" name="vGroupID" value="<%=groupId%>">
            <%
            }
            %>
            </p>
             <p class="input_box"> <!-- ����Ʈ �ڽ� -->
                   <select name="vSearchType"  onchange="searchChk()">
                       <option value="" checked>��ü</option>
                       <option value="0" <%=select%>>���ֹ�ȣ</option>
                       <option value="1" <%=aselect%>>������</option>
                       <option value="2" <%=bselect%>>����ó</option>
                       <option value="3" <%=cselect%>>�˼�����</option>
                       <option value="4" <%=dselect%>>���ſ���</option>
                   </select>
               </p>
	           <p class="input_box"><input type="text" name="vSearch" id="textfield" maxlength="20"  value="<%=vSearch%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- �˻� text box -->
            
			 <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- ��ȸ ��ư --> 
	                   <!-- �˻� ��-->
    	<!-- �˻� > �׷� �����ڽ� : ��-->
		</div>

		</div>
	<!-- �˻� ���� : �� -->     
			<!-- ���̺� : ���� -->
			<div id="code_origin" class="list_box">

			<ul class="listNm">
				<li>��ü�Ǽ� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>��</span></li>
				<li class="last">���������� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>���ִ�� ����</caption>
		            <thead>
		                <tr>
		               	  <th>���ֹ�ȣ</th>
		               	  <th>��������</th>
		               	  <th>������</th>
		                  <th>����</th>
		                  <th>����ó</th>
                          <th>�˼�����</th>
                          <th>���Ż���</th>
		                  <th>���ް�</th>
		                  <th>�ΰ���</th>
		                  <th>�հ�</th>
		                </tr>
		            </thead>
		            <tbody>
		            <!-- :: loop :: -->
					<!--����Ʈ---------------->
					<%
						if (ld.getItemCount() > 0) {
							int i = 0;
							double total=0;
							double supply=0;
							float vat=0;
							while (ds.next()) {
								
								//�ο���󺯰� ����
								int num = 0;
								String rowClass="";
								
								num = i % 2;
								
								if("Y".equals(StringUtil.nvl(ds.getString("BuyYN"),""))){
							
									 rowClass="#FF9";
								
								}else{
								
									if(num==1){
										rowClass="#FAFAFA";
									
									}else{
										rowClass="#FFFFFF";
										
									}
									
								}
								
								//�ο���󺯰� ��  
								supply=ds.getInt("ToTalOrderPrice");
								vat=ds.getFloat("ToTalVatPrice");
								total=supply+vat;
						
						%>
				<!--  ���� ����ó�� ����-->	
				<% 
                	 if (!ds.getString("BuyYN").equals("Y")){     	
	            %>	        
               	    <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" class="bold2" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >             
                <%
	            	}else {
	            %>
                     <tr name="tdonevent_<%=i%>" id="tdonevent_<%=i%>" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >               	
				<%
	             	}
	            %>	
	            <!--   ���� ����ó�� �� -->

                       <td style="cursor: pointer" onclick="goOrderDetail('<%=ds.getString("OrderCode")%>','<%=ds.getString("CompanyCode") %>','<%=ds.getString("GroupID")%>',
		                	'<%=ds.getString("GroupName")%>','<%=ds.getString("Email")%>','<%=ds.getString("FaxNumber")%>','<%=ds.getString("MobilePhone")%>'
		                	,'<%=ds.getString("OrderEtc")%>','<%=ds.getString("OrderAdress")%>','<%=ds.getString("IngYN")%>','<%=ds.getString("BuyYN")%>','<%=ds.getInt("ToTalOrderPrice")%>','<%=(long)ds.getFloat("ToTalVatPrice")%>');"><%=ds.getString("OrderCode")%></td>
							<td><%=ds.getString("OrderDateTime")%></td>
							<td><%=ds.getString("OrderUserName")%>(<%=ds.getString("OrderUserID")%>)</td>
							<td><%=ds.getString("GroupName")%>(<%=ds.getString("OrderUserID")%>)</td>
							<td><%=ds.getString("CompanyName")%>(<%=ds.getString("CompanyCode")%>)</td>
							<td><%=ds.getString("IngResult") %></td>
							<td><%=ds.getString("BuyResult") %></td>
							<td><%=NumberUtil.getPriceFormat((long)supply)%></td>
							<td><%=NumberUtil.getPriceFormat((long)vat)%></td>
							<td><%=NumberUtil.getPriceFormat((long)total)%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="10">���ְ��� �����ϴ�.</td>
					</tr>
					<!-- <script>
						goSearch();
					</script> -->
					<%
						}
					%>
					
		          </tbody>
		        </table>
			</div>
			</div>
		    <!-- ���̺� �� -->
		    
		    <!-- ������ �ѹ� �̹����� ó�� -->
		    <div id="Pagging"><%=ld.getPagging("goPage")%></div>
			<!-- ������ �ѹ� �� -->

		</div>
		<!-- ���̾ƿ� �� -->
</form>
<div name="orderDetailPageList" title="���� �� ǰ��"></div>
</body>
</html>
