<%@ page contentType="text/html; charset=euc-kr"%>
<script language="JavaScript">

<!--
	function tmt_winLaunch(theURL,winName,targetName,features) {
		eval(winName+"=window.open('"+theURL+"','"+targetName+"','"+features+"')");
	}
	function init(){

	var h=screen.height-(screen.height*(8.5/100));
	var s=screen.width-10;

	//alert('귀하의 모니터 해상도는 ' + s + ' x ' + h + '입니다.');
	tmt_winLaunch('<%= request.getContextPath()%>/H_Login.do?cmd=main', 'qaz', 'qaz', 'status=yes,width='+s+',height ='+h+',left=0,top=0');

	}
	parent.close();
//-->
</script>
<body onLoad = "init();">
</body>