package com.d1.taobao;


import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.OrderBase;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderRecent;
import com.d1.bean.OrderTaobao;
import com.d1.bean.Product;
import com.d1.dbcache.core.BaseEntity;
import com.d1.helper.SkuHelper;
import com.d1.service.OrderTmallService;
import com.d1.util.HttpUtil;
import com.d1.util.Tools;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.Sku;
import com.taobao.api.domain.Trade;
import com.taobao.api.domain.TradeRate;
import com.taobao.api.domain.User;
import com.taobao.api.request.ItemQuantityUpdateRequest;
import com.taobao.api.request.ItemSkusGetRequest;
import com.taobao.api.request.ItemsInventoryGetRequest;
import com.taobao.api.request.ItemsOnsaleGetRequest;
import com.taobao.api.request.LogisticsOfflineSendRequest;
import com.taobao.api.request.TradeFullinfoGetRequest;
import com.taobao.api.request.TraderatesGetRequest;
import com.taobao.api.request.TradesSoldGetRequest;
import com.taobao.api.request.UserGetRequest;
import com.taobao.api.response.ItemQuantityUpdateResponse;
import com.taobao.api.response.ItemSkusGetResponse;
import com.taobao.api.response.ItemsInventoryGetResponse;
import com.taobao.api.response.ItemsOnsaleGetResponse;
import com.taobao.api.response.LogisticsOfflineSendResponse;
import com.taobao.api.response.TradeFullinfoGetResponse;
import com.taobao.api.response.TraderatesGetResponse;
import com.taobao.api.response.TradesSoldGetResponse;
import com.taobao.api.response.UserGetResponse;

/**
 * �Ա��̳ǹ����ࡣ��������ͬ�������ͬ��������״̬ͬ����
 * outerId���û�У�ֱ����outerSkuId����Ʒ��Ӧ��outerId����У���outerId+outerSkuId���������Ҷ�Ӧ����Ʒ <br/>
 * http://open.taobao.com/doc/api_list.htm?id=102	����SDK���ص�ַ<br/>
 * ���û�ȡ��Ȩsession key:http://container.api.taobao.com/container?appkey=12383931<br/>
 * ��ȡsession key :http://123.103.15.181:8080/inf/taobao/sk.jsp?get=true<br/>
 * @@author kk
 *
 */
public class TmallUtil {
	
	private static TaobaoClient client=new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "12483299", "0c4f7116fb2836c0e4d362939b389acc");

	private static String sessionKey = "6102420816a229792b7a6c5df9991339fec50c0c1d29608762005010" ;//session key
	
	static{
		sessionKey = HttpUtil.getUrlContentByGet("http://www.d1.com.cn/inf/taobao/sk2.jsp?get=true", "gbk");
	}
	
	public static void loadSessionKey(){
		sessionKey = HttpUtil.getUrlContentByGet("http://www.d1.com.cn/inf/taobao/sk2.jsp?get=true", "gbk");
		//sessionKey = "610040399eb146836349fde42310dec13422c1fdf3b1b8521167705";
	}
	
	public static void main(String[] args)throws Exception{
		TradesSoldGetRequest req=new TradesSoldGetRequest();
		req.setFields("seller_nick, buyer_nick, status, buyer_message, title, type, created, tid, seller_rate, buyer_rate, status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, commission_fee, pic_path, num_iid, num, price, cod_fee, cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, receiver_zip, receiver_mobile, receiver_phone, orders");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String startStr = sdf.format(new Date(System.currentTimeMillis()-30*24*3600*1000l)) ;
		String endStr = sdf.format(new Date()) ;
		//System.out.println("start time="+startStr);
		//System.out.println("end time="+endStr);

		Date startTime = SimpleDateFormat.getDateTimeInstance().parse(startStr);
		req.setStartCreated(startTime);

		Date endTime = SimpleDateFormat.getDateTimeInstance().parse(endStr);//��ǰʱ��
		req.setEndCreated(endTime);
		req.setStatus("WAIT_SELLER_SEND_GOODS");//�ȴ����ҷ���,��:����Ѹ���
		//req.setBuyerNick("liuaike");
		//req.setType("game_equipment");
		//req.setRateStatus("RATE_UNBUYER");
		//req.setTag("time_card");
		
		long currentPage = 1l ;//��ǰҳ
		long PAGE_SIZE = 100l;//ÿҳȡ����
		
		req.setPageSize(PAGE_SIZE);
		req.setPageNo(currentPage);
		
		TradesSoldGetResponse response_1 = client.execute(req , sessionKey);
		List<Trade> list = response_1.getTrades() ;
		
		System.out.println(response_1.getBody());

		if(list!=null){
			for(Trade t:list){
				System.out.println(t.getBuyerNick() +" "+t.getTotalFee()+" "+t.getTid());
			}
		}
		
	}
	
	/**
	 * ͬ�����ұ�ע�����ұ�ע������֧���ɹ����д��ġ�
	 * @@throws Exception
	 */
	public static synchronized void syncSellerMemo()throws Exception{
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("status", new Long(0)));//״̬Ϊ0���Ա�������ʾû��ͬ��������״̬
		
		List<BaseEntity> list = Tools.getManager(OrderTaobao.class).getList(clist, null, 0, 1000);
		if(list!=null&&list.size()>0){
			for(BaseEntity b:list){
				OrderTaobao ot = (OrderTaobao)b;
				if(ot.getStatus().longValue()!=0)continue;
				
				String tid = ot.getTaobaoOrderId() ;
				TradeFullinfoGetRequest req=new TradeFullinfoGetRequest();
				req.setFields("buyer_message,seller_memo");//���ұ�ע
				req.setTid(new Long(tid).longValue());
				TradeFullinfoGetResponse resp2 = client.execute(req , sessionKey);
				Trade t123 = resp2.getTrade();
				////System.out.println(t123.getSellerMemo());
				
				OrderMain order = (OrderMain)Tools.getManager(OrderMain.class).get(ot.getD1OrderId());
				
				if(order==null)continue;
				String memo = "���ұ�ע��"+t123.getSellerMemo()+"<br/>������ԣ�"+t123.getBuyerMessage();
				
				if(!memo.equals(order.getOdrmst_ourmemo())){
					//System.out.println("ͬ����������="+memo);
					order.setOdrmst_ourmemo(memo);//���ұ�ע
					order.setOdrmst_internalmemo("[�����ǰ��ϵ,����ǩ�� �뵱������������ױƷ���ղ��ɲ��Ʒ��װ��]<br><span style=\"color:#FF0000\">������ԣ�"+t123.getBuyerMessage()+"</span><br/><font color=red><b>���ұ�ע��"+t123.getSellerMemo()+"</b></font>");
					Tools.getManager(OrderMain.class).update(order, false);
				}
			}
		}
	}
	
	/**
	 * �Լ�������������״̬ͬ����ÿ��һ��ʱ��ͬ��һ�Σ��������������
	 * 
	 * @@throws Exception
	 */
	public static synchronized void orderStateSyncGo() throws Exception{
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("status", new Long(0)));//״̬Ϊ0���Ա�������ʾû��ͬ��������״̬
		
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
				
				//System.out.println("ͬ������״̬..."+order1.getId()+" �˵���="+order1.getOdrmst_goodsodrid()+" ����״̬="+order1.getOdrmst_orderstatus());
				
				if(order1!=null){//��������
					String shipMethod=order1.getOdrmst_d1shipmethod();
					if((order1.getOdrmst_orderstatus().longValue()==3
							||order1.getOdrmst_orderstatus().longValue()==31)&&
							!Tools.isNull(shipMethod)&&
							order1.getOdrmst_goodsodrid()!=null&&
							order1.getOdrmst_goodsodrid().trim().length()>0){//ʵ�ʷ���״̬
						
						LogisticsOfflineSendRequest req=new LogisticsOfflineSendRequest();
						req.setTid(new Long(ot.getTaobaoOrderId()));//�Ա�������
						req.setOutSid(order1.getOdrmst_goodsodrid().trim());//�˵���
						
						String shipNumber = order1.getOdrmst_goodsodrid();//�˵���
						
						String postTaobao = "����";
						
						//�����˵��Ź����������˾����
						/*if(shipNumber.startsWith("E")||shipNumber.startsWith("e"))postTaobao="EMS";
						else if((shipNumber.startsWith("36")||shipNumber.startsWith("268")||shipNumber.startsWith("468")||shipNumber.startsWith("58"))&&shipNumber.trim().length()==12)postTaobao="STO";
						else if((shipNumber.startsWith("6")&&shipNumber.trim().length()==10))postTaobao="����";//����ͨ
						else if(shipNumber.trim().length()==12)postTaobao="SF";//˳��
						else if(shipNumber.trim().length()==10&&shipNumber.startsWith("0"))postTaobao="ZJS";//լ����
						else if(shipNumber.trim().length()==10)postTaobao="YTO";//Բͨ
						else postTaobao = "����";*/
							
						if(shipMethod.trim().equals("EMS")){ postTaobao="EMS";}
						else if((shipMethod.trim().equals("��ͨ���")
								||shipMethod.trim().equals("������ͨ"))){postTaobao="STO";}
						else if((shipMethod.trim().equals("������ͨ")
								||shipMethod.trim().equals("��ͨ���")))	{ postTaobao="ZTO";}//˳��
						else if(shipMethod.trim().equals("˳����")){ postTaobao="SF";}//˳��
						else if((shipMethod.trim().equals("լ����")
								||shipMethod.trim().equals("����լ����"))){ postTaobao="ZJS";}//լ����
						else if((shipMethod.trim().equals("Բͨ�ٵ�")
									||shipMethod.trim().equals("����Բͨ"))) { postTaobao="YTO";}//Բͨ
						else if((shipMethod.trim().equals("�ϴ����")
									||shipMethod.trim().equals("�����ϴ�"))) { postTaobao="YUNDA";}//Բͨ
						else if(shipMethod.trim().equals("ȫ����")) { postTaobao="QFKD";}//Բͨ
						else postTaobao="OTHER";
						
						/*
						if("լ����".equals(shipMethod))postTaobao = "ZJS";
						else if("EMS".equals(shipMethod))postTaobao = "EMS";
						else if("��ͨ���".equals(shipMethod))postTaobao = "STO";
						else if("˳����".equals(shipMethod))postTaobao = "SF";
						else if("Բͨ�ٵ�".equals(shipMethod))postTaobao = "YTO";
						*/
						
						req.setCompanyCode(postTaobao);//������˾����.��"POST"�ʹ����й�����,"ZJS"�ʹ���լ����.���� taobao.logistics.companies.get ��ȡ�����Ա��ٷ�����������˾����д����������
						//req.setSenderId(654321L);//������ϵ�˵�ַ��ID������ͨ��taobao.logistics.address.search�ӿڲ�ѯ����ַ��ID�����Ϊ�գ�ȡ�����ҵ�Ĭ��ȡ����ַ
						//req.setCancelId(123456L);//������ϵ�˵�ַ��ID������ͨ��taobao.logistics.address.search�ӿڲ�ѯ����ַ��ID�����Ϊ�գ�ȡ�����ҵ�Ĭ���˻���ַ
						//req.setFeature("machineCode=tid:123,456;machineCode=tid2:111|tid3:123,567");
						LogisticsOfflineSendResponse response = client.execute(req , sessionKey);
						
						if(response.isSuccess()){
							//�޸�ͬ��״̬
							Tools.getManager(OrderTaobao.class).clearListCache(ot);
							ot.setStatus(new Long(1));
							Tools.getManager(OrderTaobao.class).update(ot, true);
						}else{
							Tools.getManager(OrderTaobao.class).clearListCache(ot);
							ot.setStatus(new Long(-1));
							ot.setReason(response.getBody());
							Tools.getManager(OrderTaobao.class).update(ot, true);
							//System.out.println("�޸ķ���״̬ʧ�ܣ�"+response.getBody());
						}
					}
				}else{
					//System.out.println("d1���������ڣ��޸Ķ���״̬ʧ�ܡ�orderid="+d1OrderId);
				}
			}
		}
	}
	
	/**
	 * ���ͬ��������
	 * ��ȡ��ǰ�û���Ϊ���ҵĳ����е���Ʒ�б����ܸ��ݴ�������������Գ����е���Ʒ�б���й��� ֻ�ܻ����Ʒ�Ĳ�����Ϣ����Ʒ����ϸ��Ϣ��ͨ��taobao.item.get��ȡ
	 * api�ο���http://api.taobao.com/apidoc/api.htm?path=cid:5-apiId:46
	 * @@throws Exception
	 */
	public static synchronized void stockSyncGo() throws Exception{

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
		
		//��һҳ����Ʒ
		List<Item> list = response.getItems();
		if(list!=null){
			for(Item it:list){
				//System.out.println(it.getTitle()+"    "+it.getOuterId()+" "+ it.getNumIid());
				
				ItemSkusGetRequest req123=new ItemSkusGetRequest();
				req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
				req123.setNumIids(it.getNumIid()+"");//sku������Ʒ����id����ѡ
				ItemSkusGetResponse response123 = client.execute(req123);
				
				List<Sku> skuList = response123.getSkus();
				if(skuList!=null&&skuList.size()>0){
					for(Sku s:skuList){
						updateSkuStock(it,s);
					}
				}else{
					updateSkuStock(it,null);
				}
			}
		}
		
		int currentPage = 1 ;//��ǰҳ
		
		int totalPages = (int)(response.getTotalResults().longValue()/PAGE_SIZE) ;//��Ʒ��ҳ��
		
		if(response.getTotalResults().longValue()%PAGE_SIZE>0){
			totalPages+=1;
		}
		
		while(currentPage<totalPages){
			currentPage++;
			req.setPageNo((long)currentPage);
			req.setPageSize(PAGE_SIZE);
			
			response = client.execute(req , sessionKey);
			
			//����ҳ����Ʒ
			list = response.getItems();
			//System.out.println("ͬ����"+currentPage+"ҳ");
			if(list!=null){
				for(Item it:list){
					ItemSkusGetRequest req123=new ItemSkusGetRequest();
					req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
					req123.setNumIids(it.getNumIid()+"");//sku������Ʒ����id����ѡ
					ItemSkusGetResponse response123 = client.execute(req123);
					
					List<Sku> skuList = response123.getSkus();
					if(skuList!=null&&skuList.size()>0){
						for(Sku s:skuList){
							updateSkuStock(it,s);
						}
					}else{
						updateSkuStock(it,null);
					}
				}
			}
		}
	}
	
	/**
	 * ͬ�����ֿ��еı��������<br/>
	 * �����ֶΡ���ѡֵ: regular_shelved(��ʱ�ϼ�) never_on_shelf(��δ�ϼ�) sold_out(ȫ������) off_shelf(���¼ܵ�) for_shelved(�ȴ������ϼ�) violation_off_shelf(Υ���¼ܵ�) Ĭ�ϲ�ѯ����for_shelved(�ȴ������ϼ�)���״̬����Ʒ
	 * @@throws Exception
	 */
	public static synchronized void stockSyncGo1() throws Exception{

		String[] status = {"regular_shelved","never_on_shelf","sold_out","off_shelf","for_shelved","violation_off_shelf"};
		for(int xyz=0;xyz<status.length;xyz++){
			ItemsInventoryGetRequest req=new ItemsInventoryGetRequest();
			req.setFields("approve_status,num_iid,title,nick,type,cid,pic_url,num,props,valid_thru,list_time,price,has_discount,has_invoice,has_warranty,has_showcase,modified,delist_time,postage_id,seller_cids,seller_memo,outer_id");
			//req.setQ("N97");
			//req.setCid(1512L);
			//req.setSellerCids("11");
			req.setPageNo(1L);
			req.setBanner(status[xyz]);
			//System.out.println("ͬ���ֿ��еı�����棺"+status[xyz]+"<<<<<<<<<<<<<<<<<<");
			//req.setHasDiscount(true);
			//req.setHasShowcase(true);
			req.setOrderBy("list_time:desc");
			//req.setIsTaobao(true);
			//req.setIsEx(true);
			long PAGE_SIZE = 100L ;
			
			req.setPageSize(PAGE_SIZE);
			
			ItemsInventoryGetResponse response = client.execute(req , sessionKey);
			
			//System.out.println("total results="+response.getTotalResults());
			
			//��һҳ����Ʒ
			List<Item> list = response.getItems();
			if(list!=null){
				for(Item it:list){
					//System.out.println(it.getTitle()+"    "+it.getOuterId()+" "+ it.getNumIid());
					
					ItemSkusGetRequest req123=new ItemSkusGetRequest();
					req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
					req123.setNumIids(it.getNumIid()+"");//sku������Ʒ����id����ѡ
					ItemSkusGetResponse response123 = client.execute(req123);
					
					List<Sku> skuList = response123.getSkus();
					if(skuList!=null&&skuList.size()>0){
						for(Sku s:skuList){
							updateSkuStock(it,s);
						}
					}else{
						updateSkuStock(it,null);
					}
				}
			}
			
			int currentPage = 1 ;//��ǰҳ
			
			int totalPages = (int)(response.getTotalResults().longValue()/PAGE_SIZE) ;//��Ʒ��ҳ��
			
			if(response.getTotalResults().longValue()%PAGE_SIZE>0){
				totalPages+=1;
			}
			
			while(currentPage<totalPages){
				currentPage++;
				req.setPageNo((long)currentPage);
				req.setPageSize(PAGE_SIZE);
				
				response = client.execute(req , sessionKey);
				
				//����ҳ����Ʒ
				list = response.getItems();
				//System.out.println("ͬ����"+currentPage+"ҳ");
				if(list!=null){
					for(Item it:list){
						ItemSkusGetRequest req123=new ItemSkusGetRequest();
						req123.setFields("sku_id,num_iid,outer_id,quantity,properties,sku_id,title");
						req123.setNumIids(it.getNumIid()+"");//sku������Ʒ����id����ѡ
						ItemSkusGetResponse response123 = client.execute(req123);
						
						List<Sku> skuList = response123.getSkus();
						if(skuList!=null&&skuList.size()>0){
							for(Sku s:skuList){
								updateSkuStock(it,s);
							}
						}else{
							updateSkuStock(it,null);
						}
					}//end for
				}
			}//end while
		}//end for
	}
	
	
	/**
	 * �޸�sku���
	 * @@param it ��Ʒitem
	 * @@param sku ��Ʒsku
	 * @@return
	 */
	private static boolean updateSkuStock(Item it,Sku sku){
		try{
			String outerId = null;
			
			if(sku!=null)outerId = sku.getOuterId();//01715909-XL(185) �������ַ���
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
				//System.out.println("û�������̼ұ��룡�����޷���Ӧ��Ʒ��ͬ�����ʧ�ܣ�");
				/*
				ItemGetRequest req=new ItemGetRequest();
				req.setFields("num_iid,title,price");
				req.setNumIid(it.getNumIid());
				ItemGetResponse response = client.execute(req , sessionKey);
				
				Item it123 = response.getItem();
				String s="";
				if(it123!=null)s+=it123.getTitle();*/

				FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
				fw.write("û�������̼ұ��룬��Ʒ����="+it.getTitle()+System.getProperty("line.separator"));
				fw.flush();
				fw.close();
				return false ;
			}
			
			if(sku!=null){//��Ʒ��Ӧ��d1 sku���ڲ��޸Ŀ��
				if(hasSku){//��sku��Ŀ��
					com.d1.bean.Sku s = SkuHelper.getSku(productId, sku1);
					Product p = (Product)Tools.getManager(Product.class).get(productId);
					
					if(s==null){
						FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
						fw.write(it.getOuterId()+" "+sku.getOuterId()+" skuΪ�գ�sku1=>"+sku1+"< productId="+"  ��Ʒ����="+it.getTitle()+productId+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						//System.out.println("�޸Ŀ��ʧ�ܣ�skuΪ�գ�productId="+productId+" sku1="+sku1+"  ��Ʒ����="+it.getTitle());
						return false ;
					}
					long d1stock = s.getSkumst_vstock().longValue() ;//������
					
					if(d1stock<0)d1stock=0;
					
					ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
					req.setNumIid(it.getNumIid());
					req.setSkuId(sku.getSkuId());
					//req.setOuterId(it.getOuterId());
					
					//��治�����������ҵ���Դ����һֱ����25�����
					if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
						d1stock = 25l;
					}
					
					req.setQuantity(d1stock);
					ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
					
					if(rsp.isSuccess()){
						//System.out.println("ͬ�����ɹ���"+productId+" "+d1stock);
						return true ;
					}else{
						FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
						fw.write(it.getOuterId()+" "+sku.getOuterId()+" "+rsp.getBody()+"  ��Ʒ����="+it.getTitle()+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						//System.out.println("ͬ��sku���ʧ�ܣ������룺"+rsp.getErrorCode()+" response body="+rsp.getBody()+" ��Ʒ����="+it.getTitle());
					}
				}else{//����Ʒ��Ŀ�棬�޸�sku

					Product p = (Product)Tools.getManager(Product.class).get(productId);
					
					if(p!=null){
						long d1stock = p.getGdsmst_virtualstock().longValue();
						if(d1stock<0)d1stock=0;
						
						ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
						req.setNumIid(it.getNumIid());
						req.setSkuId(sku.getSkuId());
						//req.setOuterId(it.getOuterId());
						//��治�����������ҵ���Դ����һֱ����25�����
						
						//��治�����������ҵ���Դ����һֱ����25�����
						if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
							d1stock = 25l;
						}
						
						req.setQuantity(d1stock);
						//req.setType(1L);
						ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
						
						if(rsp.isSuccess()){
							//System.out.println("ͬ�����ɹ���"+productId+" "+d1stock);
							return true ;
						}else{
							FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
							fw.write(it.getOuterId()+" "+rsp.getBody()+"  ��Ʒ����="+it.getTitle()+System.getProperty("line.separator"));
							fw.flush();
							fw.close();
							//System.out.println("ͬ����Ʒ���ʧ�ܣ������룺"+rsp.getErrorCode()+" response body="+rsp.getBody()+" ��Ʒ����="+it.getTitle());
						}
					}
				}
			}else{
				Product p = (Product)Tools.getManager(Product.class).get(productId);
				
				if(p!=null){
					long d1stock = p.getGdsmst_virtualstock().longValue();
					if(d1stock<0)d1stock=0;
					
					ItemQuantityUpdateRequest req=new ItemQuantityUpdateRequest();
					req.setNumIid(it.getNumIid());
					//req.setSkuId(it.getNumIid());
					//req.setOuterId(it.getOuterId());
					//��治�����������ҵ���Դ����һֱ����25�����
					//��治�����������ҵ���Դ����һֱ����25�����
					if(p!=null&&p.getGdsmst_stocklinkty()!=null&&p.getGdsmst_stocklinkty().longValue()==3){
						d1stock = 25l;
					}
					
					req.setQuantity(d1stock);
					//req.setType(1L);
					ItemQuantityUpdateResponse rsp = client.execute(req , sessionKey);
					
					if(rsp.isSuccess()){
						//System.out.println("ͬ�����ɹ���"+productId+" "+d1stock);
						return true ;
					}else{
						FileWriter fw = new FileWriter(new File("/var/error.txt"),true);
						fw.write(it.getOuterId()+" "+rsp.getBody()+" ��Ʒ����="+it.getTitle()+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						//System.out.println("ͬ����Ʒ���ʧ�ܣ������룺"+rsp.getErrorCode()+" response body="+rsp.getBody()+" ��Ʒ����="+it.getTitle());
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return false ;
	}
	
	/**
	 * ����ͬ��������sku�̼ұ���  ��01715909-XL(185)��
	 * @@throws Exception
	 */
	public static synchronized void tradeSyncGo()throws Exception{
		TradesSoldGetRequest req=new TradesSoldGetRequest();
		req.setFields("seller_nick, buyer_nick, status, buyer_message, title, type, created, tid, seller_rate, buyer_rate, status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, commission_fee, pic_path, num_iid, num, price, cod_fee, cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, receiver_zip, receiver_mobile, receiver_phone, orders");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String startStr = sdf.format(new Date(System.currentTimeMillis()-30*24*3600*1000l)) ;
		String endStr = sdf.format(new Date()) ;
		//System.out.println("start time="+startStr);
		//System.out.println("end time="+endStr);

		Date startTime = SimpleDateFormat.getDateTimeInstance().parse(startStr);
		req.setStartCreated(startTime);

		Date endTime = SimpleDateFormat.getDateTimeInstance().parse(endStr);//��ǰʱ��
		req.setEndCreated(endTime);
		req.setStatus("WAIT_SELLER_SEND_GOODS");//�ȴ����ҷ���,��:����Ѹ���
		//req.setBuyerNick("liuaike");
		//req.setType("game_equipment");
		//req.setRateStatus("RATE_UNBUYER");
		//req.setTag("time_card");
		
		long currentPage = 1l ;//��ǰҳ
		long PAGE_SIZE = 100l;//ÿҳȡ����
		
		req.setPageSize(PAGE_SIZE);
		req.setPageNo(currentPage);
		
		TradesSoldGetResponse response_1 = client.execute(req , sessionKey);
		List<Trade> list = response_1.getTrades() ;

		if(list!=null){
			syncTradeList(list);//ͬ����һҳ����
		}
		
		int totalPages = (int)(response_1.getTotalResults().longValue()/PAGE_SIZE) ;//������ҳ��
		
		if(response_1.getTotalResults().longValue()%PAGE_SIZE>0){
			totalPages+=1;
		}
		
		while(currentPage<totalPages){
			currentPage++;
			//System.out.println("ͬ����"+currentPage+"ҳ����..........................");
			req.setPageNo(currentPage);
			req.setPageSize(PAGE_SIZE);
			
			response_1 = client.execute(req , sessionKey);
			
			list = response_1.getTrades() ;
			if(list!=null){
			syncTradeList(list);//ͬ����һҳ����
			}
		}
	}
	
	/**
	 * ȡ����������
	 * @@throws Exception
	 */
	public static synchronized void tradeClosedSyncGo()throws Exception{
		TradesSoldGetRequest req=new TradesSoldGetRequest();
		req.setFields("seller_nick, buyer_nick, status, buyer_message, title, type, created, tid, seller_rate, buyer_rate, status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, commission_fee, pic_path, num_iid, num, price, cod_fee, cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, receiver_zip, receiver_mobile, receiver_phone, orders");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String startStr = sdf.format(new Date(System.currentTimeMillis()-30*24*3600*1000l)) ;
		String endStr = sdf.format(new Date()) ;
		//System.out.println("start time="+startStr);
		//System.out.println("end time="+endStr);

		Date startTime = SimpleDateFormat.getDateTimeInstance().parse(startStr);
		req.setStartCreated(startTime);

		Date endTime = SimpleDateFormat.getDateTimeInstance().parse(endStr);//��ǰʱ��
		req.setEndCreated(endTime);
		req.setStatus("TRADE_CLOSED");//�����Ժ��û��˿�ɹ��������Զ��ر�
		//req.setBuyerNick("liuaike");
		//req.setType("game_equipment");
		//req.setRateStatus("RATE_UNBUYER");
		//req.setTag("time_card");
		
		long currentPage = 1l ;//��ǰҳ
		long PAGE_SIZE = 100l;//ÿҳȡ����
		
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
						//ȡ����������.......
					}
				}
			}
		}
	}
	
	/**
	 * ͬ��һϵ�ж��������ݿ�
	 * @@param list
	 */
	private static void syncTradeList(List<Trade> list){
		if(list!=null)
		for(Trade t:list){
			OrderTmallService os = (OrderTmallService)Tools.getService(OrderTmallService.class);
			
			try{
				//������ԡ����ұ�עҪ������ȡ������
				TradeFullinfoGetRequest req=new TradeFullinfoGetRequest();
				req.setFields("buyer_message,seller_memo");
				req.setTid(t.getTid());
				TradeFullinfoGetResponse resp2 = client.execute(req , sessionKey);
				Trade t123 = resp2.getTrade();
				
				//�Ա�ҲҪ������ȡ
				UserGetRequest req135=new UserGetRequest();
				req135.setFields("user_id,nick,seller_credit,sex");
				req135.setNick(t.getBuyerNick());
				UserGetResponse response135 = client.execute(req135 , sessionKey);
				User u135 = response135.getUser();
				String sex = "��";
				if("f".equalsIgnoreCase(u135.getSex()))sex = "Ů";
				
				String sellor_memo = t123.getSellerMemo();
				
				OrderMain orderd1 = os.createOrderFromTmall(t,t123.getBuyerMessage(),sex,u135,sellor_memo,"");
				
				if(orderd1!=null)System.out.println("�Ա��̳Ƕ������Ƶ�d1�����ɹ���orderId="+orderd1.getId());
				
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
		}
	}
}


/**
 * �Ա���ݶ�Ӧ��ϵ
 * QFKD ����ȫ��
EMS EMS
YTO Բͨ�ٵ�
ZTO ��ͨ�ٵ�
ZJS լ����
HZABC ���ݰ�����
YUNDA �ϴ����
TTKDEX ������
FEDEX ������
EBON һ���ٵ�
STARS �ǳ�����
DBL �°�����
CRE ��������
SHQ ��ǿ����
HTKY ��ͨ����
WLB-ABC �㽭ABC
WLB-SAD ���ĵ�
SF ˳������
CCES CCES
STO ��ͨE����
ZY ��Զ
YCT ��èլ����
DFH ������
YC Զ��
XB �°�����
SY ��ҵ
NEDA �����ܴ�
XFHONG �ηɺ���
UC ��������
QRT ȫ��ͨ���
FAST ����ٵ�
 * 
 */

