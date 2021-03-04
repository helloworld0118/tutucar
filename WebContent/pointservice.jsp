<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="css/jquery.mobile-1.4.2.css" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">
<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/jquery.mobile-1.4.2.min.js"></script>
<title>点到点服务</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;text-shadow:none}
img{border:none;}
#title{ text-shadow:none;background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#serviceTitle{ font-weight:bolder;margin-top:15px;text-align: center;}
#serviceContent{width:90%;margin:0 auto;}
ul,li{margin:0px;padding:0px;list-style:none;}
li{width:50%;float:left;margin-top:5px;color:#292929;font-size:14px;}
#servicePrice{color:#304d85;font-size:16px;}
.service{ background:#e5e5e5; border:1px solid #d9d9d9; color:#000; text-decoration:none; height:35px; line-height:35px; display:block;width:49%;float:left; text-align:center}
.serviceSelect{ background:#234074;border:1px solid #000;color:#FFF;text-decoration:none;height:35px;line-height:35px; display:block;width:49%;float:left; text-align:center}
#next_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
a{ text-shadow:none;}
</style>
</head>

<body>
 <header id="title">
   	点到点服务
    <a href="home.jsp" data-ajax="false"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="serviceContent">
      <section style="height:auto;">
        <p id="serviceTitle">北京市区-点到点服务</p>
        <div style="font-size:14px;" style="display:none;">五环内的点到点的单程用车，包含单程25公里内。中途停靠，每一地，加收100元。</div>
     </section>
     <form action="orderFormAction!go2choiceCar" method="post" style="margin-top:10px;background:#f0f0f2;border:1px solid #b5b6b8; border-radius:10px;height:auto;padding:0 10px;">
         <input type="hidden"  value="2" id="servicetype" name="service.id"/>
          <input type="hidden"  value="" name="extraPrice" id="point_extraPrice"/>
     	 <div class="ui-field-contain"> <label>用车时间</label>
         <input type="text" name="time" readonly="readonly" onclick="switchstartTime()" id="point_time" placeholder="请选择上车时间" /></div>
         <div class="ui-field-contain"> <label>上车地点</label>
         <input type="text" name="startAddress" id="point_startAddress"  placeholder="请输入上车地点" /></div>
         <div class="ui-field-contain"> <label>地点补充</label>
         <input type="text" name="extra" id="point_extra" placeholder="补充详细地址，司机更容易接到您"/></div>
         <div class="ui-field-contain"><label>乘车人数</label>
         <input type="number"  name="count" id="point_count"   placeholder="请输入乘车人数" /></div>
         <div class="ui-field-contain"> <label>下车地点</label>
         <input type="text" name="endAddress" id="point_endAddress" placeholder="请输入目的地" /></div>
         <div class="ui-field-contain">
          <div class="ui-field-contain">
          <label for="">预估时间</label>
          <select name="estimateTime"  placeholder="选择大概行程时间" id="point_estimateTime" data-native-menu="false">
              <option value="1">1小时</option>
              <option value="2">2小时</option>
              <option value="3">3小时</option>
              <option value="4">4小时</option>
              <option value="5">5小时</option>
              <option value="6">6小时</option>
              <option value="7">7小时</option>
              <option value="8">8小时</option>
          </select>
            </div>
       </form>
     <div style="clear:both;">
 	  <a id="next_a" onclick="submitPointForm()">下一步</a>
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
	  if($("#point_time").val()){
		  $.cookie("point_time",$("#point_time").val());
	  }
	  if($("#point_startAddress").val()){
		  $.cookie("point_startAddress",$("#point_startAddress").val());
	  }
	  if($("#point_endAddress").val()){
		  $.cookie("point_endAddress",$("#point_endAddress").val());
	  }
	  if($("#point_extra").val()){
		  $.cookie("point_extra",$("#point_extra").val());
	  }
	  if($("#point_count").val()){
		  $.cookie("point_count",$("#point_count").val());
	  }
	  location.href='datepicker.html';
}
$(function(){
	 if($.cookie("point_startAddress")){
		  $("#point_startAddress").val($.cookie("point_startAddress"));
		  //$.cookie("point_startAddress","");
	  }
	  if($.cookie("point_extra")){
		  $("#point_extra").val($.cookie("point_extra"));
		  //$.cookie("point_extra","");
	  }
	  if($.cookie("point_count")){
		  $("#point_count").val($.cookie("point_count"));
		  //$.cookie("point_count","");
	  }
	  if($.cookie("point_endAddress")){
		  $("#point_endAddress").val($.cookie("point_endAddress"));
		  //$.cookie("point_endAddress","");
	  }
	  if( $.cookie("extraPrice")){
		  $("#point_extraPrice").val($.cookie("extraPrice"));
		  //$.cookie("dateservice_extraPrice","");
	  }
	  if($.cookie("date")){
		  $("#point_time").val($.cookie("date")+" "+$.cookie("time"));
		  //$.cookie("point_time","");
	  }
	  
});
</script>
</html>