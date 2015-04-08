package com.web.common.order;

import com.web.framework.util.StringUtil;

public class OrderDTO {

	protected int loginSeq;
	
	//sp º¯°æ
	protected String chUserID;
	protected String FrDate;
	protected String ToDate;
	protected String GroupID;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;
	
	protected String OrderCode;
	protected String CompanyCode;
	protected String OrderDateTime;
	protected String OrderUserID;
	protected String FAXKey;
	protected String SMSKey;
	protected String EmailKey;
	
	protected String mobilephone;
	protected String emailaddr;
	protected String faxnum;
	
	protected String OrderEtc;
	protected String OrderAdress;
	
	protected int ToTalOrderPrice;
	protected String IngYN;
	
	protected String ProductCode;
	protected int OrderCnt;
	protected String Etc;
	protected int StockCnt;
	protected int SafeStock;
	protected int LossCnt;
	protected int AddCnt;
	protected String Memo;
	protected int OrderResultCnt;
	protected int OrderResultPrice;
	protected String OrderCheck;
	
	protected String BuyResult;
	protected String DeliveryDate;
	protected String DeliveryEtc;
	protected String DeliveryMethod;
	protected String DeliveryCharge;
	
	protected String VatRate;
	protected String OrderMemo;
	
	protected String logid;

	public int getLoginSeq() {
		return loginSeq;
	}

	public void setLoginSeq(int loginSeq) {
		this.loginSeq = loginSeq;
	}

	public String getChUserID() {
		return chUserID;
	}

	public void setChUserID(String chUserID) {
		this.chUserID = chUserID;
	}

	public String getFrDate() {
		return FrDate;
	}

	public void setFrDate(String frDate) {
		FrDate = frDate;
	}

	public String getToDate() {
		return ToDate;
	}

	public void setToDate(String toDate) {
		ToDate = toDate;
	}

	public String getGroupID() {
		return GroupID;
	}

	public void setGroupID(String groupID) {
		GroupID = groupID;
	}

	public String getvSearchType() {
		return vSearchType;
	}

	public void setvSearchType(String vSearchType) {
		this.vSearchType = vSearchType;
	}

	public String getvSearch() {
		return vSearch;
	}

	public void setvSearch(String vSearch) {
		this.vSearch = vSearch;
	}

	public int getnRow() {
		return nRow;
	}

	public void setnRow(int nRow) {
		this.nRow = nRow;
	}

	public int getnPage() {
		return nPage;
	}

	public void setnPage(int nPage) {
		this.nPage = nPage;
	}

	public String getJobGb() {
		return JobGb;
	}

	public void setJobGb(String jobGb) {
		JobGb = jobGb;
	}

	public String getCompanyCode() {
		return CompanyCode;
	}

	public void setCompanyCode(String companyCode) {
		CompanyCode = companyCode;
	}

	public String getOrderDateTime() {
		return OrderDateTime;
	}

	public void setOrderDateTime(String orderDateTime) {
		OrderDateTime = orderDateTime;
	}

	public String getOrderUserID() {
		return OrderUserID;
	}

	public void setOrderUserID(String orderUserID) {
		OrderUserID = orderUserID;
	}

	public String getFAXKey() {
		return FAXKey;
	}

	public void setFAXKey(String fAXKey) {
		FAXKey = fAXKey;
	}

	public String getSMSKey() {
		return SMSKey;
	}

	public void setSMSKey(String sMSKey) {
		SMSKey = sMSKey;
	}

	public String getEmailKey() {
		return EmailKey;
	}

	public void setEmailKey(String emailKey) {
		EmailKey = emailKey;
	}

	public int getToTalOrderPrice() {
		return ToTalOrderPrice;
	}

	public void setToTalOrderPrice(int toTalOrderPrice) {
		ToTalOrderPrice = toTalOrderPrice;
	}

	public String getIngYN() {
		return IngYN;
	}

	public void setIngYN(String ingYN) {
		IngYN = ingYN;
	}

	public String getProductCode() {
		return ProductCode;
	}

	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}

	public int getOrderCnt() {
		return OrderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		OrderCnt = orderCnt;
	}

	public String getEtc() {
		return Etc;
	}

	public void setEtc(String etc) {
		Etc = etc;
	}

	public int getStockCnt() {
		return StockCnt;
	}

	public void setStockCnt(int stockCnt) {
		StockCnt = stockCnt;
	}

	public int getSafeStock() {
		return SafeStock;
	}

	public void setSafeStock(int safeStock) {
		SafeStock = safeStock;
	}

	public int getLossCnt() {
		return LossCnt;
	}

	public void setLossCnt(int lossCnt) {
		LossCnt = lossCnt;
	}

	public int getAddCnt() {
		return AddCnt;
	}

	public void setAddCnt(int addCnt) {
		AddCnt = addCnt;
	}

	public String getMemo() {
		return Memo;
	}

	public void setMemo(String memo) {
		Memo = memo;
	}

	public int getOrderResultCnt() {
		return OrderResultCnt;
	}

	public void setOrderResultCnt(int orderResultCnt) {
		OrderResultCnt = orderResultCnt;
	}

	public int getOrderResultPrice() {
		return OrderResultPrice;
	}

	public void setOrderResultPrice(int orderResultPrice) {
		OrderResultPrice = orderResultPrice;
	}

	public String getOrderCheck() {
		return OrderCheck;
	}

	public void setOrderCheck(String orderCheck) {
		OrderCheck = orderCheck;
	}

	public String getLogid() {
		return logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

	public String getOrderCode() {
		return OrderCode;
	}

	public void setOrderCode(String orderCode) {
		OrderCode = orderCode;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public String getEmailaddr() {
		return emailaddr;
	}

	public void setEmailaddr(String emailaddr) {
		this.emailaddr = emailaddr;
	}

	public String getFaxnum() {
		return faxnum;
	}

	public void setFaxnum(String faxnum) {
		this.faxnum = faxnum;
	}

	public String getOrderEtc() {
		return OrderEtc;
	}

	public void setOrderEtc(String orderEtc) {
		OrderEtc = orderEtc;
	}

	public String getOrderAdress() {
		return OrderAdress;
	}

	public void setOrderAdress(String orderAdress) {
		OrderAdress = orderAdress;
	}

	public String getBuyResult() {
		return BuyResult;
	}

	public void setBuyResult(String buyResult) {
		BuyResult = buyResult;
	}

	public String getDeliveryDate() {
		return DeliveryDate;
	}

	public void setDeliveryDate(String deliveryDate) {
		DeliveryDate = deliveryDate;
	}

	public String getDeliveryEtc() {
		return DeliveryEtc;
	}

	public void setDeliveryEtc(String deliveryEtc) {
		DeliveryEtc = deliveryEtc;
	}

	public String getDeliveryMethod() {
		return DeliveryMethod;
	}

	public void setDeliveryMethod(String deliveryMethod) {
		DeliveryMethod = deliveryMethod;
	}

	public String getDeliveryCharge() {
		return DeliveryCharge;
	}

	public void setDeliveryCharge(String deliveryCharge) {
		DeliveryCharge = deliveryCharge;
	}

	public String getVatRate() {
		return VatRate;
	}

	public void setVatRate(String vatRate) {
		VatRate = vatRate;
	}

	public String getOrderMemo() {
		return OrderMemo;
	}

	public void setOrderMemo(String orderMemo) {
		OrderMemo = orderMemo;
	}
	
	
}
