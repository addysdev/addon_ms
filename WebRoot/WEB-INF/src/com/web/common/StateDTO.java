package com.web.common;

public class StateDTO {
	
	protected String UserID;
	protected int InbundCnt;                //수신건수
	protected int OutboundCnt;              //발신건수
	protected int AssignmentCnt;            //수신배정건수
	protected int NonImageOpenCnt;          //수신미확인건수
	protected int NonCompleteCnt;           //수신 미처리건수
	protected String UpGroupName;           //상위그룹
	protected String GroupName;     		//소속팀
	protected String DIDNo;             	//팩스번호
	protected String OfficeTellNo; 		    //개인전화
	protected String AcceptAssignment;      //배정여부
	protected String DIDNoFromat;			//팩스번호포멧
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
