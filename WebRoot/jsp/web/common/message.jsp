<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="com.web.framework.util.*"%>
<%@ include file="/jsp/web/common/base.jsp" %>
<%

	String mode=(String)model.get("ALERT_MODE");
	String type=(String)model.get("MSG_TYPE");
	String alert=(String)model.get("ALERT");
	String url=(String)model.get("URL");
	String param=(String)model.get("PARAM");
	String go=(String)model.get("GO");
	String close=(String)model.get("CLOSE");
	String message=(String)model.get("MSG");
	String reload=(String)model.get("RELOAD");
	String exception=(String)model.get("EXCEPTION");
	
/*
    out.println("MODE =>"+mode); 
    out.println("URL =>"+url); 
    out.println("ALERT =>"+alert); 
    out.println("PARAM =>"+param); 
    out.println("MESSAGE =>"+message); 
    out.println("TYPE =>"+type); 
    out.println("CLOSE =>"+close); 
    out.println("RELOAD =>"+reload); 
    out.println("EXCEPTION =>"+exception); 
*/
%>
<%
	if( alert.equals("true") && StringUtil.isNotNull(message)) {
%>
<script language="javascript">
		var msg = "<%= message %>";
		alert(msg);
</script>	
<% }%>

<% if( mode.equals("popup") && reload.equals("true")) { %>
<script language="javascript">
     <% if(param.equals("P")) { %>
          <% if(url.equals("")){%>
	     	 parent.location.reload();
     	  <% }else{%>
			 parent.location.href ="<%=url%>";
		  <% } %>	
	<%  }else if(param.equals("M")) { %>
          <% if(url.equals("")){%>
	     	 top.dialogArguments.location.reload();
     	  <% }else{%>
			 top.dialogArguments.location.href ="<%=url%>";
		  <% } %>	
	<%  }else if(param.equals("S")) { %>
          <% if(url.equals("")){%>
	     	  parent.location.reload();
     	  <% }else{%>
			 parent.location.href ="<%=url%>";
		  <% } %>	
	<% }else{ %>
          <% if(url.equals("")){%>
	     	 opener.location.reload();
     	  <% }else{%>
			 opener.location.href ="<%=url%>";
		  <% } %>	
     <% } %>
</script>	
<% } %>

<% if( mode.equals("popup") && close.equals("true")) { %>
<script language="javascript">
     <% if(param.equals("P")) { %>
     	parent.window.close();
     <% } else { %>
     	this.close();
     <% } %>
</script>	
<% } %>

<% if( mode.equals("confirm")) { %>
<script language="javascript">
	var truthBeTold = window.confirm("<%=message%>");
	if (truthBeTold) {
	<% if( param.equals("P")) { %>	
	parent.location.href ="<%=url%>";
	<% } else  if(param.equals("M")) { %>
	 top.dialogArguments.location.href ="<%=url%>";
	<% } else  if(param.equals("O")) { %>
	 opener.location.href ="<%=url%>";
	<% } else { %>
	   window.location.href ="<%=url%>";
	<% } %>
	}else{  
	<% if( reload.equals("true")) { %>
		<% if( param.equals("P")) { %>
		parent.location.reload();
		<% } else  if(param.equals("M")) { %>
		top.dialogArguments.location.reload();
		<% } else  if(param.equals("O")) { %>
		opener.location.reload();
		<% } %>
	<% } else { %>
		<% if( param.equals("")) { %>
       		;
       		<% } else { %>
       		window.location.href ="<%=param%>";
       		<% } %>
        <% } %>
    }
</script>	
<% } %>

<% if( mode.equals("history")) { %>
<script language="javascript">
  <% if(!url.equals("")){%>
      window.location.href ="<%=url%>";
  <% }else{ %>
      history.go(-1);
  <% }%>    
</script>	
<% } %>

<% if( mode.equals("action") && url.equals("")) { %>
<form action=<%= url%> method="get">
</form>
<script language="javascript">
	document.forms[0].submit();
</script>	
<% } %>

<% if( mode.equals("message")) {  
   String msg2 = "";
   String msg = message;
%>

            <br>
            <table width="99%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center">
                  <table width="652" border="0" cellspacing="0" cellpadding="0" background="/img/common/msg_bg.gif" height="141">
                    <tr> 
                      <td width="22%">&nbsp;</td>
                      <td align="center" valign="middle">
				<!-- 메세지 들어가는 부분  --> 
						<%=msg%><br>
						<%
							if(!exception.equals("")) { 
						%>
								Exception : <%=exception%>
						<%
							}
						%>
					  </td>
                    </tr>
                  </table>
                </td>
               </tr>
               <tr>
               	<td height=10></td>
               </tr>
               <tr>
               	<td align=center>
	               	<% if( param.equals("")) { %>
					<% if(!url.equals("")) { %>
						<!-- <a href ="<%=url%>"><img src="/img/button/b_co_comfirm.gif" width="48" height="20" border='0'></a>&nbsp; -->
						<input type="button" name=btnConfirm value="확인" OnClick="javascript:location.href='<%=url%>';">&nbsp;
					<% }else{ %>
						<!-- <a href ="javascript:history.back()"><img src="/img/button/b_co_comfirm.gif" width="48" height="20" border='0'></a>&nbsp; -->
						<input type="button" name=btnConfirm value="확인" OnClick="javascript:history.back();">&nbsp;
					<% } %>
					<% }else{  %>
				     <script language="javascript">
				           function reloadAndClose(){
						     <% if(param.equals("P")) {
						          if(!url.equals("")){%>
						     	    parent.location.href="<%=url%>";
						     	  <%}else{%>  
                                 	parent.location.reload();					     	    
						     <%   } 
						        }else{ 
						        if(!url.equals("")){
						        %> 
						        opener.location.href = "<%=url%>";
						        <%}else{%>  
								opener.location.reload();
							<% 
							     }
							   } %>	
	                            window.close();
				           }
				     </script>
					<!-- <a href ="javascript:reloadAndClose();"><img src="/img/button/b_co_comfirm.gif" width="48" height="20" border='0'></a>&nbsp; -->
					<input type="button" name=btnConfirm value="확인" OnClick="javascript:reloadAndClose();">&nbsp;
				<% } %>
				
               	</td>
             

<% } %>

