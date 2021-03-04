<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String back=(String)request.getSession().getAttribute("backurl");
   if(null!=back&&!"".equals(back)){
	   request.getSession().removeAttribute("backurl");
	   response.sendRedirect(back);
   }
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>通途租车</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>
  body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
  .sayhi{ text-align:center; color:#314e86;font-size:18px;margin-top:5px;}
  .kouhao{ border-radius: 10px;
		background:#304e84;color:#FFF; text-align:center;margin-top:10px;padding:5px 0px;}
  .kouhao_e{ text-align:center;font-size:12px;}
  .service{color:#FFF;float:right; font-size:16px;margin-right:20px; line-height:40px;}
  .serviceImg{height:40px;float:left;border:none;width:135px;}
  ul,li{margin:0px;padding:0px;list-style:none;}
  li{float:left; color:#FFF; font-size:16px; text-align: left;}
  a{text-decoration: none;}
  #air{
	  	width:100%;
	  	height:40px;
	  	border-radius: 10px;
		background:#facd1e;
		margin-top:20px;
		line-height:40px;
		font-size:16px;
		color:#FFF;
	  }
 #point{
	width:100%;
	height:40px;
	border-radius: 10px;
	background:#fa9d4a;
	margin-top:20px;
	line-height:40px;
	font-size:16px;
	color:#FFF;
  }
  #date{
	width:100%;
	height:40px;
	border-radius: 10px;
	background:#4cb9f3;
	margin-top:20px;
	line-height:40px;
	font-size:16px;
	color:#FFF;
  }
  #suburb{
	width:100%;
	height:40px;
	border-radius: 10px;
	background:#91cc3d;
	margin-top:20px;
	line-height:40px;
	font-size:16px;
	color:#FFF;
  }
  #meet{
	width:100%;
	height:40px;
	border-radius: 10px;
	background:#88ace6;
	margin-top:20px;
	line-height:40px;
	font-size:16px;
	color:#FFF;
  }
  #foot{ text-align:center; color:#FFF; line-height:30px;}
  #title{ background:#304d85; width:100%;height:40px;padding:3px 0px;text-align:center; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#logoHome{margin-left:15px;float:left;margin-top:10px;float:left;width:82px;height:22px;}
a{color: #FFF;text-decoration: none;}
 .more{ clear:both;color:#FFF;font-size:16px;margin-top:30px; display:block;}
 .more a{ color:#FFF; text-decoration:none;}
</style>
</head>
<body>
 <header id="title">
    <img src="images/logo.png" id="logoHome"/>
    <section style="float:right;height:40px;margin:0px;padding:0px;">
      <div style="font-size:14px;margin:0px;padding:0px;height:20px; font-size:16px;margin-right:25px;">北京通途汽车租赁</div>
      <div style="font-size:12px;margin:0px;padding:0px;height:15px;margin-top:0px;margin-right:25px; text-align:right;">www.tutucar.com</div>
    </section>
 </header>
  <section style="width:90%;margin-left:auto;margin-right:auto;">
     <p class="sayhi">通途租车 祝您一路通达旅途愉快！</p>
     <p class="kouhao">7*24小时服务  满足您的一切用车服务 ！</p>
     <p class="kouhao_e">7 * 24 hours service satisfy all the car service for you!</p>
  </section>
  <section style="width:90%;margin-left:auto;margin-right:auto;">
   <article id="air">
    <a href="airservice.jsp">
      <img src="images/air.png" class="serviceImg" />
   	  <p class="service">机场接送服务 ></p>
    </a>
   </article>
   <article id="point">
    <a href="pointservice.jsp">
    <img src="images/point.png" class="serviceImg" />
    <p class="service">点到点服务 ></p>
    </a>
   </article>
   <article id="date">
    <a href="dateservice.jsp">
    <img src="images/date.png" class="serviceImg" />
    <p class="service">半日/全日租 ></p>
    </a>
   </article>
   <article id="suburb">
    <a href="suburbservice.jsp">
    <img src="images/suburb.png" class="serviceImg" />
    <p class="service">郊区包车服务 ></p>
    </a>
   </article>
   <article id="meet">
    <a href="meetservice.jsp">
    <img src="images/meet.png" class="serviceImg" />
    <p class="service">会议及长租服务 ></p>
    </a>
   </article>
  </section>
  <section style="width:100%;margin-left:auto;margin-right:auto;background:#314e86;height:60px;margin-top:20px;padding-top:10px;">
    <ul>
   	  <li style="width:10%;">&nbsp;</li>
      <li style="width:15%;">
      <c:if test="${null!=tu_user}">
      	  <a href="userAction!logout">退出</a>
      </c:if>
      <c:if test="${null==tu_user}">
         <a href="login.jsp">登陆</a>
      </c:if>
      </li>
      <li style="width:25%;">
      <c:if test="${null!=tu_user}">
      	  <a href="userAction!detail">用户中心</a>
      </c:if>
      <c:if test="${null==tu_user}">
         <a href="register.jsp">免费注册</a>
      </c:if>
      </li>
      <li style="width:25%;"><a href="serviceinfo.html">服务介绍</a></li>
      <li style="width:25%;"><a href="http://www.tutucar.com/invitation/">关于通途</a></li>
    </ul>
     <p class="more"><span style="width:10%;display:block;height:20px;float:left;"></span>更多咨询请拨打：<a href="tel:86-10-6538 0036">86-10-6538 0036</a></p>
  </section>
  <section style="width:100%;margin-left:auto;margin-right:auto; background:#696464;height:30px;" >
    <p id="foot">Copyright  2014通途租赁</p>
  </section>
</body>
</html>
