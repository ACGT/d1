package com.d1.test;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.d1.bean.Cart;
import com.d1.helper.CartHelper;
import com.d1.util.Tools;

public class T5 {
	public static float getTotalPayMoney(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()==1)total+=cart.getMoney();
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	public static String stringToAscii(String value)  
	{  
		if(value==null)return "";
	    StringBuffer sbu = new StringBuffer();  
	    char[] chars = value.toCharArray();   
	    for (int i = 1; i <=chars.length; i++) {  
	    	int c = (int)chars[i-1];
	    	//加密
	    	c+=3*i*i+17*i+9;
	    	
	    	if(i>=2){
	    		c+=(int)chars[i-2];
	    		c+=19*i;
	    	}
	    	
	        if(i != chars.length)  
	        {  
	            sbu.append(c).append(",");  
	        }  
	        else {  
	            sbu.append(c);  
	        }  
	    }  
	    return sbu.toString();  
	}  
	
	
	 public static String jiaMi(String s,String key){
		    String str = "";
		    int ch;
		    if(key.length() == 0){
		        return s;
		    }
		    else if(!s.equals(null)){
		        for(int i = 0,j = 0;i < s.length();i++,j++){
		          if(j > key.length() - 1){
		            j = j % key.length();
		          }
		          ch = s.codePointAt(i) + key.codePointAt(j);
		          if(ch > 65535){
		            ch = ch % 65535;//ch - 33 = (ch - 33) % 95 ;
		          }
		          str += (char)ch;
		        }
		    }
		    return str;

		  } 
		  //解密
		  public static String jieMi(String s,String key){
		    String str = "";
		    int ch;
		    if(key.length() == 0){
		        return s;
		    }
		    else if(!s.equals(key)){
		        for(int i = 0,j = 0;i < s.length();i++,j++){
		          if(j > key.length() - 1){
		            j = j % key.length();
		          }
		          ch = (s.codePointAt(i) + 65535 - key.codePointAt(j));
		          if(ch > 65535){
		            ch = ch % 65535;//ch - 33 = (ch - 33) % 95 ;
		          }
		          str += (char)ch;
		        }
		    }
		    return str;
		  }
		  
		  public static void main(String args[]) throws Exception{
			 // System.out.println(Base64.encodeBytes("一个简单的字符串加密算法_字符串_电脑频道- 唯才教育网   13581907901 13693567584".getBytes("GBK")));
			 // System.out.println(jieMi(jiaMi("5LiA5Liq566A5Y2V55qE5a2X56ym5Liy5Yqg5a+G566X5rOVX+Wtl+espuS4sl/nlLXohJHpopHpgZMtIOWUr+aJjeaVmeiCsue9kSAgIDEzNTgxOTA3OTAxIDEzNjkzNTY3NTg0","32486583453583045s284sdfsdkfhsdfhks"),"32486583453583045s284sdfsdkfhsdfhks"));
			 // System.out.println(jiaMi("5LiA5Liq566A5Y2V55qE5a2X56ym5Liy5Yqg5a+G566X5rOVX+Wtl+espuS4sl/nlLXohJHpopHpgZMtIOWUr+aJjeaVmeiCsue9kSAgIDEzNTgxOTA3OTAxIDEzNjkzNTY3NTg0","32486583453583045s284sdfsdkfhsdfhks"));
			 // System.out.println(jieMi("h~?yk??¤ikivm?b?j¨?}i???¨???????????g?c}jni?j????[???]?§???§××???°?×??{??¨~?????|????_?????????§?????????ww????°??vf??t¨}y??????????????","32486583453583045s284sdfsdkfhsdfhks"));
			  
			  String photo = "http://images.d1.com.cn/sdlifjskldfjl/sdfujkf/sdfdff.jpg sldfj93485sdfjljdf aljt http://images.d1.com.cn/sdlifjskldfjl/sdfujkf/sff777dfd_ff.jpg http://images.d1.com.cn/zt2011/aleeishe.com/images/title01.jpg 345435";
				Pattern pa = Pattern.compile("http://images\\.d1\\.com\\.cn/[\\._/a-zA-Z0-9]+\\.jpg");
				Matcher m = pa.matcher(photo);
				while(m.find()){
					System.out.println(m.group());
				}
		  }
}
