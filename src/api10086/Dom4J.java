package api10086;

import java.io.File;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import com.d1.Const;

public class Dom4J {
	private static Document document = null;
	private static void getDocument(){
		if(document == null){
			SAXReader reader = new SAXReader();
			try {
				document = reader.read(new File( Const.PROJECT_PATH+"conf/ServerConfig.xml"));
				
				System.out.println(document);
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
	}
	public static String getDocumentValue(String nodeName){
		getDocument();
		Node node = document.selectSingleNode("//root/" + nodeName);
		if(nodeName.equals("INFO")){
			return node.asXML();
		} else {
			return node.getText();
		}
	}
	
	public static String getDocumentValue(){
		getDocument();
		Node node = document.selectSingleNode("//root/INFO");
		return node.getStringValue();
	}
	
}
