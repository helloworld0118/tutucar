<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>免费注册</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="css/jquery.mobile-1.4.2.css" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">	
<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/jquery.mobile-1.4.2.min.js"></script>
<style>
img{border:none;}
#registerTitle{ font-weight:bolder; background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#sendSMS{ background:#22263f;border-radius:10px; color:#FFF; font-size:14px;display:block;padding:7px;float:left;margin-top:10px;margin-left:30px;text-shadow:none;}
#registerContent{ width:90%;margin:0 auto;height:530px;border-radius: 10px;
		background:#ebeae8; border:1px solid #c0c3ca;margin-top:20px;}
a{text-decoration: none;}
</style>
</head>

<body>
 <header id="registerTitle">
    免费注册
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="registerContent">
   <form id="registerForm" data-ajax="false" method="post" action="userAction!register" style="background:url(images/loginbg.png);padding-top:10px;margin:3px; border-radius:10px; background-repeat:no-repeat; background-size:100% 100%;padding:10px 20px;">
     <input type="text" maxlength="11"  name="phone" placeholder="手机号" />
     <input type="email" name="email"  placeholder="电子邮件" />
     <input type="email" name="cemail"  placeholder="备用电子邮件（选填）"/>
     <input type="hidden" name="score" value="0"  />
     <input type="hidden" name="group.id" value="1" />
     <input type="text" name="username" placeholder="姓　　名" />
     <div class="ui-field-contain"style="margin:0px;padding:0px;">
        <select name="cardType"  data-native-menu="false">
            <option value="1">身份证</option>
            <option value="2">CODE号</option>
            <option value="3">驾驶证</option>
        </select>
    </div>
     <input type="text" name="cardNum" placeholder="证件号码" />
     <input type="password" name="password"placeholder="密码为6~18位数字或字母" />
     <input type="password" id="confirmPassword" placeholder="确认密码" />
     <div style="width:100%;margin-left:auto;margin-right:auto;padding:0px;height:60px;">
       <div style="float:left;width:30%;"> <input type="text" placeholder="验证码" name="code" id="code"/></div>
	   <a id="sendSMS" href="javascript:void(0)"><span id="jscount" style="display: none;">60</span>点击发送验证码</a>
     </div> 
    </form>
    <section style="width:50%;margin-left:auto;margin-right:auto;background:url(images/registerbtn.png);background-repeat:no-repeat; background-size:100% 100%;margin-top:10px;">
      <a href="javascript:void(0)" onclick="validateRegister()" style="padding:10px 20px; display:block; text-align:center;color:#FFF;font-size:16px;text-shadow:none;">注册</a>
    </section>
 </section>
 <section style="margin-top:20px; font-size:12px;width:90%;margin-left:auto;marign-right:auto;">
   <a href="#" style="color:#304d85;" style="text-shadow:none;">*阅读《通途汽车会员注册协议》</a>
 </section>
   <a href="#" id="error_a" style="display:none;" data-error-id="errorDiv"></a>
   <div class="reveal-error" id="errorDiv">
     <p id="errorcontent_p" style="color:red">abc</p>
     <a class="close-reveal-error">&#215;</a>
   </div>
</body>
<script src="js/main.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.reveal.js"></script>
</html>
