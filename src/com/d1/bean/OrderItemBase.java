package com.d1.bean;

import java.util.Date;

import javax.persistence.MappedSuperclass;

import com.d1.dbcache.core.BaseEntity;

/**
 * 订单明细表基类
 * @author kk
 *
 */
@MappedSuperclass
public abstract class OrderItemBase extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	private String odrdtl_odrid;
	private String odrdtl_gdsid;
	private String odrdtl_shopcode = "00000000";//d1自己的shopcode
	private String odrdtl_shopname = "D1便利网自行发货";
	private String odrdtl_gdsname = "";
	private Long odrdtl_buystep;
	private String odrdtl_buyway = "";
	private Double odrdtl_memberprice;
	/**
	 * 记录是否是百分点来源的订单
	 */
	private String odrdtl_bfdtemp  = "";
	
	private Double odrdtl_saleprice;
	private Double odrdtl_vipprice;
	
	/**
	 * 成交单价
	 */
	private Double odrdtl_finalprice;
	private Long odrdtl_gdscount;
	private Double odrdtl_totalmoney;
	private Long odrdtl_incometype = new Long(0);
	private Double odrdtl_incomevalue = new Double(0);
	private Double odrdtl_totalincomevalue = new Double(0);
	private String odrdtl_stddetail1 = "";
	private String odrdtl_stddetail2 = "";
	private String odrdtl_stddetail3 = "";
	private String odrdtl_stddetail4 = "";
	private String odrdtl_stddetail5 = "";
	private String odrdtl_stddetail6 = "";
	private String odrdtl_stddetail7 = "";
	private String odrdtl_stddetail8 = "";
	private String odrdtl_stddetail9 = "";
	
	/**
	 * 发货状态（1：未发；2：部分发 3：全发 -2：用户取消 -1：缺货取消）
	 */
	private Long odrdtl_shipstatus = new Long(1);
	private Long odrdtl_sendcount = new Long(0);
	private Long odrdtl_presellflag = new Long(0);
	private Date odrdtl_creatdate;
	private String odrdtl_rackcode = "";
	private String odrdtl_promotionword = "";
	private Long odrdtl_refundcount = new Long(0);
	private Long odrdtl_weight = new Long(0);
	private String odrdtl_discdesc = "";
	private Double odrdtl_taxfee = new Double(0);
	private Double odrdtl_insurancefee = new Double(0);//现在用于联盟佣金比例（聚会平台）
	private Double odrdtl_netpayfee = new Double(0);
	private Long odrdtl_downflag = new Long(0);
	private String odrdtl_purcode = "";
	private Long odrdtl_purcount = new Long(0);
	private Double odrdtl_purprice = new Double(0);
	private String odrdtl_purmemo = "";
	
	/**
	 * 采购单状态
	 */
	private Long odrdtl_purtype = new Long(0);
	private String odrdtl_purshopcode = "";
	private String odrdtl_oldpurshopcode = "";
	private String odrdtl_puraddr = "";
	private String odrdtl_purperson = "";
	private Long odrdtl_buyflag = new Long(0);
	private String odrdtl_managememo = "";
	private Date odrdtl_purcreatedate;
	private Date odrdtl_purvaliddate;
	private Date odrdtl_purbegindate;
	private Date odrdtl_purenddate;
	private String odrdtl_purvalidpeople = "";
	private String odrdtl_temp = "";
	private Double odrdtl_eyuan = new Double(0);
	private Date odrdtl_purstockdate;
	private String odrdtl_purcheckpeople = "";
	private Long odrdtl_twopurreason = new Long(0);
	private Double odrdtl_spendcount = new Double(0);
	private Long odrdtl_specialflag = new Long(0);
	private Long odrdtl_phflag = new Long(0);
	private String odrdtl_gdspurmemo = "";
	private String odrdtl_gifttype = "";
	private Long odrdtl_servicerack = new Long(0);
	private Long odrdtl_examineflag = new Long(0);
	private Double odrdtl_addshipfee = new Double(0);
	private Long odrdtl_refcount = new Long(0);
	private Long odrdtl_jcflag = new Long(0);
	private Date odrdtl_realshipdate;
	private String odrdtl_phday = "";
	private Date odrdtl_phtime;
	private String odrdtl_phpeople = "";
	private String odrdtl_purstockpeople = "";
	private String odrdtl_log = "";
	private String odrdtl_egblancecode = "";
	private Long odrdtl_egblancetype = new Long(0);
	private Double odrdtl_lmcommision = new Double(0);
	private String odrdtl_aspmemo ="";
	private String odrdtl_sku1 = "";
	private String odrdtl_sku2 = "";
	private Date odrdtl_atophtime;
	private String odrdtl_tuancardno = "";
	private String  odrdtl_referer="";
	private String odrdtl_oldodrid;
	private Long odrdtl_phstatus = new Long(0);
	
	private Long odrdtl_actid=new Long(0);
	private Long odrdtl_actmoney=new Long(0);
	private String odrdtl_actmemo;
	public String getOdrdtl_odrid() {
		return odrdtl_odrid;
	}
	public void setOdrdtl_odrid(String odrdtl_odrid) {
		this.odrdtl_odrid = odrdtl_odrid;
	}
	public String getOdrdtl_gdsid() {
		return odrdtl_gdsid;
	}
	public void setOdrdtl_gdsid(String odrdtl_gdsid) {
		this.odrdtl_gdsid = odrdtl_gdsid;
	}
	public String getOdrdtl_shopcode() {
		return odrdtl_shopcode;
	}
	public void setOdrdtl_shopcode(String odrdtl_shopcode) {
		this.odrdtl_shopcode = odrdtl_shopcode;
	}
	public String getOdrdtl_shopname() {
		return odrdtl_shopname;
	}
	public void setOdrdtl_shopname(String odrdtl_shopname) {
		this.odrdtl_shopname = odrdtl_shopname;
	}
	public String getOdrdtl_gdsname() {
		return odrdtl_gdsname;
	}
	public void setOdrdtl_gdsname(String odrdtl_gdsname) {
		this.odrdtl_gdsname = odrdtl_gdsname;
	}
	public Long getOdrdtl_buystep() {
		return odrdtl_buystep;
	}
	public void setOdrdtl_buystep(Long odrdtl_buystep) {
		this.odrdtl_buystep = odrdtl_buystep;
	}
	public String getOdrdtl_buyway() {
		return odrdtl_buyway;
	}
	public void setOdrdtl_buyway(String odrdtl_buyway) {
		this.odrdtl_buyway = odrdtl_buyway;
	}
	public Double getOdrdtl_memberprice() {
		return odrdtl_memberprice;
	}
	public void setOdrdtl_memberprice(Double odrdtl_memberprice) {
		this.odrdtl_memberprice = odrdtl_memberprice;
	}
	public Double getOdrdtl_saleprice() {
		return odrdtl_saleprice;
	}
	public void setOdrdtl_saleprice(Double odrdtl_saleprice) {
		this.odrdtl_saleprice = odrdtl_saleprice;
	}
	public Double getOdrdtl_vipprice() {
		return odrdtl_vipprice;
	}
	public void setOdrdtl_vipprice(Double odrdtl_vipprice) {
		this.odrdtl_vipprice = odrdtl_vipprice;
	}
	public Double getOdrdtl_finalprice() {
		return odrdtl_finalprice;
	}
	public void setOdrdtl_finalprice(Double odrdtl_finalprice) {
		this.odrdtl_finalprice = odrdtl_finalprice;
	}
	public Long getOdrdtl_gdscount() {
		return odrdtl_gdscount;
	}
	public void setOdrdtl_gdscount(Long odrdtl_gdscount) {
		this.odrdtl_gdscount = odrdtl_gdscount;
	}
	public Double getOdrdtl_totalmoney() {
		return odrdtl_totalmoney;
	}
	public void setOdrdtl_totalmoney(Double odrdtl_totalmoney) {
		this.odrdtl_totalmoney = odrdtl_totalmoney;
	}
	public Long getOdrdtl_incometype() {
		return odrdtl_incometype;
	}
	public void setOdrdtl_incometype(Long odrdtl_incometype) {
		this.odrdtl_incometype = odrdtl_incometype;
	}
	public Double getOdrdtl_incomevalue() {
		return odrdtl_incomevalue;
	}
	public void setOdrdtl_incomevalue(Double odrdtl_incomevalue) {
		this.odrdtl_incomevalue = odrdtl_incomevalue;
	}
	public Double getOdrdtl_totalincomevalue() {
		return odrdtl_totalincomevalue;
	}
	public void setOdrdtl_totalincomevalue(Double odrdtl_totalincomevalue) {
		this.odrdtl_totalincomevalue = odrdtl_totalincomevalue;
	}
	public String getOdrdtl_stddetail1() {
		return odrdtl_stddetail1;
	}
	public void setOdrdtl_stddetail1(String odrdtl_stddetail1) {
		this.odrdtl_stddetail1 = odrdtl_stddetail1;
	}
	public String getOdrdtl_stddetail2() {
		return odrdtl_stddetail2;
	}
	public void setOdrdtl_stddetail2(String odrdtl_stddetail2) {
		this.odrdtl_stddetail2 = odrdtl_stddetail2;
	}
	public String getOdrdtl_stddetail3() {
		return odrdtl_stddetail3;
	}
	public void setOdrdtl_stddetail3(String odrdtl_stddetail3) {
		this.odrdtl_stddetail3 = odrdtl_stddetail3;
	}
	public String getOdrdtl_stddetail4() {
		return odrdtl_stddetail4;
	}
	public void setOdrdtl_stddetail4(String odrdtl_stddetail4) {
		this.odrdtl_stddetail4 = odrdtl_stddetail4;
	}
	public String getOdrdtl_stddetail5() {
		return odrdtl_stddetail5;
	}
	public void setOdrdtl_stddetail5(String odrdtl_stddetail5) {
		this.odrdtl_stddetail5 = odrdtl_stddetail5;
	}
	public String getOdrdtl_stddetail6() {
		return odrdtl_stddetail6;
	}
	public void setOdrdtl_stddetail6(String odrdtl_stddetail6) {
		this.odrdtl_stddetail6 = odrdtl_stddetail6;
	}
	public String getOdrdtl_stddetail7() {
		return odrdtl_stddetail7;
	}
	public void setOdrdtl_stddetail7(String odrdtl_stddetail7) {
		this.odrdtl_stddetail7 = odrdtl_stddetail7;
	}
	public String getOdrdtl_stddetail8() {
		return odrdtl_stddetail8;
	}
	public void setOdrdtl_stddetail8(String odrdtl_stddetail8) {
		this.odrdtl_stddetail8 = odrdtl_stddetail8;
	}
	public String getOdrdtl_stddetail9() {
		return odrdtl_stddetail9;
	}
	public void setOdrdtl_stddetail9(String odrdtl_stddetail9) {
		this.odrdtl_stddetail9 = odrdtl_stddetail9;
	}
	public Long getOdrdtl_shipstatus() {
		return odrdtl_shipstatus;
	}
	public void setOdrdtl_shipstatus(Long odrdtl_shipstatus) {
		this.odrdtl_shipstatus = odrdtl_shipstatus;
	}
	public Long getOdrdtl_sendcount() {
		return odrdtl_sendcount;
	}
	public void setOdrdtl_sendcount(Long odrdtl_sendcount) {
		this.odrdtl_sendcount = odrdtl_sendcount;
	}
	public Long getOdrdtl_presellflag() {
		return odrdtl_presellflag;
	}
	public void setOdrdtl_presellflag(Long odrdtl_presellflag) {
		this.odrdtl_presellflag = odrdtl_presellflag;
	}
	public Date getOdrdtl_creatdate() {
		return odrdtl_creatdate;
	}
	public void setOdrdtl_creatdate(Date odrdtl_creatdate) {
		this.odrdtl_creatdate = odrdtl_creatdate;
	}
	public String getOdrdtl_rackcode() {
		return odrdtl_rackcode;
	}
	public void setOdrdtl_rackcode(String odrdtl_rackcode) {
		this.odrdtl_rackcode = odrdtl_rackcode;
	}
	public String getOdrdtl_promotionword() {
		return odrdtl_promotionword;
	}
	public void setOdrdtl_promotionword(String odrdtl_promotionword) {
		this.odrdtl_promotionword = odrdtl_promotionword;
	}
	public Long getOdrdtl_refundcount() {
		return odrdtl_refundcount;
	}
	public void setOdrdtl_refundcount(Long odrdtl_refundcount) {
		this.odrdtl_refundcount = odrdtl_refundcount;
	}
	public Long getOdrdtl_weight() {
		return odrdtl_weight;
	}
	public void setOdrdtl_weight(Long odrdtl_weight) {
		this.odrdtl_weight = odrdtl_weight;
	}
	public String getOdrdtl_discdesc() {
		return odrdtl_discdesc;
	}
	public void setOdrdtl_discdesc(String odrdtl_discdesc) {
		this.odrdtl_discdesc = odrdtl_discdesc;
	}
	public Double getOdrdtl_taxfee() {
		return odrdtl_taxfee;
	}
	public void setOdrdtl_taxfee(Double odrdtl_taxfee) {
		this.odrdtl_taxfee = odrdtl_taxfee;
	}
	public Double getOdrdtl_insurancefee() {
		return odrdtl_insurancefee;
	}
	public void setOdrdtl_insurancefee(Double odrdtl_insurancefee) {
		this.odrdtl_insurancefee = odrdtl_insurancefee;
	}
	public Double getOdrdtl_netpayfee() {
		return odrdtl_netpayfee;
	}
	public void setOdrdtl_netpayfee(Double odrdtl_netpayfee) {
		this.odrdtl_netpayfee = odrdtl_netpayfee;
	}
	public Long getOdrdtl_downflag() {
		return odrdtl_downflag;
	}
	public void setOdrdtl_downflag(Long odrdtl_downflag) {
		this.odrdtl_downflag = odrdtl_downflag;
	}
	public String getOdrdtl_purcode() {
		return odrdtl_purcode;
	}
	public void setOdrdtl_purcode(String odrdtl_purcode) {
		this.odrdtl_purcode = odrdtl_purcode;
	}
	public Long getOdrdtl_purcount() {
		return odrdtl_purcount;
	}
	public void setOdrdtl_purcount(Long odrdtl_purcount) {
		this.odrdtl_purcount = odrdtl_purcount;
	}
	public Double getOdrdtl_purprice() {
		return odrdtl_purprice;
	}
	public void setOdrdtl_purprice(Double odrdtl_purprice) {
		this.odrdtl_purprice = odrdtl_purprice;
	}
	public String getOdrdtl_purmemo() {
		return odrdtl_purmemo;
	}
	public void setOdrdtl_purmemo(String odrdtl_purmemo) {
		this.odrdtl_purmemo = odrdtl_purmemo;
	}
	public Long getOdrdtl_purtype() {
		return odrdtl_purtype;
	}
	public void setOdrdtl_purtype(Long odrdtl_purtype) {
		this.odrdtl_purtype = odrdtl_purtype;
	}
	public String getOdrdtl_purshopcode() {
		return odrdtl_purshopcode;
	}
	public void setOdrdtl_purshopcode(String odrdtl_purshopcode) {
		this.odrdtl_purshopcode = odrdtl_purshopcode;
	}
	public String getOdrdtl_oldpurshopcode() {
		return odrdtl_oldpurshopcode;
	}
	public void setOdrdtl_oldpurshopcode(String odrdtl_oldpurshopcode) {
		this.odrdtl_oldpurshopcode = odrdtl_oldpurshopcode;
	}
	public String getOdrdtl_puraddr() {
		return odrdtl_puraddr;
	}
	public void setOdrdtl_puraddr(String odrdtl_puraddr) {
		this.odrdtl_puraddr = odrdtl_puraddr;
	}
	public String getOdrdtl_purperson() {
		return odrdtl_purperson;
	}
	public void setOdrdtl_purperson(String odrdtl_purperson) {
		this.odrdtl_purperson = odrdtl_purperson;
	}
	public Long getOdrdtl_buyflag() {
		return odrdtl_buyflag;
	}
	public void setOdrdtl_buyflag(Long odrdtl_buyflag) {
		this.odrdtl_buyflag = odrdtl_buyflag;
	}
	public String getOdrdtl_managememo() {
		return odrdtl_managememo;
	}
	public void setOdrdtl_managememo(String odrdtl_managememo) {
		this.odrdtl_managememo = odrdtl_managememo;
	}
	public Date getOdrdtl_purcreatedate() {
		return odrdtl_purcreatedate;
	}
	public void setOdrdtl_purcreatedate(Date odrdtl_purcreatedate) {
		this.odrdtl_purcreatedate = odrdtl_purcreatedate;
	}
	public Date getOdrdtl_purvaliddate() {
		return odrdtl_purvaliddate;
	}
	public void setOdrdtl_purvaliddate(Date odrdtl_purvaliddate) {
		this.odrdtl_purvaliddate = odrdtl_purvaliddate;
	}
	public Date getOdrdtl_purbegindate() {
		return odrdtl_purbegindate;
	}
	public void setOdrdtl_purbegindate(Date odrdtl_purbegindate) {
		this.odrdtl_purbegindate = odrdtl_purbegindate;
	}
	public Date getOdrdtl_purenddate() {
		return odrdtl_purenddate;
	}
	public void setOdrdtl_purenddate(Date odrdtl_purenddate) {
		this.odrdtl_purenddate = odrdtl_purenddate;
	}
	public String getOdrdtl_purvalidpeople() {
		return odrdtl_purvalidpeople;
	}
	public void setOdrdtl_purvalidpeople(String odrdtl_purvalidpeople) {
		this.odrdtl_purvalidpeople = odrdtl_purvalidpeople;
	}
	public String getOdrdtl_temp() {
		return odrdtl_temp;
	}
	public void setOdrdtl_temp(String odrdtl_temp) {
		this.odrdtl_temp = odrdtl_temp;
	}
	public Double getOdrdtl_eyuan() {
		return odrdtl_eyuan;
	}
	public void setOdrdtl_eyuan(Double odrdtl_eyuan) {
		this.odrdtl_eyuan = odrdtl_eyuan;
	}
	public Date getOdrdtl_purstockdate() {
		return odrdtl_purstockdate;
	}
	public void setOdrdtl_purstockdate(Date odrdtl_purstockdate) {
		this.odrdtl_purstockdate = odrdtl_purstockdate;
	}
	public String getOdrdtl_purcheckpeople() {
		return odrdtl_purcheckpeople;
	}
	public void setOdrdtl_purcheckpeople(String odrdtl_purcheckpeople) {
		this.odrdtl_purcheckpeople = odrdtl_purcheckpeople;
	}
	public Long getOdrdtl_twopurreason() {
		return odrdtl_twopurreason;
	}
	public void setOdrdtl_twopurreason(Long odrdtl_twopurreason) {
		this.odrdtl_twopurreason = odrdtl_twopurreason;
	}
	public Double getOdrdtl_spendcount() {
		return odrdtl_spendcount;
	}
	public void setOdrdtl_spendcount(Double odrdtl_spendcount) {
		this.odrdtl_spendcount = odrdtl_spendcount;
	}
	public Long getOdrdtl_specialflag() {
		return odrdtl_specialflag;
	}
	public void setOdrdtl_specialflag(Long odrdtl_specialflag) {
		this.odrdtl_specialflag = odrdtl_specialflag;
	}
	public Long getOdrdtl_phflag() {
		return odrdtl_phflag;
	}
	public void setOdrdtl_phflag(Long odrdtl_phflag) {
		this.odrdtl_phflag = odrdtl_phflag;
	}
	public String getOdrdtl_gdspurmemo() {
		return odrdtl_gdspurmemo;
	}
	public void setOdrdtl_gdspurmemo(String odrdtl_gdspurmemo) {
		this.odrdtl_gdspurmemo = odrdtl_gdspurmemo;
	}
	public String getOdrdtl_gifttype() {
		return odrdtl_gifttype;
	}
	public void setOdrdtl_gifttype(String odrdtl_gifttype) {
		this.odrdtl_gifttype = odrdtl_gifttype;
	}
	public Long getOdrdtl_servicerack() {
		return odrdtl_servicerack;
	}
	public void setOdrdtl_servicerack(Long odrdtl_servicerack) {
		this.odrdtl_servicerack = odrdtl_servicerack;
	}
	public Long getOdrdtl_examineflag() {
		return odrdtl_examineflag;
	}
	public void setOdrdtl_examineflag(Long odrdtl_examineflag) {
		this.odrdtl_examineflag = odrdtl_examineflag;
	}
	public Double getOdrdtl_addshipfee() {
		return odrdtl_addshipfee;
	}
	public void setOdrdtl_addshipfee(Double odrdtl_addshipfee) {
		this.odrdtl_addshipfee = odrdtl_addshipfee;
	}
	public Long getOdrdtl_refcount() {
		return odrdtl_refcount;
	}
	public void setOdrdtl_refcount(Long odrdtl_refcount) {
		this.odrdtl_refcount = odrdtl_refcount;
	}
	public Long getOdrdtl_jcflag() {
		return odrdtl_jcflag;
	}
	public void setOdrdtl_jcflag(Long odrdtl_jcflag) {
		this.odrdtl_jcflag = odrdtl_jcflag;
	}
	public Date getOdrdtl_realshipdate() {
		return odrdtl_realshipdate;
	}
	public void setOdrdtl_realshipdate(Date odrdtl_realshipdate) {
		this.odrdtl_realshipdate = odrdtl_realshipdate;
	}
	public String getOdrdtl_phday() {
		return odrdtl_phday;
	}
	public void setOdrdtl_phday(String odrdtl_phday) {
		this.odrdtl_phday = odrdtl_phday;
	}
	public Date getOdrdtl_phtime() {
		return odrdtl_phtime;
	}
	public void setOdrdtl_phtime(Date odrdtl_phtime) {
		this.odrdtl_phtime = odrdtl_phtime;
	}
	public String getOdrdtl_phpeople() {
		return odrdtl_phpeople;
	}
	public void setOdrdtl_phpeople(String odrdtl_phpeople) {
		this.odrdtl_phpeople = odrdtl_phpeople;
	}
	public String getOdrdtl_purstockpeople() {
		return odrdtl_purstockpeople;
	}
	public void setOdrdtl_purstockpeople(String odrdtl_purstockpeople) {
		this.odrdtl_purstockpeople = odrdtl_purstockpeople;
	}
	public String getOdrdtl_log() {
		return odrdtl_log;
	}
	public void setOdrdtl_log(String odrdtl_log) {
		this.odrdtl_log = odrdtl_log;
	}
	public String getOdrdtl_egblancecode() {
		return odrdtl_egblancecode;
	}
	public void setOdrdtl_egblancecode(String odrdtl_egblancecode) {
		this.odrdtl_egblancecode = odrdtl_egblancecode;
	}
	public Long getOdrdtl_egblancetype() {
		return odrdtl_egblancetype;
	}
	public void setOdrdtl_egblancetype(Long odrdtl_egblancetype) {
		this.odrdtl_egblancetype = odrdtl_egblancetype;
	}
	public Double getOdrdtl_lmcommision() {
		return odrdtl_lmcommision;
	}
	public void setOdrdtl_lmcommision(Double odrdtl_lmcommision) {
		this.odrdtl_lmcommision = odrdtl_lmcommision;
	}
	public String getOdrdtl_aspmemo() {
		return odrdtl_aspmemo;
	}
	public void setOdrdtl_aspmemo(String odrdtl_aspmemo) {
		this.odrdtl_aspmemo = odrdtl_aspmemo;
	}
	public String getOdrdtl_sku1() {
		return odrdtl_sku1;
	}
	public void setOdrdtl_sku1(String odrdtl_sku1) {
		this.odrdtl_sku1 = odrdtl_sku1;
	}
	public String getOdrdtl_sku2() {
		return odrdtl_sku2;
	}
	public void setOdrdtl_sku2(String odrdtl_sku2) {
		this.odrdtl_sku2 = odrdtl_sku2;
	}
	public Date getOdrdtl_atophtime() {
		return odrdtl_atophtime;
	}
	public void setOdrdtl_atophtime(Date odrdtl_atophtime) {
		this.odrdtl_atophtime = odrdtl_atophtime;
	}
	public String getOdrdtl_tuancardno() {
		return odrdtl_tuancardno;
	}
	public void setOdrdtl_tuancardno(String odrdtl_tuancardno) {
		this.odrdtl_tuancardno = odrdtl_tuancardno;
	}
	public String getOdrdtl_bfdtemp() {
		return odrdtl_bfdtemp;
	}
	public void setOdrdtl_bfdtemp(String odrdtl_bfdtemp) {
		this.odrdtl_bfdtemp = odrdtl_bfdtemp;
	}
	public String getOdrdtl_referer() {
		return odrdtl_referer;
	}
	public void setOdrdtl_referer(String odrdtl_referer) {
		this.odrdtl_referer = odrdtl_referer;
	}
	public String getOdrdtl_oldodrid() {
		return odrdtl_oldodrid;
	}
	public void setOdrdtl_oldodrid(String odrdtl_oldodrid) {
		this.odrdtl_oldodrid = odrdtl_oldodrid;
	}
	public Long getOdrdtl_phstatus() {
		return odrdtl_phstatus;
	}
	public void setOdrdtl_phstatus(Long odrdtl_phstatus) {
		this.odrdtl_phstatus = odrdtl_phstatus;
	}
	public Long getOdrdtl_actid() {
		return odrdtl_actid;
	}
	public void setOdrdtl_actid(Long odrdtl_actid) {
		this.odrdtl_actid = odrdtl_actid;
	}
	public Long getOdrdtl_actmoney() {
		return odrdtl_actmoney;
	}
	public void setOdrdtl_actmoney(Long odrdtl_actmoney) {
		this.odrdtl_actmoney = odrdtl_actmoney;
	}
	public String getOdrdtl_actmemo() {
		return odrdtl_actmemo;
	}
	public void setOdrdtl_actmemo(String odrdtl_actmemo) {
		this.odrdtl_actmemo = odrdtl_actmemo;
	}
}
