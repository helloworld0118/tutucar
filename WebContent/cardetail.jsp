<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>查看车型</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="css/main.css" type="text/css" media="screen" charset="utf-8" />
<style>
  body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
  .sayhi{ text-align:center; color:#314e86;font-size:18px;margin-top:5px;}
  .kouhao{ border-radius: 10px;
		background:#304e84;color:#FFF; text-align:center;margin-top:10px;padding:5px 0px;}
  .kouhao_e{ text-align:center;font-size:12px;}
  .service{color:#FFF;float:right; font-size:16px;margin-right:20px; line-height:40px;}
  .serviceImg{height:40px;float:left;}
  ul,li{margin:0px;padding:0px;list-style:none;}
  li{float:left; color:#FFF; font-size:16px;margin-left:15px;}
  .more{ clear:both;color:#FFF;font-size:16px;margin-left:35px;margin-top:30px; display:block;}
  .more a{ color:#FFF; text-decoration:none;}
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
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
</style>
</head>
<body>
 <header id="title">
   	选择车型
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
  <section style="width:90%;margin-left:auto;margin-right:auto;">
     <p class="sayhi">通途租车 祝您一路通达旅途愉快！</p>
     <p class="kouhao">7*24小时服务  满足您的一切用车服务 ！</p>
     <p class="kouhao_e">7 * 24 hours service satisfy all the car service for you!</p>
  </section>
  <section style="width:90%;margin-left:auto;margin-right:auto;padding-top:10px;">
    <p style="font-size:14px;"><span style="font-weight:bolder;font-size:16px;">${car.type}</span></p>
    <div style="background:#304d85; border-radius:5px;height:40px;width:100%;font-size:18px;color:#FFF;  text-align:center; line-height:40px;">${car.name}</div>
    <section style="border:1px solid #304d85; border-radius:5px;height:auto;width:100%;margin-top:3px; text-align:center; color:#303537">
      <div style="margin:3px;"><img src="images/car01.png" style="max-width:370px;width:100%;" /></div>
      <div style="margin-left:10px;height:30px; text-align:left;padding-left:0px;">
	      <span style="margin-left:0px; display:block; float:left;">${car.name}</span>
	      <span style="margin-left:15px; display:block;float:left;">${car.description}</span>
	      <span style="margin-left:15px; display:block;float:left;">乘坐${car.loadCount}人</span>
      </div>
      <div style="margin-left:10px;height:100px; text-align:left;">
        <p>报价：¥${price.price}元起</p>
        <p style="margin-left:50px;">超公里：${price.kmoutPrice}元/公里</p>
        <p style="margin-left:50px;">超小时：${price.timeoutPrice}元/小时</p>
        <p>	
           <div style="width:50px;float:right;margin-right:20px;">
           	 <div class="clean-button">
					<span class="text"><a href="orderFormAction!save?carid=${car.id}&price=${price.price}">租车</a></span>
			</div>
           </div>
        </p>
      </div>
    </section>
  </section>
</body>
</html>
