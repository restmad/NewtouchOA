<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-logic"  prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	//清缓存
	response.setHeader("Pragma","No-cache");   
	response.setHeader("Cache-Control","no-cache");   
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"></base>
    <title>入库单列表</title>
    <link rel="shortcut icon" href="favicon.ico"/>
	<meta http-equiv="x-ua-compatible" content="ie=EmulateIE7" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link rel="stylesheet" type="text/css" href="crm/css/style.css"/>
	<script type="text/javascript" src="crm/js/prototype.js"></script>
    <script type="text/javascript" src="crm/js/formCheck.js"></script>
	<script type="text/javascript" src="crm/js/common.js"></script>
    <script type="text/javascript" src="crm/sup/sup.js"></script>
  	<script language="javascript" type="crm/text/javascript">
		function dataMapper(obj){
			var datas,className,dblFunc,dataId;
			dataId = obj.pinId;
			dblFunc="descPop('supAction.do?op=toDescProdIn&pinId="+dataId+"')";
			var state = "";
			var pinCode="<a href='javascript:void(0)' onClick=\""+dblFunc+"\">"+obj.pinCode+"</a>";
			var funcCol = "<img src='crm/images/content/detail.gif' onClick=\""+dblFunc+"\" class='hand' alt='查看详细'/>&nbsp;&nbsp;<img style='cursor:pointer' src='crm/images/content/edit.gif' onClick=\"supPopDiv(8,"+dataId+")\"  alt='编辑'/>";
			if(obj.pinState == "0"){
				state = "已撤销";
				funcCol += "&nbsp;&nbsp;<img onClick=\"supDelDiv(4,"+dataId+")\"  style='cursor:pointer' src='crm/images/content/del.gif' alt='删除'/>";
			}else{
				state = "已入库";
				funcCol +="&nbsp;&nbsp;<img onClick=\"supCancleDiv(1,"+dataId+")\"  style='cursor:pointer' src='crm/images/content/cancel.gif' alt='撤销'/>";
			}
			datas = [pinCode, obj.purOrd?obj.purOrd.puoCode:"", obj.pinRespMan, obj.pinDate,state, obj.pinInNum,obj.pinRemark, funcCol ];
			return [datas,className,dblFunc,dataId];
		}
		function loadList(sortCol,isDe,pageSize,curP){
			var url = "supAction.do";
			var pars = $("searchForm").serialize(true);
			pars.op = "listProdIn";
			var loadFunc = "loadList";
			var cols=[
				{name:"入库单号",align:"left"},
				{name:"采购单",align:"left"},
				{name:"经手人"},
				{name:"入库日期",renderer:"date"},
				{name:"入库状态"},
				{name:"入库数量"},
				{name:"备注",isSort:false},
				{name:"操作",isSort:false}
			];
			gridEl.init(url,pars,cols,loadFunc,sortCol,isDe,pageSize,curP);
			gridEl.loadData(dataMapper);
		}
    	var gridEl = new MGrid("prodInTab","dataList");
    	gridEl.config.hasCheckBox = true;
		createProgressBar();
		window.onload=function(){
			loadList();
			//增加清空按钮
			createCancelButton(loadList,'searchForm',-50,5,'searButton','after');
		}
  	</script>
  </head>
  
  <body>
    <div id="mainbox">
    	<div id="contentbox">
        	<div id="title"><a class="refreshButton" href="javascript:void(0)" onClick="self.history.go(0)" title="重新载入页面"></a>&nbsp;采购管理 > 入库单</div>
  	   		<table class="mainTab" cellpadding="0" cellspacing="0">
                <tr>
                    <th>
                        <div id="tabType"><div id="tabType1" class="tabTypeWhite" onClick="self.location.href='supAction.do?op=toListProdIn'">入库单</div></div>
                    </th>
                    <td>
                    	<a href="javascript:void(0)"  onClick="supPopDiv(7);return false;" class="newBlueButton">新建入库单</a>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">loadTabTypeWidth();</script>
            <div id="listContent">
             	<div class="listSearch">
                	<form style="margin:0; padding:0;" id="searchForm" onSubmit="loadList();return false;" >
                        商品名称：<input class="inputSize2 inputBoxAlign" type="text" name="wprName" onBlur="autoShort(this,100)"/>&nbsp;&nbsp;&nbsp;
                        仓库：<c:if test="${!empty typList}">
                      			<select name="storeType" class="inputBoxAlign inputSize2" style="width:100px;">
	                      			<option value="">请选择</option>
	                      			<c:forEach var="storeType" items="${typList}">
	                      				<option value="${storeType.typId}">${storeType.typName}</option>
	                      			</c:forEach>
                      			</select>
                      	     </c:if>
                      	     <c:if test="${empty typList}">
                      	        <select id="storeType" class="inputBoxAlign"  disabled>
                             		<option value="">未添加</option>
                             	</select>
                      	     </c:if>&nbsp;
                         <input type="submit" class="butSize3 inputBoxAlign" id="searButton" value="查询" />&nbsp;&nbsp;
                    </form>
                </div>
                <div id="dataList" class="dataList" ></div>
            </div>
  		</div> 
	</div>
  </body>
</html>
