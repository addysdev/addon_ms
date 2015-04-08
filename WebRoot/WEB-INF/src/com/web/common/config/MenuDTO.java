package com.web.common.config;

public class MenuDTO {

	protected String MenuID;
	protected String MenuName;
	protected String UpMenuID;
	protected int MenuStep=1;
	protected int MenuSort=1;
	protected String MenuType;
	protected String UpdateDateTime;
	protected String DeleteYN;
	
	//Screen data
	protected String ScreenID;
	protected String AuthType;
	
	//Auth set
	protected String Auth;
	
	public String getMenuID() {
		return MenuID;
	}
	public void setMenuID(String menuID) {
		MenuID = menuID;
	}
	public String getMenuName() {
		return MenuName;
	}
	public void setMenuName(String menuName) {
		MenuName = menuName;
	}
	public String getUpMenuID() {
		return UpMenuID;
	}
	public void setUpMenuID(String upMenuID) {
		UpMenuID = upMenuID;
	}
	public int getMenuStep() {
		return MenuStep;
	}
	public void setMenuStep(int menuStep) {
		MenuStep = menuStep;
	}
	public int getMenuSort() {
		return MenuSort;
	}
	public void setMenuSort(int menuSort) {
		MenuSort = menuSort;
	}
	public String getMenuType() {
		return MenuType;
	}
	public void setMenuType(String menuType) {
		MenuType = menuType;
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
	public String getAuth() {
		return Auth;
	}
	public void setAuth(String auth) {
		Auth = auth;
	}  
}
