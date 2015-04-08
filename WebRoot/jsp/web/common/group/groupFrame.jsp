<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>그룹프레임</title>
<link href="<%= request.getContextPath() %>/css/common_2.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/css/popup.css" rel="stylesheet" type="text/css" />
</head>

<body class="pop_body_bgAll">
<!-- 레이아웃 시작 -->
<div id="wrap_400">
	<!-- TOP 타이틀 시작 -->
	<div id="header">
		<div class="pop_top">
			<p><img src="<%=request.getContextPath()%>/images/popup/text_groupFrame.gif" alt="양식분류" /></p>
		</div>
	</div>
	<!-- TOP 타이틀 끝 -->
	<!-- 메인컨텐츠 시작 -->
	<div id="pop_contents">

		<!-- 테이블 시작 -->
		<div class="pop_list_box">
			<iframe src="<%= request.getContextPath() %>/H_Common.do?cmd=groupTreeList" id="tree" name="tree"  width="360" height="470" scrolling="auto" frameborder="0" class="iframe_table"></iframe><!-- 그룹트리 프레임 -->
		</div>

	</div>
	<!-- 메인컨텐츠 끝 -->	
</div>
<!-- 레이아웃 끝 -->
</body>