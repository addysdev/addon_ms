package com.web.common.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

import com.web.common.CodeParam;
import com.web.common.ComCodeDTO;
import com.web.common.CommonDAO;
import com.web.common.code.CodeDAO;
import com.web.common.code.CodeDTO;

public class FormUtil {
  /**
   * Host로 부터 전달된 영문중 전각으로 표현된 문자열을 일반 문자열로 변환하여 반환한다.
   *
   * @param str  Host로 부터 전달된 전각으로 표현된 문자열
   * @return  일반적인 문자열
   */

	public static String convert4Host(String str){
		if(str == null || str.equals(" ") || str.equals("　")){
			return "";
		}
		String curStr;
		char curChar;
		String result = "";

		for( int index = 0; index < str.length(); index++)
		{
			curStr = str.substring(index,index+1);
			curChar = ( curStr.getBytes().length != 1 ) ?  (char)(curStr.charAt(0) - (65248)) : curStr.charAt(0);
			result    += curChar;
		 }		
		return result;
	}

  /**
   * null값을 갖는 String과 "null"값을 갖는 문자열을 공백으로 반환한다.
   *
   * @param str  
   * @return  공백
   */
  public static String getNotNullString(String arg) {
    if(arg == null || arg.equalsIgnoreCase("null")) {    // null값과 "null" 문자열 모두 공백으로 리턴 수정 - 2003.11.4 (이세우)
      return "";
    }
    return arg.trim();
  }
  public static String zipFormat(String zip){
	  if(zip == null || zip.length() < 6){
		  return zip;
	  }else{
		return zip.substring(0,3) + "-" + zip.substring(3,6);
	  }
  }

  /**
   * 주민등록번호를 입력으로 나이를 계산한다.
   *
   * @param socialId
   * @return
   */
  public static int getAge(String socialId)
  {
    String currentDate = FormUtil.getCurrentDate();
    if(socialId.length() != 13 || currentDate.length() != 10) return 0;

    int currentYear = Integer.parseInt(currentDate.substring(0, 4));
    int birthYear = Integer.parseInt(socialId.substring(0, 2));
    if(socialId.charAt(6) == '1' || socialId.charAt(6) == '2') {
        birthYear += 1900;
    } else {
        birthYear += 2000;
    }

    return currentYear - birthYear;
  }



	/**
	  *<p>지역번호(4자리),국번(4자리),끝번호(4자리) 총 12자리로 구성된 전화번호 및 휴대폰 번호를 
	  *<p>지역번호-국번-끝번호 형태를 갖춘 문자열로 반환한다.
	*/
	public static String telFormat(String tel){	
		return getFormedPhone(tel);
		
		/*
		
		if(tel != null && tel.length() == 12){
			try{
				String localNum = null;
				String deptNum = null;
				String endNum = null;

				localNum = tel.substring(0,4);				//지역번호
				deptNum = tel.substring(4,8);					//국번
				endNum = tel.substring(8,tel.length());			//번호

				localNum = localNum.trim();
				if(localNum.length() == 0) localNum = "02";
				else if(localNum.length() == 1) localNum = "0" + localNum;

				if(localNum.length() > 1){
					localNum = elimZero(localNum,true);
					localNum = "0" + localNum;
				}
				tel = localNum + "-" + deptNum + "-" + endNum;			
				if(tel.equals("0--")) tel = "000-0000-0000";
			}catch(Exception e){ }
		}else if(tel != null && tel.length() == 11){
                 
				String localNum = null;
				String deptNum = null;
				String endNum = null;

				localNum = tel.substring(0,2);				//지역번호
				deptNum = tel.substring(2,6);					//국번
				endNum = tel.substring(6,tel.length());			//번호

				tel = localNum + "-" + deptNum + "-" + endNum;	

			}
		return tel;	
		*/
	}	

	private static String elimZero(String str, boolean reverse){
		StringBuffer buffer = new StringBuffer(str);
		cleanZero(buffer);
		if(reverse){
			buffer.reverse();
			cleanZero(buffer);
			buffer.reverse();
		}
		return buffer.toString();
	}

	// '0'을 제거함
	private static void cleanZero(StringBuffer buffer){		
		String str = buffer.toString();
		System.out.println("\t" + str);
		char[ ] charArray = str.toCharArray();
		int k=0;
		for(int i=0; i<charArray.length; i++,k++){
			if(charArray[i] == '0') buffer.deleteCharAt(k--);
			else break;
		}
	}


/*
  //기존 메서드
  public static String telFormat(String tel){
		try{
			if(tel != null){
				tel = tel.trim();
			}
			if(tel == null || tel.equals("0") || Integer.parseInt(tel) == 0){
				return "0000-0000-0000";
			}
			if(tel.length() < 12){
				for(int i= tel.length(); i< 12; i++){
					tel ="0".concat(tel);
				}
			}
			String tel1 = tel.substring(0, 4);
			String tel2 = tel.substring(4, 8);
			String tel3 = tel.substring(8, 12);
			tel1  = ""+Integer.parseInt(tel1);
			tel1 = "0".concat(tel1);
			tel2 = ""+ Integer.parseInt(tel2);
			return tel1 + "-" + tel2 + "-" + tel3;
		}catch(NumberFormatException noEx){
			return tel;
		}
  }
//*/


  public static String cardFormat(String cardNo){
		try{
			if( cardNo == null || cardNo.equals("0") ){
				return "0000-0000-0000-0000";
			}
			if(cardNo.length() < 16){
				for(int i= cardNo.length(); i< 16; i++){
					cardNo ="0".concat(cardNo);
				}
			}
			return cardNo.substring(0, 4) + "-" + cardNo.substring(4, 8) + "-"
						+ cardNo.substring(8, 12) + "-" + cardNo.substring(12, 16);
		}catch(NumberFormatException noEx){
			return cardNo;
		}
  }

  public static String getString(short value) {
    return Short.toString(value);
  }

  public static String getString(int value) {
    return Integer.toString(value);
  }

  public static String getString(long value) {
    return Long.toString(value);
  }

  public static String getString(float value) {
    return Float.toString(value);
  }

  public static  String getNotZeroString(short value) {
    return value != 0 ? Short.toString(value) : "";
  }

  public static String getNotZeroString(int value) {
    return value != 0 ? Integer.toString(value) : "";
  }

  public static String getNotZeroString(long value) {
    return value != 0 ? Long.toString(value) : "";
  }

  public static String getNotZeroString(float value) {
    return value != 0 ? Float.toString(value) : "";
  }

  public static String getCurrentDate() {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    return format.format(new Date());
  }

  public static String getCurrentTime() {
    SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
    return format.format(new Date());
  }
  public static String getLoanPeriod(int loanPeriod) {
    String period = FormUtil.getFilledZero(loanPeriod, 9);
    int year = Integer.parseInt(period.substring(0, 3));
    int month = Integer.parseInt(period.substring(3, 6));
    int day = Integer.parseInt(period.substring(6, 9));

    StringBuffer result = new StringBuffer();
    if(year != 0) {
      result.append(year).append("년");
    }
    if(month != 0) {
      result.append(" ").append(month).append("개월");
    }
    if(day != 0) {
      result.append(" ").append(day).append("일");
    }

    return result.toString();
  }

  public static String getFilledZero(long code, int length) {
    StringBuffer buf = new StringBuffer();
    buf.append(code);

    while(buf.length() < length) {
      buf.insert(0, 0);
    }

    return buf.toString();
  }

  public static String getBankCode(int code) {
    StringBuffer buf = new StringBuffer();
    buf.append(code);

    if(buf.length() < 2) {
      buf.insert(0, 0);
    }

    return buf.toString();
  }

   public static String getJuminId(String juminId) {
     String residentNumber = FormUtil.getNotNullString(juminId);
     if(residentNumber.length() != 13) {
       return residentNumber;
     }

     return residentNumber.substring(0, 6) + "-" + residentNumber.substring(6, 13);
   }

   public static String quote(String str) {
       str = getNotNullString(str);
       return new String("'" + str + "'");
   }

   public static String quote(long str) {
     return new String("'" + str + "'");
   }

  public static String getAppendedZero(float code, int length) {
    String buf = new Float(code).toString();
	 int dotIdx = buf.indexOf(".");
    while( (buf.length() - dotIdx ) < length+1) {
      buf = buf.concat("0");
    }
    return buf;
  }

   public static String telChange(String tel ){
	  
	  String nullCheckData=FormUtil.getNotNullString(tel);
	  String result="0000-0000-0000";

	  if(!nullCheckData.equals("")){
		 result=tel.replace(' ','-');
	  }

	  return result;
  }

  public static String getDateForm(String date) {
        	
		String nullCheckData=FormUtil.getNotNullString(date);
		String yyyy="";
		String mm="";
		String dd="";
		String result="";

		if(!nullCheckData.equals("")){
			yyyy = date.substring(0,4);
			mm = date.substring(4,6);
			dd=date.substring(6,8);
			result=yyyy+"-"+mm+"-"+dd;
		}

		return  result;
   }

   public static String getTimeForm(String time) {
        
		String nullCheckData=FormUtil.getNotNullString(time);
		String hour="";
		String minute="";
		String second="";
		String result="";

		if(!nullCheckData.equals("")){
			hour = time.substring(0,2);
			minute = time.substring(2,4);
			second=time.substring(4,6);
			result=hour+":"+minute+":"+second;
		}

		return result;
   }

	public static String getOnlyNumber(String string) {
		StringBuffer result = new StringBuffer();
		
		String digits = "1234567890";
		char[] nums = string.toCharArray();
		for(int i = 0 ; i < nums.length ; i++) {
			if(digits.lastIndexOf(nums[i]) > -1) {
				result.append(nums[i]);
			}
		}
		
		return result.toString();			
	}
	
	public static String getOriginPhone(String phone) {
		String origin = getFilledZero(Long.parseLong(phone), 12);
		
		String dig1 = origin.substring(0,   4);
		String dig2 = origin.substring(4,   8);
		String dig3 = origin.substring(8, 12);
		
		String resultPhone=dig1+"-"+dig2+"-"+dig3;
		
		if("0000-0000-0000".equals(resultPhone)){
			resultPhone="";
		}
		
		return resultPhone;
	}
	
	public static String getFilledZero(String code, int length) {
		StringBuffer buf = new StringBuffer();
		buf.append(code);
		
		while(buf.length() < length) {
			buf.insert(0, 0);
		}
		
		return buf.toString();
	}		
	
	public static String getFilledPhone(String num) {
		String phone = getFormedPhone(num);
		StringTokenizer tokenizer = new StringTokenizer(phone, "-");
		StringBuffer result = new StringBuffer();
		
		while(tokenizer.hasMoreTokens()) {
			result.append(getFilledZero(tokenizer.nextToken(), 4));
		}
		
		return result.toString();
	}
	
	public static String getFormedPhone(String num) {
		String iphone = getOnlyNumber(getNotNullString(num));
		if(iphone.length() == 0) iphone = "0";
		long lPhone = Long.parseLong(iphone);
		String phone = "0"+String.valueOf(lPhone);

		int length = phone.length();
		if(length < 6) {
			return getOriginPhone(iphone);
		}

		String dig1 = "";
		String dig2 = "";
		String dig3 = phone.substring(length-4);		
		phone = phone.substring(0, length-4);
		
		Vector local = getLocalPhoneNumber();
		for(int i = 0 ; i < local.size() ; i++) {
			String temp = (String)local.elementAt(i);
			if(phone.startsWith(temp, 0)) {
				dig1 = temp;
				break;
			}
		}
		
		dig2 = phone.substring(dig1.length());
		if("".equals(dig1) || "".equals(dig2) || ("02".equals(dig1) && dig2.length() < 3) || dig2.length() > 4 || (dig1.startsWith("01", 0) && dig2.length() < 3)) 
		{ 
			return getOriginPhone(iphone); 
		}

		String resultPhone=dig1+"-"+Long.parseLong(dig2)+"-"+dig3;
		
		if("0000-0000-0000".equals(resultPhone)){
			resultPhone="";
		}
		
		return resultPhone;
	}
	
	public static Vector getLocalPhoneNumber() {
		Vector local = new Vector();
		
		CommonUtil ccm = new CommonUtil();
		ArrayList clist = ccm.getCodeList("6");
		for(int i=0 ; i < clist.size() ; i++) {
			ComCodeDTO codeDto = (ComCodeDTO)clist.get(i);
 			local.add(codeDto.getCode());
 		}
 		
 		return local;
	}
}