package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 购物车表，对应表f_cart。float存入是都四舍五入保留两位小数！用Tools.getFloat(f,2)保留两位小数！！！
 * @author kk
 *
 */
@Entity
@Table(name="f_cart")
public class Cart extends BaseEntity implements java.io.Serializable {

	/**
	 * searial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	/**
	 * 主键id
	 */
	private String id ;//done
	
	/**
	 * 父级id，组合套餐等会用到，所有父级id相同的算一个组（一个活动、一个组合、一个套餐等）
	 */
	private String parentId = "";
	
	/**
	 * 是否有子cart，1=有，0=没有
	 */
	private Long hasChild = new Long(0) ;
	
	/**
	 * 是否有父级cart，1有 0没有，修改购物车时要注意
	 */
	private Long hasFather = new Long(0) ;
	
	/**
	 * 购物车商品ID
	 */
	private String productId = "";
	
	/**
	 * 对应的sku id，或者型号
	 */
	private String skuId = "";
	
	/**
	 * IP，删除的时候要判断IP，修改时要修改IP。
	 */
	private String ip = "";
	
	/**
	 * 商品的数量
	 */
	private Long amount = new Long(1);
	
	/**
	 * 成交单价，单价，创建Cart时必须设置正确，用于计算最后购物车总价！！！！！
	 */
	private Float price = new Float(-1) ;
	
	/**
	 * 商品原价，会员价
	 */
	private Float oldPrice = new Float(0);
	
	/**
	 * VIP价格，单价
	 */
	private Float vipPrice = new Float(0);
	
	/**
	 * 商品的单价，这个是用户要支付的总价，已经乘上amount了
	 */
	private Float money = new Float(0) ;
	
	/**
	 * 没有登录的时候根据cookie记录购物车，cookie里存第一次访问的sessionId
	 */
	private String cookie = "";
	
	/**
	 * 如果是登录用户，用userId来读取购物车
	 */
	private String userId = "";
	
	/**
	 * 该条购物车记录创建时间
	 */
	private Date createDate = new Date();
	
	/**
	 * 购物车商品类型-999=默认未知，-5=积分兑换券，-4选X件Y折套餐父节点，-3买x送Y套餐父节点，-2=X元选Y件套餐父节点，<br/>
	 * -1=组合套餐父节点，-6=搭配套餐父节点，0=普通赠品，1=普通商品，2=积分换购商品，<br/>
	 * 3=买X送Y商品，4=X元选Y件商品，5=选X件Y折商品，6=团购商品，7=品牌减免商品，8=组合套餐子商品，<br/>
	 * 9=独享价商品，10=不参加E券的商品，type=10是CardHelper.addCart自动修改的，<br/>
	 * 11=团购兑换，12=单品赠品，13=网易兑换商品，14=DM刊赠品，15=激活邮件赠品,16搭配商品,17白金独享商品,18升级白金的赠品,19=生日礼物<br/>
	 * 20=商品秒杀特价,21=几件几折,22=手机独享
	 * 大于0表示要支付的价格商品，小于0表示虚拟品，不需要支付钱的商品<br/>
	 */
	private Long type = new Long(-999);
	
	/**
	 * 购物车标题
	 */
	private String title = "";
	
	/**
	 * 积分换购的总积分，已经乘商品数量
	 */
	private Long point = new Long(0);
	
	/**
	 * 兑换码
	 */
	private String tuanCode = "";
	
	/**
	 * 赠品分类
	 */
	private String giftRackcode = "";
	
	/**
	 * 赠品说明，类似“rck337(全场购物满额赠品)”
	 */
	private String giftType = "";
	
	/**
	 * 积分兑换的award id，暂时没什么用
	 */
	private String awardId ;
	/**
	 * 商户编号用于拆单
	 */
	private String shopcode="00000000" ;
	/**
	 * 商品的来源地址或搭配的来源地址
	 */
	private String refererurl;

	/**
	 * 用于商户满减促销  actid促销ID、actmoney促销优惠金额
	 */
    private Long actid=new Long(0);
    
    private Long actmoney=new Long(0);
    private String actmemo;

	public String getAwardId() {
		return awardId;
	}

	public void setAwardId(String awardId) {
		this.awardId = awardId;
	}

	public String getGiftRackcode() {
		return giftRackcode;
	}

	public void setGiftRackcode(String giftRackcode) {
		this.giftRackcode = giftRackcode;
	}

	public String getGiftType() {
		return giftType;
	}

	public void setGiftType(String giftType) {
		this.giftType = giftType;
	}

	public String getTuanCode() {
		return tuanCode;
	}

	public void setTuanCode(String tuanCode) {
		this.tuanCode = tuanCode;
	}

	public Long getPoint() {
		return point;
	}

	public void setPoint(Long point) {
		this.point = point;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Long getHasChild() {
		return hasChild;
	}

	public void setHasChild(Long hasChild) {
		this.hasChild = hasChild;
	}

	public Long getHasFather() {
		return hasFather;
	}

	public void setHasFather(Long hasFather) {
		this.hasFather = hasFather;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getSkuId() {
		return skuId;
	}

	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}

	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public Float getOldPrice() {
		return oldPrice;
	}

	public void setOldPrice(Float oldPrice) {
		this.oldPrice = oldPrice;
	}

	public Float getVipPrice() {
		return vipPrice;
	}

	public void setVipPrice(Float vipPrice) {
		this.vipPrice = vipPrice;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public String getCookie() {
		return cookie;
	}

	public void setCookie(String cookie) {
		this.cookie = cookie;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}
	public String getShopcode() {
		return shopcode;
	}

	public void setShopcode(String shopcode) {
		this.shopcode = shopcode;
	}
	public String getRefererurl() {
		return refererurl;
	}

	public void setRefererurl(String refererurl) {
		this.refererurl = refererurl;
	}

	public Long getActid() {
		return actid;
	}

	public void setActid(Long actid) {
		this.actid = actid;
	}

	public Long getActmoney() {
		return actmoney;
	}

	public void setActmoney(Long actmoney) {
		this.actmoney = actmoney;
	}

	public String getActmemo() {
		return actmemo;
	}

	public void setActmemo(String actmemo) {
		this.actmemo = actmemo;
	}
}
