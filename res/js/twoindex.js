function Getmen_left(ws,productsort)
{
	if(ws>1200){
		$('#resultall').removeClass('bodywmin')
		$('#resultall').addClass('bodywbig')
		$('#topcls').removeClass('bodywmin')
		$('#topcls').addClass('bodywbig')
		$('#mbody').removeClass('bodywmin')
		$('#mbody').addClass('bodywbig')
		$('#picad').show();
		
	}
	else{
		$('#resultall').removeClass('bodywbig')
		$('#resultall').addClass('bodywmin')
		$('#topcls').removeClass('bodywbig')
		$('#topcls').addClass('bodywmin')
		$('#mbody').removeClass('bodywbig')
		$('#mbody').addClass('bodywmin')
		$('#picad').hide();
		
	}
	$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/html/getmenl.jsp',
		cache: false,
		data: {w:ws,productsort:productsort},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
			$('#mbodyl').html(strRet);
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}

function Getmen_rec(ws,code,count,divid)
{if(ws>1200){
	$('#stdlist').removeClass('stdtop')
	$('#stdlist').addClass('stdtopbig')
	$('#ssort').removeClass('sSort')
	$('#ssort').addClass('sSortbig')
	$('#mbodyr').removeClass('mbodyrmin')
	$('#mbodyr').addClass('mbodyrbig')
	$('#newlist').removeClass('newlistmin')
	$('#newlist').addClass('newlistbig')
	$('#pimg').removeClass('pimgmin')
	$('#pimg').addClass('pimgbig')
	
}else{
	$('#stdlist').removeClass('stdtopbig')
	$('#stdlist').addClass('stdtop')
	$('#ssort').removeClass('tsSortbig')
	$('#ssort').addClass('sSor')
	$('#mbodyr').removeClass('mbodyrbig')
	$('#mbodyr').addClass('mbodyrmin')
	$('#newlist').removeClass('newlistbig')
	$('#newlist').addClass('newlistmin')
	$('#pimg').removeClass('pimgbig')
	$('#pimg').addClass('pimgmin')
	
}
		$.ajax({
		type: "get",
		dataType: "text",
		url: '/ajax/html/getrec.jsp',
		cache: false,
		data: {w:ws,code:code,count:count},
		error: function(XmlHttpRequest,textStatus,erroeThrown){	
			
		},success: function(strRet){
			$('#rec'+divid).html(strRet);
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}