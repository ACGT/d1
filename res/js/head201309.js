function searchbut() {
	var searchKey = $('#ffb9_input').val();
	if(searchKey == "" || searchKey == "请输入您要搜索的商品名称或编码"){
		alert("请输入您要搜索的商品名称或编码");
		$('#headsearchkey').focus();
		return;
	}
    var url = "http://www.d1.com.cn/search.jsp?headsearchkey="+encodeURIComponent($('#ffb9_input').val());
    top.location.href=url;
}
function keydownsearch() {
    var event = event || window.event;
    var key = event.charCode || event.keyCode;
    if (key == 13) {
        searchbut();
    }
}
function showcard() {
	$.post("/ajax/flow/getHeadLoadFlow.jsp",{"m":new Date().getTime()},function(data){
		$('#Headcart').html(data);
		if($('#headFlow_totalGoods').length>0) $('#headcardnum').html($('#headFlow_totalGoods').html());
	});
}

//浮层距离计算
var allflPosition = function(t){
	var _default = [0,-12,-100,-160,-96,-50,-50,-22];
	//var _index = t.parent().index() - 1;
	var _index = t.attr('attr');
	var _top = t.offset().top + _default[_index];
	var _height = t.next('dd').outerHeight(true);
	var _sTop = $(window).scrollTop();
	var _wHeight = $(window).height();
	var boxtop;
	if(_top > _sTop && _top + _height < _sTop + _wHeight){boxtop = _default[_index];}
	else if(_top < _sTop){boxtop = Math.min(_default[_index] + (_sTop - _top) + 20,0);}
	else if(_top + _height > _sTop + _wHeight){boxtop = Math.max((_index) * -91 + 30,Math.max(_default[_index] - (_top + _height - _sTop - _wHeight) - 10,-(_height - 91)));}
	return boxtop;
}

$(function(){
	
	$.post("/ajax/user/getHeadLoginInfo2012.jsp",{"m":new Date().getTime()},function(json){
		
		$('#ShowWelcome').html(json.message);
		if(json.success){
			$('#headcardnum').html(json.cardNum);
		}
	},"json");
	var jincar = false;
	$("#headerbuy_list").hover(function() {
        if (jincar) return;
        //mouseover
        jincar = true;
        if (!$("#Headcart").is(":visible")) {
            $("#Headcart").fadeIn();
            showcard();
        }
    },function() {//mouseout
        jincar = false;
        setTimeout(function() {
            if (!jincar) {
                $("#Headcart").fadeOut();
            }
        }, 100);
    });
    $('#Headcart').hover(function() {
        jincar = true;
    }, function() {
        jincar = false;
        setTimeout(function() {
            if (!jincar) {
                $("#Headcart").fadeOut();
            }
        }, 100);
    });
	//导航经过
    if ($('.allfl dl:visible').length <= 0){
		if(!!window.ActiveXObject && !window.XMLHttpRequest){
			$('.allfl').hover(function(){
				$('.allfl dd').hide().parent().removeAttr('background','');
				
			});
		}else{
			$('.allfl').hover(function(){
				$('.allfl dd').hide().parent().removeAttr('background','');
				
			});		
		}
    }

	var listhide;
	var listout;
	var listhide1;

	/*$('.allfl').hover(function(e){
		var _self = this;
		clearTimeout(listhide);
		clearTimeout(listout);
		clearTimeout(listhide1);
		},function(e){
		listhide1 = setTimeout(function(){
	          $('.allfl dd').hide().parent().css('background','');
			},200);
		}
	    );*/
	$('.allfl').hover(function(e){
		
	},function(e){
	listhide1 = setTimeout(function(){
          $('.allfl dd').hide().parent().css('background','');
          $('.allfl dl').removeClass("lin");
          $('.allfl dl').find("i").remove();
		},200);
	}
    );

	$('.allfl dl dt').hover(function(e){
		var _self = this;
		clearTimeout(listhide);
		clearTimeout(listout);
		clearTimeout(listhide1);
			if($(_self).next().is(':visible')) return false;
			listhide = setTimeout(function(){
	          // $('.allfl dl').css('background','#fff');
	           $('.allfl dl dd').hide();
	           $('.allfl dl').removeClass("lin");
	           $('.allfl dl').find("i").remove();
	           $(_self).parent().addClass("lin");
	           $(_self).parent().append('<i class="rnolin"></i>');
	           $(_self).parent().find('dd').css('top',allflPosition($(_self))).show();
},200);
		});
	$('.allfl dl dd').hover(function(){
	clearTimeout(listhide);
	clearTimeout(listout);
	clearTimeout(listhide1);
    },function(e){
	var _self = this;	
	listout = setTimeout(function(){
		$(_self).hide().parent().removeAttr('style');
		  $(_self).parent().removeClass("lin");
		  $(_self).parent().find("i").remove();
	},300);
});
	
	$('.mlmj_top a').hover(function(i){	
		$('.mlmj_top a').css('background','url(http://images.d1.com.cn/images2013/newindex/hxbg.jpg) no-repeat');
		$('.mlmj_top a').css('color','#a8a8a8');
		$('.mlmj_div').css('display','none');
		$(this).css('background','url(http://images.d1.com.cn/images2013/newindex/glbg.jpg) no-repeat');
		$(this).css('color','#c90000');
		var j=$(this).attr('attr');
		$('.mlmj_div').eq(j).css('display','block');
		
	});
	
	
	
   
});

/*$('#ffb9').flexbox('/ajax/search/hotkeys.jsp', {
    autoCompleteFirstMatch: false,
    selectFirstMatch:false,
    noResultsText: '',
    paging: false,
    width:200,
    initialValue:'请输入您要搜索的商品名称或编码',
    inputClass:'',
    containerClass:'ffb',
    contentPos:{w:-7,t:-10,l:-1}
});
*/

function displayfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","block");
}
function outfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","none");
}

function displayAllFL(){
	var fdiv=$("#allfl");
	fdiv.css("display","block");
}
function outAllFL(){
	var fdiv=$("#allfl");
	fdiv.css("display","none");
}
function outMLMJ(obj){
	
	var fdiv=$("#mlmj").parent();
	if(fdiv.css('display')=='block'){
		fdiv.css("display","none");
		$(obj).parent().removeClass('current_page_item');
	}
	else{
		fdiv.css("display","block");
		$(obj).parent().addClass('current_page_item');
	}
	
}


