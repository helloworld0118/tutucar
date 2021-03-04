<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">
<title>取消订单</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
#cannelContent{ width:90%;margin:0 auto;height:400px;border-top-left-radius:10px;border-top-right-radius:10px;background:#ebeae8; border:1px solid #cfd3d6;border-bottom:none; margin-top:20px;}
.cannel_p{color:#304d85;margin:5px; font-size:18px;}
.cannel_checkbox{width:40px;height:18px;padding: 0 5px 0 0;}
#cannel_form{border:1px solid #9296a1; border-radius:6px; background:#FFF;margin:5px;padding:10px 0px;}
#cannel_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
#cannel_div{margin-top:20px; font-size:12px;width:95%;margin-left:auto;marign-right:auto;color:red;}
</style>
</head>

<body>
 <header id="title">
   	取消订单
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section id="cannelContent">
   <form id="cannel_form" action="orderFormAction!addEvalution" method="post">
      <input type="hidden" value=""  id="cancel_content" name="evacontent"/>
      <input type="hidden" value=""   name="evaremark"/>
      <input type="hidden" value="1" name="state"/>
      <input type="hidden" value="<%=request.getParameter("orderFormId") %>" name="id"/>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="行程发生改变"  />行程发生改变</p>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="不满意价格"/>不满意价格</p>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="选择其他租车公司" />选择其他租车公司</p>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="其他出行代替" />其他出行代替</p>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="天气原因" />天气原因</p>
      <p class="cannel_p"><input type="checkbox" class="cannel_checkbox" value="其他原因"/>其他原因</p>
   </form>
   <div>
   <a id="cannel_a" onclick="cancelOrderForm()">确认取消</a>
   </div>
  <div id="cannel_div">*请选择取消订单的原因</a>
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
<script type="text/javascript">
$("#cancel_content").val("");
</script>
</html>
