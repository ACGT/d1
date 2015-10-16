package com.d1.bean;

import java.util.Date;

import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import com.d1.dbcache.core.BaseEntity;

/**
 * ���������࣬��¼�����ֶ�.
 * @author kk
 *
 */
@MappedSuperclass
public abstract class OrderBase extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * id��ͨ��sequence�����������SequenceIdGenerator.generate("4")����
	 */
	private Long odrmst_id;
	
	/**
	 * ��Աid������
	 */
	private Long odrmst_mbrid;
	
	/**
	 * �ջ�����Ϣ
	 */
	private String odrmst_rname = "";
	private String odrmst_rsex = "";
	private String odrmst_rzipcode = "";
	private String odrmst_raddress = "";
	private String odrmst_rphone = "";
	private String odrmst_remail = "";
	private String odrmst_rcountry = "";
	private String odrmst_rprovince = "";
	private String odrmst_rcity = "";
	
	/**
	 * ��������Ϣ
	 */
	private String odrmst_pname = "";
	private String odrmst_psex = "";
	private String odrmst_pzipcode = "";
	private String odrmst_paddress = "";
	private String odrmst_pcountry = "";
	private String odrmst_pprovince = "";
	private String odrmst_pcity = "";
	private String odrmst_pophone = "";
	private String odrmst_phphone = "";
	private String odrmst_pmphone = "";
	private String odrmst_pusephone = "";
	private String odrmst_pemail = "";
	private String odrmst_pbp = "";
	private Double odrmst_fee = new Double(0);
	/**
	 * ֧����ʽ��ţ���Ӧpaymst_payid��
	 */
	private Long odrmst_payid = new Long(0);
	
	/**
	 * ֧����ʽ����Ӧpaymst_name��
	 */
	private String odrmst_paymethod = "";
	
	/**
	 * ֧����ʽ���ͣ���Ӧpaymst_type��
	 */
	private Long odrmst_paytype = new Long(0);
	
	/**
	 * ������ʽ��ţ���Ӧsndmst_shipid����Ĭ�Ͽ������
	 */
	private Long odrmst_shipid = new Long(10);
	
	/**
	 * ������ʽ����Ӧsndmst_shipname��
	 */
	private String odrmst_shipmethod = "";
	
	/**
	 * ��Ʒ���
	 */
	private Double odrmst_gdsmoney = new Double(0);
	
	/**
	 * �˷�
	 */
	private Double odrmst_shipfee = new Double(0);
	
	/**
	 * �������̵ļ��з��ã����ڲ����ˣ������ֶΣ�
	 */
	private Double odrmst_centerfee = new Double(0);
	
	/**
	 * �����ܽ��
	 */
	private Double odrmst_ordermoney = new Double(0);
	
	/**
	 * ��������
	 */
	private Date odrmst_orderdate = new Date();
	
	/**
	 * ����״̬��0��δ����  1��������ȷ�� 2���ѵ��� 3��ȫ������ 31�����ַ��� 5��ȫ��������� 51�����ֽ������ 6��ϵͳ����ȫ��������� 61��ϵͳ���ò��ֽ������ -1���û�ȡ�� -2��ȱ��ȡ����
	 */
	private Long odrmst_orderstatus = new Long(0);
	
	/**
	 * ȷ�϶�������
	 */
	private Date odrmst_affirmdate;
	
	/**
	 * �տ���=Eȯ���+Ԥ���
	 */
	private Double odrmst_getmoney = new Double(0);
	
	/**
	 * �Ƿ�������ջ�
	 */
	private Long odrmst_rthird = new Long(0);
	
	/**
	 * �û�����
	 */
	private String odrmst_customerword = "";
	
	/**
	 * ʵ��Ӧ�ս��û�ʵ��Ӧ�ý���D1��Ǯ�Ƕ��٣���������Ҫ����eȯ�ģ�
	 */
	private Double odrmst_acturepaymoney = new Double(0);
	
	/**
	 * δ֪
	 */
	private Double odrmst_acturecollectmoney = new Double(0);
	
	/**
	 * ��Ʊ��־������û�õ���
	 */
	private Long odrmst_invoiceflag = new Long(0);
	
	/**
	 * D1�����̻����ͻ�������
	 */
	private String odrmst_ourmemo = "";
	
	/**
	 * D1���ڲ����ԣ��û���������
	 */
	private String odrmst_internalmemo = "";
	
	/**
	 * D1ʵ���������ã��ͻ������ʼĵķ��ã�
	 */
	private Double odrmst_d1fee = new Double(0);
	
	/**
	 * �˿�״̬����0��1��11���֣����庬��δ֪��
	 */
	private Long odrmst_refundmentstatus = new Long(0);
	
	/**
	 * �˿���
	 */
	private Double odrmst_refundmentmoney = new Double(0);
	
	/**
	 * ����ת��״̬��ֻ������e8�Ķ�������Ҫת����
	 */
	private Long odrmst_tsmstatus = new Long(0);
	
	/**
	 * ����ת��ʱ��
	 */
	private Date odrmst_tsmtime;
	
	/**
	 * ȡ��ʱ��
	 */
	private Date odrmst_canceldate;
	
	/**
	 * ���ʱ��
	 */
	private Date odrmst_finishdate;
	
	/**
	 * ����ȷ����Ч�����ڣ��տ���߻���ȷ�ϣ�
	 */
	private Date odrmst_validdate;
	
	/**
	 * ����û��
	 */
	private Long odrmst_refundstatus = new Long(0);
	
	/**
	 * �˿�����
	 */
	private Date odrmst_refundtime ;
	
	/**
	 * �û��������־����������λչ������8λ�����1����ʾ��vip��Ա��
	 */
	private Long odrmst_specialtype = new Long(0);
	
	/**
	 * eȯ��ţ���Ӧtktmst_id��
	 */
	private Long odrmst_tktid = new Long(0);
	
	/**
	 * eȯ���
	 */
	private Double odrmst_tktvalue = new Double(0);
	
	/**
	 * ȱ��ѡ�񷽰�������û�����ϣ����ڸĳ�Ԥ����ʱ��
	 */
	private Long odrmst_oosselect = new Long(0);
	
	/**
	 * ����������eȯ���
	 */
	private Double odrmst_sndtkt = new Double(0);
	
	/**
	 * ����������eȯ��������
	 */
	private String odrmst_sndtktdesc = "";
	
	/**
	 * ���ⶩ�����ͣ���������ʱȱ������  
	 * ȱ�������Ҫ�󻻻�  
	 * �ͺŲ�����Ҫ�󻻻�  
	 * ��ȱ�������Ҫ���˻�  
	 * �ͺŲ�����Ҫ���˻�  
	 * �õ���Ҫ�ر��ע
	 * �ͻ�ָ�����ջ�ʱ��  ��ϵ�����û�
	 * ��۸��������
	 * �л�ʱ֪ͨ�û�
	 * �û�δ�յ���
	 * �ݲ����ɲɹ��� ��
	 */
	private String odrmst_faqtype = "";
	
	/**
	 * ���ⶩ��״̬��0��û���� 1�����ڴ��� 5��������ϣ�
	 */
	private Long odrmst_faqstatus = new Long(0);
	
	/**
	 * ���״̬��0��δ��ӡ 11��СƱ�Ѵ�ӡ 1���������Ѵ�ӡ 2�������� 31������ɹ� 3�������أ�
	 */
	private Long odrmst_prnflag = new Long(0);
	
	/**
	 * ʵ���տ�״̬��0��δ�տ� 1�����տ �ѵ����ʾǮ��������D1�Ŀڴ�
	 */
	private Long odrmst_realstatus = new Long(0);
	
	/**
	 * ʵ���տ���
	 */
	private Double odrmst_realgetmoney = new Double(0);
	
	/**
	 * �����1 Ŀǰ�õĲ�����
	 */
	private String odrmst_ads1 = "";
	
	/**
	 * �����2 Ŀǰ�õĲ�����
	 */
	private String odrmst_ads2 = "";
	
	/**
	 * ��������
	 */
	private Date odrmst_shipdate;
	
	/**
	 * �ؿ�������
	 */
	private String odrmst_cardmemo = "";
	
	/**
	 * ����
	 */
	private Double odrmst_giftfee = new Double(0);
	
	/**
	 * ����
	 */
	private Long odrmst_giftid = new Long(0);
	
	/**
	 * �û���Ҫ���ķ��ã����ܱ����������ֶ���ʵ�Ѿ������ˣ���Ĭ��Ϊ0�ˣ�
	 */
	private Double odrmst_taxfee = new Double(0);
	
	/**
	 * �û���Ҫ���ı��շ��ã���Ҫ���ڹ�����Ʒ�ʼģ�
	 */
	private Double odrmst_insurancefee = new Double(0);
	
	/**
	 * �û���Ҫ����֧�����ط���
	 */
	private Double odrmst_netpayfee = new Double(0);
	
	/**
	 * �Ƿ�ͬ��
	 */
	private Long odrmst_downflag = new Long(0);
	
	/**
	 * ʵ���տ�ʱ��
	 */
	private Date odrmst_realgettime;
	
	/**
	 * �˿����ͣ�0��δ�˿� 1����֪ͨ8�� 2����֪ͨ2�� 3����֪ͨ5�� 4����Ϊeȯ 5���ʾ��˿� 6�������˿� 7�����˿� 8����֪֧ͨ�������� 9���ֽ��˿�
	 */
	private Long odrmst_refundtype = new Long(0);
	
	/**
	 * ����̳ǻ���֧�������յ�Ӷ�𣨹��ܱ��������Ѿ������ˣ�
	 */
	private Double odrmst_comvalue = new Double(0);
	
	/**
	 * D1����Ʊ��˰ʵ����Ҫ֧���Ľ��
	 */
	private Double odrmst_taxvalue = new Double(0);
	
	/**
	 * �������̵ı�ţ�ֻ�����з����Ĳ�����̱�ţ�����e8��D1������һ����00000000��
	 */
	private String odrmst_sndshopcode = "00000000";
	
	/**
	 * ���̻������õĽ��㵥�ţ����磺050801-03121801
	 */
	private String odrmst_balanceid = "";
	
	/**
	 * �Ƽ��˻�Ա�ţ���ʾ����������ĸ���Ա�Ƽ����ģ�
	 */
	private Long odrmst_rcmmbrid = new Long(0);
	
	/**
	 * �����Ļ�����
	 */
	private String odrmst_goodsodrid = "";
	
	/**
	 * ����������Թ���
	 */
	private Double odrmst_profit = new Double(0);
	
	/**
	 * ����ȷ����
	 */
	private String odrmst_validpeople = "";
	
	/**
	 * ����������
	 */
	private String odrmst_shippeople = "";
	
	/**
	 * D1�����ķ�����ʽid����Ӧd1shpsnd_id��
	 */
	private Long odrmst_d1shipid = new Long(0);
	
	/**
	 * D1�����ķ�����ʽ����Ӧd1shpsnd_name��
	 */
	private String odrmst_d1shipmethod = "";
	
	/**
	 * ���������
	 */
	private String odrmst_phpeople = "";
	
	/**
	 * ����������
	 */
	private Date odrmst_phdate;
	
	/**
	 * ���������
	 */
	private String odrmst_checkpeople = "";
	
	/**
	 * �������
	 */
	private Date odrmst_checkdate;
	
	/**
	 * ��ԴIP
	 */
	private String odrmst_ip = "";
	
	/**
	 * ��ԴURL
	 */
	private String odrmst_srcurl = "";
	
	/**
	 * �����Ƽ���
	 */
	private String odrmst_peoplercm = "";
	
	/**
	 * ���˱�ǣ���pingan��yiqifa
	 */
	private String odrmst_temp = "";
	
	/**
	 * ��Ʊ״̬��0���û�����Ҫ��Ʊ 1����Ҫ��Ʊ,���� 5����Ʊ�ѿ� -1���˻�,��Ʊ���� -2����Ʊ����,ȡ�� -3����Ʊ�޷���,�Ȿ��
	 */
	private Long odrmst_taxflag = new Long(0);
	
	/**
	 * ׷����־��0��δ���� 1����׷�� 2���û���Ӧ��� 5��׷���ɹ��� -1�����ʧ�� -2��ȡ��׷����
	 */
	private Long odrmst_zhuidanflag = new Long(0);
	
	/**
	 * �û�ȡ������ 1.���͹�˾ԭ��   2.�ͻ��������  3.�ͻ�Ҫ�����¶���  4.�ɹ�ʱ������û�ȡ��   5.����ԭ��
	 */
	private Long odrmst_cancelreason = new Long(0);
	
	/**
	 * ��������
	 */
	private String odrmst_linkodrid = "";
	
	/**
	 * δ֪
	 */
	private Long odrmst_paytimes = new Long(0);
	
	/**
	 *  �������ֵ
	 */
	private Double odrmst_difprice = new Double(0);
	
	/**
	 *  �����״̬��0���ò���1������2�Ѳ���
	 */
	private Long odrmst_difpricestatus = new Long(0);
	
	/**
	 * �绰֧�������������صĺţ������������ѯ�û��绰֧���Ƿ�ɹ�
	 */
	private String odrmst_returnid = "";
	
	/**
	 * ״̬����Ϊ��δ���0�������1��������2������ɹ�3��������4
	 */
	private Long odrmst_printflag = new Long(0);
	
	/**
	 *���Ӻ�
	 */
	private Long odrmst_phbagno = new Long(0);
	
	/**
	 * δ֪
	 */
	private String odrmst_domain = "";
	
	/**
	 * �Ƿ���ϸ�޸Ĺ���1�޸Ĺ���0û��
	 */
	private Long odrmst_ifupddtl = new Long(0);
	
	/**
	 * �û�Ҫ�������ʹ�����
	 */
	private Date odrmst_lastreceivetime;
	
	/**
	 * ȱ���˿�ѡ�񷽰�
	 */
	private String odrmst_refundplan = "";
	
	/**
	 * ���������Ѿ�����
	 */
	private Long odrmst_jcflag = new Long(0);
	
	/**
	 * Ԥ���
	 */
	private Double odrmst_prepayvalue = new Double(0);
	
	/**
	 * ʵ�ʷ���ʱ��
	 */
	private Date odrmst_realshipdate;
	
	/**
	 * ȡ����
	 */
	private String odrmst_cancelpeople = "";
	
	/**
	 * ʵ�ʷ�������
	 */
	private Long odrmst_realsendcount = new Long(0);
	
	/**
	 * ��װ��
	 */
	private String odrmst_bzpeople = "";
	
	/**
	 * ʵ�ʷ�����
	 */
	private String odrmst_realshippeople = "";
	
	/**
	 * �Ƿ�ʵ�ʷ�����1�ǣ�0��
	 */
	private Long odrmst_ifrealsend = new Long(0);
	
	/**
	 * EG�̻����
	 */
	private String odrmst_egshpcode = "0";
	
	/**
	 * ��������
	 */
	private String odrmst_fhcode = "";
	
	/**
	 * ����
	 */
	private Double odrmst_dsmoney = new Double(0);
	
	/**
	 * ���ջ�����㵥��
	 */
	private String odrmst_codbalance = "";
	
	/**
	 * �˷ѽ�����㵥��
	 */
	private String odrmst_shipfeebalance = "";
	
	/**
	 * ��ʾ��һ�ι���
	 */
	private Long odrmst_specialmbr = new Long(0);
	
	/**
	 * �����ط�״̬��0���ûط�,1 ���ط�,2 �ѻط� 
	 */
	private String odrmst_revisitflag = "0";
	
	/**
	 * �subad��δ֪
	 */
	private String odrmst_subad = "";
	
	/**
	 *�����������͹�����odrqus��
	 */
	private String odrmst_odrqus = "";
	
	/**
	 * ����Ʊ��
	 */
	private String odrmst_invpeople = "";
	
	/**
	 * ��������
	 */
	private Date odrmst_invdate;
	
	/**
	 * ���ֶһ�ʹ���ܻ���
	 */
	private Long odrmst_sumawardvalue = new Long(0);
	
	private String odrmst_actpay;
	
	private String odrmst_oldodrid;
	/**
	 * ��Żݽ��*/
	private Long odrmst_d1actmoney=new Long(0);
	
	/**
	 * ���ʱ��ץȡ
	 **/
	private Date odrmst_sshipdate;
	private Date odrmst_eshipdate;
	private Long odrmst_shipflag=new Long(0);
	/**
	 * ����ʱ��
	 */
	private Date odrmst_update;
	
	private Float odrmst_tmfx=new Float(0);     //��è����
	private Long odrmst_tmfxstatus=new Long(0);  //��è����״̬
	private String odrmst_tmfximg;   //��è���ֽ�ͼ
	/**
	 * 1=cache������2=main������3=recent������4=history����
	 */
	@Transient
	private int type ;
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Long getOdrmst_id() {
		return odrmst_id;
	}
	public void setOdrmst_id(Long odrmst_id) {
		this.odrmst_id = odrmst_id;
	}
	public Long getOdrmst_mbrid() {
		return odrmst_mbrid;
	}
	public void setOdrmst_mbrid(Long odrmst_mbrid) {
		this.odrmst_mbrid = odrmst_mbrid;
	}
	public String getOdrmst_rname() {
		return odrmst_rname;
	}
	public void setOdrmst_rname(String odrmst_rname) {
		this.odrmst_rname = odrmst_rname;
	}
	public String getOdrmst_rsex() {
		return odrmst_rsex;
	}
	public void setOdrmst_rsex(String odrmst_rsex) {
		this.odrmst_rsex = odrmst_rsex;
	}
	public String getOdrmst_rzipcode() {
		return odrmst_rzipcode;
	}
	public void setOdrmst_rzipcode(String odrmst_rzipcode) {
		this.odrmst_rzipcode = odrmst_rzipcode;
	}
	public String getOdrmst_raddress() {
		return odrmst_raddress;
	}
	public void setOdrmst_raddress(String odrmst_raddress) {
		this.odrmst_raddress = odrmst_raddress;
	}
	public String getOdrmst_rphone() {
		return odrmst_rphone;
	}
	public void setOdrmst_rphone(String odrmst_rphone) {
		this.odrmst_rphone = odrmst_rphone;
	}
	public String getOdrmst_remail() {
		return odrmst_remail;
	}
	public void setOdrmst_remail(String odrmst_remail) {
		this.odrmst_remail = odrmst_remail;
	}
	public String getOdrmst_rcountry() {
		return odrmst_rcountry;
	}
	public void setOdrmst_rcountry(String odrmst_rcountry) {
		this.odrmst_rcountry = odrmst_rcountry;
	}
	public String getOdrmst_rprovince() {
		return odrmst_rprovince;
	}
	public void setOdrmst_rprovince(String odrmst_rprovince) {
		this.odrmst_rprovince = odrmst_rprovince;
	}
	public String getOdrmst_rcity() {
		return odrmst_rcity;
	}
	public void setOdrmst_rcity(String odrmst_rcity) {
		this.odrmst_rcity = odrmst_rcity;
	}
	public String getOdrmst_pname() {
		return odrmst_pname;
	}
	public void setOdrmst_pname(String odrmst_pname) {
		this.odrmst_pname = odrmst_pname;
	}
	public String getOdrmst_psex() {
		return odrmst_psex;
	}
	public void setOdrmst_psex(String odrmst_psex) {
		this.odrmst_psex = odrmst_psex;
	}
	public String getOdrmst_pzipcode() {
		return odrmst_pzipcode;
	}
	public void setOdrmst_pzipcode(String odrmst_pzipcode) {
		this.odrmst_pzipcode = odrmst_pzipcode;
	}
	public String getOdrmst_paddress() {
		return odrmst_paddress;
	}
	public void setOdrmst_paddress(String odrmst_paddress) {
		this.odrmst_paddress = odrmst_paddress;
	}
	public String getOdrmst_pcountry() {
		return odrmst_pcountry;
	}
	public void setOdrmst_pcountry(String odrmst_pcountry) {
		this.odrmst_pcountry = odrmst_pcountry;
	}
	public String getOdrmst_pprovince() {
		return odrmst_pprovince;
	}
	public void setOdrmst_pprovince(String odrmst_pprovince) {
		this.odrmst_pprovince = odrmst_pprovince;
	}
	public String getOdrmst_pcity() {
		return odrmst_pcity;
	}
	public void setOdrmst_pcity(String odrmst_pcity) {
		this.odrmst_pcity = odrmst_pcity;
	}
	public String getOdrmst_pophone() {
		return odrmst_pophone;
	}
	public void setOdrmst_pophone(String odrmst_pophone) {
		this.odrmst_pophone = odrmst_pophone;
	}
	public String getOdrmst_phphone() {
		return odrmst_phphone;
	}
	public void setOdrmst_phphone(String odrmst_phphone) {
		this.odrmst_phphone = odrmst_phphone;
	}
	public String getOdrmst_pmphone() {
		return odrmst_pmphone;
	}
	public void setOdrmst_pmphone(String odrmst_pmphone) {
		this.odrmst_pmphone = odrmst_pmphone;
	}
	public String getOdrmst_pusephone() {
		return odrmst_pusephone;
	}
	public void setOdrmst_pusephone(String odrmst_pusephone) {
		this.odrmst_pusephone = odrmst_pusephone;
	}
	public String getOdrmst_pemail() {
		return odrmst_pemail;
	}
	public void setOdrmst_pemail(String odrmst_pemail) {
		this.odrmst_pemail = odrmst_pemail;
	}
	public String getOdrmst_pbp() {
		return odrmst_pbp;
	}
	public void setOdrmst_pbp(String odrmst_pbp) {
		this.odrmst_pbp = odrmst_pbp;
	}
	public Double getOdrmst_fee() {
		return odrmst_fee;
	}
	public void setOdrmst_fee(Double odrmst_fee) {
		this.odrmst_fee = odrmst_fee;
	}
	public Long getOdrmst_payid() {
		return odrmst_payid;
	}
	public void setOdrmst_payid(Long odrmst_payid) {
		this.odrmst_payid = odrmst_payid;
	}
	public String getOdrmst_paymethod() {
		return odrmst_paymethod;
	}
	public void setOdrmst_paymethod(String odrmst_paymethod) {
		this.odrmst_paymethod = odrmst_paymethod;
	}
	public Long getOdrmst_paytype() {
		return odrmst_paytype;
	}
	public void setOdrmst_paytype(Long odrmst_paytype) {
		this.odrmst_paytype = odrmst_paytype;
	}
	public Long getOdrmst_shipid() {
		return odrmst_shipid;
	}
	public void setOdrmst_shipid(Long odrmst_shipid) {
		this.odrmst_shipid = odrmst_shipid;
	}
	public String getOdrmst_shipmethod() {
		return odrmst_shipmethod;
	}
	public void setOdrmst_shipmethod(String odrmst_shipmethod) {
		this.odrmst_shipmethod = odrmst_shipmethod;
	}
	public Double getOdrmst_gdsmoney() {
		return odrmst_gdsmoney;
	}
	public void setOdrmst_gdsmoney(Double odrmst_gdsmoney) {
		this.odrmst_gdsmoney = odrmst_gdsmoney;
	}
	public Double getOdrmst_shipfee() {
		return odrmst_shipfee;
	}
	public void setOdrmst_shipfee(Double odrmst_shipfee) {
		this.odrmst_shipfee = odrmst_shipfee;
	}
	public Double getOdrmst_centerfee() {
		return odrmst_centerfee;
	}
	public void setOdrmst_centerfee(Double odrmst_centerfee) {
		this.odrmst_centerfee = odrmst_centerfee;
	}
	public Double getOdrmst_ordermoney() {
		return odrmst_ordermoney;
	}
	public void setOdrmst_ordermoney(Double odrmst_ordermoney) {
		this.odrmst_ordermoney = odrmst_ordermoney;
	}
	public Date getOdrmst_orderdate() {
		return odrmst_orderdate;
	}
	public void setOdrmst_orderdate(Date odrmst_orderdate) {
		this.odrmst_orderdate = odrmst_orderdate;
	}
	public Long getOdrmst_orderstatus() {
		return odrmst_orderstatus;
	}
	public void setOdrmst_orderstatus(Long odrmst_orderstatus) {
		this.odrmst_orderstatus = odrmst_orderstatus;
	}
	public Date getOdrmst_affirmdate() {
		return odrmst_affirmdate;
	}
	public void setOdrmst_affirmdate(Date odrmst_affirmdate) {
		this.odrmst_affirmdate = odrmst_affirmdate;
	}
	public Double getOdrmst_getmoney() {
		return odrmst_getmoney;
	}
	public void setOdrmst_getmoney(Double odrmst_getmoney) {
		this.odrmst_getmoney = odrmst_getmoney;
	}
	public Long getOdrmst_rthird() {
		return odrmst_rthird;
	}
	public void setOdrmst_rthird(Long odrmst_rthird) {
		this.odrmst_rthird = odrmst_rthird;
	}
	public String getOdrmst_customerword() {
		return odrmst_customerword;
	}
	public void setOdrmst_customerword(String odrmst_customerword) {
		this.odrmst_customerword = odrmst_customerword;
	}
	public Double getOdrmst_acturepaymoney() {
		return odrmst_acturepaymoney;
	}
	public void setOdrmst_acturepaymoney(Double odrmst_acturepaymoney) {
		this.odrmst_acturepaymoney = odrmst_acturepaymoney;
	}
	public Double getOdrmst_acturecollectmoney() {
		return odrmst_acturecollectmoney;
	}
	public void setOdrmst_acturecollectmoney(Double odrmst_acturecollectmoney) {
		this.odrmst_acturecollectmoney = odrmst_acturecollectmoney;
	}
	public Long getOdrmst_invoiceflag() {
		return odrmst_invoiceflag;
	}
	public void setOdrmst_invoiceflag(Long odrmst_invoiceflag) {
		this.odrmst_invoiceflag = odrmst_invoiceflag;
	}
	public String getOdrmst_ourmemo() {
		return odrmst_ourmemo;
	}
	public void setOdrmst_ourmemo(String odrmst_ourmemo) {
		this.odrmst_ourmemo = odrmst_ourmemo;
	}
	public String getOdrmst_internalmemo() {
		return odrmst_internalmemo;
	}
	public void setOdrmst_internalmemo(String odrmst_internalmemo) {
		this.odrmst_internalmemo = odrmst_internalmemo;
	}
	public Double getOdrmst_d1fee() {
		return odrmst_d1fee;
	}
	public void setOdrmst_d1fee(Double odrmst_d1fee) {
		this.odrmst_d1fee = odrmst_d1fee;
	}
	public Long getOdrmst_refundmentstatus() {
		return odrmst_refundmentstatus;
	}
	public void setOdrmst_refundmentstatus(Long odrmst_refundmentstatus) {
		this.odrmst_refundmentstatus = odrmst_refundmentstatus;
	}
	public Double getOdrmst_refundmentmoney() {
		return odrmst_refundmentmoney;
	}
	public void setOdrmst_refundmentmoney(Double odrmst_refundmentmoney) {
		this.odrmst_refundmentmoney = odrmst_refundmentmoney;
	}
	public Long getOdrmst_tsmstatus() {
		return odrmst_tsmstatus;
	}
	public void setOdrmst_tsmstatus(Long odrmst_tsmstatus) {
		this.odrmst_tsmstatus = odrmst_tsmstatus;
	}
	public Date getOdrmst_tsmtime() {
		return odrmst_tsmtime;
	}
	public void setOdrmst_tsmtime(Date odrmst_tsmtime) {
		this.odrmst_tsmtime = odrmst_tsmtime;
	}
	public Date getOdrmst_canceldate() {
		return odrmst_canceldate;
	}
	public void setOdrmst_canceldate(Date odrmst_canceldate) {
		this.odrmst_canceldate = odrmst_canceldate;
	}
	public Date getOdrmst_finishdate() {
		return odrmst_finishdate;
	}
	public void setOdrmst_finishdate(Date odrmst_finishdate) {
		this.odrmst_finishdate = odrmst_finishdate;
	}
	public Date getOdrmst_validdate() {
		return odrmst_validdate;
	}
	public void setOdrmst_validdate(Date odrmst_validdate) {
		this.odrmst_validdate = odrmst_validdate;
	}
	public Long getOdrmst_refundstatus() {
		return odrmst_refundstatus;
	}
	public void setOdrmst_refundstatus(Long odrmst_refundstatus) {
		this.odrmst_refundstatus = odrmst_refundstatus;
	}
	public Date getOdrmst_refundtime() {
		return odrmst_refundtime;
	}
	public void setOdrmst_refundtime(Date odrmst_refundtime) {
		this.odrmst_refundtime = odrmst_refundtime;
	}
	public Long getOdrmst_specialtype() {
		return odrmst_specialtype;
	}
	public void setOdrmst_specialtype(Long odrmst_specialtype) {
		this.odrmst_specialtype = odrmst_specialtype;
	}
	public Long getOdrmst_tktid() {
		return odrmst_tktid;
	}
	public void setOdrmst_tktid(Long odrmst_tktid) {
		this.odrmst_tktid = odrmst_tktid;
	}
	public Double getOdrmst_tktvalue() {
		return odrmst_tktvalue;
	}
	public void setOdrmst_tktvalue(Double odrmst_tktvalue) {
		this.odrmst_tktvalue = odrmst_tktvalue;
	}
	public Long getOdrmst_oosselect() {
		return odrmst_oosselect;
	}
	public void setOdrmst_oosselect(Long odrmst_oosselect) {
		this.odrmst_oosselect = odrmst_oosselect;
	}
	public Double getOdrmst_sndtkt() {
		return odrmst_sndtkt;
	}
	public void setOdrmst_sndtkt(Double odrmst_sndtkt) {
		this.odrmst_sndtkt = odrmst_sndtkt;
	}
	public String getOdrmst_sndtktdesc() {
		return odrmst_sndtktdesc;
	}
	public void setOdrmst_sndtktdesc(String odrmst_sndtktdesc) {
		this.odrmst_sndtktdesc = odrmst_sndtktdesc;
	}
	public String getOdrmst_faqtype() {
		return odrmst_faqtype;
	}
	public void setOdrmst_faqtype(String odrmst_faqtype) {
		this.odrmst_faqtype = odrmst_faqtype;
	}
	public Long getOdrmst_faqstatus() {
		return odrmst_faqstatus;
	}
	public void setOdrmst_faqstatus(Long odrmst_faqstatus) {
		this.odrmst_faqstatus = odrmst_faqstatus;
	}
	public Long getOdrmst_prnflag() {
		return odrmst_prnflag;
	}
	public void setOdrmst_prnflag(Long odrmst_prnflag) {
		this.odrmst_prnflag = odrmst_prnflag;
	}
	public Long getOdrmst_realstatus() {
		return odrmst_realstatus;
	}
	public void setOdrmst_realstatus(Long odrmst_realstatus) {
		this.odrmst_realstatus = odrmst_realstatus;
	}
	public Double getOdrmst_realgetmoney() {
		return odrmst_realgetmoney;
	}
	public void setOdrmst_realgetmoney(Double odrmst_realgetmoney) {
		this.odrmst_realgetmoney = odrmst_realgetmoney;
	}
	public String getOdrmst_ads1() {
		return odrmst_ads1;
	}
	public void setOdrmst_ads1(String odrmst_ads1) {
		this.odrmst_ads1 = odrmst_ads1;
	}
	public String getOdrmst_ads2() {
		return odrmst_ads2;
	}
	public void setOdrmst_ads2(String odrmst_ads2) {
		this.odrmst_ads2 = odrmst_ads2;
	}
	public Date getOdrmst_shipdate() {
		return odrmst_shipdate;
	}
	public void setOdrmst_shipdate(Date odrmst_shipdate) {
		this.odrmst_shipdate = odrmst_shipdate;
	}
	public String getOdrmst_cardmemo() {
		return odrmst_cardmemo;
	}
	public void setOdrmst_cardmemo(String odrmst_cardmemo) {
		this.odrmst_cardmemo = odrmst_cardmemo;
	}
	public Double getOdrmst_giftfee() {
		return odrmst_giftfee;
	}
	public void setOdrmst_giftfee(Double odrmst_giftfee) {
		this.odrmst_giftfee = odrmst_giftfee;
	}
	public Long getOdrmst_giftid() {
		return odrmst_giftid;
	}
	public void setOdrmst_giftid(Long odrmst_giftid) {
		this.odrmst_giftid = odrmst_giftid;
	}
	public Double getOdrmst_taxfee() {
		return odrmst_taxfee;
	}
	public void setOdrmst_taxfee(Double odrmst_taxfee) {
		this.odrmst_taxfee = odrmst_taxfee;
	}
	public Double getOdrmst_insurancefee() {
		return odrmst_insurancefee;
	}
	public void setOdrmst_insurancefee(Double odrmst_insurancefee) {
		this.odrmst_insurancefee = odrmst_insurancefee;
	}
	public Double getOdrmst_netpayfee() {
		return odrmst_netpayfee;
	}
	public void setOdrmst_netpayfee(Double odrmst_netpayfee) {
		this.odrmst_netpayfee = odrmst_netpayfee;
	}
	public Long getOdrmst_downflag() {
		return odrmst_downflag;
	}
	public void setOdrmst_downflag(Long odrmst_downflag) {
		this.odrmst_downflag = odrmst_downflag;
	}
	public Date getOdrmst_realgettime() {
		return odrmst_realgettime;
	}
	public void setOdrmst_realgettime(Date odrmst_realgettime) {
		this.odrmst_realgettime = odrmst_realgettime;
	}
	public Long getOdrmst_refundtype() {
		return odrmst_refundtype;
	}
	public void setOdrmst_refundtype(Long odrmst_refundtype) {
		this.odrmst_refundtype = odrmst_refundtype;
	}
	public Double getOdrmst_comvalue() {
		return odrmst_comvalue;
	}
	public void setOdrmst_comvalue(Double odrmst_comvalue) {
		this.odrmst_comvalue = odrmst_comvalue;
	}
	public Double getOdrmst_taxvalue() {
		return odrmst_taxvalue;
	}
	public void setOdrmst_taxvalue(Double odrmst_taxvalue) {
		this.odrmst_taxvalue = odrmst_taxvalue;
	}
	public String getOdrmst_sndshopcode() {
		return odrmst_sndshopcode;
	}
	public void setOdrmst_sndshopcode(String odrmst_sndshopcode) {
		this.odrmst_sndshopcode = odrmst_sndshopcode;
	}
	public String getOdrmst_balanceid() {
		return odrmst_balanceid;
	}
	public void setOdrmst_balanceid(String odrmst_balanceid) {
		this.odrmst_balanceid = odrmst_balanceid;
	}
	public Long getOdrmst_rcmmbrid() {
		return odrmst_rcmmbrid;
	}
	public void setOdrmst_rcmmbrid(Long odrmst_rcmmbrid) {
		this.odrmst_rcmmbrid = odrmst_rcmmbrid;
	}
	public String getOdrmst_goodsodrid() {
		return odrmst_goodsodrid;
	}
	public void setOdrmst_goodsodrid(String odrmst_goodsodrid) {
		this.odrmst_goodsodrid = odrmst_goodsodrid;
	}
	public Double getOdrmst_profit() {
		return odrmst_profit;
	}
	public void setOdrmst_profit(Double odrmst_profit) {
		this.odrmst_profit = odrmst_profit;
	}
	public String getOdrmst_validpeople() {
		return odrmst_validpeople;
	}
	public void setOdrmst_validpeople(String odrmst_validpeople) {
		this.odrmst_validpeople = odrmst_validpeople;
	}
	public String getOdrmst_shippeople() {
		return odrmst_shippeople;
	}
	public void setOdrmst_shippeople(String odrmst_shippeople) {
		this.odrmst_shippeople = odrmst_shippeople;
	}
	public Long getOdrmst_d1shipid() {
		return odrmst_d1shipid;
	}
	public void setOdrmst_d1shipid(Long odrmst_d1shipid) {
		this.odrmst_d1shipid = odrmst_d1shipid;
	}
	public String getOdrmst_d1shipmethod() {
		return odrmst_d1shipmethod;
	}
	public void setOdrmst_d1shipmethod(String odrmst_d1shipmethod) {
		this.odrmst_d1shipmethod = odrmst_d1shipmethod;
	}
	public String getOdrmst_phpeople() {
		return odrmst_phpeople;
	}
	public void setOdrmst_phpeople(String odrmst_phpeople) {
		this.odrmst_phpeople = odrmst_phpeople;
	}
	public Date getOdrmst_phdate() {
		return odrmst_phdate;
	}
	public void setOdrmst_phdate(Date odrmst_phdate) {
		this.odrmst_phdate = odrmst_phdate;
	}
	public String getOdrmst_checkpeople() {
		return odrmst_checkpeople;
	}
	public void setOdrmst_checkpeople(String odrmst_checkpeople) {
		this.odrmst_checkpeople = odrmst_checkpeople;
	}
	public Date getOdrmst_checkdate() {
		return odrmst_checkdate;
	}
	public void setOdrmst_checkdate(Date odrmst_checkdate) {
		this.odrmst_checkdate = odrmst_checkdate;
	}
	public String getOdrmst_ip() {
		return odrmst_ip;
	}
	public void setOdrmst_ip(String odrmst_ip) {
		this.odrmst_ip = odrmst_ip;
	}
	public String getOdrmst_srcurl() {
		return odrmst_srcurl;
	}
	public void setOdrmst_srcurl(String odrmst_srcurl) {
		this.odrmst_srcurl = odrmst_srcurl;
	}
	public String getOdrmst_peoplercm() {
		return odrmst_peoplercm;
	}
	public void setOdrmst_peoplercm(String odrmst_peoplercm) {
		this.odrmst_peoplercm = odrmst_peoplercm;
	}
	public String getOdrmst_temp() {
		return odrmst_temp;
	}
	public void setOdrmst_temp(String odrmst_temp) {
		this.odrmst_temp = odrmst_temp;
	}
	public Long getOdrmst_taxflag() {
		return odrmst_taxflag;
	}
	public void setOdrmst_taxflag(Long odrmst_taxflag) {
		this.odrmst_taxflag = odrmst_taxflag;
	}
	public Long getOdrmst_zhuidanflag() {
		return odrmst_zhuidanflag;
	}
	public void setOdrmst_zhuidanflag(Long odrmst_zhuidanflag) {
		this.odrmst_zhuidanflag = odrmst_zhuidanflag;
	}
	public Long getOdrmst_cancelreason() {
		return odrmst_cancelreason;
	}
	public void setOdrmst_cancelreason(Long odrmst_cancelreason) {
		this.odrmst_cancelreason = odrmst_cancelreason;
	}
	public String getOdrmst_linkodrid() {
		return odrmst_linkodrid;
	}
	public void setOdrmst_linkodrid(String odrmst_linkodrid) {
		this.odrmst_linkodrid = odrmst_linkodrid;
	}
	public Long getOdrmst_paytimes() {
		return odrmst_paytimes;
	}
	public void setOdrmst_paytimes(Long odrmst_paytimes) {
		this.odrmst_paytimes = odrmst_paytimes;
	}
	public Double getOdrmst_difprice() {
		return odrmst_difprice;
	}
	public void setOdrmst_difprice(Double odrmst_difprice) {
		this.odrmst_difprice = odrmst_difprice;
	}
	public Long getOdrmst_difpricestatus() {
		return odrmst_difpricestatus;
	}
	public void setOdrmst_difpricestatus(Long odrmst_difpricestatus) {
		this.odrmst_difpricestatus = odrmst_difpricestatus;
	}
	public String getOdrmst_returnid() {
		return odrmst_returnid;
	}
	public void setOdrmst_returnid(String odrmst_returnid) {
		this.odrmst_returnid = odrmst_returnid;
	}
	public Long getOdrmst_printflag() {
		return odrmst_printflag;
	}
	public void setOdrmst_printflag(Long odrmst_printflag) {
		this.odrmst_printflag = odrmst_printflag;
	}
	public Long getOdrmst_phbagno() {
		return odrmst_phbagno;
	}
	public void setOdrmst_phbagno(Long odrmst_phbagno) {
		this.odrmst_phbagno = odrmst_phbagno;
	}
	public String getOdrmst_domain() {
		return odrmst_domain;
	}
	public void setOdrmst_domain(String odrmst_domain) {
		this.odrmst_domain = odrmst_domain;
	}
	public Long getOdrmst_ifupddtl() {
		return odrmst_ifupddtl;
	}
	public void setOdrmst_ifupddtl(Long odrmst_ifupddtl) {
		this.odrmst_ifupddtl = odrmst_ifupddtl;
	}
	public Date getOdrmst_lastreceivetime() {
		return odrmst_lastreceivetime;
	}
	public void setOdrmst_lastreceivetime(Date odrmst_lastreceivetime) {
		this.odrmst_lastreceivetime = odrmst_lastreceivetime;
	}
	public String getOdrmst_refundplan() {
		return odrmst_refundplan;
	}
	public void setOdrmst_refundplan(String odrmst_refundplan) {
		this.odrmst_refundplan = odrmst_refundplan;
	}
	public Long getOdrmst_jcflag() {
		return odrmst_jcflag;
	}
	public void setOdrmst_jcflag(Long odrmst_jcflag) {
		this.odrmst_jcflag = odrmst_jcflag;
	}
	public Double getOdrmst_prepayvalue() {
		return odrmst_prepayvalue;
	}
	public void setOdrmst_prepayvalue(Double odrmst_prepayvalue) {
		this.odrmst_prepayvalue = odrmst_prepayvalue;
	}
	public Date getOdrmst_realshipdate() {
		return odrmst_realshipdate;
	}
	public void setOdrmst_realshipdate(Date odrmst_realshipdate) {
		this.odrmst_realshipdate = odrmst_realshipdate;
	}
	public String getOdrmst_cancelpeople() {
		return odrmst_cancelpeople;
	}
	public void setOdrmst_cancelpeople(String odrmst_cancelpeople) {
		this.odrmst_cancelpeople = odrmst_cancelpeople;
	}
	public Long getOdrmst_realsendcount() {
		return odrmst_realsendcount;
	}
	public void setOdrmst_realsendcount(Long odrmst_realsendcount) {
		this.odrmst_realsendcount = odrmst_realsendcount;
	}
	public String getOdrmst_bzpeople() {
		return odrmst_bzpeople;
	}
	public void setOdrmst_bzpeople(String odrmst_bzpeople) {
		this.odrmst_bzpeople = odrmst_bzpeople;
	}
	public String getOdrmst_realshippeople() {
		return odrmst_realshippeople;
	}
	public void setOdrmst_realshippeople(String odrmst_realshippeople) {
		this.odrmst_realshippeople = odrmst_realshippeople;
	}
	public Long getOdrmst_ifrealsend() {
		return odrmst_ifrealsend;
	}
	public void setOdrmst_ifrealsend(Long odrmst_ifrealsend) {
		this.odrmst_ifrealsend = odrmst_ifrealsend;
	}
	public String getOdrmst_egshpcode() {
		return odrmst_egshpcode;
	}
	public void setOdrmst_egshpcode(String odrmst_egshpcode) {
		this.odrmst_egshpcode = odrmst_egshpcode;
	}
	public String getOdrmst_fhcode() {
		return odrmst_fhcode;
	}
	public void setOdrmst_fhcode(String odrmst_fhcode) {
		this.odrmst_fhcode = odrmst_fhcode;
	}
	public Double getOdrmst_dsmoney() {
		return odrmst_dsmoney;
	}
	public void setOdrmst_dsmoney(Double odrmst_dsmoney) {
		this.odrmst_dsmoney = odrmst_dsmoney;
	}
	public String getOdrmst_codbalance() {
		return odrmst_codbalance;
	}
	public void setOdrmst_codbalance(String odrmst_codbalance) {
		this.odrmst_codbalance = odrmst_codbalance;
	}
	public String getOdrmst_shipfeebalance() {
		return odrmst_shipfeebalance;
	}
	public void setOdrmst_shipfeebalance(String odrmst_shipfeebalance) {
		this.odrmst_shipfeebalance = odrmst_shipfeebalance;
	}
	public Long getOdrmst_specialmbr() {
		return odrmst_specialmbr;
	}
	public void setOdrmst_specialmbr(Long odrmst_specialmbr) {
		this.odrmst_specialmbr = odrmst_specialmbr;
	}
	public String getOdrmst_revisitflag() {
		return odrmst_revisitflag;
	}
	public void setOdrmst_revisitflag(String odrmst_revisitflag) {
		this.odrmst_revisitflag = odrmst_revisitflag;
	}
	public String getOdrmst_subad() {
		return odrmst_subad;
	}
	public void setOdrmst_subad(String odrmst_subad) {
		this.odrmst_subad = odrmst_subad;
	}
	public String getOdrmst_odrqus() {
		return odrmst_odrqus;
	}
	public void setOdrmst_odrqus(String odrmst_odrqus) {
		this.odrmst_odrqus = odrmst_odrqus;
	}
	public String getOdrmst_invpeople() {
		return odrmst_invpeople;
	}
	public void setOdrmst_invpeople(String odrmst_invpeople) {
		this.odrmst_invpeople = odrmst_invpeople;
	}
	public Date getOdrmst_invdate() {
		return odrmst_invdate;
	}
	public void setOdrmst_invdate(Date odrmst_invdate) {
		this.odrmst_invdate = odrmst_invdate;
	}
	public Long getOdrmst_sumawardvalue() {
		return odrmst_sumawardvalue;
	}
	public void setOdrmst_sumawardvalue(Long odrmst_sumawardvalue) {
		this.odrmst_sumawardvalue = odrmst_sumawardvalue;
	}
	public String getOdrmst_actpay() {
		return odrmst_actpay;
	}
	public void setOdrmst_actpay(String odrmst_actpay) {
		this.odrmst_actpay = odrmst_actpay;
	}
	public String getOdrmst_oldodrid() {
		return odrmst_oldodrid;
	}
	public void setOdrmst_oldodrid(String odrmst_oldodrid) {
		this.odrmst_oldodrid = odrmst_oldodrid;
	}
	public Long getOdrmst_d1actmoney() {
		return odrmst_d1actmoney;
	}
	public void setOdrmst_d1actmoney(Long odrmst_d1actmoney) {
		this.odrmst_d1actmoney = odrmst_d1actmoney;
	}
	public Date getOdrmst_sshipdate() {
		return odrmst_sshipdate;
	}
	public void setOdrmst_sshipdate(Date odrmst_sshipdate) {
		this.odrmst_sshipdate = odrmst_sshipdate;
	}
	public Date getOdrmst_eshipdate() {
		return odrmst_eshipdate;
	}
	public void setOdrmst_eshipdate(Date odrmst_eshipdate) {
		this.odrmst_eshipdate = odrmst_eshipdate;
	}
	public Long getOdrmst_shipflag() {
		return odrmst_shipflag;
	}
	public void setOdrmst_shipflag(Long odrmst_shipflag) {
		this.odrmst_shipflag = odrmst_shipflag;
	}
	public Date getOdrmst_update() {
		return odrmst_update;
	}
	public void setOdrmst_update(Date odrmst_update) {
		this.odrmst_update = odrmst_update;
	}
	public Float getOdrmst_tmfx() {
		return odrmst_tmfx;
	}
	public void setOdrmst_tmfx(Float odrmst_tmfx) {
		this.odrmst_tmfx = odrmst_tmfx;
	}
	public Long getOdrmst_tmfxstatus() {
		return odrmst_tmfxstatus;
	}
	public void setOdrmst_tmfxstatus(Long odrmst_tmfxstatus) {
		this.odrmst_tmfxstatus = odrmst_tmfxstatus;
	}
	public String getOdrmst_tmfximg() {
		return odrmst_tmfximg;
	}
	public void setOdrmst_tmfximg(String odrmst_tmfximg) {
		this.odrmst_tmfximg = odrmst_tmfximg;
	}
	
}
