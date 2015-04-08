package com.web.webaction.recovery.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;



import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.persist.ListDTO;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.BaseAction;
import com.web.common.address.AddressDTO;
import com.web.common.recovery.RecoveryDAO;
import com.web.common.recovery.RecoveryDTO;
import com.web.common.order.OrderDAO;
import com.web.common.order.OrderDTO;
import com.web.common.config.CompanyDTO;
import com.web.common.user.UserBroker;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;

import com.web.framework.util.ByTimestampFileRenamePolicy;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.InJectionFilter;

import com.web.framework.data.DataSet;
import com.oreilly.servlet.MultipartRequest;

public class RecoveryAction extends StrutsDispatchAction{

	public static String UPLOAD_PATH = config.getString("framework.fileupload.temppath");
	
   /**
	 * 회수대상 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	  public ActionForward reTargetPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
		    //log action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "reTargetPageList action start");
			
			//로그인 처리 
			UserMemDTO dtoUser = BaseAction.getSession(request);
			String USERID = dtoUser.getUserId();
			String GROUPID = dtoUser.getGroupid();
			
			if(USERID.equals("")){
				BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			//로그인 처리 끝. 
	
		    String vGroupID = StringUtil.nvl(request.getParameter("GroupID"),GROUPID);
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			
			RecoveryDAO recoveryDao = new RecoveryDAO();
			RecoveryDTO recoveryDto = new RecoveryDTO();
	
			//리스트
			recoveryDto.setLogid(logid);
			recoveryDto.setChUserID(USERID);
			recoveryDto.setGroupID(vGroupID);
			recoveryDto.setvSearchType(searchGb);
			recoveryDto.setvSearch(searchtxt);
			recoveryDto.setnRow(20);
			recoveryDto.setnPage(curPageCnt);
			recoveryDto.setJobGb("PAGE");
			
			ListDTO ld = recoveryDao.reTargetPageList(recoveryDto);
	
			model.put("listInfo",ld);
			model.put("curPage",String.valueOf(curPageCnt));
		    model.put("vGroupID",vGroupID);
		    model.put("searchGb",searchGb);
		    model.put("searchtxt",searchtxt);
		    
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "reTargetPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
		  return actionMapping.findForward("reTargetPageList");
	  	}
	    /**
		 * 회수대상 상세 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
		  public ActionForward reTargetDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
			    //log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "reTargetDetailPageList action start");
				
				//로그인 처리 
				UserMemDTO dtoUser = BaseAction.getSession(request);
				String USERID = dtoUser.getUserId();
				String GROUPID = dtoUser.getGroupid();
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//로그인 처리 끝. 
		
			    String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
			    String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
			    String GroupName = StringUtil.nvl(URLDecoder.decode(request.getParameter("GroupName").trim(), "UTF-8"),"");
				int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
				RecoveryDAO recoveryDao = new RecoveryDAO();
				RecoveryDTO recoveryDto = new RecoveryDTO();
				CompanyDTO companyDto = new CompanyDTO();
		
				companyDto.setLogid(logid);
				companyDto.setChUserID(USERID);
				companyDto.setCompanyCode(CompanyCode);
				//리스트
				recoveryDto.setLogid(logid);
				recoveryDto.setChUserID(USERID);
				recoveryDto.setGroupID(GroupID);
				recoveryDto.setCompanyCode(CompanyCode);
				recoveryDto.setnRow(20);
				recoveryDto.setnPage(curPageCnt);
				recoveryDto.setJobGb("LIST");
				
				ListDTO ld = recoveryDao.reTargetDetailPageList(recoveryDto);
				
				companyDto= recoveryDao.companyInfo(companyDto);
		
				model.put("listInfo",ld);
				model.put("curPage",String.valueOf(curPageCnt));
			    model.put("companyDto",companyDto);
			    model.put("GroupID",GroupID);
			    model.put("GroupName",GroupName);
			    
				//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "reTargetDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
				
			  return actionMapping.findForward("reTargetDetailPageList");
		  	}
		  /**
			 * 회수처리
			 * @param actionMapping
			 * @param actionForm
			 * @param request
			 * @param response
			 * @param model
			 * @return userPageList
			 * @throws Exception
			 */
			public ActionForward recoveryProcess(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
				
				//log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "recoveryProcess action start");
				
				//로그인 처리 
				String USERID = UserBroker.getUserId(request);
				UserMemDTO dtoUser = BaseAction.getSession(request);
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//로그인 처리 끝.
				
				String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
				String GroupName = StringUtil.nvl(request.getParameter("GroupName"),"");
				String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
				String[] recoverys = request.getParameterValues("seqs");
				
				int retVal=-1;
				String msg="";
				String recoverycode="R"+GroupID+CompanyCode+DateTimeUtil.getDate();
				
			
				 /* 파일을 생성해서 내용 쓰기 */
		        String szFileName = "C://Addys/Recovery/"+recoverycode+".html";                    // 파일 이름
		        File file = new File(szFileName);                        // 파일 생성
		        OutputStream out = new FileOutputStream(file);            // 파일에 문자를 적을 스트림 생성
		        
		        String szContent = "";
		        
		        szContent += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'><html><head><title>회수코드</title><meta http-equiv='Content-Type' content='text/html; charset=euc-kr' /><style type='text/css'>";
		        szContent += "<!--td {";
		        szContent += "font-family: '굴림', '돋움', 'Seoul', '한강체';";
		        szContent += "font-size: 24px;";
		        szContent += "line-height: 80px;";
		        szContent += " }.style10 {";
		        szContent += "font-size: 60px;";
		        szContent += "font-weight: bold;";
		        szContent += "font-family: '굴림체', '돋움체', Seoul;";
		        szContent += "}";
		        szContent += " -->";
		        szContent += "</style>";
		        szContent += "</head><body><div align='center'></div><div align='left'><table width='612' border='0' align='center' cellpadding='0' cellspacing='0'><!--DWLayoutTable--><tr> <td width='516' valign='top'><table width='941' height='610' border='0' align='center' cellpadding='1' cellspacing='1' bgcolor='#000000'>";
		        szContent += "<tr bgcolor='#FFFFFF'> ";
		        szContent += "<td width='794' height='55' colspan='9' align='center'><div align='left'>&nbsp;&nbsp;&nbsp;회수코드("+GroupName+")</div></td>";
		        szContent += "</tr><tr bgcolor='#FFFFFF'> <td height='518' colspan='9' align='center'><span class='style10'>"+recoverycode+"</span></td>";
		        szContent += " </tr></table>    </td></tr></table></div></body> </html></html>";
		        
		        out.write(szContent.getBytes());                        // 파일에 쓰기
		        out.close();                                            // 파일 쓰기 스트림 닫기

				RecoveryDAO recoveryDao = new RecoveryDAO();
				RecoveryDTO recoveryDto = new RecoveryDTO();
				
				recoveryDto.setChUserID(USERID); //세션 아이디
				recoveryDto.setRecoveryCode(recoverycode); 
				recoveryDto.setGroupID(GroupID); 
				recoveryDto.setCompanyCode(CompanyCode); 
				
				retVal=recoveryDao.recoveryRegist(recoveryDto);
				
				if(retVal==-1){
					msg="회수오류! 당일 회수처리한 내용이 있는지 확인 하시기 바랍니다.";
				}else if(retVal==0){
					msg="회수[1]실패!";
				}else{
					msg="회수[1]완료!";
					
					retVal = recoveryDao.recoveryDetailRegist(logid,recoverys, recoverycode);
		
					if(retVal==-1){
						msg="회수[2]오류!";
					}else if(retVal==0){
						msg="회수[2]실패!";
					}else{
						
						msg="회수완료!";

					}
					
				}
				
				if("회수완료!".equals(msg)){
									
					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "recoveryProcess action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					
					return alertAndExit(model,msg,request.getContextPath()+"/H_Recovery.do?cmd=recoveryPageList","");	
					
				}else{

					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "recoveryProcess action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					
					return alertAndExit(model,msg,request.getContextPath()+"/H_Recovery.do?cmd=reTargetPageList","");	
					
				}
				
			}	  
		   
	  	/**
		 * 회수 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
  		public ActionForward recoveryPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "recoveryPageList action start");
		
		//로그인 처리 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 

		String startDate = StringUtil.nvl(request.getParameter("startDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String endDate = StringUtil.nvl(request.getParameter("endDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String vGroupID = StringUtil.nvl(request.getParameter("vGroupID"),"");
		String vSearch = StringUtil.nvl(request.getParameter("vSearch"),"");
		String vSearchType = StringUtil.nvl(request.getParameter("vSearchType"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		RecoveryDAO recoveryDao = new RecoveryDAO();
		RecoveryDTO recoveryDto = new RecoveryDTO();

		//리스트
		recoveryDto.setLogid(logid);
		recoveryDto.setChUserID(USERID);
		recoveryDto.setFrDate(startDate);
		recoveryDto.setToDate(endDate);
		recoveryDto.setGroupID(vGroupID);
		recoveryDto.setvSearchType(vSearchType);
		recoveryDto.setvSearch(vSearch);
		recoveryDto.setnRow(20);
		recoveryDto.setnPage(curPageCnt);
		recoveryDto.setJobGb("PAGE");
		
		ListDTO ld = recoveryDao.recoveryPageList(recoveryDto);

		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("vGroupID",vGroupID);
	    model.put("vSearchType",vSearchType);
	    model.put("vSearch",vSearch);
	    model.put("startDate",startDate);
	    model.put("endDate",endDate);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "recoveryPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("recoveryPageList");
	}
  		/**
		 * 회수  상세 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
		  public ActionForward recoveryDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
			    //log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "recoveryDetailPageList action start");
				
				//로그인 처리 
				UserMemDTO dtoUser = BaseAction.getSession(request);
				String USERID = dtoUser.getUserId();
				String UseGroupID = dtoUser.getGroupid();
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//로그인 처리 끝. 
		
				String RecoveryCode = StringUtil.nvl(request.getParameter("RecoveryCode"),"");
			    String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
			    String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
			    String GroupName = StringUtil.nvl(URLDecoder.decode(request.getParameter("GroupName").trim(), "UTF-8"),"");
			    
			    String IngYN = StringUtil.nvl(request.getParameter("IngYN"),"");
			    String RegYN = StringUtil.nvl(request.getParameter("RegYN"),"");
			    
				int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
				RecoveryDAO recoveryDao = new RecoveryDAO();
				RecoveryDTO recoveryDto = new RecoveryDTO();
				CompanyDTO companyDto = new CompanyDTO();
		
				companyDto.setLogid(logid);
				companyDto.setChUserID(USERID);
				companyDto.setCompanyCode(CompanyCode);
				//리스트
				recoveryDto.setLogid(logid);
				recoveryDto.setChUserID(USERID);
				recoveryDto.setGroupID(GroupID);
				recoveryDto.setRecoveryCode(RecoveryCode);
				recoveryDto.setCompanyCode(CompanyCode);
				recoveryDto.setnRow(20);
				recoveryDto.setnPage(curPageCnt);
				recoveryDto.setJobGb("LIST");
				
				ListDTO ld = recoveryDao.recoveryDetailPageList(recoveryDto);
				
				companyDto= recoveryDao.companyInfo(companyDto);
		
				model.put("listInfo",ld);
				model.put("curPage",String.valueOf(curPageCnt));
			    model.put("companyDto",companyDto);
			    model.put("GroupID",GroupID);
			    model.put("GroupName",GroupName);
			    model.put("RecoveryCode",RecoveryCode);
			    model.put("IngYN",IngYN);
			    model.put("RegYN",RegYN);
			    
			    model.put("UseGroupID",UseGroupID);
			    
				//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "recoveryDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
				
			  return actionMapping.findForward("recoveryDetailPageList");
		  	}
		  
			/**
			 * 회수처리
			 * @param actionMapping
			 * @param actionForm
			 * @param request
			 * @param response
			 * @param model
			 * @return
			 * @throws Exception
			 */
			public ActionForward recoveryProcSave(ActionMapping actionMapping,
					ActionForm actionForm, HttpServletRequest request,
					HttpServletResponse response, Map model) throws Exception {

				// log action execute time start
				String logid = log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "recoveryProcSave action start");

				// 로그인 처리
				String USERID = UserBroker.getUserId(request);
				if (USERID.equals("")) {
					String rtnUrl = request.getContextPath()
							+ "/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl, "huation-sessionOut");
				}

				String RecoveryCode = StringUtil.nvl(request.getParameter("RecoveryCode"), "");
				String ProductCode = StringUtil.nvl(request.getParameter("ProductCode"), "");
				String RecoveryCheck = StringUtil.nvl(request.getParameter("RecoveryCheck"), "");
				int RecoveryResultCnt = StringUtil.nvl(request.getParameter("RecoveryResultCnt"), 0);
				String RecoveryMemo = StringUtil.nvl(URLDecoder.decode(request.getParameter("RecoveryMemo"), "UTF-8"), "");
				
				log.debug("#####RecoveryCode"+RecoveryCode);
				log.debug("#####ProductCode"+ProductCode);
				log.debug("#####RecoveryCheck"+RecoveryCheck);
				log.debug("#####RecoveryResultCnt"+RecoveryResultCnt);
				
				RecoveryDAO recoveryDao = new RecoveryDAO();
				RecoveryDTO recoveryDto = new RecoveryDTO();

				recoveryDto.setLogid(logid);
				recoveryDto.setRecoveryCode(RecoveryCode);
				recoveryDto.setProductCode(ProductCode);
				recoveryDto.setRecoveryCheck(RecoveryCheck);
				recoveryDto.setRecoveryResultCnt(RecoveryResultCnt);
				recoveryDto.setRecoveryMemo(RecoveryMemo);
			
				int retVal = -1;
				String IngYN="";
				retVal = recoveryDao.recoveryProcSave(recoveryDto);
				
				if(retVal==1){
					IngYN=recoveryDao.recoveryIngYN(recoveryDto);
				}
				
				response.setContentType("text");
				response.getWriter().print(IngYN);

				// log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "recoveryProcSave action end execute time:[" + (t2 - t1)
						/ 1000.0 + "] seconds");

				return null;
			}
			/**
			 * 등록완료
			 * @param actionMapping
			 * @param actionForm
			 * @param request
			 * @param response
			 * @param model
			 * @return
			 * @throws Exception
			 */
			public ActionForward recoveryProcClose(ActionMapping actionMapping,
					ActionForm actionForm, HttpServletRequest request,
					HttpServletResponse response, Map model) throws Exception {

				// log action execute time start
				String logid = log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "recoveryProcClose action start");

				// 로그인 처리
				String USERID = UserBroker.getUserId(request);
				if (USERID.equals("")) {
					String rtnUrl = request.getContextPath()
							+ "/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl, "huation-sessionOut");
				}

				String RecoveryCode = StringUtil.nvl(request.getParameter("RecoveryCode"), "");
						
				RecoveryDAO recoveryDao = new RecoveryDAO();
				RecoveryDTO recoveryDto = new RecoveryDTO();

				recoveryDto.setLogid(logid);
				recoveryDto.setRecoveryCode(RecoveryCode);
				recoveryDto.setChUserID(USERID);
			
				int retVal = -1;
				retVal = recoveryDao.recoveryProcClose(recoveryDto);
				
			
				response.setContentType("text");
				response.getWriter().print(retVal);

				// log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "recoveryProcClose action end execute time:[" + (t2 - t1)
						/ 1000.0 + "] seconds");

				return null;
			}
}
