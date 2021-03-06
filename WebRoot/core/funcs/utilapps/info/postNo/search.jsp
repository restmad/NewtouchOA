<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/inc/header.jsp" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE  html  PUBLIC  "-//W3C//DTD  HTML  4.01  Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>邮政编码查询</title>
<meta  http-equiv="Content-Type"  content="text/html;  charset=UTF-8">
<meta  http-equiv="Content-Type"  content="text/html;  charset=UTF-8">
<link  rel="stylesheet"  href  =  "<%=cssPath%>/cmp/ExchangeSelect.css">
<link  rel="stylesheet"  href  ="<%=cssPath%>/style.css">
<link rel="stylesheet" href="<%=cssPath %>/page.css"/>
<style>
.pgPanel {
  margin : 0 auto;
  width:720px;
}
</style>
<script  type="text/Javascript"  src="<%=contextPath%>/core/js/datastructs.js"  ></script>
<script  type="text/Javascript"  src="<%=contextPath%>/core/js/sys.js"  ></script>
<script  type="text/Javascript"  src="<%=contextPath%>/core/js/prototype.js"  ></script>
<script  type="text/Javascript"  src="<%=contextPath%>/core/js/smartclient.js"  ></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/cmp/page.js"></script>
<script Language="JavaScript">

var pageMgr;
function Init(){
  var postNo = encodeURI("${param.postNo }");
  var area = encodeURI("${param.area }");
  var requestURL;
  var cfgs;
  if(postNo.trim() != ""){
    requestURL = "<%=contextPath%>/yh/core/funcs/utilapps/info/postNo/act/YHPostNoAct/searchPostNo.act?postNo="+postNo;
    cfgs = {
      dataAction: requestURL,
      container: "listDiv",
      colums: [
         {type: "text", name: "seqId", text: "城市", width: 180,align: 'center'}, 
         {type: "text", name: "train", text: "区/县", width: 180,align: 'center'}, 
         {type: "text", name: "start", text: "街道", width: 180,align: 'center'}, 
         {type: "text", name: "end", text: "邮编", width: 180,align: 'center'} ]
    };
  }
  else if(area != ""){
    requestURL = "<%=contextPath%>/yh/core/funcs/utilapps/info/postNo/act/YHPostNoAct/searchAreaInfo.act?area="+area;
    cfgs = {
      dataAction: requestURL,
      container: "listDiv",
      colums: [
         {type: "text", name: "seqId", text: "国家", width: 250,align: 'center'}, 
         {type: "text", name: "train", text: "城市", width: 200,align: 'center'}, 
         {type: "text", name: "start", text: "地区", width: 80,align: 'center'}, 
         {type: "text", name: "end", text: "邮编", width: 180,align: 'center'} ]
    };
  }
   pageMgr = new YHJsPage(cfgs);
   pageMgr.show();
}
 
</script>
</head>

<body class="bodycolor" topmargin="5" onload="Init()">

<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
  <tr>
    <td class="Big"><img src="/yh/core/styles/imgs/menuIcon/infofind.gif" align="absmiddle"><span class="big3"> 邮政编码查询结果</span>
    </td>
  </tr>
</table>

<br>
<div align="center" id="listDiv"></div>

<br>
<center><input type="button" class="BigButton" value="返回" onclick="history.back();"></center>

</body>
</html>