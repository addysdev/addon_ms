package com.web.webaction.config.action;

import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;



import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.web.framework.persist.ListDTO;
import com.web.framework.util.StringUtil;
import com.web.framework.struts.StrutsDispatchAction;

import com.web.common.BaseAction;
import com.web.common.address.AddressDTO;
import com.web.common.config.MasterDAO;
import com.web.common.config.ProductDTO;
import com.web.common.config.CompanyDTO;
import com.web.common.config.SafeStockDTO;
import com.web.common.user.UserDTO;
import com.web.common.user.UserBroker;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;

import com.web.framework.util.ByTimestampFileRenamePolicy;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.InJectionFilter;

import com.web.framework.data.DataSet;
import com.oreilly.servlet.MultipartRequest;

public class MasterAction extends StrutsDispatchAction{

	public static String UPLOAD_PATH = config.getString("framework.fileupload.temppath");
	/**
	 * ��ǰ���� ���� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward productPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productPageList action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		int searchTab = StringUtil.nvl(request.getParameter("searchTab"),1);
		
		InJectionFilter inJectionFilter = new InJectionFilter();
		
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}
		
		MasterDAO masterDao = new MasterDAO();
		ProductDTO productDto = new ProductDTO();

		//����Ʈ
		productDto.setLogid(logid);
		productDto.setChUserID(USERID);
		productDto.setvSearchType(searchGb);
		productDto.setvSearch(searchtxt);
		productDto.setnRow(20);
		productDto.setnPage(curPageCnt);
		
		ListDTO ld = masterDao.productPageList(productDto);

		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("productPageList");
   	}
	
	/**
	 * ���� ��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward productRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productRegistForm action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

		return actionMapping.findForward("productRegistForm");
	 }
	
	/**
	 * ��ǰ ���
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward productRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productRegist action start");
		
		
		String productcode = StringUtil.nvl(request.getParameter("productCode"),"");
		String barcode = StringUtil.nvl(request.getParameter("BarCode"),"");
		String productname = StringUtil.nvl(request.getParameter("productName"),"");
		String companycode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
		String group1 = StringUtil.nvl(request.getParameter("group1"),"");
		String group1name = StringUtil.nvl(request.getParameter("group1name"),"");
		String group2 = StringUtil.nvl(request.getParameter("group2"),"");
		String group2name = StringUtil.nvl(request.getParameter("group2name"),"");
		String group3 = StringUtil.nvl(request.getParameter("group3"),"");
		String group3name = StringUtil.nvl(request.getParameter("group3name"),"");
		int ProductPrice = StringUtil.nvl(request.getParameter("ProductPrice"),0);
		String VatRate = StringUtil.nvl(request.getParameter("VatRate"),"0.0");

		String msg="";
	
		int retVal=0;

		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		MasterDAO masterDao = new MasterDAO();
		ProductDTO productDto = new ProductDTO();

		productDto.setLogid(logid);
		productDto.setChUserID(USERID);
		productDto.setProductCode(productcode);
		productDto.setBarCode(barcode);
		productDto.setProductName(productname);
		productDto.setCompanyCode(companycode);
		productDto.setGroup1(group1);
		productDto.setGroup1Name(group1name);
		productDto.setGroup2(group2);
		productDto.setGroup2Name(group2name);
		productDto.setGroup3(group3);
		productDto.setGroup3Name(group3name);
		productDto.setProductPrice(ProductPrice);
		productDto.setVatRate(VatRate);
		
		retVal=masterDao.productRegist(productDto);

		if(retVal==-1){
			msg="�ý��� �����Դϴ�.!";
		}else if(retVal==0){
			msg="����� �����߽��ϴ�!";
		}else{
			msg="����� �����߽��ϴ�!.";
		}			
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Master.do?cmd=productPageList","");
		
	}
	
	/**
	 * ��ǰ ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userModifyForm
	 * @throws Exception
	 */
	public ActionForward productModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productModifyForm action start");
		
		String productcode = StringUtil.nvl(request.getParameter("productcode"),"");
		
		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		MasterDAO masterDao = new MasterDAO();
		ProductDTO productDto = new ProductDTO();
		
		productDto.setLogid(logid);
		productDto.setProductCode(productcode);
		
		productDto = masterDao.productView(productDto);
		
		if(productDto == null){
			msg = "��ǰ ������ �����ϴ�.";	
	    }
		
		model.put("productDto", productDto);
	    model.put("msg", msg);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("productModifyForm");
	}
	
	/**
	 * ��ǰ ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward productModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productModify action start");
		
		String productcode = StringUtil.nvl(request.getParameter("productCode"),"");
		String barcode = StringUtil.nvl(request.getParameter("BarCode"),"");
		String productname = StringUtil.nvl(request.getParameter("productName"),"");
		String companycode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
		String RecoveryYN = StringUtil.nvl(request.getParameter("RecoveryYN"),"");
		String group1 = StringUtil.nvl(request.getParameter("group1"),"");
		String group1name = StringUtil.nvl(request.getParameter("group1name"),"");
		String group2 = StringUtil.nvl(request.getParameter("group2"),"");
		String group2name = StringUtil.nvl(request.getParameter("group2name"),"");
		String group3 = StringUtil.nvl(request.getParameter("group3"),"");
		String group3name = StringUtil.nvl(request.getParameter("group3name"),"");
		int ProductPrice = StringUtil.nvl(request.getParameter("ProductPrice"),0);
		String VatRate = StringUtil.nvl(request.getParameter("VatRate"),"0.0");


		String msg="";
	
		int retVal=0;

		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 

		MasterDAO masterDao = new MasterDAO();
		ProductDTO productDto = new ProductDTO();

		productDto.setLogid(logid);
		productDto.setChUserID(USERID);
		productDto.setProductCode(productcode);
		productDto.setBarCode(barcode);
		productDto.setProductName(productname);
		productDto.setCompanyCode(companycode);
		productDto.setRecoveryYN(RecoveryYN);
		productDto.setGroup1(group1);
		productDto.setGroup1Name(group1name);
		productDto.setGroup2(group2);
		productDto.setGroup2Name(group2name);
		productDto.setGroup3(group3);
		productDto.setGroup3Name(group3name);
		productDto.setProductPrice(ProductPrice);
		productDto.setVatRate(VatRate);
		
		retVal=masterDao.productModify(productDto);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Master.do?cmd=productPageList","");
		
	}
	/**
	 * ��ǰ ������ �����Ѵ�.(�ٰ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward productDeletes(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productDeletes action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.

		int retVal=-1;
		String msg="";
		
		String[] prods = request.getParameterValues("seqs");
		MasterDAO masterDao = new MasterDAO();

		retVal = masterDao.productDeletes(logid,prods, USERID);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Master.do?cmd=productPageList","");
		
	}
	
	/**
	 * ��ǰ �ߺ�üũ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userXML
	 * @throws Exception
	 */
	public ActionForward productDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "productDupCheck action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String productcode = StringUtil.nvl(request.getParameter("productcode"),"");

		MasterDAO masterDao = new MasterDAO();
		ProductDTO productDto = new ProductDTO();

		productDto.setLogid(logid);
		productDto.setProductCode(productcode);
		productDto.setChUserID(USERID);
		
		String result = masterDao.productDupCheck(productDto, "DUPLICATE");
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(result);
		
		//model.put("result", result );
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "productDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return null;
		
	}
	
	/**
	 * ����ó EXCEL��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward companyExcelForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "companyExcelForm action start");
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "companyExcelForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("companyExcelForm");
	 }
	
	
	/**
	 * ����� ���� �ʱ⼼��(EXCEL)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception 
	 */
	public ActionForward companyExcelImport(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "companyExcelImport action start");
		
		String USERID = UserBroker.getUserId(request);
		String msg = "";

		
		ArrayList<CompanyDTO> companyList =new ArrayList();
	    
		MultipartRequest multipartRequest = new MultipartRequest( request,UPLOAD_PATH, 500*1024*1000, "euc-kr", new ByTimestampFileRenamePolicy());	
		
		File file=multipartRequest.getFile("companyFile");
		String fileName=file.getName();
		int exeindex = fileName.indexOf(".");
		fileName=fileName.substring(0,exeindex-1);

		try{
			Workbook workbook = Workbook.getWorkbook(file);
			
			Sheet sheet = workbook.getSheet(0);
		    Cell myCell = null;
		    log.debug("���� �� �ο� : "+sheet.getRows());
		    System.out.println("���� �� �ο� : "+sheet.getRows());
		    for(int h=1; h<sheet.getRows(); h++){
		    	CompanyDTO companyDto = new CompanyDTO();
		    	String[] sItemTmp = new String[9]; 
		        for(int i=0;i<9;i++){
		           myCell = sheet.getCell(i,h); 
		           sItemTmp[i] = myCell.getContents(); 
		        }
		        
		        //��ĭ���� �ƴ��� üũ
		        if(sItemTmp[0] != ""){

		        	companyDto.setLogid(logid);
		        	companyDto.setChUserID(USERID); //USERID
		        	companyDto.setCompanyCode(sItemTmp[0]); //CompanyCode
		        	companyDto.setCompanyName(sItemTmp[1]); //CompanyName
		        	companyDto.setCompanyPhone(sItemTmp[4]); //CompanyPhone
		        	companyDto.setPostCode(sItemTmp[7]); //PostCode
		        	companyDto.setAddress1(sItemTmp[8]); //Address1
		        	companyDto.setFaxNumber(sItemTmp[5]); //
		        	companyDto.setMobilePhone(sItemTmp[3]); //
		        	companyDto.setEmail(sItemTmp[6]); //
		        	companyDto.setChargeName(sItemTmp[2]); //
		        	
		        	log.debug("[CompanyCode]"+companyDto.getCompanyCode());
		        	log.debug("[CompanyName]"+companyDto.getCompanyName());
		        	log.debug("[CompanyPhone]"+companyDto.getCompanyPhone());
		        	log.debug("[PostCode]"+companyDto.getPostCode());
		        	log.debug("[Address1]"+companyDto.getAddress1());
		        	log.debug("[FaxNumber]"+companyDto.getFaxNumber());
		        	log.debug("[Email]"+companyDto.getEmail());
		        	log.debug("[ChargeName]"+companyDto.getChargeName());
					
		        	companyList.add(companyDto);
		        }
		       
		    }
		    
		}catch (Exception e) {
			
			 msg = "���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!!";

		    //log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "companyExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return alertAndExit(model,msg,request.getContextPath()+"/H_Master.do?cmd=productPageList","");
			
		}
		
	    MasterDAO masterDao = new MasterDAO();
	    
	    String importResult=masterDao.companyListImport(companyList,fileName);

		long t2 = System.currentTimeMillis();
		log.trace(logid, "companyExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		msg = importResult;
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Master.do?cmd=productPageList","");

	}
	/**
	 * ������� ���� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward safeStockList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "safeStockList action start");
		
		String productcode = StringUtil.nvl(request.getParameter("productcode"),"");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 	
		
		MasterDAO masterDao = new MasterDAO();
		SafeStockDTO safeStockDto = new SafeStockDTO();
		
		safeStockDto.setLogid(logid);
		safeStockDto.setChUserID(USERID);
		safeStockDto.setProductCode(productcode);
		
		ListDTO ld = masterDao.safeStockList(safeStockDto);
		
		model.put("listInfo",ld);	
		model.put("ProductCode",productcode);	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "safeStockList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("safeStockList");
	}
	/**
	 * �޸���
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward safeStockSave(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		// log action execute time start
		String logid = log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "safeStockSave action start");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		String groupID = StringUtil.nvl(request.getParameter("GroupID"), "");
		String productCode = StringUtil.nvl(request.getParameter("ProductCode"), "");
		int safeStockCnt = StringUtil.nvl(request.getParameter("SafeStock"), 0);
		String procYN =StringUtil.nvl(request.getParameter("ProcYN"), "");
		
		MasterDAO masterDao = new MasterDAO();

		SafeStockDTO safeStockDto = new SafeStockDTO();

		safeStockDto.setLogid(logid);
		safeStockDto.setChUserID(USERID);
		safeStockDto.setGroupID(groupID);
		safeStockDto.setProductCode(productCode);
		safeStockDto.setSafeStockCnt(safeStockCnt);
		safeStockDto.setProcYN(procYN);
	
		int retVal = -1;
		retVal = masterDao.safeStockSave(safeStockDto);

		response.setContentType("text");
		response.getWriter().print(retVal);

		// log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "safeStockSave action end execute time:[" + (t2 - t1)
				/ 1000.0 + "] seconds");

		return null;
	}
}
