<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%
String reqodr=request.getQueryString();
FileWriter fw3 = new FileWriter(new File("baiduerrvalid.txt"),true);
fw3.write(reqodr+System.getProperty("line.separator"));
fw3.flush();
fw3.close();
JSONObject json = JSONObject.fromObject(reqodr);
String retheader=json.getString("header");
String province=json.getString("province");
String city=json.getString("city");
StringBuilder sbvalide=new StringBuilder();
String status="3";
String desc="fail";
String failures="";
StringBuilder sbbody=new StringBuilder();
if(retheader!=null&&retheader.equals("")){
	City  cmst =(City)Tools.getManager(City.class).findByProperty("", city);
	if(cmst!=null){
	CityShipFee csf = (CityShipFee)Tools.getManager(CityShipFee.class).findByProperty("cityid", new Long(cmst.getId()));
	
	//Ifcanhf字段值为1表示支持货到付款
	if(csf!=null&&csf.getIfcanhf()!=null&&csf.getIfcanhf().longValue()==1) {
	
	String odrbody=json.getString("body");
	JSONObject jsonbody = JSONObject.fromObject(odrbody);
	String payment_method=jsonbody.getString("payment_method");
	if(!Tools.isNull(odrbody)&&payment_method!=null&&payment_method.equals("10001")){
		String product_list=jsonbody.getString("product_list");
		JSONObject jsonplist= JSONObject.fromObject(product_list);
		
		int plistsize=jsonplist.size();
		int gdsflag=0;
		float allmoney=0f;
		for (int i=0;i<plistsize;i++){
			 JSONObject itemJson = JSONObject.fromObject(jsonplist.get(i)); 
			String gdsid=itemJson.getString("product_id");
			long gdscount=itemJson.getLong("count");
			Product p=ProductHelper.getById(gdsid);
			if(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1
				&&((p.getGdsmst_virtualstock()!=null&&p.getGdsmst_virtualstock().longValue()>=gdscount)
				||p.getGdsmst_stocklinkty().longValue()==0)){
				allmoney+=p.getGdsmst_memberprice().floatValue();
			}else{
				gdsflag+=1;
			}
		}
		if(gdsflag==0){
			 status="0";
			 desc="success";
			 failures="";
			 sbbody.append("\"body\":{");
			 sbbody.append("\"support_payment_type\": \"10001\",");
			 sbbody.append("\"post_fee\": \"10.00\",");
			 sbbody.append("\"sub_total\": \""+Tools.getFloat(allmoney, 2)+"\",");
			 sbbody.append("\"discount\":\'0.00\',");
			 sbbody.append("\"payment\": \""+Tools.getFloat(allmoney+10, 2)+"\"");
			 sbbody.append("}");
			 /* "body":{
		          "support_payment_type": "10001,10002", //支持货到付款和在线支付
		          "post_fee": "200.07", //运费，保留小数点后面两位
		          "sub_total": "10002.53" //商品总价
		          "discount":'1000.10', //优惠，具体价格
		          "payment": "10002.56", //订单总价,商品价格+运费-优惠
		         }*/
		}else if(gdsflag>0&&gdsflag<(plistsize+1)){
			status="1";
			 desc="fail";
			 failures="{\"code\":3001,\"message\":\"库存不足\",\"position\":0,\"content\":\"\"}";
		}else{
			status="2";
			 desc="fail";
			 failures="{\"code\":3001,\"message\":\"库存不足\",\"position\":0,\"content\":\"\"}";
		}
	/*	{
			  "header":{"status":0,  
			            "desc":"success",                        //描述
			            "failures":[]                            //参考错误信息
			           },
			  "body":{
			          "support_payment_type": "10001,10002", //支持货到付款和在线支付
			          "post_fee": "200.07", //运费，保留小数点后面两位
			          "sub_total": "10002.53" //商品总价
			          "discount":'1000.10', //优惠，具体价格
			          "payment": "10002.56", //订单总价,商品价格+运费-优惠
			         }
			}
	{
"header":{"status":1,   //0: 成功, 1:部分失败  2:全部失败  3:系统错误
          "desc":"fail",                        //描述
          "failures":[                            //参考错误信息
                    {"code":3001,"message":"库存不足","position":0,"content":""},
                    {"code":3003,"message":"库存不足","position":1,"content":"limit_num:2"}
                     ]
         },
"body":{
         
       }
}
	*/
	    }else{
		  status="3099";
		  desc="fail";
		  failures="{\"code\":3001,\"message\":\"库存不足\",\"position\":0,\"content\":\"\"}";
	   }
	}else{
		  status="3099";
		  desc="fail";
		  failures="{\"code\":3002,\"message\":\"该地区无法送达\",\"position\":0,\"content\":\"\"}";
	}
	}else{
		 status="3099";
		  desc="fail";
		  failures="{\"code\":3002,\"message\":\"该地区无法送达\",\"position\":0,\"content\":\"\"}";
	}
}
sbvalide.append("{");
sbvalide.append("\"header\":{\"status\":"+status+","); //0: 成功, 1:部分失败  2:全部失败  3:系统错误
sbvalide.append("\"desc\":\""+desc+"\",");//描述
sbvalide.append("\"failures\":["+failures+"]");
sbvalide.append("},");
if(!Tools.isNull(sbbody.toString())){
sbvalide.append(sbbody.toString());
}else{
	sbvalide.append("\"body\":{}");
}
sbvalide.append("}");
out.print(sbvalide.toString());
%>