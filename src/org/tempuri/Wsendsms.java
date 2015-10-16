package org.tempuri;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.d1.util.Tools;

public class Wsendsms {
//1:成功，2：短信字数越长，3：手机号码错误，4：发送失败，5：发送接口异常
	public static int sendsms(String smstxt,String phone) throws IOException{
		int reti=1;
		if (smstxt.length()>65)return 2;
		if (phone.length()!=11&&phone.startsWith("13")&&phone.startsWith("15")&&phone.startsWith("18"))return 3;
		  WmgwLocator wmgwLocator = new WmgwLocator();
			String strArgs[] = new String[10];
			//jc2339  551251
			strArgs[0] = wmgwLocator.smsuserid;
			strArgs[1] = wmgwLocator.smspwd;		//
			strArgs[2] = phone;
			strArgs[3] = smstxt;
			strArgs[4] = "1";			//
			strArgs[5] = "*";			//
			String strMsg = strArgs[3];

			//发短信
			try {
	
				String  smsstatus=wmgwLocator.getwmgwSoap().mongateCsSpSendSmsNew(strArgs[0],strArgs[1], strArgs[2], strMsg, Integer.valueOf(strArgs[4]).intValue(),strArgs[5]);
			    FileWriter fw = new FileWriter(new File("/var/smslog.txt"),true);
				fw.write(phone+","+smsstatus);
				fw.write(System.getProperty("line.separator"));
				fw.flush();
				fw.close();
			  if(smsstatus.length()<=10){
				  reti=Tools.parseInt(smsstatus);
			    }
			  if (smsstatus.length()>=25){
				 reti=4;
			    }
			} catch (RemoteException e) {
				//e.printStackTrace();
				reti=5;
			} catch (ServiceException e) {
				//e.printStackTrace();
				reti=5;
			}

			
	
			return reti;
	}
	/**
	 * 多号码,无法一个个判断发送成功
	 * @param smstxt
	 * @param phone
	 * @return
	 * @throws IOException
	 */
	public static int sendsmss(String smstxt,String phone) throws IOException{
		int reti=1;
		if (smstxt.length()>65)return 2;
            WmgwLocator wmgwLocator = new WmgwLocator();
            String arrphone[]=phone.split(",");
            int arrlong=arrphone.length;
			String strArgs[] = new String[10];
			strArgs[0] = wmgwLocator.smsuserid;
			strArgs[1] = wmgwLocator.smspwd;		//
			strArgs[2] = phone;
			strArgs[3] = smstxt;
			strArgs[4] = (arrlong+1)+"";			//
			strArgs[5] = "*";			//
			String strMsg = strArgs[3];

			//发短信
			try {
				String  smsstatus=wmgwLocator.getwmgwSoap().mongateCsSpSendSmsNew(strArgs[0],strArgs[1], strArgs[2], strMsg, Integer.valueOf(strArgs[4]).intValue(),strArgs[5]);
			    FileWriter fw = new FileWriter(new File("/var/smslog.txt"),true);
			   
			     
			    for (int i=0;i<=arrlong;i++){
				fw.write(arrphone[i]+","+(Tools.parseInt(smsstatus)+i));
				fw.write(System.getProperty("line.separator"));
			    }
				fw.flush();
				fw.close();
			  if(smsstatus.length()<=10){
				  reti=Tools.parseInt(smsstatus);
			    }
			  if (smsstatus.length()>=25){
				 reti=4;
			    }
			} catch (RemoteException e) {
				//e.printStackTrace();
				reti=5;
			} catch (ServiceException e) {
				//e.printStackTrace();
				reti=5;
			}

			
	
			return reti;
	}
	
	
}
