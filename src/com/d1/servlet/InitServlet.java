package com.d1.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.d1.Const;
import com.d1.bean.Floor;
import com.d1.bean.Product;
import com.d1.bean.ProductSaleCount;
import com.d1.bean.Sku;
import com.d1.manager.ProductManager;
import com.d1.util.Tools;

public class InitServlet extends HttpServlet {
	
	/**
	 * 项目路径
	 */
	private static String PROJECT_PATH = "./" ;
	
	/**
	 * 得到项目绝对路径
	 * @return
	 */
	public static String getProjectAbsolutePath() {
		return PROJECT_PATH;
	}

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	public void init() throws ServletException{
		
		PROJECT_PATH = this.getServletContext().getRealPath("/");
		
		PROJECT_PATH = PROJECT_PATH.replaceAll("\\\\", "/");
		if(!PROJECT_PATH.endsWith("/")){
			PROJECT_PATH+="/";
		}
		
		System.out.println("MyFactory初始化开始......"+Const.PROJECT_PATH);
		
		int len = Tools.getManager(Floor.class).getLength(null);
		System.out.println("len="+len);

		File sf = new File("d://JavaServer.txt");
		File sf2 = new File("/etc/JavaServer.txt");
		if(sf.exists()||sf2.exists()){
			loadProductData();
			loadData();
		}
		
		System.out.println("MyFactory初始化完毕!!!!!!");
    }
	
	/**
	 * 加载商品数据，启动之前就得加载
	 */
	public void loadProductData(){
		System.out.println("商品及销量数据load开始......");
		long start = System.currentTimeMillis();
		Tools.getManager(ProductSaleCount.class).loadAllData();
		Tools.getManager(Product.class).loadAllData();
		Tools.getManager(Sku.class).loadAllData();
		ProductManager pm = (ProductManager)Tools.getManager(Product.class);
		pm.loadProductSales();//加载销量
		long end = System.currentTimeMillis();
		System.out.println("商品及销量数据load完毕！耗时="+(end-start)+"毫秒！！！");
	}
	
	/**
	 * 把所有商品读到内存中去，因为搜索的时候可能会用到很多商品，为了提升检索速度，商品全部读入到内存
	 */
	public void loadData(){
		LoadDataThread  ldt = new LoadDataThread();
		ldt.start();
	}
	
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
    	throws ServletException, IOException {
    	doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("欢迎来到d1优尚网！");
        out.flush();
        out.close();
	}
	
	public static void main(String[] args){
		String s = "c:\\sdf\\sdfjf";
		System.out.println(s.replaceAll("\\\\", "/"));
		System.out.println(Math.random());
	}
}