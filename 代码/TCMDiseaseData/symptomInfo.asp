<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>证候加工审校页面</title>
<link href="common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function AddNewRecord()
{
	if(confirm("确定要加入新记录么?"))
	{
		if (document.forms("formCont").txtZHMC.value=="")
		{
			alert("证候名称不能为空!");
			return false;
		}
		var init = document.forms("formCont").txtZHMC.value.indexOf("$")
		if (init !=-1)
		{
			alert("不能有多个证候名称!");
			return false;
		}
		return true;
	}
	else
		return false;
}
function UpdateRecord(num)
{
	if(confirm("确定要更新记录么?"))
	{
		if (document.forms(num).txtZHMC.value=="")
		{
			alert("证候名称不能为空!");
			return false;
		}
		var init = document.forms(num).txtZHMC.value.indexOf("$")
		if (init !=-1)
		{
			alert("不能有多个证候名称!");
			return false;
		}
		return true;
	}
	else
		return false;
}

var standard;
function showStandard(strTable,strPos,txtTarget,strnum)
{
	var num = parseInt(strnum);
	var left;
	
	if (strPos=="left")
		left=screen.width-280;
	else
		left=0;
	document.forms(num).pastefield.value=txtTarget;

	if (standard=='[object]')
		standard.close();
			
	standard=window.open("/starch/wizard.asp?table="+strTable+"&formNum="+num,"standard","width=310,height=500,left="+left+",top=25,toolbar=no,scrollbars=yes");
	
	if ((document.forms(num).window!=null) && (!standard.opener))
		standard.opener=document.forms(num).window;
		
	standard.focus();
}
//-->
</script>
</head>

<body class="body">
<% 
	dim JBMC
	JBMC=request.QueryString("JBMC")
	dim strSQL
	strSQL="select * from C_ZhenH where JBMC='"&JBMC&"'"
	
	dim oraDB
	set oraDB=OraSession.GetDatabaseFromPool(60)
	dim oraRS 
	set oraRS=oraDB.CreateDynaset(strSQL,0)
	
%>
<form>
<INPUT type="hidden" name="pastefield">
</form>
<table width="800" border="0" align="center" class="table2">
<tr>
<td class="title1"><%=JBMC%>-已有相关的证候信息记录列表：<%=oraRS.RecordCount%>条<br/></td>
</tr>
<%		
	Dim JLNUM
	JLNUM= 0    	
	oraRS.MoveFirst
    Do Until oraRS.EOF
		JLNUM= JLNUM+1
%>
<tr><td class="title1"><%response.Write(JLNUM)%></td></tr>
<tr><td>
	<form action="updateSymptomInfo.asp?ID=<%=oraRS.fields("ID")%>&JBMC=<%=JBMC%>&BJZT=<%=request("BJZT")%>" method="post">
	<INPUT type="hidden" name="pastefield">
	<table width="100%" class="table3">
    	<tr> 
      		<td height="40"> <div align="right">证候名称：</div></td>
      		<td><textarea name="txtZHMC" cols="20" rows="3"><%=oraRS.fields("ZHMC")%></textarea> 
        		<input name="button222" type="button" class="button1" onClick="showStandard('ZhengHou','Right','txtZHMC','<%=JLNUM%>');" value="辅助选词"></td>
      		<td height="40"><div align="right">证候类型：</div></td>
      		<td><textarea name="txtZHLX" cols="20" rows="3"><%=oraRS.fields("ZHLX")%></textarea>
                <input name="button2222" type="button" class="button1" onClick="showStandard('JiBing','Right','txtYFB','<%=JLNUM%>');" value="辅助选词"></td>
    	</tr>
    	<tr> 
      		<td height="40"> <div align="right">病机信息：</div></td>
      		<td><textarea name="txtBJMC" cols="20" rows="3"><%=oraRS.fields("BJMC")%></textarea>
        		<input type="button" class="button1" onClick="showStandard('ZhengHou','Right','txtZHMC','<%=JLNUM%>');" value="辅助选词"></td>
      		<td> <div align="right">症状信息：</div></td>
      		<td><textarea name="txtZZMC" cols="20" rows="3"><%=oraRS.fields("ZZMC")%></textarea>
        		<input name="button4" type="button" class="button1" onClick="showStandard('ZhengZhuang','Right','txtZZMC','<%=JLNUM%>');" value="辅助选词"></td>
    	</tr>
		<tr> 
        	<td height="20" ><div align="right">备注：</div></td>
        	<td height="20" colspan="4" ><textarea name="txtBZ" cols="60" rows="3"><%=oraRS.fields("BZ")%></textarea></td>
      	</tr>
    	<tr>
    	  <td height="16" colspan="4"><div align="center"><input type="submit" name="Submit" value="更新该条证候记录" onClick="return UpdateRecord(<%=JLNUM%>)"> 
		  <input type="button" value="删除该条证候记录" onClick="if (confirm('确定要删除记录么？')) { window.location='delSymptomInfo.asp?ID=<%=oraRS.fields("ID")%>&JBMC=<%=JBMC%>&BJZT=<%=request("BJZT")%>';}">
    	  </div></td>
   	  	</tr>
  	</table>
	</form>
</td></tr>
<%
		oraRS.movenext
	loop
	oraRS.close
	set oraRS=nothing
	oraDB.close
	set oraDB=nothing
	JLNUM=JLNUM+1
%>
<tr>
<td class="title1"><div align="center">添加一条新的证候记录</div></td>
</tr>
<tr>
<td>
	<form name="formCont" action="insertSymptomInfo.asp?JBMC=<%=JBMC%>&BJZT=<%=request("BJZT")%>" method="post">
	<INPUT type="hidden" name="pastefield">
	<table width="100%" class="table3">
    	<tr>
    	  <td height="40">
            <div align="right">证候名称：</div></td>
    	  <td><textarea name="txtZHMC" cols="20" rows="3"></textarea>
              <input name="button222" type="button" class="button1" onClick="showStandard('ZhengHou','Right','txtZHMC','<%=JLNUM%>');" value="辅助选词"></td>
    	  <td height="40"><div align="right">证候类型：</div></td>
    	  <td><textarea name="txtZHLX" cols="20" rows="3"></textarea>
              <input name="button2222" type="button" class="button1" onClick="showStandard('JiBing','Right','txtYFB','<%=JLNUM%>');" value="辅助选词"></td>
   		  </tr>
    	<tr>
    	  <td height="40">
            <div align="right">病机信息：</div></td>
    	  <td><textarea name="txtBJMC" cols="20" rows="3"></textarea>
              <input type="button" class="button1" onClick="showStandard('ZhengHou','Right','txtZHMC','<%=JLNUM%>');" value="辅助选词"></td>
    	  <td>
            <div align="right">症状信息：</div></td>
    	  <td><textarea name="txtZZMC" cols="20" rows="3"></textarea>
              <input name="button4" type="button" class="button1" onClick="showStandard('ZhengZhuang','Right','txtZZMC','<%=JLNUM%>');" value="辅助选词"></td> 
   		  </tr>
		<tr> 
        	<td height="20" ><div align="right">备注：</div></td>
        	<td height="20" colspan="4" ><textarea name="txtBZ" cols="60" rows="3"></textarea></td>
      	</tr>
    	<tr>
    	  <td height="16" colspan="4"><div align="center"><input type="submit" name="Submit" value="添加该条证候记录" onClick="return AddNewRecord()"></div></td>
   	  	</tr>
  	</table>
	</form></td>
</tr>
</table>
<center>
<a href="javascript:history.go(-1)">返回</a>
</center>
</body>
</html>
