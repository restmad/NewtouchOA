<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/core/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频会议</title>
<link rel="stylesheet" href = "<%=cssPath%>/style.css">
<link rel="stylesheet" href="<%=cssPath%>/page.css">
<style>
.pgPanel {
  display:none;
}
</style>
<script type="text/javascript" src="<%=contextPath %>/core/js/prototype.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/datastructs.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/sys.js"></script>
<script type="text/javascript" src="<%=contextPath %>/core/js/smartclient.js"></script>
<script type="text/javascript" src="<%=contextPath%>/core/js/cmp/page.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/cmp/select.js" ></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/orgselect.js" ></script>
<script type="text/javascript"  src="<%=contextPath%>/core/js/cmp/Menu.js"></script>
<script type="text/javascript"  src="<%=contextPath%>/core/js/cmp/attachMenu.js"></script>
<script type="text/javascript" src="<%=contextPath %>/subsys/oa/netmeeting/video/js/util.js"></script>
<script> 
var pageMgr = null;
function doInit(){
  var url = "<%=contextPath%>/yh/subsys/oa/netmeeting/video/act/YHVideoMeetingAct/checkUser.act";
  var json = getJsonRs(url);
  if(json.rtState == "0"){
    var data = json.rtData;
    if(data.state == 1){
    	getMeeting()
    }
    else if(data.state == 0){
      window.location.href = "<%=contextPath %>/subsys/oa/netmeeting/video/manage/check.jsp";
    }
    else if(data.state == 2){
      window.location.href = "<%=contextPath %>/subsys/oa/netmeeting/video/manage/error.jsp";
    }
  } else{
    alert("视频会议系统配置失败！");
  }
}

function getMeeting(){
  var url = "<%=contextPath%>/yh/subsys/oa/netmeeting/video/act/YHVideoMeetingAct/getVideoMeetingListInfo.act";
  var cfgs = {
    dataAction: url,
    container: "listContainer",
    colums: [
       {type:"data", name:"confKey",  width: '8%', text:"会议号" ,align: 'center' },
       {type:"data", name:"confType",  width: '8%', text:"会议类型" ,align: 'center' ,render:conferenceType},
       {type:"data", name:"duringTime",  width: '10%', text:"持续时间" ,align: 'center' ,render:duringTime},
       {type:"data", name:"hostName",  width: '10%', text:"主持人" ,align: 'center' },
       {type:"data", name:"startTime",  width: '15%', text:"开始时间" ,align: 'center' ,render:stringTime},
       {type:"data", name:"endTime",  width: '15%', text:"结束时间" ,align: 'center' ,render:stringTime},
       {type:"data", name:"status",  width: '8%', text:"会议状态" ,align: 'center' ,render:conferenceStatus},
       {type:"data", name:"subject",  width: '15%', text:"会议主题" ,align: 'center' },
       {type:"hidden", name:"attendees",  width: '15%', text:"参与人" ,align: 'center' },
       {type:"selfdef", text:"操作", width: '15%',render:opts}]
  };
  pageMgr = new YHJsPage(cfgs);
  pageMgr.show();
  var total = pageMgr.pageInfo.totalRecord;
  if(total){
    showCntrl('listContainer');
    var mrs = " 共 " + total + " 条记录 ！";
    showCntrl('delOpt');
  }else{
    WarningMsrg('没有进行中的视频会议', 'msrg');
  }
}

function conferenceType(cellData, recordIndex, columIndex){
  switch(cellData){
    case '0' : return "预约会议";
    case '1' : return "即时会议";
    case '2' : return "固定会议";
    case '3' : return " 周期会议";
  }
}

function duringTime(cellData, recordIndex, columIndex){
	var hour = ((cellData/60) + ".0");
	hour = hour.split(".")[0]; 
	var min = cellData%60;
	if(hour < 1){
		return min + "分钟";
	}
	if(min == 0){
		return hour + "小时";
	}
	return hour + "小时" + min + "分钟";
}

function stringTime(cellData, recordIndex, columIndex){
  return cellData.replace("T"," ");
}

function conferenceStatus(cellData, recordIndex, columIndex){
  switch(cellData){
    case '0' : return "未开始";
    case '1' : return "已开始";
    case '2' : return "已结束";
  }
}

function opts(cellData, recordIndex, columIndex){
	var confKey = this.getCellData(recordIndex,"confKey");
	var status = this.getCellData(recordIndex,"status");
	var temp = "";
	if(status == 1){
		 temp = "<center>" + "<a href=javascript:joinSingle(" + recordIndex + ")>加入</a>&nbsp;";
	}
  return temp;
}

function joinSingle(recordIndex){
	var confKey = pageMgr.getCellData(recordIndex,"confKey");
	$('listContainer').style.display = "none";
	$('confKey').value= confKey;
	$('form1').style.display = "";
  return;
}

function back(){
  $('listContainer').style.display = "";
  $('confKey').value= "";
  $('form1').style.display = "none";
}

function formSubmit(){
  var url = "<%=contextPath%>/yh/subsys/oa/netmeeting/video/act/YHVideoMeetingAct/doJoinVideoMeeting.act?confKey=" + $('confKey').value + "&password=" + $('password').value;
  var json = getJsonRs(url);
  if(json.rtState == "0"){
    var data = json.rtData;
    if(data.ciURL){
      var meetingURL = data.ciURL + "?siteId=1&dt=GMT";;
      $('form1').action = meetingURL;
      $('form1').target ="_blank";
      $('token').value = data.token;
      $('form1').submit();
    }
    else{
      alert(data.error);
    }
  } else{
    alert("加入会议失败！");
  }
}
</script>
</head>
<body topmargin="5" onload="doInit()">
<br><br>
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
 <tr>
   <td class="Big"><img src="<%=imgPath%>/notify.gif" align="absMiddle" width="17"><span class="big3">&nbsp;邀请您参加的视频会议    </span>
   </td>
 </tr>
</table>
<div id="listContainer" style="display:none;width:100;">
</div>
<div id="delOpt" style="display:none">
<table class="TableList" width="100%">
</table>
</div><p><br>
<div id="msrg">
</div>
<form action="" method="post" id="form1" name="form1" style="display:none">
<table class="TableBlock" width="40%" align="center">
  <tr>
    <td align="left" width="80" class="TableContent">会议密码：<font color="red">*</font></td>
    <td align="left" class="TableData" width="180">
      <input type="password" id="password" name="password" >
      <input type="hidden" id="confKey" name="confKey" >
    </td>
  </tr>
  <tr align="center" class="TableControl">
    <td colspan="2">
      <input type="button" value="确定" class="BigButton" onClick="formSubmit()" >
      <input type="button" value="返回" class="BigButton" onClick="back()">
    </td>
  </tr>
</table>
<input type="hidden" id="token" name="token">
</form>
</body>
</html>