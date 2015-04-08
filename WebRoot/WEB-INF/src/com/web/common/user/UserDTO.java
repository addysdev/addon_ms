package com.web.common.user;

import com.web.framework.util.StringUtil;

public class UserDTO {

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
	protected String vGroupID;
	
	protected String UserID;
	protected String Ori_ID;
	protected String UserName;
	protected String GroupID;
	protected String GroupName;
	protected String AuthID;
	protected String AuthName;
	protected String ExcelAuth;
	protected String Password;
	protected String DID;
	protected String DIDFormat;
	protected String OfficePhone;
	protected String OfficePhoneFormat;
	protected String MobliePhone;
	protected String MobliePhoneFormat;
	protected String Email;
	protected String IP;
	protected String HostName;
	protected String Description;
	protected String CreateUserID;
	protected String UpdateUserID;
	protected String UseYN;
	protected String CreateDateTime;
	protected String UpdateDateTime;
	protected String DeletedYN;
	
	//넘어다니는 파라미터
    protected String curPage;
    protected String searchGb;
    protected String searchTxt;
    
    // total info
    protected String UseYN_NCount;
    protected String UseYN_YCount;
    protected String TotCount;
    
    protected String vInitYN;
    
    //log id
    protected String logid;
    
    protected String AlarmYN;
    
    protected String  Group1;
    protected String  Group2;
    protected String  Group3;
    protected String  Group4;
    protected String  Group5;
    protected int searchTab;
    protected String Ori_DID;
    protected String ViewFlag;
    

    public String getViewFlag() {
		return ViewFlag;
	}
	public void setViewFlag(String viewFlag) {
		ViewFlag = viewFlag;
	}
    public String getOri_DID() {
		return Ori_DID;
	}
	public void setOri_DID(String ori_DID) {
		Ori_DID = ori_DID;
	}
	protected String EchoYN;
    
    protected String GroupFaxView;
    
    public String getGroupFaxView() {
		return GroupFaxView;
	}
	public void setGroupFaxView(String groupFaxView) {
		GroupFaxView = groupFaxView;
	}
	public String getEchoYN() {
		return EchoYN;
	}
	public void setEchoYN(String echoYN) {
		EchoYN = echoYN;
	}
	public int getSearchTab() {
		return searchTab;
	}
	public void setSearchTab(int searchTab) {
		this.searchTab = searchTab;
	}
	public String getOri_ID() {
		return Ori_ID;
	}
	public void setOri_ID(String ori_ID) {
		Ori_ID = ori_ID;
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
	public String getvGroupID() {
		return vGroupID;
	}
	public void setvGroupID(String vGroupID) {
		this.vGroupID = vGroupID;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
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
	public String getAuthID() {
		return AuthID;
	}
	public void setAuthID(String authID) {
		AuthID = authID;
	}
	public String getAuthName() {
		return AuthName;
	}
	public void setAuthName(String authName) {
		AuthName = authName;
	}
	public String getExcelAuth() {
		return ExcelAuth;
	}
	public void setExcelAuth(String excelAuth) {
		ExcelAuth = excelAuth;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getDID() {
		return DID;
	}
	public void setDID(String dID) {
		DID = dID;
	}
	public String getDIDFormat() {
		return DIDFormat;
	}
	public void setDIDFormat(String dIDFormat) {
		DIDFormat = dIDFormat;
	}
	public String getOfficePhone() {
		return OfficePhone;
	}
	public void setOfficePhone(String officePhone) {
		OfficePhone = officePhone;
	}
	public String getOfficePhoneFormat() {
		return OfficePhoneFormat;
	}
	public void setOfficePhoneFormat(String officePhoneFormat) {
		OfficePhoneFormat = officePhoneFormat;
	}
	public String getMobliePhone() {
		return MobliePhone;
	}
	public void setMobliePhone(String mobliePhone) {
		MobliePhone = mobliePhone;
	}
	public String getMobliePhoneFormat() {
		return MobliePhoneFormat;
	}
	public void setMobliePhoneFormat(String mobliePhoneFormat) {
		MobliePhoneFormat = mobliePhoneFormat;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getIP() {
		return IP;
	}
	public void setIP(String iP) {
		IP = iP;
	}
	public String getHostName() {
		return HostName;
	}
	public void setHostName(String hostName) {
		HostName = hostName;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
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
	public String getUseYN() {
		return UseYN;
	}
	public void setUseYN(String useYN) {
		UseYN = useYN;
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
	public void setCurPage(String CurPage) {
		curPage = CurPage;
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
	public String getUseYN_NCount() {
		return UseYN_NCount;
	}
	public void setUseYN_NCount(String useYN_NCount) {
		UseYN_NCount = useYN_NCount;
	}
	public String getUseYN_YCount() {
		return UseYN_YCount;
	}
	public void setUseYN_YCount(String useYN_YCount) {
		UseYN_YCount = useYN_YCount;
	}
	public String getTotCount() {
		return TotCount;
	}
	public void setTotCount(String totCount) {
		TotCount = totCount;
	}
	public String getvInitYN() {
		return vInitYN;
	}
	public void setvInitYN(String vInitYN) {
		this.vInitYN = vInitYN;
	}
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public String getAlarmYN() {
		return AlarmYN;
	}
	public void setAlarmYN(String alarmYN) {
		AlarmYN = alarmYN;
	}
	public String getGroup1() {
		return Group1;
	}
	public void setGroup1(String group1) {
		Group1 = group1;
	}
	public String getGroup2() {
		return Group2;
	}
	public void setGroup2(String group2) {
		Group2 = group2;
	}
	public String getGroup3() {
		return Group3;
	}
	public void setGroup3(String group3) {
		Group3 = group3;
	}
	public String getGroup4() {
		return Group4;
	}
	public void setGroup4(String group4) {
		Group4 = group4;
	}
	public String getGroup5() {
		return Group5;
	}
	public void setGroup5(String group5) {
		Group5 = group5;
	}
}
