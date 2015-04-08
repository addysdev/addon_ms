package com.web.common.user;

import java.io.Serializable;
import java.util.ArrayList;

import com.web.framework.persist.ListDTO;

public class UserMemDTO implements Serializable{
   
	protected String userId;
    protected String passwd;
    protected String userNm;
    protected String email;
    protected String phone;
    protected String faxno;
    protected String groupid;
    protected String groupname;
    protected String authid;
    protected String  authname;
    protected String phoneFormat;
    protected String faxnoFormat;
    protected String groupfaxview;
    protected String excelauth;
    
    protected ArrayList faxlist=null;

	public ArrayList getFaxlist() {
		return faxlist;
	}

	public String getAuthname() {
		return authname;
	}

	public void setAuthname(String authname) {
		this.authname = authname;
	}

	public String getGroupfaxview() {
		return groupfaxview;
	}

	public void setGroupfaxview(String groupfaxview) {
		this.groupfaxview = groupfaxview;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFaxno() {
		return faxno;
	}

	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}

	public String getGroupid() {
		return groupid;
	}

	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public String getAuthid() {
		return authid;
	}

	public void setAuthid(String authid) {
		this.authid = authid;
	}

	public String getPhoneFormat() {
		return phoneFormat;
	}

	public void setPhoneFormat(String phoneFormat) {
		this.phoneFormat = phoneFormat;
	}

	public String getFaxnoFormat() {
		return faxnoFormat;
	}

	public void setFaxnoFormat(String faxnoFormat) {
		this.faxnoFormat = faxnoFormat;
	}

	public void setFaxlist(ArrayList faxlist) {
		this.faxlist = faxlist;
	}

	public String getExcelauth() {
		return excelauth;
	}

	public void setExcelauth(String excelauth) {
		this.excelauth = excelauth;
	}
	
}
