function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj,flag);
	});
	$("#next2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
	
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj+2,flag);
	});
	}

function mdmover(flag)
{
	var obj=$("#floatdp"+flag);
	obj.css("display","block");
	$("#price"+flag).css("display","block");
}


 function mdm_out(flag)
{
	 $("#floatdp"+flag).css("display","none");
	 $("#price"+flag).css("display","none");
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+count);
	if(obj!=null)
	{
		    $(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulth.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
				selectdp(1,count);
			});
	
    }
}
function selectdp(flags,flag) {
	
	var len=$(".floatdp1").find("input[type='checkbox'][name='chk_"+flag+"_"+flags+"']:checked").length;
	
	$("#count_"+flag).html(len);
	var money=0;
	var tmoney=0;
	var zk=0.95;
	$(".floatdp1").find("input[type='checkbox'][name='chk_"+flag+"_"+flags+"']:checked").each(function(){
		money+=parseInt($(this).attr('m')*zk);
		tmoney+=parseInt($(this).attr('m'));
	});
	
	$("#money_"+flag).html(money+".0");
	$("#totalmoney_"+flag).html(tmoney+".0");
	$("#cheap_"+flag).html((tmoney-money)+".0");
	
}

function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		   $("#price"+flag).css("display","block");
		}
    
}
function AddInCart(obj){
	var flag=$(obj).attr("flag");
	$("#floatdp"+flag).css("display","block");
	 
	$("#price"+flag).css("display","block");
	var flags=$('#banner_list'+flag+" span").filter(":visible").attr("attr");
	var code=$('#banner_list'+flag+" span").filter(":visible").attr("code");
	
	var list=$(".floatdp1").find("input[type='checkbox'][name='chk_"+flag+"_"+flags+"']:checked");
	if(list.length<2){
		$.alert('对不起，请至少选择两个商品！');
		return;
	}

	var arr = new Array();
    list.each(function(i){
		arr[i] = $(this).attr('attr');
	});
    $(obj).attr('attr',arr.toString());
    $(obj).attr('code',code);
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}