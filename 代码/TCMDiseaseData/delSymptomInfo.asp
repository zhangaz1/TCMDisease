<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ɾ����֤֢��¼</title>
</head>

<body>
<%
	dim ID
	ID=request("ID")
	dim BJZT
	BJZT=request("BJZT")
	
	dim strSQL
	strSQL="delete from C_ZhenH where ID="&ID
	dim oraDB
	set oraDB=OraSession.GetDatabaseFromPool(60)
	
	oraDB.BeginTrans
	oraDB.ExecuteSQL(strSQL)
	if Err.Number=0 then
		oraDB.CommitTrans
	else
		oraDB.Rollback
	end if
	
	oraDB.close
	set oraDB=nothing
	response.Redirect("symptomInfo.asp?JBMC="&request("JBMC")&"&BJZT="&BJZT)
%>
</body>
</html>
