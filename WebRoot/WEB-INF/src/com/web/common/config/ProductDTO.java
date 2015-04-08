package com.web.common.config;

import com.web.framework.util.StringUtil;

public class ProductDTO {

	protected int loginSeq;
	
	//sp 변경
	protected String chUserID;
	protected String FrDate;
	protected String ToDate;
	protected String SearchGroup;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;
	
	protected String ProductCode;
	protected String BarCode;
	protected String ProductName;
	protected String CompanyCode;
	protected String CompanyName;
	protected int ProductPrice;
	protected String VatRate;
	protected String Group1;
	protected String Group1Name;
	protected String Group2;
	protected String Group2Name;
	protected String Group3;
	protected String Group3Name;
	protected String RecoveryYN;
	protected String CreateUserID;
	protected String UpdateUserID;
	protected String CreateDateTime;
	protected String UpdateDateTime;
	protected String DeletedYN;
	
	//넘어다니는 파라미터
    protected String curPage;
    protected String searchGb;
    protected String searchTxt;
    
    //log id
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

	public String getSearchGroup() {
		return SearchGroup;
	}

	public void setSearchGroup(String searchGroup) {
		SearchGroup = searchGroup;
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

	public String getProductCode() {
		return ProductCode;
	}

	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}

	public String getBarCode() {
		return BarCode;
	}

	public void setBarCode(String barCode) {
		BarCode = barCode;
	}

	public String getProductName() {
		return ProductName;
	}

	public void setProductName(String productName) {
		ProductName = productName;
	}

	public String getCompanyCode() {
		return CompanyCode;
	}

	public void setCompanyCode(String companyCode) {
		CompanyCode = companyCode;
	}

	public String getCompanyName() {
		return CompanyName;
	}

	public void setCompanyName(String companyName) {
		CompanyName = companyName;
	}

	public String getGroup1() {
		return Group1;
	}

	public void setGroup1(String group1) {
		Group1 = group1;
	}

	public String getGroup1Name() {
		return Group1Name;
	}

	public void setGroup1Name(String group1Name) {
		Group1Name = group1Name;
	}

	public String getGroup2() {
		return Group2;
	}

	public void setGroup2(String group2) {
		Group2 = group2;
	}

	public String getGroup2Name() {
		return Group2Name;
	}

	public void setGroup2Name(String group2Name) {
		Group2Name = group2Name;
	}

	public String getGroup3() {
		return Group3;
	}

	public void setGroup3(String group3) {
		Group3 = group3;
	}

	public String getGroup3Name() {
		return Group3Name;
	}

	public void setGroup3Name(String group3Name) {
		Group3Name = group3Name;
	}

	public String getRecoveryYN() {
		return RecoveryYN;
	}

	public void setRecoveryYN(String recoveryYN) {
		RecoveryYN = recoveryYN;
	}

	public String getCreateUserID() {
		return CreateUserID;
	}

	public void setCreateUserID(String createUserID) {
		CreateUserID = createUserID;
	}

	public String getUpdateUserID() {
		return UpdateUserID;
	}

	public void setUpdateUserID(String updateUserID) {
		UpdateUserID = updateUserID;
	}

	public String getCreateDateTime() {
		return CreateDateTime;
	}

	public void setCreateDateTime(String createDateTime) {
		CreateDateTime = createDateTime;
	}

	public String getUpdateDateTime() {
		return UpdateDateTime;
	}

	public void setUpdateDateTime(String updateDateTime) {
		UpdateDateTime = updateDateTime;
	}

	public String getDeletedYN() {
		return DeletedYN;
	}

	public void setDeletedYN(String deletedYN) {
		DeletedYN = deletedYN;
	}

	public String getCurPage() {
		return curPage;
	}

	public void setCurPage(String curPage) {
		this.curPage = curPage;
	}

	public String getSearchGb() {
		return searchGb;
	}

	public void setSearchGb(String searchGb) {
		this.searchGb = searchGb;
	}

	public String getSearchTxt() {
		return searchTxt;
	}

	public void setSearchTxt(String searchTxt) {
		this.searchTxt = searchTxt;
	}

	public String getLogid() {
		return logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

	public int getProductPrice() {
		return ProductPrice;
	}

	public void setProductPrice(int productPrice) {
		ProductPrice = productPrice;
	}

	public String getVatRate() {
		return VatRate;
	}

	public void setVatRate(String vatRate) {
		VatRate = vatRate;
	}


	
}
