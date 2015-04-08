package com.web.webaction.address.action;

import java.io.File;
import java.net.URL;
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
import com.web.common.user.UserDAO;
import com.web.common.user.UserDTO;
import com.web.common.address.AddressDAO;
import com.web.common.address.AddressDTO;
import com.web.common.user.UserBroker;
import com.web.common.user.UserMemDTO;
import com.web.common.util.DateUtil;
import com.web.webaction.user.action.UserAction;

import com.web.framework.util.ByTimestampFileRenamePolicy;
import com.web.framework.util.DateTimeUtil;
import com.web.framework.util.HtmlXSSFilter;
import com.web.framework.util.InJectionFilter;

import com.web.framework.data.DataSet;
import com.oreilly.servlet.MultipartRequest;

public class AddressAction extends StrutsDispatchAction{

	
	/**
	 * �ּҷ� ���� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward AddressPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressPageList action start");
		
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
		
		InJectionFilter inJectionFilter = new InJectionFilter();
		
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}
		
		//String vGroupID = StringUtil.nvl(request.getParameter("vGroupID"),"");
		//String vInitYN=StringUtil.nvl(request.getParameter("vInitYN"),"N");
	
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		//����Ʈ
		addrDto.setLogid(logid);
		addrDto.setUserID(USERID);
		addrDto.setvSearchType(searchGb);
		addrDto.setvSearch(searchtxt);
		addrDto.setnRow(10);
		addrDto.setnPage(curPageCnt);
	    
		ListDTO ld = addrDao.addrPageList(addrDto);
		
		
		//ī��Ʈ ���� UserDTO userDtoCount = userDao.userTotCount(userDto);
		
		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("AddressPageList");
   	}
	
	/**
	 * �ּҷ� ���ó��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward AddressRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressRegist action start");
		
		String AddressName = StringUtil.nvl(URLDecoder.decode(request.getParameter("AddressName"),"UTF-8") ,"");
		String FaxNo = StringUtil.nvl(request.getParameter("FaxNo"),"");
		String OfficePhone = StringUtil.nvl(request.getParameter("OfficePhone"),"");
		String MobilePhone = StringUtil.nvl(request.getParameter("MobilePhone"),"");
		String Email = StringUtil.nvl(request.getParameter("Email"),"");
		String Memo = StringUtil.nvl(URLDecoder.decode(request.getParameter("Memo"),"UTF-8"),"");

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
		
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		addrDto.setUserID(USERID);
		addrDto.setAddressName(AddressName);
		addrDto.setFaxNo(FaxNo);
		addrDto.setOfficePhone(OfficePhone);
		addrDto.setMobilePhone(MobilePhone);
		addrDto.setEmail(Email);
		addrDto.setMemo(Memo);
		
		retVal=addrDao.addrRegist(addrDto);
		/*
		if(retVal==-1){
			msg="�ý��� �����Դϴ�.!";
		}else if(retVal==0){
			msg="����� �����߽��ϴ�!";
		}else{
			msg="����� �����߽��ϴ�!.";
		}*/
		//Jquery Ajax AddressPageList.jsp ���� ����� ó�� �޽��� ó�� ����.
		
		response.setContentType("text/html; charset=euc-kr"); //Jquery Ajax(UTF-8)�� �Ѿ�� ������ euc_kr�� jsp�������� �����ָ� jsp�������󿡼� ���ڵ��Ѵ�.("text/html; charset=euc-kr")
		response.getWriter().print(retVal);
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return null;	
	}
	
	/**
	 * �ּҷ� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userModifyForm
	 * @throws Exception
	 */
	public ActionForward AddressView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressView action start");
		
		int Seq = StringUtil.nvl(request.getParameter("Seq"),0);
		System.out.println("SEq:"+Seq);
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

		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		
		addrDto.setLogid(logid);
		addrDto.setSeq(Seq);
		addrDto.setUserID(USERID);

		addrDto = addrDao.addrView(addrDto);
		
		if(addrDto == null){
			msg = "����� ������ �����ϴ�.";	
	    }
		
		model.put("addrDto", addrDto);
	    model.put("msg", msg);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressView action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("AddressView");
	}
	
	/**
	 * �ּҷ��ѽ���ȣ �ߺ�üũ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userXML
	 * @throws Exception
	 */
	public ActionForward addrDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "addrDupCheck action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String FaxNo = StringUtil.nvl(request.getParameter("FaxNo"),"");
		
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		addrDto.setUserID(USERID);
		addrDto.setFaxNo(FaxNo);
		
		String result = addrDao.addrDupCheck(addrDto);
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(result);
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "addrDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return null;
	}
	
	/**
	 * �ּҷ� ����� ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward AddressModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressModify action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.  
		
		int Seq = StringUtil.nvl(request.getParameter("Seq"),0);
		String AddressName = StringUtil.nvl(URLDecoder.decode(request.getParameter("AddressName"),"UTF-8") ,"");
		String FaxNo = StringUtil.nvl(request.getParameter("FaxNo"),"");
		String OfficePhone = StringUtil.nvl(request.getParameter("OfficePhone"),"");
		String MobilePhone = StringUtil.nvl(request.getParameter("MobilePhone"),"");
		String Email = StringUtil.nvl(request.getParameter("Email"),"");
		String Memo = StringUtil.nvl(URLDecoder.decode(request.getParameter("Memo"),"UTF-8"),"");

		int retVal=0;
		String msg="";
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
				
		userDto.setLogid(logid);
		addrDto.setSeq(Seq);
		addrDto.setUserID(USERID);
		addrDto.setAddressName(AddressName);
		addrDto.setFaxNo(FaxNo);
		addrDto.setOfficePhone(OfficePhone);
		addrDto.setMobilePhone(MobilePhone);
		addrDto.setEmail(Email);
		addrDto.setOfficePhone(OfficePhone);
		addrDto.setMemo(Memo);
		
		retVal=addrDao.addrModify(addrDto);
		
		/*
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		*/
		//Jquery Ajax AddressPageList.jsp ���� ����� ó�� �޽��� ó�� ����.
		
		response.setContentType("text/html; charset=euc-kr"); //Jquery Ajax(UTF-8)�� �Ѿ�� ������ euc_kr�� jsp�������� �����ָ� jsp�������󿡼� ���ڵ��Ѵ�.("text/html; charset=euc-kr")
		response.getWriter().print(retVal);
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return null;
	}
	
	/**
	 * �ּҷ� ����� ������ �����Ѵ�.(�ٰ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward AddressDeletes(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressDeletes action start");
		
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
		
		String[] users_seq = request.getParameterValues("seqs");

		System.out.println("users_seq:"+users_seq);
		UserDAO userDao = new UserDAO();
		AddressDAO addrDao = new AddressDAO();

		retVal = addrDao.addrDeletes(logid,users_seq);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Address.do?cmd=AddressPageList","");	
		
	}
	
	/**
	 * �ּҷ� ����� ������ �̵��Ѵ�.(�ٰ�)(�Ϲݹ����߽�,��Ĺ߽�,��ĵ�߽�)���� ���� �߼� ����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward AddressMove(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressMove action start");
		
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
		
		String[] users_seq = request.getParameterValues("seqs");

		UserDAO userDao = new UserDAO();
		AddressDAO addrDao = new AddressDAO();

		retVal = addrDao.addrDeletes(logid,users_seq);
		
		if(retVal==-1){
			msg="�̵�����!";
		}else if(retVal==0){
			msg="�̵�����!";
		}else{
			msg="�̵��Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressMove action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Address.do?cmd=AddressPageListPopFrame","");	
		
	}
	
	/**
	 * �ּҷ� ���� ����Ʈ(�Ϲݹ����߽�,��Ĺ߽�,��ĵ�߽�) ����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward AddressPageListPopFrame(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressPageListPopFrame action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
		String searchtxt = "";
		
		searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		InJectionFilter inJectionFilter = new InJectionFilter();
		
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}
	
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		//����Ʈ
		addrDto.setLogid(logid);
		addrDto.setUserID(USERID);
		addrDto.setvSearchType(searchGb);
		addrDto.setvSearch(searchtxt);
		addrDto.setnRow(10);
		addrDto.setnPage(curPageCnt);
	    
		ListDTO ld = addrDao.addrPageList(addrDto);
			
		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressPageListPopFrame action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("AddressPageListPopFrame");
   	}
   
   /**
	 * �ּҷ� ���� ����Ʈ(�Ϲݹ����߽�,��Ĺ߽�,��ĵ�߽�) ����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
  public ActionForward AddressPageListPop(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressPageListPop action start");
		
		//�α��� ó�� 
		UserMemDTO dtoUser = BaseAction.getSession(request);
		String USERID = dtoUser.getUserId();
		
		String FormName = StringUtil.nvl(request.getParameter("FormName"),""); //(�Ϲݹ���,���,��ĵ)�߽� jsp���� ���� ����.
		
		if(USERID.equals("")){
			BaseAction.SesseionLogout( request.getRequestedSessionId(), "" );
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
	
	    
	    model.put("FormName",FormName);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressPageListPop action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("AddressPageListPop");
  	}
  
  	/**
	 * echo �����ȣ ���� EXCEL EXPORT
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return callBackExcelList
	 * @throws Exception
	 */
	public ActionForward AddressExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressExcelList action start");
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		UserMemDTO dtoUser = BaseAction.getSession(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		

		InJectionFilter inJectionFilter = new InJectionFilter();
				
		if(!"".equals(searchtxt.trim())){	        	
			searchtxt=inJectionFilter.filter(searchtxt.trim());
		}
	
		AddressDTO addrDto = new AddressDTO();
		AddressDAO addrDao = new AddressDAO();
		
		//����Ʈ
		addrDto.setLogid(logid);
		addrDto.setUserID(USERID);
		addrDto.setvSearchType(searchGb);
		addrDto.setvSearch(searchtxt);
		addrDto.setnRow(20);
		addrDto.setnPage(curPageCnt);
	    
		ListDTO ld = addrDao.addressExcelList(addrDto);
		
		model.put("listInfo",ld);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressExcelList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("AddressExcelList");
	}
  
  	/**
	 * �� �ּҷ� EXCEL��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward AddressExcelForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "AddressExcelForm action start");

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "AddressExcelForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("AddressExcelForm");
	 }
  
	/**
	 * �� �ּҷ� ���� �ʱ⼼��(EXCEL)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception 
	 */
	
	public static String UPLOAD_PATH = config.getString("framework.fileupload.path");
	
	public ActionForward AddressExcelImport(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "addressExcelImport action start");
		
		String USERID = UserBroker.getUserId(request);
		String msg = "";
		
		ArrayList<AddressDTO> addrList =new ArrayList();
	    
		MultipartRequest multipartRequest = new MultipartRequest( request,UPLOAD_PATH, 500*1024*1000, "euc-kr", new ByTimestampFileRenamePolicy(USERID,"A"));	
		
		File file=multipartRequest.getFile("addressFile");
		String fileName=file.getName();
		int exeindex = fileName.indexOf(".");
		fileName=fileName.substring(0,exeindex-1);

		try{
			Workbook workbook = Workbook.getWorkbook(file);
			
			Sheet sheet = workbook.getSheet(0); // ù��°��Ʈ
		    Cell myCell = null; //�� ĭ
		    System.out.println("���� �� �ο� : "+sheet.getRows()); //��Ʈ�� �ο� ��
		    for(int h=4; h<sheet.getRows(); h++){ //���� �ο� ��
		    	AddressDTO addrDto = new AddressDTO();
		    	String[] sItemTmp = new String[14]; // ������  �迭 ����
		        for(int i=0;i<6;i++){
		           myCell = sheet.getCell(i+1,h); 
		           sItemTmp[i] = myCell.getContents(); //���� �о����
		           System.out.println("����:"+sItemTmp[i]);
		        }
		        
		        //��ĭ���� �ƴ��� üũ (����ڸ�)
		        if(sItemTmp[0] != ""){
		        	//System.out.println("1:"+sItemTmp[0]); ���� ����Ÿ üũ ����
			        //System.out.println("2:"+sItemTmp[1]); 
			        //System.out.println("3:"+sItemTmp[2]);
			        //System.out.println("4:"+sItemTmp[3]);
			        //System.out.println("5:"+sItemTmp[4]);
			        //System.out.println("6:"+sItemTmp[5]);
		        	
		        	
		        	addrDto.setLogid(logid);
		        	addrDto.setUserID(USERID); //����ID
		        	addrDto.setAddressName(sItemTmp[0]); //����ڸ�
		        	addrDto.setFaxNo(sItemTmp[1]); //�ѽ���ȣ
		        	addrDto.setOfficePhone(sItemTmp[2]); //�� �Ǵ� ��ȭ��ȣ
		        	addrDto.setMobilePhone(sItemTmp[3]); //�ڵ��� ��ȣ
		        	addrDto.setEmail(sItemTmp[4]);	//Email
		        	addrDto.setMemo(sItemTmp[5]);	//�޸�
					
			        addrList.add(addrDto);
		        }
		       
		    }
		    
		}catch (Exception e) {
			
			 msg = "���ε带 �����߽��ϴ�.\\n���ε� ��Ŀ� �´� ����Ÿ���� Ȯ���ϼ���!!";

		    //log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "addressExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return alertAndExit(model,msg,request.getContextPath()+"/H_Address.do?cmd=AddressPageList","");
			
		}
		
	    AddressDAO addrDao = new AddressDAO();
	    
	    String importResult=addrDao.addressListImport(addrList,fileName);
	    System.out.println("importResult:"+importResult);
	    
	    //���DB ó��
	   // String bakImportResult=userDao.userListBackImport(userList,fileName);
			
	    
	    //model.put("bakImportResult", bakImportResult);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "addressExcelImport action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		msg = importResult;
		
		model.put("importResult", importResult);
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Address.do?cmd=AddressPageList","");
	}
	
	
}
