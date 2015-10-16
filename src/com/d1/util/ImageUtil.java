package com.d1.util;

import java.awt.Image;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * 图片切割程序，需要安装ImageMagick
 */
public class ImageUtil
{
	/**
	 * 取得图片的地址
	 * @param photo 图片的全路径
	 * @param prefix 后缀
	 * @return /upload/home/12345.jpg  变成 /upload/home/12345_s.jpg
	 */
	public static String getPrefixImage(String photo,String prefix)
	{
		if(photo==null)return null;
		if(photo.indexOf(".")<0)
		{
			return photo+prefix;
		}
		
		String targetFileName = photo.substring(0,photo.lastIndexOf("."))
		+prefix+"."
		+photo.substring(photo.lastIndexOf(".")+1);
		
		return targetFileName ;
	}
	

	/**
	 * 切图片的工具，从最上面开始裁切，找最合适的比率<br>
	 * @param sourceFileName 用来切的源文件-绝对路径
	 * @param prefix 目标文件的前缀，目标文件和原文件在同一个目录下
	 * @param width 裁切的宽度
	 * @param height 裁切的高度
	 */
	public static boolean cropImage(String sourceFileName,String prefix,int width,int height)
	{
		String targetFileName = getPrefixImage(sourceFileName,prefix);
		
		if(sourceFileName==null||targetFileName==null)return false;
		
		
		int colors = 128 ;
		
			File fromFile2 = new File(sourceFileName);
			if(!fromFile2.exists())return false ;
			
			if(!sourceFileName.toLowerCase().endsWith(".jpg")&&!sourceFileName.toLowerCase().endsWith(".jpeg")&&!sourceFileName.toLowerCase().endsWith(".gif")&&!sourceFileName.toLowerCase().endsWith(".png"))return false;
			
			String imgType = targetFileName.substring(targetFileName.lastIndexOf(".")+1);
			if(imgType!=null)imgType=imgType.toLowerCase();
			
			int imgWidth = 0 ,imgHeight = 0 ;
			try
			{
				Image oldImage = javax.imageio.ImageIO.read(new File(sourceFileName));  
				imgWidth=oldImage.getWidth(null); 
				imgHeight=oldImage.getHeight(null);    
			}
			catch(Exception ex)
			{
					ex.printStackTrace();
					return false ;
			}
			
			//以下代码是从原图片中找出最好位置切成想要得尺寸，采用横向从最上面开始切，纵向从中间开始切
			String command = "";
			if(((float)imgHeight/imgWidth)>=((float)height/width))//从最上面开始切,如果是gif或png则先切jpg然后再转格式后删除jpg
			{
				int cropHeight =(int)(height*imgWidth/width);
				int cropWidth = imgWidth ;
				command = "/usr/local/ImageMagick/bin/convert "
							+sourceFileName
							+" -crop "+cropWidth+"x"+cropHeight+"+0+0 -resize "
							+width+"x"+height+"! +repage " ;
							
				if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 95 ";
				else if ("gif".equals(imgType)) command+=" -colors "+colors+" ";
				else if ("png".equals(imgType)) command+=" -colors "+colors+" -quality 95 ";
				
				command+=" +profile * "+targetFileName;
				
				String pppath = "" ;
				if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
				try
				{
						File fff9 = new File(pppath);
						fff9.mkdirs();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
			}
			else //从中间开始切
			{
				int cropHeight = imgHeight ;
				int cropWidth = (int)(width*imgHeight/height);				
				command = "/usr/local/ImageMagick/bin/convert "
							+sourceFileName
							+" -crop "+cropWidth+"x"+cropHeight+"+"+(int)((imgWidth-cropWidth)/2)+"+0 -resize "
							+width+"x"+height+"! +repage " ;
							
				if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 95 ";
				else if ("gif".equals(imgType)) command+=" -colors "+colors+" ";
				else if ("png".equals(imgType)) command+=" -colors "+colors+" -quality 95 ";
				
				command+=" +profile * "+targetFileName;
								
				String pppath = "" ;
				if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
				try
				{
						File fff9 = new File(pppath);
						fff9.mkdirs();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			
			System.out.println(command);
			
			exec(command); //切图片
			return true;
	}
	
	/**
	 * 把图片resize到maxWidth和maxHeight,保持原来比列，保持原来格式.<br>
	 * @param sourceFileName sourceFileName必须是以.jpg或.png或.gif结尾的图片名
	 * @param prefix 前缀，如切成小图就用 xxxl_1111.jpg  xxl_1111.jpg
	 * @param maxWidth 最大高度
	 * @param maxHeigth 最大宽度
	 * @return
	 */
	public static boolean resizeImage(String sourceFileName,String prefix,int maxWidth,int maxHeight)
	{
		if(sourceFileName==null||sourceFileName.indexOf("/")<0)
		{
			return false;
		}
		
		String targetFileName = getPrefixImage(sourceFileName,prefix);
		
		int colors = 128 ;
		
			File fromFile2 = new File(sourceFileName);
			if(!fromFile2.exists())
			{
				return false;
			}
			
			if(!sourceFileName.toLowerCase().endsWith(".jpg")&&!sourceFileName.toLowerCase().endsWith(".jpeg")&&!sourceFileName.toLowerCase().endsWith(".gif")&&!sourceFileName.toLowerCase().endsWith(".png"))
			{
				return false;
			}
			
			String imgType = targetFileName.substring(targetFileName.lastIndexOf(".")+1);
			if(imgType!=null)imgType=imgType.toLowerCase();
			
			String command = "";
			
			command = "/usr/local/ImageMagick/bin/convert "
						+sourceFileName
						+" -scale "+maxWidth+"x"+maxHeight+" ";
			
			if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 95 ";
			else if ("gif".equals(imgType)) command+=" -colors "+colors+" ";
			else if ("png".equals(imgType)) command+=" -colors "+colors+" -quality 95 ";
			
			command+=" +profile * "+targetFileName;
						
			String pppath = "" ;
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
			try
			{
					File fff9 = new File(pppath);
					fff9.mkdirs();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
				
			System.out.println(command);
			
			return exec(command); 
	}
	
	//晒单要求保存质量为80%的图片
	public static boolean resizeImage_sd(String sourceFileName,String prefix,int maxWidth,int maxHeight)
	{
		if(sourceFileName==null||sourceFileName.indexOf("/")<0)
		{
			return false;
		}
		
		String targetFileName = getPrefixImage(sourceFileName,prefix);
		
		int colors = 128 ;
		
			File fromFile2 = new File(sourceFileName);
			if(!fromFile2.exists())
			{
				return false;
			}
			
			if(!sourceFileName.toLowerCase().endsWith(".jpg")&&!sourceFileName.toLowerCase().endsWith(".jpeg")&&!sourceFileName.toLowerCase().endsWith(".gif")&&!sourceFileName.toLowerCase().endsWith(".png"))
			{
				return false;
			}
			
			String imgType = targetFileName.substring(targetFileName.lastIndexOf(".")+1);
			if(imgType!=null)imgType=imgType.toLowerCase();
			
			String command = "";
			
			command = "/usr/local/ImageMagick/bin/convert "
						+sourceFileName
						+" -scale "+maxWidth+"x"+maxHeight+" ";
			
			if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 80 ";
			else if ("gif".equals(imgType)) command+=" -colors "+colors+" ";
			else if ("png".equals(imgType)) command+=" -colors "+colors+" -quality 80 ";
			
			command+=" +profile * "+targetFileName;
						
			String pppath = "" ;
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
			try
			{
					File fff9 = new File(pppath);
					fff9.mkdirs();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
				
			System.out.println(command);
			
			return exec(command); 
	}
	
	
	
	/**
	 * 把图片resize到maxWidth和maxHeight,保持原来比列，保持原来格式.<br>
	 * @param sourceFileName sourceFileName必须是以.jpg或.png或.gif结尾的图片名
	 * @param prefix 前缀，如切成小图就用 xxxl_1111.jpg  xxl_1111.jpg
	 * @param maxWidth 最大高度
	 * @param maxHeigth 最大宽度
	 * @return
	 */
	public static boolean resizeImage1(String sourceFileName,String prefix,int maxWidth,int maxHeight)
	{
		if(sourceFileName==null||sourceFileName.indexOf("/")<0)
		{
			return false;
		}
		
		String targetFileName = getPrefixImage(sourceFileName,prefix);
		
		int colors = 128 ;
		
			File fromFile2 = new File(sourceFileName);
			if(!fromFile2.exists())
			{
				return false;
			}
			
			if(!sourceFileName.toLowerCase().endsWith(".jpg")&&!sourceFileName.toLowerCase().endsWith(".jpeg")&&!sourceFileName.toLowerCase().endsWith(".gif")&&!sourceFileName.toLowerCase().endsWith(".png"))
			{
				return false;
			}
			
			String imgType = targetFileName.substring(targetFileName.lastIndexOf(".")+1);
			if(imgType!=null)imgType=imgType.toLowerCase();
			
			String command = "";
			
			command = "/usr/local/ImageMagick/bin/convert "
						+sourceFileName+" -crop 0x0+0+0 "
						+" -resize "+maxWidth+"x"+maxHeight+"! ";
			
			command+=" +repage";
			if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 95 ";
			else if ("gif".equals(imgType)) {}
			else if ("png".equals(imgType)) command+=" -quality 95 ";
			
			command+=" +profile * "+targetFileName;
				//System.out.print(command);		
			String pppath = "" ;
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
			try
			{
					File fff9 = new File(pppath);
					fff9.mkdirs();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
				
			//System.out.println(command);
			
			return exec(command); 
	}
	/***
	 * 图片左右剪切初始切图320x400此方法只用于4：5比例
	 * /usr/local/ImageMagick/bin/convert 01720599_400.jpg -crop 320x400+40+0 -resize 240x300! +repage -quality 95 +profile "*" 240.jpg 
	 * @param sourceFileName
	 * @param prefix
	 * @param maxWidth
	 * @param maxHeight
	 * @param cutnum
	 * @return
	 */

	public static boolean resizeImagecut(String sourceFileName,String prefix,int maxWidth,int maxHeight)
	{
		if(sourceFileName==null||sourceFileName.indexOf("/")<0)
		{
			return false;
		}
		
		String targetFileName = getPrefixImage(sourceFileName ,prefix);
		
		int colors = 128 ;
		
			File fromFile2 = new File(sourceFileName);
			if(!fromFile2.exists())
			{
				return false;
			}
			
			if(!sourceFileName.toLowerCase().endsWith(".jpg")&&!sourceFileName.toLowerCase().endsWith(".jpeg")&&!sourceFileName.toLowerCase().endsWith(".gif")&&!sourceFileName.toLowerCase().endsWith(".png"))
			{
				return false;
			}
			
			String imgType = targetFileName.substring(targetFileName.lastIndexOf(".")+1);
			if(imgType!=null)imgType=imgType.toLowerCase();
			
			String command = "";
			
			command = "/usr/local/ImageMagick/bin/convert "
						+sourceFileName+" -crop 320x400+40+0 "
						+" -resize "+maxWidth+"x"+maxHeight+"! ";
			/*/usr/local/ImageMagick/bin/convert 01720599_400.jpg -crop 320x400+40+0 
			-resize 240x300! +repage -quality 95 +profile "*" 240.jpg */
			command+=" +repage";
			if("jpg".equals(imgType)||"jpeg".equals(imgType))command+=" -quality 95 ";
			else if ("gif".equals(imgType)) {}
			else if ("png".equals(imgType)) command+=" -quality 95 ";
			
			command+=" +profile * "+targetFileName;
				//System.out.print(command);		
			String pppath = "" ;
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//文字如果是路径
			try
			{
					File fff9 = new File(pppath);
					fff9.mkdirs();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
				
			//System.out.println(command);
			
			return exec(command); 
	}
	
	
	/**
	 * 执行一个切图命令，使用ImageMagick，这个软件安装比较困难
	 * @param command 要执行的命令
	 */
	public static boolean exec(String command)
	{
		try 
	    {             
	            Runtime rt = Runtime.getRuntime(); 
	            Process proc = rt.exec(command); 
	            InputStream ins = proc.getInputStream(); 
	            InputStreamReader isr = new InputStreamReader(ins); 
	            BufferedReader br = new BufferedReader(isr); 
	            String line = null,result = null;
	            while ( (line = br.readLine()) != null) 
	            {
					result+=line+";";	
				}
	            if(isr!=null)isr.close();
	            if(br!=null)br.close();
	            System.out.println(result);
	            //int exitVal = proc.waitFor(); 
	            //System.out.println("Process exitValue: " + exitVal); 
	    }
		catch (Throwable t)
		{ 
			t.printStackTrace(); 
			return false ;
	    } 
	    
	    return true;
	}
	
	public static void main(String[] args)
	{
		System.out.println(getPrefixImage("/opt/shopimg/01720599_400.jpg","_s"));
	}
}
