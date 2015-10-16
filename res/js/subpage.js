function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var gdsid=$("#pre2012"+flag).attr('attr');
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj,gdsid,flag);
	});
	$("#next2012"+flag).click(function(){
		var gdsid=$("#next2012"+flag).attr('attr');
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
		selectdp(obj+2,gdsid,flag);
	});
	}

function mdmover(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	obj.css("display","block");
	$("#price"+gdsid+flag).css("display","block");
}


 function mdm_out(gdsid,flag)
{
	 $("#floatdp"+gdsid+flag).css("display","none");
	 $("#price"+gdsid+flag).css("display","none");
	
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+gdsid+count);
	if(obj!=null)
	{
		    $(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulth1.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
				selectdp(1,gdsid,count);
				//$(obj).css("background","");
				//$(obj).addClass("floatdp");
				//$(obj).css("background-image","url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat");
				//$(obj).css("background-position","right 315px;");
				//$(obj).css("margin-top","0px");
			});
	
    }
}

function selectdp(flags,gdsid,flag) {	
	var len=$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked").length;
    $("#count_"+gdsid+"_"+flag).html(len);
	var money=0;
	var tmoney=0;
	var zk=0.95;
	$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked").each(function(){
			money+=parseInt($(this).attr('m')*zk);
			tmoney+=parseInt($(this).attr('m'));
	});

	$("#money_"+gdsid+"_"+flag).html(money+".0");
	$("#totalmoney_"+gdsid+"_"+flag).html(tmoney+".0");
	$("#cheap_"+gdsid+"_"+flag).html((tmoney-money)+".0");
	
}



function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		   $("#price"+gdsid+flag).css("display","block");
		}
    
}

function AddInCart(obj){
	var flag=$(obj).attr("flag");
	var gdsid=$(obj).attr("id");
	$("#floatdp"+gdsid+flag).css("display","block");
	$("#price"+gdsid+flag).css("display","block");
	var flags=$('#banner_list'+flag+" span").filter(":visible").attr("attr");
	var code=$('#banner_list'+flag+" span").filter(":visible").attr("code");
	var list=$(".floatdp1").find("input[type='checkbox'][name='chk_"+gdsid+"_"+flag+"_"+flags+"']:checked");
	
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

function view_time2(){
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
    	var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
        var the_S=Math.floor((lasttime-the_H*3600)%60);
       if(the_D!=0){$("#topd").text(the_D);}
        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
        $("#tops").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }
}	
$(document).ready(function() {
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
  setInterval(view_time2,1000);
    }
});
