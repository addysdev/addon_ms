<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>�׷�������</title>
<link href="<%= request.getContextPath() %>/css/common_2.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/css/popup.css" rel="stylesheet" type="text/css" />
</head>

<body class="pop_body_bgAll">
<!-- ���̾ƿ� ���� -->
<div id="wrap_400">
	<!-- TOP Ÿ��Ʋ ���� -->
	<div id="header">
		<div class="pop_top">
			<p><img src="<%=request.getContextPath()%>/images/popup/text_groupFrame.gif" alt="��ĺз�" /></p>
		</div>
	</div>
	<!-- TOP Ÿ��Ʋ �� -->
	<!-- ���������� ���� -->
	<div id="pop_contents">

		<!-- ���̺� ���� -->
		<div class="pop_list_box">
			<iframe src="<%= request.getContextPath() %>/H_Common.do?cmd=groupTreeList" id="tree" name="tree"  width="360" height="470" scrolling="auto" frameborder="0" class="iframe_table"></iframe><!-- �׷�Ʈ�� ������ -->
		</div>

	</div>
	<!-- ���������� �� -->	
</div>
<!-- ���̾ƿ� �� -->
</body>