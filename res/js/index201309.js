function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_H=Math.floor((the_s[the_s_index])/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "";	        
	        if( the_H!=0) html += '<td width="34">'+(the_H)+'</td><td width="10"></td>';
	        if(the_H!=0 || the_M!=0) html += '<td width="35">'+the_M+'</td><td width="15"></td>';
	        html += '<td width="35">'+the_S+'</td>';
	        $('#'+objid).html(html);
	        the_s[the_s_index]--;
	    }else{
	        $('#'+objid).html('已结束');
	    }
}	
function GetOtherDPDetail(o)
{
	   var obj=$(o).parent();
	   if($(obj).find('li').length>2)
	   {
		    $(obj).find('li:first').stop().slideUp(200,function(){(obj).find('li:last').after($(obj).find('li:first'));});
			$(obj).find('li').eq(2).css('height','125px').slideDown(200);		
		}   
}


function GetIndex_hdgg(ws)
{
	if(ws>1200){
		$('#hdgg_index').css('width','1200px');
	}
	else{
		$('#hdgg_index').css('width','980px');
	}
	$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/index/getRMHD.jsp',
		cache: false,
		data: {w:ws},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
			$('#hdgg_index').html(strRet);
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}
function GetIndex_R(ws)
{
	if(ws>1200){
		$('.rmhd_1').css('width','1200px');
	}
	else{
		$('.rmhd_1').css('width','980px');
	}
	$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/index/getR.jsp',
		cache: false,
		data: {w:ws},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
			$('.rmhd_1').html(strRet);
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}
function GetCloth(ws,flag,obj)
{
	$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/index/get_Cloth.jsp',
		cache: false,
		data: {w:ws,f:flag},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
			$('#'+obj).html(strRet);
			
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}
function GetOtherproduct(ws,flag,obj)
{
	if(ws>1200){		
		$('#'+obj).parent().css('width','1200px');		
	}
	else{
		$('#'+obj).parent().css('width','980px');	
	}
	$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/index/GetOtherProduct.jsp',
		cache: false,
		data: {w:ws,f:flag},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
				$('#'+obj).html(strRet);
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}
