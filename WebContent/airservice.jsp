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
<title>机场接送服务</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{text-shadow:none; background:#304d85; width:100%;height:40px;padding:3px 0px;text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#serviceTitle{ font-weight:bolder;margin-top:15px; text-align: center;}
#airServiceContent{width:90%;margin:0 auto;}
ul,li{margin:0px;padding:0px;list-style:none;}
#airServiceContent li{width:50%;float:left;margin-top:5px;color:#292929;font-size:14px;}
#servicePrice{color:#304d85;font-size:16px;}
.service{ background:#e5e5e5; border:1px solid #d9d9d9; color:#000; text-decoration:none; height:35px; line-height:35px; display:block;width:49%;float:left; text-align:center}
.serviceSelect{ background:#234074;border:1px solid #000;color:#FFF;text-decoration:none;height:35px;line-height:35px; display:block;width:49%;float:left; text-align:center}
#next_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
a{ text-shadow:none;}
</style>
</head>

<body>
 <header id="title">
   	机场接送服务
    <a href="home.jsp" data-ajax="false" ><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="airServiceContent">
      <section style="height:atuto;">
        <p id="serviceTitle">北京市区-机场接送服务</p>
        <div style="font-size:14px;margin-top:5px;" style="display:none;" id="servicedesc">五环内的机场单程接机或送机,中途停靠，每一地，加收100元。</div>
     </section>
     <section style="height:35px; margin-top:10px;">
        <p><a href="javascript:void(0)" onClick="showAndHide('aircomeForm','aircome','airsendForm','airsend','1')" id="aircome" class="service">接    机</a><a href="javascript:void(0)" onClick="showAndHide('airsendForm','airsend','aircomeForm','aircome','1')" class="serviceSelect" id="airsend">送    机</a></p>
     </section>
     <section style="clear:both;height:auto;margin-top:15px;">
      <form data-ajax="false" action="orderFormAction!go2choiceCar" method="post" id="aircomeForm" style="display:none;background:#f0f0f2;border:1px solid #b5b6b8; border-radius:10px;height:auto;padding:0px 10px;">
       <input type="hidden"  value="1" name="service.id"/>
        <input type="hidden"  value="0" name="extraPrice" id="comeAir_extraPrice"/>
        <section id="aircomeContent" >
             <div class="ui-field-contain"> <label>航  班  号</label>
             <input type="text" name="extra2" id="comeAir_extra2" placeholder="请输入您的航班号" /></div>
             <div class="ui-field-contain"><label>航班日期</label>
             <input type="text" name="extra3" id="comeAir_extra3" onclick="comeSwitchAirTime()"  readonly="readonly" placeholder="请选择航班日期" /></div>
             <div class="ui-field-contain">
                <label>上车地点</label>
                <select name="startAddress" id="comeAir_startAddress" data-native-menu="false">
                    <option value="1">北京首都机场T1航站楼</option>
                    <option value="2">北京首都机场T2航站楼</option>
                    <option value="3">北京首都机场T3航站楼</option>
                </select>
             </div>
             <div class="ui-field-contain"> <label>用车时间</label>
             <input type="text"  name="time" readonly="readonly" onclick="comeSwitchStartTime()" id="comeAir_time" placeholder="请选择上车时间" /></div>
              <div class="ui-field-contain"><label>乘车人数</label>
             <input type="number"  name="count" id="comeAir_count"  placeholder="请输入乘车人数" /></div>
             <div class="ui-field-contain"> <label>补充说明</label>
             <input type="text" name="remark" id="comeAir_remark"  placeholder="如有其他要求请在此处输入"/></div>
           
       </section>
      </form>
      <form data-ajax="false"  action="orderFormAction!go2choiceCar" method="post" id="airsendForm" style="background:#f0f0f2;border:1px solid #b5b6b8; border-radius:10px;height:auto;padding:0px 10px;">
       <input type="hidden"  value="1" name="service.id"/>
       <input type="hidden"  value="0" name="extraPrice" id="sendAir_extraPrice"/>
       <section id="airsendContent">
             <div class="ui-field-contain">
                <label for="">送往机场</label>
                <select name="endAddress" id="sendAir_endAddress" data-native-menu="false">
                    <option value="1">北京首都机场T1航站楼</option>
                    <option value="2">北京首都机场T2航站楼</option>
                    <option value="3">北京首都机场T3航站楼</option>
                </select>
            </div>
             <div class="ui-field-contain"> <label>用车时间</label>
             <input type="text" readonly="readonly" onclick="sendSwitchstartTime()" id="sendAir_time"  name="time" placeholder="请选择上车时间" /></div>
             <div class="ui-field-contain"> <label>上车地点</label>
             <input type="text" name="startAddress" id="sendAir_startAddress" placeholder="请输入上车地点" /></div>
             <div class="ui-field-contain"><label>乘车人数</label>
             <input type="number"  name="count" id="sendAir_count"  placeholder="请输入乘车人数" /></div>
             <div class="ui-field-contain"> <label>补充说明</label>
             <input type="text" name="remark" id="sendAir_remark" placeholder="如有其他要求请在此处输入"/></div>
       </section>
       </form>
     </section>
     <div style="clear:both;">
 	  <a id="next_a" onclick="submitAircurrentForm()">下一步</a>
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
  function sendSwitchstartTime(){
	  $.cookie("service",1);
	  $.cookie("url",this.location);
	  $.cookie("form","airsendForm");
	  if($("#sendAir_endAddress").val()){
		  $.cookie("sendAir_endAddress",$("#sendAir_endAddress").val());
	  }
	  if($("#sendAir_time").val()){
		  $.cookie("sendAir_time",$("#sendAir_time").val());
	  }
	  if($("#sendAir_startAddress").val()){
		  $.cookie("sendAir_startAddress",$("#sendAir_startAddress").val());
	  }
	  if($("#sendAir_count").val()){
		  $.cookie("sendAir_count",$("#sendAir_count").val());
	  }
	  if($("#sendAir_remark").val()){
		  $.cookie("sendAir_remark",$("#sendAir_remark").val());
	  }
	  location.href='datepicker.html';
  }
  function comeSwitchAirTime(){
	  $.cookie("service",1);
	  $.cookie("url",this.location);
	  $.cookie("form","aircomeForm");
	  $.cookie("datetype","comeAir_extra3");
	  if($("#comeAir_extra2").val()){
		  $.cookie("comeAir_extra2",$("#comeAir_extra2").val());
	  }
	  if($("#comeAir_extra3").val()){
		  $.cookie("comeAir_extra3",$("#comeAir_extra3").val());
	  }
	  if($("#comeAir_startAddress").val()){
		  $.cookie("comeAir_startAddress",$("#comeAir_startAddress").val());
	  }
	  if($("#comeAir_time").val()){
		  $.cookie("comeAir_time",$("#comeAir_time").val());
	  }
	  if($("#comeAir_count").val()){
		  $.cookie("comeAir_count",$("#comeAir_count").val());
	  }
	  if($("#comeAir_remark").val()){
		  $.cookie("comeAir_remark",$("#comeAir_remark").val());
	  }
	  location.href='datepicker.html';
  }
  function comeSwitchStartTime(){
	  $.cookie("service",1);
	  $.cookie("url",this.location);
	  $.cookie("form","aircomeForm");
	  $.cookie("datetype","comeAir_time");
	  if($("#comeAir_extra2").val()){
		  $.cookie("comeAir_extra2",$("#comeAir_extra2").val());
	  }
	  if($("#comeAir_extra3").val()){
		  $.cookie("comeAir_extra3",$("#comeAir_extra3").val());
	  }
	  if($("#comeAir_startAddress").val()){
		  $.cookie("comeAir_startAddress",$("#comeAir_startAddress").val());
	  }
	  if($("#comeAir_time").val()){
		  $.cookie("comeAir_time",$("#comeAir_time").val());
	  }
	  if($("#comeAir_count").val()){
		  $.cookie("comeAir_count",$("#comeAir_count").val());
	  }
	  if($("#comeAir_remark").val()){
		  $.cookie("comeAir_remark",$("#comeAir_remark").val());
	  }
	  location.href='datepicker.html';
  }
  $(function(){
	  if($.cookie("form")=="airsendForm"){
		  if($.cookie("sendAir_endAddress")){
			  $("#sendAir_endAddress").val($.cookie("sendAir_endAddress"));
			  //$.cookie("sendAir_endAddress","");
		  }
		  if($.cookie("sendAir_startAddress")){
			  $("#sendAir_startAddress").val($.cookie("sendAir_startAddress"));
			  //$.cookie("sendAir_startAddress","");
		  }
		  if($.cookie("sendAir_count")){
			  $("#sendAir_count").val($.cookie("sendAir_count"));
			  //$.cookie("sendAir_count","");
		  }
		  if($.cookie("sendAir_remark")){
			  $("#sendAir_remark").val($.cookie("sendAir_remark"));
			  //$.cookie("sendAir_remark","");
		  } 
		  if( $.cookie("extraPrice")){
			  $("#sendAir_extraPrice").val($.cookie("extraPrice"));
			  //$.cookie("sendAir_remark","");
		  }
		  if($.cookie("date")){
			  $("#sendAir_time").val($.cookie("date")+" "+$.cookie("time"));
			  //$.cookie("date","");
		  }
	  }else if($.cookie("form")=="aircomeForm"){
		  $("#aircome").click();
		  if($.cookie("datetype")=="comeAir_extra3"){
			  if($.cookie("comeAir_extra2")){
				  $("#comeAir_extra2").val($.cookie("comeAir_extra2"));
				 // $.cookie("comeAir_extra2","");
			  }
			  if($.cookie("comeAir_startAddress")){
				  $("#comeAir_startAddress").val($.cookie("comeAir_startAddress"));
				  //$.cookie("comeAir_startAddress","");
			  }
			  if($.cookie("comeAir_time")){
				  $("#comeAir_time").val($.cookie("comeAir_time"));
				  //$.cookie("comeAir_time","");
			  }
			  if($.cookie("comeAir_count")){
				  $("#comeAir_count").val($.cookie("comeAir_count"));
				 // $.cookie("comeAir_count","");
			  }
			  if($.cookie("comeAir_remark")){
				  $("#comeAir_remark").val($.cookie("comeAir_remark"));
				//  $.cookie("comeAir_remark","");
			  }
			  if($.cookie("extraPrice")){
				  $("#comeAir_extraPrice").val($.cookie("extraPrice"));
				  //$.cookie("comeAir_extraPrice","");
			  }
			  if($.cookie("date")){
				  $("#comeAir_extra3").val($.cookie("date")+" "+$.cookie("time"));
				  //$.cookie("date","");
			  }
		  }else{
			  if($.cookie("comeAir_extra2")){
				  $("#comeAir_extra2").val($.cookie("comeAir_extra2"));
				  //$.cookie("comeAir_extra2","");
			  }
			  if($.cookie("comeAir_extra3")){
				  $("#comeAir_extra3").val($.cookie("comeAir_extra3"));
				  //$.cookie("comeAir_extra3","");
			  }
			  if($.cookie("comeAir_startAddress")){
				  $("#comeAir_startAddress").val($.cookie("comeAir_startAddress"));
				 // $.cookie("comeAir_startAddress","");
			  }
			  if($.cookie("comeAir_time")){
				  $("#comeAir_time").val($.cookie("comeAir_time"));
				  $.cookie("comeAir_time","");
			  }
			  if($.cookie("comeAir_count")){
				  $("#comeAir_count").val($.cookie("comeAir_count"));
				  //$.cookie("comeAir_count","");
			  }
			  if($.cookie("comeAir_remark")){
				  $("#comeAir_remark").val($.cookie("comeAir_remark"));
				  //$.cookie("comeAir_remark","");
			  }
			  if($.cookie("extraPrice")){
				  $("#comeAir_extraPrice").val($.cookie("extraPrice"));
				 // $.cookie("comeAir_extraPrice","");
			  }
			  if($.cookie("date")){
				  $("#comeAir_time").val($.cookie("date")+" "+$.cookie("time"));
				 // $.cookie("date","");
			  }
		  }
	  }
  });
</script>
</html>
