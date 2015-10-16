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
 * �������ߣ��ṩ����������ѯ��������ʾ��һЩ��������<br>
 */
public class SearchManager {
	
	/**
	 * ����me
	 */
	private static SearchManager me = null ;
	
	/**
	 * SearchResult����session��key
	 */
	public final static String search_result_session_key = "search_result_session_key_378Q";
	
	/**
	 * ��10000�������ʽ��л���
	 */
	private static Map<String,SearchResult> CACHE_MAP = Collections.synchronizedMap(new LRUCache<String,SearchResult>(10000));

	/**
	 * �洢�Ա������ʵ�hashmap
	 */
	private static Map<String,String> TAOBAO_KEY_WORDS_HASHMAP = Collections.synchronizedMap(new HashMap<String,String>());
	
	/**
	 * �Ա������ʵ��ļ���
	 */
	private static final String TAOBAO_KEY_WORDS_FILENAME = Const.PROJECT_PATH+"conf/taobao_ok.txt";
	
	/**
	 * ������Ŀ¼
	 */
	private final static String INDEX_PATH =  Const.PROJECT_PATH+"lucene/products/"; 
	
	/**
	 * �޸Ĺ�����Ʒid��ÿ���Ӹ���һ������
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
		 * ����ִʴʿ�
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
	 * ����Ʒid����map��
	 * @param productId
	 */
	public void addUpdateProductId(String productId){
		if(!Tools.isNull(productId))UPDATE_PRODUCT_ID_MAP.put(productId, "");
	}
	
	/**
	 * ����������Ʒ����
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
	 * ���ӷ���
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
	 * �����ⲿ����new����
	 */
	private SearchManager(){}
	
	/**
	 * ����product�����������˵������ֶ�
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
			boolean isFirstIndex = true ;//�Ƿ��һ�ν�������
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
		//�¼ӵ��ֶ�
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
		name = name.toLowerCase();//ת��Сд
		name = name.replaceAll("\\p{Punct}", " ");//ȥ��������
		name = name.replaceAll(" +", " ");
		
		//��Ҫȫ�ļ������ֶ�
		doc.add(new Field("name",name,Field.Store.YES,Field.Index.ANALYZED));//��Ʒ����+�ؼ��֣�������
		
		//boost�������ӣ������doc���򣬾ͻ�ѡ����������ֶ�
		//if(product.getGdsmst_createdate()!=null)doc.setBoost(product.getGdsmst_createdate().getTime()); //�ϼ�ʱ��
		//else doc.setBoost(System.currentTimeMillis());
		
		//��Ҫ�����������ֶΣ�������Ҫȫ�ļ���		
		doc.add(new Field("productId",product.getId()+"",Field.Store.YES,Field.Index.NOT_ANALYZED));//��Ʒid
		doc.add(new Field("validflag",product.getGdsmst_validflag()+"",Field.Store.YES,Field.Index.NOT_ANALYZED));//��Ʒ�ϼܱ�־��1��ʾ�ϼ���Ʒ
		
   		writer.addDocument(doc);
	}
	
	/**
	 * ����product��������ɾ�����ؽ�
	 */
	public void updateProductIndex(Product product){
		if(product==null)return;
		removeProductIndex(product);
		createProductIndex(product);
	}
	
	/**
	 * ������Ʒidɾ����Ʒ����
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
	 * ɾ��product������
	 * @param product
	 */
	public void removeProductIndex(Product product){
		if(product==null)return;
		removeProductIndex(product.getId());
	}
	
	/**
	 * �ؽ�������Ʒ����,�÷�����ɾ��ԭ������Ŀ¼�µ������ļ�����Ҫ����ʹ�ã���
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
	 * �Ż�����Ŀ¼����ԭ��ɾ����ǵ�����ȫ��������������Ķ���ļ��ϲ��������ļ�...
	 * 
	 */
	public synchronized void optimize(){
		IndexWriter writer = null ;
		Directory dir = null;
		try {
			Analyzer writerAnalyzer = new StandardAnalyzer(Version.LUCENE_30);
			dir = FSDirectory.open(new File(INDEX_PATH));
			writer = new IndexWriter(dir,writerAnalyzer, false,IndexWriter.MaxFieldLength.UNLIMITED);
			//�ϲ���һ��
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
	 * �������������������id�б����򷽷���SearchResult���棬��ҳ��jsp����PageBean�֡�<br/>
	 * @param request Jsp���request
	 * @param response Jsp���response
	 * @param rackcode ���� null��ʾ����ȫ��������������ʱ��null
	 * @param name ���������֣��û�������������֡��硰Ůʽ  ţ�п㡱���ִ��ÿո�ֿ�
	 * @param cacheTime ����ʱ�����,0��ʾ�������档���Խ׶β�Ҫ�û��棬��ʽ�׶λ���1���Ӽ��ɣ�cacheTime=60000��
	 * @return
	 */
	public SearchResult searchProduct(HttpServletRequest request,HttpServletResponse response,
			String rackcode,String name,long cacheTime){
		
		SearchResult result = new SearchResult();//�������ؽ��
		result.setKeyWords(name);
		
		if(name==null)name="";
		
		name = name.toLowerCase();//ת��Сд
		name = name.replaceAll("\\p{Punct}", " ");//ȥ��������
		name = name.replaceAll(" +", " ");

		//��session�в��ҷ��ؽ��
		
		javax.servlet.http.HttpSession session = request.getSession();
		
		String base64Name = Base64.encode(name);
		
		SearchResult sr33 = (SearchResult)session.getAttribute(search_result_session_key+base64Name);
		if(sr33!=null&&sr33.getTotalcount(null)>0){
			return sr33;
		}
		
		//�ӻ����в����������
		if(cacheTime>0&&CACHE_MAP.containsKey(name)){
			SearchResult sr123 = CACHE_MAP.get(name);
			if(sr123!=null){
				if(sr123.getExpireTime()>=System.currentTimeMillis()){//û�й���
					session.setAttribute(search_result_session_key+base64Name, sr123);//����session
					return sr123 ;
				}else{
					CACHE_MAP.remove(name);
				}
			}
		}
		
		//System.out.println("�����ļ���name="+name+" path="+INDEX_PATH);
		
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
			
			//ֻ���ϼ���Ʒ
			//bquery.add(new TermQuery(new Term("validflag","1")),BooleanClause.Occur.MUST);
			
			//ȥ�������ţ������ĺ�Ӣ���ôʷֿ���
			if(name!=null && name.length()>0 ){
				String sb = name ;
				sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
				sb = sb.replaceAll(" +", " ");
				String[] sbs = sb.split(" ");
				if(sbs!=null){
					for(int i=0;i<sbs.length;i++){
						String w1 = sbs[i];
						if(w1.length()>0){
							//�������Զ���һ�δʣ���С�������ִʡ��硰��ޢ��ˮ���ֳɡ���ޢ���͡���ˮ�������ʣ�������ˮ�������ٷ�
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
						if(w2.length()>0){//������Ӣ��
							PhraseQuery pq = new PhraseQuery();  
							pq.add(new Term("name",w2));  
							bquery.add(pq,BooleanClause.Occur.MUST);
						}
					}
				}
			}
			
			//���������1000����Ʒ
			TopDocs topDocs = searcher.search(bquery,null,1000,sort);
			
			ScoreDoc[] hits = topDocs.scoreDocs ;
			
			Map<String,Integer> rackMap = new ConcurrentHashMap<String,Integer>();
			CopyOnWriteArrayList<Product> resultlist = new CopyOnWriteArrayList<Product>();
			
			int totalcount = 0 ;//����Ʒ��
			if(hits!=null&&hits.length>0){
				for(int i=0;i<hits.length;i++){
					Document doc = searcher.doc(hits[i].doc);
			    	Product sp = (Product)Tools.getManager(Product.class).get(doc.get("productId"));
			    	if(sp!=null){
			    		//����ͷ������������
			    		String gdsrackcode = sp.getGdsmst_rackcode();
			    		if(gdsrackcode!=null&&sp.getGdsmst_validflag()!=null&&sp.getGdsmst_validflag().longValue()==1&&sp.getGdsmst_ifhavegds()!=null&&sp.getGdsmst_ifhavegds().longValue()==0){//���೤�ȱ�����3��������������
			    			totalcount++;//����+1
				    		for(int x=0;x<(int)(gdsrackcode.length()/3);x++){//���շ��༶��չ��
				    			String vgdsrackcode = gdsrackcode.substring(0,3*x+3);
				    			
				    			if(rackMap.containsKey(vgdsrackcode)){
					    			Integer ri = rackMap.get(vgdsrackcode);
					    			rackMap.put(vgdsrackcode, new Integer(ri.intValue()+1));
					    		}else{
					    			rackMap.put(vgdsrackcode, new Integer(1));
					    		}
				    		}
				    		resultlist.add(sp);//���뵽�������
			    		}//else{
			    			//System.err.println("������Ʒ�е����⣬��Ʒid="+sp.getId());
			    		//}
			    	}
			    }
			}
			
			result.setTotalcount(totalcount);
			result.setRackMap(rackMap);
			result.setResultlist(resultlist);
			result.setExpireTime(System.currentTimeMillis()+cacheTime);//���û������ʱ��
			
			if(cacheTime>0)CACHE_MAP.put(name, result);//���뻺��
			
			session.setAttribute(search_result_session_key+base64Name, result);//����session
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
		
		SearchResult result = new SearchResult();//�������ؽ��
		result.setKeyWords(name);
		
		if(name==null)name="";
		
		name = name.toLowerCase();//ת��Сд
		name = name.replaceAll("\\p{Punct}", " ");//ȥ��������
		name = name.replaceAll(" +", " ");

		//��session�в��ҷ��ؽ��
		
		
		//System.out.println("�����ļ���name="+name+" path="+INDEX_PATH);
		
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
			
			//ȥ�������ţ������ĺ�Ӣ���ôʷֿ���
			if(name!=null && name.length()>0 ){
				String sb = name ;
				sb = sb.replaceAll("[^\\u4e00-\\u9fa5 ]", "");
				sb = sb.replaceAll(" +", " ");
				String[] sbs = sb.split(" ");
				if(sbs!=null){
					for(int i=0;i<sbs.length;i++){
						String w1 = sbs[i];
						if(w1.length()>0){
							//�������Զ���һ�δʣ���С�������ִʡ��硰��ޢ��ˮ���ֳɡ���ޢ���͡���ˮ�������ʣ�������ˮ�������ٷ�
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
						if(w2.length()>0){//������Ӣ��
							PhraseQuery pq = new PhraseQuery();  
							pq.add(new Term("name",w2));  
							bquery.add(pq,BooleanClause.Occur.MUST);
						}
					}
				}
			}
			
			//���������1000����Ʒ
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
	 * ��������Ϻ�ɫ�ʹ��壬������ʾ���и�С���⣬���ֲ��ܸ�����<br/>
	 * lucene�Դ��ĸ�����ʾ��ȻҲ���ԣ����ǿ��ܻ����̫���<font>��ǩ����Ϊ�ִ����⣩�����Բ���<br/>
	 * @param productName
	 * @param searchKeyWords
	 * @return
	 */
	public String highlighterProductName(String productName,String searchKeyWords){
		if(productName==null)return null;
		if(searchKeyWords==null)return productName;
		
		productName = productName.toLowerCase();
		searchKeyWords = searchKeyWords.toLowerCase();
		
		searchKeyWords = searchKeyWords.replaceAll("\\p{Punct}", " ");//ȥ��������
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
		File f = new File("D://���ķִʴʿ�����");
		String[] fs = f.list();
		HashMap<String,String> map = new HashMap<String,String>();
		int count = 0 ;
		for(int i=0;i<fs.length;i++){
			if(fs[i].endsWith(".txt")){
				System.out.println("����"+fs[i]+"...");
				BufferedReader br = new BufferedReader(new FileReader(new File("D://���ķִʴʿ�����//"+fs[i])));
				String line = null ;
				while((line=br.readLine())!=null){
					line = line.replaceAll("[^\\u4e00-\\u9fa5]", "");//��������ȫȥ��
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
	 * IK�ִʷֳ����ɸ��ʣ�����û�ã�ֱ����kkSplit������
	 * @param name
	 * @return
	 */
	public static ArrayList<String> ikSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();//mapΪ��ȥ��
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
		
		if(list.size()<=1)return list;//���ֻ��һ���ʣ��ֵ�û���⣬�����Ż�
		
		//Ȼ���Ż�һ�·ִʽ����������ƥ�䣬ȥ��һЩ�����Ի��Ľ����
		//�硰������ţ�п㡱�ִʽ���ǡ�������ţ�п�   ������   ����   ��  ţ��   �п㡱��
		//����ʵ��ֻ��Ҫ��������   ţ�п㡱����Ϊ��ţ�С��Ǹ��ʣ���ţ�п㡱�������ʣ�
		ArrayList<String> rlist = new ArrayList<String>();
		
		for(int i=0;i<list.size();i++){
			String s1 = list.get(i);
			map.put(s1, "");
		}
		
		//for(String s:list)System.out.println("map===="+s);
		
		HashMap<String,String> rmap = new HashMap<String,String>();//���map
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
	 * KK�ִʷ������������������ƥ�䡣<br/>
	 * �硰������ţ�п㡱����������������������ţ�С���ţ�п㡱���Ǵʣ����������ƥ��ֳɡ����������͡�ţ�п㡱<br/>
	 * ����ֻ�������������ģ���Ӣ�Ļ�ϵ���������洦��<br/>
	 * @param name
	 * @return
	 */
	private static ArrayList<String> kkSplit(String name){
		if(Tools.isNull(name))return null;
		
		ArrayList<String> list = new ArrayList<String>();
		
		HashMap<String,String> rmap = new HashMap<String,String>();//���map
 		
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
	 * ���Էִ�Ч��
	 */
	public static void testSplit(){
		String[] names ={"��������ʿ����ţ�п�",
				"���ζ��ɿ�Ůʿ��ˮ",
				"ŷ�������˪",
				"�����ָɵ�ʽ���뵶",
				"�����������",
				"Ůʿ��ˮ",
				"�����ɰ�ţ�̱�",
				"�¹���ձ��ʺ�",
				"����ʹ���岥����",
				"����ֿ��Ⱥ����º�",
				"��ޢŮʿ��ˮ",
				"��Ȼ���ƻ���˪",
				"�¿��ﶬװ���� ",
				"Ůװ����ë�춷��",
				"��������˪",
				"ŷ����ˬ��ˮŮ",
				"�۲ݼ�ר����Ʒƽ�������",
				"��ױϴ������������ԭװ��ױϴ����",
				"��ƤŮʿ�ֱ�",
				"�������̷�",
				"�����ﶬװ�¿��˫�ſ���������װ��ë�ش�������Ů",
				"�ΰ�ɯŮʿ���µ����;�£һƬʽ�޺��Ըб�������",
				"�����ݻ�������ͥë�� ����Ӻ�����Ƥ�����޷�",
				"��˹����Ʒѩ��ѥ��Ͳѥ���Ůѥ��ţƤ��ѥѩ��ЬŮЬţ��װ���",
				"��������Լ���ŷ���Ƥ����Ǯ��ĥɰ�ָ�ŮʿǮ��Ů����",
				"������Ʒ�����ʯ������������觱���������",
				"�������������������ɱ����ֹ����ɵ�����˾ζ�ر��Ƽ�",
				"Ѳ���� ��Ƥ�а�����ţƤ��ʿ��������԰� ʱ�й��İ�",
				"�������װ��Ʒ"};
			
		
		for(String name:names){
			ArrayList<String> list = kkSplit(name.replaceAll(" ", ""));
			System.out.print(name+"��");
			for(String s:list){
				System.out.print(s+"|");
			}
			System.out.print("��");
			System.out.println();
		}
	}
	
	public static void main(String[] args) throws Exception{
		
		//SearchManager.getInstance().testIndexAll();
		//test();
		//SearchManager.getInstance().searchProductCount("ţ�п�");
		
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
		
		//System.out.println(SearchManager.getInstance().highlighterProductName("1908�Ҿ���Ҫ��1908Ůʿ��ţ�п㣬���ر�ϲ��Ůʿ����ţ�п�",name));
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
	        name = name.toLowerCase();//ת��Сд
			name = name.replaceAll("\\p{Punct}", " ");//ȥ��������
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
