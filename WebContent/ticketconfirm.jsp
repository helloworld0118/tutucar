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
<link rel="stylesheet" href="css/jquery.mobile-1.4.2.css" />
<link rel="stylesheet" type="text/css" href="css/reveal.css">
<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/jquery.mobile-1.4.2.min.js"></script>
<script src="js/md5.js"></script>
<script src="js/sha1.js"></script>
<title>订单确认</title> 
<style>
body,p{margin:0px;padding:0px; font-family:"微软雅黑"; font-size:16px;}
img{border:none;}
#title{ background:#304d85; width:100%;height:40px;padding:3px 0px; text-align:center; line-height:40px; font-size:18px; color:#FFF}
#telImg{float:right;margin-right:15px;}
#homeImg{float:right;margin-top:5px;margin-right:15px;}
#backImg{margin-left:10px;float:left;}
.info_p{color:#3c3c3c;margin-top:10px; font-size:14px;}
#confirm_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
#cancel_a{background:url(images/cannelbtn.png); background-repeat:no-repeat; background-size:100% 100%;padding:10px;font-size:18px;color:#FFF;width:70%;margin:0 auto;display:block; text-align:center;margin-top:20px;}
.tip_p{ font-size:12px;color:#3c3c3c;margin-top:10px;}
</style>
</head>
<body>
<body>
 <header id="title">
   	订单确认
    <a href="javascript:history.back()"><img src="images/back.png" id="backImg"/></a>
    <a href="#"><img src="images/home.png" id="homeImg"/></a>
    <a href="tel:86-10-6538 0036"><img src="images/tel.png" id="telImg"/></a>
 </header>
 <section style="width:90%;margin:0 auto;margin-top:15px;">
    <section style=" background:#f0f0f2; border:1px solid #bebfc1; border-radius:10px;padding:10px;">
       <p style="font-weight:bolder;">
        <c:choose>
          <c:when test="${orderform.service.id==1}">
               机场接送
          </c:when>
          <c:when test="${orderform.service.id==2}">
               点到点服务
          </c:when>
          <c:when test="${orderform.service.id==3}">
			   半日/全日租
          </c:when>
          <c:when test="${orderform.service.id==4}">
               郊区包车服务
          </c:when>
        </c:choose>
       </p>
       <p class="info_p">预定车型：${orderform.car.name}</p>
       <p class="info_p">用车时间：${orderform.time}</p>
       <p class="info_p">乘车人数：${orderform.count}人</p>
       <p class="info_p">上车地址：
         <c:choose>
          <c:when test="${(orderform.startAddress=='1'||orderform.startAddress=='2'||orderform.startAddress=='3')&&orderform.service.id==1}">
                北京首都机场T${orderform.startAddress}航站楼
          </c:when>
          <c:otherwise>
          	${orderform.startAddress }
          </c:otherwise>
         </c:choose>
       		&nbsp;${orderform.extra}</p>
       <c:if test="${fn:length(orderform.extra2)>0}">
          <p class="info_p">航  班  号：${orderform.extra2 }</p>
       </c:if>
       	<c:if test="${fn:length(orderform.extra3)>0}">
			<p class="info_p">航班日期：${orderform.extra3 }</p>
		</c:if>
       <p class="info_p">下车地址：
       	  <c:choose>
          <c:when test="${(orderform.endAddress=='1'||orderform.endAddress=='2'||orderform.endAddress=='3')&&orderform.service.id==1}">
                北京首都机场T${orderform.endAddress}航站楼
          </c:when>
          <c:otherwise>
          	${orderform.endAddress }
          </c:otherwise>
         </c:choose>
         &nbsp;${orderform.extra1}
       </p>
       <p class="info_p">订单金额：<span style="color:red;font-weight: bolder;">${orderform.price+orderform.extraPrice}</span>元</p>
    </section>
   <div>
    <a id="confirm_a">确认并支付</a>
    <a id="cancel_a" onclick="javascript:location.href='cannelticket.jsp?orderFormId=${orderform.id}'">取消订单</a>
   </div>
   <section style="padding:10px;">
     <p style="color:#304d85;">重要提示：</p>
     <p class="tip_p">1、车辆分配后，系统会以短信通知您。</p>
     <p class="tip_p">2、本公司车辆均为中国大陆地区标准车型。</p>
     <p class="tip_p">3、距离乘车时间1小时内取消订单，收取最低消费。</p>
   </section>
 </section>
</body>
</body>
<script type="text/javascript">
function getAppId(){
    return '<%=request.getAttribute("APP_ID") %>';
}
 
 function getTimeStamp(){
     var timestamp=new Date().getTime();
     var timestampstring = timestamp.toString();//一定要转换字符串
     oldTimeStamp = timestampstring;
     return timestampstring;
 }
function getNonceStr(){
     var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
     var maxPos = $chars.length;
     var noceStr = "";
     for (i = 0; i < 32; i++) {
         noceStr += $chars.charAt(Math.floor(Math.random() * maxPos));
     }
     oldNonceStr = noceStr;
     return noceStr;
 }
 //获取订单生成Ip
function getIp(){
	var str_tmp = '<%=request.getLocalAddr() %>' ;
	//document.getElementById("spbillCreateIp").value=str_tmp;
	return str_tmp;
}
function getANumber(){
  //在这里加订单号
  return '<%=request.getAttribute("code") %>';
}
 function getPartnerId(){
    //这里是商户号
    return  '<%=request.getAttribute("PartnerId") %>';
   
}
function getPartnerKey() {
   //这里是商户key
   return  '<%=request.getAttribute("PartnerKey") %>';
  
}
var oldPackageString;//记住package，方便最后进行整体签名时取用
function getPackage(){
      var banktype = "WX";
      var body ='<%=request.getAttribute("serviceTitle")%>';//商品名称信息，这里由测试网页填入。
      var fee_type = "1";//费用类型，这里1为默认的人民币
      var input_charset = "UTF-8";//字符集，这里将统一使用GBK
      var notify_url = 'http://112.253.28.19:8080/tutucar/orderFormAction!paySuccess?orderId=<%=request.getAttribute("orderId")%>';//支付成功后将通知该地址
      var out_trade_no = ""+getANumber();//订单号，商户需要保证该字段对于本商户的唯一性
      var partner = getPartnerId();//测试商户号
      var spbill_create_ip = getIp();//用户浏览器的ip，这个需要在前端获取。这里使用127.0.0.1测试值
      var total_fee = 1;//总金额。
      var partnerKey = getPartnerKey();//这个值和以上其他值不一样是：签名需要它，而最后组成的传输字符串不能含有它。这个key是需要商户好好保存的。
      
      //首先第一步：对原串进行签名，注意这里不要对任何字段进行编码。这里是将参数按照key=value进行字典排序后组成下面的字符串,在这个字符串最后拼接上key=XXXX。由于这里的字段固定，因此只需要按照这个顺序进行排序即可。
      var signString = "bank_type="+banktype+"&body="+body+"&fee_type="+fee_type+"&input_charset="+input_charset+"&notify_url="+notify_url+"&out_trade_no="+out_trade_no+"&partner="+partner+"&spbill_create_ip="+spbill_create_ip+"&total_fee="+total_fee+"&key="+partnerKey;
      
      var md5SignValue =  ("" + CryptoJS.MD5(signString)).toUpperCase();
      //然后第二步，对每个参数进行url转码，如果您的程序是用js，那么需要使用encodeURIComponent函数进行编码。
      
      
      banktype = encodeURIComponent(banktype);
      body=encodeURIComponent(body);
      fee_type=encodeURIComponent(fee_type);
      input_charset = encodeURIComponent(input_charset);
      notify_url = encodeURIComponent(notify_url);
      out_trade_no = encodeURIComponent(out_trade_no);
      partner = encodeURIComponent(partner);
      spbill_create_ip = encodeURIComponent(spbill_create_ip);
      total_fee = encodeURIComponent(total_fee);
      
      //然后进行最后一步，这里按照key＝value除了sign外进行字典序排序后组成下列的字符串,最后再串接sign=value
      var completeString = "bank_type="+banktype+"&body="+body+"&fee_type="+fee_type+"&input_charset="+input_charset+"&notify_url="+notify_url+"&out_trade_no="+out_trade_no+"&partner="+partner+"&spbill_create_ip="+spbill_create_ip+"&total_fee="+total_fee;
      completeString = completeString + "&sign="+md5SignValue;
      oldPackageString = completeString;//记住package，方便最后进行整体签名时取用
      return completeString;
  }
 function getSignType() {
     return "SHA1";
 }
 function getAppKey() {
     return '<%=request.getAttribute("APP_KEY") %>';
 }
 var oldTimeStamp ;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
 var oldNonceStr ; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
 function getSign(){
      var app_id = getAppId().toString();
      var app_key = getAppKey().toString();
      var nonce_str = oldNonceStr;
      var package_string = oldPackageString;
      var time_stamp = oldTimeStamp;
      //第一步，对所有需要传入的参数加上appkey作一次key＝value字典序的排序
      var keyvaluestring = "appid="+app_id+"&appkey="+app_key+"&noncestr="+nonce_str+"&package="+package_string+"&timestamp="+time_stamp;
      sign = CryptoJS.SHA1(keyvaluestring).toString();
      return sign;
  }
      // 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
       //公众号支付
      jQuery('a#confirm_a').click(function(e){
         WeixinJSBridge.invoke('getBrandWCPayRequest',{
         "appId" : getAppId(), //公众号名称，由商户传入
         "timeStamp" : getTimeStamp(), //时间戳
          "nonceStr" : getNonceStr(), //随机串
          "package" : getPackage(),//扩展包
          "signType" : getSignType(), //微信签名方式:1.sha1
          "paySign" : getSign() //微信签名
         },function(res){
           if(res.err_msg == "get_brand_wcpay_request:ok" ) {}
           // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
           //因此微信团队建议，当收到ok返回时，向商户后台询问是否收到交易成功的通知，若收到通知，前端展示交易成功的界面；若此时未收到通知，商户后台主动调用查询订单接口，查询订单的当前状态，并反馈给前端展示相应的界面。
              location.href="http://112.253.28.19:8080/tutucar/orderFormAction!sendPaySuccessMsg?code="+getANumber();
           }); 
       });
         WeixinJSBridge.log('yo~ ready.');
      }, false)
</script>
</html>
