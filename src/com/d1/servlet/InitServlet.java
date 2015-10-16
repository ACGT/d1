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
	 * ��Ŀ·��
	 */
	private static String PROJECT_PATH = "./" ;
	
	/**
	 * �õ���Ŀ����·��
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
		
		System.out.println("MyFactory��ʼ����ʼ......"+Const.PROJECT_PATH);
		
		int len = Tools.getManager(Floor.class).getLength(null);
		System.out.println("len="+len);

		File sf = new File("d://JavaServer.txt");
		File sf2 = new File("/etc/JavaServer.txt");
		if(sf.exists()||sf2.exists()){
			loadProductData();
			loadData();
		}
		
		System.out.println("MyFactory��ʼ�����!!!!!!");
    }
	
	/**
	 * ������Ʒ���ݣ�����֮ǰ�͵ü���
	 */
	public void loadProductData(){
		System.out.println("��Ʒ����������load��ʼ......");
		long start = System.currentTimeMillis();
		Tools.getManager(ProductSaleCount.class).loadAllData();
		Tools.getManager(Product.class).loadAllData();
		Tools.getManager(Sku.class).loadAllData();
		ProductManager pm = (ProductManager)Tools.getManager(Product.class);
		pm.loadProductSales();//��������
		long end = System.currentTimeMillis();
		System.out.println("��Ʒ����������load��ϣ���ʱ="+(end-start)+"���룡����");
	}
	
	/**
	 * ��������Ʒ�����ڴ���ȥ����Ϊ������ʱ����ܻ��õ��ܶ���Ʒ��Ϊ�����������ٶȣ���Ʒȫ�����뵽�ڴ�
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
        out.println("��ӭ����d1��������");
        out.flush();
        out.close();
	}
	
	public static void main(String[] args){
		String s = "c:\\sdf\\sdfjf";
		System.out.println(s.replaceAll("\\\\", "/"));
		System.out.println(Math.random());
	}
}