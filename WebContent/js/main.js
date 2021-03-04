// JavaScript Document
$(function(){
	$("#homeImg").click(function(){
		location.href="home.jsp";
	});
	$("#forgetPwd").click(function(){
		var phone=$("input[name='phone']").val();
		if(!phone){
			$("#errorcontent_p").html("请填写手机号");
			$("#error_a").click();
		}else if(phone.length!=11){
			$("#errorcontent_p").html("请确认手机号");
			$("#error_a").click();
		}else{
			if($("#sendSMS").css("color")=="rgb(204, 204, 204)"){
				return;
			}
			$.ajax({
				url:"userAction!forgetRegisterMsg",
				data:{'phoneNum':phone},
				dataType:"json",
				type: "POST",
				success:function(result){
						if(result.success){
							$("#sendSMS").html("<span id='jscount'>59</span>秒后重新发送");
							$("#sendSMS").attr("disabled",true);
							$("#sendSMS").css("color","#CCC");
							setTimeout("jscount();",1000);
							$("#errorcontent_p").html("发送成功，请注意查收短信");
						}else{
							$("#errorcontent_p").html(result.msg);
						}
						$("#error_a").click();
				},
				failure:function(result){
					
				}
			});
		}
		
	});
	$("#sendSMS").click(function(){
		var phone=$("input[name='phone']").val();
		var email=$("input[name='email']").val();
		var cemail=$("input[name='cemail']").val();
		var username=$("input[name='username']").val();
		var cardNum=$("input[name='cardNum']").val();
		var cardType=$("select[name='cardType']").val();
		var password=$("input[name='password']").val();
		var confirmPassword=$("#confirmPassword").val();
		if(!phone){
			$("#errorcontent_p").html("请填写手机号");
			$("#error_a").click();
		}else if(phone.length!=11){
			$("#errorcontent_p").html("请确认手机号");
			$("#error_a").click();
		}else if(!email){
			$("#errorcontent_p").html("请填写邮箱");
			$("#error_a").click();
		}else if(!username){
			$("#errorcontent_p").html("请填写姓名");
			$("#error_a").click();
		}else if(!cardNum){
			alert("请填写证件号码");
			$("#errorcontent_p").html("请填写手机号");
			$("#error_a").click();
		}else if(cardType==1&&cardNum.length!=17&&cardNum.length!=18){
			$("#errorcontent_p").html("请确认身份证号码");
			$("#error_a").click();
		}else if(!password){
			$("#errorcontent_p").html("请输入密码");
			$("#error_a").click();
		}else if(password.length<6||password.length>18){
			$("#errorcontent_p").html("密码为6-18位");
			$("#error_a").click();
		}else if(!confirmPassword){
			$("#errorcontent_p").html("请确认密码");
			$("#error_a").click();
		}else if(password!=confirmPassword){
			$("#errorcontent_p").html("输入密码不一致");
			$("#error_a").click();
		}else{
			if($("#sendSMS").css("color")=="rgb(204, 204, 204)"){
				return;
			}
			$.ajax({
				url:"userAction!sendRegisterMsg",
				data:{'phoneNum':phone},
				dataType:"json",
				type: "POST",
				success:function(result){
						if(result.success){
							$("#sendSMS").html("<span id='jscount'>59</span>秒后重新发送");
							$("#sendSMS").attr("disabled",true);
							$("#sendSMS").css("color","#CCC");
							setTimeout("jscount();",1000);
							$("#errorcontent_p").html("发送成功，请注意查收短信");
						}else{
							$("#errorcontent_p").html(result.msg);
						}
						$("#error_a").click();
				},
				failure:function(result){
					
				}
			});
		}
	});
});
function jscount(){
	var i=$("#jscount").html();
	i--;
	if(i==0){
		$("#sendSMS").html("<span id='jscount' style='display:none;'>59</span>点击重新发送");
		$("#sendSMS").attr("disabled",false);
		$("#sendSMS").css("color","#FFF");
	}else{
		$("#jscount").html(i);
		setTimeout("jscount();",1000);
	}
	
}
function showAndHide(showid,thisid,hideid,otherid,value){
	$("#"+thisid).attr("class","serviceSelect");
	if(showid&&hideid){
	 $("#"+showid).show();
	 $("#"+hideid).hide();
	}
	$("#"+otherid).attr("class","service");
	$('#servicetype').val(value);
	showServiceDesc(thisid);
}
function showServiceDesc(thisid){
	if(thisid=="allpoint"){
		$("#servicedesc").html("全天包车包括车辆使用8小时或100公里");
	}else if(thisid=="halfpoint"){
		$("#servicedesc").html("半天包车包括车辆使用4小时或60公里");
	}
	
}
function validateRegister(){
	var phone=$("input[name='phone']").val();
	var email=$("input[name='email']").val();
	var cemail=$("input[name='cemail']").val();
	var username=$("input[name='username']").val();
	var cardNum=$("input[name='cardNum']").val();
	var cardType=$("select[name='cardType']").val();
	var password=$("input[name='password']").val();
	var confirmPassword=$("#confirmPassword").val();
	var code=$("#code").val();
	if(!phone){
		$("#errorcontent_p").html("请填写手机号");
		$("#error_a").click();
	}else if(phone.length!=11){
		$("#errorcontent_p").html("请确认手机号");
		$("#error_a").click();
	}else if(!email){
		$("#errorcontent_p").html("请填写邮箱");
		$("#error_a").click();
	}else if(!username){
		$("#errorcontent_p").html("请填写姓名");
		$("#error_a").click();
	}else if(!cardNum){
		alert("请填写证件号码");
		$("#errorcontent_p").html("请填写手机号");
		$("#error_a").click();
	}else if(cardType==1&&cardNum.length!=17&&cardNum.length!=18){
		$("#errorcontent_p").html("请确认身份证号码");
		$("#error_a").click();
	}else if(!password){
		$("#errorcontent_p").html("请输入密码");
		$("#error_a").click();
	}else if(password.length<6||password.length>18){
		$("#errorcontent_p").html("密码为6-18位");
		$("#error_a").click();
	}else if(!confirmPassword){
		$("#errorcontent_p").html("请确认密码");
		$("#error_a").click();
	}else if(password!=confirmPassword){
		$("#errorcontent_p").html("输入密码不一致");
		$("#error_a").click();
	}else if(!code){
		$("#errorcontent_p").html("请输入验证码");
		$("#error_a").click();
	}else{
		$.ajax({
			url:"userAction!isVildate",
			data:{'code':code},
			dataType:"json",
			type: "POST",
			success:function(result){
			    if(result.success){
			    	$("#registerForm").submit();
			    }else{
			    	$("#errorcontent_p").html(result.msg);
					$("#error_a").click();
			    }
			},
			failure:function(result){
				
			}
		});
	}
}
function validateLogin(){
	var userinfo=$("input[name='userinfo']").val();
	var password=$("input[name='password']").val();
	if(!userinfo){
		$("#errorcontent_p").html("请输入账号");
		$("#error_a").click();
	}else if(!password){
		$("#errorcontent_p").html("请输入密码");
		$("#error_a").click();
	}else{
		$("#loginForm").submit();
	}
}
function submitAircurrentForm(){
	var show=false;
    var content="";
	if($("form:visible").attr("id")=="aircomeForm"){
		  if(!$("#comeAir_extra2").val()){
			  content="请输入航班号";
			  show=true;
		  }else if(!$("#comeAir_extra3").val()){
			  content="请输入航班日期";
			  show=true;
		  }else if(!$("#comeAir_time").val()){
			  content="请输入用车时间";
			  show=true;
		  }else if(!$("#comeAir_count").val()){
			  content="请输入乘车人数";
			  show=true;
		  }else if(!$.isNumeric($('#comeAir_count').val())||parseInt($('#comeAir_count').val())<0){
			  content="请确认乘车人数";
			  show=true;
		  }
	}else {
		  if(!$("#sendAir_time").val()){
			  content="请输入用车时间";
			  show=true;
		  }else if(!$("#sendAir_startAddress").val()){
			  show=true;
			  content="请输入上车地点";
		  }else if(!$("#sendAir_count").val()){
			  show=true;
			  content="请输入乘车人数";
		  }else if(!$.isNumeric($('#sendAir_count').val())||parseInt($('#sendAir_count').val())<0){
			  content="请确认乘车人数";
			  show=true;
		  }
	}
	if(show){
		$("#errorcontent_p").html(content);
		$("#error_a").click();
	}else{
		$("form:visible").submit();
	}
}
function submitDateForm(){
	var show=false;
    var content="";
	  if(!$("#dateservice_time").val()){
		  content="请输入用车时间";
		  show=true;
	  }else if(!$("#dateservice_startAddress").val()){
		  content="请输入上车地点";
		  show=true;
	  }else if(!$("#dateservice_count").val()){
		  content="请输入乘车人数";
		  show=true;
	  }else if(!$.isNumeric($('#dateservice_count').val())||parseInt($('#dateservice_count').val())<0){
		  content="请确认乘车人数";
		  show=true;
	  }else if(!$("#dateservice_endAddress").val()){
		  content="请输入下车地点";
		  show=true;
	  }
	  if(show){
		    $("#error_a").click();
			$("#errorcontent_p").html(content);
		}else{
			$("form").submit();
		}
}
function submitMeetForm(){
	var show=false;
    var content="";
	  if(!$("#meet_time").val()){
		  content="请输入用车时间";
		  show=true;
	  }else if(!$("#meet_count").val()){
		  content="请输入乘车人数";
		  show=true;
	  }else if(!$.isNumeric($('#meet_count').val())||parseInt($('#meet_count').val())<0){
		  content="请确认乘车人数";
		  show=true;
	  }else if(!$("#meet_user_name").val()){
		  content="请输入联系人";
		  show=true;
	  }else if(!$("#meet_user_phone").val()){
		  content="请输入联系电话";
		  show=true;
	  }else if(!$.isNumeric($('#meet_count').val())){
		  content="请确认联系电话";
		  show=true;
	  }
	  if(show){
		    $("#error_a").click();
			$("#errorcontent_p").html(content);
		}else{
			$("form").submit();
		}
}
function submitPointForm(){
	var show=false;
    var content="";
    if(!$("#point_time").val()){
    	  content="请输入用车时间";
		  show=true;
	  }else if(!$("#point_startAddress").val()){
		  content="请输入上车地点";
		  show=true;
	  }else if(!$("#point_endAddress").val()){
		  content="请输入下车地点";
		  show=true;
	  }else if(!$("#point_count").val()){
		  content="请输入乘车人数";
		  show=true;
	  }else if(!$.isNumeric($('#point_count').val())||parseInt($('#point_count').val())<0){
		  content="请确认乘车人数";
		  show=true;
	  }
	  if(show){
		    $("#error_a").click();
			$("#errorcontent_p").html(content);
		}else{
			$("form").submit();
		}
}
function submitSuburbForm(){
	var show=false;
    var content="";
    if(!$("#suburb_time").val()){
    	  content="请输入用车时间";
		  show=true;
	  }else if(!$("#suburb_startAddress").val()){
		  content="请输入上车地点";
		  show=true;
	  }else if(!$("#suburb_endAddress").val()){
		  content="请输入下车地点";
		  show=true;
	  }else if(!$("#suburb_count").val()){
		  content="请输入乘车人数";
		  show=true;
	  }else if(!$.isNumeric($('#suburb_count').val())||parseInt($('#suburb_count').val())<0){
		  content="请确认乘车人数";
		  show=true;
	  }
	  if(show){
		    $("#error_a").click();
			$("#errorcontent_p").html(content);
		}else{
			$("form").submit();
		}
}
function cancelOrderForm(){
	$("#cancel_content").val("");
   if($('input[class="cannel_checkbox"]:checked').length>0){
	   var content="";
	   $.each($('input[class="cannel_checkbox"]:checked'),function(i,val){
	    	if($("#cancel_content").val()){
	    		content=$("#cancel_content").val()+","
	    	}
	    	content+=$(val).val();
	    	$("#cancel_content").val(content)
	    });
	  
	   $("form").submit();
   }else{
	    $("#error_a").click();
		$("#errorcontent_p").html("请至少选择一项");
   }
}
function forgetvalidateRegister(){
	var phone=$("input[name='phone']").val();
	var code=$("#code").val();
	if(!phone){
		$("#errorcontent_p").html("请填写手机号");
		$("#error_a").click();
	}else if(phone.length!=11){
		$("#errorcontent_p").html("请确认手机号");
		$("#error_a").click();
	}else{
		$.ajax({
			url:"userAction!isVildate",
			data:{'code':code},
			dataType:"json",
			type: "POST",
			success:function(result){
			    if(result.success){
			    	location.href=result.msg+"?phone="+phone;
			    }else{
			    	$("#errorcontent_p").html(result.msg);
					$("#error_a").click();
			    }
			},
			failure:function(result){
				
			}
		});
	}
}
function updatevalidateRegister(){
	var password=$("input[name='password']").val();
	var confirmPassword=$("#confirmPassword").val();
if(!password){
		$("#errorcontent_p").html("请输入密码");
		$("#error_a").click();
	}else if(password.length<6||password.length>18){
		$("#errorcontent_p").html("密码为6-18位");
		$("#error_a").click();
	}else if(!confirmPassword){
		$("#errorcontent_p").html("请确认密码");
		$("#error_a").click();
	}else if(password!=confirmPassword){
		$("#errorcontent_p").html("输入密码不一致");
		$("#error_a").click();
	}else{
		$("#updateForm").submit();
	}
}