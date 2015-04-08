package com.web.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import com.web.common.CodeParam;
import com.web.common.ComCodeDTO;
import com.web.common.CommonDAO;
import com.web.common.code.CodeDAO;
import com.web.common.code.CodeDTO;
import com.web.common.config.AuthDAO;
import com.web.common.config.MenuDTO;
import com.web.framework.configuration.Configuration;
import com.web.framework.configuration.ConfigurationFactory;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.MailUtil;
import com.web.framework.util.StringUtil;

/*********************************************************
 * 프로그램 : CommonUtil.java
 * 모 듈 명  : 프로젝트내에서 사용하는 공통 유틸 정의 
 * 설    명   : 
 * 테 이 블  :
 * 작 성 자  : 
 * 작 성 일  : 
 * 수 정 일  :
 * 수정사항 : 
 *********************************************************/
public class CommonUtil {
    private static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	private static final boolean mon_ture = false;
    public static final String SERVERTYPE = config.getString("framework.system.server_type");
    public static final String SERVERURL = config.getString("framework.system.server_url");
    public static final String DATAURL = config.getString("framework.fileupload.datadir");
    public static final String FILESURL = config.getString("framework.fileupload.filedir");
    public static final String COMMUNITYURL = config.getString("framework.fileupload.communitydir");
    public static final String XMLENCODING = config.getString("framework.xml.encoding");
    public static final String SMSURL = config.getString("framework.sms.url");
	public static final boolean DB_MONITOR = mon_ture;
    public static String LOGIN_MSG = "로그인 정보가 없습니다. 로그인하시기 바랍니다.";
    public static String ERROR_URL = "/jsp/imagefax/common/error.jsp";
    public static String LOGIN_FORM_FORWARD = "/H_Login.do?cmd=loginForm";
    
    private static CommonUtil commonUtilIns = null;

    /** 
     * 
     */
    public CommonUtil() {
        super();
        // TODO Auto-generated constructor stub
    }

    public static CommonUtil getInstance(){  
	    if(commonUtilIns == null) {
	        commonUtilIns = new CommonUtil();
	     }
	
	     return commonUtilIns;
    }
    
    /**
     * 코드 박스를 생성해 준다.
     * @param param
     * @param list
     * @return
     */    
    public static String getCodeBox(CodeParam param, ArrayList list){
    	StringBuffer out = new StringBuffer();
    	ComCodeDTO code = null;
	    if (param.getType().equals("select")){
			out.append("<select name=\""+param.getName()+"\"  style=\"margin:1 0 0 0;"+param.getStyle()+"\" ");
            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")) out.append("class=\""+param.getStyleClass()+"\" ");
			if(param.getEtc() != null) out.append(" "+param.getEtc()+" ");
			if (param.getEvent() != null && !param.getEvent().equals("")) out.append("onChange=\""+param.getEvent()+"\" ");
			    out.append(" > \n "); 
				if (param.getFirst() != null && !param.getFirst().equals("")) out.append("<option value=\"\">"+param.getFirst()+"</option> \n");
				if (list != null && list.size() > 0)
				    for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);
				    	out.append("<option value=\""+code.getCode()+"\" ");
				    	if (code.getCode().equals(param.getSelected())) out.append("selected");
				    	out.append(" >"+code.getName()+"</option>\n");
				    }
			out.append("</select>\n");
	    }else if(param.getType().equals("check")){
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);				
						out.append("<INPUT type=checkbox name=\""+param.getName()+"\" ");
			            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")){ out.append("class=\""+param.getStyleClass()+"\" ");}else{out.append("class=\"no\" ");}
			            out.append(" value=\""+code.getCode()+"\"");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked "); 
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp; \n");
					}
	    }else if(param.getType().equals("radio")) {
	    		if (param.getFirst() != null && !param.getFirst().equals("")) {
	    			out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\"\"");
	    			if("".equals(param.getSelected())) out.append(" checked ");
	    			out.append(">"+param.getFirst()+" ");
	    		}
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){
						code = (ComCodeDTO)list.get(i);
						out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\""+code.getCode()+"\" ");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked ");
						//if (code.getCode().equals(param.getSelected())) out.append(" checked ");
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp;");
					}
	    }
	    
	    return out.toString();
   }
    
    /**
     * 코드 박스를 생성해 준다.(지역 팩스번호 용도)
     * Author : shbyeon
     * Description : select box에 option = get.CodeID값. Value = get.CodeID값 지역번호 선택을위해.
     * @param param
     * @param list
     * @return
     */    
    public static String getCodeBox1(CodeParam param, ArrayList list){
    	StringBuffer out = new StringBuffer();
    	ComCodeDTO code = null;
	    if (param.getType().equals("select")){
			out.append("<select name=\""+param.getName()+"\" tabindex=\"2\"  style=\"margin:1 0 0 0;"+param.getStyle()+"\" ");
            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")) out.append("class=\""+param.getStyleClass()+"\" ");
			if(param.getEtc() != null) out.append(" "+param.getEtc()+" ");
			if (param.getEvent() != null && !param.getEvent().equals("")) out.append("onChange=\""+param.getEvent()+"\" ");
			    out.append(" > \n "); 
				if (param.getFirst() != null && !param.getFirst().equals("")) out.append("<option value=\"\">"+param.getFirst()+"</option> \n");
				if (list != null && list.size() > 0)
				    for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);
				    	out.append("<option value=\""+code.getCode()+"\" ");
				    	if (code.getCode().equals(param.getSelected())) out.append("selected");
				    	out.append(" >"+code.getCode()+"</option>\n");
				    }
			out.append("</select>\n");
	    }else if(param.getType().equals("check")){
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);				
						out.append("<INPUT type=checkbox name=\""+param.getName()+"\" ");
			            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")){ out.append("class=\""+param.getStyleClass()+"\" ");}else{out.append("class=\"no\" ");}
			            out.append(" value=\""+code.getCode()+"\"");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked "); 
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp; \n");
					}
	    }else if(param.getType().equals("radio")) {
	    		if (param.getFirst() != null && !param.getFirst().equals("")) {
	    			out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\"\"");
	    			if("".equals(param.getSelected())) out.append(" checked ");
	    			out.append(">"+param.getFirst()+" ");
	    		}
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){
						code = (ComCodeDTO)list.get(i);
						out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\""+code.getCode()+"\" ");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked ");
						//if (code.getCode().equals(param.getSelected())) out.append(" checked ");
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp;");
					}
	    }
	    
	    return out.toString();
   }
    

   /**
    * 기본 메일 폼을 가지고 메일을 전송해준다.
    * @param subject
    * @param addr
    * @param username
    * @param msg
    */
   public static void defaultMailSend(String subject, String addr, String username,String msg){
	StringBuffer sb = new StringBuffer();
	sb.append("<html>");
	sb.append("<head>");
	sb.append("<title>Audien</title>");
	sb.append("</head>");
	sb.append("<body>");
	sb.append("<TABLE id=\"Table1\" cellSpacing=\"1\" cellPadding=\"1\" width=\"300\" border=\"1\">");
	sb.append("<TR>");
	sb.append("<TD style=\"HEIGHT: 60px;BACKGROUND-COLOR: #ccffcc\">");
	sb.append("<P align=\"center\"><FONT face=\"굴림\"><STRONG>"+subject+"</STRONG> </FONT>");
	sb.append("</P>");
	sb.append("</TD>");
	sb.append("</TR>");
	sb.append("<TR>");
	sb.append("<TD style=\"HEIGHT: 47px\"><FONT face=\"굴림\">"+msg+"</FONT></TD>");
	sb.append("</TR>");
	sb.append("</TABLE>");
	sb.append("</body>");
	sb.append("</html>");
    
	MailUtil.sendDirectMail(addr, username, subject, sb.toString()); 
  }

   /**
    * 코드명을 가져온다.
    * @param bigcd
    * @param smlcd
    * @return
    */
   public static String getCodeNm(String bigcd, String smlcd){
   	CodeDAO codeDao = new CodeDAO();
   	CodeDTO codeDto = null;
   	try{
   		codeDto = codeDao.getCodeInfo(bigcd, smlcd);
   	}catch(Exception e){
   	}
   	
   	return codeDto.getCdNm();
   }

   /**
    * 코드명을 가져온다.
    * @param String[] bigcd
    * @param String smlcd
    * @return
    */
   public static String[] getCodeNm(String[] bigcd, String smlcd){
   	CodeDAO codeDao = new CodeDAO();
   	CodeDTO codeDto = null;
   	String[] cdNms = null;
   	if(bigcd == null) {
   		return null;
   	} else {
   		cdNms = new String[bigcd.length];
   	   	try{
   	   		for(int i=0; i<bigcd.length; i++) {
   	   			codeDto = codeDao.getCodeInfo(bigcd[i], smlcd);
   	   			cdNms[i] = codeDto.getCdNm();
   	   		}
   	   	}catch(Exception e){
   	   	}
   	   	return cdNms;
   	}
   	
   }
   /**
    * 코드 리스트를 가져온다.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeList(CodeParam param, String codegroupid){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeList(codegroupid);
   	}catch(Exception e){
   	}
   	
   	return getCodeBox(param, codeList);
   }
   
   /**
    * 코드 리스트를 가져온다.
    * @param smlcode
    * @return
    */
   public static ArrayList getCodeList(String smlcode){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeList(smlcode);
   	}catch(Exception e){
   	}
   	
   	return codeList;
   }
   /**
    * 코드 리스트를(가나다순) 가져온다.(구매처 셀렉트 용)
    * Author : shbyeon.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListCompany(CodeParam param){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeListCompany();
   	}catch(Exception e){
   	}
   	
   	return getCodeBox(param, codeList);
   }
   /**
    * 코드 리스트를(가나다순) 가져온다.(구매처 셀렉트 용)
    * Author : shbyeon.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListGroup(CodeParam param){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeListGroup();
   	}catch(Exception e){
   	}
   	
   	return getCodeBox(param, codeList);
   }
   /**
    * 코드 리스트를(가나다순) 가져온다.(팩스 지역번호 셀렉트 용)
    * Author : shbyeon.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListHanSeq(CodeParam param, String faxCodeID){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeListHanSeq(faxCodeID);
   	}catch(Exception e){
   	}
   	
   	return getCodeBox1(param, codeList);
   }
   
   
   public static String getPackageCodeList(CodeParam param, String smlcode){
	   CommonDAO common = new CommonDAO();
	   	ArrayList codeList = null;
	   	try{
	   		//codeList = common.getCodeList(smlcode , "A" );
	   	}catch(Exception e){
	   	}
	   	
	   	return getCodeBox(param, codeList);
   }
  
   /**
	 * -------------------------------------------------------- URL에 대한 페이지를 실행한 결과를 리턴한다.
	 * @param String 호출할 url
	 * @return String ----------------------------------------------------------
	 */
	public static String getHtml(String url) {
		String content = "";
		String param = "";
		param = url.substring(url.indexOf("?") + 1,url.length());
		url = url.substring(0,url.indexOf("?"));
		try {
			URL source = new URL(url);
			URLConnection sconnection = source.openConnection();
			sconnection.setDoOutput(true);
			//sconnection.setRequestProperty("Content-Type","application/octet-stream");
			/**
			BufferedReader in = new BufferedReader(new InputStreamReader(sconnection.getInputStream(), "cp949"));
			String inputLine = null;
			while ((inputLine = in.readLine()) != null)
				content += inputLine;
			in.close();
			*/
			PrintWriter out = new PrintWriter(
                    sconnection.getOutputStream());
		    out.println(param);
		    out.close();
		
		    BufferedReader in = new BufferedReader(new InputStreamReader(sconnection.getInputStream(), "MS949"));
		    String inputLine = null;
		    while ((inputLine = in.readLine()) != null)
		        content += inputLine + "\n";
		    in.close();
		} catch (MalformedURLException me) {
			me.printStackTrace();
			return "*";
		} catch (IOException ioe) {
			ioe.printStackTrace();
			return "*";
		} catch (Exception e) {
			e.printStackTrace();
			return "*";
		}
		//log.debug("내용:" + content + "끝");
		return content;
	}
	
	public static String getDateDropDownListWithExpdate(String frmObj, String endDate, String selectedDate, String expCnt){
	//function getDateDropDownListWithExpdate( frmObj , endDate , selectedDate , expCnt)
	/*
		DATE date = new Date();
		var year = date.getYear();
		var month = date.getMonth() + 1;
		
		var endYear = endDate.substring(0 , 4 );
		var endMonth = endDate.substring( 4 , 6 );
		var monthDiff;
				
		if ( year > parseInt( endYear ) ){			
			monthDiff = month + ( ( year - parseInt( endYear ) - 1 ) * 12 + ( 12 - parseInt( endMonth ) ) );
		}else{
			monthDiff = month - parseInt( endMonth );
		}

		frmObj.length = monthDiff + 1 - expCnt ;

		var cnt = 1;
		var cnt1 = 12;
		var selectedCnt = 0;

		if ( monthDiff <= month )
		{
			for ( var i = 0 ; i < ( month - parseInt( endMonth ) )  ; i++ ){

				if ( ( month - i ) < 10  )
				{
					if ( (year + "0" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}
					
					
					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "0" + ( month - i );
						frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
					}
				}
				else
				{
					if ( (year + "" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}

					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "" + ( month - i ) ;
						frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
					}
				}
			}
		}
		else
		{
			for( var i = 0 ; i < monthDiff ; i++ )
			{
				if ( i < month )
				{
					if ( ( month - i ) < 10  )
					{
						if ( (year + "0" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}

						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + ( month - i );
							frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
						}
					}
					else
					{
						if ( (year + "" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "" + ( month - i );
							frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
						}
					}
				}
				else
				{
					if ( cnt1 == 12 )
					{
						year--;
					}

					if ( cnt1 < 10 )
					{
						if ( ( year + "0" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + cnt1;
							frmObj.options[cnt++].text = year + "년 0" + cnt1 + "월";
						}
					}
					else
					{
						if ( ( year + "" + cnt1 ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						

							frmObj.options[cnt].value = year + "" + cnt1;
							frmObj.options[cnt++].text = year + "년 " + cnt1 + "월";
						}
					}

					if ( cnt1 == 1 )
					{
						cnt1 = 12;
					}
					else
					{
						cnt1--;
					}
				}
			}
		}

		frmObj.selectedIndex = selectedCnt;*/
		return "";
	}	
	/**
	    * 권한에 따른 그룹  리스트를 가져온다.
	    * @param param
	    * @param smlcode
	    * @return
	    */
	   public static String getGroupList(CodeParam param, String authid){
		AuthDAO authDao = new AuthDAO();
	   	ArrayList groupList = null;
	   	try{
	   		groupList = authDao.getGroupList(authid);
	   	}catch(Exception e){
	   	}
	   	
	   	return getCodeBox(param, groupList);
	   }
	   public static String  getMenuAuth(ArrayList<MenuDTO> menulist){
	       
	          StringBuffer result = new StringBuffer();
	          
	      	if(menulist.size() > 0){	

				String menuID="";
			    
				result.append("\n<script language=\"javascript\">\n");
		       
		        for(int j=0; j < menulist.size(); j++ ){	
					MenuDTO dto = menulist.get(j);
					
					menuID=dto.getMenuID();
					if(!dto.getAuth().equals("N")){
						result.append("\n menuid = document.getElementById(\""+menuID+"\");\n");		
						result.append("\n if(menuid!=undefined){ menuid.style.display='inline'; }\n");
					}
				}
		        
				 result.append("</script>\n");
			}

	          return result.toString();
		  }
		  
		  public static String  getMenuAuth(ArrayList<MenuDTO> menulist ,String menuid ){
		       
	          StringBuffer result = new StringBuffer();
	          
	      	if(menulist.size() > 0){	

				String TmenuID="";
				String menuID="";
			    
				result.append("\n<script language=\"javascript\">\n");
				
				result.append("\n menuSetting('"+menuid+"'); \n");
		       
		        for(int j=0; j < menulist.size(); j++ ){	
					MenuDTO dto = menulist.get(j);
					
					TmenuID="T"+dto.getMenuID();
					menuID=dto.getMenuID();
					
				    result.append("\n tmenuid = document.getElementById(\""+TmenuID+"\");\n");
				    result.append("\n menuid = document.getElementById(\""+menuID+"\");\n");			
					result.append("\n if(tmenuid!=undefined){ tmenuid.style.display='inline'; } \n");
					result.append("\n if(menuid!=undefined){ menuid.style.display='inline'; }\n");

				}
		        
				 result.append("</script>\n");
			}

	          return result.toString();
		  }
}
