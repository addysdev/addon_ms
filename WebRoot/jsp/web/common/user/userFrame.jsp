<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>�׷�������</title>
<link href="<%= request.getContextPath() %>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
function goSearch(){

	var obj=document.UserSearchFrm;
	var uid=document.UserSearchFrm.UserID.value;

	obj.action='<%= request.getContextPath() %>/H_Common.do?cmd=userTree&UserID='+uid;
	obj.target="tree";
	obj.submit();

}
function captureReturnKey(e) {
	 if(e.keyCode==13 && e.srcElement.type != 'textarea')
	 //return false;
	 goSearch();
}

</script>
</head>

<body>
<form name="UserSearchFrm" method="post" onkeydown="return captureReturnKey(event)">
 <!-- ���������� ���̺� START -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top">
            <table vspace="top" width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                <td height="10">&nbsp;</td>
              </tr>
              <tr>
                <td height="35"><img src="<%= request.getContextPath() %>/images/popup/text_user-search.gif" width="103" height="15" /></td>
              </tr>
              <tr>
                <td><iframe src="<%= request.getContextPath() %>/H_Common.do?cmd=userTree&UserID=" id="tree" name="tree"  width="310" height="420" scrolling="auto" frameborder="0" class="iframe_table"></iframe></td><!-- �׷�Ʈ�� ������ -->
              </tr>
               <!-- ��ȸ���� �� ���� START -->
              <tr>
                <td><table width="312" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="40" align="center" class="textField2">�����(ID)�˻� &nbsp;:&nbsp; 
                    <input name="UserID" type="text" class="textField" id="textfield_search" />
                    <img src="<%= request.getContextPath() %>/images/sub/spacer.gif" width="10" height="1" />
                    <a href="javascript:goSearch();"><img src="<%= request.getContextPath() %>/images/sub/popup_btn_find.gif" width="45" height="23" border="0" align="absmiddle" usemap="#Map2" alt="��ȸ" title="��ȸ" onFocus="this.blur();" border="0"/></a>
                    </td>
                  </tr>
                </table></td>
              </tr>
              <!-- ��ȸ���� �� ���� END -->
          </table>
         </td>
        </tr>
      </table>
  </form>    
</body>