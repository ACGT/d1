$("#tktshow").click(function(){
		   var obj = $(".tktlist");
   		    if(obj.css('display')=='none'){
   			  $(".tktlist").show();
   			  $(this).addClass("new-on");
			  Bindtkt();
			 
   		     }else{
			$(".tktlist").hide();
   			$(this).removeClass("new-on");
   		  }
   	   });
	   function choosetkt(t){
	   var tkttxt= $(t).parent().next().text();
		$("#tktid").val($(t).val());
		$("#tkttxt").html("优惠券金额:"+tkttxt);
		  $(".tktlist").hide();
		  $("#tktshow").removeClass("new-on");
		  loadprice();
	   }
	   function chooseaddr(t){
	    var rname= $(t).next().text()
	    var rphone= $(t).parent().next().find(".phone").text();
	    var raddress= $(t).parent().next().find(".address").text();
		$("#addrid").val($(t).val());
		$("#addr1").html(rname+"&nbsp;&nbsp;"+rphone);
		$("#addr2").html(raddress);
		$(".m_addlist").hide();
		$("#addr").removeClass("new-on");
		loadprice();
	   }
	   
function Bindaddr(t){
	  $.ajax({
		type: 'get', 
		url: '/ajax/wap/getaddr.jsp',
		dataType:'json',
		success: function(json){
				/*处理数据*/
				
				if(json.status=="1"){
				  if(t=="1"){
					$(".m_addlist ul").html();
				  showitem(json);
				  $(".m_addlist ul").append('<div class="addrnone"><a href=\"user/addro.html\">添加收货人地址</a> </div>');
				  }else{
				  chooseitem(json);
				  }
				  $("#addr").click(function(){
					   var obj = $(".m_addlist");
			  		    if(obj.css('display')=='none'){
			  			  $(".m_addlist").show();
			  			  $(this).addClass("new-on");
						  Bindaddr('1');
			  		     }else{
			  		    $(".m_addlist ul").html();
						$(".m_addlist").hide();
			  			$(this).removeClass("new-on");
			  		  }
			  	   });
				}else if(json.status=="-1"){
					window.location.href='login.html';
				}else{
					  $(".m_addlist ul").html('<div class="addrnone"><a href=\"user/addro.html\">添加收货人地址</a> </div>');
					  $(".m_addlist").show();
					  $(".m_addlist").addClass("new-on");
				}
				
      }
	});
	 
	}

function wxpay(){
	
	$("#paytxt").val("1");
	$.ajax({
		type: 'get', 
		url: '/ajax/wap/getpay.jsp',
		dataType:'json',
		success: function(json){
		 if(json.status=="-1"){
			 window.location.href='/wap/login.html';
		 }else{
			 var payhtml='<span><input class="pay" type="radio" checked  id="payid2" onclick="loadprice();" name="payid" value="60">微信支付</span>';
			 if(json.ifCanHF){
				 payhtml+='<span><input class="pay" type="radio" id="payid2" name="payid" onclick="loadprice();" value="0">货到付款</span>';
			 }
			 $(".m_pay .item").append(payhtml);
			 loadprice();
		 }
		}
	  });

}


function Bindpay(){
	
	  $.ajax({
		type: 'get', 
		url: '/ajax/wap/getpay.jsp',
		dataType:'json',
		success: function(json){
		 if(json.status=="-1"){
			 window.location.href='/wap/login.html';
		 }else{
			 var payhtml='<span><input class="pay" type="radio"  id="payid1" name="payid" onclick="loadprice();" value="20">支付宝支付</span>';
			 payhtml += '<span><input class="pay" type="radio" checked id="payid3" name="payid" onclick="loadprice();" value="61">百度支付</span>';
			 if(json.ifCanHF){
				 payhtml+='<span><input class="pay" type="radio" id="payid2" name="payid" onclick="loadprice();" value="0">货到付款</span>';
			 }
			 $(".m_pay .item").append(payhtml);
			 loadprice();
		 }
		}
	  });
}
function chooseitem(json){
	var addresss=eval(json.addresss);
	  var addrhtml=""
	  var addrid="";
	 // alert(addresss.length);
	if(addresss.length>0){
	   for(var i=0;i<addresss.length;i++){
		
	     if(i==0||addresss[i].is_default==1){
		    addrhtml='<a href="javascript:void(0);" id="addr">';
			addrhtml+='<span id="addr1">收货人:'+addresss[i].rname+'&nbsp;&nbsp;'+addresss[i].rphone+'</span>';
			addrhtml+='<span id="addr2">'+addresss[i].rprov+addresss[i].rcity+addresss[i].raddress+'</span>';
			addrhtml+='<i class="go  top1"></i>';
			addrhtml+='</a>';
			addrid=addresss[i].rid;
			 if(addresss[i].is_defalut==1)
				 break;
		 }
	     
	   }
	   
	   $(".m_address .item").append(addrhtml);
	   $("#addrid").val(addrid);
	   loadprice();
	}
	/*
	else {
		alert("aaa");
		   
		   addrhtml = '<a href="login.html" id="addr"  >使用其它D1账号登录</a>';
		   
	   }*/
}
function showitem(json){
	var addresss=eval(json.addresss);
	  var addrhtml=""
		 // alert(addresss.length);
	if(addresss.length>0){
	   for(var i=0;i<addresss.length;i++){
		   addrhtml+='<li>';
		   addrhtml=addrhtml+'<div class="addritem">';
		   addrhtml=addrhtml+'<div class="title">';
		   addrhtml=addrhtml+'	<input class="chaddr" type="radio" id="chaddr'+i+'" onclick="chooseaddr(this)" name="chooseAddr" ';
		   addrhtml=addrhtml+' value="'+addresss[i].rid+'"><span>收件人：'+addresss[i].rname+'</span>';
		   addrhtml=addrhtml+'</div>';
		   addrhtml=addrhtml+'<div class="content">';
		   addrhtml=addrhtml+'	<span class="address">'+addresss[i].rprov+addresss[i].rcity+addresss[i].raddress+'</span>';
		   addrhtml=addrhtml+'	<span class="phone">手机：'+addresss[i].rphone;
		   if(addresss[i].rtel!=""){
			   addrhtml=addrhtml+'&nbsp;&nbsp;电话：'+addresss[i].rtel;
		   }
		   addrhtml=addrhtml+'</span></div>';
		   addrhtml=addrhtml+'<div class="edit"><a href="user/addro.html?mcstid='+addresss[i].rid+'">修改</a></div>';
		   addrhtml=addrhtml+'</div>';
		   addrhtml=addrhtml+'</li>';
		   
	   }
	   $(".m_addlist ul").html(addrhtml);
	}
	
	}
	function Bindtkt(){
	  $.ajax({
		type: 'get', 
		url: '/ajax/wap/gettkt.jsp',
		dataType:'json',
		success: function(json){
				/*处理数据*/
				if(json.status=="1"){
				showtkt(json);
				$(".tktlist ul").append(' <div class="tktadd"><span class="card"><input name="cardno" id="cardno" class="cardno" type="text" ></span><a href="javascript:void(0);" class="active">激活</a> </div>');
				}else if(json.status=="-1"){
					window.location.href='/wap/wxtt.jsp?backurl=/wap/login.html';
				}else{
					$(".tktlist ul").html(' <div class="tktadd"><span class="card"><input name="cardno" id="cardno" class="cardno" type="text" ></span><a href="javascript:void(0);" class="active">激活</a> </div>');
				}
				$(".active").click(function(){
						ActivateTkt();
					});
      }
	
	});
	  
	}
	function ActivateTkt(){
		var strCardNo = $('#cardno').val();
		var payid=-1;
	    if (strCardNo == null || strCardNo.length == 0){
	        alert('请输入优惠券号码!');
	        return;
	    }
	    $.ajax({
	        type: "post",
	        dataType: "json",
	        url: "/ajax/flow/activateTicket.jsp",
	        cache: false,
	        data:{CardNo: strCardNo,payId:payid},
	        error: function(XmlHttpRequest){
	            alert("激活优惠券错误！");
	        },
	        success: function(json){
	            if(json.success){
	                alert('激活优惠券成功!');
	                Bindtkt();
	            }else{
	                alert(json.message);
	            }
	        }
	    });
	}
	function showtkt(json){
	var tickets=eval(json.tickets);
	  var tkthtml=""
	if(tickets.length>0){
	var tktid="";
	   for(var i=0;i<tickets.length;i++){
	   if(tickets[i].tkt_type==2){
	     tktid="crd"+tickets[i].tkt_id;
	   }else{
	   tktid=tickets[i].tkt_id;
	   }
		tkthtml+='<li>';
		tkthtml+='    <div class="tktitem">';
		tkthtml+='   <span class="wd0"><input class="pay" type="radio" id="tktid1" onclick="choosetkt(this)" name="tktid" value="'+tktid+'"></span>';
		tkthtml+='	<span class="wd1">￥'+tickets[i].tkt_value+'</span>';
		tkthtml+='	<span class="wd3">'+tickets[i].tkt_shopname+'</span>';
		tkthtml+='	</div>';
		tkthtml+='</li>';
		
	   }
	   $(".tktlist ul").html(tkthtml);
	}
}

function Bindcart(){
	  $.ajax({
		type: 'get', 
		url: '/ajax/wap/getflowcheckcart.jsp',
		dataType:'json',
		success: function(json){
				/*处理数据*/
				if(json.status=="1"){
					
				showcart(json);
				}else{
					//window.location.href='/wap/index.html';
				}
      }
	});
	}
	function showcart(json){
	var cartlist=eval(json.cartlist);
	   var actlist=eval(json.actlist);
	  var citemhtml='<div class="citem">';
	      citemhtml+='<span class="cwd1">商品名称</span>';
	      citemhtml+='<span class="cwd2">单价</span>';
	      citemhtml+='<span class="cwd2">数量</span>';
	      citemhtml+='</div>';
	if(cartlist.length>0){
	    var showact=0;
	       var oldactid=0;
	       var hfflag=0;
	       for(var i=0;i<cartlist.length;i++){
	    	   actid=cartlist[i].cart_actid;
	    	   if(oldactid!=actid&&showact==1)showact=0;
	    	   if(actid!=0&&showact==0){
		
	    	   for(var l=0;l<actlist.length;l++){
	    		   if(actid==cartlist[l].actid){
	    			   showact=1;
	    	       citemhtml=citemhtml+'<div class="act">';
	    	       citemhtml=citemhtml+'<p class="acttitle">'+actlist[l].acttxt+'</p>';
	    	       citemhtml=citemhtml+'<p class="acttxt">'+actlist[l].showactt+'</p>';
	    	       citemhtml=citemhtml+'</div>';
	    	       break;
	    		   }
	    	   }
	    	   }
	    	   if(cartlist[i].cart_shopcode!="00000000"&&hfflag==0){
    			   hfflag=1;
    		   }
			    citemhtml+='<div class="citem">';
			    citemhtml+='<span class="cwd1">'+cartlist[i].cart_title;
				if(cartlist[i].cart_sku!=''){
	    	      citemhtml+='尺码：'+cartlist[i].cart_sku+'';
	    	   
	    	     }
				citemhtml+='</span><span class="cwd2">'+cartlist[i].cart_price+'</span>';
				citemhtml+='<span class="cwd2">'+cartlist[i].cart_gdscount+'</span>';
				citemhtml+='</div>';
	    	  
	    	   oldactid=actid;
			   
	        }
	       if(hfflag==1){
	    	  $("#payid2").parent().hide();
	       }
	       $(".c_list").html(citemhtml);
	}

				
}
//ajax更新总金额
function loadprice(){
    var aj_tktid = -1; //选择的优惠券ID
    var aj_payid = -1; //选择的支付方式ID

    aj_tktid=$("#tktid").val();
   // 遍历支付方式, 记录选中项
    var req_pay = $('input[type=radio][name=payid]');
    if (req_pay.length > 0){
    	req_pay.each(function(){
    		if(this.checked){
    			aj_payid = this.value;
    			return false;
    		}
    	});
    }
    var addrid=$("#addrid").val();
    //var strGdsFee = $('#lblGdsFee').text(); //商品金额
    var iIsUsePrepay = 0;
    var chkPrepay = $('#chkPrepay').get(0);
    if (chkPrepay != null && chkPrepay.checked){
        iIsUsePrepay = 1;
    }
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/loadPrice.jsp",
        cache: false,
        data:{tktid: aj_tktid,payid: aj_payid,IsUsePrepay: iIsUsePrepay,addId:addrid},
        error: function(XmlHttpRequest, textStatus, errorThrown){
            alert("更新总金额出错，请刷新总金额！");
        },success: function(json){
        	if(json.success){
                var tothtml='<p><span class="r">商品金额：</span><span>'+json.lblGdsFee+'元</span></p>';
				  if(json.TktValue>0){
					tothtml+='<p><span class="r">-优惠券：</span><span>'+json.TktValue+'元</span></p>';
					}
					if(json.D1ActValue>0){
					tothtml+='<p><span class="r">-优惠金额：</span><span>'+json.D1ActValue+'元</span></p>';
					}
					if(json.UsePrepay>0){
					tothtml+='<p><span class="r">-预存款：</span><span>'+json.UsePrepay+'元</span></p>';
					}
					tothtml+='<p><span class="r">+运费：</span><span>'+json.ShipFee+'元<font style="color:red">&nbsp;&nbsp;（在线支付满59元免运费）</font></span></p>';
					tothtml+='<p class="tot"><span class="r">应付金额：</span><span>'+json.Total+'元</span></p>';
                    $('.totlenum').html(tothtml);

        	}else{
        		alert(json.message);
        	}
        }
    });
}
$("#sndOK").click(function(){
	sendupdate();
});
function sendupdate(){
	var iIsChkMbrcst = $('#addrid').val();
    if (iIsChkMbrcst =="-1"){
    	$('#msgerr').show();
		$('#msgerr .txt>i').html("请添加选择收货人!");
		return;
    }
    //遍历检查是否选中支付方式
    var intSelFlag = 0;
    var payid = -1; //选中的支付方式
	var req_pay = $('input[type=radio][name=payid]');
	if(req_pay.length>0){
		req_pay.each(function(){
	    	if(this.checked){
	    		intSelFlag = 1;//选中的支付方式
	    		payid = this.value;
	    		return false;
	    	}
	    });
	}
	
    
	//送货时间要求
    var submitFlag1 = 0;
    var deliverStr = "";
    var shipTime = $('input[type=radio][name=shiptime]');
    if(shipTime.length>0){
    	shipTime.each(function(){
	    	if(this.checked){
	    		submitFlag1 = 1;//选中的支付方式
	    		deliverStr = this.value;
	    		return false;
	    	}
	    });
	}

    var ticketIdStr =$("#tktid").val();
    
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/flowDone.jsp",
        cache: false,
        data:{addressId: iIsChkMbrcst,payId:payid,deliver:deliverStr,ticketId:ticketIdStr,userPrepay:1,memo:$('#memo').val()},
        error: function(XmlHttpRequest){
            $('#msgerr').show();
    		$('#msgerr .txt>i').html("创建订单失败，请重新再试或者联系客服处理！!");
    		$('#sndOK').hide();
    		return;
        },
        success: function(json){
            if(json.success){
            	$('#sndOK').hide();
                top.location.href='flowdone.html';
            }else{
                alert(json.message);
                $('#msgerr').show();
        		$('#msgerr .txt>i').html(json.message);
        		$('#sndOK').hide();
        		return;
            }
        },beforeSend: function(){
        	$('#sndOK').hide();
        }
    });
}
