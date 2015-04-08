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

	if (searchGb.equals("01")) { 		//사용자명(Name)
		searchtxt = (String) model.get("searchtxt");
		aselect = "selected";
	} else if (searchGb.equals("02")) { //사용자 ID(ID)
		searchtxt = (String) model.get("searchtxt");
		bselect = "selected";
	} else if (searchGb.equals("03")) { //팩스번호(FaxNo)
		searchtxt = (String) model.get("searchtxt");
		cselect = "selected";
	} else if (searchGb.equals("04")) { //이메일(Email)
		searchtxt = (String) model.get("searchtxt");
		dselect = "selected";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>직원검색</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/common_2.css" rel="stylesheet" type="text/css" />
<script>
var observer;//처리중
var observerkey=false;//처리중여부
//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인

	searchChk();
}

// 검색
function goSearch() {
	var obj=document.UserSearchForm;
	var gubun=obj.searchGb.value;
	var invalid = ' ';	//공백 체크
		
		if(gubun=='01'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('사용자 이름을 입력해 주세요');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='02'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('사용자 ID를 입력해 주세요');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='03'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('팩스번호를 입력해 주세요');
				obj.searchtxt.value="";
				obj.searchtxt.focus();
				return;
			}
		}else if(gubun=='04'){
			if(obj.searchtxt.value=='' || obj.searchtxt.value.indexOf(invalid) > -1){
				alert('이메일 주소를 입력해 주세요');
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
<!-- 처리중 시작 -->
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
<!-- 처리중 종료 -->
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<%=ld.getPageScript("UserSearchForm", "curPage", "goPage")%>
<body id="popup">
<form method="post" name=UserSearchForm action="<%=request.getContextPath()%>/H_Common.do?cmd=userSearchList">
		<input type="hidden" name="curPage" value="<%=curPage%>"> 
<!-- 레이아웃 시작 -->
<div id="wrap_600">

	<!-- TOP 타이틀 시작 -->
	<div id="header">
    	<div class="pop_top">
			<p><img src="<%=request.getContextPath()%>/images/popup/text_User_seach.gif" width="199" height="44" /></p>
    	</div>
    </div>
	<!-- TOP 타이틀 끝 -->

	<!-- 메인컨텐츠 시작 -->
    <div id="pop_contents">

        <!-- 검색 시작 -->
        <div id="sch_wrap">
                
            <!-- 조직검색 시작 -->
            <div id="sch_box">
                <p>&nbsp;</p>
                <ul>
                   <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li><img src="<%=request.getContextPath()%>/images/popup/btn_selection.gif" width="42" height="21" title="선택" /></li>
                </ul> 
            </div>
            <!-- 조직검색 끝 -->

            <!-- 직원검색 시작 -->
            <div id="sch_box_02">
                <p></p>
                <ul>
                    <li>
                       <select name="searchGb" class="seach2"  onChange="searchChk()">
									<option value="ALL" checked>전체</option>
									<option value="01" <%=aselect%>>사용자명</option>
									<option value="02" <%=bselect%>>ID</option>
									<option value="03" <%=cselect%>>팩스번호</option>
									<option value="04" <%=dselect%>>eMail</option>
							</select>
                    </li>
                    <li><input name="searchtxt" type="text"   maxlength="20"  /></li>
                    <li><img src="<%=request.getContextPath()%>/images/popup/btn_find.gif" width="42" height="21" /></li>
                </ul>
                <ul class="mg">
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                    <li>
                        <select name="seach2">
                            <option value="전체">전체</option>
                            <option value="이름">이름</option>
                            <option value="기타">기타</option>
                          </select>
                    </li>
                </ul>
            </div>	
            <!-- 직원검색 끝-->
           
 	  </div>
      <!-- 검색 끝 -->
      
      <!-- 테이블 시작 -->
      <div id="tblPop" class="tbl_out">
      <table width="100%" border="0" cellspacing="1" class="tbl_pop">
      	<caption>이관대상 검색</caption>
              <thead>
                  <tr>
                    <th colspan="12">전체건수 0건, 현재페이지 1/1</th>
                  </tr>
                  <tr>
                    <th>사용자명</th>
                    <th>ID</th>
                    <th>소속</th>
                    <th>팩스번호</th>
                    <th>E-mail</th>
                  </tr>
               </thead>
               
               <tbody>
			   <!-- :: loop :: -->
						<!--리스트---------------->
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
							<td colspan="5" align="center" >게시물이 없습니다.</td>
						</tr>
						<%
						}
						%>
                  </tbody>
            </table>
		</div>
        <!-- 테이블 끝 -->
        
        <!-- 페이지넘버 START -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<br>
						<tr align="center">
							<td><%=ld.getPagging("goPage")%></td>
						</tr>
					</table> 
		<!-- 페이지넘버 END -->
        
  	</div>
	<!-- 메인컨텐츠 끝 -->

	<!-- bottom 시작 -->
	<div id="bottom">
    	<div class="bottom_top"></div>
    </div>
	<!-- bottom 끝 -->

</div>
<!-- 레이아웃 끝 -->

</body>
</html>
