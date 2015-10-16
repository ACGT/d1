//+---------------------------------------------------  
//| 日期时间检查  
//| 格式为：YYYY-MM-DD HH:MM:SS  
//+---------------------------------------------------  
function CheckDateTime(str)  
{   
    //var reg = /^(\d+)-(\d{1,2})-(\d{ 1,2 }) (\d{ 1,2 }):(\d{ 1,2 }):(\d{ 1,2 })$/; 
    var rr=/^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/;   
    	   if(!rr.test(str)) {
    		   alert('请输入正确的时间格式，如：2013-01-27 22:12:00');   
    		   return false;
    	   }  
    return true;   
}   

function checkDate(str){
	 var thePat = /^\d{4}-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2]\d|3[0-1]) ([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;   
     if(!thePat.test(str)){   
         return true;   
     }   
     else{   
         return false;   
     }   
	} 

function actadd(obj){
	var req_name=$('#req_name').val();
	if(req_name==''){
	alert('促销活动名称 不能为空');
    return;
     }
    var req_type=$('#req_type option:selected').val();  
    var req_status=$('#req_status option:selected').val();  
	var req_sdate=$('#req_sdate').val();
	var req_edate=$('#req_edate').val();
	if(req_sdate==''){
		alert('促销活动开始时间不能为空');
	    return;
	}
	if(req_edate==''){
		alert('促销活动结束时间不能为空');
	    return;
	}

	 if(req_sdate!=''&&!CheckDateTime(req_sdate)){
		   alert('促销开始时间格式不正确，正确的为：2013-01-01 00:00:00');
		   return;
	   }
	   if(req_edate!=''&&!CheckDateTime(req_edate)){
		   alert('促销结束时间格式不正确，正确的为：2013-01-01 00:00:00');
		   return;
	   }
	   var req_snum1=$('#req_snum1').val();
	   var req_enum1=$('#req_enum1').val();
	   var req_snum2=$('#req_snum2').val();
	   var req_enum2=$('#req_enum2').val();
	   var req_snum3=$('#req_snum3').val();
	   var req_enum3=$('#req_enum3').val();
	   if(req_snum1==''||req_enum1==''){
		   alert('第一阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum1)||isNaN(req_enum1)){
		   alert('第一阶设置必须为数值');
		    return;
	   }
	   if(parseInt(req_snum1)<0||parseInt(req_enum1)<0){
		   alert('第一阶设置数值必须大于0');
		    return;
	   }
	   if(req_snum2==''||req_enum2==''){
		   alert('第二阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum2)||isNaN(req_enum2)){
		   alert('第二阶设置必须为数值');
		    return;
	   }
	   if((parseInt(req_snum2)>0&&parseInt(req_enum2)<=0)||(parseInt(req_snum2)<=0&&parseInt(req_enum2)>0)){
		   alert('第二阶设置数值必须大于0');
		    return;
	   }
	   if(req_snum3==''||req_enum3==''){
		   alert('第三阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum3)||isNaN(req_enum3)){
		   alert('第三阶设置必须为数值');
		    return;
	   }
	   if((parseInt(req_snum3)>0&&parseInt(req_enum3)<=0)||(parseInt(req_snum3)<=0&&parseInt(req_enum3)>0)){
		   alert('第三阶设置数值必须大于0');
		    return;
	   }
	   var req_ppcode='';
	   if(req_type=='1' ){
		   req_ppcode=$('#req_ppcode').val();
	   }
	   var req_memo=$('#req_memo').val();
	   if(req_type=='1' && req_ppcode==""){
		   alert('推荐位号不能为空');
		    return;
	   }
	   var req_brandcode='';
	   if(req_type=='2' ){
		   req_brandcode=$('#req_brandcode').val();
	   }
	   if(req_type=='2' && req_brandcode==""){
		   alert('品牌编号不能为空');
		    return;
	   }
	   
	   
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/addshopact.jsp',
		cache: false,
		data: {name:req_name,sdate:req_sdate,edate:req_edate,type:req_type,snum1:req_snum1,enum1:req_enum1
			,snum2:req_snum2,enum2:req_enum2,snum3:req_snum3,enum3:req_enum3,ppcode:req_ppcode,memo:req_memo,status:req_status,brandcode:req_brandcode},
		error: function(XmlHttpRequest){
			$.alert('添加错误请联系管理员！');
		},success: function(json){
			if(json.success){
			$.alert(json.message,'提示',function(){
	        		this.location.href="/admin/SHManage/shopact/acttbup.jsp?id="+json.actid;
	        		});
		}else{
			$.alert(json.message);
		}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function acttbup(obj){
	var id=$('#id').val();
	if(id==''){
	alert('活动编号不能为空');
    return;
     }
	var req_name=$('#req_name').val();
	if(req_name==''){
	alert('促销活动名称 不能为空');
    return;
     }
    var req_type=$('#req_type option:selected').val();  
    var req_status=$('#req_status option:selected').val();  
	var req_sdate=$('#req_sdate').val();
	var req_edate=$('#req_edate').val();
	if(req_sdate==''){
		alert('促销活动开始时间不能为空');
	    return;
	}
	if(req_edate==''){
		alert('促销活动结束时间不能为空');
	    return;
	}

	 if(req_sdate!=''&&!CheckDateTime(req_sdate)){
		   alert('促销开始时间格式不正确，正确的为：2013-01-01 00:00:00');
		   return;
	   }
	   if(req_edate!=''&&!CheckDateTime(req_edate)){
		   alert('促销结束时间格式不正确，正确的为：2013-01-01 00:00:00');
		   return;
	   }
	   var req_snum1=$('#req_snum1').val();
		var req_enum1=$('#req_enum1').val();
		var req_snum2=$('#req_snum2').val();
		var req_enum2=$('#req_enum2').val();
		var req_snum3=$('#req_snum3').val();
		var req_enum3=$('#req_enum3').val();
	   if(req_snum1==''||req_enum1==''){
		   alert('第一阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum1)||isNaN(req_enum1)){
		   alert('第一阶设置必须为数值');
		    return;
	   }
	   if(parseInt(req_snum1)<0||parseInt(req_enum1)<0){
		   alert('第一阶设置数值必须大于0');
		    return;
	   }
	   if(req_snum2==''||req_enum2==''){
		   alert('第二阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum2)||isNaN(req_enum2)){
		   alert('第二阶设置必须为数值');
		    return;
	   }
	   if((parseInt(req_snum2)>0&&parseInt(req_enum2)<=0)||(parseInt(req_snum2)<=0&&parseInt(req_enum2)>0)){
		   alert('第二阶设置数值必须大于0');
		    return;
	   }
	   if(req_snum3==''||req_enum3==''){
		   alert('第三阶设置不能为空');
		    return;
	   }
	   if(isNaN(req_snum3)||isNaN(req_enum3)){
		   alert('第三阶设置必须为数值');
		    return;
	   }
	   if((parseInt(req_snum3)>0&&parseInt(req_enum3)<=0)||(parseInt(req_snum3)<=0&&parseInt(req_enum3)>0)){
		   alert('第三阶设置数值必须大于0');
		    return;
	   }
	   var req_ppcode='';
	   if(req_type=='1' ){
		   req_ppcode=$('#req_ppcode').val();
	   }
	 
	   if(req_type=='1' && req_ppcode==""){
		   alert('推荐位号不能为空');
		    return;
	   }
	   var req_brandcode='';
	   if(req_type=='2' ){
		   req_brandcode=$('#req_brandcode').val();
	   }
	   if(req_type=='2' && req_brandcode==""){
		   alert('品牌编号不能为空');
		    return;
	   }
	   var req_memo=$('#req_memo').val();
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/upshopact.jsp',
		cache: false,
		data: {id:id,name:req_name,sdate:req_sdate,edate:req_edate,type:req_type,snum1:req_snum1,enum1:req_enum1
			,snum2:req_snum2,enum2:req_enum2,snum3:req_snum3,enum3:req_enum3,ppcode:req_ppcode,memo:req_memo,status:req_status,brandcode:req_brandcode},
		error: function(XmlHttpRequest){
			$.alert('修改错误请联系管理员！');
		},success: function(json){
		$.alert(json.message);
		
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function actgetlist(obj){
	var req_name=$('#req_name').val();
    var req_type=$('#req_type option:selected').val();  
    var req_status=$('#req_status option:selected').val();  
    
	var req_stime=$('#req_stime').val();
	var req_etime=$('#req_etime').val();


$.get("/admin/ajax/getactlist.jsp",{"req_name":req_name,"req_type":req_type,"req_status":req_status,"req_stime":req_stime
	,"req_etime":req_etime,"m":new Date().getTime()},function(data){
	$('#actlist').html(data);
});
}
