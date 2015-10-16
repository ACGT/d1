package com.d1.util;

/**
 * <p>Title:数字格式化</p>
 * <li>数字格式化，主要是用来补零什么的。</li>
 * <br><b>CopyRight: cgzz[昭昭]</b>
 * @author chg
 * @version chg-2.0
 */
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class NumberUtils {
	
	/**
	 * 小数位数最多为2位。如12，结果为12，12.015123，结果为12.02，四舍五入
	 */
	public static final DecimalFormat maxPrice = new DecimalFormat("#0");
	
	/**
	 * 小数位数为2位。如12，结果为12.00，12.015123，结果为12.02，四舍五入
	 */
	public static final DecimalFormat minPrice = new DecimalFormat("#0");
	
	/**
	 * 折扣，90/10为9，89/10为8.9，防止出现很多0
	 */
	public static final DecimalFormat disCount = new DecimalFormat("#0");
	
	/**
	 * 小数位数最多为3位。如12，结果为12，12.015123，结果为12.015，四舍五入
	 */
	public static final DecimalFormat maxWeight = new DecimalFormat("#0");
	
	/**
	 * 百分比格式
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
	 * 小数位数最多为2位。如12，结果为12，12.015123，结果为12.02，四舍五入
	 * @param d - 数字
	 * @return String
	 */
	public static String getMaxPrice(double d){
		return maxPrice.format(d);
	}
	
	/**
	 * 小数位数为2位。如12，结果为12.00，12.015123，结果为12.02，四舍五入
	 * @param d - 数字
	 * @return String
	 */
	public static String getMinPrice(double d){
		return minPrice.format(d);
	}
	
	/**
	 * 折扣，90/10为9，89/10为8.9，防止出现很多0
	 * @param d - 数字
	 * @return String
	 */
	public static String getMaxDis(double d){
		return disCount.format(d);
	}
	
	/**
	 * 重量，小数位数最多为3位。如12，结果为12，12.015123，结果为12.015，四舍五入
	 * @param d - 数字
	 * @return String
	 */
	public static String getMaxWeight(double d){
		return maxWeight.format(d);
	}
	
	/**
	 * 返回百分比根式
	 * @param d - 数字
	 * @return String
	 */
	public static String getPercent(double d){
		return percent.format(d);
	}
	
	/**
	 * 返回格式化的一个数字,小数位数不超过i
	 * @param d double 格式化的数字
	 * @param i int 小数位数最大位数
	 * @return String
	 */
	public static String getMaximumFraction(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMaximumFractionDigits(i);
		return df.format(d);
	}
	
	/**
	 * 返回格式化的一个数字,整数部分不能大于i
	 * @param d double 需要格式化的数字
	 * @param i int 整数部分最大位数
	 * @return String
	 */
	public static String getMaximumInteger(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMaximumIntegerDigits(i);
		return df.format(d);
	}
	
	/**
	 * 返回格式化的一个数字,小数部分不能小于i
	 * @param d double 需要格式化的数字
	 * @param i int 小数部分的最小位数
	 * @return String
	 */
	public static String getMinimumFraction(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMinimumFractionDigits(i);
		return df.format(d);
	}
	
	/**
	 * 返回格式化的一个数字,整数部分不能小于i
	 * @param d double 需要格式化的数字
	 * @param i 整数部分的最小位数
	 * @return String
	 */
	public static String getMinimumInteger(double d , int i){
		DecimalFormat df = new DecimalFormat("#0");
		df.setMinimumIntegerDigits(i);
		return df.format(d);
	}
	
	/**
	 * 返回格式化的一个数字,格式样式是用户自定义样式
	 * @param d double 需要格式化的数字
	 * @param format 格式样式
	 * @return String
	 */
	public static String getMumberCustom(double d , String format){
		DecimalFormat df = new DecimalFormat(format);
		return df.format(d);
	}
	
	/** 
     * 对double数据进行取精度. 
     * double value = 100.345678;
     * double ret = round(value,4,BigDecimal.ROUND_HALF_UP);
     * ret为100.3457  
     * @param value - double数据. 
     * @param scale - 精度位数(保留的小数位数). 
     * @param roundingMode - 精度取值方式.See BigDecimal
     * @return 精度计算后的数据. 
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
