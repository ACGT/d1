package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品表
 * @author kk
 *
 */
@Entity
@Table(name="gdsmst")
public class Product extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdsmst_gdsid")
	private String id;//done

	private String gdsmst_shopcode;
	private String gdsmst_gdsname;
	private String gdsmst_gdsename;
	private String gdsmst_rackcode;
	private String gdsmst_relrackcode;
	private String gdsmst_orgrackcode;
	private String gdsmst_brand;
	private String gdsmst_brandname;
	private String gdsmst_stdid;
	private String gdsmst_stdvalue1;
	private String gdsmst_stdvalue2;
	private String gdsmst_stdvalue3;
	private String gdsmst_stdvalue4;
	private String gdsmst_stdvalue5;
	private String gdsmst_stdvalue6;
	private String gdsmst_stdvalue7;
	private String gdsmst_stdvalue8;
	private String gdsmst_stdvalue9;
	private String gdsmst_stdvalue10;
	private String gdsmst_stdvalue11;
	private String gdsmst_stdvalue12;
	private String gdsmst_stdothervalues;
	private String gdsmst_keyword;
	private String gdsmst_unit;
	private Float Gdsmst_weight;
	private String gdsmst_imgurl;
	private String gdsmst_smallimg;
	private String gdsmst_bigimg;
	private String gdsmst_nomarkimg;
	private String gdsmst_briefintrduce;
	private String gdsmst_detailintruduce;
	private Long gdsmst_hitcount;
	private Date gdsmst_createdate;
	private Date gdsmst_updatedate;
	private Long gdsmst_refcount;
	private Long gdsmst_validflag;
	private Float gdsmst_saleprice;
	private Float gdsmst_memberprice;
	private Float gdsmst_vipprice;
	private Long gdsmst_incometype;
	private Float gdsmst_incomeprice;
	private Long gdsmst_presellflag;
	private String gdsmst_provenance;
	private String gdsmst_manufacture;
	private String gdsmst_provider;
	private String gdsmst_promotionword;
	private Date gdsmst_promotionstart;
	private Date gdsmst_promotionend;
	private String gdsmst_shopgoodscode;
	private Date gdsmst_beginstart;
	private Date gdsmst_enddateend;
	private Long gdsmst_discounflag;
	private String gdsmst_refrackcode;
	private String gdsmst_paymethod;
	private String gdsmst_sndmethod;
	
	/**
	 * 销量，总销量
	 */
	private Long gdsmst_salecount;
	private Long gdsmst_wsalecount;
	private Long gdsmst_sendcount;
	private String gdsmst_handworkurl;
	private String gdsmst_title;
	private String gdsmst_tktdesc;
	private String gdsmst_inputmngid;
	private Long gdsmst_stock;
	private Float gdsmst_taxfee;
	private Float gdsmst_Insurancefee;
	private Float gdsmst_netpayfee;
	private Long gdsmst_downflag;
	private String gdsmst_provide;
	private Float gdsmst_inprice;
	private Float gdsmst_pricelev1;
	private Float gdsmst_pricelev2;
	private Float gdsmst_eyuan=0f;
	private String gdsmst_srcurl1;
	private String gdsmst_srcurl2;
	private String gdsmst_srcurl3;
	private String gdsmst_otherimg1;
	private String gdsmst_otherimg2;
	private String gdsmst_otherimg3;
	private Float gdsmst_provide8848;
	private String gdsmst_linkgds;
	private String gdsmst_linkrck;
	private Long gdsmst_buylimit;
	private String gdsmst_modimngid;
	private Float gdsmst_oldmemberprice;
	private Float gdsmst_oldvipprice;
	private Date gdsmst_discountenddate;
	private Long gdsmst_giftselecttype;
	private Float gdsmst_spendcount;
	
	/**
	 * 是否是玻璃品
	 */
	private Long gdsmst_glassflag ;
	
	/**
	 * 0是什么都参与，1表示商品不能用券
	 */
	private Long gdsmst_specialflag;
	private Float gdsmst_srcprice1;
	private Float gdsmst_srcprice2;
	private Float gdsmst_srcprice3;
	private Date gdsmst_srcdate1;
	private Date gdsmst_srcdate2;
	private Date gdsmst_srcdate3;
	private Long Gdsmst_srctype1;
	private Long Gdsmst_srctype2;
	private Long Gdsmst_srctype3;
	private Long gdsmst_srcstatus;
	private Long gdsmst_ifhavegds;
	private Date gdsmst_ifhavedate;
	private Float gdsmst_addshipfee;
	private String gdsmst_provideStr;
	private String gdsmst_barcode;
	private String gdsmst_gdssite;
	private String gdsmst_gzgdssite;
	

	/**
	 * 库存联动类型，0不联动，1卖完就下，2量少提醒，3量少提醒不暂缺
	 */
	private Long gdsmst_stocklinkty;
	
	/**
	 * 虚拟库存
	 */
	private Long gdsmst_virtualstock;
	private String gdsmst_ip;
	private Float gdsmst_othercost;
	private String gdsmst_layertype;
	private String gdsmst_layertitle;
	
	/**
	 * 这个字段如果不是null，或者长度大于0，表示有sku
	 */
	private String gdsmst_skuname1;
	private String gdsmst_skuname2;
	private Long gdsmst_sex;
	private String gdsmst_atts;
	private Date gdsmst_autoupdatedate;
	private String gdsmst_autopageurl;
	private Long gdsmst_airflag;
	private Date gdsmst_validdate;
	private String gdsmst_midimg;
	private String gdsmst_recimg;
	private String gdsmst_fzimg;
	private String gdsmst_img200250;
	private String gdsmst_img240300;
	private String gdsmst_img310;
	private Long gdsmst_sizeid;
	private Long gdsmst_mwgid;//男女通用身高体重对应
	private Long gdssmt_wwgid;//女装身高体重对应ID
	/**
	 * 商品所属系列 
	 */
	private String gdsmst_gdscoll;
	private String gdsmst_shoprck;
	
	private Float gdsmst_msprice=0f;
	private Float gdsmst_sortxs=0f;
	private Long gdsmst_sortxsv=new Long(0);
	
	/**
	 * 商品周销量，不对应数据库字段
	 */
	@Transient
	private int total_sales = -1 ; 
	
	

	@Transient
	private int sequence = -1 ;
	
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public int getTotal_sales() {
		return total_sales;
	}
	public void setTotal_sales(int total_sales) {
		this.total_sales = total_sales;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsmst_shopcode() {
		return gdsmst_shopcode;
	}
	public void setGdsmst_shopcode(String gdsmst_shopcode) {
		this.gdsmst_shopcode = gdsmst_shopcode;
	}
	public String getGdsmst_gdsname() {
		return gdsmst_gdsname;
	}
	public void setGdsmst_gdsname(String gdsmst_gdsname) {
		this.gdsmst_gdsname = gdsmst_gdsname;
	}
	public String getGdsmst_gdsename() {
		return gdsmst_gdsename;
	}
	public void setGdsmst_gdsename(String gdsmst_gdsename) {
		this.gdsmst_gdsename = gdsmst_gdsename;
	}
	public String getGdsmst_rackcode() {
		return gdsmst_rackcode;
	}
	public void setGdsmst_rackcode(String gdsmst_rackcode) {
		this.gdsmst_rackcode = gdsmst_rackcode;
	}
	public String getGdsmst_relrackcode() {
		return gdsmst_relrackcode;
	}
	public void setGdsmst_relrackcode(String gdsmst_relrackcode) {
		this.gdsmst_relrackcode = gdsmst_relrackcode;
	}
	public String getGdsmst_orgrackcode() {
		return gdsmst_orgrackcode;
	}
	public void setGdsmst_orgrackcode(String gdsmst_orgrackcode) {
		this.gdsmst_orgrackcode = gdsmst_orgrackcode;
	}
	public String getGdsmst_brand() {
		return gdsmst_brand;
	}
	public void setGdsmst_brand(String gdsmst_brand) {
		this.gdsmst_brand = gdsmst_brand;
	}
	public String getGdsmst_brandname() {
		return gdsmst_brandname;
	}
	public void setGdsmst_brandname(String gdsmst_brandname) {
		this.gdsmst_brandname = gdsmst_brandname;
	}
	public String getGdsmst_stdid() {
		return gdsmst_stdid;
	}
	public void setGdsmst_stdid(String gdsmst_stdid) {
		this.gdsmst_stdid = gdsmst_stdid;
	}
	public String getGdsmst_stdvalue1() {
		return gdsmst_stdvalue1;
	}
	public void setGdsmst_stdvalue1(String gdsmst_stdvalue1) {
		this.gdsmst_stdvalue1 = gdsmst_stdvalue1;
	}
	public String getGdsmst_stdvalue2() {
		return gdsmst_stdvalue2;
	}
	public void setGdsmst_stdvalue2(String gdsmst_stdvalue2) {
		this.gdsmst_stdvalue2 = gdsmst_stdvalue2;
	}
	public String getGdsmst_stdvalue3() {
		return gdsmst_stdvalue3;
	}
	public void setGdsmst_stdvalue3(String gdsmst_stdvalue3) {
		this.gdsmst_stdvalue3 = gdsmst_stdvalue3;
	}
	public String getGdsmst_stdvalue4() {
		return gdsmst_stdvalue4;
	}
	public void setGdsmst_stdvalue4(String gdsmst_stdvalue4) {
		this.gdsmst_stdvalue4 = gdsmst_stdvalue4;
	}
	public String getGdsmst_stdvalue5() {
		return gdsmst_stdvalue5;
	}
	public void setGdsmst_stdvalue5(String gdsmst_stdvalue5) {
		this.gdsmst_stdvalue5 = gdsmst_stdvalue5;
	}
	public String getGdsmst_stdvalue6() {
		return gdsmst_stdvalue6;
	}
	public void setGdsmst_stdvalue6(String gdsmst_stdvalue6) {
		this.gdsmst_stdvalue6 = gdsmst_stdvalue6;
	}
	public String getGdsmst_stdvalue7() {
		return gdsmst_stdvalue7;
	}
	public void setGdsmst_stdvalue7(String gdsmst_stdvalue7) {
		this.gdsmst_stdvalue7 = gdsmst_stdvalue7;
	}
	public String getGdsmst_stdvalue8() {
		return gdsmst_stdvalue8;
	}
	public void setGdsmst_stdvalue8(String gdsmst_stdvalue8) {
		this.gdsmst_stdvalue8 = gdsmst_stdvalue8;
	}
	public String getGdsmst_stdvalue9() {
		return gdsmst_stdvalue9;
	}
	public void setGdsmst_stdvalue9(String gdsmst_stdvalue9) {
		this.gdsmst_stdvalue9 = gdsmst_stdvalue9;
	}
	public String getGdsmst_stdvalue10() {
		return gdsmst_stdvalue10;
	}
	public void setGdsmst_stdvalue10(String gdsmst_stdvalue10) {
		this.gdsmst_stdvalue10 = gdsmst_stdvalue10;
	}
	public String getGdsmst_stdvalue11() {
		return gdsmst_stdvalue11;
	}
	public void setGdsmst_stdvalue11(String gdsmst_stdvalue11) {
		this.gdsmst_stdvalue11 = gdsmst_stdvalue11;
	}
	public String getGdsmst_stdvalue12() {
		return gdsmst_stdvalue12;
	}
	public void setGdsmst_stdvalue12(String gdsmst_stdvalue12) {
		this.gdsmst_stdvalue12 = gdsmst_stdvalue12;
	}
	
	public String getGdsmst_stdothervalues() {
		return gdsmst_stdothervalues;
	}
	public void setGdsmst_stdothervalues(String gdsmst_stdothervalues) {
		this.gdsmst_stdothervalues = gdsmst_stdothervalues;
	}
	public String getGdsmst_keyword() {
		return gdsmst_keyword;
	}
	public void setGdsmst_keyword(String gdsmst_keyword) {
		this.gdsmst_keyword = gdsmst_keyword;
	}
	public String getGdsmst_unit() {
		return gdsmst_unit;
	}
	public void setGdsmst_unit(String gdsmst_unit) {
		this.gdsmst_unit = gdsmst_unit;
	}
	public Float getGdsmst_weight() {
		return Gdsmst_weight;
	}
	public void setGdsmst_weight(Float gdsmst_weight) {
		Gdsmst_weight = gdsmst_weight;
	}
	public String getGdsmst_imgurl() {
		return gdsmst_imgurl;
	}
	public void setGdsmst_imgurl(String gdsmst_imgurl) {
		this.gdsmst_imgurl = gdsmst_imgurl;
	}
	public String getGdsmst_smallimg() {
		return gdsmst_smallimg;
	}
	public void setGdsmst_smallimg(String gdsmst_smallimg) {
		this.gdsmst_smallimg = gdsmst_smallimg;
	}
	public String getGdsmst_bigimg() {
		return gdsmst_bigimg;
	}
	public void setGdsmst_bigimg(String gdsmst_bigimg) {
		this.gdsmst_bigimg = gdsmst_bigimg;
	}
	public String getGdsmst_nomarkimg() {
		return gdsmst_nomarkimg;
	}
	public void setGdsmst_nomarkimg(String gdsmst_nomarkimg) {
		this.gdsmst_nomarkimg = gdsmst_nomarkimg;
	}
	public String getGdsmst_briefintrduce() {
		return gdsmst_briefintrduce;
	}
	public void setGdsmst_briefintrduce(String gdsmst_briefintrduce) {
		this.gdsmst_briefintrduce = gdsmst_briefintrduce;
	}
	public String getGdsmst_detailintruduce() {
		return gdsmst_detailintruduce;
	}
	public void setGdsmst_detailintruduce(String gdsmst_detailintruduce) {
		this.gdsmst_detailintruduce = gdsmst_detailintruduce;
	}
	public Long getGdsmst_hitcount() {
		return gdsmst_hitcount;
	}
	public void setGdsmst_hitcount(Long gdsmst_hitcount) {
		this.gdsmst_hitcount = gdsmst_hitcount;
	}
	public Date getGdsmst_createdate() {
		return gdsmst_createdate;
	}
	public void setGdsmst_createdate(Date gdsmst_createdate) {
		this.gdsmst_createdate = gdsmst_createdate;
	}
	public Date getGdsmst_updatedate() {
		return gdsmst_updatedate;
	}
	public void setGdsmst_updatedate(Date gdsmst_updatedate) {
		this.gdsmst_updatedate = gdsmst_updatedate;
	}
	public Long getGdsmst_refcount() {
		return gdsmst_refcount;
	}
	public void setGdsmst_refcount(Long gdsmst_refcount) {
		this.gdsmst_refcount = gdsmst_refcount;
	}
	public Long getGdsmst_validflag() {
		return gdsmst_validflag;
	}
	public void setGdsmst_validflag(Long gdsmst_validflag) {
		this.gdsmst_validflag = gdsmst_validflag;
	}
	public Float getGdsmst_saleprice() {
		return gdsmst_saleprice;
	}
	public void setGdsmst_saleprice(Float gdsmst_saleprice) {
		this.gdsmst_saleprice = gdsmst_saleprice;
	}
	public Float getGdsmst_memberprice() {
		return gdsmst_memberprice;
	}
	public void setGdsmst_memberprice(Float gdsmst_memberprice) {
		this.gdsmst_memberprice = gdsmst_memberprice;
	}
	public Float getGdsmst_vipprice() {
		return gdsmst_vipprice;
	}
	public void setGdsmst_vipprice(Float gdsmst_vipprice) {
		this.gdsmst_vipprice = gdsmst_vipprice;
	}
	public Long getGdsmst_incometype() {
		return gdsmst_incometype;
	}
	public void setGdsmst_incometype(Long gdsmst_incometype) {
		this.gdsmst_incometype = gdsmst_incometype;
	}
	public Float getGdsmst_incomeprice() {
		return gdsmst_incomeprice;
	}
	public void setGdsmst_incomeprice(Float gdsmst_incomeprice) {
		this.gdsmst_incomeprice = gdsmst_incomeprice;
	}
	public Long getGdsmst_presellflag() {
		return gdsmst_presellflag;
	}
	public void setGdsmst_presellflag(Long gdsmst_presellflag) {
		this.gdsmst_presellflag = gdsmst_presellflag;
	}
	public String getGdsmst_provenance() {
		return gdsmst_provenance;
	}
	public void setGdsmst_provenance(String gdsmst_provenance) {
		this.gdsmst_provenance = gdsmst_provenance;
	}
	public String getGdsmst_manufacture() {
		return gdsmst_manufacture;
	}
	public void setGdsmst_manufacture(String gdsmst_manufacture) {
		this.gdsmst_manufacture = gdsmst_manufacture;
	}
	public String getGdsmst_provider() {
		return gdsmst_provider;
	}
	public void setGdsmst_provider(String gdsmst_provider) {
		this.gdsmst_provider = gdsmst_provider;
	}
	public String getGdsmst_promotionword() {
		return gdsmst_promotionword;
	}
	public void setGdsmst_promotionword(String gdsmst_promotionword) {
		this.gdsmst_promotionword = gdsmst_promotionword;
	}
	public Date getGdsmst_promotionstart() {
		return gdsmst_promotionstart;
	}
	public void setGdsmst_promotionstart(Date gdsmst_promotionstart) {
		this.gdsmst_promotionstart = gdsmst_promotionstart;
	}
	public Date getGdsmst_promotionend() {
		return gdsmst_promotionend;
	}
	public void setGdsmst_promotionend(Date gdsmst_promotionend) {
		this.gdsmst_promotionend = gdsmst_promotionend;
	}
	public String getGdsmst_shopgoodscode() {
		return gdsmst_shopgoodscode;
	}
	public void setGdsmst_shopgoodscode(String gdsmst_shopgoodscode) {
		this.gdsmst_shopgoodscode = gdsmst_shopgoodscode;
	}
	public Date getGdsmst_beginstart() {
		return gdsmst_beginstart;
	}
	public void setGdsmst_beginstart(Date gdsmst_beginstart) {
		this.gdsmst_beginstart = gdsmst_beginstart;
	}
	public Date getGdsmst_enddateend() {
		return gdsmst_enddateend;
	}
	public void setGdsmst_enddateend(Date gdsmst_enddateend) {
		this.gdsmst_enddateend = gdsmst_enddateend;
	}
	public Long getGdsmst_discounflag() {
		return gdsmst_discounflag;
	}
	public void setGdsmst_discounflag(Long gdsmst_discounflag) {
		this.gdsmst_discounflag = gdsmst_discounflag;
	}
	public String getGdsmst_refrackcode() {
		return gdsmst_refrackcode;
	}
	public void setGdsmst_refrackcode(String gdsmst_refrackcode) {
		this.gdsmst_refrackcode = gdsmst_refrackcode;
	}
	public String getGdsmst_paymethod() {
		return gdsmst_paymethod;
	}
	public void setGdsmst_paymethod(String gdsmst_paymethod) {
		this.gdsmst_paymethod = gdsmst_paymethod;
	}
	public String getGdsmst_sndmethod() {
		return gdsmst_sndmethod;
	}
	public void setGdsmst_sndmethod(String gdsmst_sndmethod) {
		this.gdsmst_sndmethod = gdsmst_sndmethod;
	}
	public Long getGdsmst_wsalecount() {
		return gdsmst_wsalecount;
	}
	public void setGdsmst_wsalecount(Long gdsmst_wsalecount) {
		this.gdsmst_wsalecount = gdsmst_wsalecount;
	}	
	public Long getGdsmst_salecount() {
		return gdsmst_salecount;
	}
	public void setGdsmst_salecount(Long gdsmst_salecount) {
		this.gdsmst_salecount = gdsmst_salecount;
	}
	public Long getGdsmst_sendcount() {
		return gdsmst_sendcount;
	}
	public void setGdsmst_sendcount(Long gdsmst_sendcount) {
		this.gdsmst_sendcount = gdsmst_sendcount;
	}
	public String getGdsmst_handworkurl() {
		return gdsmst_handworkurl;
	}
	public void setGdsmst_handworkurl(String gdsmst_handworkurl) {
		this.gdsmst_handworkurl = gdsmst_handworkurl;
	}
	public String getGdsmst_title() {
		return gdsmst_title;
	}
	public void setGdsmst_title(String gdsmst_title) {
		this.gdsmst_title = gdsmst_title;
	}
	public String getGdsmst_tktdesc() {
		return gdsmst_tktdesc;
	}
	public void setGdsmst_tktdesc(String gdsmst_tktdesc) {
		this.gdsmst_tktdesc = gdsmst_tktdesc;
	}
	public String getGdsmst_inputmngid() {
		return gdsmst_inputmngid;
	}
	public void setGdsmst_inputmngid(String gdsmst_inputmngid) {
		this.gdsmst_inputmngid = gdsmst_inputmngid;
	}
	public Long getGdsmst_stock() {
		return gdsmst_stock;
	}
	public void setGdsmst_stock(Long gdsmst_stock) {
		this.gdsmst_stock = gdsmst_stock;
	}
	public Float getGdsmst_taxfee() {
		return gdsmst_taxfee;
	}
	public void setGdsmst_taxfee(Float gdsmst_taxfee) {
		this.gdsmst_taxfee = gdsmst_taxfee;
	}
	public Float getGdsmst_Insurancefee() {
		return gdsmst_Insurancefee;
	}
	public void setGdsmst_Insurancefee(Float gdsmst_Insurancefee) {
		this.gdsmst_Insurancefee = gdsmst_Insurancefee;
	}
	public Float getGdsmst_netpayfee() {
		return gdsmst_netpayfee;
	}
	public void setGdsmst_netpayfee(Float gdsmst_netpayfee) {
		this.gdsmst_netpayfee = gdsmst_netpayfee;
	}
	public Long getGdsmst_downflag() {
		return gdsmst_downflag;
	}
	public void setGdsmst_downflag(Long gdsmst_downflag) {
		this.gdsmst_downflag = gdsmst_downflag;
	}
	public String getGdsmst_provide() {
		return gdsmst_provide;
	}
	public void setGdsmst_provide(String gdsmst_provide) {
		this.gdsmst_provide = gdsmst_provide;
	}
	public Float getGdsmst_inprice() {
		return gdsmst_inprice;
	}
	public void setGdsmst_inprice(Float gdsmst_inprice) {
		this.gdsmst_inprice = gdsmst_inprice;
	}
	public Float getGdsmst_pricelev1() {
		return gdsmst_pricelev1;
	}
	public void setGdsmst_pricelev1(Float gdsmst_pricelev1) {
		this.gdsmst_pricelev1 = gdsmst_pricelev1;
	}
	public Float getGdsmst_pricelev2() {
		return gdsmst_pricelev2;
	}
	public void setGdsmst_pricelev2(Float gdsmst_pricelev2) {
		this.gdsmst_pricelev2 = gdsmst_pricelev2;
	}
	public Float getGdsmst_eyuan() {
		return gdsmst_eyuan;
	}
	public void setGdsmst_eyuan(Float gdsmst_eyuan) {
		this.gdsmst_eyuan = gdsmst_eyuan;
	}
	public String getGdsmst_srcurl1() {
		return gdsmst_srcurl1;
	}
	public void setGdsmst_srcurl1(String gdsmst_srcurl1) {
		this.gdsmst_srcurl1 = gdsmst_srcurl1;
	}
	public String getGdsmst_srcurl2() {
		return gdsmst_srcurl2;
	}
	public void setGdsmst_srcurl2(String gdsmst_srcurl2) {
		this.gdsmst_srcurl2 = gdsmst_srcurl2;
	}
	public String getGdsmst_srcurl3() {
		return gdsmst_srcurl3;
	}
	public void setGdsmst_srcurl3(String gdsmst_srcurl3) {
		this.gdsmst_srcurl3 = gdsmst_srcurl3;
	}
	public String getGdsmst_otherimg1() {
		return gdsmst_otherimg1;
	}
	public void setGdsmst_otherimg1(String gdsmst_otherimg1) {
		this.gdsmst_otherimg1 = gdsmst_otherimg1;
	}
	public String getGdsmst_otherimg2() {
		return gdsmst_otherimg2;
	}
	public void setGdsmst_otherimg2(String gdsmst_otherimg2) {
		this.gdsmst_otherimg2 = gdsmst_otherimg2;
	}
	public String getGdsmst_otherimg3() {
		return gdsmst_otherimg3;
	}
	public void setGdsmst_otherimg3(String gdsmst_otherimg3) {
		this.gdsmst_otherimg3 = gdsmst_otherimg3;
	}
	public Float getGdsmst_provide8848() {
		return gdsmst_provide8848;
	}
	public void setGdsmst_provide8848(Float gdsmst_provide8848) {
		this.gdsmst_provide8848 = gdsmst_provide8848;
	}
	public String getGdsmst_linkgds() {
		return gdsmst_linkgds;
	}
	public void setGdsmst_linkgds(String gdsmst_linkgds) {
		this.gdsmst_linkgds = gdsmst_linkgds;
	}
	public String getGdsmst_linkrck() {
		return gdsmst_linkrck;
	}
	public void setGdsmst_linkrck(String gdsmst_linkrck) {
		this.gdsmst_linkrck = gdsmst_linkrck;
	}
	public Long getGdsmst_buylimit() {
		return gdsmst_buylimit;
	}
	public void setGdsmst_buylimit(Long gdsmst_buylimit) {
		this.gdsmst_buylimit = gdsmst_buylimit;
	}
	public String getGdsmst_modimngid() {
		return gdsmst_modimngid;
	}
	public void setGdsmst_modimngid(String gdsmst_modimngid) {
		this.gdsmst_modimngid = gdsmst_modimngid;
	}
	public Float getGdsmst_oldmemberprice() {
		return gdsmst_oldmemberprice;
	}
	public void setGdsmst_oldmemberprice(Float gdsmst_oldmemberprice) {
		this.gdsmst_oldmemberprice = gdsmst_oldmemberprice;
	}
	public Float getGdsmst_oldvipprice() {
		return gdsmst_oldvipprice;
	}
	public void setGdsmst_oldvipprice(Float gdsmst_oldvipprice) {
		this.gdsmst_oldvipprice = gdsmst_oldvipprice;
	}
	public Date getGdsmst_discountenddate() {
		return gdsmst_discountenddate;
	}
	public void setGdsmst_discountenddate(Date gdsmst_discountenddate) {
		this.gdsmst_discountenddate = gdsmst_discountenddate;
	}
	public Long getGdsmst_giftselecttype() {
		return gdsmst_giftselecttype;
	}
	public void setGdsmst_giftselecttype(Long gdsmst_giftselecttype) {
		this.gdsmst_giftselecttype = gdsmst_giftselecttype;
	}
	public Float getGdsmst_spendcount() {
		return gdsmst_spendcount;
	}
	public void setGdsmst_spendcount(Float gdsmst_spendcount) {
		this.gdsmst_spendcount = gdsmst_spendcount;
	}
	public Long getGdsmst_glassflag() {
		return gdsmst_glassflag;
	}
	public void setGdsmst_glassflag(Long gdsmst_glassflag) {
		this.gdsmst_glassflag = gdsmst_glassflag;
	}
	public Long getGdsmst_specialflag() {
		return gdsmst_specialflag;
	}
	public void setGdsmst_specialflag(Long gdsmst_specialflag) {
		this.gdsmst_specialflag = gdsmst_specialflag;
	}
	public Float getGdsmst_srcprice1() {
		return gdsmst_srcprice1;
	}
	public void setGdsmst_srcprice1(Float gdsmst_srcprice1) {
		this.gdsmst_srcprice1 = gdsmst_srcprice1;
	}
	public Float getGdsmst_srcprice2() {
		return gdsmst_srcprice2;
	}
	public void setGdsmst_srcprice2(Float gdsmst_srcprice2) {
		this.gdsmst_srcprice2 = gdsmst_srcprice2;
	}
	public Float getGdsmst_srcprice3() {
		return gdsmst_srcprice3;
	}
	public void setGdsmst_srcprice3(Float gdsmst_srcprice3) {
		this.gdsmst_srcprice3 = gdsmst_srcprice3;
	}
	public Date getGdsmst_srcdate1() {
		return gdsmst_srcdate1;
	}
	public void setGdsmst_srcdate1(Date gdsmst_srcdate1) {
		this.gdsmst_srcdate1 = gdsmst_srcdate1;
	}
	public Date getGdsmst_srcdate2() {
		return gdsmst_srcdate2;
	}
	public void setGdsmst_srcdate2(Date gdsmst_srcdate2) {
		this.gdsmst_srcdate2 = gdsmst_srcdate2;
	}
	public Date getGdsmst_srcdate3() {
		return gdsmst_srcdate3;
	}
	public void setGdsmst_srcdate3(Date gdsmst_srcdate3) {
		this.gdsmst_srcdate3 = gdsmst_srcdate3;
	}
	public Long getGdsmst_srctype1() {
		return Gdsmst_srctype1;
	}
	public void setGdsmst_srctype1(Long gdsmst_srctype1) {
		Gdsmst_srctype1 = gdsmst_srctype1;
	}
	public Long getGdsmst_srctype2() {
		return Gdsmst_srctype2;
	}
	public void setGdsmst_srctype2(Long gdsmst_srctype2) {
		Gdsmst_srctype2 = gdsmst_srctype2;
	}
	public Long getGdsmst_srctype3() {
		return Gdsmst_srctype3;
	}
	public void setGdsmst_srctype3(Long gdsmst_srctype3) {
		Gdsmst_srctype3 = gdsmst_srctype3;
	}
	public Long getGdsmst_srcstatus() {
		return gdsmst_srcstatus;
	}
	public void setGdsmst_srcstatus(Long gdsmst_srcstatus) {
		this.gdsmst_srcstatus = gdsmst_srcstatus;
	}
	public Long getGdsmst_ifhavegds() {
		return gdsmst_ifhavegds;
	}
	public void setGdsmst_ifhavegds(Long gdsmst_ifhavegds) {
		this.gdsmst_ifhavegds = gdsmst_ifhavegds;
	}
	public Date getGdsmst_ifhavedate() {
		return gdsmst_ifhavedate;
	}
	public void setGdsmst_ifhavedate(Date gdsmst_ifhavedate) {
		this.gdsmst_ifhavedate = gdsmst_ifhavedate;
	}
	public Float getGdsmst_addshipfee() {
		return gdsmst_addshipfee;
	}
	public void setGdsmst_addshipfee(Float gdsmst_addshipfee) {
		this.gdsmst_addshipfee = gdsmst_addshipfee;
	}
	public String getGdsmst_provideStr() {
		return gdsmst_provideStr;
	}
	public void setGdsmst_provideStr(String gdsmst_provideStr) {
		this.gdsmst_provideStr = gdsmst_provideStr;
	}
	public String getGdsmst_barcode() {
		return gdsmst_barcode;
	}
	public void setGdsmst_barcode(String gdsmst_barcode) {
		this.gdsmst_barcode = gdsmst_barcode;
	}
	public String getGdsmst_gdssite() {
		return gdsmst_gdssite;
	}
	public void setGdsmst_gdssite(String gdsmst_gdssite) {
		this.gdsmst_gdssite = gdsmst_gdssite;
	}
	public Long getGdsmst_stocklinkty() {
		return gdsmst_stocklinkty;
	}
	public void setGdsmst_stocklinkty(Long gdsmst_stocklinkty) {
		this.gdsmst_stocklinkty = gdsmst_stocklinkty;
	}
	public Long getGdsmst_virtualstock() {
		return gdsmst_virtualstock;
	}
	public void setGdsmst_virtualstock(Long gdsmst_virtualstock) {
		this.gdsmst_virtualstock = gdsmst_virtualstock;
	}
	public String getGdsmst_ip() {
		return gdsmst_ip;
	}
	public void setGdsmst_ip(String gdsmst_ip) {
		this.gdsmst_ip = gdsmst_ip;
	}
	public Float getGdsmst_othercost() {
		return gdsmst_othercost;
	}
	public void setGdsmst_othercost(Float gdsmst_othercost) {
		this.gdsmst_othercost = gdsmst_othercost;
	}
	public String getGdsmst_layertype() {
		return gdsmst_layertype;
	}
	public void setGdsmst_layertype(String gdsmst_layertype) {
		this.gdsmst_layertype = gdsmst_layertype;
	}
	public String getGdsmst_layertitle() {
		return gdsmst_layertitle;
	}
	public void setGdsmst_layertitle(String gdsmst_layertitle) {
		this.gdsmst_layertitle = gdsmst_layertitle;
	}
	public String getGdsmst_skuname1() {
		return gdsmst_skuname1;
	}
	public void setGdsmst_skuname1(String gdsmst_skuname1) {
		this.gdsmst_skuname1 = gdsmst_skuname1;
	}
	public String getGdsmst_skuname2() {
		return gdsmst_skuname2;
	}
	public void setGdsmst_skuname2(String gdsmst_skuname2) {
		this.gdsmst_skuname2 = gdsmst_skuname2;
	}
	public Long getGdsmst_sex() {
		return gdsmst_sex;
	}
	public void setGdsmst_sex(Long gdsmst_sex) {
		this.gdsmst_sex = gdsmst_sex;
	}
	public String getGdsmst_atts() {
		return gdsmst_atts;
	}
	public void setGdsmst_atts(String gdsmst_atts) {
		this.gdsmst_atts = gdsmst_atts;
	}
	public Date getGdsmst_autoupdatedate() {
		return gdsmst_autoupdatedate;
	}
	public void setGdsmst_autoupdatedate(Date gdsmst_autoupdatedate) {
		this.gdsmst_autoupdatedate = gdsmst_autoupdatedate;
	}
	public String getGdsmst_autopageurl() {
		return gdsmst_autopageurl;
	}
	public void setGdsmst_autopageurl(String gdsmst_autopageurl) {
		this.gdsmst_autopageurl = gdsmst_autopageurl;
	}
	public Long getGdsmst_airflag() {
		return gdsmst_airflag;
	}
	public void setGdsmst_airflag(Long gdsmst_airflag) {
		this.gdsmst_airflag = gdsmst_airflag;
	}
	public Date getGdsmst_validdate() {
		return gdsmst_validdate;
	}
	public void setGdsmst_validdate(Date gdsmst_validdate) {
		this.gdsmst_validdate = gdsmst_validdate;
	}
	public String getGdsmst_midimg() {
		return gdsmst_midimg;
	}
	public void setGdsmst_midimg(String gdsmst_midimg) {
		this.gdsmst_midimg = gdsmst_midimg;
	}
	public String getGdsmst_recimg() {
		return gdsmst_recimg;
	}
	public void setGdsmst_recimg(String gdsmst_recimg) {
		this.gdsmst_recimg = gdsmst_recimg;
	}
	public String getGdsmst_fzimg() {
		return gdsmst_fzimg;
	}
	public void setGdsmst_fzimg(String gdsmst_fzimg) {
		this.gdsmst_fzimg = gdsmst_fzimg;
	}
	public String getGdsmst_img200250() {
		return gdsmst_img200250;
	}
	public void setGdsmst_img200250(String gdsmst_img200250) {
		this.gdsmst_img200250 = gdsmst_img200250;
	}
	public String getGdsmst_img240300() {
		return gdsmst_img240300;
	}
	public void setGdsmst_img240300(String gdsmst_img240300) {
		this.gdsmst_img240300 = gdsmst_img240300;
	}
	public String getGdsmst_img310() {
		return gdsmst_img310;
	}
	public void setGdsmst_img310(String gdsmst_img310) {
		this.gdsmst_img310 = gdsmst_img310;
	}
	public Long getGdsmst_sizeid() {
		return gdsmst_sizeid;
	}
	public void setGdsmst_sizeid(Long gdsmst_sizeid) {
		this.gdsmst_sizeid = gdsmst_sizeid;
	}
	public String getGdsmst_gdscoll() {
		return gdsmst_gdscoll;
	}
	public void setGdsmst_gdscoll(String gdsmst_gdscoll) {
		this.gdsmst_gdscoll = gdsmst_gdscoll;
	}

	public Long getGdsmst_mwgid() {
		return gdsmst_mwgid;
	}
	public void setGdsmst_mwgid(Long gdsmst_mwgid) {
		this.gdsmst_mwgid = gdsmst_mwgid;
	}
	public Long getGdssmt_wwgid() {
		return gdssmt_wwgid;
	}
	public void setGdssmt_wwgid(Long gdssmt_wwgid) {
		this.gdssmt_wwgid = gdssmt_wwgid;
	}
	public String getGdsmst_gzgdssite() {
		return gdsmst_gzgdssite;
	}
	public void setGdsmst_gzgdssite(String gdsmst_gzgdssite) {
		this.gdsmst_gzgdssite = gdsmst_gzgdssite;
	}
	public String getGdsmst_shoprck() {
		return gdsmst_shoprck;
	}
	public void setGdsmst_shoprck(String gdsmst_shoprck) {
		this.gdsmst_shoprck = gdsmst_shoprck;
	}
	public Float getGdsmst_msprice() {
		return gdsmst_msprice;
	}
	public void setGdsmst_msprice(Float gdsmst_msprice) {
		this.gdsmst_msprice = gdsmst_msprice;
	}
	public Float getGdsmst_sortxs() {
		return gdsmst_sortxs;
	}
	public void setGdsmst_sortxs(Float gdsmst_sortxs) {
		this.gdsmst_sortxs = gdsmst_sortxs;
	}
	public Long getGdsmst_sortxsv() {
		return gdsmst_sortxsv;
	}
	public void setGdsmst_sortxsv(Long gdsmst_sortxsv) {
		this.gdsmst_sortxsv = gdsmst_sortxsv;
	}
	
}
