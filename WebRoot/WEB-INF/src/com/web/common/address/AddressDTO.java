package com.web.common.address;

import com.web.framework.util.StringUtil;

public class AddressDTO {

	protected int loginSeq;
	
										 //Description
	protected int Seq;					 //���� �ε���Ű
	protected String UserID; 			 //���� ID
	protected String AddressName; 		 //�ּҷ� �̸�(����,������,ȸ���)
	protected String FaxNo; 		     //�ѽ���ȣ
	protected String OfficePhone;  		 //ȸ��,�� ��ȭ��ȣ
	protected String MobilePhone; 		 //�ڵ��� ��ȣ
	protected String Email; 			 //�̸���
	protected String Memo; 				 //�޸�
	protected String CreateDateTime; 	 //��������
	protected String UpdateDateTime; 	 //��������
	protected String DeletedYN; 		 //��������
	
	//�Ѿ�ٴϴ� �Ķ����
    protected String curPage;
    protected String searchGb;
    protected String searchTxt;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;
	protected String FaxNoFormat;				 //�ѽ���ȣ ����(-)
	protected String OfficePhoneFormat;  		 //ȸ��,�� ��ȭ��ȣ ����(-)
	protected String MobilePhoneFormat; 		 //�ڵ��� ��ȣ ����(-)
	
	
	
    //log id
	protected String logid;
    
    public int getLoginSeq() {
		return loginSeq;
	}
	public void setLoginSeq(int loginSeq) {
		this.loginSeq = loginSeq;
	}
	public int getSeq() {
		return Seq;
	}
	public void setSeq(int seq) {
		Seq = seq;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getAddressName() {
		return AddressName;
	}
	public void setAddressName(String addressName) {
		AddressName = addressName;
	}

	public String getFaxNo() {
		return FaxNo;
	}
	public void setFaxNo(String faxNo) {
		FaxNo = faxNo;
	}
	public String getOfficePhone() {
		return OfficePhone;
	}
	public void setOfficePhone(String officePhone) {
		OfficePhone = officePhone;
	}
	public String getMobilePhone() {
		return MobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		MobilePhone = mobilePhone;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getMemo() {
		return Memo;
	}
	public void setMemo(String memo) {
		Memo = memo;
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
	public String getFaxNoFormat() {
		return FaxNoFormat;
	}
	public void setFaxNoFormat(String faxNoFormat) {
		FaxNoFormat = faxNoFormat;
	}
	public String getOfficePhoneFormat() {
		return OfficePhoneFormat;
	}
	public void setOfficePhoneFormat(String officePhoneFormat) {
		OfficePhoneFormat = officePhoneFormat;
	}
	public String getMobilePhoneFormat() {
		return MobilePhoneFormat;
	}
	public void setMobilePhoneFormat(String mobilePhoneFormat) {
		MobilePhoneFormat = mobilePhoneFormat;
	}
    
	
    
}
