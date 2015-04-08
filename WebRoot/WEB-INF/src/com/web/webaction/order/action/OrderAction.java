package com.web.webaction.order.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
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

import org.apache.commons.mail.*;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.persist.ListDTO;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.BaseAction;
import com.web.common.address.AddressDTO;
import com.web.common.order.StockDAO;
import com.web.common.order.StockDTO;
import com.web.common.order.OrderDAO;
import com.web.common.order.OrderDTO;
import com.web.common.recovery.RecoveryDAO;
import com.web.common.recovery.RecoveryDTO;
import com.web.common.config.CompanyDTO;
import com.web.common.user.UserBroker;
import com.web.common.user.UserDAO;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;

import com.web.framework.util.ByTimestampFileRenamePolicy;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.InJectionFilter;
import com.web.framework.util.MailUtil;

import com.web.framework.data.DataSet;
import com.oreilly.servlet.MultipartRequest;

public class OrderAction extends StrutsDispatchAction{

	public static String UPLOAD_PATH = config.getString("framework.fileupload.temppath");
	/**
	 * �����Ȳ ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward stockPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "stockPageList action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		String startDate = StringUtil.nvl(request.getParameter("startDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String endDate = StringUtil.nvl(request.getParameter("endDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String vGroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		StockDAO stockDao = new StockDAO();
		StockDTO stockDto = new StockDTO();

		//����Ʈ
		stockDto.setLogid(logid);
		stockDto.setChUserID(USERID);
		stockDto.setFrDate(startDate);
		stockDto.setToDate(endDate);
		stockDto.setGroupID(vGroupID);
		stockDto.setnRow(20);
		stockDto.setnPage(curPageCnt);
		
		ListDTO ld = stockDao.stockPageList(stockDto);

		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("vGroupID",vGroupID);
	    model.put("startDate",startDate);
	    model.put("endDate",endDate);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "stockPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("stockPageList");
  	}
   /**
	 * ��� ����Ȳ  ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward stockDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "stockDetailPageList action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		String stockdate = StringUtil.nvl(request.getParameter("stockdate"),"");
		String groupid = StringUtil.nvl(request.getParameter("groupid"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		StockDAO stockDao = new StockDAO();
		StockDTO stockDto = new StockDTO();

		//����Ʈ
		stockDto.setLogid(logid);
		stockDto.setChUserID(USERID);
		stockDto.setStockDate(stockdate);
		stockDto.setGroupID(groupid);
		stockDto.setnRow(15);
		stockDto.setnPage(curPageCnt);
		
		ListDTO ld = stockDao.stockDetailPageList(stockDto);

		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("stockdate",stockdate);
	    model.put("groupid",groupid);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "stockDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("stockDetailPageList");
   	}
  
   /**
	 * ���ִ�� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	  public ActionForward targetPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
		    //log action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "targetPageList action start");
			
			//�α��� ó�� 
			UserMemDTO dtoUser = BaseAction.getSession(request);
			String USERID = dtoUser.getUserId();
			String GROUPID = dtoUser.getGroupid();
			
			if(USERID.equals("")){
				BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			//�α��� ó�� ��. 
	
		    String vGroupID = StringUtil.nvl(request.getParameter("GroupID"),GROUPID);
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			
			
			OrderDAO orderDao = new OrderDAO();
			OrderDTO orderDto = new OrderDTO();
	
			//����Ʈ
			orderDto.setLogid(logid);
			orderDto.setChUserID(USERID);
			orderDto.setGroupID(vGroupID);
			orderDto.setvSearchType(searchGb);
			orderDto.setvSearch(searchtxt);
			orderDto.setnRow(20);
			orderDto.setnPage(curPageCnt);
			orderDto.setJobGb("PAGE");
			
			ListDTO ld = orderDao.targetPageList(orderDto);
			
			model.put("listInfo",ld);
			model.put("curPage",String.valueOf(curPageCnt));
		    model.put("vGroupID",vGroupID);
		    model.put("searchGb",searchGb);
		    model.put("searchtxt",searchtxt);
		  
		    
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "targetPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
		  return actionMapping.findForward("targetPageList");
	  	}
	    /**
		 * ���ִ�� �� ����Ʈ
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
		  public ActionForward targetDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
			    //log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "targetDetailPageList action start");
				
				//�α��� ó�� 
				UserMemDTO dtoUser = BaseAction.getSession(request);
				String USERID = dtoUser.getUserId();
				String GROUPID = dtoUser.getGroupid();
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//�α��� ó�� ��. 
		
			    String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
			    String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
			    String GroupName = StringUtil.nvl(URLDecoder.decode(request.getParameter("GroupName").trim(), "UTF-8"),"");
				int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
				OrderDAO orderDao = new OrderDAO();
				OrderDTO orderDto = new OrderDTO();
				CompanyDTO companyDto = new CompanyDTO();
		
				companyDto.setLogid(logid);
				companyDto.setChUserID(USERID);
				companyDto.setCompanyCode(CompanyCode);
				//����Ʈ
				orderDto.setLogid(logid);
				orderDto.setChUserID(USERID);
				orderDto.setGroupID(GroupID);
				orderDto.setCompanyCode(CompanyCode);
				orderDto.setnRow(20);
				orderDto.setnPage(curPageCnt);
				orderDto.setJobGb("LIST");
				
				ListDTO ld = orderDao.targetDetailPageList(orderDto);
				
				companyDto= orderDao.companyInfo(companyDto);
		
				model.put("listInfo",ld);
				model.put("curPage",String.valueOf(curPageCnt));
			    model.put("companyDto",companyDto);
			    model.put("GroupID",GroupID);
			    model.put("GroupName",GroupName);
			    
				//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "targetDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
				
			  return actionMapping.findForward("targetDetailPageList");
		  	}
	  	/**
		 * ���� ����Ʈ
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
  		public ActionForward orderPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "orderPageList action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		String startDate = StringUtil.nvl(request.getParameter("startDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String endDate = StringUtil.nvl(request.getParameter("endDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String vGroupID = StringUtil.nvl(request.getParameter("vGroupID"),"");
		String vSearch = StringUtil.nvl(request.getParameter("vSearch"),"");
		String vSearchType = StringUtil.nvl(request.getParameter("vSearchType"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		OrderDAO orderDao = new OrderDAO();
		OrderDTO orderDto = new OrderDTO();

		//����Ʈ
		orderDto.setLogid(logid);
		orderDto.setChUserID(USERID);
		orderDto.setFrDate(startDate);
		orderDto.setToDate(endDate);
		orderDto.setGroupID(vGroupID);
		orderDto.setvSearchType(vSearchType);
		orderDto.setvSearch(vSearch);
		orderDto.setnRow(20);
		orderDto.setnPage(curPageCnt);
		orderDto.setJobGb("PAGE");
		
		ListDTO ld = orderDao.orderPageList(orderDto);

		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("vGroupID",vGroupID);
	    model.put("vSearchType",vSearchType);
	    model.put("vSearch",vSearch);
	    model.put("startDate",startDate);
	    model.put("endDate",endDate);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "orderPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("orderPageList");
	}
  		/**
		 * ����  �� ����Ʈ
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
		  public ActionForward orderDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
			    //log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "orderDetailPageList action start");
				
				//�α��� ó�� 
				UserMemDTO dtoUser = BaseAction.getSession(request);
				String USERID = dtoUser.getUserId();
				String UseGroupID = dtoUser.getGroupid();
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//�α��� ó�� ��. 
		
				String OrderCode = StringUtil.nvl(request.getParameter("OrderCode"),"");
			    String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
			    String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
			    String GroupName = StringUtil.nvl(URLDecoder.decode(request.getParameter("GroupName").trim(), "UTF-8"),"");
				int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
				String Email = StringUtil.nvl(URLDecoder.decode(request.getParameter("Email").trim(), "UTF-8"),"");
				String FaxNumber = StringUtil.nvl(request.getParameter("FaxNumber"),"");
				String MobilePhone = StringUtil.nvl(request.getParameter("MobilePhone"),"");
				String IngYN = StringUtil.nvl(request.getParameter("IngYN"),"");
				String BuyYN = StringUtil.nvl(request.getParameter("BuyYN"),"");
				String OrderEtc = StringUtil.nvl(URLDecoder.decode(request.getParameter("OrderEtc").trim(), "UTF-8"),"");
				String OrderAdress = StringUtil.nvl(URLDecoder.decode(request.getParameter("OrderAdress").trim(), "UTF-8"),"");
				
				int ToTalOrderPrice = StringUtil.nvl(request.getParameter("ToTalOrderPrice"),0);
				int ToTalVatPrice = StringUtil.nvl(request.getParameter("ToTalVatPrice"),0);
				
				OrderDAO orderDao = new OrderDAO();
				OrderDTO orderDto = new OrderDTO();
				CompanyDTO companyDto = new CompanyDTO();
		
				companyDto.setLogid(logid);
				companyDto.setChUserID(USERID);
				companyDto.setCompanyCode(CompanyCode);
				companyDto.setOrderCode(OrderCode);
				//����Ʈ
				orderDto.setLogid(logid);
				orderDto.setChUserID(USERID);
				orderDto.setGroupID(GroupID);
				orderDto.setOrderCode(OrderCode);
				orderDto.setCompanyCode(CompanyCode);
				orderDto.setnRow(20);
				orderDto.setnPage(curPageCnt);
				orderDto.setJobGb("LIST");
				
				ListDTO ld = orderDao.orderDetailPageList(orderDto);
				
				companyDto= orderDao.orderCompanyInfo(companyDto);
		
				model.put("listInfo",ld);
				model.put("curPage",String.valueOf(curPageCnt));
			    model.put("companyDto",companyDto);
			    model.put("GroupID",GroupID);
			    model.put("GroupName",GroupName);
			    model.put("OrderCode",OrderCode);
			    
			   model.put("Email",Email);
				model.put("FaxNumber",FaxNumber);
			    model.put("MobilePhone",MobilePhone);
			    model.put("OrderEtc",OrderEtc);
			    model.put("OrderAdress",OrderAdress);
			    model.put("IngYN",IngYN);
			    model.put("BuyYN",BuyYN);
			    model.put("ToTalOrderPrice",""+ToTalOrderPrice);
			    model.put("ToTalVatPrice",""+ToTalVatPrice);
			    
			    model.put("UseGroupID",UseGroupID);
			    
				//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "orderDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
				
			  return actionMapping.findForward("orderDetailPageList");
		  	}
		  /**
			 * ������ǥ ����Ʈ
			 * @param actionMapping
			 * @param actionForm
			 * @param request
			 * @param response
			 * @param model
			 * @return userPageList
			 * @throws Exception
			 */
			  public ActionForward orderExcelDetailPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
				    //log action execute time start
					String logid=log.logid();
					long t1 = System.currentTimeMillis();
					log.trace(logid, "orderExcelDetailPageList action start");
					
					//�α��� ó�� 
					UserMemDTO dtoUser = BaseAction.getSession(request);
					String USERID = dtoUser.getUserId();
					String GROUPID = dtoUser.getGroupid();
					
					if(USERID.equals("")){
						BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
						String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
						return goSessionOut(model, rtnUrl,"huation-sessionOut");
					}
					//�α��� ó�� ��. 
			
					String OrderCode = StringUtil.nvl(request.getParameter("OrderCode"),"");
					String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
				 	
					OrderDAO orderDao = new OrderDAO();
					OrderDTO orderDto = new OrderDTO();
				
					//����Ʈ
					orderDto.setLogid(logid);
					orderDto.setChUserID(USERID);
					
					orderDto.setOrderCode(OrderCode);
					orderDto.setnRow(20);
					orderDto.setnPage(1);
					orderDto.setJobGb("LIST");
					
					ListDTO ld = orderDao.orderDetailPageList(orderDto);

					model.put("listInfo",ld);
		
				    model.put("OrderCode",OrderCode);
				    model.put("GroupID",GroupID);
				    
					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "orderExcelDetailPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					
				  return actionMapping.findForward("orderExcelDetailPageList");
			  	}
		  /**
			 * ����ó��
			 * @param actionMapping
			 * @param actionForm
			 * @param request
			 * @param response
			 * @param model
			 * @return userPageList
			 * @throws Exception
			 */
			public ActionForward orderProcess(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
				
				//log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "orderProcess action start");
				
				//�α��� ó�� 
				String USERID = UserBroker.getUserId(request);
				UserMemDTO dtoUser = BaseAction.getSession(request);
				
				if(USERID.equals("")){
					BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
				}
				//�α��� ó�� ��.
				
				String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
				String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
				String FAXKey = StringUtil.nvl(request.getParameter("FAXKey"),"");
				String EmailKey = StringUtil.nvl(request.getParameter("EmailKey"),"");
				String SMSKey = StringUtil.nvl(request.getParameter("SMSKey"),"");
				
				String mobilephone = StringUtil.nvl(request.getParameter("mobilephone"),"");
				String emailaddr = StringUtil.nvl(request.getParameter("emailaddr"),"");
				String faxnum = StringUtil.nvl(request.getParameter("faxnum"),"");
				
				
				String totalEtc = StringUtil.nvl(request.getParameter("totalEtc"),"");
				String deliveryAddr = StringUtil.nvl(request.getParameter("deliveryAddr"),"");
				
				String CompanyName = StringUtil.nvl(request.getParameter("CompanyName"),"");
				String CompanyPhone = StringUtil.nvl(request.getParameter("CompanyPhone"),"");
				String ChargeName = StringUtil.nvl(request.getParameter("ChargeName"),"");
				String GroupName = StringUtil.nvl(request.getParameter("GroupName"),"");
				
				String deliveryDate = StringUtil.nvl(request.getParameter("deliveryDate"),"");
				String orderMethod = StringUtil.nvl(request.getParameter("orderMethod"),"");
				String orderEtc = StringUtil.nvl(request.getParameter("orderEtc"),"");
				
				String[] orders = request.getParameterValues("seqs");
				
				int retVal=-1;
				String msg="";
				String emailResult="";
				String ordercode="O"+GroupID+CompanyCode+DateTimeUtil.getDate();
				
				String orderYear=DateTimeUtil.getYear();
				String orderMonth=DateTimeUtil.getMonth();
				String orderDay=DateTimeUtil.getDate().substring(6);
				
				String deliveryDateArr [] =deliveryDate.split("-");
				
				String deliveryYear="";
				String deliveryMonth="";
				String deliveryDay="";
				
				if(deliveryDateArr.length>2){
			    	deliveryYear=deliveryDateArr[0];
					deliveryMonth=deliveryDateArr[1];
					deliveryDay=deliveryDateArr[2];	
				}
				
				 /* ������ �����ؼ� ���� ���� */
		        String szFileName = "C://Addys/Order/"+ordercode+".html";                    // ���� �̸�
		        File file = new File(szFileName);                        // ���� ����
		        OutputStream out = new FileOutputStream(file);            // ���Ͽ� ���ڸ� ���� ��Ʈ�� ����
		        
		        String szContent = "";
		    
		        szContent += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>";
		        szContent += "<html>";
		        szContent += "<head>";
		        szContent += "<title>��ǰ�ֹ���</title>";
		        szContent += "<meta http-equiv='Content-Type' content='text/html; charset=euc-kr' />";
		        szContent += "<style type='text/css'>"; 
		        szContent += "<!--";
		        szContent += "td {";
		        szContent += "font-family: '����', '����', 'Seoul', '�Ѱ�ü';";
		        szContent += "font-size: 12px;";
		        szContent += "	line-height: 30px;";
		        szContent += "}";
				szContent += ".style1 {";
			    szContent += "	font-size: 30px;";
				szContent += "	font-weight: bold;";
				szContent += "	font-family: '����ü', '����ü', Seoul;";
		        szContent += "}";
				szContent += ".style5 {";
				szContent += "	font-size: 24px;";
				szContent += "font-weight: bold;";
		        szContent += "}";
				szContent += "-->";
				szContent += "</style>";
				szContent += "</head>";

				szContent += "<body>";
				szContent += "<div align='center'></div>";

				szContent += "<div align='left'>";
				szContent += "<table width='612' border='0' align='center' cellpadding='0' cellspacing='0'>";
				szContent += "<!--DWLayoutTable-->";
				szContent += "<tr> ";
				szContent += "<td width='516' valign='top'>";
				szContent += "<table width='722' height='900' border='0' align='center' cellpadding='1' cellspacing='1' bgcolor='#000000'>";
				szContent += "<tr bgcolor='#FFFFFF'> ";
				szContent += "<td height='55' colspan='9' align='center'><span class='style1'>�� ǰ �� �� ��</span></td>";
				szContent += " </tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += " <td width='81' height='29' align='center'>�� ��</td>";
				szContent += "<td colspan='5' align='center'>&nbsp;"+CompanyName+"</td>";
				szContent += " <td colspan='3' rowspan='3' align='center'><span class='style5'>�ֵ𽺴��̷�Ʈ</span></td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='29'>�� ��</td>";
				szContent += "<td colspan='5' align='center'>&nbsp;"+orderEtc+"</td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='29'>��������</td>";
				szContent += "<td width='77' colspan='-2' align='center'><div align='right'>"+orderYear+" �� </div></td>";
				szContent += "<td width='61' align='center'>&nbsp;"+orderMonth+"</td>";
				szContent += "<td width='50' align='center'>��</td>";
				szContent += "<td width='58' align='center'>&nbsp;"+orderDay+"</td>";
				szContent += "<td width='52' align='center'>��</td>";
				szContent += " </tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='29'>��ǰ����</td>";
				szContent += "<td colspan='-2' align='center'><div align='right'>"+deliveryYear+" �� </div></td>";
				szContent += " <td align='center'>&nbsp;"+deliveryMonth+"</td>";
				szContent += " <td align='center'>��</td>";
				szContent += "<td align='center'>&nbsp;"+deliveryDay+"</td>";
				szContent += "<td align='center'>��</td>";
				szContent += "<td width='86' align='center'>�� ȭ</td>";
				szContent += "<td colspan='2' align='center'>&nbsp;"+CompanyPhone+"</td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='29'>��ǰ���</td>";
				szContent += "<td colspan='5' align='center'>"+orderMethod+"</td>";
				szContent += "<td align='center'>�� �� ��</td>";
				szContent += "<td colspan='2' align='center'>&nbsp;"+mobilephone+"</td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='29'>��ǰ���</td>";
				szContent += "<td colspan='5' align='center'>&nbsp;"+GroupName+"</td>";
				szContent += "<td align='center'>�� �� ��</td>";
				szContent += "<td colspan='2' align='center'>&nbsp;"+ChargeName+"</td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td colspan='9' align='center' height='27'><div align='left'>1.�Ʒ��� ���� �����մϴ�.</div></td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='27'>�� ȣ</td>";
				szContent += "<td colspan='-2' align='center'>������</td>";
				szContent += "<td colspan='5' align='center'>�� ǰ ��</td>";
				szContent += "<td width='57' align='center'>����</td>";
				szContent += "<td width='172' align='center'>�� ��</td>";
				szContent += " </tr>";
				
				int num=0;
				int totalnum=orders.length;
				int etcnum=0;
				String[] r_data=null;
				
				if(totalnum<23){
					
					etcnum=23-totalnum;
					
				}

				for(int i=0;i<totalnum;i++){
					
					num=i+1;
					r_data = StringUtil.getTokens(orders[i], "|");
					/*
					log.debug("@@@@@@@@@@@@@@@@"+r_data.length);
					log.debug(StringUtil.nvl(r_data[0],"")); 
					log.debug(StringUtil.nvl(r_data[1],0)); 
					log.debug(StringUtil.nvl(r_data[2],"")); 
					log.debug(StringUtil.nvl(r_data[3],0)); 
					log.debug(StringUtil.nvl(r_data[4],0)); 
					log.debug(StringUtil.nvl(r_data[5],0)); 
					log.debug(StringUtil.nvl(r_data[6],0)); 
					log.debug(StringUtil.nvl(r_data[7],"")); 
					log.debug(StringUtil.nvl(r_data[8],"")); 
					log.debug(StringUtil.nvl(r_data[9],"")); 
					*/
					szContent += "<tr bgcolor='#FFFFFF'>";
					szContent += "<td align='center' height='27'>"+num+"</td>";
					szContent += "<td colspan='-2' align='center'>&nbsp;"+StringUtil.nvl(r_data[8],"")+"</td>";
					szContent += "<td colspan='5' align='center'>&nbsp;"+StringUtil.nvl(r_data[9],"")+"</td>";
					szContent += "<td align='center'>&nbsp;"+StringUtil.nvl(r_data[1],0)+"</td>";
					szContent += " <td align='center'>&nbsp;"+StringUtil.nvl(r_data[2],"")+"</td>";
					szContent += " </tr>";
				
				}
			
				for(int y=0;y<etcnum;y++){
					
					szContent += "<tr bgcolor='#FFFFFF'>";
					szContent += "<td align='center' height='27'></td>";
					szContent += "<td colspan='-2' align='center'>&nbsp;</td>";
					szContent += "<td colspan='5' align='center'>&nbsp;</td>";
					szContent += " <td align='center'>&nbsp;</td>";
					szContent += "<td align='center'>&nbsp;</td>";
					szContent += " </tr>";
				
				}
			
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td height='45' align='center'>�� ��</td>";
				szContent += "<td colspan='8' align='left'>&nbsp;"+totalEtc+"</td>";
				szContent += "</tr>";
				szContent += "<tr bgcolor='#FFFFFF'>";
				szContent += "<td align='center' height='27'>����ּ�</td>";
				szContent += "<td colspan='8' align='left'>&nbsp;"+deliveryAddr+"</td>";
				szContent += "</tr>";
				szContent += "</table>    </td>";
				szContent += "</tr>";
				szContent += "</table>";
				szContent += "</div>";

				szContent += "</body>";
				szContent += " </html>";

				szContent += "</html>";

		        
		        out.write(szContent.getBytes());                        // ���Ͽ� ����
		        out.close();                                            // ���� ���� ��Ʈ�� �ݱ�
		        
		        if("Y".equals(EmailKey)){//�̸��� �߼�ó��
		        
				        try{
		
				    	EmailAttachment attachment = new EmailAttachment();
				    	attachment.setPath(szFileName); //÷�� ���� ��ġ
				    	attachment.setDisposition(EmailAttachment.ATTACHMENT);
				    	attachment.setDescription("Order");
				    	attachment.setName(ordercode+".html");
				    	
				    	String MAIL_HOST = config.getString("framework.mail.host");
				    	String MAIL_ID = config.getString("framework.mail.user");
				    	String MAIL_PW = config.getString("framework.mail.password");
				    	String MAIL_FROMNM = config.getString("framework.mail.fromName");
				    	String MAIL_FROMADDR = config.getString("framework.mail.fromAddr");

				    	//�⺻ �������� ����
				    	MultiPartEmail email = new MultiPartEmail();
				    	email.setHostName(MAIL_HOST);
				    	email.setAuthentication(MAIL_ID, MAIL_PW);
				    	email.addTo(emailaddr, CompanyName);
				    	email.setFrom(MAIL_FROMADDR, "(��)�ֵ� ���̷�Ʈ");
				    	email.setSubject("[TEST]��ǰ�ֹ���");
				    	email.setMsg("���� �׽�Ʈ �Դϴ�.");
				    	
				    	//÷�� ���� �߰�
				    	email.attach(attachment);
				    	 
				    	//���� ����
				    	email.send();
				    	
				        }catch (Exception e) {
							
				        	log.debug("email error :"+e.getMessage());
				        	EmailKey = "N";
				        	emailResult="N";
							
						}
				    	/*
				        }catch(MailParseException ex){
				    		   log.debug("�̸������ۿ��� : "+ex.getCause()+"[�޼��� �Ľ� ����]");
				    		   EmailKey = "N";
				        }catch(MailAuthenticationException ex){
				    			  log.debug("�̸������ۿ��� : "+ex.getCause()+"[�̸��� ��������]");
				    			  EmailKey = "N";
				    	}catch(MailSendException ex){
				    			  log.debug("�̸������ۿ��� : "+ex.getCause()+"[�̸��� ���ۿ���]");
				    			  EmailKey = "N";
				    	}catch(Exception ex){
				    			  log.debug("�̸������ۿ��� : "+ex.getCause()+"[�˼����� ����]");
				    			  EmailKey = "N";
				    	}
		*/
		        }

				OrderDAO orderDao = new OrderDAO();
				OrderDTO orderDto = new OrderDTO();
				
				orderDto.setChUserID(USERID); //���� ���̵�
				orderDto.setOrderCode(ordercode); 
				orderDto.setGroupID(GroupID); 
				orderDto.setCompanyCode(CompanyCode); 
				orderDto.setFAXKey(FAXKey); 
				orderDto.setEmailKey(EmailKey); 
				orderDto.setSMSKey(SMSKey); 
				
				orderDto.setMobilephone(mobilephone);
				orderDto.setEmailaddr(emailaddr);
				orderDto.setFaxnum(faxnum);
				
				orderDto.setOrderEtc(totalEtc);
				orderDto.setOrderAdress(deliveryAddr);
				
				orderDto.setDeliveryDate(deliveryYear+deliveryMonth+deliveryDay);
				orderDto.setDeliveryEtc(orderEtc);
				orderDto.setDeliveryMethod(orderMethod);
				orderDto.setDeliveryCharge(ChargeName);
				
				retVal=orderDao.orderRegist(orderDto);
				
				if(retVal==-1){
					msg="���ֿ���! ���� ����ó���� ������ �ִ��� Ȯ�� �Ͻñ� �ٶ��ϴ�.";
				}else if(retVal==0){
					msg="����[1]����!";
				}else{
					msg="����[1]�Ϸ�!";
					
					retVal = orderDao.orderDetailRegist(logid,orders, ordercode);
		
					if(retVal==-1){
						msg="����[2]����!";
					}else if(retVal==0){
						msg="����[2]����!";
					}else{
						
						msg="���ֿϷ�!";

					}
					
				}
				
				if("���ֿϷ�!".equals(msg)){
									
					if("N".equals(EmailKey) && "N".equals(emailResult)){
						msg="���ֿϷ� ó���Ͽ����� �̸��� ������ �����Ͽ����ϴ�.\\n�̸��� ������ Ȯ���Ͻð� ���ָ���Ʈ���� ���ּ��� ó���ϼ���!!"; 
					}else{
						msg="���ֿϷ�!";
					}

					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "orderProcess action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					
					return alertAndExit(model,msg,request.getContextPath()+"/H_Order.do?cmd=orderPageList","");	
					
				}else{
					

					//log action execute time end
					long t2 = System.currentTimeMillis();
					log.trace(logid, "orderProcess action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
					
					return alertAndExit(model,msg,request.getContextPath()+"/H_Order.do?cmd=targetPageList","");	
					
				}
				
			}	  
		  
	/**
	 * �����Ȳ EXCEL��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward stockExcelForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "stockExcelForm action start");
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "stockExcelForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("stockExcelForm");
	 }
	
	/**
	 * �����Ȳ ���(EXCEL)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception 
	 */
	public ActionForward stockExcelImport(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "stockExcelImport action start");
		
		String USERID = UserBroker.getUserId(request);
		String GROUPID = UserBroker.getGroupID(request);
		String msg = "";

		
		ArrayList<StockDTO> stockList =new ArrayList();
		StockDTO stockDto = new StockDTO();
    	String StockDate="";
    	String GroupName="";
	    
		MultipartRequest multipartRequest = new MultipartRequest( request,UPLOAD_PATH, 500*1024*1000, "euc-kr", new ByTimestampFileRenamePolicy());	
		
		File file=multipartRequest.getFile("stockFile");
		String fileName=file.getName();
		int exeindex = fileName.indexOf(".");
		fileName=fileName.substring(0,exeindex-1);

		try{
			Workbook workbook = Workbook.getWorkbook(file);
			
			Sheet sheet = workbook.getSheet(0);
		    Cell myCell = null;
		    System.out.println("���� �� �ο� : "+sheet.getRows());
		    for(int h=0; h<sheet.getRows()-2; h++){
		    	
		    	StockDTO stockDetailDto = new StockDTO();
		    	String[] sItemTmp = new String[7]; 
		    	String stockPK="";

		    	
		    	if(h==0){//�׷�� /����� ����
		    		
		    		myCell = sheet.getCell(0,0); 
		    		stockPK= myCell.getContents(); 
		    		
		    		String[] sPkTmp =stockPK.trim().split("/"); 
		    	
		    		int spklength=sPkTmp.length;

		    		stockDto.setChUserID(USERID); //USERID
		    		
		    		GROUPID=StringUtil.nvl(multipartRequest.getParameter("GroupID"),"");
			    	   
		    		stockDto.setGroupID(GROUPID);
		    		
		    		//GroupName=sPkTmp[spklength-4].trim();
		    		GroupName=StringUtil.nvl(multipartRequest.getParameter("GroupName"),"");
		    		
		    	    stockDto.setGroupName(GroupName);
		    	
		    		//StockDate=sPkTmp[spklength-3].trim()+sPkTmp[spklength-2].trim()+sPkTmp[spklength-1].trim();
		    		StockDate=StringUtil.nvl(multipartRequest.getParameter("stockDate"),"");
		    		
		    		stockDto.setStockDate(StockDate);
		    		
		    	}else if (h==1){
		    		//Ÿ��Ʋ
		    		// System.out.println("���� �� �ο� �ι�° : ");
		    	}else{
		    	
			        for(int i=0;i<7;i++){
			           myCell = sheet.getCell(i,h); 
			           sItemTmp[i] = myCell.getContents(); 
			        }
			        
			        //��ĭ���� �ƴ��� üũ
			        if(sItemTmp[0] != ""){
			        /*	log.debug("[sItemTmp[0]]"+sItemTmp[0]);
			        	log.debug("[sItemTmp[1]]"+sItemTmp[1]);
			        	log.debug("[sItemTmp[2]]"+sItemTmp[2]);
			        	log.debug("[sItemTmp[3]]"+sItemTmp[3]);
			        	log.debug("[sItemTmp[4]]"+sItemTmp[4]);
			        	log.debug("[sItemTmp[5]]"+sItemTmp[5]);
			        	log.debug("[sItemTmp[6]]"+sItemTmp[6]);
			        	log.debug("[sItemTmp[7]]"+sItemTmp[7]);
			        	*/

			        	stockDetailDto.setLogid(logid);
			        	stockDetailDto.setChUserID(USERID); //USERID
			        	stockDetailDto.setGroupID(GROUPID);
			        	stockDetailDto.setGroupName(GroupName);
			        	stockDetailDto.setStockDate(StockDate);
			        	stockDetailDto.setProductCode(sItemTmp[0]); //ProductCode
			        	stockDetailDto.setStockCnt(Integer.parseInt(sItemTmp[3])); //StockCnt
			        	
			        	log.debug("[StockDate]"+stockDetailDto.getStockDate());
			        	log.debug("[ProductCode]"+stockDetailDto.getProductCode());
			        	log.debug("[StockCnt]"+stockDetailDto.getStockCnt());
			        
			        	stockList.add(stockDetailDto);
			        }
		    	}
		    }
		    
		}catch (Exception e) {
			
			 msg = "���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!!";

		    //log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "userExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return alertAndExit(model,msg,request.getContextPath()+"/H_Order.do?cmd=stockPageList","");
			
		}
		
	    StockDAO stockDao = new StockDAO();
	    
	    String importResult=stockDao.stockListImport(stockDto,stockList,fileName);

		long t2 = System.currentTimeMillis();
		log.trace(logid, "stockExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		msg = importResult;
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Order.do?cmd=stockPageList","");

	}
	/**
	 * ����ó��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward orderProcSave(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		// log action execute time start
		String logid = log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "orderProcSave action start");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		String OrderCode = StringUtil.nvl(request.getParameter("OrderCode"), "");
		String ProductCode = StringUtil.nvl(request.getParameter("ProductCode"), "");
		String OrderCheck = StringUtil.nvl(request.getParameter("OrderCheck"), "");
		int OrderResultCnt = StringUtil.nvl(request.getParameter("OrderResultCnt"), 0);
		int OrderResultPrice = StringUtil.nvl(request.getParameter("OrderResultPrice"), 0);
		String VatRate = StringUtil.nvl(request.getParameter("VatRate"), "0.1");
		String OrderMemo =StringUtil.nvl(URLDecoder.decode(request.getParameter("OrderMemo").trim(), "UTF-8"),""); 
		
		OrderDAO orderDao = new OrderDAO();
		OrderDTO orderDto = new OrderDTO();

		orderDto.setLogid(logid);
		orderDto.setChUserID(USERID);
		orderDto.setOrderCode(OrderCode);
		orderDto.setProductCode(ProductCode);
		orderDto.setOrderCheck(OrderCheck);
		orderDto.setOrderResultCnt(OrderResultCnt);
		orderDto.setOrderResultPrice(OrderResultPrice);
		orderDto.setVatRate(VatRate);
		orderDto.setOrderMemo(OrderMemo);
	
		int retVal = -1;
		String IngYN="-1";
	  	retVal = orderDao.orderProcSave(orderDto);
		//retVal=1;
		
		if(retVal==1){
			IngYN=orderDao.orderIngYN(orderDto);
		}
		
		response.setContentType("text");
		response.getWriter().print(IngYN);

		// log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "orderProcSave action end execute time:[" + (t2 - t1)
				/ 1000.0 + "] seconds");

		return null;
	}
	/**
	 * ���ſϷ�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward orderProcClose(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		// log action execute time start
		String logid = log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "orderProcClose action start");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		String OrderCode = StringUtil.nvl(request.getParameter("OrderCode"), "");
				
		OrderDAO orderDao = new OrderDAO();
		OrderDTO orderDto = new OrderDTO();

		orderDto.setLogid(logid);
		orderDto.setOrderCode(OrderCode);
		orderDto.setChUserID(USERID);
	
		int retVal = -1;
		retVal = orderDao.orderProcClose(orderDto);
		
	
		response.setContentType("text");
		response.getWriter().print(retVal);

		// log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "orderProcClose action end execute time:[" + (t2 - t1)
				/ 1000.0 + "] seconds");

		return null;
	}
	
	
}
