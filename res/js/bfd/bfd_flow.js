/********** 向百分点推荐引擎提交推荐请求 **********/
window.bfd_onload = function() {
	// "public2"是百分点推荐引擎公开的演示账户，在正式使用时请替换为您的账户名称bfdtest2
	var client = new brs.Client("Cd1youshang");
	var p = new brs.PackedRequest();	
	var itemArr=bfd_strgdsid2.split(',');
	for(var i=0;i<itemArr.length;i++){
		p["a"+i]=new brs.AddShopCart(bfd_strbfdusrid,itemArr[i],bfd_strsessioinid);
	}
	/********** 向百分点推荐引擎请求推荐结果(推荐请求部分) **********/
	p.rec7 = new brs.RecByBoughtAlsoBought(bfd_strgdsid,bfd_strsessioinid, 8);
	client.invoke(p, "cb_recommend");
}

csname='';
// 回调函数：用于处理推荐请求的返回结果。即,将推荐结果展示在推荐栏中，您可以根据需要修改
function cb_recommend(json) {
	if(typeof json.rec7 == 'undefined') return;
	var rec7_data = json.rec7[2];
	if(rec7_data.length == 0) return;
	var rec7_reqid = json.rec7[1];
	
	$.post("/ajax/product/getBFDFlowDate.jsp",{bfdgdsid:rec7_data.toString(),reqid:rec7_reqid,tt:Math.random()},function(json){
		if(json.success){
			$('#cjxh_div').html(json.content);
			if(json.size>4){
				new SellerScroll();
			}
		}else{
			$('#cjxh_div').hide();
		}
	},"json");
}