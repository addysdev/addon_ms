package com.web.common.config;

public class AuthDTO {
	
	protected String GroupID;
	protected String UserID;
	protected String MenuID;
	protected String ScreenID;
	protected String AuthType;

	protected String authID;
	protected String authGb;
	protected String authKey;
	
	protected String logid;
	
	public String getAuthID() {
		return authID;
	}
	public void setAuthID(String authID) {
		this.authID = authID;
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
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getMenuID() {
		return MenuID;
	}
	public void setMenuID(String menuID) {
		MenuID = menuID;
	}
	public String getScreenID() {
		return ScreenID;
	}
	public void setScreenID(String screenID) {
		ScreenID = screenID;
	}
	public String getAuthType() {
		return AuthType;
	}
	public void setAuthType(String authType) {
		AuthType = authType;
	}
	public String getAuthGb() {
		return authGb;
	}
	public void setAuthGb(String authGb) {
		this.authGb = authGb;
	}
	public String getAuthKey() {
		return authKey;
	}
	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}
	
}
