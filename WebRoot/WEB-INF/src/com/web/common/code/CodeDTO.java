/**
 * @(#)CodeDTO
 *
 * Copyright 2004 mediopia. All Rights Reserved.
 */

package com.web.common.code;


/**
 * T_CODE 테이블 Dto 클래스.
 **/
public class CodeDTO {

	 protected String bigCd="";
	    protected String smlCd="";
	    protected String cdNm="";
	    protected String cdDesc="";
	    protected String useYn="";
	    protected String cdRef1="";
	    protected String cdRef2="";
	    protected String regId="";
	    protected String regDt="";
	    protected String modId="";
	    protected String modDt="";

	    protected String gubun;
	    protected String preBigCd;
	    
	    protected String searchGb="";
	    protected String searchtxt="";
	    
	    public String getSearchGb() {
			return searchGb;
		}

		public void setSearchGb(String searchGb) {
			this.searchGb = searchGb;
		}

		public String getSearchtxt() {
			return searchtxt;
		}

		public void setSearchtxt(String searchtxt) {
			this.searchtxt = searchtxt;
		}

		/**
	     * get bigCd.
	     *
	     * @return      bigCd
	     */
	    public String getBigCd() {
	        return  this.bigCd;
	    }

	    /**
	     * set bigCd.
	     *
	     * @param       bigCd
	     */
	    public void setBigCd(String bigCd) {
	        this.bigCd = bigCd;
	    }

	    /**
	     * get smlCd.
	     *
	     * @return      smlCd
	     */
	    public String getSmlCd() {
	        return  this.smlCd;
	    }

	    /**
	     * set smlCd.
	     *
	     * @param       smlCd
	     */
	    public void setSmlCd(String smlCd) {
	        this.smlCd = smlCd;
	    }

	    /**
	     * get cdNm.
	     *
	     * @return      cdNm
	     */
	    public String getCdNm() {
	        return  this.cdNm;
	    }

	    /**
	     * set cdNm.
	     *
	     * @param       cdNm
	     */
	    public void setCdNm(String cdNm) {
	        this.cdNm = cdNm;
	    }

	    /**
	     * get cdDesc.
	     *
	     * @return      cdDesc
	     */
	    public String getCdDesc() {
	        return  this.cdDesc;
	    }

	    /**
	     * set cdDesc.
	     *
	     * @param       cdDesc
	     */
	    public void setCdDesc(String cdDesc) {
	        this.cdDesc = cdDesc;
	    }

	    /**
	     * get useYn.
	     *
	     * @return      useYn
	     */
	    public String getUseYn() {
	        return  this.useYn;
	    }

	    /**
	     * set useYn.
	     *
	     * @param       useYn
	     */
	    public void setUseYn(String useYn) {
	        this.useYn = useYn;
	    }

	    /**
	     * get cdRef1.
	     *
	     * @return      cdRef1
	     */
	    public String getCdRef1() {
	        return  this.cdRef1;
	    }

	    /**
	     * set cdRef1.
	     *
	     * @param       cdRef1
	     */
	    public void setCdRef1(String cdRef1) {
	        this.cdRef1 = cdRef1;
	    }

	    /**
	     * get cdRef2.
	     *
	     * @return      cdRef2
	     */
	    public String getCdRef2() {
	        return  this.cdRef2;
	    }

	    /**
	     * set cdRef2.
	     *
	     * @param       cdRef2
	     */
	    public void setCdRef2(String cdRef2) {
	        this.cdRef2 = cdRef2;
	    }

	    /**
	     * get regId.
	     *
	     * @return      regId
	     */
	    public String getRegId() {
	        return  this.regId;
	    }

	    /**
	     * set regId.
	     *
	     * @param       regId
	     */
	    public void setRegId(String regId) {
	        this.regId = regId;
	    }

	    /**
	     * get regDt.
	     *
	     * @return      regDt
	     */
	    public String getRegDt() {
	        return  this.regDt;
	    }

	    /**
	     * set regDt.
	     *
	     * @param       regDt
	     */
	    public void setRegDt(String regDt) {
	        this.regDt = regDt;
	    }

	    /**
	     * get modId.
	     *
	     * @return      modId
	     */
	    public String getModId() {
	        return  this.modId;
	    }

	    /**
	     * set modId.
	     *
	     * @param       modId
	     */
	    public void setModId(String modId) {
	        this.modId = modId;
	    }

	    /**
	     * get modDt.
	     *
	     * @return      modDt
	     */
	    public String getModDt() {
	        return  this.modDt;
	    }

	    /**
	     * set modDt.
	     *
	     * @param       modDt
	     */
	    public void setModDt(String modDt) {
	        this.modDt = modDt;
	    }
	   
		/**
		 * @return Returns the gubun.
		 */
		public String getGubun() {
			return gubun;
		}
		/**
		 * @param gubun The gubun to set.
		 */
		public void setGubun(String gubun) {
			this.gubun = gubun;
		}
		
		/**
		 * @return Returns the preBigCd.
		 */
		public String getPreBigCd() {
			return preBigCd;
		}
		/**
		 * @param preBigCd The preBigCd to set.
		 */
		public void setPreBigCd(String preBigCd) {
			this.preBigCd = preBigCd;
		}
	    /**
	     * toString 
	     *
	     * @return  String 
	     */
	    public String toString() {
	        return  "bigCd="+bigCd+",smlCd="+smlCd+",cdNm="+cdNm+",cdDesc="+cdDesc+",useYn="+useYn
	               +",cdRef1="+cdRef1+",cdRef2="+cdRef2+",regId="+regId+",regDt="+regDt+",modId="+modId
	               +",modDt="+modDt;
	    }
    }
