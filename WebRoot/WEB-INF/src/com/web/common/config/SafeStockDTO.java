package com.web.common.config;

import com.web.framework.util.StringUtil;

public class SafeStockDTO {

	protected int loginSeq;

	protected String ProductCode;
	protected String GroupID;
	protected String GroupName;
	protected int safeStockCnt;
	protected String ProcYN;
    //log id
    protected String logid;
    
    protected String chUserID;
    
    
	public String getChUserID() {
		return chUserID;
	}
	public void setChUserID(String chUserID) {
		this.chUserID = chUserID;
	}
	public int getLoginSeq() {
		return loginSeq;
	}
	public void setLoginSeq(int loginSeq) {
		this.loginSeq = loginSeq;
	}
	public String getProductCode() {
		return ProductCode;
	}
	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}
	public String getGroupID() {
		return GroupID;
	}
	public void setGroupID(String groupID) {
		GroupID = groupID;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	
	public String getProcYN() {
		return ProcYN;
	}
	public void setProcYN(String procYN) {
		ProcYN = procYN;
	}
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public int getSafeStockCnt() {
		return safeStockCnt;
	}
	public void setSafeStockCnt(int safeStockCnt) {
		this.safeStockCnt = safeStockCnt;
	}

}
