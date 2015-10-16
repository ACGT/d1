<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
String reqodr=request.getQueryString();
JSONObject json = JSONObject.fromObject(reqodr);
String retheader=json.getString("header");
if(retheader!=null&&retheader.equals("")){
	String odrbody=json.getString("body");
	JSONObject jsonbody = JSONObject.fromObject(odrbody);
	String wg_order_id=jsonbody.getString("wg_order_id");
	System.out.println(odrbody);
	if(!Tools.isNull(odrbody)){
	 if(Tools.getManager(OdrBaiDu.class).txFindByProperty("odrbaidu_bdodrid", wg_order_id)!=null){
			//已经同步过了
			System.out.println("百度微购订单："+wg_order_id+"，订单已经同步过！");
		}else{
			OrderCache oc=null;
	    	   try{
	    		   System.out.println("..........百度微购下单开始..........");
	        //OrderBaiDuService ots = (OrderBaiDuService)Tools.getService(OrderBaiDuService.class);
			// oc=ots.createOrderFromBaiDu(odrbody);
	    	   }
	    	   catch(Exception ex1){
	    		   ex1.printStackTrace();
					System.out.println("百度微购下单出错，自动重新下单..........");
					try{
						//OrderBaiDuService ots = (OrderBaiDuService)Tools.getService(OrderBaiDuService.class);
						// oc=ots.createOrderFromBaiDu(odrbody);
				    	   }
				    	   catch(Exception ex2){
				    			System.out.println("..........百度微购重新下单失败..........");
				    		   ex2.printStackTrace();
				
				    	   }
					
	    	   }
			
		}
	}else{
		System.out.println("..........百度微购odrbody不能为空..........");
	}
	/*
	"wg_order_id": "567887"               //微购订单唯一标示,ID
            "payment_method":1001               //支付方式 见下表
            "addressee":"黄先生",                //收件人
            "mobile":"13818818888",             //收件人电话
            "baidu_account":'xxxxx',         //百度账号
            "province":"江苏省",                 //国标省名称
            "city":"南京市",                       //国标市名称
            "district":"白下区",                  //国标区名称
            "address":"上地十街10号",            //街道
            "need_receipt":true,                //是否需要发票
            "receipt_type":4001,             //4001个人，4002公司
            "receipt_title":"百度(中国)有限公司", //发票抬头
            "confirm_before_delivery":"否",     //送货前是否需要电话确认,默认否
            "delivery_period":"工作日",          //送货,"工作日","周末和节假日","都可以"
            "product_list":[  
                          {"product_id": "137673",  //商品ID
                           "count":1          //数量
                          },
                          {"product_id": "187686", //商品ID
                           "count":12        //数量
                          },
                          {"product_id": "875468", //商品ID
                           "count":3          //数量
                          }
	*/
}

%>