package com.web.common;

public class LogInDTO {
	
	protected String gubun;
	protected int Seq;
	protected String UserID;
	protected String LoginPathCode;
	protected String LoginType;
	protected String LoginDatetime;
	protected String LogOutDatetime;
	protected String ClientIP;
	protected String ClientOS;
	protected String ClientBrowserVersion;
	protected String Discription;
	protected int Result;
	
	protected String  macAddress;		// MAC аж╪р
	protected String  hddSerialNo;		// HDD Serial
	protected String  cpu;							// cup Serial
	protected String  ram;						// ram Serial
	protected String  hddsize;			// HDD Size
	
	protected String  logid;
	
	protected String SessionID;
	
	
	public String getSessionID() {
		return SessionID;
	}
	public void setSessionID(String sessionid) {
		this.SessionID = sessionid;
	}	
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public String getMacAddress() {
		return macAddress;
	}
	public void setMacAddress(String macAddress) {
		this.macAddress = macAddress;
	}
	public String getHddSerialNo() {
		return hddSerialNo;
	}
	public void setHddSerialNo(String hddSerialNo) {
		this.hddSerialNo = hddSerialNo;
	}
	public String getCpu() {
		return cpu;
	}
	public void setCpu(String cpu) {
		this.cpu = cpu;
	}
	public String getRam() {
		return ram;
	}
	public void setRam(String ram) {
		this.ram = ram;
	}
	public String getHddsize() {
		return hddsize;
	}
	public void setHddsize(String hddsize) {
		this.hddsize = hddsize;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
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
	public String getLoginPathCode() {
		return LoginPathCode;
	}
	public void setLoginPathCode(String loginPathCode) {
		LoginPathCode = loginPathCode;
	}
	public String getLoginType() {
		return LoginType;
	}
	public void setLoginType(String loginType) {
		LoginType = loginType;
	}
	public String getLoginDatetime() {
		return LoginDatetime;
	}
	public void setLoginDatetime(String loginDatetime) {
		LoginDatetime = loginDatetime;
	}
	public String getLogOutDatetime() {
		return LogOutDatetime;
	}
	public void setLogOutDatetime(String logOutDatetime) {
		LogOutDatetime = logOutDatetime;
	}
	public String getClientIP() {
		return ClientIP;
	}
	public void setClientIP(String clientIP) {
		ClientIP = clientIP;
	}
	public String getClientOS() {
		return ClientOS;
	}
	public void setClientOS(String clientOS) {
		ClientOS = clientOS;
	}
	public String getClientBrowserVersion() {
		return ClientBrowserVersion;
	}
	public void setClientBrowserVersion(String clientBrowserVersion) {
		ClientBrowserVersion = clientBrowserVersion;
	}
	public String getDescription() {
		return Discription;
	}
	public void setDescription(String description) {
		Discription = description;
	}
	public String getDiscription() {
		return Discription;
	}
	public void setDiscription(String discription) {
		Discription = discription;
	}
	public int getResult() {
		return Result;
	}
	public void setResult(int result) {
		Result = result;
	}
	
}
