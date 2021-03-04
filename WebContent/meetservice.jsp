<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="css/jquery.mobile-1.4.2.css" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">
<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/jquery.mobile-1.4.2.min.js"></script>
<title>会议及长租服务</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#serviceTitle{ font-weight:bolder;margin-top:15px;}
#airServiceContent{width:90%;margin:0 auto;}
ul,li{margin:0px;padding:0px;list-style:none;}
li{width:50%;float:left;margin-top:5px;color:#292929;font-size:14px;}
#servicePrice{color:#304d85;font-size:16px;}
.service{ background:#e5e5e5; border:1px solid #d9d9d9; color:#000; text-decoration:none; height:35px; line-height:35px; display:block;width:49%;float:left; text-align:center}
.serviceSelect{ background:#234074;border:1px solid #000;color:#FFF;text-decoration:none;height:35px;line-height:35px; display:block;width:49%;float:left; text-align:center}
#next_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
</style>
</head>

<body>
 <header id="title">
   	会议及长租服务
    <a href="home.jsp" data-ajax="false"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="airServiceContent">
     <section style="height:35px; margin-top:20px;">
        <p><a  href="javascript:void(0)" onClick="showAndHide('-1','meet','-1','longtime','6')" id="meet" class="service">会议租车</a><a href="javascript:void(0)" onClick="showAndHide('-1','longtime','-1','meet','7')"  class="serviceSelect" id="longtime">长期包车</a></p>
     </section>
      <form action="orderFormAction!saveMeet" method="post" style="background:#f0f0f2;border:1px solid #b5b6b8; border-radius:10px;padding:0px 10px;margin-top:15px;">
         <section style="clear:both;height:auto;">
             <input type="hidden"  value="7" id="servicetype" name="service.id"/>
             <input type="hidden"  value="6" name="state"/>
             <div class="ui-field-contain"> <label>用车时间</label>
             <input type="text" name="time" id="meet_time" readonly="readonly" onclick="switchstartTime()" value="" /></div>
             <div class="ui-field-contain"> <label>乘车人数</label>
             <input type="number"  name="count" id="meet_count" value="" /></div>
             <div class="ui-field-contain"> <label>联  系  人</label>
               <c:if test="${null!=tu_user}">
              	  <input type="text" readonly="readonly" name="username" id="meet_user_name" value="${tu_user.username}" />
               </c:if>
                <c:if test="${null==tu_user}">
                 <input type="text" name="username" id="meet_user_name" value="" />
               </c:if>
                
             </div>
             <div class="ui-field-contain"> <label>联系电话</label>
               <c:if test="${null!=tu_user}">
               	 <input type="text" readonly="readonly" name="phone" id="meet_user_phone" value="${tu_user.phone}" />
               </c:if>
               <c:if test="${null==tu_user}">
                   <input type="text" name="phone" id="meet_user_phone" value="" />
               </c:if>
             </div>
         </section>
      </form>
     <div style="clear:both;">
 	  <a id="next_a" onclick="submitMeetForm()">提交</a>
  	 </div>
 </section>
 <a href="#" id="error_a" style="display:none;" data-error-id="errorDiv"></a>
   <div class="reveal-error" id="errorDiv">
     <p id="errorcontent_p" style="color:red;margin-top:15px;">abc</p>
     <a class="close-reveal-error">&#215;</a>
   </div>
 </body>
 <script src="js/main.js"></script>
 <script type="text/javascript" src="js/jquery.min.js"></script>
 <script type="text/javascript" src="js/jquery.reveal.js"></script>
 <script src="js/jquery.cookie.js"></script>
 <script type="text/javascript">
function switchstartTime(){
	  $.cookie("service",$("#servicetype").val());
	  $.cookie("url",this.location);
	  if($("#meet_time").val()){
		  $.cookie("meet_time",$("#meet_time").val());
	  }
	  if($("#meet_count").val()){
		  $.cookie("meet_count",$("#meet_count").val());
	  }
	  if($("#meet_user_name").val()){
		  $.cookie("meet_user_name",$("#meet_user_name").val());
	  }
	  if($("#meet_user_phone").val()){
		  $.cookie("meet_user_phone",$("#meet_user_phone").val());
	  }
	  location.href='datepicker.html';
}
$(function(){
	  if($.cookie("meet_count")){
		  $("#meet_count").val($.cookie("meet_count"));
		  $.cookie("meet_count","");
	  }
	  if($.cookie("meet_user_name")){
		  $("#meet_user_name").val($.cookie("meet_user_name"));
		  $.cookie("meet_user_name","");
	  }
	  if($.cookie("meet_user_phone")){
		  $("#meet_user_phone").val($.cookie("meet_user_phone"));
		  $.cookie("meet_user_phone","");
	  }
	  if($.cookie("date")){
		  $("#meet_time").val($.cookie("date")+" "+$.cookie("time"));
		  $.cookie("meet_time","");
	  }
});
</script>
</html>
