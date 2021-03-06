<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-logic"  prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"></base>
    <title>收票记录详情</title>
    <link rel="shortcut icon" href="favicon.ico"/>
    <meta http-equiv="x-ua-compatible" content="ie=EmulateIE7" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="crm/css/style.css"/>
    <style type="text/css">
    	body{
			background-color:#fff;
		}
    </style>
    <script type="text/javascript" src="crm/js/prototype.js"></script>
    <script type="text/javascript" src="crm/js/common.js"></script>
  </head>
  
  <body>
   	<logic:notEmpty name="inv">
    <div class="inputDiv">
        <table class="normal dashTab" style="width:98%" cellpadding="0" cellspacing="0">
        	<tbody>
            	<tr>
                    <th style="vertical-align:top;">开票内容：</th>
                    <td colspan="3">${inv.sinCon}&nbsp;</td>
                </tr>
                <tr>
                    <th class="blue"><nobr>对应采购单：</nobr></th>
                    <td class="blue mlink" colspan="3">
                    	<logic:notEmpty name="inv" property="salPurOrd">
                        <a class="textOverflow" style="width:380px" title="${inv.salPurOrd.spoTil}" href="salPurAction.do?op=spoDesc&spoId=${inv.salPurOrd.spoId}" target="_blank"><img class="imgAlign" src="crm/images/content/showDesc.gif" alt="查看采购单详情" style="border:0px;">${inv.salPurOrd.spoTil}</a></logic:notEmpty>&nbsp;
                    </td>
                </tr>
                <tr>
                    <th>票据类别：</th>
                    <td style="width:40%">${inv.salInvType.typName}&nbsp;</td>
                    <th>发票编号：</th>
                    <td style="width:40%">${inv.sinCode}&nbsp;</td>
                    
                </tr>
                
                <tr>
                    <th>金额：</th>
                    <td colspan="3">￥<bean:write name="inv" property="sinMon" format="###,##0.00"/>&nbsp;</td>
                </tr>
                <tr>
                    <th><nobr>开票日期：</nobr></th>
                    <td><span id="invDate"></span>&nbsp;</td>
                    <th>开票人：</th>
                    <td>${inv.sinResp}&nbsp;</td>
                </tr>
                
                <tr>
                    <th><nobr>是否已付款：</nobr></th>
                    <td>
                        <logic:equal name="inv" property="sinIsPaid" value="1">
                            是
                        </logic:equal> 
                        <logic:equal name="inv" property="sinIsPaid" value="0">
                            否
                        </logic:equal> 
                    </td>
                    <th><nobr>是否有付款计划：</nobr></th>
                    <td>${inv.sinIsPlaned}&nbsp;</td>
                </tr>
                <tr>
                    <th style="vertical-align:top;">备注：</th>
                    <td colspan="3">
                        ${inv.sinRemark}&nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td colspan="4" class="descStamp" style="border-bottom:0px">
                        由
                        <span>${inv.sinUserCode}</span>
                        于
                        <span id="creDate"></span>&nbsp;
                        录入
                        <logic:notEmpty name="inv" property="sinAltUser"><br/>
                        最近由
                        <span class="bold middle">${inv.sinAltUser}</span>
                        于
                        <span id="altDate"></span>&nbsp;
                        修改
                        </logic:notEmpty>
                    </td>
                </tr>
            </tbody>
            <script type="text/javascript">
				removeTime("invDate","${inv.sinDate}",1);
                removeTime("creDate","${inv.sinCreDate}",2)
                removeTime("altDate","${inv.sinAltDate}",2);
            </script>
        </table>
    </div>
    </logic:notEmpty>
	<logic:empty name="inv">
		    <div class="redWarn"><img src="crm/images/content/fail.gif" alt="警告" style="vertical-align:middle"/>&nbsp;该收票记录已被删除</div>
	</logic:empty>
  </body>
</html>
