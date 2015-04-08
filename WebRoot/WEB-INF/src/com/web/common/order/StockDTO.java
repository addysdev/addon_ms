package com.web.common.order;

import com.web.framework.util.StringUtil;

public class StockDTO {

	protected int loginSeq;
	
	//sp º¯°æ
	protected String chUserID;
	protected String FrDate;
	protected String ToDate;
	protected String SearchGroup;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;
	
	protected String StockDate;
	protected String GroupID;
	protected String GroupName;
	protected String StockDateTime;
	protected String LastUserID;
	protected String ProductCode;
	protected int StockCnt;
	
	protected String logid;
	
	
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
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
	public String getStockDate() {
		return StockDate;
	}
	public void setStockDate(String stockDate) {
		StockDate = stockDate;
	}
	public String getGroupID() {
		return GroupID;
	}
	public void setGroupID(String groupID) {
		GroupID = groupID;
	}
	public String getStockDateTime() {
		return StockDateTime;
	}
	public void setStockDateTime(String stockDateTime) {
		StockDateTime = stockDateTime;
	}
	public String getLastUserID() {
		return LastUserID;
	}
	public void setLastUserID(String lastUserID) {
		LastUserID = lastUserID;
	}
	public String getProductCode() {
		return ProductCode;
	}
	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}
	public int getStockCnt() {
		return StockCnt;
	}
	public void setStockCnt(int stockCnt) {
		StockCnt = stockCnt;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	
}
