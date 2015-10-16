//判断此商品是否来自于推荐栏
	function isFromRecommend(url){
		if (url.indexOf("req_id=") == -1){
			return false;
		} else {
			return true;
		}
	}
	//如果此商品来自推荐栏，得到推荐的reqId
	function getReqId(url){
		var str = "req_id=";
		idx = url.indexOf(str);
		var reqid = url.slice(idx + str.length); 
		return reqid;
	}
	window.bfd_onload = function() {
		var client = new brs.Client("Cd1youshang");
		var p = new brs.PackedRequest();	
		var url = self.location.href;	
		if (isFromRecommend(url)) {
			var req_id = getReqId(url);
			p.cr = new brs.ClickRecItem(strbfdusrid,bfd_id,bfd_bfdsession,req_id);
		} else {
			p.a = new brs.AddItem(bfd_id, bfd_gdsname, "http://www.d1.com.cn/product/"+bfd_id);
			p.a.image_link = bfd_smallimg;
			p.a.price =bfd_price;
			p.a.category = new Array(bfd_category);
			p.v = new brs.VisitItem(strbfdusrid, bfd_id, bfd_bfdsession);
		}
		p.rec1 = new brs.RecByFreqBoughtTogether([bfd_id], bfd_bfdsession , 6);
		p.rec2 = new brs.RecByViewUltiBought([bfd_id], bfd_bfdsession , 2);
		p.rec2.output_mod = "simple";
		p.rec3 = new brs.RecByViewAlsoView([bfd_id], bfd_bfdsession,6);// 默认返回10条结果
		client.invoke(p, "cb_recommend");
	}

	// 回调函数：用于处理推荐请求的返回结果。即,将推荐结果展示在推荐栏中，您可以根据需要修改
	function cb_recommend(json) {
		if(typeof json.rec1 == 'undefined') return;
		var rec1_data = json.rec1[2];
		var rec1_reqid = json.rec1[1];
		var result_2 = json.rec2;
		var code_2 = result_2[0];
		if (code_2 == 0){
			var rec2_reqid = result_2[1];
			var item_info_2 = result_2[2];
			var rec2_data ="";
			var rec2_percent ="";
			for(var k=0;k<item_info_2.length;k++){
				if (k==0){
					rec2_data=item_info_2[k][0];
					rec2_percent=item_info_2[k][5];
				}else{
					rec2_data+=","+item_info_2[k][0];
					rec2_percent+=","+item_info_2[k][5];
				}
			}
		}
		var rec3_data = json.rec3[2];
		var rec3_reqid = json.rec3[1];
		var _bfdtype=1+"|"+2+"|"+3;
		var rec_reqid=rec1_reqid+"|"+rec2_reqid+"|"+rec3_reqid;
		var rec_data=rec1_data+"|"+rec2_data+"|"+rec3_data.toString();
		var rec_percent=(typeof(rec2_percent) == "undefined" ? "":" |"+rec2_percent+"| |");
		var rec_showstyle=0;
		$.post("/ajax/product/getBFDProductDate.jsp",{"bfdgdsid":rec_data,"bfdtype":_bfdtype,"bfdpercent":rec_percent,"showstyle":rec_showstyle,"reqid":rec_reqid,"m":new Date().getTime()},function(data){
			if(data.success){
				if(typeof data.strrec1_data != 'undefined')	$('#banner1_FreqBoughtTogether').html(data.strrec1_data);
				if(typeof data.strrec2_data != 'undefined') $('#banner2_ViewUltiBought').html(data.strrec2_data);
				if(typeof data.strrec3_data != 'undefined') $('#banner3_ViewAlsoView').html(data.strrec3_data);
			}
		},"json");
	}