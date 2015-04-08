<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>
<%@ page import ="com.web.common.util.CommonUtil"%>
<%@ page import ="com.web.common.CodeParam"%>

<%
	String MenuAuthID = "";//���ջ� �̰��� ���Ѿ��̵�

	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String SearchGroup = (String) model.get("SearchGroup");
	String startDate = (String) model.get("startDate");
	String endDate = (String) model.get("endDate");
	String searchtxt = (String) model.get("searchtxt");
	
	String excelEnabledCheck="";//���� ��ȸ����
	
	String select = "";
	String aselect = "";
	String bselect = "";
	String cselect = "";

	if (searchGb.equals("%")) { //all
		searchtxt = (String) model.get("searchtxt");
		select = "selected";
	} else if (searchGb.equals("1")) { //UserID
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //UserName
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("3")) { //ClientIP
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�α��� �̷�</title>
<link type="text/css" href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" />
<script>

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
	var obj=document.HistoryForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//���� üũ
	
	var dch=dateCheck(obj.startDate,obj.endDate,31);//�˻����� ��¥üũ : ������,������,�Ⱓ
	
	if (dch==false){
		return;
	}
	
	if(gubun=='1'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('����� ID�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('����� ���� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
			alert('Client IP�� �Է����ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	if(observerkey==true){return;}
	openWaiting( );
	obj.curPage.value='1';
	obj.submit();

}
//��ü ���ý� �˻��ڽ� disable
function searchChk() {
	var obj = document.HistoryForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}
//Excel Export
function goExcel() {
	var frm = document.HistoryForm;
	frm.action = "<%=request.getContextPath()%>/H_History.do?cmd=loginExcelList";	
	frm.submit();
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

//Ŀ��  ���� ó�� ��

</script>
</head>
<!-- ó���� ���� -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
   <table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
      <tr>
         <td align=center height=middle style="margin-top: 10px;">
            <table width=293 height=148 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/main/ing.gif" >
                  <tr>
                     <td align=center><img src="<%=request.getContextPath()%>/images/main/spacer.gif" width="1" height="50" /><img src="<%=request.getContextPath()%>/images/main/wait2.gif" width="242" height="16" /></td>
                  </tr>
            </table>
          </td>
       </tr>
    </table>
</div>
<!-- ó���� ���� -->

<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();

	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("HistoryForm", "curPage", "goPage")%>

<body onLoad="init()" class="body_bgAll">
	<form method="post" name=HistoryForm action="<%=request.getContextPath()%>/H_History.do?cmd=loginPageList">
	<input type="hidden" name="curPage" value="<%=curPage%>">
	
	<!-- ���̾ƿ� ���� -->
<div class="wrap_bgL">
	<!-- ����Ÿ��Ʋ ���� : ���� -->
	<div class="sub_title">
    	<p class="titleP">�α����̷�</p>
	</div>
	<!-- ����Ÿ��Ʋ ���� : �� -->
   
  	<!-- �˻� ���� : ���� -->
  	<div id="seach_box" >
   	<!-- �˻� > �ѽ��˻� : ���� -->
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
          	<p class="btn"><a href="javascript:dateMove2('1',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="����" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_1day','','<%=request.getContextPath()%>/images/sub/btn_1day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_1day.gif" name="btn_1day" border="0" id="btn_1day" /></a></p> <!-- ���ù�ư -->
        	<p class="btn"><a href="javascript:dateMove2('7',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="7����" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_7day','','<%=request.getContextPath()%>/images/sub/btn_7day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_7day.gif" name="btn_7day" border="0" id="btn_prevDay" /></a></p> <!-- 7������ư -->
            <p class="btn"><a href="javascript:dateMove2('15',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="15����" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_15day','','<%=request.getContextPath()%>/images/sub/btn_15day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_15day.gif" name="btn_15day" border="0" id="btn_prevDay" /></a></p> <!-- 15������ư -->
            <p class="btn"><a href="javascript:dateMove2('30',document.HistoryForm.startDate,document.HistoryForm.endDate);goSearch()" title="30����" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btn_30day','','<%=request.getContextPath()%>/images/sub/btn_30day_on.gif',1)">
            <img src="<%=request.getContextPath()%>/images/sub/btn_30day.gif" name="btn_30day" border="0" id="btn_prevDay" /></a></p> <!-- 15������ư -->
       
           <!-- �˻����� ����Ʈ �ڽ� ���� ����-->
           <p class="input_box"> <!-- �˻����� ����Ʈ �ڽ� ���� -->
           	<select name="searchGb">
                 	<option value="%" <%=select%>>��ü</option>
                <option value="1" <%=aselect%>>����� ID</option>
                <option value="2" <%=bselect%>>����� ��</option>
                <option value="3" <%=cselect%>>Client IP</option>
               </select>
           </p>
           <p class="input_box"><input type="text" name="searchtxt" id="textfield" style="ime-mode:active;" class="seach_text" /> </p> <!-- �˻� text box -->
           <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" title="�˻�"/></a></p> <!-- ��ȸ ��ư -->
           <%
       	if(excelEnabledCheck.equals("Y")){
         	%>
           <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="���� �ٿ�ε�" /></a></p> <!-- ���� ��ư --> 
            <%
       	}
           %> 
           <!-- �˻����� ����Ʈ �ڽ� ���� ����-->
 		</div>
   	<!-- �˻� > �׷� �����ڽ� : ��-->
   	</div>
	<!-- �˻� ���� : �� -->
	<!-- ���̺� : ���� -->
	<div id="code_origin" class="list_box">
		<ul class="listNm">
			<li>��ü�Ǽ� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>��</span></li>
			<li class="last">���������� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
		</ul>
		<div class="tbl_type_out">
			<table cellspacing="0" cellpadding="0" class="tbl_type loginPageList">
				<caption>�α��� �̷�</caption>
				<!-- <colgroup>
				<col width="5%"><col width=""><col width="5%" span="6">
				</colgroup> -->
				<thead>
					<tr>
						<th scope="col">�α����Ͻ�</th>
						<th scope="col">�α� �ƿ�</th>
						<th scope="col">�����(ID)</th>
						<!-- th scope="col">�α���<br />ä��</th-->
						<th scope="col">Browser<br />version</th>
						<th scope="col">Client IP<br />
						<th scope="col">Client OS<br />
						<th scope="col">��Ÿ<br />����</th>
					</tr>
				</thead>
				<tbody>
				<!-- :: loop :: -->
				<!--����Ʈ---------------->
				<%
					if (ld.getItemCount() > 0) {
						int i = 0;
						 String BVer="";
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
					<%
						if (ds.getString("ImageOpenDate").equals("")){
					%>
					<tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');">
					<%
						}else {
					%>
					<tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');">
					<%
						}
					%>
					<!-- Ȯ�� ��Ȯ�� ���� ����ó�� �� -->
						<td><%=ds.getString("LoginDateTime")%></td>
						<td><%=ds.getString("LogoutDateTime")%></td>
						<td><%=ds.getString("LoginUser")%></td>
						<!-- td><%=ds.getString("LoginProgram")%></td-->
					   <%
						        BVer=ds.getString("ClientBrowserVersion");
						
						        if(BVer.indexOf("FireFox")!=-1){
						        %>
						          <td><a class="ico_firefox"><span class="blind">���̾�����</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }else if(BVer.indexOf("Chrome")!=-1){
						        %>
						          <td><a class="ico_chrome"><span class="blind">ũ��</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }else{
						        %>
						          <td><a class="ico_ie"><span class="blind">�ͽ��÷η�</span></a><%=ds.getString("ClientBrowserVersion")%></td>
						          <%
						        }
					    %>
						<td><%=ds.getString("ClientIP")%></td>
						<td><a class="ico_win"><span class="blind">������7</span></a><%=ds.getString("ClientOS")%></td>
						<td class="align_left"><%=ds.getString("Description")%></td>
					</tr>
					<!-- :: loop :: -->
					<%
						i++;
						}
						} else {
					%>
					<tr>
						<td colspan="8">�Խù��� �����ϴ�.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<!-- ���̺� : �� -->
	<!-- ������ �ѹ� : ���� -->
	<div id="Pagging"><%=ld.getPagging("goPage")%></div>
	<!-- ���� ��ư�� ��ü ���δ� span, �ؽ�Ʈ �� ���� ���δ� span��  class="PaggingR" �߰�
	<div id="Pagging"><span class="PaggingR"><span class="direction_off pd0"><img src="images/sub/btn_first_off.gif"></span><span class="direction_off pd0"><img src="images/sub/btn_prev_off.gif"></span></span><span class="PaggingR"><strong>1</strong></span><span class="PaggingR"><a href="javascript:goPage('2', '2')">2</a></span><span><span class="direction_off pd0"><img src="images/sub/btn_next_off.gif"></span><span class="direction_off pd0"><img src="images/sub/btn_last_off.gif"></span></span></div>
	-->
	<!-- ������ �ѹ� : �� -->
</div>
</form>
</body>
</html>