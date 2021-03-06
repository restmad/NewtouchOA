<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/inc/header.jsp" %>
<%
  String seqId = request.getParameter("seqId");
  if (seqId == null) {
    seqId = "";
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>设置印章权限</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=cssPath %>/cmp/tab.css" type="text/css" />
<link rel="stylesheet" href = "<%=cssPath%>/cmp/Calendar.css">
<link rel="stylesheet" href = "<%=cssPath%>/style.css">
<link rel="stylesheet" href = "<%=cssPath%>/cmp/tree.css">
<script type="text/javascript" src="<%=contextPath %>/core/js/prototype.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/cmp/tab.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/datastructs.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/sys.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/smartclient.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/orgselect.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/core/js/cmp/Calendarfy.js"></script>
<script type="text/javascript">
var seqId = "<%=seqId%>";

/**
 * 同步公章
 */
function onSysSeal(){
  if(confirmDel()){
    var url = "<%=contextPath%>/yh/subsys/jtgwjh/task/act/YHJhTaskLogAct/sendSynSealOnly.act?type=&reciveDept=" + $("deptStr").value;
    var rtJson = getJsonRs(url);
    if (rtJson.rtState == "0") {
      window.location.reload();
    }else {
      alert(rtJson.rtMsrg); 
    }
  }
}

function confirmDel() {
  if(confirm("确认将同步所选单位公章？")) {
    return true;
  }else {
    return false;
  }
}




/**
 * 获取最近10条同步公章信息
 */
function getLastTask(){
  var url = "<%=contextPath%>/yh/subsys/jtgwjh/task/act/YHJhTaskLogAct/getLastTask.act";
  var rtJson = getJsonRs(url,{sendType:2});
  if (rtJson.rtState == "0") {
    var prcs = rtJson.rtData;
    if(prcs.length > 0){
      var table = new Element('table',{"class":'TableList',"align":"center","width":"90%"}).update("<tbody id='tbody'>"
          +"<tr class='TableHeader'><td>序号</td><td>操作人员</td><td>任务唯一标识</td><td>发送单位</td><td>操作时间</td>"+
          "<td>发送详情</td>"+"</tr>"+
          "</tbody>");
      $("taskList").insert(table);
      prcs.each(function(prc, i) {
        var prc = prcs[i];
        var guid = prc.guid;
        var tr = new Element('tr',{"class":"TableData"});
        $("tbody").insert(tr);
        var td = new Element('td',{"align":"center"}).update(i+1);
        var td2 = new Element('td',{"align":"center"}).update(prc.userName);
        var td7 = new Element('td',{"align":"center"}).update(guid);
        var td3 = new Element('td',{"align":"center"}).update(prc.fromDeptName);
        var td4 = new Element('td',{"align":"center"}).update("全体单位");
        var td5 = new Element('td',{"align":"center"}).update(prc.optTime.substring(0,19));
        
        var info = getCountByGuid(prc.guid,prc.optTime);
        
        var a = new Element('a',{"href":"javascript:void(0)"}).update( info.esbCount +"/" + info.esbCountAll);
        a.onclick = function(){
          toTaskLogInfo(guid,prc.optTime);
        }
    
        var td6 = new Element('td',{"align":"center"});
        td6.insert(a);
        tr.insert(td);
        tr.insert(td2);
        tr.insert(td7);
        tr.insert(td3);
       // tr.insert(td4);
        tr.insert(td5);
        tr.insert(td6);
 
      });
    }else{
      
      var table = new Element('table',{ "class":"MessageBox" ,"align":"center","width":"340" }).update("<tr>"
	        + "<td class='msg info'><div class='content' style='font-size:12pt'>没有同步公章数据!</div></td></tr>"
	        );
       $("Rnull").update(table);
    }
  }else {
    alert(rtJson.rtMsrg); 
  }
   
}

/**
 * 查看详情
 */
function toTaskLogInfo(guid,optTime){
  var url = "<%=contextPath%>/subsys/jtgwjh/setting/taskLog/taskLogInfo.jsp?guid=" + guid + "&optTime=" +optTime;
  var locX=(screen.width-700)/2;
  var locY=(screen.height-500)/2;
  window.open(url, "taskLog", 
      "height=" +500 + ",width=" + 800 +",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes, top=" 
      + locY + ", left=" + locX + ", resizable=yes");
}
/**
 * 获取下载详情
 */
function getCountByGuid(guid,optTime){
  var url = "<%=contextPath%>/yh/subsys/jtgwjh/task/act/YHJhTaskLogAct/getCountByGuid.act";
  var rtJson = getJsonRs(url,{guid:guid,optTime:optTime});
  if (rtJson.rtState == "0") {
    return rtJson.rtData;
  }else {
    alert(rtJson.rtMsrg); 
    return;
  }
}
function doOnload(){
  getLastTask();
}
</script>
</head>
<body topmargin="5" onload="doOnload();">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
  
  <tr>
    <td><img src="<%=imgPath%>/notify_new.gif" align="absmiddle"><span class="big3">&nbsp;选择单位同步</span></td>
    
     <td>
     
       
       <input type="hidden" name="deptStr" id="deptStr" value="">
        <textarea cols=80 name="deptName" id="deptName" rows=8 class="BigStatic" wrap="yes" readonly></textarea>
       <a href="javascript:void(0);" class="orgAdd" onClick="selectOutDept2(['deptStr', 'deptName'])">添加</a>
        <a href="javascript:void(0);" class="orgClear" onClick="$('deptStr').value='';$('deptName').value='';">清空</a>
    
     </td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="button" value="确认同步" class="BigButton" onclick="onSysSeal();">  </td>
  </tr>
</table>

<br></br>
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
  <tr>
    <td class="Big"><img src="<%=imgPath%>/system.gif" align="absmiddle"><span class="big3">&nbsp;最近10次同步公章记录</span>
    </td>
    
    <td class="Big">   </td>
  </tr>
</table>
<br></br>

<div id="taskList">
   
</div>
<div id="Rnull">

</div>


</body>
</html>