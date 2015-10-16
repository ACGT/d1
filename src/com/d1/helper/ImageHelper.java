package com.d1.helper;


import java.awt.Color;  
import java.awt.Graphics;  
import java.awt.Image;  
import java.awt.Rectangle;  
import java.awt.image.BufferedImage;  
import java.io.File;  
import java.io.IOException;  
import java.io.PrintStream;  
import javax.imageio.ImageIO;  
  
public class ImageHelper {   
  
 /** 
  * @Description: ��srcImageFile�ü�������destImageFile 
  * @param srcImageFile  ԭʼͼ 
  * @param destImageFile  Ŀ��ͼ 
  * @param width          ԭʼͼԤ�����width 
  * @param height         ԭʼͼԤ�����height 
  * @param rect           Ŀ��ͼ����ĸ�ʽ(rect.x, rect.y, rect.width, rect.height) 
  * @throws IOException 
  * @author Sun Yanjun 
  */  
 public static void cut(String srcImageFile, String destImageFile, int width, int height, Rectangle rect) throws IOException {  
  Image image = ImageIO.read(new File(srcImageFile));  
  BufferedImage bImage = makeThumbnail(image, width, height);  
  
  //��ԭʼͼƬ���  
  //ImageIO.write(bImage, "jpg",new File("D://src2.jpg"));  
    
  saveSubImage(bImage, rect, new File(destImageFile));  
 }  
  
   
 /** 
  * @Description: ��srcImageFile�ü�������destImageFile 
  * @param srcImageFile  ԭʼͼ 
  * @param destImageFile  Ŀ��ͼ 
  * @param width          ԭʼͼԤ�����width 
  * @param height         ԭʼͼԤ�����height 
  * @param rect           Ŀ��ͼ����ĸ�ʽ(rect.x, rect.y, rect.width, rect.height) 
  * @throws IOException 
  * @author Sun Yanjun 
  */  
 public static void cut(File srcImageFile, File destImageFile, int width, int height, Rectangle rect) throws IOException {  
  Image image = ImageIO.read(srcImageFile);  
  BufferedImage bImage = makeThumbnail(image, width, height);  
  
    
  //saveSubImage(bImage, rect, destImageFile);  
 }  
   
 /** 
  * @Description: ��ԭʼͼƬ����(x, y, width, height) = (0, 0, width, height)�������ţ�����BufferImage 
  * @param img 
  * @param width Ԥ�����ͼƬ�Ŀ�� 
  * @param height Ԥ�����ͼƬ�߶� 
  * @return 
  * @author Sun Yanjun 
  * @throws IOException 
  */  
 private static BufferedImage makeThumbnail(Image img, int width, int height) throws IOException { 
	 int newwidth=0;
	 int newheight=0;
     if ((float)img.getWidth(null) > 0 && (float)img.getHeight(null) > 0) {
         if ((float)img.getWidth(null) / (float)img.getHeight(null) >= (float)width / (float)height) {
             if (img.getWidth(null) >width) {
                 newwidth=width;
                 newheight=(img.getHeight(null)*width) / img.getWidth(null);
             }
             else {
            	 newwidth=img.getWidth(null);
                 newheight=img.getHeight(null);
             }
         }
         else {
             if (img.getHeight(null) > height) {
            
            	 newheight=height;
                 newwidth=(img.getWidth(null) *height) / img.getHeight(null);
             }
             else {
                 newwidth=img.getWidth(null);
                 newheight=img.getHeight(null);
             }
         }
     }
	 
   System.out.print(newwidth+"n"+newheight);
  BufferedImage tag = new BufferedImage(newwidth, newheight, 1);  
  Graphics g = tag.getGraphics();  
  g.drawImage(img.getScaledInstance(newwidth, newheight, 4), 0, 0, null);  
    
  g.dispose();  
  return tag;  
 }  
  
 /** 
  * @Description: ��BufferImage����(x, y, width, height) = (subImageBounds.x, subImageBounds.y, subImageBounds.width, subImageBounds.height)���вü� 
  *               ���subImageBounds��Χ�������ÿհ������Χ������ 
  *               
  * @param image 
  * @param subImageBounds 
  * @param destImageFile 
  * @throws IOException 
  * @author 
  */  
 private static void saveSubImage(BufferedImage image, Rectangle subImageBounds, File destImageFile) throws IOException {  
  String fileName = destImageFile.getName();  
  String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);  
  BufferedImage subImage = new BufferedImage(subImageBounds.width, subImageBounds.height, 1);  
  Graphics g = subImage.getGraphics();  
    
  //  System.out.print(subImageBounds.width+","+subImageBounds.height+","+image.getWidth()+","+image.getHeight());
  if ((subImageBounds.width > image.getWidth())  
    || (subImageBounds.height > image.getHeight())) {  
   int left = subImageBounds.x;  
   int top = subImageBounds.y;  
   if (image.getWidth() < subImageBounds.width)  
    left = (subImageBounds.width - image.getWidth()) / 2;  
   if (image.getHeight() < subImageBounds.height)  
    top = (subImageBounds.height - image.getHeight()) / 2;  
   g.setColor(Color.white);  
   g.fillRect(0, 0, subImageBounds.width, subImageBounds.height);  
   g.drawImage(image, left, top, null);  
   ImageIO.write(image, formatName, destImageFile);  
  } else {  
   g.drawImage(image.getSubimage(subImageBounds.x, subImageBounds.y,  
     subImageBounds.width, subImageBounds.height), 0, 0, null);  
  }  
  g.dispose();  
  ImageIO.write(subImage, formatName, destImageFile);  
 }  
}  