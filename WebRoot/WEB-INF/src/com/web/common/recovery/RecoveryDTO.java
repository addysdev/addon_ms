package com.web.common.recovery;

import com.web.framework.util.StringUtil;

public class RecoveryDTO {

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
	
	protected String RecoveryCode;
	protected String CompanyCode;
	protected String RecoveryDateTime;
	protected String RecoveryUserID;

	protected String IngYN;
	
	protected String ProductCode;
	protected int RecoveryCnt;
	protected int StockCnt;
	protected int LossAddCnt;
	protected String Memo;
	protected int RecoveryResultCnt;
    protected String RecoveryCheck;
    protected String RecoveryMemo;
	
	protected String logid;

	public int getLoginSeq() {
		return loginSeq;
	}

	public String getRecoveryMemo() {
		return RecoveryMemo;
	}

	public void setRecoveryMemo(String recoveryMemo) {
		RecoveryMemo = recoveryMemo;
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

	public String getRecoveryCode() {
		return RecoveryCode;
	}

	public void setRecoveryCode(String recoveryCode) {
		RecoveryCode = recoveryCode;
	}

	public String getCompanyCode() {
		return CompanyCode;
	}

	public void setCompanyCode(String companyCode) {
		CompanyCode = companyCode;
	}

	public String getRecoveryDateTime() {
		return RecoveryDateTime;
	}

	public void setRecoveryDateTime(String recoveryDateTime) {
		RecoveryDateTime = recoveryDateTime;
	}

	public String getRecoveryUserID() {
		return RecoveryUserID;
	}

	public void setRecoveryUserID(String recoveryUserID) {
		RecoveryUserID = recoveryUserID;
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

	public int getRecoveryCnt() {
		return RecoveryCnt;
	}

	public void setRecoveryCnt(int recoveryCnt) {
		RecoveryCnt = recoveryCnt;
	}

	public int getStockCnt() {
		return StockCnt;
	}

	public void setStockCnt(int stockCnt) {
		StockCnt = stockCnt;
	}

	public int getLossAddCnt() {
		return LossAddCnt;
	}

	public void setLossAddCnt(int lossAddCnt) {
		LossAddCnt = lossAddCnt;
	}

	public String getMemo() {
		return Memo;
	}

	public void setMemo(String memo) {
		Memo = memo;
	}

	public int getRecoveryResultCnt() {
		return RecoveryResultCnt;
	}

	public void setRecoveryResultCnt(int recoveryResultCnt) {
		RecoveryResultCnt = recoveryResultCnt;
	}

	public String getRecoveryCheck() {
		return RecoveryCheck;
	}

	public void setRecoveryCheck(String recoveryCheck) {
		RecoveryCheck = recoveryCheck;
	}

	public String getLogid() {
		return logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

}
