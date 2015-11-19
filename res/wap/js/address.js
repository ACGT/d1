function loaddata(){
	             
				  var url=document.URL;
				  var para="";
				  var op="";
				  var mcstid="";
				   if(url.lastIndexOf("?")>0)
				   {
				        para=url.substring(url.lastIndexOf("?")+1,url.length);
						var arr=para.split("&");
						para="";
						for(var i=0;i<arr.length;i++)
						{
						   if(arr[i].split("=")[0]=="op"){
						   op=arr[i].split("=")[1];
						   }
						   if(arr[i].split("=")[0]=="mcstid"){
						   mcstid=arr[i].split("=")[1];
						   }
						}
				   }
				   if((op!=""&&op=="new_save_consignee")||mcstid==''||parseInt(mcstid)==0){
					   BindProvince();
			             changecity();
				   $("#MbrcstAction").val("new_save_consignee");
				   $("#hdnMbrcstID").val(0);
				   $(".m_addaddr .but").text("添加收货人");
				   }else{
				   $("#MbrcstAction").val("update_save_consignee");
				   $("#hdnMbrcstID").val(mcstid);
				   $(".m_addaddr .but").text("修改收货人");
				   $.ajax({
					type: "post",
					dataType: "json",
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",
					url: "/ajax/user/address_info.jsp",
					cache: false,
					data:{id: mcstid,m: new Date().getTime()},
					error: function(XmlHttpRequest, textStatus, errorThrown){
					$('#btnSaveMbrcst').removeAttr('disabled');
					alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
					},
					success: function(json){
					if(json.success){
						FillUpdateMbrcst(json);
					}
					}
					});
				}
}

function FillUpdateMbrcst(modMbrcst){
    var ddlProvince = $('#rprov');
        BindProvince(modMbrcst.ProvID);
    $('#rname').val(modMbrcst.Name);
    changecity(modMbrcst.ProvID, modMbrcst.CityID);
    $('#raddr').val(modMbrcst.RAddress);
    $('#rphone').val(modMbrcst.RPhone);
    $('#rtel').val(modMbrcst.RTelephone);
    if (modMbrcst.is_default==1) {
    	document.getElementById("rflag").checked = true;
    }
    else {
    	document.getElementById("rflag").checked = false;
    }
    	

}
function BindProvince(id){
    var dllProv = $('#rprov');
    $.ajax({
        type: "GET",
        url: "/ajax/user/getProvCity.jsp",
        success: function(data){
        	dllProv.empty();
        	$("<option value=''>==请选择==</option>").appendTo(dllProv);
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function(){
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + (opt[0]==id?" selected":"") + ">" + opt[1] + "</option>").appendTo(dllProv);
                });
            }
        },error: function(XmlHttpRequest){
        	dllProv.empty();
        	$("<option value=''>==请选择==</option>").appendTo(dllProv);
        }
    });
}

function changecity(strProvinceID,strCityID){
    var ddlCity = $('#rcity');
    if (strProvinceID == null || strProvinceID.length == 0){
        ddlCity.empty();
        $("<option value=''>==请选择==</option>").appendTo(ddlCity);
        return;
    }
    
    $.ajax({
        type: "GET",
        url: "/ajax/user/getProvCity.jsp",
        data:{ProvinceID:strProvinceID},
        success: function(data){
        	ddlCity.empty();
        	$("<option value=''>==请选择==</option>").appendTo(ddlCity);
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function(){
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + (strCityID==opt[0]?" selected":"") + ">" + opt[1] + "</option>").appendTo(ddlCity);
                });
            }
        },error: function(XmlHttpRequest){
        	ddlCity.empty();
        	$("<option value=''>==请选择==</option>").appendTo(ddlCity);
        }
    });
}
function isMobile(_str)
{
    return /^1[0-9]{10}$/.test(_str);
}

function CheckMbrcst(rname,raddr,rphone){
  if (typeof(rname) == 'undefined'||rname == null || rname.length == 0){
        $('.msgerr .txt i').html("收货人不能为空！");
		$('.msgerr').show();
		return false;
    }
   if (typeof(raddr) == 'undefined'||raddr == null || raddr.length == 0){
        $('.msgerr .txt i').html("收货地址不能为空！");
		$('.msgerr').show();
		return false;
    }
	 if (typeof(rphone) == 'undefined'||rphone == null || rphone.length == 0){
        $('.msgerr .txt i').html("手机号不能为空！");
		$('.msgerr').show();
		return false;
    }
	  if (!isMobile(rphone)){
        $('.msgerr .txt i').html("无效手机号码！");
		$('.msgerr').show();
        return false;
    }
	   return true;
}
	

function AddMbrcst(){
    var rname = $('#rname').val();
    var rprov = $('#rprov').val();
    var rcity = $.trim($('#rcity').val());
    var raddr = $.trim($('#raddr').val());
    var rphone = $.trim($('#rphone').val());
    var rtel = $.trim($('#rtel').val());
    var rflag = "0";
    if (document.getElementById("rflag").checked) {
    	rflag = "1";
    }
    var strMbrcstID = $.trim($('#hdnMbrcstID').val());
	var MbrcstAction = $.trim($('#MbrcstAction').val());
    var isAdd = (MbrcstAction=="new_save_consignee"?true:false);
    var blnOK = CheckMbrcst(rname,raddr,rphone);
    //alert(MbrcstAction);
    if (blnOK){
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/ajax/user/address_add.jsp",
            cache: false,
            data:{
		        MbrcstID: strMbrcstID,
		        Name: rname,
		        Sex: 0,
		        ProvinceID: rprov,
		        CityID: rcity,
		        RAddress: raddr,
		        RPhone: rphone,
		        TelePhone: rtel,
		        REmail: "",
		        RZipcode: "",
		        RFlag: rflag,
		        Action: MbrcstAction
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
		    	 $('.msgerr .txt i').html("添加失败！");
		         $('.msgerr').show();
            },success: function(strRet){
            	
                var iRet;
                var iMbrcstID;
                eval(strRet);
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                switch (iRet){
                    case -201:
                      $('.msgerr .txt i').html("会员ID参数出错！");
		              $('.msgerr').show();
                        break;
                    case -202:
                         $('.msgerr .txt i').html("姓名超过20个字符长度(一个汉字占两个字符)！");
		              $('.msgerr').show();
                        break;
                    case -203:
                          $('.msgerr .txt i').html("请选择省份！");
		              $('.msgerr').show();
                        break;
                    case -204:
                         $('.msgerr .txt i').html("请选择城市！");
		              $('.msgerr').show();
                        break;
                    case -205:
                        $('.msgerr .txt i').html("地址超200个字符(一个汉字占两个字符)！");
		              $('.msgerr').show();
                        break;
                    case -206:
                       $('.msgerr .txt i').html("已存在相同姓名和地址的收货人！");
		              $('.msgerr').show();
                        break;
                    case -207:
                      $('.msgerr .txt i').html("添加收货人失败！！");
		              $('.msgerr').show();
                        break;
                    case 1:
                           window.location.href='/wap/flowcheck.html';
                        break;
                }
            }
        });
    }
}