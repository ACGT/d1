<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.SimpleExpression"%>
<%@page import="com.d1.bean.OrderBase"%>
<%@page import="com.d1.bean.OrderMain"%>
<%@page import="com.d1.bean.OrderRecent"%>
<%@page import="com.d1.bean.OrderTaobao"%>
<%@page import="com.d1.bean.Product"%>
<%@page import="com.d1.dbcache.core.BaseEntity"%>
<%@page import="com.d1.helper.SkuHelper"%>
<%@page import="com.d1.helper.CartItemHelper"%>
<%@page import="com.d1.service.OrderTmallService"%>
<%@page import="com.d1.util.HttpUtil"%>
<%@page import="com.d1.util.Tools"%>
<%@page import="com.taobao.api.DefaultTaobaoClient"%>
<%@page import="com.taobao.api.TaobaoClient"%>
<%@page import="com.taobao.api.domain.Item"%>
<%@page import="com.taobao.api.domain.Sku"%>
<%@page import="com.taobao.api.domain.Trade"%>
<%@page import="com.taobao.api.domain.User"%>
<%@page import="com.taobao.api.request.ItemQuantityUpdateRequest"%>
<%@page import="com.taobao.api.request.ItemSkusGetRequest"%>
<%@page import="com.taobao.api.request.ItemsInventoryGetRequest"%>
<%@page import="com.taobao.api.request.ItemsOnsaleGetRequest"%>
<%@page import="com.taobao.api.request.LogisticsOfflineSendRequest"%>
<%@page import="com.taobao.api.request.TradeFullinfoGetRequest"%>
<%@page import="com.taobao.api.request.TradesSoldGetRequest"%>
<%@page import="com.taobao.api.request.UserGetRequest"%>
<%@page import="com.taobao.api.response.ItemQuantityUpdateResponse"%>
<%@page import="com.taobao.api.response.ItemSkusGetResponse"%>
<%@page import="com.taobao.api.response.ItemsInventoryGetResponse"%>
<%@page import="com.taobao.api.response.ItemsOnsaleGetResponse"%>
<%@page import="com.taobao.api.response.LogisticsOfflineSendResponse"%>
<%@page import="com.taobao.api.response.TradeFullinfoGetResponse"%>
<%@page import="com.taobao.api.response.TradesSoldGetResponse"%>
<%@page import="com.taobao.api.response.UserGetResponse"%>
<%!
/**
 * 淘宝商城工具类。包括订单同步、库存同步、发货状态同步1。
 * outerId如果没有，直接用outerSkuId和商品对应。outerId如果有，用outerId+outerSkuId联合起来找对应的商品 <br/>
 * http://open.taobao.com/doc/api_list.htm?id=102	这是SDK下载地址<br/>
 * 调用获取授权session key:http://container.api.taobao.com/container?appkey=12383931<br/>
 * 获取session key :http://123.103.15.181:8080/inf/taobao/sk.jsp?get=true<br/>
 * @author kk
 *
 */

/**
 * 同步卖家备注，卖家备注可能是支付成功后才写入的。
 * @throws Exception
 */
public synchronized void syncSellerMemo(TaobaoClient client,String sessionKey)throws Exception{
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("status", new Long(0)));//状态为0的淘宝订单表示没有同步过发货状态
	
	List<BaseEntity> list = Tools.getManager(OrderTaobao.class).getList(clist, null, 0, 1000);
	if(list!=null&&list.size()>0){
		for(BaseEntity b:list){
			OrderTaobao ot = (OrderTaobao)b;
			if(ot.getStatus().longValue()!=0)continue;
			String d1OrderId = ot.getD1OrderId();
			OrderBase order1 = (OrderMain)Tools.getManager(OrderMain.class).get(d1OrderId);
			
			if(order1==null){
				order1 = (OrderRecent)Tools.getManager(OrderRecent.class).get(d1OrderId);
			}
			if(order1!=null&&(order1.getOdrmst_orderstatus().longValue()==3
					||order1.getOdrmst_orderstatus().longValue()==31)){
			String tid = ot.getTaobaoOrderId() ;
			if(Tools.isNull(tid))continue;
			TradeFullinfoGetRequest req=new TradeFullinfoGetRequest();
			req.setFields("buyer_message,seller_memo");//卖家备注
			req.setTid(new Long(tid).longValue());
			TradeFullinfoGetResponse resp2 = client.execute(req , sessionKey);
			Trade t123 = resp2.getTrade();
			////System.out.println(t123.getSellerMemo());
			
			OrderMain order = (OrderMain)Tools.getManager(OrderMain.class).get(ot.getD1OrderId());
			
			if(order==null||t123==null)continue;
			String memo = "卖家备注："+t123.getSellerMemo()+"<br/>买家留言："+t123.getBuyerMessage();
			
			if(!memo.equals(order.getOdrmst_ourmemo())){
				//System.out.println("同步卖家留言="+memo);
				order.setOdrmst_ourmemo(memo);//卖家备注
				order.setOdrmst_internalmemo("[务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）]<br><span style=\"color:#FF0000\">买家留言："+t123.getBuyerMessage()+"</span><br/><font color=red><b>卖家备注："+t123.getSellerMemo()+"</b></font>");
				Tools.getManager(OrderMain.class).update(order, false);
			}
		  }
		}
	}
}

/**
 * 自己发货，即发货状态同步。每隔一段时间同步一次！根据情况而定！
 * 
 * @throws Exception
 */
public synchronized void orderStateSyncGo(TaobaoClient client,String sessionKey) throws Exception{
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("status", new Long(0)));//状态为0的淘宝订单表示没有同步过发货状态
	clist.add(Restrictions.eq("mbrid", new Long(3250586)));//会员号
	
	List<BaseEntity> list = Tools.getManager(OrderTaobao.class).getList(clist, null, 0, 10000);
	if(list!=null&&list.size()>0){
		for(BaseEntity b:list){
			OrderTaobao ot = (OrderTaobao)b;
			if(ot.getStatus().longValue()!=0)continue;
			
			String d1OrderId = ot.getD1OrderId();
			OrderBase order1 = (OrderMain)Tools.getManager(OrderMain.class).get(d1OrderId);
			
			if(order1==null){
				order1 = (OrderRecent)Tools.getManager(OrderRecent.class).get(d1OrderId);
			}
			
			//System.out.println("同步发货状态..."+order1.getId()+" 运单号="+order1.getOdrmst_goodsodrid()+" 订单状态="+order1.getOdrmst_orderstatus());
			
			if(order1!=null){//订单存在
				String shipMethod=order1.getOdrmst_d1shipmethod();
					if((order1.getOdrmst_orderstatus().longValue()==3
							||order1.getOdrmst_orderstatus().longValue()==31)&&
							!Tools.isNull(shipMethod)&&
							order1.getOdrmst_goodsodrid()!=null&&
							order1.getOdrmst_goodsodrid().trim().length()>0){//实际发货状态
					LogisticsOfflineSendRequest req=new LogisticsOfflineSendRequest();
					if(Tools.isNull(ot.getTaobaoOrderId()))continue;
					req.setTid(new Long(ot.getTaobaoOrderId()));//淘宝订单号
					req.setOutSid(order1.getOdrmst_goodsodrid().trim());//运单号
					
					String shipNumber = order1.getOdrmst_goodsodrid();//运单号
				
					String postTaobao = "其他";
					
					//根据运单号规则猜物流公司名字
					/*if(shipNumber.startsWith("E")||shipNumber.startsWith("e"))postTaobao="EMS";
					else if((shipNumber.startsWith("36")||shipNumber.startsWith("268")||shipNumber.startsWith("468")||shipNumber.startsWith("58"))&&shipNumber.trim().length()==12)postTaobao="STO";
					else if((shipNumber.startsWith("6000")&&shipNumber.trim().length()==10))postTaobao="其他";//乐运通
					else if(shipNumber.trim().length()==12 && shipNumber.startsWith("30"))postTaobao="SF";//顺丰
					else if(shipNumber.trim().length()==10&&(shipNumber.startsWith("1")||shipNumber.startsWith("0")||shipNumber.startsWith("97")))postTaobao="ZJS";//宅急送
					else if(shipNumber.trim().length()==10)postTaobao="YTO";//圆通
					else if(shipMethod!=null&&"宅急送".equals(shipMethod))postTaobao = "ZJS";
					else postTaobao = "其他";
						*/
					if(shipMethod.trim().equals("EMS")){ postTaobao="EMS";}
					else if((shipMethod.trim().equals("申通快递")
							||shipMethod.trim().equals("广州申通"))){postTaobao="STO";}
					else if((shipMethod.trim().equals("广州中通")
							||shipMethod.trim().equals("中通快递")))	{ postTaobao="ZTO";}//顺丰
					else if(shipMethod.trim().equals("顺丰快递")){ postTaobao="SF";}//顺丰
					else if((shipMethod.trim().equals("宅急送")
							||shipMethod.trim().equals("广州宅急送"))){ postTaobao="ZJS";}//宅急送
					else if((shipMethod.trim().equals("圆通速递")
								||shipMethod.trim().equals("广州圆通"))) { postTaobao="YTO";}//圆通
					else if((shipMethod.trim().equals("韵达快运")
								||shipMethod.trim().equals("韵达快递"))) { postTaobao="YUNDA";}//圆通
					else if(shipMethod.trim().equals("全峰快递")) { postTaobao="QFKD";}//圆通
					else postTaobao="OTHER";
					
					/*
					if("宅急送".equals(shipMethod))postTaobao = "ZJS";
					else if("EMS".equals(shipMethod))postTaobao = "EMS";
					else if("申通快递".equals(shipMethod))postTaobao = "STO";
					else if("顺丰快递".equals(shipMethod))postTaobao = "SF";
					else if("圆通速递".equals(shipMethod))postTaobao = "YTO";
					*/
					
					req.setCompanyCode(postTaobao);//物流公司代码.如"POST"就代表中国邮政,"ZJS"就代表宅急送.调用 taobao.logistics.companies.get 获取。非淘宝官方物流合作公司，填写“其他”。
					//req.setSenderId(654321L);//卖家联系人地址库ID，可以通过taobao.logistics.address.search接口查询到地址库ID。如果为空，取的卖家的默认取货地址
					//req.setCancelId(123456L);//卖家联系人地址库ID，可以通过taobao.logistics.address.search接口查询到地址库ID。如果为空，取的卖家的默认退货地址
					//req.setFeature("machineCode=tid:123,456;machineCode=tid2:111|tid3:123,567");
					LogisticsOfflineSendResponse response = client.execute(req , sessionKey);
					
					if(response.isSuccess()||(response.getBody()!=null&&response.getBody().indexOf("不能重复发货")>-1)){
						//修改同步状态
						Tools.getManager(OrderTaobao.class).clearListCache(ot);
						ot.setStatus(new Long(1));
						Tools.getManager(OrderTaobao.class).update(ot, true);
					}else{
						Tools.getManager(OrderTaobao.class).clearListCache(ot);
						//ot.setStatus(new Long(-1));
						ot.setReason(response.getBody());
						Tools.getManager(OrderTaobao.class).update(ot, true);
						System.out.println("修改发货状态失败，快递:"+shipMethod+"-----单号："+shipNumber+"-----d1OrderId="+ot.getD1OrderId()+" "+response.getBody());
					}
				}
			}else{
				//System.out.println("d1订单不存在，修改订单状态失败。orderid="+d1OrderId);
			}
		}
	}
}

/**
 * 库存同步方法。
 * 获取当前用户作为卖家的出售中的商品列表，并能根据传入的搜索条件对出售中的商品列表进行过滤 只能获得商品的部分信息，商品的详细信息请通过taobao.item.get获取
 * api参考：http://api.taobao.com/apidoc/api.htm?path=cid:5-apiId:46
 * @throws Exception
 */
public synchronized void stockSyncGo(TaobaoClient client,String sessionKey) throws Exception{

	ItemsOnsaleGetRequest req=new ItemsOnsaleGetRequest();
	req.setFields("approve_status,num_iid,title,nick,type,cid,pic_url,num,props,valid_thru,list_time,price,has_discount,has_invoice,has_warranty,has_showcase,modified,delist_time,postage_id,seller_cids,seller_memo,outer_id");
	//req.setQ("N97");
	//req.setCid(1512L);
	//req.setSellerCids("11");
	req.setPageNo(1L);
	//req.setHasDiscount(true);
	//req.setHasShowcase(true);
	req.setOrderBy("list_time:desc");
	//req.setIsTaobao(true);
	//req.setIsEx(true);
	long PAGE_SIZE = 100L ;
	
	req.setPageSize(PAGE_SIZE);
	
	ItemsOnsaleGetResponse response = client.execute(req , sessionKey);
	
	//System.out.println("total results="+response.getTotalResults());
	
	//第一页的商品
	List<Item> list = response.getItems();
	if(list!=null){
		for(Item it:list){
			//System.out.println(it.getTitle()+"    "+it.getOuterId()+" "+ it.getNumIid());
			
			ItemSkusGetRequest req123=new ItemSkusGetRequest();
			req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
			req123.setNumIids(it.getNumIid()+"");//sku所属商品数字id，必选
			ItemSkusGetResponse response123 = client.execute(req123 , sessionKey);

			
			List<Sku> skuList = response123.getSkus();
			if(skuList!=null&&skuList.size()>0){
				for(Sku s:skuList){
					updateSkuStock(client,sessionKey,it,s);
				}
			}else{
				updateSkuStock(client,sessionKey,it,null);
			}
		}
	}
	
	int currentPage = 1 ;//当前页
	
	int totalPages = (int)(response.getTotalResults().longValue()/PAGE_SIZE) ;//商品总页数
	
	if(response.getTotalResults().longValue()%PAGE_SIZE>0){
		totalPages+=1;
	}
	
	while(currentPage<totalPages){
		currentPage++;
		req.setPageNo((long)currentPage);
		req.setPageSize(PAGE_SIZE);
		
		response = client.execute(req , sessionKey);
		
		//后面页得商品
		list = response.getItems();
		//System.out.println("同步第"+currentPage+"页");
		if(list!=null){
			for(Item it:list){
				ItemSkusGetRequest req123=new ItemSkusGetRequest();
				req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
				req123.setNumIids(it.getNumIid()+"");//sku所属商品数字id，必选
				ItemSkusGetResponse response123 = client.execute(req123 , sessionKey);
				
				List<Sku> skuList = response123.getSkus();
				if(skuList!=null&&skuList.size()>0){
					for(Sku s:skuList){
						updateSkuStock(client,sessionKey,it,s);
					}
				}else{
					updateSkuStock(client,sessionKey,it,null);
				}
			}
		}
	}
}

/**
 * 同步“仓库中的宝贝”库存<br/>
 * 分类字段。可选值: regular_shelved(定时上架) never_on_shelf(从未上架) sold_out(全部卖完) off_shelf(我下架的) for_shelved(等待所有上架) violation_off_shelf(违规下架的) 默认查询的是for_shelved(等待所有上架)这个状态的商品
 * @throws Exception
 */
public synchronized void stockSyncGo1(TaobaoClient client,String sessionKey) throws Exception{

	String[] status = {"regular_shelved","never_on_shelf","sold_out","off_shelf","for_shelved","violation_off_shelf"};
	for(int xyz=0;xyz<status.length;xyz++){
		ItemsInventoryGetRequest req=new ItemsInventoryGetRequest();
		req.setFields("approve_status,num_iid,title,nick,type,cid,pic_url,num,props,valid_thru,list_time,price,has_discount,has_invoice,has_warranty,has_showcase,modified,delist_time,postage_id,seller_cids,seller_memo,outer_id");
		//req.setQ("N97");
		//req.setCid(1512L);
		//req.setSellerCids("11");
		req.setPageNo(1L);
		req.setBanner(status[xyz]);
		//System.out.println("同步仓库中的宝贝库存："+status[xyz]+"<<<<<<<<<<<<<<<<<<");
		//req.setHasDiscount(true);
		//req.setHasShowcase(true);
		req.setOrderBy("list_time:desc");
		//req.setIsTaobao(true);
		//req.setIsEx(true);
		long PAGE_SIZE = 100L ;
		
		req.setPageSize(PAGE_SIZE);
		
		ItemsInventoryGetResponse response = client.execute(req , sessionKey);
		
		//System.out.println("total results="+response.getTotalResults());
		
		//第一页的商品
		List<Item> list = response.getItems();
		if(list!=null){
			for(Item it:list){
				//System.out.println(it.getTitle()+"    "+it.getOuterId()+" "+ it.getNumIid());
				
				ItemSkusGetRequest req123=new ItemSkusGetRequest();
				req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
				req123.setNumIids(it.getNumIid()+"");//sku所属商品数字id，必选
				ItemSkusGetResponse response123 = client.execute(req123 , sessionKey);
				
				List<Sku> skuList = response123.getSkus();
				if(skuList!=null&&skuList.size()>0){
					for(Sku s:skuList){
						updateSkuStock(client,sessionKey,it,s);
					}
				}else{
					updateSkuStock(client,sessionKey,it,null);
				}
			}
		}
		
		int currentPage = 1 ;//当前页
		
		int totalPages = (int)(response.getTotalResults().longValue()/PAGE_SIZE) ;//商品总页数
		
		if(response.getTotalResults().longValue()%PAGE_SIZE>0){
			totalPages+=1;
		}
		
		while(currentPage<totalPages){
			currentPage++;
			req.setPageNo((long)currentPage);
			req.setPageSize(PAGE_SIZE);
			
			response = client.execute(req , sessionKey);
			
			//后面页得商品
			list = response.getItems();
			//System.out.println("同步第"+currentPage+"页");
			if(list!=null){
				for(Item it:list){
					ItemSkusGetRequest req123=new ItemSkusGetRequest();
					req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
					req123.setNumIids(it.getNumIid()+"");//sku所属商品数字id，必选
					ItemSkusGetResponse response123 =client.execute(req123 , sessionKey);
					
					List<Sku> skuList = response123.getSkus();
					if(skuList!=null&&skuList.size()>0){
						for(Sku s:skuList){
							updateSkuStock(client,sessionKey,it,s);
						}
					}else{
						updateSkuStock(client,sessionKey,it,null);
					}
				}//end for
			}
		}//end while
	}//end for
}


/**
 * 修改sku库存
 * @param it 商品item
 * @param sku 商品sku
 * @return
 */
private boolean updateSkuStock(TaobaoClient client,String sessionKey,Item it,Sku sku){
	try{
		String outerId = null;
		
		if(sku!=null)outerId = sku.getOuterId();//01715909-XL(185) 这样的字符串
		else outerId = it.getOuterId();//01715909
		
		String productId = outerId ,sku1 = null ;
		
		boolean hasSku = false ;
		if(!Tools.isNull(outerId)){
			if(outerId.indexOf("-")>0){
				productId = outerId.substring(0,outerId.indexOf("-")).trim();
				sku1 = outerId.substring(outerId.indexOf("-")+1).trim();
				hasSku = true ;
			}
		}else{
			//System.out.println("没有填入商家编码！！！无法对应商品，同步库存失败！");
			/*
			ItemGetRequest req=new ItemGetRequest();
			req.setFields("num_iid,title,price");
			req.setNumIid(it.getNumIid());
			ItemGetResponse response = client.execute(req , sessionKey);
			
			Item it123 = response.getItem();
			String s="";
			if(it123!=null)s+=it123.getTitle();*/

			FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
			fw.write("没有填入商家编码，商品标题="+it.getTitle()+System.getProperty("line.separator"));
			fw.flush();
			fw.close();
			return false ;
		}
		
		if(sku!=null){//商品对应的d1 sku存在才修改库存
			if(hasSku){//读sku表的库存
				com.d1.bean.Sku s = SkuHelper.getSku(productId, sku1);
				Product p = (Product)Tools.getManager(Product.class).get(productId);
				
				if(s==null){
					FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
					fw.write(it.getOuterId()+" "+sku.getOuterId()+" sku为空，sku1=>"+sku1+"< productId="+"  商品标题="+it.getTitle()+productId+System.getProperty("line.separator"));
					fw.flush();
					fw.close();
					//System.out.println("修改库存失败，sku为空，productId="+productId+" sku1="+sku1+"  商品标题="+it.getTitle());
					return false ;
				}
				long d1stock = s.getSkumst_vstock().longValue() - CartItemHelper.getProductOccupyStock(productId, sku1) ;//虚拟库存
				
				if(d1stock<0)d1stock=0;
				
				ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
				req.setNumIid(it.getNumIid());
				req.setSkuId(sku.getSkuId());
				//req.setOuterId(it.getOuterId());
				
				//库存不联动，即能找到货源，则一直保持25个库存
				if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
					d1stock = 10000l;
				}
				    
				req.setQuantity(d1stock);
				ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
				
				if(rsp.isSuccess()){
					//System.out.println("同步库存成功！"+productId+" "+d1stock);
					return true ;
				}else{
					FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
					fw.write(it.getOuterId()+" "+sku.getOuterId()+" "+rsp.getBody()+"  商品标题="+it.getTitle()+System.getProperty("line.separator"));
					fw.flush();
					fw.close();
					//System.out.println("同步sku库存失败，错误码："+rsp.getErrorCode()+" response body="+rsp.getBody()+" 商品标题="+it.getTitle());
				}
			}else{//读商品表的库存，修改sku

				Product p = (Product)Tools.getManager(Product.class).get(productId);
				
				if(p!=null){
					long d1stock = p.getGdsmst_virtualstock().longValue() - CartItemHelper.getProductOccupyStock(productId, sku1);
					d1stock=d1stock+3;
					if(d1stock<0)d1stock=0;
					
					ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
					req.setNumIid(it.getNumIid());
					req.setSkuId(sku.getSkuId());
					//req.setOuterId(it.getOuterId());
					//库存不联动，即能找到货源，则一直保持25个库存
					
					//库存不联动，即能找到货源，则一直保持25个库存
					if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
						d1stock = 10000l;
					}
					
					req.setQuantity(d1stock);
					//req.setType(1L);
					ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
					
					if(rsp.isSuccess()){
						//System.out.println("同步库存成功！"+productId+" "+d1stock);
						return true ;
					}else{
						FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
						fw.write(it.getOuterId()+" "+rsp.getBody()+"  商品标题="+it.getTitle()+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						//System.out.println("同步商品库存失败，错误码："+rsp.getErrorCode()+" response body="+rsp.getBody()+" 商品标题="+it.getTitle());
					}
				}
			}
		}else{
			Product p = (Product)Tools.getManager(Product.class).get(productId);
			
			if(p!=null){
				long d1stock = p.getGdsmst_virtualstock().longValue() - CartItemHelper.getProductOccupyStock(productId, sku1);
				d1stock=d1stock+3;
				if(d1stock<0)d1stock=0;
				
				ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
				req.setNumIid(it.getNumIid());
				//req.setSkuId(it.getNumIid());
				//req.setOuterId(it.getOuterId());
				//库存不联动，即能找到货源，则一直保持25个库存
				//库存不联动，即能找到货源，则一直保持25个库存
				if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
					d1stock = 10000l;
				}
				
				req.setQuantity(d1stock);
				//req.setType(1L);
				ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
				
				if(rsp.isSuccess()){
					//System.out.println("同步库存成功！"+productId+" "+d1stock);
					return true ;
				}else{
					FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
					fw.write(it.getOuterId()+" "+rsp.getBody()+" 商品标题="+it.getTitle()+System.getProperty("line.separator"));
					fw.flush();
					fw.close();
					//System.out.println("同步商品库存失败，错误码："+rsp.getErrorCode()+" response body="+rsp.getBody()+" 商品标题="+it.getTitle());
				}
			}
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}
	return false ;
}

/**
 * 订单同步！！！sku商家编码  “01715909-XL(185)”
 * @throws Exception
 */
public synchronized void tradeSyncGo(TaobaoClient client,String sessionKey,String from)throws Exception{

	TradesSoldGetRequest req=new TradesSoldGetRequest();
	
	req.setFields("seller_nick, buyer_nick, status, buyer_message, title, type, created, tid, seller_rate, buyer_rate, status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, commission_fee, pic_path, num_iid, num, price, cod_fee, cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, receiver_zip, receiver_mobile, receiver_phone, orders");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	
	//String startStr = sdf.format(new Date(System.currentTimeMillis()-2*30*24*3600*1000l)) ;
	String startStr = sdf.format(new Date(System.currentTimeMillis()-7*24*3600*1000l)) ;
	String endStr = sdf.format(new Date()) ;
	System.out.println("淘宝同步时间范围开始："+startStr+"----结束时间："+endStr);
	//System.out.println("淘宝取订单2");
	//System.out.println("start time="+startStr);
	//System.out.println("end time="+endStr);

	Date startTime = SimpleDateFormat.getDateTimeInstance().parse(startStr);
	req.setStartCreated(startTime);

	Date endTime = SimpleDateFormat.getDateTimeInstance().parse(endStr);//当前时间
	req.setEndCreated(endTime);
	req.setStatus("WAIT_SELLER_SEND_GOODS");//等待卖家发货,即:买家已付款
	//req.setBuyerNick("liuaike");
	//req.setType("game_equipment");
	//req.setRateStatus("RATE_UNBUYER");
	//req.setTag("time_card");
	
	long currentPage = 1l ;//当前页
	long PAGE_SIZE = 100l;//每页取多少
	
	req.setPageSize(PAGE_SIZE);
	req.setPageNo(currentPage);
	
	TradesSoldGetResponse response_1 = client.execute(req , sessionKey);
	List<Trade> list = response_1.getTrades() ;
	//System.out.println("淘宝同步状态："+response_1.isSuccess()+"----"+list.size());
	if(list!=null){
		syncTradeList(client,sessionKey,list,from);//同步第一页订单
	}
	
	if(!response_1.isSuccess()){
		System.out.println("淘宝同步订单出错了："+response_1.getBody());
	}
	
	if(response_1.getTotalResults()!=null){
		int totalPages = (int)(response_1.getTotalResults().longValue()/PAGE_SIZE) ;//订单总页数
		
		if(response_1.getTotalResults().longValue()%PAGE_SIZE>0){
			totalPages+=1;
		}
		
		while(currentPage<totalPages){
			currentPage++;
			//System.out.println("同步第"+currentPage+"页订单..........................");
			req.setPageNo(currentPage);
			req.setPageSize(PAGE_SIZE);
			
			response_1 = client.execute(req , sessionKey);
			
			list = response_1.getTrades() ;
			
			syncTradeList(client,sessionKey,list,from);//同步下一页订单
		}
	}
}

/**
 * 取消订单操作
 * @throws Exception
 */
public synchronized void tradeClosedSyncGo(TaobaoClient client,String sessionKey)throws Exception{
	TradesSoldGetRequest req=new TradesSoldGetRequest();
	req.setFields("seller_nick, buyer_nick, status, buyer_message, title, type, created, tid, seller_rate, buyer_rate, status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, commission_fee, pic_path, num_iid, num, price, cod_fee, cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, receiver_zip, receiver_mobile, receiver_phone, orders");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	String startStr = sdf.format(new Date(System.currentTimeMillis()-30*24*3600*1000l)) ;
	String endStr = sdf.format(new Date()) ;
	//System.out.println("start time="+startStr);
	//System.out.println("end time="+endStr);

	Date startTime = SimpleDateFormat.getDateTimeInstance().parse(startStr);
	req.setStartCreated(startTime);

	Date endTime = SimpleDateFormat.getDateTimeInstance().parse(endStr);//当前时间
	req.setEndCreated(endTime);
	req.setStatus("TRADE_CLOSED");//付款以后用户退款成功，交易自动关闭
	//req.setBuyerNick("liuaike");
	//req.setType("game_equipment");
	//req.setRateStatus("RATE_UNBUYER");
	//req.setTag("time_card");
	
	long currentPage = 1l ;//当前页
	long PAGE_SIZE = 100l;//每页取多少
	
	req.setPageSize(PAGE_SIZE);
	req.setPageNo(currentPage);
	
	TradesSoldGetResponse response_1 = client.execute(req , sessionKey);
	List<Trade> list = response_1.getTrades() ;

	if(list!=null){
		for(Trade t123:list){
			OrderTaobao ot = (OrderTaobao)Tools.getManager(OrderTaobao.class).findByProperty("taobaoOrderId", t123.getTid()+"");
			if(ot!=null){
				OrderMain order = (OrderMain)Tools.getManager(OrderMain.class).get(ot.getD1OrderId());
				if(order!=null){
					//取消订单操作.......
				}
			}
		}
	}
}

/**
 * 同步一系列订单到数据库
 * @param list
 */
private void syncTradeList(TaobaoClient client,String sessionKey,List<Trade> list,String from){
	if(list!=null)
	for(Trade t:list){
		OrderTmallService os = (OrderTmallService)Tools.getService(OrderTmallService.class);
		
		try{
			//买家留言、卖家备注要单独获取！！！
			TradeFullinfoGetRequest req=new TradeFullinfoGetRequest();
			if(Tools.isNull(t.getTid().toString()))continue;
			req.setFields("buyer_message,seller_memo");
			req.setTid(t.getTid());
			TradeFullinfoGetResponse resp2 = client.execute(req , sessionKey);
			Trade t123 = resp2.getTrade();
			
			//性别也要单独获取
			UserGetRequest req135=new UserGetRequest();
			req135.setFields("user_id,nick,seller_credit,sex");
			req135.setNick(t.getBuyerNick());
			UserGetResponse response135 = client.execute(req135 , sessionKey);
			User u135 = response135.getUser();
			String sex = "男";
			if(u135!=null&&"f".equalsIgnoreCase(u135.getSex()))sex = "女";
			
			String sellor_memo = "",tbuyer_message="";
			if(t123!=null){
				sellor_memo=t123.getSellerMemo();
				tbuyer_message = t123.getBuyerMessage();
			}
			
			OrderMain orderd1 = os.createOrderFromTmall(t,tbuyer_message,sex,u135,sellor_memo,from);
			
			if(orderd1!=null)System.out.println("淘宝小栗舍订单复制到d1订单成功，orderId="+orderd1.getId());
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
	}
}
%>
<%
com.d1.util.HitLogUtil.log(request, response);

TaobaoClient client = null ;
String sessionKey = null ;
Date dd=new Date();
System.out.println("天猫小栗舍店订单");
	client = new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "21546424", "464d854ee8a1def29189d5e0bd9df4b8");
	sessionKey = HttpUtil.getUrlContentByGet("http://www.d1.com.cn/inf/taobao/sk4.jsp?get=true", "gbk");
	tradeSyncGo(client,sessionKey,"b3");//同步交易

if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	int currentMinute = java.util.Calendar.getInstance().get(java.util.Calendar.MINUTE) ;
	if (dd.getHours()>=7){
	 //if(!"true".equals(request.getParameter("c"))){//C店api调用方法
	    if(dd.getHours()%2==0&&currentMinute>=30&&currentMinute<=32){//库存1小时同步一次
		   System.out.println("淘宝库小栗舍存更新:"+new Date());
		  stockSyncGo(client,sessionKey);
		  stockSyncGo1(client,sessionKey);
	   }
	 //}
	orderStateSyncGo(client,sessionKey);//同步订单状态
	syncSellerMemo(client,sessionKey);//同步卖家留言
	}
	
	
}
%>