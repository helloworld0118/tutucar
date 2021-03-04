// JavaScript Document
function showAndHide(showid,thisid,hideid,otherid,value){
	$("#"+thisid).attr("class","serviceSelect");
	if(showid&&hideid){
	 $("#"+showid).show();
	 $("#"+hideid).hide();
	}
	$("#"+otherid).attr("class","service");
	$('#servicetype').val(value);
}
