<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>�׷����������</title>
<link href="<%= request.getContextPath() %>/css/common_2.css" rel="stylesheet" type="text/css" />
</head>

<body>
 <!-- ���������� ���̺� START -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top">
            <table vspace="top" width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                <td height="10">&nbsp;</td>
              </tr>
              <tr>
                <td height="35"><img src="<%= request.getContextPath() %>/images/popup/text_faxSearchPower-.gif" width="85" height="14" /></td>
              </tr>
              <tr>
                <td><iframe src="<%= request.getContextPath() %>/H_Common.do?cmd=authTreeList" id="tree" name="tree"  width="300" height="475" scrolling="auto" frameborder="0" class="iframe_table"></iframe></td><!-- �׷�Ʈ�� ������ -->
              </tr>
          </table>
         </td>
        </tr>
      </table>
</body>