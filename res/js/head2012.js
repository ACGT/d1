/////head.js
function stepNavAction(step){
	}
function searchbut() {
	var searchKey = $('#ffb9_input').val();
	if(searchKey == "" || searchKey == "请输入您要搜索的商品名称或编码"){
		alert("请输入您要搜索的商品名称或编码");
		$('#headsearchkey').focus();
		return;
	}
    var url = "/search.jsp?headsearchkey="+encodeURIComponent($('#ffb9_input').val());
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
$(function(){
	$('#head_nav2 > li > a:first-child').each(function(i){
		//if(i == 0) return true;
		$(this).mouseover(function(){
			$(this).parent().addClass("hover");
		});
		$(this).mouseout(function(){
			$(this).parent().removeClass("hover");
		});
	});
	$('#head_nav1 > li > a:first-child').each(function(i){
		//if(i == 0) return true;
		$(this).mouseover(function(){
			$(this).parent().addClass("hover");
		});
		$(this).mouseout(function(){
			$(this).parent().removeClass("hover");
		});
	});
	$('#ffb9_input').keydown(function(){
		keydownsearch();
	}).focus(function(){
		if(this.value=='请输入您要搜索的商品名称或编码'){this.value='';this.style.color='#333'}
	}).blur(function(){
		if(this.value==''){this.value='请输入您要搜索的商品名称或编码';this.style.color='#999999'}
	});
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
    var xx = false;
    $('#left_btn').mouseenter(function(){
    	$(this).css({"backgroundImage":"url(http://images.d1.com.cn/images2012/New/x_qbfl2.gif)","width":"186px","marginLeft":"0px"});
    	xx = false;
    	$('#comsbox').show();
    }).bind("mouseleave",function(){
    	xx = true;
    	setTimeout(function(){
    		if(xx){
    			$('#left_btn').css({"backgroundImage":"url(http://images.d1.com.cn/images2012/New/x_qbfl.gif)","width":"146px","marginLeft":"19px"});
    		}
    	},50);
    	$('#comsbox').hide();
    });
	$('#comsbox').mouseover(function(){xx = false;$('#comsbox').show();}).bind("mouseleave",function(){
		xx = true;
		setTimeout(function(){
			if(xx){
				$('#comsbox').hide();
				$('#left_btn').css({"backgroundImage":"url(http://images.d1.com.cn/images2012/New/x_qbfl.gif)","width":"146px","marginLeft":"19px"});
			}
		},50);
	});
	$('#comsbox').find(".item").each(function(){
		var _this = $(this);
		_this.mouseover(function(){
			xx = false;
			$('#comsbox').show();
			_this.addClass("hover");
		}).bind("mouseleave",function(){
			xx = true;
			_this.removeClass("hover");
			setTimeout(function(){
				if(xx){
					$('#comsbox').hide();
					$('#left_btn').css({"backgroundImage":"url(http://images.d1.com.cn/images2012/New/x_qbfl.gif)","width":"146px","marginLeft":"19px"});
				}
			},50);
		});
	});
	$('#women').mouseover(function(){
		$('#wmenu').css("display","block");
	});
	$('#women').mouseout(function(){
		$('#wmenu').css("display","none");
	});
	$('#men').mouseover(function(){
		$('#mmenu').css("display","block");
	});
	$('#men').mouseout(function(){
		$('#mmenu').css("display","none");
	});
	$('#mmenu').mouseout(function(){
		$('#mmenu').css("display","none");
	});
	$('#mmenu').mouseover(function(){
		$('#mmenu').css("display","block");
	});
	$('#wmenu').mouseover(function(){
		$('#wmenu').css("display","block");
	});
	$('#wmenu').mouseout(function(){
		$('#wmenu').css("display","none");
	});
});
$('#ffb9').flexbox('/ajax/search/hotkeys.jsp', {
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


function displayfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","block");
}
function outfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","none");
}