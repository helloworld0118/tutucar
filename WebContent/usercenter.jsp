<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>用户中心</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#ticketdetailContent{width:90%;margin:20px auto;background:#ebe9e9; border:1px solid #496394; border-radius:5px;}
a{ text-decoration:none;color:#FFF; text-align:center;}
.userinfo_p{ font-size:14px;color:#b0aaa8;margin-top:4px;}
.info_p{color:#3c3c3c;margin-top:10px; font-size:14px;}

</style>
</head>

<body>
<header id="title">
   	用户中心
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="ticketdetailContent">
   <section style="margin:3px;background:#FFF; border-radius:4px;height:auto;">
     <section style="background:#304d85; border-radius:4px;height:50px;padding-top:15px;">
         <p style="float:left; display:block;text-align:left;color:#FFF;line-height:30px;padding-left:20px; font-size:18px;">${user.username}</p>
         <a style="float:left; color:#000; display:block;margin-left:15px;background:#ffd44f; border-radius:6px;padding:5px 10px;"href="#">${user.group.groupName}</a>
         <span style="color:#FFF;font-size:12px;margin-left:10px; line-height:30px;">积分：${user.score}</span>
    </section>
    <section style="height:auto;padding-top:10px;padding-left:30px;padding-bottom:15px;">
      <p class="userinfo_p">手机号</p>
      <p class="userinfo_p">${user.phone}</p>
       <c:if test="${fn:length(user.email)>0}">
        <p class="userinfo_p">电子邮件</p>
      <p class="userinfo_p">${user.email}</p>
      </c:if>
      <c:if test="${fn:length(user.cemail)>0}">
        <p class="userinfo_p">备用电子邮件</p>
        <p class="userinfo_p"></p> 
      </c:if>
      <p class="userinfo_p">证件号码</p>
      <p class="userinfo_p">${user.cardNum}</p> 
    </section>
   </section>
   <section style="margin-top:20px;">
     <p style="color:#818283;margin-left:10px;">您的通途订单：</p>
       <c:if test="${fn:length(orderFormList)==0}">
           <p style="color:red;text-align: center;margin-bottom:10px;"> 您还没有任何订单噢，赶紧去一下单吧！</p>
       </c:if>
       <c:if test="${fn:length(orderFormList)>0}">
           <c:forEach var="orderform" items="${orderFormList}">
            <section style="margin:0 auto;">
		       	 <section style="margin:8px 3px;background:#ffffff; border:1px solid #3a5485; border-radius:10px;padding:10px;">
		           <p style="font-weight:bolder; color:#304d85;">订单号：${orderform.code}</p>
		            <section>												
		              <section style="width:60%;float:left; height:90px;">
		              		<c:if test="${orderform.service.id<=5}">
		                   		<p class="info_p">预定车型：${orderform.car.name}</p>
		                    </c:if>
		                   <c:if test="${orderform.service.id>5}">
		                   		<p class="info_p">预定车型：无</p>
		                    </c:if>
		                   <p class="info_p">订单类型：
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
					               郊区包车
					          </c:when>
					           <c:when test="${orderform.service.id==5}">
					               郊区包车
					          </c:when>
					           <c:when test="${orderform.service.id==6}">
					               会议用车
					          </c:when>
					          <c:when test="${orderform.service.id==7}">
					               长租服务
					          </c:when>
					        </c:choose>
		                   </p>
		                   <c:if test="${orderform.service.id<=5}">
		                   		<p class="info_p">结算方式：在线支付</p>
		                   </c:if>
		                    <c:if test="${orderform.service.id>5}">
		                   		<p class="info_p">结算方式：线下支付</p>
		                   </c:if>
		              </section>
		             <c:choose>
		               <c:when test="${orderform.state==0||orderform.state==2}">
		                  <section style="font-size:20px; color:red;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2confirm?id=${orderform.id}'">待支付&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		                <c:when test="${orderform.state==1}">
		                  <section style="font-size:20px; color:green;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2detail?id=${orderform.id}'">已取消&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		               <c:when test="${orderform.state==3}">
		                  <section style="font-size:20px; color:green;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                     <span onclick="location.href='orderFormAction!go2detail?id=${orderform.id}'">已支付&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		                <c:when test="${orderform.state==4}">
		                  <section style="font-size:20px; color:red;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2evaluation?id=${orderform.id}'">待评价&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		               <c:when test="${orderform.state==5}">
		                  <section style="font-size:20px; color:green;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2detail?id=${orderform.id}'">已评价&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		                <c:when test="${orderform.state==6}">
		                  <section style="font-size:20px; color:red;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2detail?id=${orderform.id}'">待受理&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		                <c:when test="${orderform.state==7}">
		                  <section style="font-size:20px; color:green;height:90px; line-height:90px; text-align:right; style="width:40%;float:left;"">
		                    <span onclick="location.href='orderFormAction!go2detail?id=${orderform.id}'">已受理&nbsp;&nbsp;&nbsp;></span>
		             	 </section>
		               </c:when>
		             </c:choose>
		            </section>
		        </section>
	    	 </section>
           </c:forEach>
       </c:if>
   </section>
 </section>
</body>
</html>
