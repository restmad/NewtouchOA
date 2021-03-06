<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"></base>    
    <title>涉及产品(供应商详情)</title>
    <link rel="shortcut icon" href="favicon.ico"/>   
	<meta http-equiv="x-ua-compatible" content="ie=EmulateIE7"/>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="crm/css/style.css"/>
	<style type="text/css">
    	body{
			background-color:#FFFFFF
		}
    </style>
    <script type="text/javascript" src="crm/js/prototype.js"></script>
	<script type="text/javascript" src="crm/js/common.js"></script>
    <script type="text/javascript" src="crm/js/sup.js"></script>
    <script type="text/javascript" src="crm/js/formCheck.js"></script>
    <script type="text/javascript">
		//createIfmLoad('ifmLoad');//进度条
		
		function dataMapper(obj){
			var datas,className,dblFunc,dataId;
			dataId = obj.spId;
            var relFunc1 = "descPop('prodAction.do?op=wmsProDesc&wprId="+obj.wmsProduct.wprId+"')";
            var product = "<a href='javascript:void(0)' onClick=\""+relFunc1+"\" >"+obj.wmsProduct.wprName+"</a>";
			var prodPrc=0, cusPrc=0;
			if(obj.wmsProduct.wprSalePrc>0){
				prodPrc = "￥"+changeTwoDecimal(obj.wmsProduct.wprSalePrc)+"&nbsp;<span class='deepGray'>(不含税"+changeTwoDecimal(obj.wmsProduct.wprSalePrc/(1+getSalTaxRate()))+")</span>";
			}
			else{
				prodPrc = "￥"+changeTwoDecimal(prodPrc);
			}
			var hasTax = "&nbsp;"+(obj.spHasTax=="1"?"<span class='deepGreen'>[含税价]</span>":"<span class='blue'>[不含税价]</span>");
			if(obj.spPrice>0){
				cusPrc = changeTwoDecimal(obj.spPrice);
			}
			else{
				cusPrc = changeTwoDecimal(cusPrc);
			}
			var funcCol = "<img onClick=\"parent.supPopDiv(13,"+obj.supplier.supId+","+dataId+")\" class='hand' src='crm/images/content/edit.gif' alt='编辑'/>&nbsp;&nbsp;<img onClick=\"parent.supDelDiv(6,"+dataId+",'1')\" class='hand' src='crm/images/content/del.gif' alt='删除'/>";
			datas = [product,obj.spOtherName,obj.wmsProduct.productUnit?obj.wmsProduct.productUnit.unitName:"" , prodPrc, cusPrc+hasTax, obj.spRemark,funcCol ];
			return [datas,className,dblFunc,dataId];
		}
		function loadList(sortCol,isDe,pageSize,curP){
			var url = "supAction.do";
			var pars = $("searchForm").serialize(true);
			pars.op = "listSupProd";
			pars.supId="${supId}";
			var sortFunc = "loadList";
			var cols=[
				{name:"产品名称",align:"left"},
				{name:"产品别名",align:"left"},
				{name:"单位",isSort:false},
				{name:"标准价格"},
				{name:"客户价格"},
				{name:"备注"},
				{name:"操作",isSort:false}
			];
			gridEl.init(url,pars,cols,sortFunc,sortCol,isDe,pageSize,curP);
			gridEl.loadData(dataMapper);
		}
    	var gridEl = new MGrid("supProd","dataList");
		createProgressBar();
		window.onload=function(){
			//表格内容省略
			loadList();
			createCancelButton(loadList,'searchForm',-50,5,'searButton','after');
		}
	</script>
  </head>
  
  <body>
  	<div class="divWithScroll2 innerIfm">
    	<table class="normal ifmTopTab" cellpadding="0" cellspacing="0">
            <tr>
                <th>产品策略</th>
                <td>
                <a href="javascript:void(0)" onClick="parent.supPopDiv(12,'${supId}');return false;" class="newBlueButton">新建供应商产品</a>
                </td>
            </tr>
        </table>
        <div class="listSearch">
        	<form style="margin:0; padding:0;" id="searchForm" onSubmit="loadList();return false;" >
                产品名称：<input style="width:150px" class="inputSize2 inputBoxAlign" type="text" id="wprName" name="wprName" onBlur="autoShort(this,100)"/>&nbsp;
                <input id="searButton" class="inputBoxAlign butSize3" type="submit" value="查询"/>&nbsp;&nbsp;
            </form>
        </div>
        <div id="dataList" class="dataList"></div>
   		</div>
  </body>
</html>

