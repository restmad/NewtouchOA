<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/core/inc/header.jsp" %>
        <%@ page import="java.util.*,java.text.*" %>
    <%@ page import="yh.core.funcs.email.data.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String toWebmail = request.getParameter("toWebmailR");
String toWebmailCC = request.getParameter("toWebmailCopy");
String toWebmailBCC = request.getParameter("toWebmailBcc");

  String boxId = request.getParameter("boxId");
  String startDateStr = request.getParameter("startTime") == null ? "" :   request.getParameter("startTime");
  String endDateStr = request.getParameter("endTime") == null ? "" :   request.getParameter("endTime") ;
  String userId = request.getParameter("userId") == null ? "" :  request.getParameter("userId");
  String attachmentName = request.getParameter("attachmentName") == null ? "" :   YHUtility.encodeSpecial(request.getParameter("attachmentName")) ;
  String subject = request.getParameter("subject") == null ? "" :   YHUtility.encodeSpecial(request.getParameter("subject")) ;
  String key1 = request.getParameter("key1") == null ? "" :   YHUtility.encodeSpecial(request.getParameter("key1") );
  String key2 = request.getParameter("key2") == null ? "" :   YHUtility.encodeSpecial(request.getParameter("key2")) ;
  String key3 = request.getParameter("key3") == null ? "" :  YHUtility.encodeSpecial(request.getParameter("key3"));
  String mailStatus = request.getParameter("mailStatus") == null ? "" :  request.getParameter("mailStatus");
%>
<title>内部邮件</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=cssPath %>/page.css">
<link rel="stylesheet" href = "<%=cssPath%>/style.css">
<link rel="stylesheet" href="<%=cssPath %>/cmp/email.css" type="text/css" />
<link rel="stylesheet" href="<%=cssPath %>/cmp/tab.css" type="text/css" />
<script type="text/javascript" src="<%=contextPath %>/core/js/prototype.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/cmp/tab.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/datastructs.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/sys.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/smartclient.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/cmp/page.js"></script>
<script type="text/javascript" src="<%=contextPath%>/core/js/cmp/Menu.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/funcs/email/js/util.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/funcs/email/js/emaillogic.js"></script>
<script type="text/javascript">
var pageMgr = null;
var boxId = "<%=boxId%>";
var toWebmail = "<%=toWebmail%>";
var toWebmailCC = "<%=toWebmailCC%>";
var toWebmailBCC = "<%=toWebmailBCC%>";
var queryType = "1";
function doInit() {
  if(queryType){
    param =  "boxId=" + boxId + "&queryType=" + queryType + "&startDate=<%=startDateStr%>&mailStatus=<%=mailStatus%>&attachmentName=<%=attachmentName%>&endDate=<%=endDateStr%>&subject=<%=subject%>&key1=<%=key1%>&key2=<%=key2%>&key3=<%=key3%>&userId=<%=userId%>&toWebmail=" + toWebmail+ "&toWebmailCC=" + toWebmailCC + "&toWebmailBCC=" + toWebmailBCC;
  } else {
    param =  "boxId=" + boxId;
  }
  param = encodeURI(param);
  var url =  contextPath + "/yh/core/funcs/email/act/YHInnerEMailAct/listSendBox.act?" + param;
  var cfgs = {
    dataAction: url,
    container: "listContainer",
    moduleName:"email",
    colums: [
       {type:"selfdef", align: "center", text: '<input type="checkbox" name="allbox" id="allbox" onClick="checkSearchAll();">', width:"8%",render:checkBoxRender},
       {type:"hidden", name:"emailBodyId"},
       {type:"selfdef", name:"status",text:"状态", width: "8%",render:statusRenderByIn},
       {type:"data", name:"toId", text:"收信人", width: "12%",render:userRender},
       {type:"hidden", name:"copyToId"},   
       {type:"hidden", name:"secretToId"},    
       {type:"data", name:"subject", text:"主题", width:  "20%",render:subjectRender},
       {type:"hidden", name:"attachId"},
       {type:"data", name:"attach", text:"附件", width: "15%", dataType:"attach"},
       {type:"data", name:"sendTime", text:"发送时间", width: "15%", dataType:"dateTime",format:'yyyy-MM-dd HH:mm'},    
       {type:"data", name:"ensize", text:"大小", width: "8%",dataType:"int",render:mailSizeRender}
       ,{type:"selfdef", width:  "13%",text:"操作", render:optRender},
       {type:"hidden", name:"important"}
       ]
  };
  pageMgr = new YHJsPage(cfgs);
  pageMgr.show();
  var total = pageMgr.pageInfo.totalRecord;
  if(total){
    showCntrl('listContainer');
    showCntrl('optM');
  }else{
    WarningMsrg('未找到符合条件的邮件！', 'msrg');
  }
}
function subjectRender(cellData, recordIndex, columIndex){
  var emailBodyId = this.getCellData(recordIndex,"emailBodyId");
 return "<a href=\"" + contextPath + "/core/funcs/email/sendbox/read_email/index.jsp?isQuery=1&seqId=" + emailBodyId + "\">" + cellData + "</a>";
}
function optRender(cellData, recordIndex, columIndex){
  var emailBodyId = this.getCellData(recordIndex,"emailBodyId");
  var status = mailStatus(emailBodyId,1);
  var html = "";
  var cellDataStr = this.getCellData(recordIndex,"toId").toString();
  if( cellDataStr.indexOf(",") == -1){
    if(status == "2"){
      html += "<A href=\"" + contextPath + "/core/funcs/email/new/index.jsp?resend=1&seqId=" + emailBodyId + "\">编辑</A>&nbsp;"; 
     }
     html += "<A href=\"" + contextPath + "/core/funcs/email/new/index.jsp?resend=1&emailId=" + emailBodyId + "\">再次发送</A>&nbsp;";
     
  }
 return html;
}
</script>
</head>
<body topmargin="5" onload="doInit()">
<table border="0" width="98%"cellspacing="0" cellpadding="3" class="small">
  <tr>
    <td class="Big" height="40px"><img src="<%=imgPath%>/cmp/email/sentbox.gif" WIDTH="20" HEIGHT="20" align="absmiddle">&nbsp;&nbsp;<span class="big3"> 已发送邮件箱  --- 查询结果</span></td>
    </tr>
</table>
<table id="optBar" cellspacing="0" cellpadding="0" border="0" class="controlbar">
  <tr>
    <td class="controlbar-left"></td>
    <td class="controlbar-center">
      <a href="javascript:deleteMail(3);" title="删除所选邮件"><img src="<%=imgPath%>/cmp/email/inbox/delete.gif" align="absMiddle">&nbsp;删除</a>
             <a href="javascript:exportMail();" title="批量导出"><img src="<%=imgPath%>/cmp/email/inbox//xls.gif" align="absMiddle">&nbsp;导出Excel</a>
             <a href="javascript:exportEml();" title="单独导出"><img src="<%=imgPath%>/cmp/email/inbox/eml.gif" align="absMiddle">&nbsp;导出eml</a>
    </td>
    <td class="controlbar-right"></td>
  </tr>
</table>
<br>
<div id="listContainer" style="display:none;width:98%"></div>
<div id="optM"  style="display:none;width:98%">
</div>
<div id="msrg"></div>
<div style="height:5px"></div>
<center><input type="button" class="BigButton" value="返回" onclick="javascript:location='<%=contextPath %>/core/funcs/email/query/index.jsp;'"></center>
</body>
