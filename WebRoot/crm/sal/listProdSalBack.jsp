<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"></base>    
    <title>提成率</title>
    <link rel="shortcut icon" href="favicon.ico"/>   
	<meta http-equiv="x-ua-compatible" content="ie=EmulateIE7"/>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="crm/css/style.css"/>

    <script type="text/javascript" src="crm/js/prototype.js"></script>
	<script type="text/javascript" src="crm/js/common.js"></script>
    <script type="text/javascript" src="crm/js/sal.js"></script>
    <script type="text/javascript">
    	function dataMapper(obj){
			var datas,className,dblFunc,dataId;
			var funcCol = "<img class='imgAlign' onClick=\"parent.ordPopDiv(55,'"+obj.psbId+"','${prodId}')\" src='crm/images/content/edit.gif' style='cursor:pointer' alt='编辑'/>&nbsp;&nbsp;<img class='imgAlign' onclick=\"parent.ordDelDiv(10,"+obj.psbId+",'1')\" src='crm/images/content/del.gif' style='cursor:pointer' alt='删除'/>";
			datas = [ obj.psbPrice, obj.psbRate, funcCol ];
			return [datas,className,dblFunc,dataId];
		}
		function loadList(sortCol,isDe,pageSize,curP){
			var url = "prodAction.do";
			var pars = [];
			pars.op = "listProdSalBack";
			pars.prodId="${prodId}";
			
			var loadFunc = "loadList";
			var cols=[
				{name:"单价",renderer:"money",align:"right"},
				{name:"提成率"},
				{name:"操作",isSort:false}
			];
			gridEl.init(url,pars,cols,loadFunc,sortCol,isDe,pageSize,curP);
			gridEl.loadData(dataMapper);
		}
		
    	var gridEl = new MGrid("prodSalBackListTab","dataList");
		createProgressBar();
		window.onload=function(){
			//表格内容省略
			loadList();
		}
	</script>
  </head>
  
  <body>
  	<div class="divWithScroll2 innerIfm">
		<table class="normal ifmTopTab" cellpadding="0" cellspacing="0">
            <tr>
                <th>未达标提成率</th>
                <td><a href="javascript:void(0)" class="newBlueButton"  onClick="parent.ordPopDiv(54,'${prodId}');return false;">新建提成率</a></td>
            </tr>
        </table>
        <div id="dataList" class="dataList"></div>
   </div>
  </body>

</html>
