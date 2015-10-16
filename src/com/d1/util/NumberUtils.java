package com.d1.util;

/**
 * <p>Title:���ָ�ʽ��</p>
 * <li>���ָ�ʽ������Ҫ����������ʲô�ġ�</li>
 * <br><b>CopyRight: cgzz[����]</b>
 * @author chg
 * @version chg-2.0
 */
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class NumberUtils {
	
	/**
	 * С��λ�����Ϊ2λ����12�����Ϊ12��12.015123�����Ϊ12.02����������
	 */
	public static final DecimalFormat maxPrice = new DecimalFormat("#0");
	
	/**
	 * С��λ��Ϊ2λ����12�����Ϊ12.00��12.015123�����Ϊ12.02����������
	 */
	public static final DecimalFormat minPrice = new DecimalFormat("#0");
	
	/**
	 * �ۿۣ�90/10Ϊ9��89/10Ϊ8.9����ֹ���ֺܶ�0
	 */
	public static final DecimalFormat disCount = new DecimalFormat("#0");
	
	/**
	 * С��λ�����Ϊ3λ����12�����Ϊ12��12.015123�����Ϊ12.015����������
	 */
	public static final DecimalFormat maxWeight = new DecimalFormat("#0");
	
	/**
	 * �ٷֱȸ�ʽ
	 */
	public static final NumberFormat percent = NumberFormat.getPercentInstance();
	
	static{
		maxPrice.setMaximumFractionDigits(2);
		maxWeight.setMaximumFractionDigits(3);
		minPrice.setMinimumFractionDigits(2);
		disCount.setMaximumFractionDigits(1);
		percent.setMinimumFractionDigits(2);
	}
	
	/**
	 * С��λ�����Ϊ2λ����12�����Ϊ12��12.015123�����Ϊ12.02����������
	 * @param d - ����
	 * @return String
	 */
	public static String getMaxPrice(double d){
		return maxPrice.format(d);
	}
	
	/**
	 * С��λ��Ϊ2λ����12�����Ϊ12.00��12.015123�����Ϊ12.02����������
	 * @param d - ����
	 * @return String
	 */
	public static String getMinPrice(double d){
		return minPrice.format(d);
	}
	
	/**
	 * �ۿۣ�90/10Ϊ9��89/10Ϊ8.9����ֹ���ֺܶ�0
	 * @param d - ����
	 * @return String
	 */
	public static String getMaxDis(double d){
		return disCount.format(d);
	}
	
	/**
	 * ������С��λ�����Ϊ3λ����12�����Ϊ12��12.015123�����Ϊ12.015����������
	 * @param d - ����
	 * @return String
	 */
	public static String getMaxWeight(double d){
		return maxWeight.format(d);
	}
	
	/**
	 * ���ذٷֱȸ�ʽ
	 * @param d - ����
	 * @return String
	 */
	public static String getPercent(double d){
		return percent.format(d);
	}
	
	/**
	 * ���ظ�ʽ����һ������,С��λ��������i
	 * @param d double ��ʽ��������
	 * @param i int С��λ�����λ��
	 * @return String
	 */
	public static String getMaximumFraction(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMaximumFractionDigits(i);
		return df.format(d);
	}
	
	/**
	 * ���ظ�ʽ����һ������,�������ֲ��ܴ���i
	 * @param d double ��Ҫ��ʽ��������
	 * @param i int �����������λ��
	 * @return String
	 */
	public static String getMaximumInteger(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMaximumIntegerDigits(i);
		return df.format(d);
	}
	
	/**
	 * ���ظ�ʽ����һ������,С�����ֲ���С��i
	 * @param d double ��Ҫ��ʽ��������
	 * @param i int С�����ֵ���Сλ��
	 * @return String
	 */
	public static String getMinimumFraction(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMinimumFractionDigits(i);
		return df.format(d);
	}
	
	/**
	 * ���ظ�ʽ����һ������,�������ֲ���С��i
	 * @param d double ��Ҫ��ʽ��������
	 * @param i �������ֵ���Сλ��
	 * @return String
	 */
	public static String getMinimumInteger(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMinimumIntegerDigits(i);
		return df.format(d);
	}
	
	/**
	 * ���ظ�ʽ����һ������,��ʽ��ʽ���û��Զ�����ʽ
	 * @param d double ��Ҫ��ʽ��������
	 * @param format ��ʽ��ʽ
	 * @return String
	 */
	public static String getMumberCustom(double d , String format){
		DecimalFormat df = new DecimalFormat(format);
		return df.format(d);
	}
	
	/** 
     * ��double���ݽ���ȡ����. 
     * double value = 100.345678;
     * double ret = round(value,4,BigDecimal.ROUND_HALF_UP);
     * retΪ100.3457  
     * @param value - double����. 
     * @param scale - ����λ��(������С��λ��). 
     * @param roundingMode - ����ȡֵ��ʽ.See BigDecimal
     * @return ���ȼ���������. 
     */  
    public static float round(double value, int scale, int roundingMode) {  
        BigDecimal bd = new BigDecimal(value);  
        bd = bd.setScale(scale, roundingMode);  
        float d = bd.floatValue();
        bd = null;  
        return d;  
    }
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		DecimalFormat minPrice = new DecimalFormat("0");
		System.out.println(minPrice.format(23444344.3434f));
	}

}
