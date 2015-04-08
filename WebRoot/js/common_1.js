
   	function isFormat(data) {
		re = /[A-Za-z0-9]*[A-Za-z0-9]$/;
		
		if (re.test(data)) {
			return  true;
		}
		
		return  false;
	}
	function js_isFormat(obj) {
		re = /[A-Za-z0-9]*[A-Za-z0-9]$/;
		var data = obj.value;
		if (re.test(data)) {
			return;
		}
		obj.value = "";
	}       
	function setCookie( name, value ){
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + (60*60*24*365));
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	function setCookieOne( name, value ){
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + (60*60*24));
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	function getCookie(name){
		var coki;
		var idx = document.cookie.indexOf(name+'=');
		
		if (idx != -1) {
			idx += name.length + 1;
			to_idx = document.cookie.indexOf(';', idx);
			
			if (to_idx == -1) {
				to_idx = document.cookie.length;
			}		
			coki = document.cookie.substring(idx, to_idx);
		} else {
		 coki = "";
		}
		return coki;
	}
	
	function js_PopResize(width, height){
		var top, left;
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
		window.moveTo(left, top);
		window.resizeTo(width, height);
	}
	/*-------------------------------------------------------------------------
 	Spec      : Open Window의 스크린 중앙 위치 처리
 	Parameter : url    -> 해당 페이지
	Parameter : name   -> 해당 Window Name
	Parameter : width  -> Window Width Size
	Parameter : height -> Window Heigth Size
	Parameter : scroll -> Window Scroll
	Parameter : loc    -> Window Location(null이 아니면 Center)
	Example   : a href="jsOpenWindow()";
	-------------------------------------------------------------------------*/
	function jsOpenWindow(url, name, width, height, scroll, loc){
		var top, left;
		if(scroll == null || scroll == '')	scroll='0';
		if(loc != null) {
			top	 = screen.height/2 - height/2 - 50;
			left = screen.width/2 - width/2 ;
		} else {
			top  = 10;
			left = 10;
		}
		var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	   	var win = window.open(url, name, option);
	   	return win;
	}

	function dodacheck(val) {
		var mikExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		var strPass = val.value;
		var strLength = strPass.length;
		var lchar = val.value.charAt((strLength) - 1);
		    if(lchar.search(mikExp) != -1) {
		
		var tst = val.value.substring(0, (strLength) - 1);
		    val.value = tst;
		   }
	}
	function dodaNumber(val) {
        re = /[0-9]*[0-9]$/;
		var strPass = val.value;
		var strLength = strPass.length;
        if (re.test(strPass)) {
			var tst = val.value.substring(0, (strLength) - 1);
		    val.value = tst;
        }
    }	
    /**
     * 문자열의 byte length를 얻는다.
     *
     * @param   str 문자열
     * @return  byte length
     * @author  marie
     */
     
    function jsByteLength(str) {
        if (str == "") {
            return  0;
        }

        var len = 0;

        for (var i = 0; i < str.length; i++) {
            if (str.charCodeAt(i) > 128) {
                len++;
            }
            len++;
        }

        return  len;
    }

    /**
     * Object에 값을 세팅한다.
     *
     * @param   obj
     * @param   value
     */
    function jsSetValue(obj, value) {
        if (obj) {
            if (obj.type == "text") {
                obj.value = value;
            } else if (obj.tagName == "SELECT") {
                for (var i = 0; i < obj.length; i++) {
                    if (obj.options[i].value == value) {
                        obj.options[i].selected = true;
                        break;
                    }
                }
            }
        }
    }
     /**
     * 외국인 주민등록번호를 체크한다.
     *
     * @param   str 주민등록번호
     * @return  true - 올바른 번호
     *          false - 틀린 번호
     */
    function jsCheckJumin3(obj) {
        
		var str = deleteHyphen(obj.value);  // 필드에 있는 주민번호에서 '-'제거

        if( !jsCheckJumin2(str) ) {
            alert("잘못된 주민등록번호입니다.")
            obj.value="";
            //obj.focus();
            if (window.event) {
                window.event.returnValue = false;
            }
            return  false;
        }

        obj.value = str;
        return  true;
    }
   /**
     * 외국인 주민등록번호를 체크한다.
     *
     * @param   str 주민등록번호
     * @return  true - 올바른 번호
     *          false - 틀린 번호
     */
    function jsCheckJumin2(str) {
        var tmp = 0;
        var sex = str.substring(6, 7);
        var birthday;

        if (str.length != 13) {
            return  false;
        }

        if (sex == 5 || sex == 6) {
            birthday = "19" + str.substring(0, 6);
        } else if (sex == 7  || sex == 8) {
            birthday = "20" + str.substring(0, 6);
        } else {
            return  false;
        }

        if (!isDate(birthday)) {
            return  false;
        }
		var digit = 0;
		var digset = "234567892345";
	
		for(var n=0; n < 12; n++)
			digit += parseInt(str.charAt(n),10) * parseInt(digset.charAt(n), 10);
	
		digit = digit % 11;
		digit = 11 - digit;
		if (digit >= 10) digit -= 10;
	    digit += 2;
	    if (digit >= 10) digit -= 10;
	    if(digit != parseInt(str.charAt(12),10)){
			return false;
	    }
	    return  true;
    }
    function jsCheckJumin3(value) {
		var pattern = /^([0-9]{6})-?([0-9]{7})$/;
		var num = value;
	
		if (!pattern.test(num)) return false;
		num = RegExp.$1 + RegExp.$2;
		var digit = 0;
		var digset = "234567892345";
	
		for(var n=0; n < 12; n++)
			digit += parseInt(num.charAt(n),10) * parseInt(digset.charAt(n), 10);
	
	
		digit = digit % 11;
		digit = 11 - digit;
	
		if(num.charAt(6) == '5' || num.charAt(6) == '6' || num.charAt(6) == '7' || num.charAt(6) == '8'){
			if (digit >= 10) digit -= 10;
		    digit += 2;
		    if (digit >= 10) digit -= 10;
		    if(digit != parseInt(num.charAt(12),10)){
		    	return false
		    }
		} else {
			digit = digit % 10;
			if(digit != parseInt(num.charAt(12),10)){
				return false
			}	
		}
		return true;
	}
    /**
     * 주민등록번호를 체크한다.
     *
     * @param   obj 주민등록번호 필드
     * @return  true - 올바른 번호
     *          false - 틀린 번호
     */
    function jsCheckJumin1(obj) {
        var str = deleteHyphen(obj.value);  // 필드에 있는 주민번호에서 '-'제거

        if( !jsCheckJumin(str) ) {
            alert("잘못된 주민등록번호입니다.")
            obj.value="";
            //obj.focus();
            if (window.event) {
                window.event.returnValue = false;
            }
            return  false;
        }

        obj.value = str;
        return  true;
    }

    /**
     * 주민등록번호를 체크한다.
     *
     * @param   str 주민등록번호
     * @return  true - 올바른 번호
     *          false - 틀린 번호
     */
    function jsCheckJumin(str) {
        var tmp = 0;
        var sex = str.substring(6, 7);
        var birthday;

        if (str.length != 13) {
            return  false;
        }

        if (sex == 1 || sex == 2) {
            birthday = "19" + str.substring(0, 6);
        } else if (sex == 3  || sex == 4) {
            birthday = "20" + str.substring(0, 6);
        } else {
            return  false;
        }

        if (!isDate(birthday)) {
            return  false;
        }

        for (var i = 0; i < 12 ; i++) {
            tmp = tmp + ((i%8+2) * parseInt(str.substring(i,i+1)));
        }

        tmp = 11 - (tmp %11);
        tmp = tmp % 10;

        if (tmp != str.substring(12, 13)) {
            return  false;
        }

        return  true;
    }

    /**
     * 주민번호를 체크한다.
     *
     * @param       주민번호(앞자리뒷자리 합친)
     * @param       주민번호 앞자리
     * @param       주민번호 뒷자리
     * @param       다음으로 이동할 포커스
     * @author      강병곤
     * @since       2003-12-04
     */
    function checkJuminNo(juminNo, juminNo1, juminNo2, nextFocus)
    {
        var form    = document.form1;
        var flag    = true;

        var juminNoElm  = eval(form.elements[juminNo]);
        var juminNo1Elm     = eval(form.elements[juminNo1]);
        var juminNo2Elm     = eval(form.elements[juminNo2]);
        var nextFocusElm    = eval(form.elements[nextFocus]);
        //alert("juminNo ::"+ juminNoElm.value +"/ juminNo1 ::"+ juminNo1Elm.value +"/ juminNo2 ::"+ juminNo2Elm.value +"/ nextFocus ::"+ nextFocusElm.value);

        if(juminNo2Elm.value == "" || juminNo2Elm.value.length < 7)
        {
            jsRange(7, 7);
            juminNo2Elm.focus();
            return;
        }

        if(!jsCheckJumin(juminNo1Elm.value + juminNo2Elm.value)) 
        {
            alert("잘못된 주민번호입니다.");
            juminNo1Elm.value = "";
            juminNo2Elm.value = "";
            juminNo1Elm.focus();
        }
        else
        {
            juminNoElm.value    = juminNo1Elm.value + juminNo2Elm.value;
            nextFocusElm.focus();
        }
    }
    /**
     * 오직 숫자로만 이루어져 있는지 체크 한다.
     *
     * @param   num
     * @return  boolean
     */
    function isNumber(num) {
        re = /[0-9]*[0-9]$/;

        if (re.test(num)) {
            return  true;
        }

        return  false;
    }

    /**
     * 정수 체크
     *
     * 1. +, - 부호를 생략하거나 넣을 수 있다 : ^[\+-]?
     * 2. 0에서 9까지 숫자가 0번 이상 올 수 있다 : [0-9]*
     * 3. 마지막은 숫자로 끝나야 한다 : [0-9]$
     *
     * @param   num
     * @return  boolean
     */
    function isInteger(num) {
        re = /^[\+-]?[0-9]*[0-9]$/;

        if (re.test(num)) {
            return  true;
        }

        return  false;
    }

    /**
     * 유리수 체크
     *
     * 1. +, - 부호를 생략하거나 넣을 수 있다 : ^[\+-]?
     * 2. 0에서 9까지 숫자가 0번 이상 올 수 있다 : [0-9]*
     * 3. 소수점을 넣을 수 있다 : [.]?
     * 4. 소수점 이하 자리에 0에서 9까지 숫자가 올 수 있다 : [0-9]*
     * 5. 마지막은 숫자로 끝나야 한다 : [0-9]$
     *
     * @param   num
     * @return  boolean
     */
    function isFloat(num) {
        re = /^[\+-]?[0-9]*[.]?[0-9]*[0-9]$/;

        if (re.test(num)) {
            return  true;
        }

        return  false;
    }

    /**
     * 이메일 체크
     *
     * @param   email
     * @return  boolean
     */
    function isEmail(email) {
        re = /[^@]+@[A-Za-z0-9_-]+[.]+[A-Za-z]+/;

        if (re.test(email)) {
            return  true;
        }

        return  false;
    }

    /**
     * 이메일 주소 체크 - 정밀하게
     */
    function emailCheck(emailStr) {
        var checkTLD=1;
        var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
        var emailPat=/^(.+)@(.+)$/;
        var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
        var validChars="\[^\\s" + specialChars + "\]";
        var quotedUser="(\"[^\"]*\")";
        var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
        var atom=validChars + '+';
        var word="(" + atom + "|" + quotedUser + ")";
        var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
        var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
        var matchArray=emailStr.match(emailPat);

        if (matchArray==null) {
            alert("이메일 주소가 정확하지 않습니다 (체크 @ and .'s)");
            return false;
        }
        var user=matchArray[1];
        var domain=matchArray[2];
        for (i=0; i<user.length; i++) {
            if (user.charCodeAt(i)>127) {
                alert("잘못된 이메일 주소를 입력 하셨습니다.");
                return false;
            }
        }
        for (i=0; i<domain.length; i++) {
            if (domain.charCodeAt(i)>127) {
                alert("도메인 이름이 잘못 기제 되었습니다.");
                return false;
            }
        }
        if (user.match(userPat)==null) {
            alert("이메일 주소가 아닙니다.");
            return false;
        }
        var IPArray=domain.match(ipDomainPat);
        if (IPArray!=null) {
            for (var i=1;i<=4;i++) {
                if (IPArray[i]>255) {
                    alert("IP주소가 틀립니다!");
                    return false;
                }
            }
            return true;
        }
        var atomPat=new RegExp("^" + atom + "$");
        var domArr=domain.split(".");
        var len=domArr.length;
        for (i=0;i<len;i++) {
            if (domArr[i].search(atomPat)==-1) {
                alert("도메인 이 존재 하지 않습니다.");
                return false;
            }
        }
        if (checkTLD && domArr[domArr.length-1].length!=2 && 
            domArr[domArr.length-1].search(knownDomsPat)==-1) {
            alert("알려진 형식으로 끝이 나야합니다." + "country.");
            return false;
        }
        if (len<2) {
        alert("Hostname이 틀립니다. !");
        return false;
        }

        return true;
    }

    /**
     * 날짜 체크
     *
     * @param   date
     * @return  boolean
     */
    function isDate(date) {
        if (date == null || date.length != 8) {
            return  false;
        }

        if (!isNumber(date)) {
            return  false;
        }

        var year = eval(date.substring(0, 4));
        var month = eval(date.substring(4, 6));
        var day = eval(date.substring(6, 8));

		if(year == "0000") {
			return false;
		}

        if (month > 12 || month == "00") {
            return  false;
        }

        var totalDays;

        switch (eval(month)){

            case 1 :
                totalDays = 31;
                break;
            case 2 :
                if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
                    totalDays = 29;
                else
                    totalDays = 28;
                break;
            case 3 :
                totalDays = 31;
                break;
            case 4 :
                totalDays = 30;
                break;
            case 5 :
                totalDays = 31;
                break;
            case 6 :
                totalDays = 30;
                break;
            case 7 :
                totalDays = 31;
                break;
            case 8 :
                totalDays = 31;
                break;
            case 9 :
                totalDays = 30;
                break;
            case 10 :
                totalDays = 31;
                break;
            case 11 :
                totalDays = 30;
                break;
            case 12 :
                totalDays = 31;
                break;
        }

        if (day > totalDays) {
            return  false;
        }

        if (day == "00") {
            return  false;
        }

        return  true;
    }

    /**
     * 데이터 유효성을 체크한다.
     *
     * @param   form
     */
    function validate(form) {
        var obj;
        var dispName;
        var dataType;
        var minValue;
        var maxValue;
        var len;
        var lenCheck;
        var lenMCheck;
        var isValid;
        var value;
        for (i = 0; i < form.elements.length; i++) {
            obj = form.elements(i);
            
        if(obj.name != ""){ //이름이 있는 경우만 체크함.(2004.10.26 suna)
            	obj.value = trim(obj.value);
         	
            dispName 		= obj.getAttribute("dispName");
            dataType 		= obj.getAttribute("dataType");
            minValue 		= obj.getAttribute("minValue");
            maxValue 		= obj.getAttribute("maxValue");
            len      		= obj.getAttribute("len");
            lenCheck 		= obj.getAttribute("lenCheck");		//최대 자리수
            lenMCheck 		= obj.getAttribute("lenMCheck");	//최소 입력자리수

            value = obj.value;
            
            if (dispName == null) {
                dispName = obj.name;
            }

            // 필수 입력 항목 체크
            if (obj.getAttribute("notNull") != null) {
                isValid = false;

                if (obj.type == "radio" || obj.type == "checkbox") {
                    if (form.elements(obj.name).length) {
                        for (j = 0; j < form.elements(obj.name).length; j++) {
                            if (form.elements(obj.name)[j].checked) {
                                isValid = true;
                                break;
                            }
                        }
                    } else {
                        if (obj.checked) {
                            isValid = true;
                        }
                    }
                } else {
                    if (value != "") {
                        isValid = true;
                    } else {
                        if (obj.getAttribute("comma") != null) {
                            obj.value = 0;
                            isValid = true;
                        }
                    }
                }

                if (!isValid) {
                    alert(dispName + "을(를) 입력하십시오.");
                    obj.focus();
                    if (window.event) {
                        window.event.returnValue = false;
                    }
                    return  false;
                }
            }
             



            // 데이터 길이 체크
            if (len != null) {
                if (value.length != eval(len)) {
                    alert(dispName + "은(는) " + len + "자리를 입력해야 합니다.");
                    obj.focus();
                    if (window.event) {
                        window.event.returnValue = false;
                    }
                    return  false;
                }
            }
            
           if(lenCheck != null )
            {
            	
              if( jsByteLength(value) > eval(lenCheck) )
                {
                  alert(dispName + "은(는) " + lenCheck + " 자리를 넘을수 없습니다 현재 글자수("+jsByteLength(value)+")");
                  obj.value = value;
                  obj.focus();
                  if(window.event)
                    {
                       window.event.returnValue = false;
                    }
                
                    return false;
                }
               
            }            
            
            // 최소 입력자리수 체크(2004.07.21 추가     작성자 : 박광진)
            if(lenMCheck != null) {
            	if(value.length < eval(lenMCheck)) {
            		alert(dispName + "은(는) " + lenMCheck + " 자리수 이상 입력하셔야 합니다.");
            		obj.focus();
            		if(window.event)
            			window.event.returnValue = false;
            		
            		return false;
            	}
            }

            if (obj.type == "text") {
                // 데이터 타입 체크
                if (dataType == null) { // 2002.01.30 추가
                    //if (obj.readOnly == false && jsByteLength(value) > obj.maxLength) {
                    if (obj.readOnly == false && (getLength(value)/2) > obj.maxLength) {
                        alert(dispName + " 길이가 " + obj.maxLength + " 을(를) 넘습니다.");
                        obj.focus();
                        if (window.event) {
                            window.event.returnValue = false;
                        }

                        return  false;
                    }
                } else if ((value != "") && (dataType != null)) {
                    isValid = true;
                    checkValue = false;

                    if (dataType == "date") {
                        value = deleteDateFormatStr(value);
                        isValid = isDate(value);
                        checkValue = true;
                    } else if (dataType == "email") {
                        isValid = isEmail(value);
                        
                    } else if (dataType == "float") {
                        value = deleteCommaStr(value);
                        isValid = isFloat(value);
                        checkValue = true;
                    } else if (dataType == "integer") {
                        value = deleteCommaStr(value);
                        isValid = isInteger(value);
                        checkValue = true;
                    } else if (dataType == "number") {
                        value = deleteCommaStr(value);
                        isValid = isNumber(value);
                        checkValue = true;
                    } else if (dataType == "double") {
                        value = deleteCommaStr(value);
                        isValid = isNumber(value);
                        checkValue = true;
                    }

                    if (!isValid) {
                        alert(dispName + " 형식이 올바르지 않습니다.");
                        if (dataType == "float" || dataType == "integer" || dataType == "number" || dataType == "double") {
                            obj.value = "0";
                        }
                        obj.focus();
                        if (window.event) {
                            window.event.returnValue = false;
                        }
                        return  false;
                    }

                    if (checkValue) {
                        if (minValue != null) {
                            if (eval(minValue) > eval(value)) {
                                alert(dispName + " 값은 최소값(" + minValue + ") 이상입니다.");
                                obj.focus();
                                if (window.event) {
                                    window.event.returnValue = false;
                                }
                                return  false;
                            }
                        }

                        if (isValid && (maxValue != null)) {
                            if (eval(maxValue) < eval(value)) {
                                alert(dispName + " 값이 최대값(" + maxValue + ")을 초과합니다.");
                                obj.focus();
                                if (window.event) {
                                    window.event.returnValue = false;
                                }
                                return  false;
                            }
                        }
                    }
                }
            }
         }
      }
        return  true;
    }

    /**
     * 숫자에 comma를 붙인다.
     *
     * @param   obj
     */
    function addComma(obj) {
        obj.value = trim(obj.value);
        var value = obj.value;

        if (value == "") {
            return;
        }

        value = deleteCommaStr(value);

        if (!isFloat(value)) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.value = "0";
            obj.focus();
            if (window.event) {
                window.event.returnValue = false;
            }
            return;
        }

        obj.value = addCommaStr(value);
    }

    /**
     * 숫자에 comma를 붙인다.
     */
    function addComma2() {
        var obj = window.event.srcElement;
        addComma(obj);
    }

    /**
     * 숫자에 comma를 붙인다.
     *
     * @param   str
     */
    function addCommaStr(str) {
        var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
        var arrNumber = str.split('.');
        arrNumber[0] += '.';
        do {
            arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
        } while (rxSplit.test(arrNumber[0]));

        if (arrNumber.length > 1) {
            replaceStr = arrNumber.join("");
        } else {
            replaceStr = arrNumber[0].split(".")[0];
        }
        return replaceStr;
    }

    /**
     * 숫자에서 comma를 없앤다.
     *
     * @param   obj
     */
    function deleteComma(obj) {
        obj.value = deleteCommaStr(obj.value);
    }

    /**
     * 숫자에서 comma를 없앤다.
     */
    function deleteComma2() {
        var obj = window.event.srcElement;
        deleteComma(obj);
        obj.select();
    }

    /**
     * 숫자에서 comma를 없앤다.
     *
     * @param   str
     */
    function deleteCommaStr(str) {
        var temp = '';

        for (var i = 0; i < str.length; i++) {
            if (str.charAt(i) == ',') {
                continue;
            } else {
                temp += str.charAt(i);
            }
        }

        return  temp;
    }

    /**
     * 날짜에 "-"를 붙인다.
     *
     * @param   obj
     */
    function addDateFormat(obj) {
        var value = obj.value;

        if (trim(value) == "") {
            return;
        }

        value = deleteDateFormatStr(value);

        if (!isDate(value)) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.value='';
            obj.focus();

            return;
        }

        obj.value = addDateFormatStr(value);
    }

    /**
     * 날짜(년월)에 "-"를 붙인다.
     *
     * @param   obj
     */
    function addYmFormat(obj) {
        var value = obj.value;

        if (trim(value) == "") {
            return;
        }

        value = deleteDateFormatStr(value);

        if (!isDate(value + "01")) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.focus();

            return;
        }

        obj.value = addYmFormatStr(value);
    }
    
    /**
     * 날짜에 "-"를 붙인다.
     */
    function addDateFormat2() {
        var obj = window.event.srcElement;
        addDateFormat(obj);
    }

    /**
     * 날짜에 "-"를 붙인다.
     */
    function addYmFormat2() {
        var obj = window.event.srcElement;
        addYmFormat(obj);
    }

    /**
     * 날짜에 "-"를 붙인다.
     *
     * @param   str
     */
    function addDateFormatStr(str) {
        return  str.substring(0, 4) + "-" + str.substring(4, 6) + "-" + str.substring(6, 8);
    }

    /**
     * 날짜(년월)에 "-"를 붙인다.
     *
     * @param   str
     */
    function addYmFormatStr(str) {
        return  str.substring(0, 4) + "-" + str.substring(4, 6);
    }

    /**
     * 날짜에서 "-"를 없앤다.
     *
     * @param   obj
     */
    function deleteDateFormat(obj) {
        obj.value = deleteDateFormatStr(obj.value);
    }

    /**
     * 날짜에서 "-"를 없앤다.
     */
    function deleteDateFormat2() {
        var obj = window.event.srcElement;
        deleteDateFormat(obj);
        obj.select();
    }

    /**
     * 날짜에서 "-"를 없앤다.
     *
     * @param   str
     */
    function deleteDateFormatStr(str) {
        var temp = '';

        for (var i = 0; i < str.length; i++) {
            if (str.charAt(i) == '-') {
                continue;
            } else {
                temp += str.charAt(i);
            }
        }

        return  temp;
    }

    /**
     * trim
     *
     * @param   text
     * @return  string
     */
    function trim(text) {
    	if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(st) <= ' ')) {
            st++;
        }

        while ((st < len) && (text.charAt(len - 1) <= ' ')) {
            len--;
        }

        return  ((st > 0) || (len < text.length)) ? text.substring(st, len) : text;
    }

    /**
     * ltrim
     *
     * @param   text
     * @return  string
     */
    function ltrim(text) {
        if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(st) <= ' ')) {
            st++;
        }

        return  (st > 0) ? text.substring(st, len) : text;
    }

    /**
     * rtrim
     *
     * @param   text
     * @return  string
     */
    function rtrim(text) {
        if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(len - 1) <= ' ')) {
            len--;
        }

        return  (len < text.length) ? text.substring(st, len) : text;
    }

    /**
     * 이벤트 핸들러를 등록한다.
     */
    function setEventHandler() {
        for (i = 0; i < document.forms.length; i++) {

            var elements = document.forms(i).elements;

            for (j = 0; j < elements.length; j++) {
                // INPUT 객체의 onblur 이벤트에 핸들러를 등록한다.
                if (elements(j).tagName == "INPUT") {

                    dataType = elements(j).getAttribute("dataType");

                    if (dataType == "date") {
                        elements(j).onblur = addDateFormat2;
                        elements(j).onfocus = deleteDateFormat2;
                        addDateFormat(elements(j));
                    } else if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                        if (elements(j).getAttribute("comma") != null) {
                            elements(j).onblur = addComma2;
                            elements(j).onfocus = deleteComma2;
                            addComma(elements(j));
                        }
                    } else if (dataType == "yyyymm") {
                        elements(j).onblur = addYmFormat2;
                        elements(j).onfocus = deleteDateFormat2;
                        addYmFormat(elements(j));
                    }
                }
            }
        }
    }

    /**
     * 자리수의 최소값, 최대값
     *
     * 최소값만 체크 : jsRange(2, -1)
     * 최대값만 체크 : jsRange(-1, 10)
     * 최소값, 최대값 모두 체크 : jsRange(2, 10)
     * 최소값, 최대값 둘다 체크 안함 : jsRange(-1, -1)
     * 
     */
    function jsRange(minValue, maxValue)
    {
        jsMinLength(minValue);
        jsMaxLength(maxValue);
    }
	function js_Str_ChkSub(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 최대 "+ max +"자(Byte)까지 가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)는 삭제됩니다.");

			for (var inx = 0; inx < Object.value.length; inx++) {
				var oneChar1 = Object.value.charAt(inx)
				var oneChar = escape(oneChar1);
				if ( oneChar.length == 1 )
					byteLength ++;
				else if (oneChar.indexOf("%u") != -1)
					byteLength += 2;
				else if (oneChar.indexOf("%") != -1)
					byteLength += oneChar.length/3;
	
				rtnStr+=oneChar1;
	
				if(byteLength >= max) break;
				else if((byteLength+1) >= max)
					if (escape(Object.value.charAt(inx+1)).indexOf("%u") != -1) break;
			
		    }//end for
		    
			Object.value = rtnStr;
	
		}else {
		}
	
	}
	// 문구 수정.. (dispName은 한글 기준으로 30자(영문 60자)까지 입력가능합니다.)
	function js_Str_ChkSub_edit(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 한글 기준으로  "+ max/2 +"자(영문 "+max+"자)까지 입력가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)는 삭제됩니다.");

			for (var inx = 0; inx < Object.value.length; inx++) {
				var oneChar1 = Object.value.charAt(inx)
				var oneChar = escape(oneChar1);
				if ( oneChar.length == 1 )
					byteLength ++;
				else if (oneChar.indexOf("%u") != -1)
					byteLength += 2;
				else if (oneChar.indexOf("%") != -1)
					byteLength += oneChar.length/3;
	
				rtnStr+=oneChar1;
	
				if(byteLength >= max) break;
				else if((byteLength+1) >= max)
					if (escape(Object.value.charAt(inx+1)).indexOf("%u") != -1) break;
			
		    }//end for
		    
			Object.value = rtnStr;
	
		}else {
	
		}
	
	}
	
	// 다른 페이지에 iframe 형식으로 만들어 놓은 것이기 때문에. 
	function js_Str_ChkSub_edit_content(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 한글 기준으로  "+ max/2 +"자(영문 "+max+"자)까지 입력가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)를 삭제하셔야 합니다.");
			return false;
	
		}else {
			return true;
		}
	
	}
	
	
	
    /**
     * 최대값
     */
    function jsMaxLength(maxValue)
    {
        var obj         = window.event.srcElement;
        var dispName    = obj.getAttribute("dispName");
        //var maxValue    = obj.getAttribute("maxValue");
        var val         = jsByteLength(obj.value);
        if(maxValue != -1 && val > maxValue)
        {
            alert(dispName +" 값이 최대값("+ maxValue +")을 초과합니다.\n초과 길이 :"+ (val - maxValue));
        	var objValue    = obj.value;
        	obj.value = objValue.substring(0, maxValue-2);
            obj.focus();
            if(window.event)
            {
                window.event.returnValue = false;
            }
            return;
        }
    }

    /**
     * 최소값
     */
    function jsMinLength(minValue)
    {
        var obj         = window.event.srcElement;
        var dispName    = obj.getAttribute("dispName");
        //var minValue    = obj.getAttribute("minValue");
        var val         = jsByteLength(obj.value);
        if(minValue != -1 && val < minValue)
        {
            alert(dispName +" 값이 최소값(" + minValue + ") 미만입니다.\n부족 길이 :"+ (minValue - val));
            //obj.value = "0";
            obj.focus();
            if(window.event)
            {
                window.event.returnValue = false;
            }
            return;
        }
    }

    /**
     * 숫자이면 숫자, 숫자가 아니면 0
     */
    function nvlNumber(val)
    {
        if(val == "" || isNaN(val) || val == "undefined")
            return 0;

        return Number(val);
    }

    /**
     * 숫자형식에서 comma를 없애고, 날짜형식에서 "/" 를 없앤다.
     *
     * @param   form
     */
    function makeValue(form) {
        for (i = 0; i < form.elements.length; i++) {
            obj = form.elements(i);

            if (obj.tagName == "INPUT") {
                dataType = obj.getAttribute("dataType");

                if (dataType == "date") {
                    deleteDateFormat(obj);
                } else if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                    if (obj.getAttribute("comma") != null) {
                        deleteComma(obj);
                    }
                } else if (dataType == "yyyymm") {
                    deleteDateFormat(obj);
                }
                /// notHyphen 이라고 선언했다면 하이픈을 모두 제거한다.
                if(obj.getAttribute("notHyphen") != null) {
                    deleteHyphenObj(obj);
                }
            }
        }
    }

    /**
      * 문자에서 Hyphen을 없앤다.
      *
      * @param  obj
      */
    function deleteHyphenObj(obj) {
        obj.value = deleteHyphen(obj.value);
    }

    /**
     * 데이터 유효성을 체크한다.
     * 하나의 오브젝트에 대한 것임.
     *
     * @param   form
     * @param   obj
     */
    function validateObj(form, obj) {

        var dispName;
        var dataType;
        var minValue;
        var maxValue;
        var isValid;
        var value;

        obj.value = trim(obj.value);
        dispName = obj.getAttribute("dispName");
        dataType = obj.getAttribute("dataType");
        minValue = obj.getAttribute("minValue");
        maxValue = obj.getAttribute("maxValue");
        len      = obj.getAttribute("len");
        value = obj.value;

        if (dispName == null) {
            dispName = obj.name;
        }

        // 필수 입력 항목 체크
        if (obj.getAttribute("notNull") != null) {
            isValid = false;

            if (obj.type == "radio" || obj.type == "checkbox") {
                if (form.elements(obj.name).length) {
                    for (j = 0; j < form.elements(obj.name).length; j++) {
                        if (form.elements(obj.name)[j].checked) {
                            isValid = true;
                            break;
                        }
                    }
                } else {
                    if (obj.checked) {
                        isValid = true;
                    }
                }
            } else {
                if (value != "") {
                    isValid = true;
                } else {
                    if (obj.getAttribute("comma") != null) {
                        obj.value = 0;
                        isValid = true;
                    }
                }
            }

            if (!isValid) {
                alert(dispName + "을(를) 입력하십시오.");
                obj.focus();
                if (window.event) {
                    window.event.returnValue = false;
                }
                return  false;
            }
        }

        // 데이터 길이 체크
        if (len != null) {
            if (value.length != eval(len)) {
                alert(dispName + "은(는) " + len + "자리를 입력해야 합니다.");
                obj.focus();
                if (window.event) {
                    window.event.returnValue = false;
                }
                return  false;
            }
        }

        if (obj.type == "text") {
            // 데이터 타입 체크
            if ((value != "") && (dataType != null)) {
                isValid = true;
                checkValue = false;

                if (dataType == "date") {
                    value = deleteDateFormatStr(value);
                    isValid = isDate(value);
                    checkValue = true;
                } else if (dataType == "email") {
                    isValid = isEmail(value);
                } else if (dataType == "float") {
                    value = deleteCommaStr(value);
                    isValid = isFloat(value);
                    checkValue = true;
                } else if (dataType == "integer") {
                    value = deleteCommaStr(value);
                    isValid = isInteger(value);
                    checkValue = true;
                } else if (dataType == "number") {
                    value = deleteCommaStr(value);
                    isValid = isNumber(value);
                    checkValue = true;
                } else if (dataType == "double") {
                    value = deleteCommaStr(value);
                    isValid = isNumber(value);
                    checkValue = true;
                }

                if (!isValid) {
                    alert(dispName + " 형식이 올바르지 않습니다.");
                    if (dataType == "float" || dataType == "integer" || dataType == "number" || dataType == "double") {
                        obj.value = "0";
                    }
                    obj.focus();
                    if (window.event) {
                        window.event.returnValue = false;
                    }
                    return  false;
                }

                if (checkValue) {
                    if (minValue != null) {
                        if (eval(minValue) > eval(value)) {
                            alert(dispName + " 값이 최소값(" + minValue + ") 미만입니다.");
                            obj.focus();
                            if (window.event) {
                                window.event.returnValue = false;
                            }
                            return  false;
                        }
                    }

                    if (isValid && (maxValue != null)) {
                        if (eval(maxValue) < eval(value)) {
                            alert(dispName + " 값이 최대값(" + maxValue + ")을 초과합니다.");
                            obj.focus();
                            if (window.event) {
                                window.event.returnValue = false;
                            }
                            return  false;
                        }
                    }
                }
            }
        }

        return  true;
    }

    /**
     * 숫자형식에서 comma를 없애고, 날짜형식에서 "/" 를 없앤다.
     * 하나의 오브젝트에 대한 것임.
     *
     * @param   form
     * @param   obj
     */
    function makeValueObj(form, obj) {
        if (obj.tagName == "INPUT") {
            dataType = obj.getAttribute("dataType");

            if (dataType == "date") {
                deleteDateFormat(obj);
            } else if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                if (obj.getAttribute("comma") != null) {
                    deleteComma(obj);
                }
            }
        }
    }

     /**
      * 문자에서 Hyphen을 없앤다.
      *
      * @param   str
      */
    function deleteHyphen(str) {
        var temp = '';

        for (var i = 0; i < str.length; i++) {
            if (str.charAt(i) == '-') {
                continue;
            } else {
                temp += str.charAt(i);
            }
        }

        return  temp;
    }

    /**
     * 주민등록번호&사업자번호에 '-'넣기
     */
     function setJuminHyphen(obj) {
        var str = deleteHyphen(obj.value);

        if(str.length == 13) {  // 주민등록번호  6-7
            str = str.substring(0, 6) + "-" + str.substring(6);
        }else if(str.length == 10) { // 사업자번호 3-2-5
            str = str.substring(0, 3) + "-"+ str.substring(3, 5) + "-"+ str.substring(5);
        }
        obj.value = str;
     }

    /** 
     * 법인번호 에 '-'넣기
     */
    function setPupinHyphen(obj) {
        var str = deleteHyphen(obj.value);

        if(str.length == 13) {  // 주민등록번호  6-7
            str = str.substring(0, 6) + "-" + str.substring(6);
        }
        obj.value = str;
    }

    /**
     * 납입주기에 따른 이율을 계산한다.
     * (소수로 반환한다.)
     *
     * @param   currencyCd 통화
     * @param   yRate 년이율
     * @param   term 납입주기
     * @return  소수 이율
     */
    function jsRateCalc(currencyCd, yRate, term) {

        var yday = jsYdayCalc(currencyCd);
        var rate = eval((yRate / 100) * (term / 12) * (365 / yday));

        return  rate;
    }

    /**
     * 금액을 단수 처리한다.
     *
     * 원화(WON)
     *
     *  단수단위
     *      0 - 원미만
     *      1 - 십원미만
     *      2 - 백원미만
     *      3 - 천원미만
     *      4 - 만원미만
     *
     *  단수처리
     *      1 - 반올림
     *      2 - 절상
     *      3 - 절사
     *
     * 외화
     *
     *  단수단위
     *      0 - 소수점 0 미만
     *      1 - 소수점 1 미만
     *      2 - 소수점 2 미만
     *
     *  단수처리
     *      1 - 반올림
     *      2 - 절상
     *      3 - 절사
     * @param   currency 통화 (text)
     * @param   amt 금액 (text)
     * @param   unit 단수단위 (text)
     * @param   method 단수처리 (text)
     */
    function jsTruncAmt(currency, amt, unit, method) {

        var after = eval(amt);

        if (currency == "WON") {

            after /= Math.pow(10, eval(unit));

            if (method == "1") {
                after = Math.round(after);
            } else if (method == "2") {
                after = Math.ceil(after);
            } else if (method == "3") {
                after = Math.floor(after);
            }

            after *= Math.pow(10, eval(unit));
        } else {
            after *= Math.pow(10, eval(unit));

            if (method == "1") {
                after = Math.round(after);
            } else if (method == "2") {
                after = Math.ceil(after);
            } else if (method == "3") {
                after = Math.floor(after);
            }

            after /= Math.pow(10, eval(unit));
        }

        return  after;
    }

    /**
     * String이 null인 경우 '0'으로 바꾸어 준다.
     *
     * @param   string
     * @return  String
     */
    function jsNumnvl(str) {
        if(str == null || str == "") {
            return "0";
        }
        return  str;
    }

    function jsNvl(str) {
        if(str == null) {
            return "";
        }
        return  str;
    }

    /**
     * 폼 안의 숫자 오브젝트에 콤마를 붙여준다.
     */
    function setComma() {

        for (i = 0; i < document.forms.length; i++) {
            var elements = document.forms(i).elements;
            for (j = 0; j < elements.length; j++) {
                if (elements(j).tagName == "INPUT") {
                    dataType = elements(j).getAttribute("dataType");
                    if (dataType == "number" || dataType == "integer" ||
                    dataType == "float" || dataType == "double") {
                        if (elements(j).getAttribute("comma") != null) {
                            addComma(elements(j));
                        }
                    }
                }
            }
        }
    }

    /**
     * 일수를 계산한다.(초일산입 말일불산입)
     *
     * @param   from 시작일
     * @param   to 종료일
     * @return  일수
     */
    function jsGetDays(from, to) {

        var fromDt = deleteDateFormatStr(from);
        var toDt = deleteDateFormatStr(to);
        var days = 0 ;

        var fromYy = eval(fromDt.substring(0,4));
        var fromMm = eval(fromDt.substring(4,6) - 1);
        var fromDd = eval(fromDt.substring(6,8));

        var toYy = eval(toDt.substring(0,4));
        var toMm = eval(toDt.substring(4,6) - 1);
        var toDd = eval(toDt.substring(6,8));

        var fromDate = new Date(fromYy, fromMm, fromDd) ;
        var toDate = new Date(toYy, toMm, toDd) ;

        days = ((toDate - fromDate) / 60 / 60 / 24 / 1000);

        return  days;
    }

    /**
     * 비밀번호 체크
     */
    function passChk(p_id, p_pass, obj) {

        var cnt = 0;
        var cnt2 = 1;
        var cnt3 = 1;
        var temp = "";
        
        /* 비밀번호에에 숫자만 입력되는것을 체크 - 이혁*/
        regNum = /^[0-9]+$/gi;
        bNum = regNum.test(p_pass);
        if(bNum) {
            alert('비밀번호는 숫자만으로 구성하실수는 없습니다.');
               obj.focus();
            return false;
        }
        /* 비밀번호에에 문자만 입력되는것을 체크 - 이혁*/
        regNum = /^[a-zA-Z]+$/gi;
        bNum = regNum.test(p_pass);
        if(bNum) {
            alert('비밀번호는 문자만으로 구성하실수는 없습니다.');
               obj.focus();
            return false;
        }

        for(var i = 0; i < p_id.length; i++) {
            temp_id = p_id.charAt(i);

            for(var j = 0; j < p_pass.length; j++) {
                if (cnt > 0) {
                    j = tmp_pass_no + 1;
                }

                if (temp == "r") {
                    j=0;
                    temp="";
                }

                temp_pass = p_pass.charAt(j);

                if (temp_id == temp_pass){
                    cnt = cnt + 1;
                    tmp_pass_no = j;
                    break;
                } else if (cnt > 0 && j > 0){
                    temp="r";
                    cnt = 0;
                } else {
                    cnt = 0;
                }
            }

            if (cnt > 3) {
                break;
            }
        }

        if (cnt > 3){
            alert("비밀번호가 ID와 4자 이상 중복되거나, \n연속된 글자나 순차적인 숫자를 4개이상 사용해서는 안됩니다.");
            obj.focus();
            return  false;
        }

        for(var i = 0; i < p_pass.length; i++) {
            temp_pass1 = p_pass.charAt(i);
            next_pass = (parseInt(temp_pass1.charCodeAt(0)))+1;
            temp_p = p_pass.charAt(i+1);
            temp_pass2 = (parseInt(temp_p.charCodeAt(0)));

            if (temp_pass2 == next_pass) {
                cnt2 = cnt2 + 1;
            } else {
                cnt2 = 1;
            }

            if (temp_pass1 == temp_p) {
                cnt3 = cnt3 + 1;
            } else {
                cnt3 = 1;
            }

            if (cnt2 > 3) {
                break;
            }

            if (cnt3 > 3) {
                break;
            }
        }

        if (cnt2 > 3){
            alert("비밀번호에 연속된 글이나 순차적인 숫자를 4개이상 사용해서는 안됩니다.");
            obj.focus();
            return  false;
        }

        if (cnt3 > 3){
            alert("비밀번호에 반복된 문자/숫자를 4개이상 사용해서는 안됩니다.");
            obj.focus();
            return  false;
        }

        return true;
    }

    /**
     * 브라우저의 버전을 체크한다.
     *
     * @param   none
     * @return  none
     */
    function objDetectBrowser() {
        var strUA, s, i;
        this.isIE = false;  // 인터넷 익스플로러인지를 나타내는 속성
        this.isNS = false;  // 넷스케이프인지를 나타내는 속성
        this.version = null; // 브라우저 버전을 나타내는 속성

        // Agent 정보를 담고 있는 문자열.
        strUA = navigator.userAgent; 

        s = "MSIE";
        // Agent 문자열(strUA) "MSIE"란 문자열이 들어 있는지 체크

        if ((i = strUA.indexOf(s)) >= 0) {
            this.isIE = true;
            // 변수 i에는 strUA 문자열 중 MSIE가 시작된 위치 값이 들어있고,
            // s.length는 MSIE의 길이 즉, 4가 들어 있다.
            // strUA.substr(i + s.length)를 하면 strUA 문자열 중 MSIE 다음에 
            // 나오는 문자열을 잘라온다.
            // 그 문자열을 parseFloat()로 변환하면 버전을 알아낼 수 있다.
            this.version = parseFloat(strUA.substr(i + s.length));
            return;
        }

        s = "Netscape6/";
        // Agent 문자열(strUA) "Netscape6/"이란 문자열이 들어 있는지 체크

        if ((i = strUA.indexOf(s)) >= 0) {
            this.isNS = true;
            this.version = parseFloat(strUA.substr(i + s.length));
            return;
        }

        // 다른 "Gecko" 브라우저는 NS 6.1로 취급.

        s = "Gecko";
        if ((i = strUA.indexOf(s)) >= 0) {
            this.isNS = true;
            this.version = 6.1;
            return;
        }
    }

  /**
   * 화면 크기를 1024*768로 고정 시킨다.
   */
  function fixScreen(){
    if ((screen.availWidth >= 1024) & (screen.availHeight >= 768)){
      availX = 1024;
      availY = 768;
      screenX = screen.availWidth;
      screenY = screen.availHeight;
      windowX = (screenX - availX)/2;
      windowY = (screenY - availY)/2;
    }
    else {
      //availX = 1024;
      //availY = 768;
      availX = screen.availWidth;
      availY = screen.availHeight;
      windowX = 0;
      windowY = 0;
    }
    moveTo(windowX,windowY);
    resizeTo(availX, availY);
  }

    /**
     * sub 화면을 가운데에 위치 시킨다.
     * centerSubWindow(winName, wx, wy)
     * winName : 서브윈도우의 이름
     * ww : 서브윈도우로 열 창의 너비
     * wh : 서브윈도우로 열 창의 높이
     */
    function centerSubWindow(winName, ww, wh){
        if (document.layers) {
            sw = screen.availWidth;
            sh = screen.availHeight;
        }
        if (document.all) {
            sw = screen.width;
            sh = screen.height;
        }

        w = (sw - ww)/2;
        h = (sh - wh)/2;
        winName.moveTo(w,h);
    }   

    /**
     * 문자열에서 삭제를 원하는 문자를 삭제한다.
     *
     * @param   val 문자열
     * @param   str 삭제할 문자
     */
    function jsTrim(val, str) {
        var temp  = val.value;
        temp = temp.split(str);

        val.value = temp.join("");
    }

    /**
     * 폼 전체를 읽기전용으로 만든다.
     *
     * @param    form명
     */
    function setAllDisabled(tform) {
        var len = tform.elements.length;
        alert("len ::"+ len);
        for(i=0; i<len; i++) {
            if(tform.elements[i].type == "text" || tform.elements[i].type == "select-one" 
               || tform.elements[i].type == "textarea" || tform.elements[i].type == "file" 
               || tform.elements[i].type == "radio" || tform.elements[i].type == "checkbox") {
                 tform.elements[i].disabled = true;
            }
        }
    }

    /**
     * 폼 전체를 읽기전용을 정상으로 돌려 놓는다.
     *
     * @param    form명
     */
    function setAllEnabled(tform) {
        var len = tform.elements.length;
        for(i=0; i<len; i++) {
            if(tform.elements[i].type == "text" || tform.elements[i].type == "select-one" 
               || tform.elements[i].type == "textarea" || tform.elements[i].type == "file" 
               || tform.elements[i].type == "radio" || tform.elements[i].type == "checkbox") {
                 tform.elements[i].disabled = false;
            }
        }
    }

    /**
     * tokenCommaPatt
     *
     * @param    val
     * @param    patt
     * @ String val을 String patt로 구분하여배열로 리턴한다.
     * example
     *  var TestArray = tokenCommaPatt( "abcd efgh ijkl", " ")
     *  TestArray[0] = "abcd";
     *  TestArray[1] = "efgh";
     *  TestArray[2] = "ijkl";
     */
    function tokenCommaPatt(val, patt){
        var i = 0, iFst = 0; 
        var sCheckValue = val;
        var arrRst = new Array();
        while( ( iFst = sCheckValue.indexOf( patt ) ) >= 0 ) {
            arrRst[i++] = sCheckValue.substring( 0 , iFst );
            sCheckValue = sCheckValue.substring( iFst + patt.length ,  sCheckValue.length );
            }
        arrRst[i] = sCheckValue;
        return arrRst;
    }

    /**
     * 숫자로만 이루어져 있는지 체크 한다.
     *
     * @param    num
     * @return   boolean
     */
    function isNumber2(num){
        var inText = num.value;
        var ret;

        for (var i = 0; i < inText.length; i++) {
            ret = inText.charCodeAt(i);
            if (!((ret > 47) && (ret < 58)))  {
                alert("숫자만 입력 가능합니다.");
                num.value = "";
                num.focus();
                return false;
            }
        }
        return true;
    }

    /**
     * 한글로만 이루어져 있는지 체크 한다.
     *
     * @param    han
     * @return   boolean
     */
    function isHangul(han) {
        var inText = han.value;
        var ret;

        ret = inText.charCodeAt();
        if (ret > 31 && ret < 127) {
            alert("한글만 입력 가능합니다.");
            han.value = "";
            han.focus();
            return false;
        }

        return true;
    } 

   /**
    * 영문캐릭터인지 체크(대문자)
    *
    * param obj
    * return 
    */
    function checkChar(obj)
    {
        var strValue = obj.value

        var retChar = strValue.toUpperCase();

        if (retChar <  "A" || retChar  > "Z")
        {
            alert("영문자만 입력이 가능합니다.");
            obj.value = "";
            obj.focus();
            return;
        }
        obj.value = retChar;
    }
    
    /**
     * 키보드 입력시 숫자만 입력 가능
     */
    /*
    function onlyNumber(){
    	if ((event.keyCode >= 32 && event.keyCode < 48)
            || (event.keyCode > 57 && event.keyCode < 65)
            || (event.keyCode > 90 && event.keyCode < 97)
            || (event.keyCode >= 106 && event.keyCode <= 122)
            || (event.keyCode >= 65 && event.keyCode <= 90)
            || (event.keyCode == 144))
            event.returnValue = false;
        
    }
    */
    function onlyNumber(obj){
    	/*
    	if (
    	    (event.keyCode >= 48 && event.keyCode <= 57)
            || (event.keyCode > 96 && event.keyCode <= 105)
            || (event.keyCode == 8)
            || (event.keyCode == 46)
        ){
        
        }else{
            event.returnValue = false;
        }
        */
    	var num = obj.value;

    	var pattern = /\D/gi;

    	if( pattern.test(num)==true){

    	//alert("숫자만 입력 가능합니다.");

    	obj.value = num.replace(/\D/gi, "");

    	obj.focus();

    	}



        
    }    

    /**
     * 키보드 입력시 수자 및 ','가 입력 가능
     */
    function AmtNumber(){
        if ((event.keyCode >= 32 && event.keyCode < 44)
            || (event.keyCode >= 45 && event.keyCode < 48)
            || (event.keyCode > 57 && event.keyCode < 65)
            || (event.keyCode > 90 && event.keyCode < 97)
            || (event.keyCode >= 97 && event.keyCode <= 122)
            || (event.keyCode >= 65 && event.keyCode <= 90))
            event.returnValue = false;
    }

    /**
     * 키보드 입력시 수자 및 '.'가 입력 가능
     */
    function RateNumber(){
        if ((event.keyCode >= 32 && event.keyCode < 46)
            || (event.keyCode >= 47 && event.keyCode < 48)
            || (event.keyCode > 57 && event.keyCode < 65)
            || (event.keyCode > 90 && event.keyCode < 97)
            || (event.keyCode >= 97 && event.keyCode <= 122)
            || (event.keyCode >= 65 && event.keyCode <= 90))
            event.returnValue = false;
    }

    /**
     * 숫자형식에 null이 입력되면 0으로 셋팅한다.
     *
     * @param   form
     */
    function setZero(form) {
        for (i = 0; i < form.elements.length; i++) {
            obj = form.elements(i);

            if (obj.tagName == "INPUT") {
                dataType = obj.getAttribute("dataType");

                if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                    if (obj.value == null || obj.value == "") {
                        obj.value = "0";
                    }
                } 
            }
        }
    }

    /* 날짜관련 *******************************************************************************/
    var dateBase  = new Date();

    /**
     * 년
     */
    function getYear()
    {
        return dateBase.getFullYear();
    }

    /**
     * 월
     */
    function getMonth()
    {
        var month = dateBase.getMonth()+1;
        if (("" + month).length == 1)
            month = "0" + month;
        return month;
    }

    /**
     * 일
     */
    function getDay()
    {
        var day = dateBase.getDate();
        if(("" + day).length == 1)
            day   = "0" + day;
        return day;
    }

    /**
     * 현재일부터 특정일자 이전(0), 이후(1)의 날짜를 리턴한다.(YYYYMMDD)
     */
    function getIntervalDate(term, isPrevNext)
    {
        var year2, month2, day2;
        var dt = new Date(getMonth() +"-"+ getDay() +"-"+ getYear());
        var anyTime;
        var anyDate;
        if(isPrevNext == "0") /// 이전
            anyTime = dt.getTime() - (term) * 1000 * 3600 * 24;
        else /// 이후
            anyTime = dt.getTime() + (term) * 1000 * 3600 * 24;
        anyDate = new Date();
        anyDate.setTime(anyTime);
        year2 = ( (anyDate.getYear()<100) ? "19"+ anyDate.getYear() : anyDate.getYear() );
        month2 = anyDate.getMonth()+1;
        day2 = anyDate.getDate();
        if (("" + month2).length == 1)
            month2 = "0" + month2;
        if(("" + day2).length == 1)
            day2   = "0" + day2;
        //alert("["+ year2 +"/"+ month2 +"/"+ day2 +"]");

        return year2 +""+ month2 +""+ day2;
    }

    /**
     * 기준일부터 특정일자 이전(0), 이후(1)의 날짜를 리턴한다.(YYYYMMDD)
     */
    function getIntervalDate2(kijunDate, term, isPrevNext)
    {
        var year2, month2, day2;
        var dt = toTimeObject(deleteDateFormatStr(kijunDate) +"0000");
        var anyTime;
        var anyDate;
        if(isPrevNext == "0") /// 이전
            anyTime = dt.getTime() - (term) * 1000 * 3600 * 24;
        else /// 이후
            anyTime = dt.getTime() + (term) * 1000 * 3600 * 24;
        anyDate = new Date();
        anyDate.setTime(anyTime);
        year2 = ( (anyDate.getYear()<100) ? "19"+ anyDate.getYear() : anyDate.getYear() );
        month2 = anyDate.getMonth()+1;
        day2 = anyDate.getDate();
        if (("" + month2).length == 1)
            month2 = "0" + month2;
        if(("" + day2).length == 1)
            day2   = "0" + day2;
        //alert("["+ year2 +"/"+ month2 +"/"+ day2 +"]");

        return year2 +""+ month2 +""+ day2;
    }

    /**
     * 기준일부터 특정일자 이전(0), 이후(1)의 개월수 만큼 차이나는 날짜를 리턴한다.(YYYYMMDD)
     */
    function getIntervalMonth(kijunDate, term, isPrevNext)
    {
        var kijunDate   = deleteDateFormatStr(kijunDate);
        var year        = kijunDate.substring(0,4); /// 년
        var month       = kijunDate.substring(4,6); /// 월
        var date        = kijunDate.substring(6,8); /// 일
        var addMonth;
        var addYear;
        var tempYear;
        var tempMonth;
        var rtnDate;

        if(isPrevNext == "0") /// 이전
        {
            addMonth    = eval(month) - eval(term);
            addYear     = Math.floor(eval(addMonth/12)); /// 빼줄 년도 계산
            tempYear    = eval(addYear) + eval(addMonth%12);
            if(tempYear > 0)
            {
                tempMonth   = eval(tempYear%13);
            }
            else
            {
                tempMonth   = eval(12 + addMonth%12);
                if(tempYear == 0)
                    addYear     = addYear-1;
            }
        }
        else /// 이후
        {
            addMonth    = eval(month) + eval(term);
            addYear     = Math.floor(eval(addMonth/13)); /// 더해줄 년도 계산
            tempYear    = eval(addYear) + eval(addMonth%13);

            if(tempYear < 13)
            {
                tempMonth   = eval(tempYear%13);
            }
            else
            {
                tempMonth   = eval(tempYear%13 +1);
                addYear     = addYear+1;
            }
        }

        tempMonth   = tempMonth + ""; /// 길이를 알아보기위해 string으로 바꿔줌.
        if(tempMonth.length == 1)
        {
            tempMonth = "0" + tempMonth;
        }
        /// 해당월에 해당일이 존재하는지 체크하고 존재하지 않는다면 마지막 일을 가져온다.
        if( !isValidDay(eval(year) + eval(addYear), tempMonth, date))
            date = getLastDay(eval(year) + eval(addYear), tempMonth);

        rtnDate = eval(year) + eval(addYear) +""+ tempMonth +""+ date;
        //alert(">날짜 ::"+ rtnDate);

        return rtnDate;
    }

    /**
     * Time 스트링을 자바스크립트 Date 객체로 변환
     *
     * parameter time: Time 형식의 String
     */
    function toTimeObject(time)
    { //parseTime(time)
        var year  = time.substr(0,4);
        var month = time.substr(4,2) - 1; // 1월=0,12월=11
        var day   = time.substr(6,2);
        var hour  = time.substr(8,2);
        var min   = time.substr(10,2);

        return new Date(year,month,day,hour,min);
    }

    /**
     * 자바스크립트 Date 객체를 Time 스트링으로 변환
     *
     * parameter date: JavaScript Date Object
     */
    function toTimeString(date)
    { //formatTime(date)
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
        var day   = date.getDate();
        var hour  = date.getHours();
        var min   = date.getMinutes();

        if(("" + month).length == 1) { month = "0" + month; }
        if(("" + day).length   == 1) { day   = "0" + day;   }
        if(("" + hour).length  == 1) { hour  = "0" + hour;  }
        if(("" + min).length   == 1) { min   = "0" + min;   }

        return ("" + year + month + day + hour + min)
    }

    /**
     * 두 날짜간의 일자를 리턴
     *
     * parameter date: JavaScript Date Object
     */
    function daysBetween(fromDt, toDt) {
    
        var date1 = toTimeObject(fromDt);
        var date2 = toTimeObject(toDt);
        
        //alert(date1 + date2);
        
        var DSTAdjust = 0;
        // constants used for our calculations below
        oneMinute = 1000 * 60;
        var oneDay = oneMinute * 60 * 24;
        // equalize times in case date objects have them
        date1.setHours(0);
        date1.setMinutes(0);
        date1.setSeconds(0);
        date2.setHours(0);
        date2.setMinutes(0);
        date2.setSeconds(0);
        // take care of spans across Daylight Saving Time changes
        if (date2 > date1) {
            DSTAdjust = 
                (date2.getTimezoneOffset( ) - date1.getTimezoneOffset( )) * oneMinute;
        } else {
            DSTAdjust = 
                (date1.getTimezoneOffset( ) - date2.getTimezoneOffset( )) * oneMinute;    
        }
        var diff = Math.abs(date2.getTime( ) - date1.getTime( )) - DSTAdjust;
        //alert(Math.floor(diff/oneDay)+1);
        return Math.floor(diff/oneDay)+1;
    }


    /**
     * 유효한(존재하는) 월(月)인지 체크
     */
    function isValidMonth(mm)
    {
        var m = parseInt(mm,10);
        return (m >= 1 && m <= 12);
    }

    /**
     * 유효한(존재하는) 일(日)인지 체크
     */
    function isValidDay(yyyy, mm, dd)
    {
        var m = parseInt(mm,10) - 1;
        var d = parseInt(dd,10);

        var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
        if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
            end[1] = 29;
        }

        return (d >= 1 && d <= end[m]);
    }

    /**
     * 해당 월의 마지막 일을 가져온다.
     */
    function getLastDay(yyyy, mm)
    {
        var m = parseInt(mm,10) - 1;
        var d;

        var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
        if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
            end[1] = 29;
        }
        for(var i=0; i<end.length; i++)
        {
            if(m == i)
                d = end[i];
        }
        //alert("d ::"+ d);

        return d;
    }

    /**
     * 유효한(존재하는) 시(時)인지 체크
     */
    function isValidHour(hh)
    {
        var h = parseInt(hh,10);
        return (h >= 1 && h <= 24);
    }

    /**
     * 유효한(존재하는) 분(分)인지 체크
     */
    function isValidMin(mi)
    {
        var m = parseInt(mi,10);
        return (m >= 1 && m <= 60);
    }

    /**
     * 현재날짜를 리턴한다.
     *
     */
    function getCurDate()
    {
        var date  = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
        var day   = date.getDate();
        var hour  = date.getHours();
        var min   = date.getMinutes();

        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        if (("" + hour).length  == 1) { hour  = "0" + hour;  }
        if (("" + min).length   == 1) { min   = "0" + min;   }

        return ("" + year + month + day)
    }
    /* 날짜관련 *******************************************************************************/

    /**
     * 날짜를 체크하여 금월을 return
     *
     * @param       날짜
     */
    function jsThisMonth(nowDate) {
        var form = document.form1;
        
        var nowYear = nowDate.substring(0, 4);
        var nowMonth = nowDate.substring(4, 6);
        var nowDay = nowDate.substring(6, 8);
        var newDay = "";
        
        for(var i=28; i<=31; i++) {
            if (isDate(nowYear + nowMonth + i)) {
                newDay = i + "";
            }
        }

        form.fromDate.value = addDateFormatStr(nowYear + nowMonth + "01");
        form.toDate.value = addDateFormatStr(nowYear + nowMonth + newDay);
    }

    /**
     * 날짜를 체크하여 금주를 return
     *
     * @param       날짜
     */
    function jsThisWeek(nowDate) {
        var form = document.form1;

        var dateWeek = getDateWeek(nowDate);
        var monday = Number(nowDate) - dateWeek + 1;
        var sunday = monday + 6 ;

        form.fromDate.value = addDateFormatStr(monday + "");
        form.toDate.value = addDateFormatStr(sunday + "");
    }

    /**
     * 날짜를 체크하여 금일를 return
     *
     * @param       날짜
     */
    function jsThisDay(nowDate) {
        var form = document.form1;

        form.fromDate.value = addDateFormatStr(nowDate);
        form.toDate.value = addDateFormatStr(nowDate);
    }
    
    /**
     * 지정한 날짜의 요일(1 -> 월, ~ 7 -> 일)
     *
     * @param       날짜
     */
    function getDateWeek(val){
        var day;
        var d = new Date(); 

        d.setUTCFullYear(Number(val.substring(0, 4)));
        d.setUTCMonth(Number(val.substring(4, 6)) - 1);
        d.setUTCDate(Number(val.substring(6, 8)));

        day = d.getDay();

        return day;
    }

    /**
     * 엔터키 누르면 자동으로 다음 필드로 이동
     */
    function enterNextField(field, event) 
    {
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;

        if(keyCode == 13)
        {
            var i;
            for(i = 0; i<field.form.elements.length; i++)
            {
                if(field == field.form.elements[i])
                    break;
            }

            i = (i + 1) % field.form.elements.length;
            field.form.elements[i].focus();
            return false;
        } 
        else
            return true;
    }

    /**
     * 화면의 첫번째 TextField에 포커스 이동
     */
    function firstTextFocus() 
    {
        var elements;
        var obj;

        for(var j=0; j<document.forms.length; j++)
        {
            elements = document.forms(j).elements;

            for(var i=0; i<elements.length; i++)
            {
                obj = elements(i);

                if(obj.tagName == "INPUT")
                {
                    if(obj.type == "text" && obj.disabled == false)
                    {
                        obj.focus();
                        return;
                    }
                }
            }
        }
    }

    /**
     * FM## - getFM(12, 4) -> 0012로 변경한다.
     * @param       val 원본 값
     * @param       len 사이즈 (0을 채울 갯수)
     */
    function getFM(val, len)
    {
        if(val == "")
            return val;
        var str     = "";
        var zero    = "";
        var valLen  = new String(val).length;
        var forLen  = len-valLen;
        if(len <= valLen)
            return val;
        for(var i=0; i<(forLen); i++)
        {
            zero    += "0";
        }
        str = zero+val;

        return str;
    }
    
    
    //--	값을 입력여부 확인
function isEmpty(data) {
	for (var i = 0; i < data.length; i++) {
		if (data.substring(i, i+1) != " ") {
			return false;
		}
	}
	return true;
}

//--	번호를 제대로 입력하였는지 확인
function Check_Num1(num) {
	for (var i = 0 ; i < num.length ; i++) {
		if ((num.charAt(i) < '0') || (num.charAt(i) > '9')) {
			return false;
		}
	}
	return true;
}
//--	번호를 제대로 입력하였는지 확인(몇개 특수문자포함)
function Check_Num2(num) {
	for (var i = 0 ; i < num.length ; i++) {
		if ((num.charAt(i) >= '0') && (num.charAt(i) <= '9')
			|| (num.charAt(i) == '-') || (num.charAt(i) == '(')
			|| (num.charAt(i) == ')'))
			continue;
		else
			return false;
	}
	return true;
}
//--	번호를 제대로 입력하였는지 확인(소수점포함)
function Check_Num3(num) {
	if (num == '') {
		num		=	'0';
	}
	var var_1	=	0;
	

	for (var i = 0 ; i < num.length ; i++) {
		if ((num.charAt(i) >= '0' && num.charAt(i) <= '9') || (num.charAt(i) == '.')) {
			if (num.charAt(i) == '.') {
				var_1	=	var_1 + 1;
			}
		//	continue;
		}
		else {
			return false;
		}
	}
	//--	소숫점갯수, 소숫점이하 자리수, 
	if (var_1 > 1) {
		return false;
	}

	return true;
}

//--	숫자를 제대로 입력하였는지 확인
function num_check(num) {
	for (var i = 0 ; i < num.length ; i++) {
		if ((num.charAt(i) < '0') || (num.charAt(i) > '9')) {
			return false;
		}
	}
	return true;
}

//--	소숫점 이하자릿수(1자리) 체크
function Check_Decimal(num) {

	if (num == '') {
		num		=	'0';
	}

	var var_1	=	0;
	var var_p	=	9;
	for (var i = 0 ; i < num.length ; i++) {

		if (num.charAt(i) == '.') {
			var_p		=	i;
		}
		//--	소숫점이하 자리수 계산
		if (i > var_p && (num.charAt(i) >= '0' && num.charAt(i) <= '9')) {
			var_1		=	var_1 + 1;
		}
	}

	//--	소숫점이하 자리수, 
	if (var_1 > 1 || var_p == 0) {
		return false;
	}

	return true
}

//--	입력항목이 공백인지 확인
function empty_check(data) {
	if (data.length == 0) {
		return false;
	}
	else {
		for (var i=0; i<data.length; i++) {
			if (data.substring(i,i+1) != " ") {
				return true;
			}
		}
		return false;
	}
	return true;
}

//--	공백이 있는지 확인
function Space_Check(data) {
	for (var i=0; i<data.length; i++) {
		if (data.substring(i,i+1) == " ") {
			return false;
		}
	}
	return true;
}

//--	입력값 검사
function char_Check(data) {
	var num_cnt		=	0;
	var chk_str		=	'-./[]_{|}~';
//	var chk_str		=	'!#$%()*,-./:;<=>@[\]^_{|}~';
	for (var i = 0; i < data.length; i++) {
		if ((((data.charAt(i) >= '0') && (data.charAt(i) <= '9'))) || (((data.charAt(i) >= 'a') && (data.charAt(i) <= 'z'))) || (((data.charAt(i) >= 'A') && (data.charAt(i) <= 'Z'))))
			num_cnt +=	1;
	}
	if (num_cnt == data.length) {
		return true;
	}
	return false;
}

//--	필드길이 검사(영문, 숫자 1Byte, 한글 2Byte로 계산)
function getLength(str) {
	return (str.length + (escape(str) + "/%u").match(/%u/g).length-1);
}

//--	특수문자 검사(전체)
function Special_Check1(data) {
	var num_cnt		=	0;
	var chk_str		=	'!#$%()*,-./:;<=>@[\]^_`{|}~&+?"';

	for (var i = 0; i < data.length; i++) {
		for (var j = 0; j < chk_str.length; j++)
			if (chk_str.charAt(j) == data.charAt(i) || data.charAt(i) == '"' || data.charAt(i) == "'" || data.charAt(i) == '\\')
				num_cnt += 1;
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}

//--	특수문자 검사(-_제외)
function Special_Check2(data) {
	var num_cnt		=	0;
	var chk_str		=	'!#$%()*,./:;<=>@[\]^`{|}~&+?"';

	for (var i = 0; i < data.length; i++) {
		for (var j = 0; j < chk_str.length; j++)
			if (chk_str.charAt(j) == data.charAt(i) || data.charAt(i) == '"' || data.charAt(i) == "'")
				num_cnt += 1;
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}

//--	특수문자 검사(/제외)
function Special_Check3(data) {
	var num_cnt		=	0;
	var chk_str		=	'!#$%()*,-.:;<=>@[\]^_`{|}~&+?"';

	for (var i = 0; i < data.length; i++) {
		for (var j = 0; j < chk_str.length; j++)
			if (chk_str.charAt(j) == data.charAt(i) || data.charAt(i) == '"' || data.charAt(i) == "'" || data.charAt(i) == '\\')
				num_cnt += 1;
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}

//--	특수문자 검사(복수)
function Double_Check(data) {
	var num_cnt		=	0;
	var chk_str		=	'--__@@(())[[]]{{}}//\\||##$$%%**,,..::;;<<>>&&++??';
	var var_str1	=	'';
	var var_str2	=	'';
	for (var i = 0; i < data.length; i++) {
		if (i < data.length)
			var_str1	=	data.substring(i,i+2);

		for (var j = 0; j < chk_str.length; j++)
			if (j < chk_str.length)
				var_str2	=	chk_str.substring(j,j+1);

			if (var_str1 == var_str2 || var_str1 == '""' || var_str1 == "''")
				num_cnt += 1;
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}

//--	OR 문자 검사
function Or_Check(data) {
	var num_cnt		=	0;
	var var_str1	=	'';
	var var_no		=	data.length;

	for (var i = 0; i < data.length; i++) {
		for (var j = i; j < data.length; j++) {
			if (j < data.length)
				var_str1	=	data.substring(i,j+1).toLowerCase();

				if (var_str1 == 'oror' || var_str1 == 'oror ' || var_str1 == ' oror' || var_str1 == ' oror ' 
					|| var_str1 == 'or' || var_str1 == 'or ' || var_str1 == ' or' || var_str1 == ' or ')
					num_cnt += 1;
				
		}
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}

//--	Union 문자 검사
function Union_Check(data) {
	var num_cnt		=	0;
	var var_str1	=	'';
	var var_no		=	data.length;

	for (var i = 0; i < data.length; i++) {
		for (var j = i; j < data.length; j++) {
			if (j < data.length)
				var_str1	=	data.substring(i,j+4).toLowerCase();

				if (var_str1 == 'union' || var_str1 == 'union ' || var_str1 == ' union' || var_str1 == ' union ')
					num_cnt += 1;
				
		}
	}

	if (num_cnt > 0) {
		return false;
	}
	return true;
}


//-- 특정 form의 특정name에 대한 chkbox를 모두 value로 setting
function setChkboxAll(formname, name, value) {
    for (var i = 0; i < formname.length ; i++) {
        if (name == formname.elements[i].name)
             formname.elements[i].checked = value;
    }
}

// 처리내용 : 특정값(char)를 append한 결과를 return(체크안되었으면 default값을 append)
//  check된 checkbox의 value를 attach한다 (check안되면 value값을)
// 주로 멀티 선택시 사용 
function getChkBoxByValue(formname, name, defvalue) 
{
    var Buf = "";
    var chkCnt = 0;
    for (var i = 0; i < formname.length ; i++) {
        if (name == formname.elements[i].name) {
            if (formname.elements[i].checked) {
                chkCnt ++;
                Buf = Buf + formname.elements[i].value + defvalue;
            }
        }
    }
    return Buf;
}

// 특수문자등을 사용했는지를 체크한다.
function dataCheck(data) {
	var num_cnt		=	0;
	var chk_str		=	'!#$%()*,-./:;<=>@[\]^_`{|}~';
	for (var i = 0; i < data.length; i++) {
		if ((((data.charAt(i) >= '0') && (data.charAt(i) <= '9'))) || (((data.charAt(i) >= 'a') && (data.charAt(i) <= 'z'))) || (((data.charAt(i) >= 'A') && (data.charAt(i) <= 'Z'))))
			num_cnt += 1;
		for (var j = 0; j < chk_str.length; j++)
			if (chk_str.charAt(j) == data.charAt(i))
				num_cnt += 1;
	}
	if (num_cnt == data.length) {
		return true;
	}
	return false;
}

	function isEmpty(data)
	{
		for ( var i = 0 ; i < data.length ; i++ ) {
			if ( data.substring( i, i+1 ) != ' ' )
				return false;
		}
		return true;
	}

   function windowLeftPosition(pos){
      var leftPosition = screen.width - pos;
	   
	  leftPosition = (leftPosition < 0) ? 0 : leftPosition/2;
	  
	  return leftPosition;
   }

   function windowTopPosition(pos){
	  var topPosition = screen.height - pos;
	   
	  topPosition  = (topPosition < 0)  ? 0 : topPosition /2;
	  
	  return topPosition;
   }

   
   function center_popup(s_url, s_name, s_width, s_height) { 
	ls_pri = "toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no, width="+s_width+" height="+s_height;
	wd_pop = window.open(s_url, s_name,ls_pri);
	wd_pop.blur();
	wd_pop.moveTo(((screen.availwidth - eval(s_width))/2),((screen.availheight - eval(s_height))/2));
	wd_pop.focus();
	return wd_pop;
   }

   function center_popup_scroll(s_url, s_name, s_width, s_height) { 
	ls_pri = "toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no, width="+s_width+" height="+s_height;
	wd_pop = window.open(s_url, s_name,ls_pri);
	wd_pop.blur();
	wd_pop.moveTo(((screen.availwidth - eval(s_width))/2),((screen.availheight - eval(s_height))/2));
	wd_pop.focus();
	return wd_pop;
   }
      
   function sel_box_insert(obj, s_text, s_val) {
	obj.options[obj.length] = new Option(s_text,s_val,false,false);
   }
   
   function sel_box_removeall(obj) {
        var len = obj.length;
        for (var i = len; i > 0; i--) { 
    		obj.options[i] = null;
    	}
    }

   function sel_box_remove(obj) {
        var len = obj.length;
        for (var i = len-1; i >= 0; i--) { 
    		obj.options[i] = null;
    	}
    }
    
    function sel_box_value(obj) {
	  return obj.options[obj.options.selectedIndex].value;
    }

    function sel_box_text(obj) {
	  return obj.options[obj.options.selectedIndex].text;
    }
    
    function sel_box_select(obj, s_val) {
		for(i=0; i< obj.length; i++) {
			if(obj.options[i].value==s_val) {
				obj.options[i].selected = true;
			}
		}
    }
    
	function com_checkbox_check(obj) { 
	    isChk=false;
	    if(obj.length == undefined) { 
	        isChk=false;
	    } else { 
	        isChk=true;
	    } 
	    return isChk;
	} 
	
	var checkbox_flag = true;
	function checkBoxSelectAll(obj) { 
	    try
	    {    
	        if(com_checkbox_check(obj)) { 
	            for(i=0; i< obj.length; i++) { 
	                obj[i].checked=checkbox_flag;
	            } 
	        } else { 
	            obj.checked=checkbox_flag;
	        } 
	        if(checkbox_flag==true) {  
	            checkbox_flag=false;
	        } else  {
	            checkbox_flag=true;
	        }
	    }catch (e) {
	        window.status = "error";
	    }
	}
	
	function getFileExtension(str){
       if(str == "") return "";
       
       var index = str.lastIndexOf(".");
       var extension = str.substring(index+1,str.length);
	   
	   return extension;
	}
	
	
	
	function getDateDropDownList( frmObj , endDate , selectedDate ){
		var date = new Date();
		var year = date.getYear();
		var month = date.getMonth() + 1;
		
		var endYear = endDate.substring(0 , 4 );
		var endMonth = endDate.substring( 4 , 6 );
		var monthDiff;

		if ( year > parseInt( endYear ) ){			
			monthDiff = month + ( ( year - parseInt( endYear ) - 1 ) * 12 + ( 12 - parseInt( endMonth ) ) );
		}else{
			monthDiff = month - parseInt( endMonth );
		}

		frmObj.length = monthDiff + 1;

		var cnt = 1;
		var cnt1 = 12;
		var selectedCnt = 0;

		if ( monthDiff <= month ){
			for ( var i = 0 ; i < ( month - parseInt( endMonth ) )  ; i++ ){

				if ( ( month - i ) < 10  ){
					if ( (year + "0" + ( month - i ) ) ==  selectedDate ){
						selectedCnt = cnt;
					}

					frmObj.options[cnt].value = year + "0" + ( month - i );
					frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
				}else{
					if ( (year + "" + ( month - i ) ) ==  selectedDate ){
						selectedCnt = cnt;
					}

					frmObj.options[cnt].value = year + "" + ( month - i ) ;
					frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
				}
			}
		}else{
			for( var i = 0 ; i < monthDiff ; i++ ){
				if ( i < month ){

					if ( ( month - i ) < 10  ){
						if ( (year + "0" + ( month - i ) ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						frmObj.options[cnt].value = year + "0" + ( month - i );
						frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
					}else{
						if ( (year + "" + ( month - i ) ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						frmObj.options[cnt].value = year + "" + ( month - i );
						frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
					}
				}else{
					if ( cnt1 == 12 ){
						year--;
					}

					if ( cnt1 < 10 ){
						if ( ( year + "0" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}

						frmObj.options[cnt].value = year + "0" + cnt1;
						frmObj.options[cnt++].text = year + "년 0" + cnt1 + "월";
					}else{
						if ( ( year + "" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						frmObj.options[cnt].value = year + "" + cnt1;
						frmObj.options[cnt++].text = year + "년 " + cnt1 + "월";
					}

					if ( cnt1 == 1 ){
						cnt1 = 12;
					}else{
						cnt1--;
					}
				}
			}
		}

		frmObj.selectedIndex = selectedCnt;
	}	
	
	function getDateDropDownListWithExpdate( frmObj , endDate , selectedDate , expCnt)
	{
		var date = new Date();
		var year = date.getYear();
		var month = date.getMonth() + 1;
		
		var endYear = endDate.substring(0 , 4 );
		var endMonth = endDate.substring( 4 , 6 );
		var monthDiff;
				
		if ( year > parseInt( endYear ) ){			
			monthDiff = month + ( ( year - parseInt( endYear ) - 1 ) * 12 + ( 12 - parseInt( endMonth ) ) );
		}else{
			monthDiff = month - parseInt( endMonth );
		}

		frmObj.length = monthDiff + 1 - expCnt ;

		var cnt = 1;
		var cnt1 = 12;
		var selectedCnt = 0;

		if ( monthDiff <= month )
		{
			for ( var i = 0 ; i < ( month - parseInt( endMonth ) )  ; i++ ){

				if ( ( month - i ) < 10  )
				{
					if ( (year + "0" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}
					
					
					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "0" + ( month - i );
						frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
					}
				}
				else
				{
					if ( (year + "" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}

					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "" + ( month - i ) ;
						frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
					}
				}
			}
		}
		else
		{
			for( var i = 0 ; i < monthDiff ; i++ )
			{
				if ( i < month )
				{
					if ( ( month - i ) < 10  )
					{
						if ( (year + "0" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}

						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + ( month - i );
							frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
						}
					}
					else
					{
						if ( (year + "" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "" + ( month - i );
							frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
						}
					}
				}
				else
				{
					if ( cnt1 == 12 )
					{
						year--;
					}

					if ( cnt1 < 10 )
					{
						if ( ( year + "0" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + cnt1;
							frmObj.options[cnt++].text = year + "년 0" + cnt1 + "월";
						}
					}
					else
					{
						if ( ( year + "" + cnt1 ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						

							frmObj.options[cnt].value = year + "" + cnt1;
							frmObj.options[cnt++].text = year + "년 " + cnt1 + "월";
						}
					}

					if ( cnt1 == 1 )
					{
						cnt1 = 12;
					}
					else
					{
						cnt1--;
					}
				}
			}
		}

		frmObj.selectedIndex = selectedCnt;
	}		
	


	function getDateDropDownListWithExpdate2( frmObj , endDate , selectedDate , expCnt)
	{
		var date = new Date();
		var year = date.getYear();
		var month = date.getMonth() + 1;
		
		var endYear = endDate.substring(0 , 4 );
		var endMonth = endDate.substring( 4 , 6 );
		var monthDiff;
				
		if ( year > parseInt( endYear ) ){			
			monthDiff = month + ( ( year - parseInt( endYear ) - 1 ) * 12 + ( 12 - parseInt( endMonth ) ) );
		}else{
			monthDiff = month - parseInt( endMonth );
		}

		frmObj.length = monthDiff + 1 - expCnt ;

		var cnt = 1;
		var cnt1 = 12;
		var selectedCnt = 0;

		if ( monthDiff <= month )
		{
			for ( var i = 0 ; i < ( month - parseInt( endMonth ) )  ; i++ ){

				if ( ( month - i ) < 10  )
				{
					if ( (year + "0" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}
					
					
					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3"&& (month-i)!="4")
					{						
						frmObj.options[cnt].value = year + "0" + ( month - i );
						frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
					}
				}
				else
				{
					if ( (year + "" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}

					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3"&& (month-i)!="4")
					{						
						frmObj.options[cnt].value = year + "" + ( month - i ) ;
						frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
					}
				}
			}
		}
		else
		{
			for( var i = 0 ; i < monthDiff ; i++ )
			{
				if ( i < month )
				{
					if ( ( month - i ) < 10  )
					{
						if ( (year + "0" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}

						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3"&& (month-i)!="4")
						{						
							frmObj.options[cnt].value = year + "0" + ( month - i );
							frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
						}
					}
					else
					{
						if ( (year + "" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3"&& (month-i)!="4")
						{						
							frmObj.options[cnt].value = year + "" + ( month - i );
							frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
						}
					}
				}
				else
				{
					if ( cnt1 == 12 )
					{
						year--;
					}

					if ( cnt1 < 10 )
					{
						if ( ( year + "0" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3"&& (month-i)!="4")
						{						
							frmObj.options[cnt].value = year + "0" + cnt1;
							frmObj.options[cnt++].text = year + "년 0" + cnt1 + "월";
						}
					}
					else
					{
						if ( ( year + "" + cnt1 ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						
						if ((month-i) != "1" && (month-i)!="2" && (month-i)!="3"&& (month-i)!="4")
						{						

							frmObj.options[cnt].value = year + "" + cnt1;
							frmObj.options[cnt++].text = year + "년 " + cnt1 + "월";
						}
					}

					if ( cnt1 == 1 )
					{
						cnt1 = 12;
					}
					else
					{
						cnt1--;
					}
				}
			}
		}

		frmObj.selectedIndex = selectedCnt;
	}		

	function submitEnters(field, event) {
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13)
		{
			return false;
		}else
			return true;
	}

	function addCondition(obj,startdate,enddate){

		var s_yy=startdate.substring(0,4);
		var s_mm=startdate.substring(4,6);
		var s_dd=startdate.substring(6,startdate.length);
		var sindex=0;

		var e_yy=enddate.substring(0,4);
		var e_mm=enddate.substring(4,6);
		var e_dd=enddate.substring(6,enddate.length);
		var eindex=0;

		for(var a=2006; a<(parseInt(s_yy)+10); a++){

			sindex++;

			addSelectOption(obj.startyear, a, a);

			if(s_yy==a)
			{
				obj.startyear[sindex-1].selected=true;
			}

		}

		for(var b=2006; b<(parseInt(e_yy)+10); b++){

			eindex++;
			
			addSelectOption(obj.endyear, b, b);
			
			if(e_yy==b)
			{
				obj.endyear[eindex-1].selected=true;
			}
		}

		for(var j=1; j< 13; j++){

			var m=j

			if(m<10){
				m='0'+j;
			}

			addSelectOption(obj.startmonth, m,m);
			addSelectOption(obj.endmonth, m,m);

			if(s_mm==m)
			{
				obj.startmonth[j-1].selected=true;
			}

			if(e_mm==m)
			{
				obj.endmonth[j-1].selected=true;
			}

		}

	}

function addCondition2(obj,date){

		var s_yy=date.substring(0,4);
		var s_mm=date.substring(4,6);
		var s_dd=date.substring(6,date.length);
		var sindex=0;

		for(var a=2006; a<(parseInt(s_yy)+10); a++){

			sindex++;

			addSelectOption(obj.year, a, a);

			if(s_yy==a)
			{
				obj.year[sindex-1].selected=true;
			}

		}

		for(var j=1; j< 13; j++){

			var m=j

			if(m<10){
				m='0'+j;
			}

			addSelectOption(obj.month, m,m);

			if(s_mm==m)
			{
				obj.month[j-1].selected=true;
			}

		}

	}

function addCondition_onlyYear(obj,date){

		var s_yy=date.substring(0,4);
		var sindex=0;

		for(var a=2006; a<(parseInt(s_yy)+10); a++){

			sindex++;

			addSelectOption(obj.year, a, a);

			if(s_yy==a)
			{
				obj.year[sindex-1].selected=true;
			}

		}
	}

function addCondition3(obj_yyyy,obj_mm,date){

		var s_yy=date.substring(0,4);
		var s_mm=date.substring(4,6);
		var s_dd=date.substring(6,date.length);
		var sindex=0;

		for(var a=2006; a<(parseInt(s_yy)+10); a++){

			sindex++;

			addSelectOption(obj_yyyy, a, a);

			if(s_yy==a)
			{
				obj_yyyy[sindex-1].selected=true;
			}

		}

		for(var j=1; j< 13; j++){

			var m=j

			if(m<10){
				m='0'+j;
			}

			addSelectOption(obj_mm, m,m);

			if(s_mm==m)
			{
				obj_mm[j-1].selected=true;
			}

		}

	}
	
	function dateSet(obj_year,obj_month,obj_day,date){
    
		var yyyy=date.substring(0,4);
		var mm=date.substring(4,6);
		var dd=date.substring(6,date.length);
		var index=0;

		for(var a=2006; a<(parseInt(yyyy)+10); a++){

			index++;

			addSelectOption(obj_year, a, a);

			if(yyyy==a)
			{
				obj_year[index-1].selected=true;
			}

		}

		for(var j=1; j< 13; j++){

			var m=j

			if(m<10){
				m='0'+j;
			}

			addSelectOption(obj_month, m,m);

			if(mm==m)
			{
				obj_month[j-1].selected=true;
			}

		}

		for(var x=1; x< 32; x++){

			var d=x

			if(d<10){
				d='0'+x;
			}

			addSelectOption(obj_day, d,d);

			if(dd==d)
			{
				obj_day[x-1].selected=true;
			}
			
		}

	}

function addCondition4(obj_yyyy,obj_mm,date){

		if(date==""){
				vDate = new Date();
				addSelectOption(obj_yyyy, "", "선택없음");
				addSelectOption(obj_mm, "","선택없음");

			for(var a=2006; a<Number(vDate.getFullYear()+10); a++){

				sindex++;				
			
				addSelectOption(obj_yyyy, a, a);

				if(s_yy==a)
				{
					obj_yyyy[sindex-1].selected=true;
				}

			}
			
			

			for(var j=1; j< 13; j++){

				var m=j

				if(m<10){
					m='0'+j;
				}

				addSelectOption(obj_mm, m,m);

				if(s_mm==m)
				{
					obj_mm[j-1].selected=true;
				}

			}

		} else{ // date가 있다면 

			var s_yy=date.substring(0,4);
			var s_mm=date.substring(4,6);
			var s_dd=date.substring(6,date.length);
			var sindex=0;

			

			for(var a=2006; a<(parseInt(s_yy)+10); a++){

				sindex++;

				addSelectOption(obj_yyyy, a, a);

				if(s_yy==a)
				{
					obj_yyyy[sindex-1].selected=true;
				}

			}

			for(var j=1; j< 13; j++){

				var m=j

				if(m<10){
					m='0'+j;
				}

				addSelectOption(obj_mm, m,m);

				if(s_mm==m)
				{
					obj_mm[j-1].selected=true;
				}

			}
			addSelectOption(obj_yyyy, "", "선택없음");
			addSelectOption(obj_mm, "","선택없음");
			
		}
		

	}


	function addCondition5(obj_yyyy,obj_mm,obj_dd){

	
		vDate = new Date();
		var sindex=0;
		for(var a=vDate.getFullYear(); a<Number(vDate.getFullYear()+10); a++){	
			addSelectOption(obj_yyyy, a, a);
		}

		for(var j=1; j< 13; j++){

			var m=j

			if(m<10){
				m='0'+j;
			}
			addSelectOption(obj_mm, m,m);

		}

		for(var k=1; k< 32; k++){
			var d=k

			if(d<10){
				d='0'+k;
			}
			addSelectOption(obj_dd, d,d);			

		}

	}


	function addSelectOption(object, value, text)
	{
		option = document.createElement("OPTION");
		option.text = text;
		option.value = value;
		object.options.add(option);
	}
	
	function addSelectOption2(object, value, text,title)
	{

		option = document.createElement("OPTION");
		option.text = text;
		option.value = value;
		option.title = title;
		
		object.options.add(option);
	}

	function clearSelectOptions(object)
	{
		if(object.tagName != "SELECT") return;
		
		for(var i = object.options.length - 1 ; i >= 0 ; i--) 
		{
			object.options.remove(i);
		}
	}
	var observer;//처리중
	var observerkey=false;//처리중여부

	// 여기서 부터는 처리중 표현하는 function

	function closeWaiting() {
		observerkey=false;
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}
	function closeWaiting2() {
		observerkey=false;
		$('#waitwindow2').dialog('close'); 
	}
	//처리중 팝업
	function openWaiting2() {

		$('#waitwindow2').dialog({
			modal : true,
			resizable : false, //사이즈 변경 불가능
			draggable : true, //드래그 불가능
			closeOnEscape : true, //ESC 버튼 눌렀을때 종료
			
			height : 120,
			width : 220,
			modal : true,
			
			open:function(){
				
				//팝업 가져올 url

				$(this).load('test',{
					'test' : 'test'
				});
				
			},
			close: function(){

			}
		
		});
	}
	//보이기
	function openWaiting( ) {
		observerkey=true;
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}
	function dateMove(g,CalDate,sObj,eObj)
	{
	    sObj.value = getIntervalDates(sObj.value, CalDate ,g);
	    eObj.value = getIntervalDates(eObj.value, CalDate ,g);
	}
	function dateMove2(CalDate,sObj,eObj)
	{
		if(CalDate=='1'){
			sObj.value=getToDates();
			eObj.value=getToDates();
		}else{
			sObj.value = getIntervalDates(eObj.value, CalDate ,'back');
		}
	}
	/**
     * 기준일부터 특정일자 이전(0), 이후(1)의 날짜를 리턴한다.(YYYYMMDD)
     */
    function getIntervalDates(kijunDate, term, isPrevNext)
    {
        var year2, month2, day2;
        var dt = toTimeObject(deleteDateFormatStr(kijunDate) +"0000");
        var anyTime;
        var anyDate;
        if(isPrevNext == "back") /// 이전
            anyTime = dt.getTime() - (term) * 1000 * 3600 * 24;
        else /// 이후
            anyTime = dt.getTime() + (term) * 1000 * 3600 * 24;
        anyDate = new Date();
        anyDate.setTime(anyTime);
        
        year2 = ( (anyDate.getYear()<100) ? "19"+ anyDate.getYear() : ""+anyDate.getYear());
        if(year2.length==3){
        	year2="20"+year2.substring(1);
        }
        month2 = anyDate.getMonth()+1;
        day2 = anyDate.getDate();
        if (("" + month2).length == 1)
            month2 = "0" + month2;
        if(("" + day2).length == 1)
            day2   = "0" + day2;

        return year2 +"-"+ month2 +"-"+ day2;
    }
    /**
     * 오늘 날짜를 리턴한다.(YYYYMMDD)
     */
    function getToDates()
    {
        var year2, month2, day2;
        var anyDate;
       
        anyDate = new Date();
        
        year2 = ( (anyDate.getYear()<100) ? "19"+ anyDate.getYear() : ""+anyDate.getYear());
        if(year2.length==3){
        	year2="20"+year2.substring(1);
        }
        month2 = anyDate.getMonth()+1;
        day2 = anyDate.getDate();
        if (("" + month2).length == 1)
            month2 = "0" + month2;
        if(("" + day2).length == 1)
            day2   = "0" + day2;

        return year2 +"-"+ month2 +"-"+ day2;
    }
///////////////////////////////////////////////////////////////////////////////
// 함수명 : makeExcel() 
// 내  용 : 엑셀 파일로 저장하기 
//////////////////////////////////////////////////////////////////////////////
function makeExcel(obj) {

	if (document.all._ExcelFrame==null) {
		document.body.insertAdjacentHTML("beforeEnd", "<iframe name='_ExcelFrame' style='width:0;height=0';></iframe>");
	}

	document.all.objExcel.value = obj;
	
    document.forms[0].action = "/jsp/makeExcel.jsp";
	document.forms[0].method="POST";

	document.forms[0].target = "new";
	document.forms[0].submit();

}

function limitText(str, maxChars, maxLines, maxPerLine)
{

		var count = 0;
        var strLineCounter = 0;
        var strCharCounter = 0;

		var msg = "";
		var tmpMsg1 = "";
		var tmpMsg2 = "";
        for (var i = 0; i < str.length; i++)
        {
                var strChar = str.substring(i, i + 1);
                if (strChar == '\n')
                {
                        strLineCounter++;
                }
        }

		tmpMsg1 = "줄 수 : "+ strLineCounter;

		var overLine = false;
		var overChar = false
        if (maxLines < strLineCounter){
			overLine = true;
		}else{
			if(str.length > 0){
				strLineCounter = Math.ceil(str.length/maxPerLine);
				tmpMsg1 = "줄 수 : "+ strLineCounter +"줄";
				if (strLineCounter > maxLines){
					overLine = true;
				}
			}		
		}

		tmpMsg2 = "글자 수 : "+ str.length +"자";
        if (overLine || overLine){
			msg = tmpMsg1+" / "+tmpMsg2 
		}
		return msg;
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :dateCheck()
//내  용 : 날짜체크함수
///////////////////////////////////////////////////////////////////////////////
function dateCheck(sObj,eObj,due){
	
	var sdate=deleteDateFormatStr(sObj.value);
	var edate=deleteDateFormatStr(eObj.value);
	
	if(!isDate(sdate)){
		alert('검색 시작일자의 날짜형식이 올바르지 않습니다.');
		return false;
	}
	if(!isDate(edate)){
		alert('검색 종료일자의 날짜형식이 올바르지 않습니다.');
		return false;
	}
	
	if(sdate>edate){
		alert('시작일이 종료일보다 큽니다.');
		return false;
	}
	var rdue=daysBetween(sdate,edate);
	
//	if(due!= '' && 365<rdue){
//		alert('검색일수는 12개월로 제한합니다.');
//		return false;
//	} else if(due!='' && rdue>due){
	if(due!='' && rdue>due){
		if( due == '1' )
			alert( '검색일수는 당일로 제한됩니다.' );
		else
			alert('검색일수는 '+(due-1)+'일로 제한합니다.');
    	return false;
	}	
	return true;
}
var openWin=0;//팝업객체
///////////////////////////////////////////////////////////////////////////////
//함수명 :imageView()
//내  용 : 이미지 뷰어 호출(발신용)
///////////////////////////////////////////////////////////////////////////////
function imageView(pre_url,UFID,FtpUrl,FtpID,FtpPW,ServerID,imageFolderName,imageFileName,imageTotalPagecount,Auth,FaxNo,ScreenID,veiwFlag){

	var url=pre_url+'&UFID='+UFID+'&ServerID='+ServerID+'&imageFolderName='+imageFolderName+'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+ScreenID+'&veiwFlag='+veiwFlag;
	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    if(true){

     width='942';
     height='700';
     top	 = screen.height/2 - height/2 - 50;
	 left = screen.width/2 - width/2 ;
    }

    if(scroll == null || scroll == '')	scroll='0';
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	
	if(undefined==parent.viewWin){
		
		openWin= window.open(url, 'imageView', option);
	}else{
	
		if(parent.viewWin != 0) {
			parent.viewWin.close();
		}
		parent.viewWin = window.open(url, 'imageView', option);
	}

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :imageView()
//내  용 : 이미지 뷰어 호출(발신용-팝업)
///////////////////////////////////////////////////////////////////////////////
function openImageView(pre_url,UFID,FtpUrl,FtpID,FtpPW,ServerID,imageFolderName,imageFileName,imageTotalPagecount,Auth,FaxNo,ScreenID,veiwFlag){

	var url=pre_url+'&UFID='+UFID+'&ServerID='+ServerID+'&imageFolderName='+imageFolderName+'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+ScreenID+'&veiwFlag='+veiwFlag;
	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    if(true){

     width='942';
     height='700';
     top=0;
     left = screen.width - width ;
    }

    if(scroll == null || scroll == '')	scroll='0';
    
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	if(openWin != 0) {
		openWin.close();
	}
	openWin = window.open(url, 'imageView', option);

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :imageView()
//내  용 : 이미지 뷰어 호출(발신용)
///////////////////////////////////////////////////////////////////////////////
function callImageView(pre_url,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,Auth,FaxNo,ScreenID){
		
	var url=pre_url+'&UFID='+UFID+'&imageFolderName='+imageFolderName+'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+ScreenID;
	
	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    var name = navigator.appName, BrowserInfo = navigator.appVersion;
	if(name == "Microsoft Internet Explorer")
	{
	    if(BrowserInfo.indexOf("MSIE 3.0") != -1) BrowserInfo = "Internet Explorer 3.0x";
		else if(BrowserInfo.indexOf("MSIE 4.0") != -1) BrowserInfo = "Internet Explorer 4.0x";
		else if(BrowserInfo.indexOf("MSIE 5.0") != -1) BrowserInfo = "Internet Explorer 5.0x";
		else if(BrowserInfo.indexOf("MSIE 6.0") != -1) BrowserInfo = "Internet Explorer 6.0x";
		else if(BrowserInfo.indexOf("MSIE 7.0") != -1) BrowserInfo = "Internet Explorer 7.0x";
		else if(BrowserInfo.indexOf("MSIE 8.0") != -1) BrowserInfo = "Internet Explorer 8.0x";
		else if(BrowserInfo.indexOf("MSIE 9.0") != -1) BrowserInfo = "Internet Explorer 9.0x";
	}
    
    if(top == null || top == '' || top == undefined || left == null || left == '' || left == undefined || BrowserInfo=='Internet Explorer 4.0x' || BrowserInfo=='Internet Explorer 5.0x' || BrowserInfo=='Internet Explorer 6.0x'){

     width='942';
     height='700';
     top=0;
     left = screen.width - width ;
    }

    if(scroll == null || scroll == '')	scroll='0';
    
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
 
	window.open(url, 'imageView', option);

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :inboundImageView()수신용
//내  용 : 이미지 뷰어 호출
///////////////////////////////////////////////////////////////////////////////
function inboundImageView(viewUrl,returnURL,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,
		Auth,FaxNo,ScreenID,ServerID,PortNo,ExtentionNo,ANI,CSID,Speed,SuccessYN,DisconnectResultCode,
		DisconnectResultDescription,ISDNResultCode,ImageFileSize,NetworkInboundYN,fullImageFolderName,OwnerDateTime,viewFlag){

	var exeindex = imageFileName.indexOf(".");
	var exetension=imageFileName.substring(exeindex);

	if(exetension!='.tif'){//발신 실패의 경우 문서파일 변환이 안되는 상황이 있을수 있음
		alert('미리보기 가능한 파일이 아닙니다.');
		return;
	}

	var url=viewUrl+'&returnURL='+returnURL+'&UFID='+UFID+'&ServerID='+ServerID+'&imageFolderName='+imageFolderName+
	'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+
	ScreenID+'&ServerID='+ServerID+'&PortNo='+PortNo+'&ExtentionNo='+ExtentionNo+'&ANI='+ANI+'&CSID='+
	CSID+'&Speed='+Speed+'&SuccessYN='+SuccessYN+'&DisconnectResultCode='+DisconnectResultCode+
	'&DisconnectResultDescription='+DisconnectResultDescription+'&ISDNResultCode='+ISDNResultCode+'&ImageFileSize='+ImageFileSize+'&NetworkInboundYN='+NetworkInboundYN+'&fullImageFolderName='+fullImageFolderName+'&OwnerDateTime='+OwnerDateTime+'&viewFlag='+viewFlag;

	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    if(true){

     width='942';
     height='700';
     top	 = screen.height/2 - height/2 - 50;
	 left = screen.width/2 - width/2 ;
    }

    if(scroll == null || scroll == '')	scroll='0';
	
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	
	//alert('수신'+parent.viewWin);
	
	if(undefined==parent.viewWin){
	
		openWin= window.open(url, 'imageView', option);
	}else{
	
		if(parent.viewWin != 0) {
			parent.viewWin.close();
		}
		parent.viewWin = window.open(url, 'imageView', option);
	}
 	
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :inboundImageView()수신용
//내  용 : 이미지 뷰어 호출
///////////////////////////////////////////////////////////////////////////////
function LongInboundImageView(returnURL,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,
		Auth,FaxNo,ScreenID,ServerID,PortNo,ExtentionNo,ANI,CSID,Speed,SuccessYN,DisconnectResultCode,
		DisconnectResultDescription,ISDNResultCode,ImageFileSize,NetworkInboundYN,fullImageFolderName){

	var exeindex = imageFileName.indexOf(".");
	var exetension=imageFileName.substring(exeindex);

	if(exetension!='.tif'){//발신 실패의 경우 문서파일 변환이 안되는 상황이 있을수 있음
		alert('미리보기 가능한 파일이 아닙니다.');
		return;
	}

	var url='/H_Common.do?cmd=InboundImageView&returnURL='+returnURL+'&UFID='+UFID+'&imageFolderName='+imageFolderName+
	'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+
	ScreenID+'&ServerID='+ServerID+'&PortNo='+PortNo+'&ExtentionNo='+ExtentionNo+'&ANI='+ANI+'&CSID='+
	CSID+'&Speed='+Speed+'&SuccessYN='+SuccessYN+'&DisconnectResultCode='+DisconnectResultCode+
	'&DisconnectResultDescription='+DisconnectResultDescription+'&ISDNResultCode='+ISDNResultCode+'&ImageFileSize='+ImageFileSize+'&NetworkInboundYN='+NetworkInboundYN+'&fullImageFolderName='+fullImageFolderName;

	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    if(true){
    	
     width=screen.width;
     height=screen.height;
     top=0;
     left = 0;
     
    }

    if(scroll == null || scroll == '')	scroll='0';

	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	//alert('수신'+parent.viewWin);
	if(parent.viewWin != 0) {
		parent.viewWin.close();
	}
	parent.viewWin = window.open(url, 'imageView', option);
	
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :inboundImageView()수신용
//내  용 : 이미지 뷰어 호출
///////////////////////////////////////////////////////////////////////////////
function acceptInboundImageView(index,returnURL,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,
		Auth,FaxNo,ScreenID,ServerID,PortNo,ExtentionNo,ANI,CSID,Speed,SuccessYN,DisconnectResultCode,
		DisconnectResultDescription,ISDNResultCode,ImageFileSize,NetworkInboundYN,fullImageFolderName){

	var exeindex = imageFileName.indexOf(".");
	var exetension=imageFileName.substring(exeindex);

	if(exetension!='.tif'){//발신 실패의 경우 문서파일 변환이 안되는 상황이 있을수 있음
		alert('미리보기 가능한 파일이 아닙니다.');
		return;
	}

	var url='/H_Common.do?cmd=InboundImageView&returnURL='+returnURL+'&UFID='+UFID+'&imageFolderName='+imageFolderName+
	'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+
	ScreenID+'&ServerID='+ServerID+'&PortNo='+PortNo+'&ExtentionNo='+ExtentionNo+'&ANI='+ANI+'&CSID='+
	CSID+'&Speed='+Speed+'&SuccessYN='+SuccessYN+'&DisconnectResultCode='+DisconnectResultCode+
	'&DisconnectResultDescription='+DisconnectResultDescription+'&ISDNResultCode='+ISDNResultCode+'&ImageFileSize='+ImageFileSize+'&NetworkInboundYN='+NetworkInboundYN+'&fullImageFolderName='+fullImageFolderName+'&acceptIndex='+index;

	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
  left = getCookie("HYUNDAI_viewwinLeft");
  height = getCookie("HYUNDAI_clientheight");
  width = getCookie("HYUNDAI_clientwidth");

  if(true){
  	
   width=screen.width;
   height=screen.height;
   top=0;
   left = 0;
   
  }

  if(scroll == null || scroll == '')	scroll='0';

	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	//alert('수신'+parent.viewWin);
	if(parent.viewWin != 0) {
		parent.viewWin.close();
	}
	parent.viewWin = window.open(url, 'imageView', option);
	
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :imageView()
//내  용 : 이미지 뷰어 호출(발신용)
///////////////////////////////////////////////////////////////////////////////
function LongImageView(pre_url,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,Auth,FaxNo,ScreenID){
		
	var url=pre_url+'&UFID='+UFID+'&imageFolderName='+imageFolderName+'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+ScreenID;

	var top, left,width,height,scroll;
	
	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    if(true){

     width=screen.width;
     height=screen.height;
     top=0;
     left = 0;
     
    }

    if(scroll == null || scroll == '')	scroll='0';
    
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;
	
	if(parent.viewWin != 0) {
		parent.viewWin.close();
	}
	parent.viewWin = window.open(url, 'imageView', option);

}
function tmt_winLaunch(theURL,winName,targetName,features) {
	eval(winName+"=window.open('"+theURL+"','"+targetName+"','"+features+"')");
}
function init(){

var h=screen.height-(screen.height*(8.5/100));
var s=screen.width-10;

//alert('귀하의 모니터 해상도는 ' + s + ' x ' + h + '입니다.');
tmt_winLaunch('<%= request.getContextPath()%>/H_Login.do?cmd=main', 'qaz', 'qaz', 'status=yes,width='+s+',height ='+h+',left=0,top=0');

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :inboundImageView()수신용
//내  용 : 이미지 뷰어 호출
///////////////////////////////////////////////////////////////////////////////
function callInboundImageView(returnURL,UFID,FtpUrl,FtpID,FtpPW,imageFolderName,imageFileName,imageTotalPagecount,
		Auth,FaxNo,ScreenID,ServerID,PortNo,ExtentionNo,ANI,CSID,Speed,SuccessYN,DisconnectResultCode,
		DisconnectResultDescription,ISDNResultCode,ImageFileSize,NetworkInboundYN,fullImageFolderName){

	var exeindex = imageFileName.indexOf(".");
	var exetension=imageFileName.substring(exeindex);

	if(exetension!='.tif'){//발신 실패의 경우 문서파일 변환이 안되는 상황이 있을수 있음
		alert('미리보기 가능한 파일이 아닙니다.');
		return;
	}

	var url='/H_Common.do?cmd=InboundImageView&returnURL='+returnURL+'&UFID='+UFID+'&imageFolderName='+imageFolderName+
	'&imageFileName='+imageFileName+'&imageTotalPagecount='+imageTotalPagecount+'&Auth='+Auth+'&FaxNo='+FaxNo+'&ScreenID='+
	ScreenID+'&ServerID='+ServerID+'&PortNo='+PortNo+'&ExtentionNo='+ExtentionNo+'&ANI='+ANI+'&CSID='+
	CSID+'&Speed='+Speed+'&SuccessYN='+SuccessYN+'&DisconnectResultCode='+DisconnectResultCode+
	'&DisconnectResultDescription='+DisconnectResultDescription+'&ISDNResultCode='+ISDNResultCode+'&ImageFileSize='+ImageFileSize+'&NetworkInboundYN='+NetworkInboundYN+'&fullImageFolderName='+fullImageFolderName;

	var top, left,width,height,scroll;

	top = getCookie("HYUNDAI_viewwinTop");
    left = getCookie("HYUNDAI_viewwinLeft");
    height = getCookie("HYUNDAI_clientheight");
    width = getCookie("HYUNDAI_clientwidth");

    var name = navigator.appName, BrowserInfo = navigator.appVersion;
	if(name == "Microsoft Internet Explorer")
	{
	    if(BrowserInfo.indexOf("MSIE 3.0") != -1) BrowserInfo = "Internet Explorer 3.0x";
		else if(BrowserInfo.indexOf("MSIE 4.0") != -1) BrowserInfo = "Internet Explorer 4.0x";
		else if(BrowserInfo.indexOf("MSIE 5.0") != -1) BrowserInfo = "Internet Explorer 5.0x";
		else if(BrowserInfo.indexOf("MSIE 6.0") != -1) BrowserInfo = "Internet Explorer 6.0x";
		else if(BrowserInfo.indexOf("MSIE 7.0") != -1) BrowserInfo = "Internet Explorer 7.0x";
		else if(BrowserInfo.indexOf("MSIE 8.0") != -1) BrowserInfo = "Internet Explorer 8.0x";
		else if(BrowserInfo.indexOf("MSIE 9.0") != -1) BrowserInfo = "Internet Explorer 9.0x";
	}
    
    if(top == null || top == '' || top == undefined || left == null || left == '' || left == undefined || BrowserInfo=='Internet Explorer 4.0x' || BrowserInfo=='Internet Explorer 5.0x' || BrowserInfo=='Internet Explorer 6.0x'){

     width='942';
     height='700';
     top=0;
     left = screen.width - width ;
    }

    if(scroll == null || scroll == '')	scroll='0';
    
	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;


	var objnm=UFID;

	objnm = window.open(url, UFID, option);
/*
	if(parent.viewWin != 0) {
		parent.viewWin.close();
	}
	parent.viewWin = window.open(url, 'imageView', option);
*/

}
function setWindowSize(){

	var viewwinTop=opener.parent.viewWin.screenTop;
	var viewwinLeft=opener.parent.viewWin.screenLeft;
	var clientheight=document.body.clientHeight;
	var clientwidth=document.body.clientWidth;

	setCookie("HYUNDAI_viewwinTop", viewwinTop);
	setCookie("HYUNDAI_viewwinLeft",viewwinLeft);
	setCookie("HYUNDAI_clientheight",clientheight);
	setCookie("HYUNDAI_clientwidth",clientwidth);

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :format_phone()
//내  용 : 전화번호 포멧을 자동변경한다.
///////////////////////////////////////////////////////////////////////////////
function format_phone(obj) {
	
	var str=onlyNum(obj.value);
	
	if(str.length<5){
		return;
	}

	rgnNo = new Array;
	rgnNo[0] = "02";
	rgnNo[1] = "031";
	rgnNo[2] = "032";
	rgnNo[3] = "033";
	rgnNo[4] = "041";
	rgnNo[5] = "042";
	rgnNo[6] = "043";
	rgnNo[7] = "0502";
	rgnNo[8] = "0504";
	rgnNo[9] = "0505";
	rgnNo[10] = "0506";
	rgnNo[11] = "0507";
	rgnNo[12] = "051";
	rgnNo[13] = "052";
	rgnNo[14] = "053";
	rgnNo[15] = "054";
	rgnNo[16] = "055";
	rgnNo[17] = "061";
	rgnNo[18] = "062";
	rgnNo[19] = "063";
	rgnNo[20] = "064";
	rgnNo[21] = "070";
	rgnNo[22] = "010";
	rgnNo[23] = "011";
	rgnNo[24] = "016";
	rgnNo[25] = "017";
	rgnNo[26] = "018";
	rgnNo[27] = "019";
	
	var temp = str;

	for (var i = 0; i < rgnNo.length; i++) {
		if (str.indexOf(rgnNo[i]) == 0) {
			len_rgn = rgnNo[i].length;
			formattedNo = getFormattedPhone(str.substring(len_rgn));
			temp=rgnNo[i] + "-" + formattedNo;
			
			break;
		}
	}
	
	obj.value=temp;

}
//스페이스처리
function fillSpace(val){

	if(typeof val =="undefined" || val == null){
		return ' ';
	}
	if(val.length==0){
		return ' ';
	}

    return val;
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :getFormattedPhone()
//내  용 : 전화번호 포멧을 자동변경한다.
//Event : 
//Object : Input
///////////////////////////////////////////////////////////////////////////////
function getFormattedPhone(str) {
	if (str.length<=4) {
		return str;
	}
	else {
		len_no1 = str.length - 4;
		no1 = str.substring(0, len_no1);
		no2 = str.substring(len_no1);
		return no1 + "-" + no2;
	}
}
function onlyNum(val)
{
 var num = val;
 var tmp = "";

 for (var i = 0; i < num.length; i ++)
 {
  if (num.charAt(i) >= 0 && num.charAt(i) <= 9)
   tmp = tmp + num.charAt(i);
  else
   continue;
 }
 return tmp;
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :MM_swapImgRestore(),MM_preloadImages,MM_findObj,MM_swapImage
//내  용 : 이미지 효과함수.
///////////////////////////////////////////////////////////////////////////////
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_nbGroup(event, grpName) { //v6.0
	  var i,img,nbArr,args=MM_nbGroup.arguments;
	  if (event == "init" && args.length > 2) {
	    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
	      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
	      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
	      nbArr[nbArr.length] = img;
	      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
	        if (!img.MM_up) img.MM_up = img.src;
	        img.src = img.MM_dn = args[i+1];
	        nbArr[nbArr.length] = img;
	    } }
	  } else if (event == "over") {
	    document.MM_nbOver = nbArr = new Array();
	    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
	      if (!img.MM_up) img.MM_up = img.src;
	      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
	      nbArr[nbArr.length] = img;
	    }
	  } else if (event == "out" ) {
	    for (i=0; i < document.MM_nbOver.length; i++) {
	      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
	  } else if (event == "down") {
	    nbArr = document[grpName];
	    if (nbArr)
	      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
	    document[grpName] = nbArr = new Array();
	    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
	      if (!img.MM_up) img.MM_up = img.src;
	      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
	      nbArr[nbArr.length] = img;
	  } }
	}
function MM_showHideLayers() { //v9.0
	  var i,p,v,obj,args=MM_showHideLayers.arguments;
	  for (i=0; i<(args.length-2); i+=3) 
	  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
	    if (obj.style) { obj=obj.style; v=(v=='show')?'block':(v=='hide')?'none':v; }
	    obj.display=v; }
	}


var contextroot='';
///////////////////////////////////////////////////////////////////////////////
//함수명 : groupAuth
//내  용 : 권한(그룹)선택옵션 추가
///////////////////////////////////////////////////////////////////////////////
function groupAuth(frm){

	var gobj=document.all.group_select;
	var sobj=document.all.seach_box;
	var uobj=document.all.user_select;

	if(frm.AuthOption.value=="Group"){//권한이 조직인경우 처리

		frm.AuthID.value=frm.cmAuthID.value;//사용자 설정 권한 아이디를 세팅한다.
		
		if(gobj!= undefined){
			gobj.style.display='block';
			sobj.style.height='50px';
		}
		
		if(uobj!= undefined){
			uobj.style.display='none';
			if(frm.searchArea!= undefined){
			 frm.searchArea.value='';
			 frm.vSearchTeamDIDNo.value='';
			}

		}
		
		var step=frm.cmAuthStep.value;//권한레벨	
		
		if(step==0){//권한0단계(전체권한)
			initGroupCodeChange('G-1','group1',frm);//1단계 그룹세팅
			
			if(frm.cmAuthID.value=='G0000000'){//전체권한인경우
				frm.group1.value='S'; 
			}else{
				frm.group1.value=frm.cmAuthID.value; //1단계 그룹 선택
			}
						
						
			frm.SearchAuthBox.value='group1';//선택된 조회권한 box 
			initGroupCodeChange(frm.group1.value,'group2',frm);  //2단계 그룹세팅
		}else if(step==1){//권한1단계
			initGroupCodeChange(frm.cmUpAuthID.value,'group1',frm);//1단계 그룹세팅
			frm.group1.value=frm.cmAuthID.value; //1단계 그룹 선택
			frm.SearchAuthBox.value='group1';//선택된 조회권한 box 
			initGroupCodeChange(frm.group1.value,'group2',frm); //2단계 그룹세팅
			frm.group1.disabled=true; //상위권한 disabled
		}else if(step==2){//권한2단계
			initGroupCodeChange(frm.cmUpAuthID.value,'group2',frm); //2단계 그룹세팅
			frm.group2.value=frm.cmAuthID.value; //2단계 그룹 선택
			frm.SearchAuthBox.value='group2';//선택된 조회권한 box 
			initGroupCodeChange(frm.group2.value,'group3',frm); //3단계 그룹세팅
			frm.group1.disabled=true; //상위권한 disabled
			frm.group2.disabled=true; //상위권한 disabled
		}else if(step==3){//권한3단계
			initGroupCodeChange(frm.cmUpAuthID.value,'group3',frm); //3단계 그룹세팅
			frm.group3.value=frm.cmAuthID.value; //3단계 그룹 선택
			frm.SearchAuthBox.value='group3'; //선택된 조회권한 box
			initGroupCodeChange(frm.group3.value,'group4',frm); //4단계 그룹세팅
			frm.group1.disabled=true;//상위권한 disabled
			frm.group2.disabled=true;//상위권한 disabled
			frm.group3.disabled=true;//상위권한 disabled
		}else if(step==4){//권한4단계
			initGroupCodeChange(frm.cmUpAuthID.value,'group4',frm);//4단계 그룹세팅
			frm.group4.value=frm.cmAuthID.value;//4단계 그룹 선택
			frm.SearchAuthBox.value='group4';//선택된 조회권한 box
			initGroupCodeChange(frm.group4.value,'group5',frm); //5단계 그룹세팅
			frm.group1.disabled=true;//상위권한 disabled
			frm.group2.disabled=true;//상위권한 disabled
			frm.group3.disabled=true;//상위권한 disabled
			frm.group4.disabled=true;//상위권한 disabled
		}else if(step==5){//권한5단계
			initGroupCodeChange(frm.cmUpAuthID.value,'group5',frm);//5단계 그룹세팅
			frm.group5.value=frm.cmGroupID.value;//5단계 그룹 선택
			frm.SearchAuthBox.value='group5';//선택된 조회권한 box
			frm.group1.disabled=true;//상위권한 disabled
			frm.group2.disabled=true;//상위권한 disabled
			frm.group3.disabled=true;//상위권한 disabled
			frm.group4.disabled=true;//상위권한 disabled
		}

		if(frm.AuthGroupOption!= undefined){

			if(frm.AuthGroupOption[0].checked){
				frm.AuthGroup.value='Y';
			}else{
				frm.AuthGroup.value='N';
			}
		}

	}else if(frm.AuthOption.value=="User"){//권한이 개인경우 처리
		
		frm.AuthID.value=frm.cmUserID.value;//개인ID를 권한에 세팅한다.
		frm.AuthGroup.value='N';
		if(gobj!= undefined){
			gobj.style.display='none';
		}
		
		if(uobj!= undefined){
			uobj.style.display='block';
			sobj.style.height='50px';
		}else{
			sobj.style.height='25px';
		}

	}else{//권한이 미배정인경우 처리
		
		frm.AuthID.value=frm.cmAuthID.value;//그룹ID를 권한에 세팅한다.
		frm.AuthGroup.value='N';
		if(gobj!= undefined){
			gobj.style.display='none';
		}
		sobj.style.height='25px';
	}
}
function setAuthGroup(frm,val){
	frm.AuthGroup.value=val;
}
function searchOptionGubin(obj){
	if(obj.searchArea.value!='3'){
		obj.vSearchTeamDIDNo.value='';
		obj.vSearchTeamDIDNo.disabled=true;
	}else{
		obj.vSearchTeamDIDNo.disabled=false;
	}
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :  initGroupCodeChange
//내  용 : 초기 group 단계에 대한 type에 따라 해당 타입의 코드에  대한 하위 리스트를 세팅해준다.
///////////////////////////////////////////////////////////////////////////////
function initGroupCodeChange(code,target,form)
{
	clearComboBox(target,form);

	if(code=='CallAll'){//전체인경우(콜)
		
		callGroupAllComboBox(form);
		
		return;
	}
	
	if(code=='LongAll'){//전체인경우(장기)
		
		longGroupAllComboBox(form);
		
		return;
	}

	if(code == "S" ) {	
		return;
	}
	
	var request = contextroot+"/H_Common.do?cmd=groupComboList";
	var combo;	
	
	if(target == 'group1') {
		request = request + "&groupid="+code;		
		combo = form.group1;
	} else if(target == 'group2') {
		request = request + "&groupid="+code;			
		combo = form.group2;
	} else if(target == 'group3') {
		request = request + "&groupid="+code;			
		combo = form.group3;
	} else if(target == 'group4') {
		request = request + "&groupid="+code;			
		combo = form.group4;
	} else if(target == 'group5') {
		request = request + "&groupid="+code;			
		combo = form.group5;
	} else {
		return;
	}

	doRequestSubmit(combo, request);

}
function upGroupValue(target,form){

	var result;
	
	if(target=='group5'){
		result=form.group3.value;
	}else if(target=='group4'){ 
		result=form.group2.value;
	}else if(target=='group3'){ 
		result=form.group1.value;
	}else if(target=='group2'){ 
		result='G0000000';
	} 

	return result;
	
}
///////////////////////////////////////////////////////////////////////////////
//함수명 :  GroupCodeChange
//내  용 : 선택 group 단계에 대한 type에 따라 해당 타입의 코드에  대한 하위 리스트를 세팅해준다.
///////////////////////////////////////////////////////////////////////////////
function GroupCodeChange(object,target,form)
{
	
	var code = getSelectValue(object, true);//선택값 가져오기
	
	
	if(code=='S' || code==''){
		form.AuthID.value=upGroupValue(target,form);
	}else{
    	form.AuthID.value=code;//선택값으로 권한세팅
	}



	if(form.GroupDID!= undefined){//그룹DID검색인경우
		var title=getSelectTitle(object);//선택된 타이틀 가져오기
		form.GroupDID.value=title;
		var groupname = getSelectValue(object, false);//그룹명 가져오기
		form.GroupName.value=groupname;
	}
	
	if(target == 'group1') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group1',form);
		clearComboBox('group2',form);
		clearComboBox('group3',form);
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group1';//선택된 조회권한 box
		form.sGroup1.value=code;//선택된 조회권한 box
	}else if(target == 'group2') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group2',form);
		clearComboBox('group3',form);
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group1';//선택된 조회권한 box
		form.sGroup1.value=code;//선택된 조회권한 box
	}else if(target == 'group3') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group3',form);
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group2';//선택된 조회권한 box
		form.sGroup2.value=code;//선택된 조회권한 box
	}else if(target == 'group4') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group3';//선택된 조회권한 box
		form.sGroup3.value=code;//선택된 조회권한 box
	}else if(target == 'group5') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group4';//선택된 조회권한 box
		form.sGroup4.value=code;//선택된 조회권한 box
		
	}

	if(code == "S") {	
		return;
	}
	
	var request = contextroot+"/H_Common.do?cmd=groupComboList";
	var combo;	
	
	if(target == 'group1') {
		request = request + "&groupid=G-1";		
		combo = form.group1;
	} else if(target == 'group2') {
		request = request + "&groupid="+code;			
		combo = form.group2;
	} else if(target == 'group3') {
		request = request + "&groupid="+code;			
		combo = form.group3;
	} else if(target == 'group4') {
		request = request + "&groupid="+code;			
		combo = form.group4;
	} else if(target == 'group5') {
		request = request + "&groupid="+code;			
		combo = form.group5;
	} else {
		return;
	}

	doRequestSubmit(combo, request);

}
///////////////////////////////////////////////////////////////////////////////
//함수명 :  searchChange
//내  용 : 검색결과후 검색조건에 대한 type에 따라 해당 타입의 코드에  대한 하위 리스트를 세팅해준다.
///////////////////////////////////////////////////////////////////////////////
function searchSelectAuth(frm,group){

	var step=frm.cmAuthStep.value;//권한레벨
	
	if(group=='group1'){//선택한 권한 box(전체)
		initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
		
		if(frm.sGroup1.value=='G0000000'){//전체권한인경우
			frm.group1.value='S'; 
		}else{
			frm.group1.value=frm.sGroup1.value; //0단계 그룹 선택
		}

		initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
	}else if(group=='group2'){//선택한 권한 box
		initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
		initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
		initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
		frm.group1.value=frm.sGroup1.value;//1단계권한 선택
		frm.group2.value=frm.sGroup2.value;//2단계권한 선택
	}else if(group=='group3'){//선택한 권한 box
		if(step==0){//권한 레벨 0단계
			initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
			initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group1.value=frm.sGroup1.value;//1단계권한 선택
			frm.group2.value=frm.sGroup2.value;//2단계권한 선택
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
		}else if(step==1){//권한 레벨 1단계
			initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
			initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group1.value=frm.sGroup1.value;//1단계권한 선택
			frm.group2.value=frm.sGroup2.value;//2단계권한 선택
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
		}else if(step==2){//권한 레벨 2단계
			initGroupCodeChange(frm.group2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
		}else if(step==3){//권한 레벨 3단계
			initGroupCodeChange(frm.group3.value,'group4',frm);//4단계 권한 세팅
		}
	}else {//선택한 권한 box(4,5)
		if(step==0){//권한 레벨 0단계
			initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
			initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅
			frm.group1.value=frm.sGroup1.value;//1단계권한 선택
			frm.group2.value=frm.sGroup2.value;//2단계권한 선택
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
		}else if(step==1){//권한 레벨 1단계
			initGroupCodeChange('G-1','group1',frm);//1단계 권한 세팅
			initGroupCodeChange(frm.sGroup1.value,'group2',frm);//2단계 권한 세팅
			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅
			frm.group1.value=frm.sGroup1.value;//1단계권한 선택
			frm.group2.value=frm.sGroup2.value;//2단계권한 선택
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
		}else if(step==2){//권한 레벨 2단계
			initGroupCodeChange(frm.group2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
		}else if(step==3){//권한 레벨 3단계
			initGroupCodeChange(frm.group3.value,'group4',frm);//4단계 권한 세팅
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
		}else if(step==4){//권한 레벨 4단계
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅
			frm.group5.value=frm.sGroup5.value;//5단계권한 선택
		}
	}
	
	frm.SearchAuthBox.value=group;
	
}
//선택된 값 가져오기
function getSelectValue(object, isValue)
{
	value = "";

	for(var i = 0 ; i < object.options.length ; i++)
	{
		if(object.options[i].selected)
		{
			if(isValue)
			{
				value = object.options[i].value;
			}
			else
			{
				value = object.options[i].text;
			}
			break;
		}
	}
	return value;
}
//선택된 타이틀 가져오기
function getSelectTitle(object)
{
	title = "";

	for(var i = 0 ; i < object.options.length ; i++)
	{
		if(object.options[i].selected)
		{

			title = object.options[i].title;

			break;
		}
	}
	return title;
}
//셀렉트 박스 삭제
function clearComboBox(name,form)
{
	
	switch(name) {
		case "group1" : 
		case "group2" : 	
			clearSelectOptions(form.group2);	
			addSelectOption(form.group2, "S", "전체");

		case "group3" :
			clearSelectOptions(form.group3);	
			addSelectOption(form.group3, "S", "전체");
		
		case "group4" :
			clearSelectOptions(form.group4);	
			addSelectOption(form.group4, "S", "전체");

		case "group5" :
			clearSelectOptions(form.group5);	
			addSelectOption(form.group5, "S", "전체");
	}
}
//request 요청
function doRequestSubmit(combo, request)
{
	try {

		var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", request, false);
		xmlhttp.send(request);

		var resultText = xmlhttp.responseText;
		var xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		
		xmlObject.loadXML(resultText);	

		createComboBox(combo, xmlObject);

	} catch(e) {}
}
function groupNameReplace(name){
	
	var rname;
	
	rname=name.replace("%26","&");
	
	return rname;
	
}
//셀렉트 박스 삭제
function createComboBox(object, resultXml) {

	var root=resultXml.documentElement;
	var groupids=root.getElementsByTagName("groupid");
	var cnt=groupids.length;
	
	clearSelectOptions(object);	
	addSelectOption(object, "S", "전체");

	for(var i = 0 ; i < cnt ; i++) {

		addSelectOptionTitle(object, 
					root.getElementsByTagName("groupid")[i].firstChild.nodeValue, 
					groupNameReplace(root.getElementsByTagName("groupname")[i].firstChild.nodeValue),
					root.getElementsByTagName("didno")[i].firstChild.nodeValue
			);

	}
}
function addSelectOptionTitle(object, value, text , didno)
{
	
	if(didno=='N(1)'){
		didno='';
	}
	
	option = document.createElement("OPTION");
	option.text = text;
	option.value = value;
	option.title = didno;
	object.options.add(option);
}

function viewClick(index){

	document.getElementById("tdonevent_"+index).className = '';
	
	document.getElementById("imagechange1_"+index).style.display='none';
	document.getElementById("imagechange2_"+index).style.display='block';

}
function callViewClick(index){

	var tdonevent = document.getElementsByName("Forgery");
	var imagechange1 = document.getElementsByName("imagechange1");
	var imagechange2 = document.getElementsByName("imagechange2");
	
	tdonevent[index].className = '';
	
	imagechange1[index].style.display='none';
	imagechange2[index].style.display='block';
	
}	  
function groupSelect(obj,groupid1,groupid2,groupid3,groupid4,groupid5){
	
	obj.group1.value=groupid1; //1단계 그룹 선택
	initGroupCodeChange(obj.group1.value,'group2',obj);  //2단계 그룹세팅
	obj.group2.value=groupid2; //2단계 그룹 선택
	initGroupCodeChange(obj.group2.value,'group3',obj); //3단계 그룹세팅
	obj.group3.value=groupid3; //3단계 그룹 선택
	initGroupCodeChange(obj.group3.value,'group4',obj);//4단계 그룹세팅
	obj.group4.value=groupid4; //4단계 그룹 선택
	initGroupCodeChange(obj.group4.value,'group5',obj); //5단계 그룹세팅
	obj.group5.value=groupid5; //5단계 그룹 선택
	
}	
//////////////////////////////////////////////////////////////////////////////
//함수명 : ViewDataOver(), ViewDataOut()
//내  용 : 풍선 도움말 함수 (
//function ViewDataOver(x,y,data1,data2,data3,...)
//////////////////////////////////////////////////////////////////////////////
var ttaStyle;
var _x;
var _y;

function ViewDataOver2() {
	_x = ViewDataOver2.arguments[0];
	_y = ViewDataOver2.arguments[1];
	ViewDataOver_do(ViewDataOver2.arguments);
}
function ViewDataOver() {
	_x = 0;
	_y = 0;

	ViewDataOver_do(ViewDataOver.arguments);
}
function ViewDataOver_do(arguments) {
	var args = arguments;
	var innerText = "";

	chkTtArea();
	document.onmousemove = getMouse;

	for(var i=0; i<args.length; i++) {

		if(i==0) {
			innerText += args[i];
		}else {
			if(args[i]!=null) {
				innerText += "<br>"+args[i];
			}
		}
	}

	var innerText = "<table ><tr valign='middle'><td align='left' >"
		  + innerText
		  + "</td></tr></table>";
	document.all("pop_mini").innerHTML = innerText;
	
	if(args.length>0){
	ttaStyle.visibility = "visible";
	}
}

//마우스움직임 감지
function getMouse() {
	chkTtArea();
 var x = event.x+document.body.scrollLeft;
	var y = event.y+document.body.scrollTop;
   ttaStyle.left = x+10+_x;
	ttaStyle.top  = y+5+_y;
}

//말풍선을 사라지게 함
function ViewDataOut() {
	if(ttaStyle!=undefined){
		ttaStyle.visibility = "hidden";
	}
}
//말풍선 영역 확인
function chkTtArea() {
	if(document.all.pop_mini==null) {
		document.body.insertAdjacentHTML("beforeEnd", '<div ID="pop_mini" style="position:absolute;visibility:hidden"> </div>');
		ttaStyle = document.all.pop_mini.style;
	}
}

function callGroupAuth(frm,init){

	var gobj=document.all.group_select;
	var sobj=document.all.seach_box;
	var uobj=document.all.user_select;

	if(frm.AuthOption.value=="Group"){//권한이 조직인경우 처리

		frm.AuthID.value=frm.sGroup2.value;//사용자 설정 권한 아이디를 세팅한다.

		if(gobj!= undefined){
			gobj.style.display='block';
			sobj.style.height='50px';
		}
		
		if(uobj!= undefined){
			uobj.style.display='none';
			if(frm.searchArea!= undefined){
			 frm.searchArea.value='';
			 frm.vSearchTeamDIDNo.value='';
			}

		}

		if(frm.AuthID.value=='GC10000' || frm.AuthID.value=='GC20000'){
			frm.group2.value=frm.sGroup2.value; //2단계 그룹 선택
			frm.SearchAuthBox.value='group2';//선택된 조회권한 box 
			initGroupCodeChange(frm.group2.value,'group3',frm); //3단계 그룹세팅
		}else if(frm.AuthID.value=='CallAll' ){
			
			frm.group2.value=frm.sGroup2.value; //2단계 그룹 선택
			frm.SearchAuthBox.value='group2';//선택된 조회권한 box

			callGroupAllComboBox(frm); //3단계 그룹세팅

		}else{

			
			if(init==true){
				
				var sGroup3='G067900';
				var sGroup4='G067901';
				frm.AuthID.value='G067901';

				frm.group2.value='G1G0000'; //2단계 그룹 선택
				frm.sGroup2.value='G1G0000';
				initGroupCodeChange(frm.group2.value,'group3',frm); //3단계 그룹세팅	
				frm.group3.value=sGroup3; //3단계 그룹 선택
				frm.sGroup3.value=sGroup3;
				initGroupCodeChange(frm.group3.value,'group4',frm); //4단계 그룹세팅	
				frm.group4.value=sGroup4; //4단계 그룹 선택
				frm.sGroup4.value=sGroup4;
				initGroupCodeChange(frm.group4.value, 'group5',frm);
				
				frm.SearchAuthBox.value='group4';//선택된 조회권한 box 

			}else{
				
				var sGroup3=frm.sGroup3.value;
				var sGroup4=frm.sGroup4.value;

				frm.group2.value='G1G0000'; //2단계 그룹 선택

				callGroupCodeChange(frm.group2,'group3',frm); //3단계 그룹세팅	
				frm.group3.value=sGroup3; //3단계 그룹 선택
				callGroupCodeChange(frm.group3,'group4',frm); //4단계 그룹세팅	
				frm.group4.value=sGroup4; //4단계 그룹 선택
				callGroupCodeChange(frm.group4, 'group5',frm);
				
				frm.SearchAuthBox.value='group4';//선택된 조회권한 box 
			}
			
			
		}
		
		frm.AuthGroup.value='Y';

	}else if(frm.AuthOption.value=="User"){//권한이 개인경우 처리
		
		frm.AuthID.value=frm.cmUserID.value;//개인ID를 권한에 세팅한다.
		frm.AuthGroup.value='N';
		if(gobj!= undefined){
			gobj.style.display='none';
		}
		
		if(uobj!= undefined){
			uobj.style.display='block';
			sobj.style.height='50px';
		}else{
			sobj.style.height='25px';
		}

	}else{//권한이 미배정인경우 처리

		frm.AuthID.value=frm.cmAuthID.value;//그룹ID를 권한에 세팅한다.
		frm.AuthGroup.value='N';
		if(gobj!= undefined){
			gobj.style.display='none';
		}
		sobj.style.height='25px';
	}
}
function longGroupAuth(frm,init){

	var gobj=document.all.group_select;
	var sobj=document.all.seach_box;
	var uobj=document.all.user_select;

	if(frm.AuthOption.value=="Group"){//권한이 조직인경우 처리

		frm.AuthID.value=frm.sGroup3.value;//사용자 설정 권한 아이디를 세팅한다.

		if(gobj!= undefined){
			gobj.style.display='block';
			sobj.style.height='50px';
		}
		
		if(uobj!= undefined){
			uobj.style.display='none';
			if(frm.searchArea!= undefined){
			 frm.searchArea.value='';
			 frm.vSearchTeamDIDNo.value='';
			}

		}

		if(frm.AuthID.value=='GSA0100' || frm.AuthID.value=='G045200'){
			frm.group3.value=frm.sGroup3.value; //3단계 그룹 선택
			frm.SearchAuthBox.value='group3';//선택된 조회권한 box 
			initGroupCodeChange(frm.group3.value,'group4',frm); //4단계 그룹세팅
		}else {
			frm.AuthID.value='LongAll';
			frm.sGroup3.value='LongAll';
			frm.group3.value=frm.sGroup3.value; //3단계 그룹 선택
			frm.SearchAuthBox.value='group3';//선택된 조회권한 box

			longGroupAllComboBox(frm); //3단계 그룹세팅

		}

		frm.AuthGroup.value='Y';

	}else if(frm.AuthOption.value=="User"){//권한이 개인경우 처리

		frm.AuthID.value=frm.cmUserID.value;//개인ID를 권한에 세팅한다.
		frm.AuthGroup.value='N';
		if(gobj!= undefined){
			gobj.style.display='none';
		}
		
		if(uobj!= undefined){
			uobj.style.display='block';
			sobj.style.height='50px';
		}else{
			sobj.style.height='25px';
		}

	}
}
function callSearchSelectAuth(frm,group){

	var step=frm.cmAuthStep.value;//권한레벨

	 if(group=='group2'){//선택한 권한 box
		initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
		frm.group2.value=frm.sGroup2.value;//2단계권한 선택
	}else if(group=='group3'){//선택한 권한 box
			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택

	}else {//선택한 권한 box(4,5)

			initGroupCodeChange(frm.sGroup2.value,'group3',frm);//3단계 권한 세팅
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅

	}

	frm.SearchAuthBox.value=group;
	
}
function longSearchSelectAuth(frm,group){

	var step=frm.cmAuthStep.value;//권한레벨

	  if(group=='group3'){//선택한 권한 box
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group3.value=frm.sGroup3.value;//3단계권한 선택

	}else {//선택한 권한 box(4,5)

			frm.group3.value=frm.sGroup3.value;//3단계권한 선택
			initGroupCodeChange(frm.sGroup3.value,'group4',frm);//4단계 권한 세팅
			frm.group4.value=frm.sGroup4.value;//4단계권한 선택
			initGroupCodeChange(frm.sGroup4.value,'group5',frm);//5단계 권한 세팅

	}

	frm.SearchAuthBox.value=group;
	
}
function callGroupAllComboBox(form){
	
	form.AuthID.value='CallAll';
	
	clearComboBox('group3',form);
	clearComboBox('group4',form);
	clearComboBox('group5',form);
	form.SearchAuthBox.value='group2';//선택된 조회권한 box
	form.sGroup2.value='CallAll';//선택된 조회권한 box
	
	doCallRequestSubmit(form);
	

}
function longGroupAllComboBox(form){
	
	form.AuthID.value='LongAll';

	clearComboBox('group4',form);
	clearComboBox('group5',form);
	form.SearchAuthBox.value='group3';//선택된 조회권한 box
	form.sGroup3.value='LongAll';//선택된 조회권한 box
	
	doLongRequestSubmit(form);
	

}
//request 요청
function doCallRequestSubmit(form)
{
	try {
		var combo = form.group3;
		
		clearSelectOptions(combo);	
		addSelectOption(combo, "S", "전체");
		createCallComboBox(combo,'GC10000');
		createCallComboBox(combo,'GC20000');
		createCallComboBox(combo,'G1G0000');

	} catch(e) {}
}
//request 요청
function doLongRequestSubmit(form)
{
	try {
		var combo = form.group4;
		
		clearSelectOptions(combo);	
		addSelectOption(combo, "S", "전체");
		createCallComboBox(combo,'GSA0100');
		createCallComboBox(combo,'G045200');

	} catch(e) {}
}
function createCallComboBox(object,groupid) {
	
	var request = contextroot+"/H_Common.do?cmd=groupComboList&groupid="+groupid;

	var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlhttp.open("GET", request, false);
	xmlhttp.send(request);

	var resultText = xmlhttp.responseText;
	var xmlObject = new ActiveXObject("Microsoft.XMLDOM");

	xmlObject.loadXML(resultText);	
	
	var root=xmlObject.documentElement;
	var groupids=root.getElementsByTagName("groupid");

	var cnt=groupids.length;

	for(var i = 0 ; i < cnt ; i++) {

		addSelectOptionTitle(object, 
					root.getElementsByTagName("groupid")[i].firstChild.nodeValue, 
					groupNameReplace(root.getElementsByTagName("groupname")[i].firstChild.nodeValue),
					root.getElementsByTagName("didno")[i].firstChild.nodeValue
			);

	}
}
function callGroupCodeChange(object,target,form)
{
	var code = getSelectValue(object, true);//선택값 가져오기

	if(code=='CallAll'){//전체인경우
		
		callGroupAllComboBox(form);
		
		return;
	}
	
	if(code=='S' || code==''){
		form.AuthID.value=upGroupValue(target,form);
	}else{
    	form.AuthID.value=code;//선택값으로 권한세팅
	}

	if(form.GroupDID!= undefined){//그룹DID검색인경우
		var title=getSelectTitle(object);//선택된 타이틀 가져오기
		form.GroupDID.value=title;
		var groupname = getSelectValue(object, false);//그룹명 가져오기
		form.GroupName.value=groupname;
	}

	if(target == 'group3') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group3',form);
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group2';//선택된 조회권한 box
		form.sGroup2.value=code;//선택된 조회권한 box
	}else if(target == 'group4') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group3';//선택된 조회권한 box
		form.sGroup3.value=code;//선택된 조회권한 box
	}else if(target == 'group5') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group4';//선택된 조회권한 box
		form.sGroup4.value=code;//선택된 조회권한 box
		
	}

	if(code == "S") {	
		return;
	}
	
	var request = contextroot+"/H_Common.do?cmd=groupComboList";
	var combo;	
	
	 if(target == 'group3') {
		request = request + "&groupid="+code;			
		combo = form.group3;
	} else if(target == 'group4') {
		request = request + "&groupid="+code;			
		combo = form.group4;
	} else if(target == 'group5') {
		request = request + "&groupid="+code;			
		combo = form.group5;
	} else {
		return;
	}

	doRequestSubmit(combo, request);

}
function longGroupCodeChange(object,target,form)
{
	var code = getSelectValue(object, true);//선택값 가져오기

	if(code=='LongAll'){//전체인경우
		
		longGroupAllComboBox(form);
		
		return;
	}
	
	if(code=='S' || code==''){
		form.AuthID.value=upGroupValue(target,form);
	}else{
    	form.AuthID.value=code;//선택값으로 권한세팅
	}

	if(form.GroupDID!= undefined){//그룹DID검색인경우
		var title=getSelectTitle(object);//선택된 타이틀 가져오기
		form.GroupDID.value=title;
		var groupname = getSelectValue(object, false);//그룹명 가져오기
		form.GroupName.value=groupname;
	}

	if(target == 'group4') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group4',form);
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group3';//선택된 조회권한 box
		form.sGroup3.value=code;//선택된 조회권한 box
	}else if(target == 'group5') {
		//새로 생성할 리스트 이후 box삭제
		clearComboBox('group5',form);
		form.SearchAuthBox.value='group4';//선택된 조회권한 box
		form.sGroup4.value=code;//선택된 조회권한 box
		
	}

	if(code == "S") {	
		return;
	}
	
	var request = contextroot+"/H_Common.do?cmd=groupComboList";
	var combo;	
	
	if(target == 'group4') {
		request = request + "&groupid="+code;			
		combo = form.group4;
	} else if(target == 'group5') {
		request = request + "&groupid="+code;			
		combo = form.group5;
	} else {
		return;
	}

	doRequestSubmit(combo, request);

}

function SearchReciveResultType( step, obj, CodeGroupID, frm, flag ){
	
	var request = contextroot + '/H_Common.do?cmd=SearchReciveResultTypeGroup';
	request = request + '&codegroupid=' + CodeGroupID;
	
	try {

		var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", request, false);
		xmlhttp.send(request);

		var resultText = xmlhttp.responseText;
		var xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		
		xmlObject.loadXML(resultText);
		
		var root=xmlObject.documentElement;
		var groupids=root.getElementsByTagName("codegroupid");
		var cnt=groupids.length;
		
		for(var i = obj.options.length - 1 ; i >= 0 ; i--) 
		{
			obj.options.remove(i);
		}
		
		if( flag == 1 ) {
			addSelectOption(obj, "0", "전체");			
		}
		
		for(var i = 0 ; i < cnt ; i++) {
			
			option = document.createElement("OPTION");
			option.text = root.getElementsByTagName("codename")[i].firstChild.nodeValue;
			option.value = root.getElementsByTagName("codeid")[i].firstChild.nodeValue;
			option.title = root.getElementsByTagName("codename")[i].firstChild.nodeValue;
			obj.options.add(option);
		}
		
	} catch(e) {}
}

function bluring(){ 
	if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG" ||event.srcElement.tagType=="checkbox" ||event.srcElement.tagType=="radio") document.body.focus(); 
	} 
	document.onfocusin=bluring; 

	
	//전화번호 숫자 입력시 체크 후 - 생성
	function PhonNumStr( str ){ 

		 var RegNotNum  = /[^0-9]/g; 

		 var RegPhonNum = ""; 

		 var DataForm   = ""; 

		 // return blank     

		 if( str == "" || str == null ) return ""; 

		 // delete not number

		 str = str.replace(RegNotNum,'');    

		 if( str.length < 4 ) return str; 


		 if( str.length > 3 && str.length < 7 ) { 

		   	DataForm = "$1-$2"; 

			 RegPhonNum = /([0-9]{3})([0-9]+)/; 

		 } else if(str.length == 7 ) {

			 DataForm = "$1-$2"; 

			 RegPhonNum = /([0-9]{3})([0-9]{4})/; 

		 // ↓ 전화번호 뒷자리만 - 단위로 replace 할 경우 조건식.
		 } else if(str.length == 8 ) {

			 DataForm = "$1-$2"; 

			 RegPhonNum = /([0-9]{4})([0-9]{4})/; 
			 
		 } else if(str.length == 9 ) {

			 DataForm = "$1-$2-$3"; 

			 RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 

		 } else if(str.length == 10){ 

			 if(str.substring(0,2)=="02"){

				 DataForm = "$1-$2-$3"; 

				 RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 

			 }else{

				 DataForm = "$1-$2-$3"; 

				 RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;

			 }

		 } else if(str.length > 10){ 

			 DataForm = "$1-$2-$3"; 

			 RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 

		 } 


		 while( RegPhonNum.test(str) ) {  

			 str = str.replace(RegPhonNum, DataForm);  

		 } 

		 return str; 

	} 
	String.prototype.replaceAll=replaceAll;
	function replaceAll(strValue1,strValue2){
		var strTemp=this;
		strTemp=strTemp.replace(new RegExp(strValue1,"g"),strValue2);
		return strTemp
		
	}