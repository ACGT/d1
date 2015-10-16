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
function indexshow(){
	$('#sindex').removeClass('spanout');
	$('#sindex').addClass('spanover');
	$('#imenu').show();
}
function indexhide(){
	$('#sindex').removeClass('spanover');
	$('#sindex').addClass('spanout');
	$('#imenu').hide();
}

function manhide(){
	$('#sman').removeClass('spanover');
	$('#sman').addClass('spanout');
	$('#manmenu').hide();
}

function womanhide(){
	$('#swoman').removeClass('spanover');
	$('#swoman').addClass('spanout');
	$('#womanmenu').hide();
}
function qzhide(){
	$('#squnzi').removeClass('spanover');
	$('#squnzi').addClass('spanout');
	$('#qzmenu').hide();
}
function kzhide(){
	$('#skuzi').removeClass('spanover');
	$('#skuzi').addClass('spanout');
	$('#kzmenu').hide();
}
function hzphide(){
	$('#shzp').removeClass('spanover');
	$('#shzp').addClass('spanout');
	$('#hzpmenu').hide();
	
}
function sphide(){
	$('#ssp').removeClass('spanover');
	$('#ssp').addClass('spanout');
	$('#spmenu').hide();
}
function baghide(){
	$('#sbag').removeClass('spanover');
	$('#sbag').addClass('spanout');
	$('#bagmenu').hide();
}
function pshide(){
	$('#sshoes').removeClass('spanover');
	$('#sshoes').addClass('spanout');
	$('#shoesmenu').hide();
}
function watchhide(){
	$('#swatch').removeClass('spanover');
	$('#swatch').addClass('spanout');
	$('#watchmenu').hide();
}
function dphide(){
	$('#sdp').removeClass('spanover');
	$('#sdp').addClass('spanout');
	$('#dpmenu').hide();
}
function newhide(){
	$('#snewp').removeClass('spanover');
	$('#snewp').addClass('spanout');
	$('#newpmenu').hide();
}
function hothide(){
	$('#shot').removeClass('spanover');
	$('#shot').addClass('spanout');
	$('#hotmenu').hide();
}

function manshow(){
	$('#sman').removeClass('spanout');
	$('#sman').addClass('spanover');
	$('#manmenu').show();	
}
function womanshow(){
	$('#swoman').removeClass('spanout');
	$('#swoman').addClass('spanover');
	$('#womanmenu').show();
}
function qunzishow(){
	$('#squnzi').removeClass('spanout');
	$('#squnzi').addClass('spanover');
	$('#qzmenu').show();
}
function kzshow(){
	$('#skuzi').removeClass('spanout');
	$('#skuzi').addClass('spanover');
	$('#kzmenu').show();
}
function zpshow(){
	$('#shzp').removeClass('spanout');
	$('#shzp').addClass('spanover');
	$('#hzpmenu').show();
}
function spshow(){
	$('#ssp').removeClass('spanout');
	$('#ssp').addClass('spanover');
	$('#spmenu').show();
}
function bagshow(){
	$('#sbag').removeClass('spanout');
	$('#sbag').addClass('spanover');
	$('#bagmenu').show();
}
function shoesshow(){
	$('#sshoes').removeClass('spanout');
	$('#sshoes').addClass('spanover');
	$('#shoesmenu').show();
}
function watchshow(){
	$('#swatch').removeClass('spanout');
	$('#swatch').addClass('spanover');
	$('#watchmenu').show();
}
function dpshow(){
	$('#sdp').removeClass('spanout');
	$('#sdp').addClass('spanover');
	$('#dpmenu').show();
}
function newshow(){
	$('#snewp').removeClass('spanout');
	$('#snewp').addClass('spanover');
	$('#newpmenu').show();
}
function hotshow(){
	$('#shot').removeClass('spanout');
	$('#shot').addClass('spanover');
	$('#hotmenu').show();
}
$(function(){
	var culr=window.location.href;
	//alert(culr);
	
	if(culr.indexOf("http://www.d1.com.cn/html/men")>=0){
		manshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/women")>=0){
		womanshow();
	}else if(culr.indexOf("http://www.d1.com.cn/result.jsp?productsort=020006,020007,030006,030007")>=0){
		//qunzishow();
	}else if(culr.indexOf("http://www.d1.com.cn/result.jsp?productsort=020008,020009,030008,030009&order=3")>=0){
		kzshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/cosmetic")>=0){
		zpshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/ornament")>=0){
		spshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/bag")>=0){
		bagshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/watch")>=0){
		watchshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/news/")>=0){
		newshow();
	}else if(culr.indexOf("http://www.d1.com.cn/gdscene/all.jsp")>=0){
		dpshow();
	}else if(culr.indexOf("http://www.d1.com.cn/html/zt2012/0214week/")>=0){
		hotshow();
	}else if(culr.indexOf("http://www.d1.com.cn/result.jsp?productsort=021,022,031,032&order=3")>=0){
		shoesshow();
	}else if(culr.indexOf("http://www.d1.com.cn/product/")>=0){
		
	}else if(culr.indexOf("http://www.d1.com.cn/producttest.jsp?id=")>=0){
		
	}else if(culr.indexOf("http://www.d1.com.cn/result.jsp")>=0){
		
	}else if(culr.indexOf("http://www.d1.com.cn/resulttest.jsp")>=0){
		
	}else if(culr.indexOf("http://www.d1.com.cn/html/resulttj.asp")>=0){
		
	}else if(culr.indexOf("http://www.d1.com.cn/search.jsp?key_wds=6KOk&sort=createtime&asc=false")>=0){
		kzshow();
	}
	else{
	
		indexshow();
	}

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

	
	$('#sindex').mouseover(function(){
		manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		
		indexshow();
	});
	$('#sindex').mouseout(function(){
		//$('#sindex').removeClass('spanover');
		//$('#sindex').addClass('spanout');
		//$('#imenu').hide();
	});
	$('#imenu').mouseover(function(){
		indexshow();
	});
	$('#imenu').mouseout(function(){
		//$('#sindex').removeClass('spanover');
		//$('#sindex').addClass('spanout');
		//$('#imenu').hide();
	});
	
	$('#sman').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		manshow();
		
	});
	$('#sman').mouseout(function(){
		//$('#sman').removeClass('spanover');
		//$('#sman').addClass('spanout');
		//$('#manmenu').hide();
		//indexshow();
	});
	
	$('#manmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		manshow();
	});
	$('#manmenu').mouseout(function(){
		//$('#sman').removeClass('spanover');
		//$('#sman').addClass('spanout');
		//$('#manmenu').hide();
		//indexshow();
	});
	
	
	
	$('#swoman').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		womanshow();
	});
	$('#swoman').mouseout(function(){
		//$('#swoman').removeClass('spanover');
		//$('#swoman').addClass('spanout');
		//$('#womanmenu').hide();
	//	indexshow();
	});
	
	$('#womanmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		womanshow();
	});
	$('#womanmenu').mouseout(function(){
		
		//$('#swoman').removeClass('spanover');
		//$('#swoman').addClass('spanout');
		//$('#womanmenu').hide();
		//indexshow();
	});
	
	$('#squnzi').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		qunzishow();
		
	});
	$('#squnzi').mouseout(function(){
		//$('#squnzi').removeClass('spanover');
		//$('#squnzi').addClass('spanout');
		//$('#qzmenu').hide();
		//indexshow();
	});
	
	$('#qzmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		qunzishow();
	});
	$('#qzmenu').mouseout(function(){
		//$('#squnzi').removeClass('spanover');
		//$('#squnzi').addClass('spanout');
		//$('#qzmenu').hide();
		//indexshow();
	});
	
	
	$('#skuzi').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		kzshow();
	});
	$('#skuzi').mouseout(function(){
		//$('#skuzi').removeClass('spanover');
		//$('#skuzi').addClass('spanout');
		//$('#kzmenu').hide();
		//indexshow();
	});
	
	$('#kzmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		kzshow();
	});
	$('#kzmenu').mouseout(function(){
		//$('#skuzi').removeClass('spanover');
		//$('#skuzi').addClass('spanout');
		//$('#kzmenu').hide();
		//indexshow();
	});
	
	
	$('#shzp').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		zpshow();
		
	});
	$('#shzp').mouseout(function(){
		//$('#shzp').removeClass('spanover');
		//$('#shzp').addClass('spanout');
		//$('#hzpmenu').hide();
		//indexshow();
	});
	
	$('#hzpmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		zpshow();
	});
	$('#hzpmenu').mouseout(function(){
		//$('#shzp').removeClass('spanover');
		//$('#shzp').addClass('spanout');
		//$('#hzpmenu').hide();
		//indexshow();
	});
	
	$('#ssp').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		spshow();
		
	});
	$('#ssp').mouseout(function(){
		//$('#ssp').removeClass('spanover');
		//$('#ssp').addClass('spanout');
		//$('#spmenu').hide();
		//indexshow();
	});
	
	$('#spmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		spshow();
	});
	$('#spmenu').mouseout(function(){
		//$('#ssp').removeClass('spanover');
		//$('#ssp').addClass('spanout');
		//$('#spmenu').hide();
		//indexshow();
	});
	
	
	$('#sbag').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		bagshow();
	});
	$('#sbag').mouseout(function(){
		//$('#sbag').removeClass('spanover');
		//$('#sbag').addClass('spanout');
		//$('#bagmenu').hide();
		//indexshow();
	});
	
	
	$('#bagmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		bagshow();
	});
	$('#bagmenu').mouseout(function(){
		//$('#sbag').removeClass('spanover');
		//$('#sbag').addClass('spanout');
		//$('#bagmenu').hide();
		//indexshow();
	});
	
	$('#sshoes').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		shoesshow();
	});
	$('#sshoes').mouseout(function(){
		//$('#sshoes').removeClass('spanover');
		//$('#sshoes').addClass('spanout');
		//$('#shoesmenu').hide();
		//indexshow();
	});
	
	$('#shoesmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		shoesshow();
	});
	$('#shoesmenu').mouseout(function(){
		//$('#sshoes').removeClass('spanover');
		//$('#sshoes').addClass('spanout');
		//$('#shoesmenu').hide();
		//indexshow();
	});
	
	$('#swatch').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		watchshow();
	});
	$('#swatch').mouseout(function(){
		//$('#swatch').removeClass('spanover');
		//$('#swatch').addClass('spanout');
		//$('#watchmenu').hide();
		//indexshow();
	});
	
	
	$('#watchmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		watchshow();
	});
	$('#watchmenu').mouseout(function(){
		//$('#swatch').removeClass('spanover');
		//$('#swatch').addClass('spanout');
		//$('#watchmenu').hide();
		//indexshow();
	});
	

	$('#sdp').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		dpshow();
	});
	$('#sdp').mouseout(function(){
		//$('#sdp').removeClass('spanover');
		//$('#sdp').addClass('spanout');
		//$('#dpmenu').hide();
		//indexshow();
	});
	
	$('#dpmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		dpshow();
	});
	$('#dpmenu').mouseout(function(){
		//$('#sdp').removeClass('spanover');
		//$('#sdp').addClass('spanout');
		//$('#dpmenu').hide();
	});
	
	
	$('#snewp').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		newshow();
	});
	$('#snewp').mouseout(function(){
		//$('#snewp').removeClass('spanover');
		//$('#snewp').addClass('spanout');
		//$('#newpmenu').hide();
		//indexshow();
	});
	
	$('#newpmenu').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		newshow();
	});
	$('#newpmenu').mouseout(function(){
		//$('#snewp').removeClass('spanover');
		//$('#snewp').addClass('spanout');
		//$('#newpmenu').hide();
		//indexshow();
	});
	
	$('#shot').mouseover(function(){
		indexhide();manhide();womanhide();qzhide();kzhide();hzphide();sphide();baghide();pshide();watchhide();dphide();newhide();hothide();
		hotshow();
	});
	$('#shot').mouseout(function(){
		//$('#shot').removeClass('spanover');
		//$('#shot').addClass('spanout');
		//$('#hotmenu').hide();
		//indexshow();
	});
	
	$('#hotmenu').mouseover(function(){
		hotshow();
	});
	$('#hotmenu').mouseout(function(){
		//$('#shot').removeClass('spanover');
		//$('#shot').addClass('spanout');
		//$('#hotmenu').hide();
		//indexshow();
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