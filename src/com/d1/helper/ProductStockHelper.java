package com.d1.helper;

import java.util.ArrayList;

import com.d1.bean.Product;
import com.d1.bean.Sku;

/**
 * 判断一个商品是否显示“购买”按钮
 * @author kk
 *
 */
public class ProductStockHelper {
	/**
	 * 能够购买一个商品，要判断虚拟库存-占用库存数是否大于0，判断所有sku是否都没有库存
	 * @param product
	 * @return
	 */
	public static boolean canBuy(Product product){
		if(product==null)return false;
		//如果是“量少就下架”的商品（gdsmst_stocklinkty==5），留5个库存，免得被抢购光了
		if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==5){
			if(!ProductHelper.hasSku(product)){//如果没有sku
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
			if(!ProductHelper.hasSku(product)){//如果没有sku
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
