<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>订单详情</title>
<style>
body,p {
	margin: 0px;
	padding: 0px;
	font-family: "微软雅黑";
	font-size: 16px;
}

img {
	border: none;
}

#title {
	background: #304d85;
	width: 100%;
	height: 40px;
	padding: 3px 0px;
	text-align: center;
	line-height: 40px;
	font-size: 18px;
	color: #FFF
}

#telImg {
	float: right;
	margin-right: 15px;
}

#homeImg {
	float: right;
	margin-top: 5px;
	margin-right: 15px;
}

#backImg {
	margin-left: 10px;
	float: left;
}

#ticketdetailContent {
	width: 90%;
	margin: 20px auto;
	background: #ebe9e9;
	border: 1px solid #496394;
	border-radius: 5px;
}

a {
	text-decoration: none;
	color: #FFF;
	text-align: center;
}

.ticket_p {
	font-size: 14px;
	color: #b0aaa8;
	margin-top: 10px;
}

.info_p {
	color: #3c3c3c;
	margin-top: 10px;
	font-size: 14px;
	padding-left:15px;
}
</style>
</head>

<body>
	<header id="title">
		订单详情 <a href="javascript:history.back()"><img
			src="images/back.png" id="backImg" /></a> <a href="#"><img
			src="images/home.png" id="homeImg" /></a> <a href="tel:86-10-6538 0036"><img
			src="images/tel.png" id="telImg" /></a>
	</header>
	<section id="ticketdetailContent">
		<section
			style="margin: 3px; background: #FFF; border-radius: 4px; height: auto;">
			<section
				style="background: #304d85; border-radius: 4px; height: 50px; padding-top: 15px;">
					<c:choose>
					  <c:when test="${orderform.state==0||orderform.state==2}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     待支付</p>
					  </c:when>
					  <c:when test="${orderform.state==1}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     已取消</p>
					  </c:when>	
					  <c:when test="${orderform.state==3}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     已支付</p>
					  </c:when>	
					  <c:when test="${orderform.state==4}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     待评价</p>
					  </c:when>	
					  <c:when test="${orderform.state==5}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     已评价</p>
					  </c:when>	
					   <c:when test="${orderform.state==6}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     待受理</p>
					  </c:when>	
					   <c:when test="${orderform.state==7}">
					 	 <p style="float: left; display: block; text-align: center; width: 65%; color: #FFF; line-height: 30px; font-size: 18px;">订单状态：
					     已受理</p>
					  </c:when>	
					</c:choose>
				<c:if test="${orderform.state==4}">
					<a style="float: left; display: block; width: 25%; background: #000; border-radius: 6px; padding: 5px;"
					href="#">服务评价</a>
				</c:if>
			</section>
			<section style="height: auto; padding-top:2px; padding-bottom:15px;padding-left: 30px;">
				<p class="ticket_p">订 单 号：${orderform.code}</p>
				<p class="ticket_p">会员级别：${tu_user.group.groupName }</p>
				<c:if test="${orderform.service.id<=5}">
					<p class="ticket_p">结算方式：在线支付</p>
				</c:if>
				<c:if test="${orderform.service.id>5}">
					<p class="ticket_p">结算方式：线下支付</p>
				</c:if>
			</section>
		</section>
		<section style="margin-top: 20px;">
			<p style="color: #818283; margin-left: 10px;">您的预定详情：</p>
			<section style="margin: 0 auto;">
				<section
					style="margin: 8px 3px; background: #ffffff; border: 1px solid #304d85; border-radius: 10px; padding: 10px;">
					<c:if test="${orderform.service.id<=5}">
						<p style="font-weight: bolder;">
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
						<p class="info_p">
							上车地址：
							<c:choose>
								<c:when
									test="${(orderform.startAddress==1||orderform.startAddress==2||orderform.startAddress==3)&&orderform.service.id==1}">
			                北京首都机场T${orderform.startAddress}航站楼
			          </c:when>
								<c:otherwise>
			          	${orderform.startAddress }
			          </c:otherwise>
							</c:choose>
							&nbsp;${orderform.extra}
						</p>
						<c:if test="${fn:length(orderform.extra2)>0}">
							<p class="info_p">航 班 号：${orderform.extra2 }</p>
						</c:if>
						<c:if test="${fn:length(orderform.extra3)>0}">
							<p class="info_p">航班日期：${orderform.extra3 }</p>
						</c:if>
						<p class="info_p">
							下车地址：
							<c:choose>
								<c:when
									test="${(orderform.endAddress==1||orderform.endAddress==2||orderform.endAddress==3)&&orderform.service.id==1}">
			                北京首都机场T${orderform.endAddress}航站楼
			          </c:when>
								<c:otherwise>
			          	${orderform.endAddress }
			          </c:otherwise>
							</c:choose>
							&nbsp;${orderform.extra1}
						</p>
						<p class="info_p">订单金额：${orderform.price+orderform.extraPrice}元</p>
					</c:if>
					<c:if test="${orderform.service.id>5}">
						<p class="info_p">用车时间:${orderform.time }</p>
						<p class="info_p">乘车人数:${orderform.count }</p>
						<p class="info_p">联  系  人:${orderform.user.username }</p>
						<p class="info_p">联系方式:${orderform.user.phone}</p>
					</c:if>
				</section>
			</section>
		</section>
	</section>
</body>
</html>
