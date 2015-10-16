package com.d1.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.tokenattributes.TermAttribute;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.PhraseQuery;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKTokenizer;

import com.d1.Const;
import com.d1.LRUCache;
import com.d1.bean.Product;
import com.d1.manager.ProductManager;
import com.d1.util.Base64;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * 搜索工具，提供建索引，查询，高亮显示的一些基本方法<br>
 */
public class SearchManager {
	
	/**
	 * 单子me
	 */
	private static SearchManager me = null ;
	
	/**
	 * SearchResult放入session的key
	 */
	public final static String search_result_session_key = "search_result_session_key_378Q";
	
	/**
	 * 对10000个搜索词进行缓存
	 */
	private static Map<String,SearchResult> CACHE_MAP = Collections.synchronizedMap(new LRUCache<String,SearchResult>(10000));

	/**
	 * 存储淘宝搜索词的hashmap
	 */
	private static Map<String,String> TAOBAO_KEY_WORDS_HASHMAP = Collections.synchronizedMap(new HashMap<String,String>());
	
	/**
	 * 淘宝搜索词的文件名
	 */
	private static final String TAOBAO_KEY_WORDS_FILENAME = Const.PROJECT_PATH+"conf/taobao_ok.txt";
	
	/**
	 * 索引的目录
	 */
	private final static String INDEX_PATH =  Const.PROJECT_PATH+"lucene/products/"; 
	
	/**
	 * 修改过得商品id，每分钟更新一次所有
	 */
	private static Map<String,String> UPDATE_PRODUCT_ID_MAP = new ConcurrentHashMap<String,String>();
	
	static{
		try	{
			File lf = new File(INDEX_PATH);
			if(!lf.exists())lf.mkdirs();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		/**
		 * 读入分词词库
		 */
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File(TAOBAO_KEY_WORDS_FILENAME)));
			String line = null ;
			while((line=br.readLine())!=null){
				TAOBAO_KEY_WORDS_HASHMAP.put(line, "");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * 把商品id加入map中
	 * @param productId
	 */
	public void addUpdateProductId(String productId){
		if(!Tools.isNull(productId))UPDATE_PRODUCT_ID_MAP.put(productId, "");
	}
	
	/**
	 * 批量更新商品索引
	 */
	public void batchUpdateProductIndex(){
		Iterator<String> it = UPDATE_PRODUCT_ID_MAP.keySet().iterator();
		while(it.hasNext()){
			String pid = it.next();
			Product product = (Product)Tools.getManager(Product.class).get(pid);
			updateProductIndex(product);
			it.remove();
		}
	}
	/**
	 * 单子方法
	 * @return
	 */
	public static SearchManager getInstance() {
		if (me == null) {
			synchronized (SearchManager.class) {
				if (me == null) {
					me = new SearchManager();
				}
			}
		}
		return me;
	}
	
	/**
	 * 不让外部代码new出来
	 */
	private SearchManager(){}
	
	/**
	 * 建立product索引，增加了地区的字段
	 * @param product
	 */
	public synchronized void createProductIndex(Product product){
		if(product==null)return;
		Analyzer writerAnalyzer = new StandardAnalyzer(Version.LUCENE_30);
		
		IndexWriter writer = null ;
		Directory dir = null ;
		try {
			dir = FSDirectory.open(new File(INDEX_PATH));
			//if(IndexReader.isLocked(dir))IndexReader.unlock(dir);
			File indexDir = new File(INDEX_PATH);
			boolean isFirstIndex = true ;//是否第一次建立索引
			if(indexDir.exists()&&indexDir.list()!=null&&indexDir.list().length>0)isFirstIndex = false ;
			writer = new IndexWriter(dir, writerAnalyzer, isFirstIndex,IndexWriter.MaxFieldLength.UNLIMITED);
			//writer.setMergeFactor(10);
			//writer.setMaxMergeDocs(100);
			writer.setUseCompoundFile(true);
			index(product,writer);
	   	}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(writer!=null)writer.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(dir!=null)dir.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
	
	/**
	 * @param product
	 * @param writer
	 * @throws Exception
	 */
	private void index(Product product,IndexWriter writer)throws Exception{
		Document doc = new Document();
		
		String name = product.getGdsmst_gdsname()+product.getGdsmst_keyword() ;
		//新加的字段
		if(!Tools.isNull(product.getGdsmst_stdvalue1()))
		{
			name+=product.getGdsmst_stdvalue1();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue2()))
		{
			name+=product.getGdsmst_stdvalue2();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue3()))
		{
			name+=product.getGdsmst_stdvalue3();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue4()))
		{
			name+=product.getGdsmst_stdvalue4();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue5()))
		{
			name+=product.getGdsmst_stdvalue5();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue6()))
		{
			name+=product.getGdsmst_stdvalue6();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue7()))
		{
			name+=product.getGdsmst_stdvalue7();
		}
		if(!Tools.isNull(product.getGdsmst_stdvalue8()))
		{
			name+=product.getGdsmst_stdvalue8();
		}
		name = name.toLowerCase();//转成小写
		name = name.replaceAll("\\p{Punct}", " ");//去掉标点符号
		name = name.replaceAll(" +", " ");
		
		//需要全文检索的字段
		doc.add(new Field("name",name,Field.Store.YES,Field.Index.ANALYZED));//商品名称+关键字！！！！
		
		//boost就是因子，如果按doc排序，就会选择这个排序字段
		//if(product.getGdsmst_createdate()!=null)doc.setBoost(product.getGdsmst_createdate().getTime()); //上架时间
		//else doc.setBoost(System.currentTimeMillis());
		
		//需要用来检索的字段，但不需要全文检索		
		doc.add(new Field("productId",product.getId()+"",Field.Store.YES,Field.Index.NOT_ANALYZED));//商品id
		doc.add(new Field("validflag",product.getGdsmst_validflag()+"",Field.Store.YES,Field.Index.NOT_ANALYZED));//商品上架标志，1表示上架商品
		
   		writer.addDocument(doc);
	}
	
	/**
	 * 更新product索引，先删除后重建
	 */
	public void updateProductIndex(Product product){
		if(product==null)return;
		removeProductIndex(product);
		createProductIndex(product);
	}
	
	/**
	 * 根据商品id删除商品索引
	 * @param productId
	 */
	public synchronized void removeProductIndex(String productId){
		IndexReader ir = null;
		Directory dir = null ;
		try{
			dir = FSDirectory.open(new File(INDEX_PATH));
			ir = IndexReader.open(dir,false);
			ir.deleteDocuments(new Term("productId",productId));
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try{
				if(ir!=null)ir.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(dir!=null)dir.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
	
	/**
	 * 删除product索引。
	 * @param product
	 */
	public void removeProductIndex(Product product){
		if(product==null)return;
		removeProductIndex(product.getId());
	}
	
	/**
	 * 重建所有商品索引,该方法会删除原来索引目录下的所有文件，不要轻易使用！！
	 */
	public synchronized void reIndexAllProduct(){

		FileUtil.deleteDir(new File(INDEX_PATH));
		
		File fdir = new File(INDEX_PATH);
		if(!fdir.exists()){
			fdir.mkdirs();
		}
		
		List<Product> list = ((ProductManager)Tools.getManager(Product.class)).getTotalProductList();
		
		Directory dir = null ;
		IndexWriter writer = null ;
		try{
			
			Analyzer writerAnalyzer = new StandardAnalyzer(Version.LUCENE_30);
			dir = FSDirectory.open(new File(INDEX_PATH));
			File indexDir = new File(INDEX_PATH);
			
			boolean isFirstIndex = true ;
			if(indexDir.exists()&&indexDir.list()!=null&&indexDir.list().length>0)isFirstIndex = false ;
			writer = new IndexWriter(dir, writerAnalyzer, isFirstIndex, IndexWriter.MaxFieldLength.UNLIMITED);
				
			 if(list!=null&&list.size()>0){
				 for(int i=0;i<list.size();i++){
					Product product = (Product)list.get(i);
					index(product,writer);
				 }
			 }
		} catch(Exception e){
				 e.printStackTrace();
		} finally{
			 try{
				 if(writer!=null)writer.close();
			 }catch(Exception ex){
				 ex.printStackTrace();
			 }
			 try{
				 if(dir!=null)dir.close();
				 
			 }catch(Exception eex){
				 eex.printStackTrace();
			 }
		}
	}
	
	/**
	 * 优化索引目录，把原来删除标记的数据全部清除，把索引的多个文件合并成少量文件...
	 * 
	 */
	public synchronized void optimize(){
		IndexWriter writer = null ;
		Directory dir = null;
		try {
			Analyzer writerAnalyzer = new StandardAnalyzer(Version.LUCENE_30);
			dir = FSDirectory.open(new File(INDEX_PATH));
			writer = new IndexWriter(dir,writerAnalyzer, false,IndexWriter.MaxFieldLength.UNLIMITED);
			//合并到一起
			writer.optimize();
		} catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(writer!=null)writer.close();
			}catch(Exception eex){
				eex.printStackTrace();
			}
			try{
				if(dir!=null)dir.close();
			}catch(Exception eex){
				eex.printStackTrace();
			}
		}
	}
	
	/**
	 * 根据输入的文字搜索商id列表，排序方法在SearchResult里面，分页在jsp中用PageBean分。<br/>
	 * @param request Jsp里的request
	 * @param response Jsp里的response
	 * @param rackcode 分类 null表示搜索全部，重新搜索的时候传null
	 * @param name 搜索的文字，用户输入的搜索文字。如“女式  牛仔裤”，分词用空格分开
	 * @param cacheTime 缓存时间毫秒,0表示不做缓存。测试阶段不要用缓存，正式阶段缓存1分钟即可（cacheTime=60000）
	 * @return
	 */
	public SearchResult searchProduct(HttpServletRequest request,HttpServletResponse response,
			String rackcode,String name,long cacheTime){
		
		SearchResult result = new SearchResult();//搜索返回结果
		result.setKeyWords(name);
		
		if(name==null)name="";
		
		name = name.toLowerCase();//转成小写
		name = name.replaceAll("\\p{Punct}", " ");//去掉标点符号
		name = name.replaceAll(" +", " ");

		//从session中查找返回结果
		
		javax.servlet.http.HttpSession session = request.getSession();
		
		String base64Name = Base64.encode(name);
		
		SearchResult sr33 = (SearchResult)session.getAttribute(search_result_session_key+base64Name);
		if(sr33!=null&&sr33.getTotalcount(null)>0){
			return sr33;
		}
		
		//从缓存中查找搜索结果
		if(cacheTime>0&&CACHE_MAP.containsKey(name)){
			SearchResult sr123 = CACHE_MAP.get(name);
			if(sr123!=null){
				if(sr123.getExpireTime()>=System.currentTimeMillis()){//没有过期
					session.setAttribute(search_result_session_key+base64Name, sr123);//放入session
					return sr123 ;
				}else{
					CACHE_MAP.remove(name);
				}
			}
		}
		
		//System.out.println("搜索文件：name="+name+" path="+INDEX_PATH);
		
		Directory dir = null ;
		IndexReader reader = null ;
		IndexSearcher searcher = null ;
		try {
			SortField[] sfs = null;
			//if (orderstr!=null && orderstr.length()>0){
				//sfs=new SortField[] {new SortField(orderstr, SortField.SCORE, orderboolean) };
			//}else{
				sfs=new SortField[] {new SortField(null, SortField.DOC, true) };
			//}
			
			
			Sort sort = new Sort(sfs);
			dir = FSDirectory.open(new File(INDEX_PATH));
			//if(IndexReader.isLocked(dir))IndexReader.unlock(dir);
			reader = IndexReader.open(dir);//KK
			searcher = new IndexSearcher(reader);//KK
			
			BooleanQuery bquery=new BooleanQuery();
			
			//只搜上架商品
			//bquery.add(new TermQuery(new Term("validflag","1")),BooleanClause.Occur.MUST);
			
			//去掉标点符号，把中文和英文用词分开来
			if(name!=null && name.length()>0 ){
				String sb = name ;
				sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
				sb = sb.replaceAll(" +", " ");
				String[] sbs = sb.split(" ");
				if(sbs!=null){
					for(int i=0;i<sbs.length;i++){
						String w1 = sbs[i];
						if(w1.length()>0){
							//中文再自动分一次词，最小化颗粒分词。如“兰蔻香水”分成“兰蔻”和“香水”两个词，但“香水”不可再分
							ArrayList<String> ks = kkSplit(w1);
							if(ks!=null&&ks.size()>0){
								for(String sw:ks){
									PhraseQuery pq = new PhraseQuery();  
									for(int j=0;j<sw.length();j++){
										pq.add(new Term("name",sw.charAt(j)+""));  
									}
									bquery.add(pq,BooleanClause.Occur.MUST);
								}
							}
						}
					}
				}
				String sb2 = name;
				sb2 = sb2.replaceAll("[\\u4e00-\\u9fa5]", " ");
				sb2 = sb2.replaceAll(" +", " ");
				String[] sbs2 = sb2.split(" ");
				if(sbs2!=null){
					for(int i=0;i<sbs2.length;i++){
						String w2 = sbs2[i];
						if(w2.length()>0){//这里是英文
							PhraseQuery pq = new PhraseQuery();  
							pq.add(new Term("name",w2));  
							bquery.add(pq,BooleanClause.Occur.MUST);
						}
					}
				}
			}
			
			//最多搜索到1000个商品
			TopDocs topDocs = searcher.search(bquery,null,1000,sort);
			
			ScoreDoc[] hits = topDocs.scoreDocs ;
			
			Map<String,Integer> rackMap = new ConcurrentHashMap<String,Integer>();
			CopyOnWriteArrayList<Product> resultlist = new CopyOnWriteArrayList<Product>();
			
			int totalcount = 0 ;//总商品数
			if(hits!=null&&hits.length>0){
				for(int i=0;i<hits.length;i++){
					Document doc = searcher.doc(hits[i].doc);
			    	Product sp = (Product)Tools.getManager(Product.class).get(doc.get("productId"));
			    	if(sp!=null){
			    		//分类和分类搜索结果数
			    		String gdsrackcode = sp.getGdsmst_rackcode();
			    		if(gdsrackcode!=null&&sp.getGdsmst_validflag()!=null&&sp.getGdsmst_validflag().longValue()==1&&sp.getGdsmst_ifhavegds()!=null&&sp.getGdsmst_ifhavegds().longValue()==0){//分类长度必须是3的整数倍，才算
			    			totalcount++;//总数+1
				    		for(int x=0;x<(int)(gdsrackcode.length()/3);x++){//按照分类级别展开
				    			String vgdsrackcode = gdsrackcode.substring(0,3*x+3);
				    			
				    			if(rackMap.containsKey(vgdsrackcode)){
					    			Integer ri = rackMap.get(vgdsrackcode);
					    			rackMap.put(vgdsrackcode, new Integer(ri.intValue()+1));
					    		}else{
					    			rackMap.put(vgdsrackcode, new Integer(1));
					    		}
				    		}
				    		resultlist.add(sp);//加入到搜索结果
			    		}//else{
			    			//System.err.println("搜索商品有点问题，商品id="+sp.getId());
			    		//}
			    	}
			    }
			}
			
			result.setTotalcount(totalcount);
			result.setRackMap(rackMap);
			result.setResultlist(resultlist);
			result.setExpireTime(System.currentTimeMillis()+cacheTime);//设置缓存过期时间
			
			if(cacheTime>0)CACHE_MAP.put(name, result);//放入缓存
			
			session.setAttribute(search_result_session_key+base64Name, result);//放入session
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
				if(reader!=null)reader.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(searcher!=null)searcher.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(dir!=null)dir.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		return result;
	}	
	
	
	public int searchProductCount(String name){
		
		SearchResult result = new SearchResult();//搜索返回结果
		result.setKeyWords(name);
		
		if(name==null)name="";
		
		name = name.toLowerCase();//转成小写
		name = name.replaceAll("\\p{Punct}", " ");//去掉标点符号
		name = name.replaceAll(" +", " ");

		//从session中查找返回结果
		
		
		//System.out.println("搜索文件：name="+name+" path="+INDEX_PATH);
		
		Directory dir = null ;
		IndexReader reader = null ;
		IndexSearcher searcher = null ;
		try {
			SortField[] sfs = null;
			//if (orderstr!=null && orderstr.length()>0){
				//sfs=new SortField[] {new SortField(orderstr, SortField.SCORE, orderboolean) };
			//}else{
				sfs=new SortField[] {new SortField(null, SortField.DOC, true) };
			//}
			
			
			Sort sort = new Sort(sfs);
			dir = FSDirectory.open(new File(INDEX_PATH));
			//if(IndexReader.isLocked(dir))IndexReader.unlock(dir);
			reader = IndexReader.open(dir);//KK
			searcher = new IndexSearcher(reader);//KK
			
			BooleanQuery bquery=new BooleanQuery();
			
			//去掉标点符号，把中文和英文用词分开来
			if(name!=null && name.length()>0 ){
				String sb = name ;
				sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
				sb = sb.replaceAll(" +", " ");
				String[] sbs = sb.split(" ");
				if(sbs!=null){
					for(int i=0;i<sbs.length;i++){
						String w1 = sbs[i];
						if(w1.length()>0){
							//中文再自动分一次词，最小化颗粒分词。如“兰蔻香水”分成“兰蔻”和“香水”两个词，但“香水”不可再分
							ArrayList<String> ks = kkSplit(w1);
							if(ks!=null&&ks.size()>0){
								for(String sw:ks){
									PhraseQuery pq = new PhraseQuery();  
									for(int j=0;j<sw.length();j++){
										pq.add(new Term("name",sw.charAt(j)+""));  
									}
									bquery.add(pq,BooleanClause.Occur.MUST);
								}
							}
						}
					}
				}
				String sb2 = name;
				sb2 = sb2.replaceAll("[\\u4e00-\\u9fa5]", " ");
				sb2 = sb2.replaceAll(" +", " ");
				String[] sbs2 = sb2.split(" ");
				if(sbs2!=null){
					for(int i=0;i<sbs2.length;i++){
						String w2 = sbs2[i];
						if(w2.length()>0){//这里是英文
							PhraseQuery pq = new PhraseQuery();  
							pq.add(new Term("name",w2));  
							bquery.add(pq,BooleanClause.Occur.MUST);
						}
					}
				}
			}
			
			//最多搜索到1000个商品
			TopDocs topDocs = searcher.search(bquery,null,1000,sort);
			
			ScoreDoc[] hits = topDocs.scoreDocs ;
			if(hits!=null){
				for(int i=0;i<hits.length;i++){
					Document doc = searcher.doc(hits[i].doc);
					System.out.println(doc.get("name"));
				}
			}
			if(hits!=null)return hits.length;
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
				if(reader!=null)reader.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(searcher!=null)searcher.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			try{
				if(dir!=null)dir.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		return -1;
	}	
	
	/**
	 * 给标题加上红色和粗体，高亮显示。有个小问题，数字不能高亮。<br/>
	 * lucene自带的高亮显示虽然也可以，但是可能会产生太多的<font>标签（因为分词问题），所以不用<br/>
	 * @param productName
	 * @param searchKeyWords
	 * @return
	 */
	public String highlighterProductName(String productName,String searchKeyWords){
		if(productName==null)return null;
		if(searchKeyWords==null)return productName;
		
		productName = productName.toLowerCase();
		searchKeyWords = searchKeyWords.toLowerCase();
		
		searchKeyWords = searchKeyWords.replaceAll("\\p{Punct}", " ");//去掉标点符号
		searchKeyWords = searchKeyWords.replaceAll(" +", " ");
        
		ArrayList<String> list = new ArrayList<String>();
		
		if(searchKeyWords!=null && searchKeyWords.length()>0 ){
			String sb = searchKeyWords ;
			sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
			sb = sb.replaceAll(" +", " ");
			String[] sbs = sb.split(" ");
			if(sbs!=null){
				for(int i=0;i<sbs.length;i++){
					String w1 = sbs[i];
					if(w1.length()>0){
						ArrayList<String> ks = kkSplit(w1);
						if(ks!=null&&ks.size()>0){
							for(String sw:ks){
								list.add(sw);
							}
						}
					}
				}
			}
			String sb2 = searchKeyWords;
			sb2 = sb2.replaceAll("[\\u4e00-\\u9fa5]", " ");
			sb2 = sb2.replaceAll(" +", " ");
			String[] sbs2 = sb2.split(" ");
			if(sbs2!=null){
				for(int i=0;i<sbs2.length;i++){
					String w2 = sbs2[i];
					if(w2.length()>0){
						list.add(w2);
					}
				}
			}
		}
		
		productName = productName.replaceAll("<", "&lt;");
		productName = productName.replaceAll(">", "&gt;");
		
		Collections.sort(list,new StringLengthComparator());
		
		String start = "<font color=red><b>",end="</b></font>";
		HashMap<String,String> smap = new HashMap<String,String>();
		
		for(int i=0;i<list.size();i++){
			String s = list.get(i);
			if(!StringUtils.isDigits(s)){
				productName = productName.replaceAll(s, "<"+i+">");
				smap.put("<"+i+">", start+s+end);
			}
		}
		
		Iterator<String> it = smap.keySet().iterator();
		while(it.hasNext()){
			String k = it.next();
			productName = productName.replaceAll(k, smap.get(k));
		}
		return productName;
	}
	
	public static void test() throws Exception{
		File f = new File("D://中文分词词库整理");
		String[] fs = f.list();
		HashMap<String,String> map = new HashMap<String,String>();
		int count = 0 ;
		for(int i=0;i<fs.length;i++){
			if(fs[i].endsWith(".txt")){
				System.out.println("分析"+fs[i]+"...");
				BufferedReader br = new BufferedReader(new FileReader(new File("D://中文分词词库整理//"+fs[i])));
				String line = null ;
				while((line=br.readLine())!=null){
					line = line.replaceAll("[^\\u4e00-\\u9fa5]", "");//不是中文全去掉
					if(line.length()>1){
						count++;
						if(count%5000==0)System.out.println(">>>>"+count+"<<<<");
						map.put(line, "");
					}
				}
				br.close();
			}
		}
		
		ArrayList<String> list = new ArrayList<String>();
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()){
			list.add(it.next());
		}
		
		Collections.sort(list);
		
		StringBuffer sb = new StringBuffer();
		for(String s:list){
			sb.append(s).append(System.getProperty("line.separator"));
		}
		
		FileWriter fw = new FileWriter(new File("d://m.txt"));
		fw.write(sb.toString());
		fw.flush();
		fw.close();
	}
	
	/**
	 * IK分词分成若干个词，现在没用，直接用kkSplit方法。
	 * @param name
	 * @return
	 */
	public static ArrayList<String> ikSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();//map为了去重
		IKTokenizer tokenizer = new IKTokenizer(new StringReader(name) , false);
		try {
			while(tokenizer.incrementToken()){
				TermAttribute termAtt = tokenizer.getAttribute(TermAttribute.class);
				map.put(termAtt.term(),"");				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()){
			list.add(it.next());
		}
		
		if(list.size()<=1)return list;//如果只有一个词，分得没问题，不用优化
		
		//然后优化一下分词结果，从左到右匹配，去掉一些不人性化的结果。
		//如“九牧王牛仔裤”分词结果是“九牧王牛仔裤   九牧王   九牧   九  牛仔   仔裤”，
		//但其实我只需要“九牧王   牛仔裤”（因为“牛仔”是个词，“牛仔裤”当两个词）
		ArrayList<String> rlist = new ArrayList<String>();
		
		for(int i=0;i<list.size();i++){
			String s1 = list.get(i);
			map.put(s1, "");
		}
		
		//for(String s:list)System.out.println("map===="+s);
		
		HashMap<String,String> rmap = new HashMap<String,String>();//结果map
 		for(int i=0;i<name.length();i++){
			String k = name.charAt(i)+"";
			
			int p = 0 ;
			for(int j=i+1;j<=name.length();j++){
				String w = name.substring(i,j);
				//System.out.println(w);
				if(map.containsKey(w)&&!name.equals(w)){
					k = name.substring(i,j);
					//System.out.println(w);
					p = j-i-1;
				}
			}
			i+=p;
			rmap.put(k,"");
		}
 		
 		Iterator<String> it2 = rmap.keySet().iterator();
		while(it2.hasNext()){
			rlist.add(it2.next());
		}
		return rlist;
	}
	
	/**
	 * KK分词方法，从做到右做最大匹配。<br/>
	 * 如“九牧王牛仔裤”，“九牧”“九牧王”“牛仔”“牛仔裤”都是词，但是做最大匹配分成“九牧王”和“牛仔裤”<br/>
	 * 这里只分连起来的中文，中英文混合的情况在外面处理<br/>
	 * @param name
	 * @return
	 */
	private static ArrayList<String> kkSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		
		HashMap<String,String> rmap = new HashMap<String,String>();//结果map
 		
		for(int i=0;i<name.length();i++){
			String k = name.charAt(i)+"";
			
			int p = 0 ;
			for(int j=i+1;j<=name.length();j++){
				String w = name.substring(i,j);
				//System.out.println(w);
				if(TAOBAO_KEY_WORDS_HASHMAP.containsKey(w)){
					k = name.substring(i,j);
					//System.out.println(w);
					p = j-i-1;
				}
			}
			i+=p;
			rmap.put(k,"");
			list.add(k);
		}
	
		ArrayList<String> rlist = new ArrayList<String>();
 		
 		for(String s:list){
 			if(rmap.containsKey(s))rlist.add(s);
 		}
		return rlist;
	}
	
	/**
	 * 测试分词效果
	 */
	public static void testSplit(){
		String[] names ={"九牧王男士休闲牛仔裤",
				"香奈儿可可女士香水",
				"欧莱雅润肤霜",
				"飞利浦干电式剃须刀",
				"创意个性鼠标垫",
				"女士香水",
				"浪漫可爱牛奶杯",
				"德国真空保鲜盒",
				"蓝天使高清播放器",
				"不锈钢咖啡壶保温壶",
				"兰蔻女士香水",
				"自然堂牌护手霜",
				"新款秋冬装外套 ",
				"女装韩版毛领斗篷",
				"资生堂眼霜",
				"欧泊莱爽肤水女",
				"佰草集专柜正品平衡洁面乳",
				"梦妆洗面奶批发韩国原装梦妆洗面奶",
				"真皮女士手表",
				"中老年奶粉",
				"言若秋冬装新款韩版双排扣修身长款西装领毛呢大衣外套女",
				"梦芭莎女士内衣调整型聚拢一片式无痕性感豹纹文胸",
				"绝美奢华蓝狐皇庭毛领 长款加厚收腰皮草羽绒服",
				"艾斯臣正品雪地靴高筒靴清仓女靴子牛皮冬靴雪地鞋女鞋牛筋底包邮",
				"倾情打造简约复古范真皮韩版钱包磨砂手感女士钱包女长款",
				"开光正品泗滨砭石貔貅手链红玛瑙保健防辐射",
				"韩国进口乐天妈妈手派饼干手工饼干淡淡起司味特别推荐",
				"巡洋龙 真皮男包商务牛皮男士手提包电脑包 时尚公文包",
				"中老年服装正品"};
			
		
		for(String name:names){
			ArrayList<String> list = kkSplit(name.replaceAll(" ", ""));
			System.out.print(name+"【");
			for(String s:list){
				System.out.print(s+"|");
			}
			System.out.print("】");
			System.out.println();
		}
	}
	
	public static void main(String[] args) throws Exception{
		
		//SearchManager.getInstance().testIndexAll();
		//test();
		//SearchManager.getInstance().searchProductCount("牛仔裤");
		
		//testSplit();
		for(int i=0;i<10;i++){
			SearchManager.getInstance().addUpdateProductId(i+"");
		}
		
		Iterator<String> it = UPDATE_PRODUCT_ID_MAP.keySet().iterator();
		while(it.hasNext()){
			String pid = it.next();
			it.remove();
			System.out.println(pid);
		}
		
		System.out.println("=====================");
		Iterator<String> it2 = UPDATE_PRODUCT_ID_MAP.keySet().iterator();
		while(it2.hasNext()){
			String pid = it.next();
			System.out.println(pid);
		}
		
		System.out.println("=====================");
		
		System.out.println("sdfjk*skjdfhjk*ksd******".replace("*", "&"));
		
		String x="670-686-690-0-0-0-0-0-0-0-1-1-4";
		String[]fs = x.split("-");
		for(String s:fs){
			System.out.println(s);
		}
		
		/*
		BufferedReader br = new BufferedReader(new FileReader(new File("d://taobaokey.txt")));
		
		String line = null ;
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine())!=null){
			line = line.trim();
			line = line.replaceAll("\\p{Punct}", " ");
			line = line.replaceAll(" +", " ");
			line = line.toLowerCase();
			line = line.trim();
			int c = SearchManager.getInstance().searchProductCount(line);
			if(c>0){
				System.out.println(line+"="+c);
				String sl = line.replaceAll(" ", "");
				String sss = line+","+PinyinUtil.getFullPinyin(sl)+","+PinyinUtil.getFirstPinyin(sl)+","+c;
				map.put(sss,"");
			}
		}
		
		br.close();
		
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()){
			list.add(it.next());
		}
		
		Collections.sort(list);
		for(String s:list){
			sb.append(s).append(System.getProperty("line.separator"));
		}
		
		FileWriter fw = new FileWriter(new File("d:/hot_search_keys.txt"));
		fw.write(sb.toString());
		fw.flush();
		fw.close();*/
		
		//SearchManager.getInstance().testIndexAll();
		//System.out.println(highlighterProductName("",""));
		
		//name = name.replaceAll("[^\\u4e00-\\u9fa5]", "");
		
		//System.out.println(name);
		
		//System.out.println(SearchManager.getInstance().highlighterProductName("1908我就是要穿1908女士的牛仔裤，我特别喜欢女士做的牛仔裤",name));
		/*
		Analyzer analyzer = new IKAnalyzer(false);   
        TokenStream tokenStream = analyzer.tokenStream("contents", new StringReader(name));   
        
        TermAttribute termAtt = (TermAttribute) tokenStream.getAttribute(TermAttribute.class);    
        //TypeAttribute typeAtt = (TypeAttribute) tokenStream.getAttribute(TypeAttribute.class);    
  
        while (tokenStream.incrementToken()) {    
            System.out.print(termAtt.term());    
            System.out.print("|");       
        }    
		System.out.println();*/
		
		//Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_30);
		
		/*
		Analyzer analyzer1 = new IKAnalyzer(false);   
        TokenStream tokenStream1 = analyzer1.tokenStream("contents", new StringReader(name));   
        
        TermAttribute termAtt1 = (TermAttribute) tokenStream1.getAttribute(TermAttribute.class);    
        //TypeAttribute typeAtt = (TypeAttribute) tokenStream.getAttribute(TypeAttribute.class);    
  
        while (tokenStream1.incrementToken()) {    
            System.out.print(termAtt1.term());    
            System.out.print("|");       
        }    */
	        /*
	        System.out.println("-----------------");
	        name = name.toLowerCase();//转成小写
			name = name.replaceAll("\\p{Punct}", " ");//去掉标点符号
			name = name.replaceAll(" +", " ");
	        
			if(name!=null && name.length()>0 ){
				String sb = name ;
				sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
				sb = sb.replaceAll(" +", " ");
				String[] sbs = sb.split(" ");
				if(sbs!=null){
					for(int i=0;i<sbs.length;i++){
						String w1 = sbs[i];
						if(w1.length()>0){
							System.out.println(w1);
						}
					}
				}
				String sb2 = name;
				sb2 = sb2.replaceAll("[\\u4e00-\\u9fa5]", " ");
				sb2 = sb2.replaceAll(" +", " ");
				String[] sbs2 = sb2.split(" ");
				if(sbs2!=null){
					for(int i=0;i<sbs2.length;i++){
						String w2 = sbs2[i];
						if(w2.length()>0){
							System.out.println(w2);
						}
					}
				}
			}*/
	}
}
