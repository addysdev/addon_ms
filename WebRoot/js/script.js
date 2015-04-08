function writeSave()
{
	if(document.writeform.subject.value == "")
	{
		alert("제목을 입력하세요.");
		document.writeform.subject.focus();
		return false;
	}
	if(document.writeform.subject.value == "[답변]")
	{
		alert("답변을 입력하세요.");
		document.writeform.subject.focus();
		return false;
	}
	
	if(document.writeform.content.value == "")
	{
		alert("내용을 입력하세요");
		document.writeform.content.focus();
		return false;
	}
	
	if(document.writeform.password.value == "")
	{
		alert("비밀번호를 입력하세요.");
		document.writeform.password.focus();
		return false;
	}
}