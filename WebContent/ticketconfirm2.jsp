<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>订单确认</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
.info_p{color:#3c3c3c;margin-top:10px; font-size:14px;}
#confirm_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
#cancel_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
.tip_p{ font-size:12px;color:#3c3c3c;margin-top:10px;}
</style>
</head>
<body>
 <header id="title">
   	订单确认
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section style="width:90%;margin:0 auto;margin-top:15px;">
    <section style=" background:#f0f0f2; border:1px solid #bebfc1; border-radius:10px;padding:10px;">
       <p style="font-weight:bolder;">
        <c:choose>
          <c:when test="${orderform.service.id==1}">
               机场接送
          </c:when>
          <c:when test="${orderform.service.id==2}">
               点到点服务
          </c:when>
          <c:when test="${orderform.service.id==3}">
			   半日/全日租
          </c:when>
          <c:when test="${orderform.service.id==4}">
               郊区包车服务
          </c:when>
        </c:choose>
       </p>
       <p class="info_p">预定车型：${orderform.car.name}</p>
       <p class="info_p">用车时间：${orderform.time}</p>
       <p class="info_p">乘车人数：${orderform.count}人</p>
       <p class="info_p">上车地址：
         <c:choose>
          <c:when test="${(orderform.startAddress==1||orderform.startAddress==2||orderform.startAddress==3)&&orderform.service.id==1}">
                北京首都机场T${orderform.startAddress}航站楼
          </c:when>
          <c:otherwise>
          	${orderform.startAddress }
          </c:otherwise>
         </c:choose>
       		&nbsp;${orderform.extra}</p>
       <c:if test="${fn:length(orderform.extra2)>0}">
          <p class="info_p">航  班  号：${orderform.extra2 }</p>
       </c:if>
       	<c:if test="${fn:length(orderform.extra3)>0}">
			<p class="info_p">航班日期：${orderform.extra3 }</p>
		</c:if>
       <p class="info_p">下车地址：
       	  <c:choose>
          <c:when test="${(orderform.endAddress==1||orderform.endAddress==2||orderform.endAddress==3)&&orderform.service.id==1}">
                北京首都机场T${orderform.endAddress}航站楼
          </c:when>
          <c:otherwise>
          	${orderform.endAddress }
          </c:otherwise>
         </c:choose>
         &nbsp;${orderform.extra1}
       </p>
       <p class="info_p">订单金额：<span style="color:red;font-weight: bolder;">${orderform.price+orderform.extraPrice}</span>元</p>
    </section>
   <div>
    <a id="confirm_a">确认并支付</a>
    <a id="cancel_a" onclick="javascript:location.href='cannelticket.jsp?orderFormId=${orderform.id}'">取消订单</a>
   </div>
   <section style="padding:10px;">
     <p style="color:#304d85;">重要提示：</p>
     <p class="tip_p">1、车辆分配后，系统会以短信通知您。</p>
     <p class="tip_p">2、本公司车辆均为中国大陆地区标准车型。</p>
     <p class="tip_p">3、距离乘车时间1小时内取消订单，收取最低消费。</p>
   </section>
 </section>
</body>
</html>
