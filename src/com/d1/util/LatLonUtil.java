package com.d1.util;
/**
 * ����㷨�ܾ�ȷ���ܾ�ȷ����
 * @author kk
 *
 */
public class LatLonUtil {  
     
    private static final double EARTH_RADIUS = 6378137;  //����뾶����λ��
    private static final double RAD = Math.PI/180.0;  
  
    /** 
     * ��ȡһ��raidus���뷶Χ�ڵľ���γ�������Сֵ���õ�һ��4�����ȵ�����
     * @param lon ����
     * @param lat γ��
     * @param raidus ��λ�� 
     * return minLat,minLng,maxLat,maxLng 
     */  
    public static double[] getAround(double lon,double lat,int raidus){  
          
        Double latitude = lat;  
        Double longitude = lon;  
          
        Double degree = (24901*1609)/360.0; 
        double raidusMile = raidus;  
          
        Double dpmLat = 1/degree; //һ�׾����Ӧγ�ȵı仯ֵ 
        Double radiusLat = dpmLat*raidusMile;  
        Double minLat = latitude - radiusLat;  
        Double maxLat = latitude + radiusLat;  
          
        Double mpdLng = degree*Math.cos(latitude * (Math.PI/180));  
        Double dpmLng = 1 / mpdLng; ////һ�׾����Ӧ���ȵı仯ֵ
        Double radiusLng = dpmLng*raidusMile;  
        Double minLng = longitude - radiusLng;  
        Double maxLng = longitude + radiusLng;  
 
        return new double[]{minLng,minLat,maxLng,maxLat};  
    }  
      
    /** 
     * ��������侭γ�����꣨doubleֵ���������������룬��ȷ���ס�<br/>
     * PS:�ڱ������γ�ȣ�1000�׵ľ��ȱ仯ֵ��0.01172��1000�׵�γ�ȱ仯ֵ��0.00899������仯�;�γ�ȱ仯ֵ�����ȣ�<br/>
     * @param lng1 ����
     * @param lat1 γ��
     * @param lng2 ����
     * @param lat2 γ��
     * @return ���루�ף�
     */  
    public static double getDistance(double lng1, double lat1, double lng2, double lat2)  
    {  
       double radLat1 = lat1*RAD;  
       double radLat2 = lat2*RAD;  
       double a = radLat1 - radLat2;  
       double b = (lng1 - lng2)*RAD;  
       double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +  
        Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));  
       s = s * EARTH_RADIUS;  
       s = Math.round(s * 10000)/10000;  
       return s;  
    }
    
    //1000�׵ľ��ȱ仯ֵ��0.01172��1000�׵�γ�ȱ仯ֵ��0.00899������仯�;�γ�ȱ仯ֵ������
    public static void main(String[] args){
        //System.out.println(getDistance(116.5221370,39.9448700,116.4816880,39.9401420));
    	//double[] ds = getAround(116.5221370,39.9448700,1000);
    	//System.out.println(ds[0]-116.5221370);System.out.println(ds[2]-116.5221370);
    	//System.out.println(ds[1]-39.9448700);System.out.println(ds[3]-39.9448700);
    	
    	System.out.println(getDistance(116.3977660,39.9025470,116.4258590,39.9047730));  
    }  
    
  //http://maps.google.com/maps/api/staticmap?center=%E5%8C%97%E4%BA%AC%E5%B8%82%E4%B8%9C%E5%9F%8E%E5%8C%BA%E8%B4%A1%E9%99%A2%E8%A5%BF%E8%A1%97&zoom=15&size=300x300&maptype=roadmap&mobile=true&sensor=true&markers=color:blue|label:s|%E5%8C%97%E4%BA%AC%E5%B8%82%E4%B8%9C%E5%9F%8E%E5%8C%BA%E8%B4%A1%E9%99%A2%E8%A5%BF%E8%A1%97&format=gif&lan=zh
  //http://www.google.cn/maps/geo?q=%E6%9C%9D%E9%98%B3%E5%85%AC%E5%9B%AD%E4%BD%93%E8%82%B2%E9%A6%86&output=xml
}  
