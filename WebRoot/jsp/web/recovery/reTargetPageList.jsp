<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import="com.web.common.recovery.RecoveryDTO"%>
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
	
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt");
	String aselect = "";
	String bselect = "";
	
	if (searchGb.equals("1")) { 		//����ó �ڵ�
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //����ó
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
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
	var obj = document.TargetForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}
//�˻�
function goSearch() {
	var obj=document.TargetForm;
    var gubun=obj.searchGb.value;
	
	if(gubun=='1'){

		if(obj.searchtxt.value=='' ){
			alert('����ó �ڵ带 �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('����ó�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	obj.action = "<%=request.getContextPath()%>/H_Recovery.do?cmd=reTargetPageList";
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

function goReTargetDetail(companycode,groupid,groupname){
	$('[name=reTargetDetailPageList]').dialog({
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
			
			$(this).load('<%=request.getContextPath()%>/H_Recovery.do?cmd=reTargetDetailPageList',{
				'CompanyCode' : companycode,
				'GroupID' : groupid,
				'GroupName' : encodeURIComponent(groupname)
			});
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
<%=ld.getPageScript("TargetForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=TargetForm action="<%=request.getContextPath()%>/H_Recovery.do?cmd=reTargetPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- ���̾ƿ� ���� -->
		<div class="wrap_bgL">
			<!-- ����Ÿ��Ʋ ���� : ���� -->
			<div class="sub_title">
    			<p class="titleP">ȸ�� ��� ����Ʈ</p>
			</div>
			<!-- ����Ÿ��Ʋ ���� : �� -->

		<!-- �˻� ���� : ���� -->
        <div id="seach_box" >
    	<!-- �˻� > �ѽ��˻� : ���� ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- �ѽ��˻� text : CSS�� ��Ʈ���� -->
    		<!-- �˻� > �׷� �����ڽ� : ����-->
    		    		
	    	<div id="seach">
			<p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
				<p class="psr input_box">
            <%
            
            if("G00000".equals(groupId)){

			    codeParam = new CodeParam();
				codeParam.setType("select"); 
				codeParam.setStyleClass("td3");
				codeParam.setFirst("��ü");
				codeParam.setName("GroupID");
				codeParam.setSelected(vGroupID); 
				codeParam.setEvent(""); 
				out.print(CommonUtil.getCodeListGroup(codeParam)); 

            }else{
            %>
            	<input type="hidden" name="GroupID" value="<%=groupId%>">
            <%
            }
            %>
            </p>
             <p class="input_box"> <!-- ����Ʈ �ڽ� -->
                   <select name="searchGb" onchange="searchChk()">
                       <option value="" checked>��ü</option>
                       <option value="1" <%=aselect%>>����ó �ڵ�</option>
                       <option value="2" <%=bselect%>>����ó</option>
                   </select>
               </p>
                <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- �˻� text box -->
	        
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
		               	  <th>���� ID</th>
		                  <th>������</th>
		                  <th>����ó �ڵ�</th>
		                  <th>����ó</th>
		                  <th>ȸ�� ��� ��ǰ��</th>
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
		                	<td style="cursor: pointer" onclick="goReTargetDetail('<%=ds.getString("CompanyCode")%>','<%=ds.getString("GroupID")%>','<%=ds.getString("GroupName") %>');"><%=ds.getString("GroupID")%></td>
							<td><%=ds.getString("GroupName")%></td>
							<td><%=ds.getString("CompanyCode")%></td>
							<td><%=ds.getString("CompanyName") %></td>
							<td><%=ds.getInt("Pcnt")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="5">���� ������ �����ϴ�.</td>
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
<div name="reTargetDetailPageList" title="ȸ�� ��� �� ǰ��"></div>
</body>
</html>
