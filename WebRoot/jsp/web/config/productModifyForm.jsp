<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.web.framework.util.*"%>
<%@ page import ="com.web.framework.data.DataSet"%>
<%@ page import ="com.web.framework.persist.ListDTO"%>
<%@ page import ="com.web.common.util.*"%>
<%@ page import ="com.web.common.CodeParam"%>
<%@ page import ="com.web.common.BaseAction"%>
<%@ page import ="com.web.common.config.ProductDTO"%>
<%@ page import ="com.web.common.user.UserMemDTO"%>
<%@ include file ="/jsp/web/common/base.jsp" %>
<%
String userid=StringUtil.nvl(dtoUser.getUserId(),"");
String menuAuth="";//메뉴권한

ProductDTO productDto = (ProductDTO)model.get("productDto");

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
	if($('#productModify [name=employeeID]').val() == ""){
		$('#productModify #chkAlert').hide();
	}else{
		
	$.ajax({
		url : "<%= request.getContextPath()%>/H_User.do?cmd=userDupCheck",
		type : "post",
		dataType : "text",
		async : false,
		data : {
			"userid" : val
		},
		success : function(data, textStatus, XMLHttpRequest){
			//alert(data);
				switch (data){
				case "" : alert("사용자ID 중복 체크 오류!");break;
				case "1": 
					$('#productModify #chkAlert').attr("color","red");
					$('#productModify #chkAlert').show().html("이미 사용 중입니다.");break;
				case "2":
					$('#productModify #chkAlert').attr("color","red");
					$('#productModify #chkAlert').show().html("사용 불가능합니다.");break;
				case "0":
					$('#productModify #chkAlert').attr("color","blue");
					$('#productModify #chkAlert').show().html("사용 가능합니다.");break;
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
	var frm = document.productModify; 
	
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

	if(frm.Recovery[0].checked==true){
		frm.RecoveryYN.value='N';
	}else{
		frm.RecoveryYN.value='Y';	
	}
	
	if(frm.RecoveryYN.value=='Y'){
		if(confirm(frm.productName.value+"품목을 회수 하시겠습니까?\n회수시 모든 조직에 설정된 안전재고 수량은 0 이 되며\n재고수량은 회수대상에 포함됩니다.")){
			frm.submit();
		}else{
			return;
		}
	}else{
		if(confirm(frm.productName.value+"품목을 수정 하시겠습니까?")){
			frm.submit();
		}else{
			return;
		}
	}
}

//안전재고 관리 레이아웃 팝업
function safeStockList(){
	
	if( document.productModify.RecoveryYN.value=='Y'){

		alert('회수 상태에선 안전재고 관리가 불가능합니다.\n상태값을 진행상태로 변경하여 수정후 조회하십시오.');
		return;
	}
	
	
	$('#safeStockList').dialog({
		resizable : true, //사이즈 변경 불가능
		draggable : true, //드래그 불가능
		closeOnEscape : true, //ESC 버튼 눌렀을때 종료
		
		height : 450,
		width : 450,
		autoOpen : false,
		modal : true,
		
		position : {
			my: 'left',
			at: 'right',
			of: $('#safeStoks')
		},
		
		open:function(){
			
			//팝업 가져올 url
			$(this).load('<%=request.getContextPath()%>/H_Master.do?cmd=safeStockList',{
				"productcode" : $('#productCode').val() 
			});
		}
	});
	$( "#safeStockList" ).dialog( "open" );
}
//진행여부 세팅
$(function(){
	
	var RecoveryYN 	= "<%=productDto.getRecoveryYN()%>";
	var frm = document.productModify; 
	
	switch (RecoveryYN){
	case "N" : 
		 $('#productModify #radio1').attr("checked","checked");
		break;
	case "Y" : 
		 $('#productModify #radio2').attr("checked","checked");
		break;
	}

});
</script>
</head>
<!-- 처리중 시작 -->
<!-- 처리중 종료 -->
<body id="popup" class="pop_body_bgAll">
	<form  method="post" name=productModify id="productModify"  action="<%=request.getContextPath()%>/H_Master.do?cmd=productModify">
	  
	  <!-- 컨텐츠시작 -->
	  <div class="ly_pop_new">
	      <!-- 테이블 시작 -->
				<p class="text_guide"><strong class="blueTxt">*</strong> 표시는 필수 입력 항목입니다.</p>
				<div id="userForm" class="tbl_type_out ">
	                <table cellspacing="0" cellpadding="0" class="tbl_type">
	                    <tbody>
	                        <tr>
	                            <th style="width:130px;">품목명 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box"><input type="text" size="35" name="productName" id="productName" maxlength="30"  value="<%=productDto.getProductName() %>" tabindex="2"/></td>
	                        </tr>
	                        <tr>
	                        	<th>품목코드 <strong class="blueTxt" title="필수입력">*</strong></th>
	                            <td class="input_box">
	                            	<input type="text" size="20" name="productCode" id="productCode" readOnly maxlength="20" value="<%=productDto.getProductCode() %>"  tabindex="3" style="IME-MODE : disabled"/>
	                            	<font style="display: none;" id="chkAlert" >이미 사용 중입니다.</font>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>바코드</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="BarCode" maxlength="14" value="<%=productDto.getBarCode() %>"  tabindex="4" dispName="바코드" onKeyUp="format_phone(this);"/></td>
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
										codeParam.setSelected(productDto.getCompanyCode()); 
										codeParam.setEvent(""); 
										out.print(CommonUtil.getCodeListCompany(codeParam)); 
									%>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>안전재고관리</th>
	                            <input type="hidden" name="RecoveryYN" value="<%=productDto.getRecoveryYN()%>">
	                            <td>
	                            상태:
	                            <%
	                            	if(productDto.getRecoveryYN().equals("Y")){
	                            %>
	                            	   회수
	                            <%		
	                            	}else{
	                             %>
	                             진행
	                              <%		
	                            	}
	                            %>
	                            <input type="radio" name="Recovery" id="radio1" value="N"  /> <span class="vm">진행</span>
	  								<input type="radio" name="Recovery" id="radio2" value="Y" /><span class="vm"> 회수</span>
	  								<a href="javascript:safeStockList()" id="safeStoks" title="조회" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GroupBt','','<%=request.getContextPath()%>/images/sub/btn_search00_on.gif',1)"><img src="<%=request.getContextPath()%>/images/sub/btn_search00.gif" name="GroupBt" id="GroupBt" /></a><!-- 조회버튼 -->
	                            </td>
	                        </tr>
	                          <tr>
	                            <th>입고단가</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="ProductPrice" maxlength="14" value="<%=productDto.getProductPrice()%>" tabindex="4" dispName="입고단가" /></td>
	                        </tr>
	                       <tr>
	                            <th>부가세비율</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="VatRate" maxlength="14" value="<%=productDto.getVatRate()%>" tabindex="4" dispName="부가세비율" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹1</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1" maxlength="14" value="<%=productDto.getGroup1() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹1명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group1name" maxlength="14" value="<%=productDto.getGroup1Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                         <tr>
	                            <th>그룹2</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2" maxlength="14" value="<%=productDto.getGroup2() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹2명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group2name" maxlength="14" value="<%=productDto.getGroup2Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>      
	                         <tr>
	                            <th>그룹3</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3" maxlength="14" value="<%=productDto.getGroup3() %>" tabindex="4" dispName="" /></td>
	                        </tr>
	                        <tr>
	                            <th>그룹3명</th>
	                            <td class="input_box">
                                <input type="text" size="20" name="group3name" maxlength="14" value="<%=productDto.getGroup3Name() %>" tabindex="4" dispName="" /></td>
	                        </tr>              

	                    </tbody>
	                </table>
			   </div>
			   <!-- 레이아웃 그룹팝업 -->
			   <div id="safeStockList" title="안전재고관리"></div>
			   <!-- 레이아웃 그룹팝업 끝 -->
			   
	           <!-- 테이블 끝 -->
			   <!-- bottom 시작 -->
				<div class="ly_foot"><a href="javascript:goSave()"><img src="<%=request.getContextPath()%>/images/popup/btn_modify.gif" title="수정" /></a><a href="javascript:goClosePop('productModifyForm')"><img src="<%=request.getContextPath()%>/images/popup/btn_cancel.gif" title="취소" /></a>
				<!-- bottom 끝 -->
			</div>
			<!-- 컨텐츠끝 -->
			<iframe class="sbBlind sbBlind_userRegistForm"></iframe><!-- ie6 셀렉트박스 버그 해결방법-->
			</div>
</form>
</body>
</html>
