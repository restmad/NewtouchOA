<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件字管理</title>
<link rel="stylesheet" href="<%=cssPath%>/cmp/tab.css" type="text/css" />
<link rel="stylesheet" href="<%=cssPath%>/style.css">
<script type="text/Javascript" src="<%=contextPath%>/core/js/datastructs.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/sys.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/prototype.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/smartclient.js"></script>
<script type="text/Javascript" src="<%=contextPath%>/core/js/cmp/select.js"></script>
<script type="text/javascript" src="<%=contextPath%>/core/js/cmp/tab.js"></script>
<script type="text/javascript">
  var jso = [
           {title:"文件字管理", contentUrl:"<%=contextPath%>/core/funcs/workflow/flowrun/docword/manage.jsp", imgUrl: "<%=imgPath%>/notify_new.gif", useIframe:true}
          ,{title:"新建文件字", contentUrl:"<%=contextPath%>/core/funcs/workflow/flowrun/docword/new.jsp", imgUrl: "<%=imgPath%>/notify_new.gif", useIframe:true}
          ,{title:"文件字查询", contentUrl:"<%=contextPath%>/core/funcs/workflow/flowrun/docword/query.jsp", imgUrl: "<%=imgPath%>/notify_new.gif", useIframe:true}
           ];
</script>
</head>
<body class="bodycolor" topmargin="5" onLoad="buildTab(jso, 'smsdiv', 800);">
</body>
</html>
