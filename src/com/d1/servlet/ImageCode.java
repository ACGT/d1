package com.d1.servlet;

import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.d1.image.ImageCreator;

/**
 * 生成验证码的servlet
 * @author kk
 *
 */
public class ImageCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public void init() throws ServletException{
		//do nothing
    }
	
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
    	throws ServletException, IOException {
    	doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		HttpSession session = request.getSession();
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
		session.removeAttribute("USER_IMAGE_CHECK_CODE");
		session.setAttribute("USER_IMAGE_CHECK_CODE",str);
		ImageIO.write(image, "JPEG", response.getOutputStream());
	}
}