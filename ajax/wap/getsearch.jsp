<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %><%!
private static String setrim(String s) {
    int i = s.length();// 字符串最后一个字符的位置
    int j = 0;// 字符串第一个字符
    int k = 0;// 中间变量
    char[] arrayOfChar = s.toCharArray();// 将字符串转换成字符数组
    while ((j < i) && (arrayOfChar[(k + j)] <= ' '))
     ++j;// 确定字符串前面的空格数
    while ((j < i) && (arrayOfChar[(k + i - 1)] <= ' '))
     --i;// 确定字符串后面的空格数
    return (((j > 0) || (i < s.length())) ? s.substring(j, i) : s);// 返回去除空格后的字符串
  }
%>
<%
JSONObject json = new JSONObject();
JSONArray jsonarr=new JSONArray();
//一共有几个参数key_wds=搜索词,sort=排序字段,rackcode=分类,pg=当前页,headsearchkey=头部搜索词,asc=升降序
	String keyWords = request.getParameter("key_wds"),rackcode=request.getParameter("rackcode"),
		pg = request.getParameter("pageno"),psize = request.getParameter("psize");
	//boolean isAsc = ("true".equals(asc)?true:false) ;
	
	//String isAscStr = "";
	//if(isAsc)isAscStr="true";
	//else isAscStr="false";
	
			if(!Tools.isNull(keyWords)) keyWords =URLDecoder.decode(keyWords,"Utf-8") ;//用base64编码传中文，免得出现乱码问题
	String sk = request.getParameter("headsearchkey");
	if(!Tools.isNull(sk)) sk = URLDecoder.decode(sk,"Utf-8");//用base64编码传中文，免得出现乱码问题
	if(Tools.isNull(keyWords)&&Tools.isNull(sk)){
	
		json.put("status", "0");
		out.print(json);
		return;
	}

	if(sk!=null){
		sk=setrim(sk);
	}

	if(!Tools.isNull(sk)){//重新搜索了
		
		if(sk.length()==8&&StringUtils.isDigits(sk)){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk);
			if(searchProduct!=null){
				json.put("status", "2");
				json.put("gourl", "http://m.d1.cn/wap/product.html?id="+searchProduct.getId());
				out.print(json);
				return;
			}
		}

		
		//这里看关键词是否需要跳转，如果需要跳转，直接跳转后不执行搜索
		KeySearch keySearch = (KeySearch)Tools.getManager(KeySearch.class).findByProperty("keysearch_txt",sk.trim());
		if(keySearch!=null&&!Tools.isNull(keySearch.getKeysearch_link())){
			json.put("status", "2");
			json.put("gourl", keySearch.getKeysearch_link());
			out.print(json);
			return;
		}
		keyWords = sk ;
		//rackcode = null ;
		session.removeAttribute(SearchManager.search_result_session_key);//重新搜索的话把原来session的搜索结果清除
	}else{
		if(keyWords!=null)keyWords=keyWords.replaceAll(" ", "+");
	}
	
	if(keyWords!=null)keyWords=keyWords.replaceAll(" +"," ");//把多个空格替换成一个空格
	//搜索结果
	SearchResult sr = SearchManager.getInstance().searchProduct(
			request,response,
			rackcode,
			keyWords,
			60000);//缓存时间，毫秒
			// 添加搜索记录

	if(Tools.isNull(psize))psize="12";
	final int PAGE_SIZE = Tools.parseInt(psize) ;//每页多少个
	int currentPage = 1 ;//当前页
	
	if(StringUtils.isDigits(pg)){
		currentPage = new Integer(pg).intValue();
	}
	
	int size = sr.getTotalcount(rackcode);
	PageBean pb = new PageBean(size,PAGE_SIZE,currentPage);//翻页的PageBean
		
	String sort=request.getParameter("order");
	boolean isAsc=true;
	if(sort.equals("5")){
		sort="createtime";
		isAsc=false;
	}else if(sort.equals("3")){
		sort="sales";
		isAsc=false;
	}else if(sort.equals("2")){
		sort="price";
		
	}
	
	
	//搜索结果
	//List<Product> list = sr.getProducts(rackcode, sort,msflag,shopd1, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);
	List<Product> list = sr.getProducts(rackcode, sort, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);
	
	
	int count=0;
	if(size>0){
		json.put("status", 1);
	    json.put("page_total", size);
		
		String hotKeyCode = "000";
		JSONArray jsonrckarr=new JSONArray();
		 ArrayList<String> list123 = sr.getNextLevelRackcodes(rackcode) ;//得到下一级搜索分类列表
		    if(list123!=null&&list123.size()>0){
	
		    	
		    	for(String s123:list123){
		    		JSONArray jsonrckarrm=new JSONArray();
			    	JSONObject jsonitem = new JSONObject();
		    		int i = 0;
		    		if(i == 0) hotKeyCode = s123;
		    		i++;
		    		Directory dir = new Directory();
		    		dir=(Directory)Tools.getManager(Directory.class).get(s123);
		    		if(dir==null)continue;
		    		ArrayList<String> listnext = sr.getNextLevelRackcodes(dir.getId()) ;//得到下一级搜索分类列表
		    		if(listnext!=null&&listnext.size()>0){
		    			jsonitem.put("mrackname",  dir.getRakmst_rackname());
		    			jsonitem.put("mrackcode",  dir.getId());
		    			int j = 0;
		    			for(String sn:listnext){
		    				JSONObject jsonitemm = new JSONObject();
					    	if(j == 0) hotKeyCode = sn;
					    	j++;
					    	Directory diritem = new Directory();
	
					    	diritem=(Directory)Tools.getManager(Directory.class).get(sn);
					    	if(diritem!=null){
	                             if(diritem.getRakmst_showflag()==null||diritem.getRakmst_showflag().longValue()!=1)continue;
	                             jsonitemm.put("drackname",  diritem.getRakmst_rackname());
	                             jsonitemm.put("drackcode",  diritem.getId());
	                             jsonrckarrm.add(jsonitemm);
                             }
					    	
					    }
		    			jsonitem.put("mrackitems", jsonrckarrm);
		    			jsonrckarr.add(jsonitem);
		    		}
		    	}
		    }
		    json.put("racks", jsonrckarr);
		
		
		 SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		    String	nowtime2= DateFormat.format( new Date());
		    DecimalFormat df2 = new DecimalFormat("0.00");
		    boolean ismiaoshao=false; 
     	   boolean issgflag=false; 
     	  
	 for(Product goods : list){ 
		 JSONObject jsonitem = new JSONObject();
		 count++;
	        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
	        	   String id = goods.getId();
	        	   String shopcode=goods.getGdsmst_shopcode();
	        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
	        	   long currentTime = System.currentTimeMillis();
	        	    ismiaoshao=false; 
	        	    issgflag=false; 
	        	   String brandname=goods.getGdsmst_brandname();
	        	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
	        	String gtitle="";
	        	if(gname.length()<32){
	        	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
	        	}

	        			ismiaoshao=CartHelper.getmsflag(goods);
	        		D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
	        		long gdsnum=0;
	        		long buynum=0;
	        		long gdsnum2=0;
	        		if(ismiaoshao){
	        		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
	        		  if(sg!=null&&sg.getSggdsdtl_status().longValue()==1){
	        			   gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
	        	             gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
	        	        	
	        	         	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

	        	             if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
	        	             	  gdsnum=0;
	  
	        	             }
	        			  
	    			     if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
	    					&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
	    			    	 issgflag=true ;
	    			     }
	        		  }
	        		}
	        		float msprice=0f;
	        		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
	        		//int comnum= CommentHelper.getCommentLength(id);
	        		jsonitem.put("p_gdsid",id);
	        		jsonitem.put("p_gdsname",title);
	        		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
	        		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
	        		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
	        		jsonitem.put("p_msprice",df2.format(msprice));
	        		jsonitem.put("p_ismiaoshao",ismiaoshao);
	        		jsonitem.put("p_issgflag",issgflag);
	        		jsonitem.put("p_shopcode",goods.getGdsmst_shopcode());
	        		jsonitem.put("p_tktflag", goods.getGdsmst_specialflag().longValue()==1?true:false);
	        		//jsonitem.put("p_comnum",comnum);
	        		if(acttb!=null){ 
       			     String acttxt="满"+acttb.getD1acttb_snum1()+"减"+acttb.getD1acttb_enum1();
       			     if(acttb.getD1acttb_enum2()>0){
       					 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum2()+"减"+acttb.getD1acttb_enum2();
       				 }
       				 if(acttb.getD1acttb_enum3()>0){
       					 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum3()+"减"+acttb.getD1acttb_enum3();
       				 }
       			     jsonitem.put("p_acttxt",acttxt);
		        		}else{
		        			 jsonitem.put("p_acttxt","");
		        		}
	        		jsonarr.add(jsonitem);
	 }
	 json.put("products", jsonarr);
	}else{
		json.put("status", "0");
	}
	out.print(json);
%>