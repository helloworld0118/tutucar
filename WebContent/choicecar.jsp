<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>选择车型</title> 
<link rel="stylesheet" href="css/main.css" type="text/css" media="screen" charset="utf-8" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">	
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
input{
       border-radius:5px;
	   height:25px;
	   width:40%;
	   margin-left:auto;
	   margin-right:auto;
	   display:block;
	   padding-left:5px;
       border:1px solid #b5b5b5;
       -webkit-transition: box-shadow 0.30s ease-in-out;   
       -moz-transition:  box-shadow 0.30s ease-in-out;     
	   color:#bcb8b6;
	   font-size:14px;
	   float:left;
 }
span a{color:#000}
 span a:HOVER{color:#FFF};
input:focus{
 border:#87C6F9 1px solid;
 box-shadow: 0 0 8px rgba(103, 166, 217, 1);
 color:#000;
}
label{float:left;margin-top:19px;width:90%;font-size:14px;color:#303537; text-align:center;padding-left:8px;color:#FFF;}
#choicecarContent{ width:90%;margin:0 auto;padding:5px;height:auto;border-radius:7px;background:#ebeae8; border:1px solid #97a6c2; margin-top:20px;}
#choicetip{color:#303537;font-size:14px;margin-top:20px;padding-left:5px;}
#choiceDeail{ border:1px solid #304d85;height:auto;border-radius:5px;margin-top:5px;background:#FFF;}
.carname{color:#475e8f;font-size:14px;padding-left:10px;padding-top:5px;}
.cardes1{color:#bab7b2;font-size:12px;padding-left:10px;margin-top:5px;}
.cardes2{color:#bab7b2;font-size:12px;padding-left:10px;margin-top:2px;}
.carPrice{color:#304d85; font-weight:bolder;font-size:20px;}
  ul,li{margin:0px;padding:0px;list-style:none;width:100%;}
  li{float:left; width:25px;width:25%;height:25px; font-size:14px;}
</style>
</head>
<body>
 <header id="title">
   	选择车型
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="choicecarContent">
   <section style="height:60px;background:#304d85;border-radius:6px;">
     <label style="float:left;">您要用车的地区：北京市区(五环内)</label>
   </section>
    <p id="choicetip">选择您要使用的车型：</p>
    <section id="choiceDeail">
        <c:forEach items="${carprices}" var="model">
         <article style="padding-top:10px;">
            <header style="height:30px;background:#304d85;color:#FFF;width:70%;padding-left:5px;line-height:30px;">
               ${model.type}
            </header>
               <c:forEach items="${model.prices}" var="price"  varStatus="status">
	              <section style="height:67px;">
	              <div style="width:45%;float:left;">
	                 <p class="carname"><a href="carAction!detail?id=${price.car.id}&price.price=${price.price}&price.kmoutPrice=${price.kmoutPrice}&price.timeoutPrice=${price.timeoutPrice}">${price.car.name }</a></p>
	                 <p class="cardes1">超公里： ${price.kmoutPrice}元/公里 </p>
	                 <p class="cardes2">超小时： ${price.timeoutPrice}元/小时</p>
	              </div>
	              <div style="width:30%;float:left;color:#55595b; text-align:right;margin-top:30px;">
	                <p class=""><span class="carPrice">${price.price}</span>元起</p>
	              </div>
	              <div style="width:25%;float:left;text-align:center;margin-top:30px;">
	               	<div class="clean-button">
						<span class="text"><a href="orderFormAction!save?carid=${price.car.id}&price=${price.price}">租车</a></span>
					</div>
	              </div>
	             </section>      
	             <c:if test="${status.count!=fn:length(model.prices)}">
	             	 <hr style="border:.1px dotted;width:98%;padding:0px;margin:0px;clear:both;margin-top:10px;" color="#304d85">
	             </c:if>
              </c:forEach>
        	</article>
        </c:forEach>
    </section>
  </section>
  <a href="#" id="error_a" style="display:none;" data-error-id="errorDiv"></a>
   <div class="reveal-error" id="errorDiv" style="width:200px;height:80px;">
     <p id="errorcontent_p" style="color:red;margin-top:20px;">没有符合条件的车辆，请联系客服帮您购车</p>
     <a class="close-reveal-error">&#215;</a>
   </div>
</body>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.reveal.js"></script>
<script type="text/javascript">
 $(function() {
	if($("article").length==0){
		$("#error_a").click();
	}
 });
</script>
</html>
