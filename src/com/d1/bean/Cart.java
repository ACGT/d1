package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ���ﳵ����Ӧ��f_cart��float�����Ƕ��������뱣����λС������Tools.getFloat(f,2)������λС��������
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
	 * ����id
	 */
	private String id ;//done
	
	/**
	 * ����id������ײ͵Ȼ��õ������и���id��ͬ����һ���飨һ�����һ����ϡ�һ���ײ͵ȣ�
	 */
	private String parentId = "";
	
	/**
	 * �Ƿ�����cart��1=�У�0=û��
	 */
	private Long hasChild = new Long(0) ;
	
	/**
	 * �Ƿ��и���cart��1�� 0û�У��޸Ĺ��ﳵʱҪע��
	 */
	private Long hasFather = new Long(0) ;
	
	/**
	 * ���ﳵ��ƷID
	 */
	private String productId = "";
	
	/**
	 * ��Ӧ��sku id�������ͺ�
	 */
	private String skuId = "";
	
	/**
	 * IP��ɾ����ʱ��Ҫ�ж�IP���޸�ʱҪ�޸�IP��
	 */
	private String ip = "";
	
	/**
	 * ��Ʒ������
	 */
	private Long amount = new Long(1);
	
	/**
	 * �ɽ����ۣ����ۣ�����Cartʱ����������ȷ�����ڼ�������ﳵ�ܼۣ���������
	 */
	private Float price = new Float(-1) ;
	
	/**
	 * ��Ʒԭ�ۣ���Ա��
	 */
	private Float oldPrice = new Float(0);
	
	/**
	 * VIP�۸񣬵���
	 */
	private Float vipPrice = new Float(0);
	
	/**
	 * ��Ʒ�ĵ��ۣ�������û�Ҫ֧�����ܼۣ��Ѿ�����amount��
	 */
	private Float money = new Float(0) ;
	
	/**
	 * û�е�¼��ʱ�����cookie��¼���ﳵ��cookie����һ�η��ʵ�sessionId
	 */
	private String cookie = "";
	
	/**
	 * ����ǵ�¼�û�����userId����ȡ���ﳵ
	 */
	private String userId = "";
	
	/**
	 * �������ﳵ��¼����ʱ��
	 */
	private Date createDate = new Date();
	
	/**
	 * ���ﳵ��Ʒ����-999=Ĭ��δ֪��-5=���ֶһ�ȯ��-4ѡX��Y���ײ͸��ڵ㣬-3��x��Y�ײ͸��ڵ㣬-2=XԪѡY���ײ͸��ڵ㣬<br/>
	 * -1=����ײ͸��ڵ㣬-6=�����ײ͸��ڵ㣬0=��ͨ��Ʒ��1=��ͨ��Ʒ��2=���ֻ�����Ʒ��<br/>
	 * 3=��X��Y��Ʒ��4=XԪѡY����Ʒ��5=ѡX��Y����Ʒ��6=�Ź���Ʒ��7=Ʒ�Ƽ�����Ʒ��8=����ײ�����Ʒ��<br/>
	 * 9=�������Ʒ��10=���μ�Eȯ����Ʒ��type=10��CardHelper.addCart�Զ��޸ĵģ�<br/>
	 * 11=�Ź��һ���12=��Ʒ��Ʒ��13=���׶һ���Ʒ��14=DM����Ʒ��15=�����ʼ���Ʒ,16������Ʒ,17�׽������Ʒ,18�����׽����Ʒ,19=��������<br/>
	 * 20=��Ʒ��ɱ�ؼ�,21=��������,22=�ֻ�����
	 * ����0��ʾҪ֧���ļ۸���Ʒ��С��0��ʾ����Ʒ������Ҫ֧��Ǯ����Ʒ<br/>
	 */
	private Long type = new Long(-999);
	
	/**
	 * ���ﳵ����
	 */
	private String title = "";
	
	/**
	 * ���ֻ������ܻ��֣��Ѿ�����Ʒ����
	 */
	private Long point = new Long(0);
	
	/**
	 * �һ���
	 */
	private String tuanCode = "";
	
	/**
	 * ��Ʒ����
	 */
	private String giftRackcode = "";
	
	/**
	 * ��Ʒ˵�������ơ�rck337(ȫ������������Ʒ)��
	 */
	private String giftType = "";
	
	/**
	 * ���ֶһ���award id����ʱûʲô��
	 */
	private String awardId ;
	/**
	 * �̻�������ڲ�
	 */
	private String shopcode="00000000" ;
	/**
	 * ��Ʒ����Դ��ַ��������Դ��ַ
	 */
	private String refererurl;

	/**
	 * �����̻���������  actid����ID��actmoney�����Żݽ��
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
