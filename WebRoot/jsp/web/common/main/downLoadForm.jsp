<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.framework.util.StringUtil"%>
<%@ include file="/jsp/web/common/base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ٿ�ε�</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common_1.js"></script>
<script>
function viewerDownload(){
	
	location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IView100_Setup.exe';
	
	/*
	var OSBit = navigator.userAgent;
	
	if(OSBit.indexOf("Win64") != -1) {//64bit
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IView100_Setup_x64.exe';
	
	}else {
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IView100_Setup.exe';
		
	}	
	*/
}
<%-- ��ĵ���α׷� �ٿ�ε�
function scanDownload(){
	
	location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IScan100_Setup.exe';
	
	/*
	var OSBit = navigator.userAgent;
	
	if(OSBit.indexOf("Win64") != -1) {//64bit
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IScan100_Setup_x64.exe';
	
	}else {
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HF_IScan100_Setup.exe';
		
	}
	*/
		
}
--%>

//�˶����α׷� �ٿ�ε�
function alimDownload(){
	
	//win32 bit
	location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HFCAGSETUP.EXE';
	
	<%--
	var OSBit = navigator.userAgent;
	
	if(OSBit.indexOf("Win64") != -1) {//64bit
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HFCAGSETUP.EXE';
	
	}else {
		
		location.href='<%=request.getContextPath()%>/fileDownServlet?sFileName=HFCAGSETUP.EXE';
		
	}
	--%>
		
}
</script>
</head>

<body id="popup" <%=BODYEVENT %> class="pop_body_bgAll">
<form name="reSendFrm">
<!-- ���̾ƿ� ���� -->
<div id="wrap_300">

      <!-- TOP Ÿ��Ʋ ���� -->
      <div id="header">
          <div class="pop_top">
              <p><img src="<%=request.getContextPath()%>/images/popup/text_program.gif" alt="���α׷�������ġ" /></p>
          </div>
      </div>
      <!-- TOP Ÿ��Ʋ �� -->
  
      <!-- ���������� ���� -->
      <div id="pop_contents">

        <!-- ���̺� ���� -->
		  <div class="pop_list_box">
			<div class="tbl_type_out">
	        <table cellspacing="0" cellpadding="0" class="tbl_type downloadPop">
            <tbody>
                <tr>
                    <td><span class="ico_arr_g">������α׷� ������ġ����</span><span class="btnAlign"><a href="javascript:viewerDownload()"><img src="<%=request.getContextPath()%>/images/popup/btn_download.gif"  onmouseover="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onclick="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onmouseout="this.src='<%= request.getContextPath() %>/images/popup/btn_download.gif'" title="������α׷� �����ޱ�" /></a></span></td>
                </tr>
                <tr>
                <!-- 
                   <td><span class="ico_arr_g">��ĵ���α׷� ������ġ����</span>&nbsp;&nbsp;<a href="javascript:scanDownload()"><img src="<%=request.getContextPath()%>/images/popup/btn_download.gif"  onmouseover="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onclick="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onmouseout="this.src='<%= request.getContextPath() %>/images/popup/btn_download.gif'" title="��ĵ���α׷� �����ޱ�" /></a></td>
                 -->
                 <td><span class="ico_arr_g">�˶����α׷� ������ġ����</span><span class="btnAlign"><a href="javascript:alimDownload()"><img src="<%=request.getContextPath()%>/images/popup/btn_download.gif"  onmouseover="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onclick="this.src='<%= request.getContextPath() %>/images/popup/btn_download_on.gif'" onmouseout="this.src='<%= request.getContextPath() %>/images/popup/btn_download.gif'" title="�˶����α׷� �����ޱ�" /></a></span></td>
                </tr>
                
            </tbody>
        </table>
		</div>
		</div>
        <!-- ���̺� �� -->
		<!-- bottom ���� -->
		<div id="bottom">
			<div class="bottom_top">
				<a href="javascript:window.close();"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="���" /></a>
			</div>
		</div>
		<!-- bottom �� -->

	</div>
	<!-- ���������� �� -->
</div>
<!-- ���̾ƿ� �� -->
</form>
</body>
</html>
