<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>登录</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="css/reveal.css">	
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#loginTitle{ background:#304d85; width:100%;height:40px;padding:3px 0px;text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#loginContent{ background:url(images/loginbg.png); background-repeat:no-repeat; background-size:100% 100%;width:80%;height:250px;margin-top:30px;margin-left:auto;margin-right:auto;}
input{
       border-radius:6px;
	   height:30px;
	   width:80%;
	   margin-left:auto;
	   margin-right:auto;
	   display:block;
	   padding-left:35px;
       border:1px solid #bcb8b6;
       -webkit-transition: box-shadow 0.30s ease-in-out;   
       -moz-transition:  box-shadow 0.30s ease-in-out;     
	   color:#d3d1d1;
	   font-size:14px;
 }
input:focus{
 border:#87C6F9 1px solid;
 box-shadow: 0 0 8px rgba(103, 166, 217, 1);
 color:#000;
}
#register{color:#d4d4d4; font-size:12px;float:left;margin-top:10px;margin-left:20px; text-decoration:none;}
#forgetpassword{color:#d4d4d4; font-size:12px;float:right;margin-top:10px;margin-right:20px; text-decoration:none;}
#login_a{text-decoration:none; display:block; text-align:center;  color:#000;width:70%;margin:10px auto;padding:12px;background:url("images/loginbtn.png"); background-repeat: none; background-size:100% 100%;}
</style>
</head>

<body>
 <header id="loginTitle">
     登录
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="loginContent">
     <form action="userAction!login" method="post" id="loginForm">
       <input type="hidden" name="backurl" value="<%=request.getHeader("Referer") %>" />
        <div style="width:90px;height:30px;margin:0 auto;padding-top:20px;"><img src="images/logo.png" /></div>
        <div style="width:85%;margin:0 auto;margin-top:10px;text-align:center;"> 
     	  <input name="userinfo"  type="text" placeholder="手机号/邮箱" style="background-image:url(images/username.png); background-repeat:no-repeat; background-position:5px 5px;" />
        </div>
        <div style="width:85%;margin:0 auto;margin-top:10px;"> 
     	 <input  name="password"  type="password" placeholder="密码"  style="background-image:url(images/password.png); background-repeat:no-repeat; background-position:7px 5px;" />
     	</div>
     	<a id="login_a" href="javascript:void(0)" onclick="validateLogin()">登录</a>
     </form>
     <p style="color:red; text-align: center;z-index:100;position:absolute;left:50%;margin-left:-50px;margin-top:-10px;font-size:12px;">${error}</p>
     <div>
     	<a href="register.jsp" id="register">新用户注册</a><a href="forgetPwd.jsp" id="forgetpassword" >忘记密码？</a>
     </div>
 </section>
 <a href="#" id="error_a" style="display:none;" data-error-id="errorDiv"></a>
   <div class="reveal-error" id="errorDiv">
     <p id="errorcontent_p" style="color:red;margin-top:13px;padding:0px">请输入密码</p>
     <a class="close-reveal-error">&#215;</a>
   </div>
</body>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.reveal.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
$(function(){
	  var url = location.href;
	  if(url.indexOf('userAction!register')>=0){
		  alert("注册成功！")
	  }
})
</script>
</html>

