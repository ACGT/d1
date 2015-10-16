function CancleOrderbtn(orderid,flag)
{
	$.confirm('确定要取消订单('+orderid+')吗？','提示',function(){
		CancleOrder(orderid,flag)
		});

}

function RecoverOrderbtn(orderid,flag)
{
	$.confirm('确定要恢复订单('+orderid+')吗？','提示',function(){
		RecoverOrder(orderid,flag)
		});

}

function CancleOrder(orderid,flag)
{
	$.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/user/cancleorder.jsp",
        cache: false,
        data:{orderid:orderid,flag:flag},
        error: function(XmlHttpRequest){
            alert("取消订单失败，请重新再试或者联系客服处理！");
        },
        success: function(json){
        	if(json.success)
        		{
	        		$.alert('订单'+orderid+'取消成功','提示',function(){
	            		this.location.reload();
	        		});
        		}
        		else
        		{
        			  $.alert(json.message+"请重新再试或者联系客服处理！","提示");
        		}
        		

        },beforeSend: function(){
        }
    });	
}


function RecoverOrder(orderid,flag)
{
	$.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/user/recoverorder.jsp",
        cache: false,
        data:{orderid:orderid,flag:flag},
        error: function(XmlHttpRequest){
            alert("恢复订单失败，请重新再试或者联系客服处理！");
        },
        success: function(json){
        	$.alert('订单'+orderid+'恢复成功','提示',function(){
        		this.location.reload();

        		});
        },beforeSend: function(){
        }
    });	
}



function ActivateTicket(){
	var payid = -1; //选中的支付方式
	var strCardNo = $('#ticketcode').val();
    var btnActivate = $('#activetickets');
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
            btnActivate.removeAttr('disabled');
            btnActivate.attr('value', '激活优惠券');
        },
        success: function(json){
            if(json.success){
                alert('激活优惠券成功!');
                location.href="/user/ticket.jsp";
                
            }else{
                alert(json.message);
            }
        },beforeSend: function(){
            btnActivate.attr('disabled', 'disabled');
            btnActivate.removeClass('ActivateEquan1');
            btnActivate.addClass('WaitActiveEQ');
            btnActivate.attr('value', '激活中,请稍等...');
        },complete: function(){
            btnActivate.removeAttr('disabled');
            btnActivate.removeClass('WaitActiveEQ');
            btnActivate.addClass('ActivateEquan1');
            btnActivate.attr('value', '');
        }
    });
}


function tipdialog(orderid)
{	
	$.confirm('如您已收到商品，请点击“确定”，对商品进行评价。<Br>如尚未收到商品，请点击“取消”。','提示',function(){
			location.href="/comment/addcomment.jsp?orderid="+orderid;
			});

	
}
