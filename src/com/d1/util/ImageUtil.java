package com.d1.util;

import java.awt.Image;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * ͼƬ�и������Ҫ��װImageMagick
 */
public class ImageUtil
{
	/**
	 * ȡ��ͼƬ�ĵ�ַ
	 * @param photo ͼƬ��ȫ·��
	 * @param prefix ��׺
	 * @return /upload/home/12345.jpg  ��� /upload/home/12345_s.jpg
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
	 * ��ͼƬ�Ĺ��ߣ��������濪ʼ���У�������ʵı���<br>
	 * @param sourceFileName �����е�Դ�ļ�-����·��
	 * @param prefix Ŀ���ļ���ǰ׺��Ŀ���ļ���ԭ�ļ���ͬһ��Ŀ¼��
	 * @param width ���еĿ��
	 * @param height ���еĸ߶�
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
			
			//���´����Ǵ�ԭͼƬ���ҳ����λ���г���Ҫ�óߴ磬���ú���������濪ʼ�У�������м俪ʼ��
			String command = "";
			if(((float)imgHeight/imgWidth)>=((float)height/width))//�������濪ʼ��,�����gif��png������jpgȻ����ת��ʽ��ɾ��jpg
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
				if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
			else //���м俪ʼ��
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
				if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
			
			exec(command); //��ͼƬ
			return true;
	}
	
	/**
	 * ��ͼƬresize��maxWidth��maxHeight,����ԭ�����У�����ԭ����ʽ.<br>
	 * @param sourceFileName sourceFileName��������.jpg��.png��.gif��β��ͼƬ��
	 * @param prefix ǰ׺�����г�Сͼ���� xxxl_1111.jpg  xxl_1111.jpg
	 * @param maxWidth ���߶�
	 * @param maxHeigth �����
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
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
	
	//ɹ��Ҫ�󱣴�����Ϊ80%��ͼƬ
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
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
	 * ��ͼƬresize��maxWidth��maxHeight,����ԭ�����У�����ԭ����ʽ.<br>
	 * @param sourceFileName sourceFileName��������.jpg��.png��.gif��β��ͼƬ��
	 * @param prefix ǰ׺�����г�Сͼ���� xxxl_1111.jpg  xxl_1111.jpg
	 * @param maxWidth ���߶�
	 * @param maxHeigth �����
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
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
	 * ͼƬ���Ҽ��г�ʼ��ͼ320x400�˷���ֻ����4��5����
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
			if(targetFileName.indexOf("/")>-1)pppath+=targetFileName.substring(0,targetFileName.lastIndexOf("/"))+"/";//���������·��
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
	 * ִ��һ����ͼ���ʹ��ImageMagick����������װ�Ƚ�����
	 * @param command Ҫִ�е�����
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
