<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.user.UserDTO"%>
<%@ page import="com.web.common.user.UserDAO"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/main/top.jsp" %>

<% 


	//���� ���Ѱ��� ���� START
	String userId=StringUtil.nvl(dtoUser.getUserId(),"");//����� ����
	String excelEnabledCheck="";//���� ��ȸ����
	String authID=StringUtil.nvl(dtoUser.getAuthid(),"");//�ѽ���ȸ����
	String authUpGroupID="";//�ѽ���ȸ ���� ���� 
	String authGroupStep="";//�ѽ���ȸ���� �ܰ�
	String groupUserAuthYN="";//�ѽ���ȸ���� �ɼ�(�������Կ���)
	String groupUserAuthYNOption="";//�����ѽ� ���Խ� �߰��ɼ�
	String search_authID ="";//��ȸ���� return
	String SearchAuthBox ="";//��ȸ���� return
	String sGroup1 = "";//��ȸ���� return
	String sGroup2 = "";//��ȸ���� return
	String sGroup3 ="";//��ȸ���� return
	String sGroup4 ="";//��ȸ���� return
	String sGroup5 ="";//��ȸ���� return
	//���� ���Ѱ��� ���� END

	CommonDAO comDao=new CommonDAO();
	
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
<title>���� ����</title>
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

//���, Ȱ��ȭ ����, ��Ȱ��ȭ ���� �������� ����
function selectTab(num){
	var obj = document.UserForm;
	obj.searchTab.value = num;
	
	
	obj.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
	if(observerkey==true){return;}
	openWaiting();
	//obj.curPage.value='1';
	obj.submit();
}


//�˻�
function goSearch() {
	var obj=document.UserForm;
	//var obj2=document.UserRegist;
	var gubun=obj.searchGb.value;
	var invalid = '';	//���� üũ
	
	

	if(gubun=='1'){

		if(obj.searchtxt.value=='' ){
			alert('����� �̸��� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='2'){
		if(obj.searchtxt.value=='' ){
			alert('����� ID�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='3'){
		if(obj.searchtxt.value=='' ){
			alert('�ѽ���ȣ�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='4'){
		if(obj.searchtxt.value=='' ){
			alert('��ȭ��ȣ�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}else if(gubun=='5'){
		if(obj.searchtxt.value=='' ){
			alert('�׷�ID�� �Է��� �ּ���');
			obj.searchtxt.value="";
			obj.searchtxt.focus();
			return;
		}
	}
	if(obj.AuthID.value=='S'){
		obj.AuthID.value='';
	}
	obj.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
	if(observerkey==true){return;}
	openWaiting();
	obj.curPage.value='1';
	obj.submit();
}
//���� �˾�
function goDetail(ID){

	    if(true){
	
			var url = "<%=request.getContextPath()%>/H_User.do?cmd=userModifyForm";
			var params = "&UserID=" + ID;
		
			if(openWin != 0) {
				  openWin.close();
			}
			
			openWin=window.open(url + params, "", "width=400, height=475,toolbar=no, menubar=no, scrollbars=no, status=no");
       }else{
    	   
    	   alert('�ܺ� ������ ���� ���� ������ �����ϴ�.');
    	   return;
    	   
       }
}
//��� �˾�
function goRegist() {
	if(openWin != 0) {
		  openWin.close();
	}
	openWin=window.open("<%=request.getContextPath()%>/H_User.do?cmd=userRegistForm","","width=400, height=442, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
}
//üũ�ڽ� ��ü ����
function fnCheckAll(objCheck) {
	  var arrCheck = document.getElementsByName('checkbox');
	  
	  for(var i=0; i<arrCheck.length; i++){
	  	if(objCheck.checked) {
	    	arrCheck[i].checked = true;
	    } else {
	    	arrCheck[i].checked = false;
	    }
	 }
}
//üũ �ڽ� ���� ����(�ٰ�/�ܰ�) 
function goDelete(){
	
	var frm = document.UserForm;
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
		alert("������ ����ڸ� ������ �ּ���!")
	} else {
		if(!confirm("������ �����Ͻðڽ��ϱ�?"))
			return;
		
		frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userDeletes";
		frm.submit();
	}
}
//Excel Export
function goExcel() {
	var frm = document.UserForm;
	frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userExcelList";	
	frm.submit();
	frm.action = "<%=request.getContextPath()%>/H_User.do?cmd=userPageList";
}
//��ü ���ý� �˻��ڽ� disable
function searchChk() {
	var obj = document.UserForm;

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
	$('[name=userRegistForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 420,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userRegistForm');

		}
	});
}
//user���� �˾�
function goModifyForm(userid) {
	$('[name=userModifyForm]').dialog({
		resizable : true, //������ ���� �Ұ���
		draggable : true, //�巡�� �Ұ���
		closeOnEscape : true, //ESC ��ư �������� ����
		
		height : 420,
		width : 420,
		modal : true,
		position : {
			my : 'left top',
			at : 'right top',
			of : $('#regBt')
		},
		open:function(){
			
			//�˾� ������ url
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userModifyForm',{
				'UserID' : userid
			});
		}
	});
}


//excel update �˾�
function goExcelUpdate(){
	$('[name=userExcelForm]').dialog({
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
			$(this).load('<%=request.getContextPath()%>/H_User.do?cmd=userExcelForm');
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
	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("UserForm", "curPage", "goPage")%>
<body onLoad="" class="body_bgAll">
	<form method="post" name=UserForm action="<%=request.getContextPath()%>/H_User.do?cmd=userPageList">
		<input type="hidden" name="curPage" value="<%=curPage%>">
		<!-- <input type="hidden" name="users" value="">
		<input type="hidden" name="SearchGroup" value=""> -->
		<input type="hidden" name="searchTab" value="<%=searchTab%>">

		<!-- ���̾ƿ� ���� -->
		<div class="wrap_bgL">
			<!-- ����Ÿ��Ʋ ���� : ���� -->
			<div class="sub_title">
    			<p class="titleP">��������</p>
				<ul class="seachNm">
					<li style="cursor: pointer;" onclick="selectTab('1')">��� <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getTotCount(),"0")) %>��</span></li>
					<li style="cursor: pointer;" onclick="selectTab('2')">Ȱ��ȭ ���� <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getUseYN_YCount(),"0")) %>��</span></li>
					<li style="cursor: pointer;" onclick="selectTab('3')">��Ȱ��ȭ ���� <span class="blueTxt_b"><%=userDto == null ? "0" : NumberUtil.getPriceFormat(StringUtil.nvl(userDto.getUseYN_NCount() ,"0")) %>��</span></li>
				</ul>
			</div>
			<!-- ����Ÿ��Ʋ ���� : �� -->

		<!-- �˻� ���� : ���� -->
        <div id="seach_box" >
    	<!-- �˻� > �ѽ��˻� : ���� ( hieght:35px )-->
    		<p class="fax_seach"> </p> <!-- �ѽ��˻� text : CSS�� ��Ʈ���� -->
			          	
          	<!--input type="hidden" name="AuthID" value="<%=authID%>"--><!-- ��ȸ�� ����� or �׷���̵� -->
          	<!--input type="hidden" name="AuthGroup" value="<%=groupUserAuthYN%>"--><!-- ��ȸ�� ����� ���Կ��� �ɼ� -->
          	<input type="hidden" name="AuthID" value="G0000000"><!-- ��ȸ�� ����� or �׷���̵� -->
          	<input type="hidden" name="AuthGroup" value="Y"><!-- ��ȸ�� ����� ���Կ��� �ɼ� -->
          	<input type="hidden" name="cmUserID" value="<%=userId%>"><!-- ����� ID(�����) -->
          	<input type="hidden" name="cmAuthID" value="<%=authID%>"><!-- �׷� ���� ID(�����) -->
          	<input type="hidden" name="cmUpAuthID" value="<%=authUpGroupID%>"><!-- �׷� ���� ���� ID(�����) -->
          	<input type="hidden" name="cmAuthStep" value="<%=authGroupStep%>"><!-- �׷� Step(�����) -->
          	<input type="hidden" name="SearchAuthBox" value="<%=SearchAuthBox%>"><!-- ��ȸ�� ����Ʈ �ڽ���(����) -->
          	<input type="hidden" name="sGroup1" value="<%=sGroup1%>"><!-- ��ȸ�� ����Ʈ �ڽ��� -->
          	<input type="hidden" name="sGroup2" value="<%=sGroup2%>"><!-- ��ȸ�� ����Ʈ �ڽ��� -->
          	<input type="hidden" name="sGroup3" value="<%=sGroup3%>"><!-- ��ȸ�� ����Ʈ �ڽ��� -->
          	<input type="hidden" name="sGroup4" value="<%=sGroup4%>"><!-- ��ȸ�� ����Ʈ �ڽ��� -->
          	<input type="hidden" name="sGroup5" value="<%=sGroup5%>"><!-- ��ȸ�� ����Ʈ �ڽ��� -->
          	       
            <input type="hidden" name="AuthOption" value="Group">

    		<!-- �˻� > �׷� �����ڽ� : ����-->
    		    		
	    	<div id="seach">
			  <p class="titleS"><img src="<%=request.getContextPath()%>/images/sub/title_seach_box.gif" /></p>
		      <p class="input_box"> <!-- ����Ʈ �ڽ� -->
                   <select name="searchGb" onChange="searchChk()">
                       <option value="" checked>��ü</option>
                       <option value="1" <%=aselect%>>����ڸ�</option>
                       <option value="2" <%=bselect%>>ID</option>
                       <option value="3" <%=cselect%>>�׷��</option>
                   </select>
               </p>
			           
	                  <p class="input_box"><input type="text" name="searchtxt" id="textfield" maxlength="20"  value="<%=searchtxt%>" onkeydown = "if(event.keyCode == 13)  goSearch()" style="ime-mode:inactive;" class="seach_text" /> </p> <!-- �˻� text box -->
	                  <p class="btn"><a href="javascript:goSearch();"><img src="<%=request.getContextPath()%>/images/sub/btn_find.gif" /></a> </p> <!-- ��ȸ ��ư --> 
	                  <p class="icon"><a href="javascript:goExcel();"><img src="<%=request.getContextPath()%>/images/sub/icon_excel.gif" title="���� �ٿ�ε�" /></a></p> <!-- ���� ������ -->
	                  <p class="icon"><a href="javascript:goExcelUpdate();"><img src="<%=request.getContextPath()%>/images/sub/icon_exceluserup.gif" title="��������� �ϰ����" /></a></p>  <!-- ��������� �ϰ���� ������ -->
	                  <!--<p class="input_box"><img src="<%=request.getContextPath()%>/images/sub/icon_excel_up.gif" width="16" height="16" title="���� ���ε�" /> </p> <!-- ���� ������ --> 

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
		        <caption>��������</caption>
		            <thead>
		                <tr>
		               	  <th width="30px"><input name="checkboxAll" type="checkbox" onclick="fnCheckAll(this)" /></th>
		                  <th>����ڸ�</th>
		                  <th>ID</th>
		                  <th>�׷��</th>
		                  <th>��ȭ��ȣ</th>
		                  <th>��뿩��</th>
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
					<% 
					
                 if (ds.getString("ImageOpenDate").equals("")){
	                    	
	            	%>
	                    	        
                <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >
                              
                <%
	                    }else {
	            %>
                 <tr name="tdonevent" id="tdonevent" style="cursor:hand;background-color:<%= rowClass%>;" onmouseover="fnLayerover(<%=i%>);" onmouseout="fnLayerout(<%=i%>,'<%=rowClass%>');"   >               	
				<% 
	                    }
						
					String DIDformat ="";
					if(!ds.getString("FaxNumCnt").equals("")){
						if(ds.getString("FaxNumCnt").equals("1")){
							DIDformat = ds.getString("DID");
						}else{
							DIDformat = ds.getString("DID")+" ("+ ds.getString("FaxNumCnt")+")";
						}
						 
					}
	            %>	
	            <!-- Ȯ�� ��Ȯ�� ���� ����ó�� �� -->
		                <input type="hidden" name="seqs" >
		                	<td><input name="checkbox" type="checkbox" value="<%=ds.getString("UserID")%>" /></td>
		                    <td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("UserID")%>');"><%=ds.getString("UserName")%></td>
							<td style="cursor: pointer" onclick="goModifyForm('<%=ds.getString("UserID")%>');"><%=ds.getString("UserID")%></td>
							<td><%=ds.getString("GroupName") %></td>
							<td><%=ds.getString("OfficePhoneFormat")%></td>
							<td><%=ds.getString("UseYN")%></td>
							<td><%=ds.getString("CreateDateTime")%></td>
							<td><%=ds.getString("UpdateDateTime")%></td>
		                </tr>
		               
		          	<!-- :: loop :: -->
					<%
						i++;
							}
						} else {
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
<div name="userRegistForm" title="����ڵ����"></div>
<div name="userModifyForm" title="����ڼ�����"></div>
<div name="userExcelForm" title="��������� �ϰ����"></div>
</body>
</html>
<!-- <script>
	searchChk();
</script> -->