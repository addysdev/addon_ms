function writeSave()
{
	if(document.writeform.subject.value == "")
	{
		alert("������ �Է��ϼ���.");
		document.writeform.subject.focus();
		return false;
	}
	if(document.writeform.subject.value == "[�亯]")
	{
		alert("�亯�� �Է��ϼ���.");
		document.writeform.subject.focus();
		return false;
	}
	
	if(document.writeform.content.value == "")
	{
		alert("������ �Է��ϼ���");
		document.writeform.content.focus();
		return false;
	}
	
	if(document.writeform.password.value == "")
	{
		alert("��й�ȣ�� �Է��ϼ���.");
		document.writeform.password.focus();
		return false;
	}
}