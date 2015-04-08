<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.order.StockDTO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//���� ���Ѱ��� ���� START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//����� ����
	String groupId=StringUtil.nvl(dtoUser.getGroupid(),"");//����� �׷�
	//���� ���Ѱ��� ���� END

	
	String curPage = (String) model.get("curPage");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	String GroupID = (String) model.get("GroupID");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��� ����</title>
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

//�˻�
function goSearch() {
	var obj=document.StockFrom;

	obj.action = "<%=request.getContextPath()%>/H_Order.do?cmd=stockPageList";
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

function goStockDetail(stockdate,groupid){
	$('[name=stockDetailPageList]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 750,
		width : 620,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			$(this).load('<%=request.getContextPath()%>/H_Order.do?cmd=stockDetailPageList',{
				'stockdate' : stockdate,
				'groupid' : groupid
			});
		}
	});
}
//excel update �˾�
function goExcelUpdate(){
	$('[name=stockExcelForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 450,
		width : 420,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Order.do?cmd=stockExcelForm');
		}
	});
}

//���̾ƿ� �˾� �ݱ� ��ư �Լ�
function goClosePop(formName){
	$('[name='+formName+"]").dialog('close');
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
<%=ld.getPageScript("StockFrom", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=StockFrom action="<%=request.getContextPath()%>/H_Order.do?cmd=stockPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- ���̾ƿ� ���� -->
		<div class="wrap_bgL">
			<!-- ����Ÿ��Ʋ ���� : ���� -->
			<div class="sub_title">
    			<p class="titleP">��� ��Ȳ����</p>
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
		    
			 <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- ��ȸ ��ư --> 
	         <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="�����Ȳ �ϰ����" /></a></p>  <!-- ��������� �ϰ���� ������ -->

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
		        <caption>�����Ȳ ����</caption>
		            <thead>
		                <tr>
		               	  <th>�����Ȳ����</th>
		                  <th>�׷���̵�</th>
		                  <th>�׷��</th>
		                  <th>����������ƮUserID</th>
		                  <th>����������ƮUserName</th>
		                  <th>����������Ʈ����</th>
		                </tr>
		            </thead>
		            <tbody>
		            <!-- :: loop :: -->
					<!--����Ʈ---------------->
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
				<!-- Ȯ�� ��Ȯ�� ���� ����ó�� ����-->	
                       <tr name="tdonevent" id="tdonevent" style="background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                              
		                	<td style="cursor: pointer" onclick="goStockDetail('<%=ds.getString("StockDate")%>','<%=ds.getString("GroupID")%>');"><%=ds.getString("StockDate")%></td>
							<td><%=ds.getString("GroupID")%></td>
							<td><%=ds.getString("GroupName")%></td>
							<td><%=ds.getString("LastUserID") %></td>
							<td><%=ds.getString("UserName")%></td>
							<td><%=ds.getString("StockDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="6">�Խù��� �����ϴ�.</td>
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
<div name="stockDetailPageList" title="��� �� ��Ȳ"></div>
<div name="stockExcelForm" title="�����Ȳ �ϰ����"></div>
</body>
</html>
