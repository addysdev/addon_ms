package com.web.common;

public class StateDTO {
	
	protected String UserID;
	protected int InbundCnt;                //���ŰǼ�
	protected int OutboundCnt;              //�߽ŰǼ�
	protected int AssignmentCnt;            //���Ź����Ǽ�
	protected int NonImageOpenCnt;          //���Ź�Ȯ�ΰǼ�
	protected int NonCompleteCnt;           //���� ��ó���Ǽ�
	protected String UpGroupName;           //�����׷�
	protected String GroupName;     		//�Ҽ���
	protected String DIDNo;             	//�ѽ���ȣ
	protected String OfficeTellNo; 		    //������ȭ
	protected String AcceptAssignment;      //��������
	protected String DIDNoFromat;			//�ѽ���ȣ����
	protected String SearchDateSrc;
	protected String SearchDateDest;
	
	public void SetSearchDateDest( String DateDest ) {
		SearchDateDest = DateDest;
	}
	
	public void SetSearchDateSrc( String DateSrc ) {
		SearchDateSrc = DateSrc;
	}
	
	public String GetSearchDateSrc() {
		return SearchDateSrc;
	}

	public String GetSearchDateDest() {
		return SearchDateDest;
	}
	
	public String getDIDNoFromat() {
		return DIDNoFromat;
	}
	public void setDIDNoFromat(String dIDNoFromat) {
		DIDNoFromat = dIDNoFromat;
	}
	public String getUpGroupName() {
		return UpGroupName;
	}
	public void setUpGroupName(String upGroupName) {
		UpGroupName = upGroupName;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getDIDNo() {
		return DIDNo;
	}
	public void setDIDNo(String dIDNo) {
		DIDNo = dIDNo;
	}
	public String getOfficeTellNo() {
		return OfficeTellNo;
	}
	public void setOfficeTellNo(String officeTellNo) {
		OfficeTellNo = officeTellNo;
	}
	public String getAcceptAssignment() {
		return AcceptAssignment;
	}
	public void setAcceptAssignment(String acceptAssignment) {
		AcceptAssignment = acceptAssignment;
	}
	protected String  logid;	
	
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public int getInbundCnt() {
		return InbundCnt;
	}
	public void setInbundCnt(int inbundCnt) {
		InbundCnt = inbundCnt;
	}
	public int getOutboundCnt() {
		return OutboundCnt;
	}
	public void setOutboundCnt(int outboundCnt) {
		OutboundCnt = outboundCnt;
	}
	public int getAssignmentCnt() {
		return AssignmentCnt;
	}
	public void setAssignmentCnt(int assignmentCnt) {
		AssignmentCnt = assignmentCnt;
	}
	public int getNonImageOpenCnt() {
		return NonImageOpenCnt;
	}
	public void setNonImageOpenCnt(int nonImageOpenCnt) {
		NonImageOpenCnt = nonImageOpenCnt;
	}
	public int getNonCompleteCnt() {
		return NonCompleteCnt;
	}
	public void setNonCompleteCnt(int nonCompleteCnt) {
		NonCompleteCnt = nonCompleteCnt;
	}
	
	
}
