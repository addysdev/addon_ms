<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ include file ="/jsp/web/common/base.jsp" %>
<%
String userid=StringUtil.nvl(dtoUser.getUserId(),"");
String menuAuth="";//메뉴권한

CodeParam codeParam = new CodeParam();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>제품 등록</title>
<link href="<%= request.getContextPath()%>/css/common_1.css" rel="stylesheet" type="text/css" />
<script>
//ID check 
function fnDuplicateCheck(val) {
	if($('#productRegist [name=productCode]').val() == ""){
		$('#productRegist #chkAlert').hide();
	}else{
		
	$.ajax({
		url : "<%= request.getContextPath()%>/H_Master.do?cmd=productDupCheck",
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"productcode" : val
		},
		success : function(data, textStatus, XMLHttpRequest){
			//alert(data);
				switch (data){
				case "" : alert("제품코드 중복 체크 오류!");break;
				case "1": 
					$('#productRegist #chkAlert').attr("color","red");
					$('#productRegist #chkAlert').show().html("이미 사용 중입니다.");break;
				case "2":
					$('#productRegist #chkAlert').attr("color","red");
					$('#productRegist #chkAlert').show().html("사용 불가능합니다.");break;
				case "0":
					$('#productRegist #chkAlert').attr("color","blue");
					$('#productRegist #chkAlert').show().html("사용 가능합니다.");break;
				}	
			
			/*
			if(data != 0){
				check=1;		
			}
			*/
		},
		error : function(request, status, error){
			alert("중복체크 오류!");
		}
	});
	}
}
// 저장
function goSave(){
	
	var frm = document.productRegist; 
	if(frm.productName.value.length == 0){
		alert("품목을 입력하세요");
		return;
	}
	
	if(frm.productCode.value.length == 0){
		alert("품목코드를 입력하세요");
		return;
	}
	
	if($('#productRegist #chkAlert').attr("color")== "red"){
		alert("품목코드를 확인하세요");
		return;
	}
	
	if(frm.CompanyCode.value.length == 0){
		alert("구매처를 선택하세요.");
		return;
	}

	if(confirm(frm.productName.value+"품목을 등록 하시겠습니까?")){
		frm.submit();
	}else{
		return;
	}

}
</script>
</head>
<!-- 처리중 시작 -->
<!-- 처리중 종료 -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=productRegist id="productRegist"  action="<%=request.getContextPath()%>/H_Master.do?cmd=productRegist">
	  
	  <!-- 컨텐츠시작 -->
	  <div class="ly_pop_new">
	      <!-- 테이블 시작 -->
				<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">품목명 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="35" name="productName" id="productName" maxlength="30" value="" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>품목코드 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="productCode" id="productCode" maxlength="20" value="" tabindex="3" onkeyup="fnDuplicateCheck(this.value)" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>바코드</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="BarCode" maxlength="14" value="" tabindex="4" dispName="바코드" /></td>
	                        </tr>
	                       <tr>
	                            <th>구매처 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<%
									    codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("선택");
										codeParam.setName("CompanyCode");
										codeParam.setSelected(""); 
										codeParam.setEvent(""); 
										out.print(CommonUtil.getCodeListCompany(codeParam)); 
									%>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>입고단가</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="ProductPrice" maxlength="14" value="" tabindex="4" dispName="입고단가" /></td>
	                        </tr>
	                       <tr>
	                            <th>부가세비율</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="VatRate" maxlength="14" value="" tabindex="4" dispName="부가세비율" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹1</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1" maxlength="14" value="" tabindex="4" dispName="바코드" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹1명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                         <tr>
	                            <th>그룹2</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹2명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>      
	                         <tr>
	                            <th>그룹3</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹3명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3name" maxlength="14" value="" tabindex="4" dispName="" /></td>
	                        </tr>            
	                    </tbody>
	                </table>
			   </div>
	           <!-- 테이블 끝 -->
			   <!-- bottom 시작 -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_add.gif" title="등록" /></a><a href="javascript:goClosePop('productRegistForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
				<!-- bottom 끝 -->
			</div>
			<!-- 컨텐츠끝 -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
			</div>
</form>
</body>
</html>
