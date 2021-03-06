<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/core/inc/header.jsp" %> 
<%
	String seqId=request.getParameter("seqId");
	if(seqId==null){
	  seqId="";
	}	
  
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>指定可访问人员</title>
<link rel="stylesheet" href = "<%=cssPath%>/style.css">
<link rel="stylesheet" href = "<%=cssPath%>/cmp/ExchangeSelect.css">
<script type="text/Javascript" src="<%=contextPath%>/core/js/datastructs.js" ></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/sys.js" ></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/prototype.js" ></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/smartclient.js" ></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/cmp/select.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/core/js/cmp/DTree1.0.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/orgselect.js" ></script>

<script type="text/javascript">
//alert('setUser.jsP:<%=seqId%>');
var requestURL="<%=contextPath%>/yh/core/funcs/system/dimension/act/YHDimensionAct";
function sendForm(){
	var seqId =('<%=seqId%>');
  var user = document.getElementById("user").value;
  var dept = document.getElementById("dept").value;
  var role = document.getElementById("role").value;
  var userId=dept+"|"+role+"|"+user;
 // alert('seqId:'+seqId+">>>>>userId:"+userId);
  var override=checkOverride();
  var url =requestURL + "/setVisitById.act?userId=" + userId + "&seqId=" + seqId + "&override=" + override;
  var rtJson = getJsonRs(url);
  if(rtJson.rtState == "0"){
    alert('设置权限成功！');
    //formDiv.style.display = "none";
    //show.style.display = "";
    //alert(rtJson.rtMsrg);
    //history.back();
    location.reload();
  }else{
	alert(rtJson.rtMsrg);
  }  
}

function doInit(){
	//alert("doInit");
	getUser("USER_ID");
	getDept("USER_ID");			
	getRole("USER_ID");
}
function getUser(action){
	var prcsJson; 
	var url =requestURL+"/getPersonIdStr.act?seqId=<%=seqId%>" + "&action="+action;		
	//alert("url>>"+url);  
	var json = getJsonRs(url);
	//alert(rsText);
  if(json.rtState == '1'){ 
    alert(json.rtMsrg); 
    return ; 
  }
  prcsJson = json.rtData;
  //alert("prcsJson>>"+prcsJson);
  if(prcsJson.user != "null"){
    document.getElementById("user").value = prcsJson.user;
    document.getElementById("userDesc").value = prcsJson.userDesc;
  }
}
function getRole(action){
	var prcsJson; 
	var url =requestURL+"/getRoleIdStr.act?seqId=<%=seqId%>"+"&action="+action;		
	//alert("url>>"+url);  
	var json = getJsonRs(url);
	//alert(rsText);
  if(json.rtState == '1'){ 
    alert(json.rtMsrg); 
    return ; 
  }
  prcsJson = json.rtData;
  //alert("prcsJson>>"+prcsJson);
  if(prcsJson.user != "null"){
    document.getElementById("role").value = prcsJson.role;
    document.getElementById("roleDesc").value = prcsJson.roleDesc;
  }
}
function getDept(action){
	var prcsJson; 
	var url =requestURL+"/getDeptIdStr.act?seqId=<%=seqId%>"+"&action="+action;		
	var json = getJsonRs(url);
	//alert(rsText);
  if(json.rtState == '1'){ 
    alert(json.rtMsrg); 
    return ; 
  }
  prcsJson = json.rtData;
  
  if(prcsJson.user != "null"){
    document.getElementById("dept").value = prcsJson.dept;
    var deptDesc = prcsJson.deptDesc;
    if(prcsJson.dept=="0"){
      deptDesc = "全体部门";
    }
    document.getElementById("deptDesc").value = deptDesc;
  }
}

function checkOverride(){
	var overStr=document.getElementsByName("override");
	var override="";
	if(overStr[0].checked){
		override= overStr[0].value;	
	}
	return override;
}



</script>


</head>
<body class="" topmargin="5" onload="doInit();">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
  <tr>
    <td class="small"><img src="<%=contextPath %>/core/funcs/system/filefolder/images/edit.gif" WIDTH="22" HEIGHT="20" align="absmiddle"><span class="big3"> 指定权限</span>
指定访问权限，有权限的人员可以访问该维度、子维度    </td>
  </tr>
</table>

<form action=""  method="post" name="form1">
<input type="hidden" name="userId" id="userId" value="">
<table class="TableBlock" width="100%" height="100%" align="center">
  <tr>
    <td nowrap class="TableContent"" align="center">授权范围：<br>（部门）</td>
    <td class="TableData">
      <input type="hidden" name="dept" id="dept" value="">
      <textarea cols=40 name="deptDesc" id="deptDesc" rows=8 class="BigStatic" wrap="yes" readonly></textarea>
      <a href="javascript:;" class="orgAdd" onClick="selectDept()">添加</a>
      <a href="javascript:;" class="orgClear" onClick="$('dept').value='';$('deptDesc').value='';">清空</a>
    </td>
  </tr>
  <tr>
    <td nowrap class="TableContent"" align="center">授权范围：<br>（角色）</td>
    <td class="TableData">
      <input type="hidden" name="role" id="role" value="">
      <textarea cols=40 name="roleDesc" id="roleDesc" rows=8 class="BigStatic" wrap="yes" readonly></textarea>
      <a href="javascript:;" class="orgAdd" onClick="selectRole();">添加</a>
      <a href="javascript:;" class="orgClear" onClick="$('role').value='';$('roleDesc').value='';">清空</a>
    </td>
  </tr>
  <tr>
    <td nowrap class="TableContent"" align="center">授权范围：<br>（人员）</td>
    <td class="TableData">
      <input type="hidden" name="user" id="user" value="">
      <textarea cols=40 name="userDesc" id="userDesc" rows=8 class="BigStatic" wrap="yes" readonly></textarea>
      <a href="javascript:;" class="orgAdd" onClick="selectUser();">添加</a>
      <a href="javascript:;" class="orgClear" onClick="$('user').value='';$('userDesc').value='';">清空</a>
    </td>
  </tr>
  <tr>
    <td nowrap class="TableContent"" align="center">选项：</td>
    <td class="TableData">
      <input type="checkbox" name="override" id="override" value="override"><label for="override">重置所有下级子维度的权限</label><br>
    </td>
  </tr>
  <tr>
    <td nowrap  class="TableControl" colspan="2" align="center">
      <input type="hidden" name="SORT_ID" value="5">
      <input type="hidden" name="FIELD_NAME" value="USER_ID">
      <input type="button" value="确定" onclick="sendForm()" class="BigButton">&nbsp;&nbsp;
      <input type="button" value="返回" class="BigButton" onclick="parent.parent.parent.location='../index.jsp'">
    </td>
</table>
</form>
</body>
</html>