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
<title>郊区包车服务</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#serviceTitle{ font-weight:bolder;margin-top:15px;text-align: center;}
#airServiceContent{width:90%;margin:0 auto;}
ul,li{margin:0px;padding:0px;list-style:none;}
li{width:50%;float:left;margin-top:5px;color:#292929;font-size:14px;}
#servicePrice{color:#304d85;font-size:16px;}
.service{ background:#e5e5e5; border:1px solid #d9d9d9; color:#000; text-decoration:none; height:35px; line-height:35px; display:block;width:49%;float:left; text-align:center}
.serviceSelect2{ background:#234074;border:1px solid #000;color:#FFF;text-decoration:none;height:35px;line-height:35px; display:block;width:100%;float:left; text-align:center}
#next_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
</style>
</head>

<body>
 <header id="title">
   	郊区包车服务
    <a href="home.jsp" data-ajax="false"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="airServiceContent">
      <section style="height:auto;">
        <p id="serviceTitle">北京市区-郊区包车服务</p>
        <div style="font-size:14px;margin-top:5px;" style="display:none;" id="servicedesc">由市区至五环以外北京行政区域内的用车行程,包括8小时或180公里用车.</div>
     </section>
     <section style="height:35px; margin-top:10px;">
        <p><a href="#" class="serviceSelect2" id="airsend">郊区定义：北京市五环路以外</a></p>
     </section>
     <section style="clear:both;height:auto;margin-top:15px;">
       <form style="background:#f0f0f2;border:1px solid #b5b6b8; border-radius:10px;height:auto;padding:0px 10px;">
          <input type="hidden"  value="5" id="servicetype"/>
          <input type="hidden"  value="" name="extraPrice" id="suburb_extraPrice"/>
         <div class="ui-field-contain"> <label>用车时间</label>
         <input type="text" name="time" readonly="readonly" onclick="switchstartTime()" id="suburb_time" placeholder="请选择上车时间" /></div>
         <div class="ui-field-contain">  <label>上车地点</label>
         <input type="text" name="startAddress" id="suburb_startAddress" placeholder="请输入上车地点" /></div>
         <div class="ui-field-contain">  <label>地点补充</label>
         <input type="text"  name="extra" id="suburb_extra" placeholder="补充详细地址，司机更容易接到您" /></div>
         <div class="ui-field-contain">  <label>下车地点</label>
         <input type="text" name="endAddress" id="suburb_endAddress" placeholder="请输入下车地点" /></div>
         <div class="ui-field-contain"><label>乘车人数</label>
         <input type="number"  name="count" id="suburb_count"   placeholder="请输入乘车人数" /></div>
       </form>
     </section>
     <div style="clear:both;">
 	  <a id="next_a" onclick="submitSuburbForm()">下一步</a>
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
	  if($("#suburb_time").val()){
		  $.cookie("suburb_time",$("#suburb_time").val());
	  }
	  if($("#suburb_startAddress").val()){
		  $.cookie("suburb_startAddress",$("#suburb_startAddress").val());
	  }
	  if($("#suburb_endAddress").val()){
		  $.cookie("suburb_endAddress",$("#suburb_endAddress").val());
	  }
	  if($("#suburb_extra").val()){
		  $.cookie("suburb_extra",$("#suburb_extra").val());
	  }
	  if($("#suburb_count").val()){
		  $.cookie("suburb_count",$("#suburb_count").val());
	  }
	  location.href='datepicker.html';
}
$(function(){
	 if($.cookie("suburb_startAddress")){
		  $("#suburb_startAddress").val($.cookie("suburb_startAddress"));
		  $.cookie("suburb_startAddress","");
	  }
	  if($.cookie("suburb_extra")){
		  $("#suburb_extra").val($.cookie("suburb_extra"));
		  $.cookie("suburb_extra","");
	  }
	  if($.cookie("suburb_count")){
		  $("#suburb_count").val($.cookie("suburb_count"));
		  $.cookie("suburb_count","");
	  }
	  if($.cookie("suburb_endAddress")){
		  $("#suburb_endAddress").val($.cookie("suburb_endAddress"));
		  $.cookie("suburb_endAddress","");
	  }
	  if( $.cookie("extraPrice")){
		  $("#suburb_extraPrice").val($.cookie("extraPrice"));
		  //$.cookie("dateservice_extraPrice","");
	  }
	  if($.cookie("date")){
		  $("#suburb_time").val($.cookie("date")+" "+$.cookie("time"));
		  $.cookie("suburb_time","");
	  }
});
</script>
</html>

