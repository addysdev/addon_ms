<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.config.ProductDTO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 

	//���� ���Ѱ��� ���� START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//����� ����
	//���� ���Ѱ��� ���� END
	
	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt");
	int searchTab = (Integer) model.get("searchTab");

	String aselect = "";
	String bselect = "";
	String cselect = "";
	String dselect = "";
	String eselect = "";

	if (searchGb.equals("1")) { 		//����ڸ�(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("2")) { //����� ID(ID)
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("3")) { //�ѽ���ȣ(FaxNo)
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	} else if (searchGb.equals("4")) { //��ȭ��ȣ(OfficeTellNo)
		searchtxt = (String) model.get("searchtxt");
		dselect = "selected";
	} else if (searchGb.equals("5")) { //�׷�ID(GroupID)
		searchtxt = (String) model.get("searchtxt");
		eselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��ǰ ����</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
 var openWin=0;//�˾���ü
var isSearch=0; 
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
	var obj=document.ProductForm;
	var gubun=obj.searchGb.value;
	var invalid = '';	//���� üũ
	
	if(gubun=='1'){

		if(obj.searchtxt.value=='' ){
			alert('��ǰ���� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('��ǰ�ڵ带 �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' ){
			alert('����ó ������ �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.searchtxt.value=='' ){
			alert('���ڵ带 �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='5'){
		if(obj.searchtxt.value=='' ){
			alert('���࿩�θ� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
		if(obj.searchtxt.value=='Y' || obj.searchtxt.value=='N'){
			
			
		}else{
			
			alert('���࿩�δ� Y �Ǵ� N���� �˻� �����մϴ�.');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}

	obj.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productPageList";
	if(observerkey==true){return;}
	openWaiting();
	obj.curPage.value='1';
	obj.submit();
}
//üũ �ڽ� ���� ����(�ٰ�/�ܰ�) 
function goDelete(){
	
	var frm = document.ProductForm;
	var checkYN;
	var checks=0;

	if(frm.seqs.length>1){
		for(i=0;i<frm.seqs.length;i++){
			if(frm.checkbox[i].checked==true){
				checkYN='Y';
				checks++;
			}else{
				checkYN='N';
			}
			frm.seqs[i].value=fillSpace(frm.checkbox[i].value)+'|'+fillSpace(checkYN);
		}
	}else{
		if(frm.checkbox.checked==true){
			checkYN='Y';
			checks++;
		}else{
			checkYN='N';
		}
		frm.seqs.value=fillSpace(frm.checkbox.value)+'|'+fillSpace(checkYN);

	}
	if (checks == 0){
		alert("������ ǰ���� ������ �ּ���!")
	} else {
		if(!confirm("������ �����Ͻðڽ��ϱ�?"))
			return;
		
		frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productDeletes";
		frm.submit();
	}
}
//Excel Export
function goExcel() {
	var frm = document.ProductForm;
	frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productExcelList";	
	frm.submit();
	frm.action = "<%=request.getContextPath()%>/H_Master.do?cmd=productPageList";
}
//��ü ���ý� �˻��ڽ� disable
function searchChk() {
	var obj = document.ProductForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
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

//user��� �˾�
function goRegistForm() {
	$('[name=productRegistForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 610,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=productRegistForm');

		}
	});
}
//��ǰ ���� �˾�
function goModifyForm(productcode) {
	$('[name=productModifyForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 620,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=productModifyForm',{
				'productcode' : productcode
			});
		}
	});
}


//excel update �˾�
function goExcelUpdate(){
	$('[name=companyExcelForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 390,
		width : 420,
		modal : true,
		/* position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		}, */
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=companyExcelForm');
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
<%=ld.getPageScript("ProductForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=ProductForm action="<%=request.getContextPath()%>/H_Master.do?cmd=productPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">

		<!-- ���̾ƿ� ���� -->
		<div class="wrap_bgL">
			<!-- ����Ÿ��Ʋ ���� : ���� -->
			<div class="sub_title">
    			<p class="titleP">Master ��������</p>
			</div>
			<!-- ����Ÿ��Ʋ ���� : �� -->

		<!-- �˻� ���� : ���� -->
        <div id="seach_box" >
    	<!-- �˻� > �ѽ��˻� : ���� ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- �ѽ��˻� text : CSS�� ��Ʈ���� -->
          	       
            <input type="hidden" name="AuthOption" value="Group">

    		<!-- �˻� > �׷� �����ڽ� : ����-->
    		    		
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- ����Ʈ �ڽ� -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>��ü</option>
                       <option value="1" <%=aselect%>>ǰ���ڵ�</option>
                       <option value="2" <%=bselect%>>ǰ���</option>
                       <option value="3" <%=cselect%>>����ó</option>
                       <option value="4" <%=dselect%>>���ڵ�</option>
                       <option value="5" <%=eselect%>>���࿩��</option>
                   </select>
               </p>
			           
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- �˻� text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- ��ȸ ��ư --> 
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="�ŷ�ó �ϰ����" /></a></p>  <!-- ��������� �ϰ���� ������ -->

                   <!-- �˻� ��-->
    	<!-- �˻� > �׷� �����ڽ� : ��-->
		</div>

		</div>
	<!-- �˻� ���� : �� -->     
			<!-- ���̺� : ���� -->
			<div id="code_origin" class="list_box">
			<!-- ������ ��ư ���� -->
	                <div class="btn_box" id="regBt">
	                    <p><a href="javascript:goRegistForm();"><img src="<%=request.getContextPath()%>/images/sub/btn_add_02.gif" title="���" /></a></p>
	 				</div>
			  <!-- ������ ��ư �� -->
			<ul class="listNm">
				<li>��ü�Ǽ� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>��</span></li>
				<li class="last">���������� <span class="blueTxt_b"><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getCurrentPage() ,"0")) %>/<%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalPageCount() ,"0")) %></span></li>
			</ul>
			<div class="tbl_type_out">
				<table cellspacing="0" cellpadding="0" class="tbl_type tbl_typeCen">
		        <caption>��ǰ����</caption>
		            <thead>
		                <tr>
		               	  <th width="30px"><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
		                  <th>ǰ���ڵ�</th>
		                  <th>���ڵ�</th>
		                  <th>ǰ���</th>
		                  <th>����ó</th>
		                  <th>���࿩��</th>
		                  <th>���ʵ������</th>
		                  <th>������������</th>
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
                <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >                              
             
		                <input type="hidden" name="seqs" >
		                	<td><input name="checkbox" type="checkbox" value="<%=ds.getString("ProductCode")%>" /></td>
		                    <td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("ProductCode")%>');"><%=ds.getString("ProductCode")%></td>
							<td><%=ds.getString("BarCode")%></td>
							<td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("ProductCode")%>');"><%=ds.getString("ProductName")%></td>
							<td><%=ds.getString("CompanyName") %></td>
							<td><%=ds.getString("IngYN")%></td>
							<td><%=ds.getString("CreateDateTime")%></td>
							<td><%=ds.getString("UpdateDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
							i++;
							}
						}else {
					%>
					<tr>
						<td colspan="7">�Խù��� �����ϴ�.</td>
					</tr>
					<!-- <script>
						goSearch();
					</script> -->
					<%
						}
					%>
					<!-- ����Ʈ �ϴ� ��ư ���� : ���� -->
					<tr id="list_btn_box">
						<td colspan="8">���õ� �׸� ����<input type="hidden" name="IdongGb" value="Y"><span class="btn"><a href="javascript:goDelete();"><img src="<%=request.getContextPath()%>/images/sub/btn_delete_02.gif" title="����" /></a></span><!-- ��ư -->
						</td>
					</tr>
					<!--����Ʈ �ϴ� ��ư ���� : �� -->
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
<div name="productRegistForm" title="��ǰ�����"></div>
<div name="productModifyForm" title="��ǰ������"></div>
<div name="companyExcelForm" title="�ŷ�ó���� �ϰ����"></div>
</body>
</html>
