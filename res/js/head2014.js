// JavaScript Document
function displayfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","block");
	fdiv.parent().addClass("hover");
}
function outfzh(){
	var fdiv=$("#floatzh");
	fdiv.css("display","none");
	fdiv.parent().removeClass("hover");
}
function searchbut() {
	var searchKey = $('#hm_searchtxt').val();
	if(searchKey == "" || searchKey == "请输入您要搜索的商品名称或编码"){
		$('#headsearchkey').focus();
		return;
	}
    var url = "http://www.d1.com.cn/search.jsp?headsearchkey="+encodeURIComponent($('#hm_searchtxt').val());
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
	$.post("/ajax/flow/getHeadLoadFlow2014.jsp",{"m":new Date().getTime()},function(data){
		$('#Headcart').html(data);
		if($('#headFlow_totalGoods').length>0) $('#headcardnum').html($('#headFlow_totalGoods').html());
	});
}

$(function(){
$.post("/ajax/user/getHeadLoginInfo2012.jsp",{"m":new Date().getTime()},function(json){
		
		$('#ShowWelcome').html(json.message);
		if(json.success){
			$('#headcardnum').html(json.cardNum);
		}
	},"json");
$('#hm_searchtxt').keydown(function(){
		keydownsearch();
	}).focus(function(){
		if(this.value=='请输入您要搜索的商品名称或编码'){this.value='';this.style.color='#333'}
	}).blur(function(){
		if(this.value==''){this.value='请输入您要搜索的商品名称或编码';this.style.color='#999999'}
	});
	/*购物车*/
	var jincar = false;
	$("#headerbuy_list").hover(function() {
		$(".hm_flowtxt").addClass("hover");
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
				$(".hm_flowtxt").removeClass("hover");
                $("#Headcart").fadeOut();
            }
        }, 100);
    });
    $('#Headcart').hover(function() {
		$(".hm_flowtxt").addClass("hover");
        jincar = true;
    }, function() {
        jincar = false;
        setTimeout(function() {
            if (!jincar) {
				$(".hm_flowtxt").removeClass("hover");
                $("#Headcart").fadeOut();
            }
        }, 100);
    });
	
	
	 $('#head_allfl').parent().hover(function(e){
			 $('#allfl').css('display','block');
			 $("#head_allfl").parent().addClass("hover");
		 }, function(e){
			 $("#head_allfl").parent().removeClass("hover");
			 $('#allfl').css('display','none');
		 });
		  $('.allfl').hover(function(e){
				 $('#allfl').css('display','block');
				  $("#head_allfl").parent().addClass("hover");
			 }, function(e){
				 $('#allfl').css('display','none');
				  $("#head_allfl").parent().removeClass("hover");
			 });
			 
			 
	current = 1;
	button = 1;
	images = 4;
	width = 190;
	
	$('#p1').animate({"left":"0px"},400,"swing");
	  $('#next').hover(function(e){
				 $('#next').css('border-color','transparent transparent transparent #f0424e');
			 }, function(e){
				 $('#next').css('border-color','transparent transparent transparent #ccc');
			 });
	   $('#previous').hover(function(e){
				 $('#previous').css('border-color','transparent #f0424e transparent transparent');
			 }, function(e){
				 $('#previous').css('border-color','transparent #ccc transparent transparent');
			 });
	$("#next").click(function(){
		button = current;
		current++
		if(current==(images + 1)){
			current = 1
		}
		animateLeft(current, button)
	});
	
	$("#previous").click(function(){
		button = current;
		current--
		if(current == 0){
			current = images
		}
		animateRight(current, button)
	});
	
	$("#abuttons li").mouseover(function(){
		button = current;
		clickButton = $(this).attr('id');
		current = parseInt(clickButton.slice(1));
		if(current > button){
			animateLeft(current, button)
		}
		if(current < button){
			animateRight(current, button)
		}
	});
	
	function animateLeft(current, button){
		$('#p' + current).css("left", width + "px");
		$('#p' + current).animate({"left": "0px"},400,"swing");
		$('#p' + button).animate({"left": -width + "px"},400,"swing");
		setbutton()
	}
	
	function animateRight(current, button) {
		$('#p' + current).css("left", -width + "px");
		$('#p' + current).animate({"left": "0px"},400,"swing");
		$('#p' + button).animate({"left": width + "px"},400,"swing");
		setbutton()
	}
	
	function setbutton(){
		$('#a' + button).children("a").removeClass("current");
		$('#a' + current).children("a").addClass("current");
	}

	
	});