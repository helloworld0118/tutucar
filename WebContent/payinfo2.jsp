<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
    <form name="form1" target="_blank">
            <table border="1">
                <TR><th>公众号ID</th> <th><INPUT value="wx85e4e4dc95cee8b5" name="appId" id="1"></th>
                <tr><th>商户ID</th><th><INPUT value="1219807801" name="partnerId" id="2"></th>
                <TR><th>总金额</th><th><INPUT value="1" name="totalFee" id="3"></th>
                <TR><th>商品名</th><th><INPUT value="通途租车" name="body" id="4"></th>
            </table>
            <a href="javascript:void(0)" id="getBrandWCPayRequest">点击支付</a>
        </form>
</body>
<script type="text/javascript">
function getAppId(){
    return document.form1.appId.value;
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
  return "BJ20140123123";
}
 function getPartnerId(){
    //这里是商户号
    return document.form1.partnerId.value;
}
function getPartnerKey() {
   //这里是商户key
    return "fa0504aeaec1a001b1be20d329952fc0";
}
var oldPackageString;//记住package，方便最后进行整体签名时取用
function getPackage(){
      var banktype = "WX";
      var body = document.form1.body.value;//商品名称信息，这里由测试网页填入。
      var fee_type = "1";//费用类型，这里1为默认的人民币
      var input_charset = "UTF-8";//字符集，这里将统一使用GBK
      var notify_url = "http://112.253.28.19:8080/tutucar/orderForm!paySuccess";//支付成功后将通知该地址
      var out_trade_no = ""+getANumber();//订单号，商户需要保证该字段对于本商户的唯一性
      var partner = getPartnerId();//测试商户号
      var spbill_create_ip = getIp();//用户浏览器的ip，这个需要在前端获取。这里使用127.0.0.1测试值
      var total_fee = document.form1.totalFee.value;//总金额。
      alert(total_fee);
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
     return "4YUfQY9LW7SHOUsr2Wdb5AQTpaDw3L1LOPBGLjb4h1Ru0WXzDnaOfuSre8RoaWz8yqkM1j5Y4NS0xEYeed8CbLUqiEZEtxBNWBJA54PJ1zeooA4H931i6DGK475hjoZn";
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
      jQuery('a#getBrandWCPayRequest').click(function(e){
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
           }); 
       });
      WeixinJSBridge.log('yo~ ready.');
      }, false)
</script>
</html>
