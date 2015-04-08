package com.web.common.config;

public class GroupDTO {
	
	protected String GroupID;
	protected String IGroupID;
	protected String GroupName;
	protected String UpGroupID;
	protected int GroupStep=1;
	protected int GroupSort=1;
	protected String UpdateDateTime;
	protected String DeleteYN;

	//user data
	protected String chUserID;
	protected String UserID;
	
	protected String manageGb;
	protected String searchResult;
	
	protected String AutoSendCallbackYN;
	protected String DIDNo;
	protected String DIDNoFormat;
	
	protected String MenuAuthID;
	protected String Memo;
	protected String FaxCnt;
	
	protected String AlarmYN;
	protected String EchoYN;
	
	
	
	
	public String getIGroupID() {
		return IGroupID;
	}

	public void setIGroupID(String iGroupID) {
		IGroupID = iGroupID;
	}

	public String getEchoYN() {
		return EchoYN;
	}

	public void setEchoYN(String echoYN) {
		EchoYN = echoYN;
	}

	public String getAlarmYN() {
		return AlarmYN;
	}

	public void setAlarmYN(String alarmYN) {
		AlarmYN = alarmYN;
	}


	public String getFaxCnt() {
		return FaxCnt;
	}

	public void setFaxCnt(String faxCnt) {
		FaxCnt = faxCnt;
	}

	//처리결과
	protected int result;
	
	//log id
	protected String logid;
	
	//job gb
	protected String jobGb;
	
	
	public String getMemo() {
		return Memo;
	}

	public void setMemo(String memo) {
		Memo = memo;
	}

	public String getMenuAuthID() {
		return MenuAuthID;
	}

	public void setMenuAuthID(String menuAuthID) {
		MenuAuthID = menuAuthID;
	}

	public String getDIDNoFormat() {
		return DIDNoFormat;
	}

	public void setDIDNoFormat(String dIDNoFormat) {
		DIDNoFormat = dIDNoFormat;
	}

	public String getDIDNo() {
		return DIDNo;
	}

	public void setDIDNo(String dIDNo) {
		DIDNo = dIDNo;
	}

	public String getAutoSendCallbackYN() {
		return AutoSendCallbackYN;
	}

	public void setAutoSendCallbackYN(String autoSendCallbackYN) {
		AutoSendCallbackYN = autoSendCallbackYN;
	}

	public String getChUserID() {
		return chUserID;
	}

	public void setChUserID(String chUserID) {
		this.chUserID = chUserID;
	}

	public String getJobGb() {
		return jobGb;
	}

	public void setJobGb(String jobGb) {
		this.jobGb = jobGb;
	}

	public String getLogid() {
		return logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
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
	public String getUpGroupID() {
		return UpGroupID;
	}
	public void setUpGroupID(String upGroupID) {
		UpGroupID = upGroupID;
	}
	public int getGroupStep() {
		return GroupStep;
	}
	public void setGroupStep(int groupStep) {
		GroupStep = groupStep;
	}
	public int getGroupSort() {
		return GroupSort;
	}
	public void setGroupSort(int groupSort) {
		GroupSort = groupSort;
	}
	public String getUpdateDateTime() {
		return UpdateDateTime;
	}
	public void setUpdateDateTime(String updateDateTime) {
		UpdateDateTime = updateDateTime;
	}
	public String getDeleteYN() {
		return DeleteYN;
	}
	public void setDeleteYN(String deleteYN) {
		DeleteYN = deleteYN;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getManageGb() {
		return manageGb;
	}
	public void setManageGb(String manageGb) {
		this.manageGb = manageGb;
	}

	public String getSearchResult() {
		return searchResult;
	}

	public void setSearchResult(String searchResult) {
		this.searchResult = searchResult;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}
	
	
}
