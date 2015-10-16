package com.d1.helper;

import java.util.ArrayList;

import com.d1.bean.Product;
import com.d1.bean.Sku;

/**
 * �ж�һ����Ʒ�Ƿ���ʾ�����򡱰�ť
 * @author kk
 *
 */
public class ProductStockHelper {
	/**
	 * �ܹ�����һ����Ʒ��Ҫ�ж�������-ռ�ÿ�����Ƿ����0���ж�����sku�Ƿ�û�п��
	 * @param product
	 * @return
	 */
	public static boolean canBuy(Product product){
		if(product==null)return false;
		//����ǡ����پ��¼ܡ�����Ʒ��gdsmst_stocklinkty==5������5����棬��ñ���������
		if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==5){
			if(!ProductHelper.hasSku(product)){//���û��sku
				if(ProductHelper.getVirtualStock(product.getId(), null)>5+CartItemHelper.getProductOccupyStock(product.getId(), null))return true;
				else return false;
			}else{
				ArrayList<Sku> list = SkuHelper.getSkuListViaProductId(product.getId());
				if(list!=null&&list.size()>0){
					boolean ret = false ;
					for(Sku sku:list){
						if(ProductHelper.getVirtualStock(product.getId(), sku.getId())>5+CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())){
							ret = true ;
							break;
						}
					}
					return ret ;
				}else{
					return false;
				}
			}
		}else if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
			if(!ProductHelper.hasSku(product)){//���û��sku
				if(ProductHelper.getVirtualStock(product.getId(), null)>CartItemHelper.getProductOccupyStock(product.getId(), null))return true;
				else return false;
			}else{
				ArrayList<Sku> list = SkuHelper.getSkuListViaProductId(product.getId());
				if(list!=null&&list.size()>0){
					boolean ret = false ;
					for(Sku sku:list){
						if(ProductHelper.getVirtualStock(product.getId(), sku.getId())>CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())){
							ret = true ;
							break;
						}
					}
					return ret ;
				}else{
					return false;
				}
			}
		}else{
			return true;
		}
	}
}
