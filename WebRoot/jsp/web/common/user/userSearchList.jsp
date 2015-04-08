<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.web.framework.util.*"%>
<%@ page import="com.web.framework.data.DataSet"%>
<%@ page import="com.web.framework.persist.ListDTO"%>
<%@ page import="com.web.framework.util.StringUtil"%>
<%@ page import="com.web.framework.util.DateTimeUtil"%>
<%@ page import="com.web.common.util.*"%>
<%@ page import="com.web.common.CommonDAO"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<%
	CommonDAO comDao=new CommonDAO();
	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = "";
	String aselect = "";
	String bselect = "";
	String cselect = "";
	String dselect = "";

	if (searchGb.equals("01")) { 		//����ڸ�(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("02")) { //����� ID(ID)
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("03")) { //�ѽ���ȣ(FaxNo)
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	} else if (searchGb.equals("04")) { //�̸���(Email)
		searchtxt = (String) model.get("searchtxt");
		dselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>�����˻�</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<script>
var observer;//ó����
var observerkey=false;//ó���߿���
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

// �˻�
function goSearch() {
	var obj=document.UserSearchForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//���� üũ
		
		if(gubun=='01'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('����� �̸��� �Է��� �ּ���');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='02'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('����� ID�� �Է��� �ּ���');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='03'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('�ѽ���ȣ�� �Է��� �ּ���');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='04'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('�̸��� �ּҸ� �Է��� �ּ���');
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

function searchChk() {
	var obj = document.UserSearchForm;

	if (obj.searchGb[0].selected == true) {
		obj.searchtxt.disabled = true;
		obj.searchtxt.value = '';
	} else {
		obj.searchtxt.disabled=false;
	}
}

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
%>
<%=ld.getPageScript("UserSearchForm", "curPage", "goPage")%>
<body id="popup">
<form method="post" name=UserSearchForm action="<%=request.getContextPath()%>/H_Common.do?cmd=userSearchList">
		<input type="hidden" name="curPage" value="<%=curPage%>"> 
<!-- ���̾ƿ� ���� -->
<div id="wrap_600">

	<!-- TOP Ÿ��Ʋ ���� -->
	<div id="header">
    	<div class="pop_top">
			<p><img src="<%=request.getContextPath()%>/images/popup/text_User_seach.gif" width="199" height="44" /></p>
    	</div>
    </div>
	<!-- TOP Ÿ��Ʋ �� -->

	<!-- ���������� ���� -->
    <div id="pop_contents">

        <!-- �˻� ���� -->
        <div id="sch_wrap">
                
            <!-- �����˻� ���� -->
            <div id="sch_box">
                <p>&nbsp;</p>
                <ul>
                   <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li><img src="<%=request.getContextPath()%>/images/popup/btn_selection.gif" width="42" height="21" title="����" /></li>
                </ul> 
            </div>
            <!-- �����˻� �� -->

            <!-- �����˻� ���� -->
            <div id="sch_box_02">
                <p></p>
                <ul>
                    <li>
                       <select name="searchGb" class="seach2"  onChange="searchChk()">
									<option value="ALL" checked>��ü</option>
									<option value="01" <%=aselect%>>����ڸ�</option>
									<option value="02" <%=bselect%>>ID</option>
									<option value="03" <%=cselect%>>�ѽ���ȣ</option>
									<option value="04" <%=dselect%>>eMail</option>
							</select>
                    </li>
                    <li><input name="searchtxt" type="text"   maxlength="20"  /></li>
                    <li><img src="<%=request.getContextPath()%>/images/popup/btn_find.gif" width="42" height="21" /></li>
                </ul>
                <ul class="mg">
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="��ü">��ü</option>
                            <option value="�̸�">�̸�</option>
                            <option value="��Ÿ">��Ÿ</option>
                          </select>
                    </li>
                </ul>
            </div>	
            <!-- �����˻� ��-->
           
 	  </div>
      <!-- �˻� �� -->
      
      <!-- ���̺� ���� -->
      <div id="tblPop" class="tbl_out">
      <table width="100%" border="0" cellspacing="1" class="tbl_pop">
      	<caption>�̰���� �˻�</caption>
              <thead>
                  <tr>
                    <th colspan="12">��ü�Ǽ� 0��, ���������� 1/1</th>
                  </tr>
                  <tr>
                    <th>����ڸ�</th>
                    <th>ID</th>
                    <th>�Ҽ�</th>
                    <th>�ѽ���ȣ</th>
                    <th>E-mail</th>
                  </tr>
               </thead>
               
               <tbody>
			   <!-- :: loop :: -->
						<!--����Ʈ---------------->
						<%
						if (ld.getItemCount() > 0) {
							int i = 0;
							while (ds.next()) {
						%>
                  <tr>
                    <td><%=ds.getString("Name")%></td>
                    <td><%=ds.getString("ID")%></td>
                    <td><%=ds.getString("GroupID")%></td>
                    <td><%=ds.getString("FaxNo")%></td>
                    <td><%=ds.getString("Email")%></td>
                  </tr>
                 <!-- :: loop :: -->
						<%
							i++;
							}
						} else {
						%>
						<tr align=center valign=top>
							<td colspan="5" align="center" >�Խù��� �����ϴ�.</td>
						</tr>
						<%
						}
						%>
                  </tbody>
            </table>
		</div>
        <!-- ���̺� �� -->
        
        <!-- �������ѹ� START -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<br>
						<tr align="center">
							<td><%=ld.getPagging("goPage")%></td>
						</tr>
					</table> 
		<!-- �������ѹ� END -->
        
  	</div>
	<!-- ���������� �� -->

	<!-- bottom ���� -->
	<div id="bottom">
    	<div class="bottom_top"></div>
    </div>
	<!-- bottom �� -->

</div>
<!-- ���̾ƿ� �� -->

</body>
</html>
