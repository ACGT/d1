package com.d1.image;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
  
/** 
 * ��֤��ͼƬ������ 
 *  
 * @author kk �޸� 
 *  
 */  
public class ImageCreator {  
    /** 
     * ��֤��ͼƬ�Ŀ�ȡ� 
     */  
    private int width = 60;  
    /** 
     * ��֤��ͼƬ�ĸ߶ȡ� 
     */  
    private int height = 24;  
    /** 
     * ��֤��������� 
     */  
    private Random random = new Random();  
      
    public ImageCreator(){}  
    /** 
     * ���������ɫ 
     * @param fc    ǰ��ɫ 
     * @param bc    ����ɫ 
     * @return  Color���󣬴�Color������RGB��ʽ�ġ� 
     */  
    public Color getRandomColor(int fc, int bc) {  
        if (fc > 255)  
            fc = 200;  
        if (bc > 255)  
            bc = 255;  
        int r = fc + random.nextInt(bc - fc);  
        int g = fc + random.nextInt(bc - fc);  
        int b = fc + random.nextInt(bc - fc);  
        return new Color(r, g, b);  
    }  
      
    /** 
     * ���Ƹ����� 
     * @param g Graphics2D������������ͼ�� 
     * @param nums  �����ߵ����� 
     */  
    public void drawRandomLines(Graphics2D g ,int nums ){  
        g.setColor(this.getRandomColor(160, 200)) ;  
        for(int i=0 ; i<nums ; i++){  
            int x1 = random.nextInt(width) ;  
            int y1 = random.nextInt(height);  
            int x2 = random.nextInt(12) ;  
            int y2 = random.nextInt(12) ;  
            g.drawLine(x1, y1, x2, y2) ;  
        }  
    }  
      
    /** 
     * ��ȡ����ַ����� 
     *      �˺������Բ����ɴ�Сд��ĸ�����֣�������ɵ��ַ��� 
     * @param length    ����ַ����ĳ��� 
     * @return  ����ַ��� 
     */  
    public String drawRandomString(int length , Graphics2D g){  
        StringBuffer strbuf = new StringBuffer() ;  
        String temp = "" ;  
        int itmp = 0 ;  
        int num = 10; //ֻ��������
        for(int i=0 ; i<length ; i++){  
            //switch(random.nextInt(5)){  
        	switch(num){ 
            case 1:     //����A��Z����ĸ  
                itmp = random.nextInt(26) + 65 ;  
                temp = String.valueOf((char)itmp);  
                break;  
            case 2:  
                itmp = random.nextInt(26) + 97 ;  
                temp = String.valueOf((char)itmp);  
            case 3:     //���ɺ���  
                String[] rBase = {"0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" ,   
                        "8" , "9" , "a" , "b" , "c" , "d" , "e" , "f" };  
                int r1 = random.nextInt(3)+11 ;     //���ɵ�1λ������  
                String strR1 = rBase[r1] ;      //����11��14�������  
                int r2 ;        //���ɵ�2λ������  
                if(r1 == 13)  
                    r2 = random.nextInt(7) ;    //����0��7�������  
                else  
                    r2 = random.nextInt(16) ;   //����0��16�������  
                String strR2 = rBase[r2] ;  
                int r3 = random.nextInt(6) + 10 ;   //���ɵ�1λ��λ��  
                String strR3 = rBase[r3] ;  
                int r4 ;        //���ɵ�2λ��λ��  
                if(r3 == 10)  
                    r4 = random.nextInt(15) + 1;    //����1��16�������  
                else if(r3 == 15)  
                    r4 = random.nextInt(15) ;       //����0��15�������  
                else  
                    r4 = random.nextInt(16) ;       //����0��16�������  
                String strR4 = rBase[r4] ;  
                //�����ɵĻ�����ת��������  
                byte[] bytes = new byte[2]   ;        
                String strR12 = strR1 + strR2 ;     //�����ɵ����뱣�浽�ֽ�����ĵ�1��Ԫ����  
                int tempLow = Integer.parseInt(strR12, 16) ;  
                bytes[0] = (byte)tempLow;  
                String strR34 = strR3 + strR4 ;     //�����ɵ����뱣�浽�ֽ�����ĵ�2��Ԫ����  
                int tempHigh = Integer.parseInt(strR34, 16) ;  
                bytes[1] = (byte)tempHigh;  
                temp = new String(bytes);           //�����ֽ��������ɺ���  
                break;  
            default:  
                itmp = random.nextInt(10) + 48 ;  
                temp = String.valueOf((char)itmp) ;  
                break;  
            }  
            Color color = new Color(20+random.nextInt(20) , 20+random.nextInt(20) ,20+random.nextInt(20) );  
            g.setColor(color) ;  
            //��������תһ���ĽǶ�  
            AffineTransform trans = new AffineTransform();  
            trans.rotate(random.nextInt(30)*3.14/180, 15*i+8, 7) ;  
            //��������  
            float scaleSize = random.nextFloat() + 0.8f ;  
            if(scaleSize>1f)  
                scaleSize = 1f ;  
            trans.scale(scaleSize, scaleSize) ;  
            g.setTransform(trans) ;  
            g.drawString(temp, 15*i+5, 20) ;  
              
            strbuf.append(temp) ;  
        }
        g.dispose() ;  
        return strbuf.toString() ;  
    }  
    public int getWidth() {  
        return width;  
    }  
    public void setWidth(int width) {  
        this.width = width;  
    }  
    public int getHeight() {  
        return height;  
    }  
    public void setHeight(int height) {  
        this.height = height;  
    }  
    
    public static void main(String[] args) throws Exception{
    	ImageCreator idCode = new ImageCreator();  
    	BufferedImage image =new BufferedImage(idCode.getWidth() , idCode.getHeight() , BufferedImage.TYPE_INT_BGR) ;  
    	Graphics2D g = image.createGraphics() ;  
    	Font myFont = new Font("Arial" , Font.PLAIN , 20) ;  
    	g.setFont(myFont) ;  
    	g.setColor(idCode.getRandomColor(200 , 250)) ;  
    	g.fillRect(0, 0, idCode.getWidth() , idCode.getHeight()) ;  
    	g.setColor(idCode.getRandomColor(180, 200)) ;  
    	idCode.drawRandomLines(g, 160) ;  
    	String str = idCode.drawRandomString(4, g) ;  
    	g.dispose() ;
    	System.out.println(str);
    	ImageIO.write(image, "JPEG", new FileOutputStream(new File("E://1.jpg")));
    }
}     