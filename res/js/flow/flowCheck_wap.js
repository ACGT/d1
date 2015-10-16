////flowCheck.jsp
var iSpeed = 2000;
var iInterVal = 1000;
$(document).ready(function(){
	if($('#divLoadMbrcst').length>0) ShowMbrcst(); //��ʾ�ջ����б�
});
//��ʾ�ջ����б�
function ShowMbrcst(){
	$.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/getAddressHtml_wap.jsp",
        cache: false,
        error: function(XmlHttpRequest){
        	alert("获取地址失败，请刷新页面！");
        },success: function(json){
        	$('#divLoadMbrcst').hide();
        	if(json.success){
        		$('#divMbrcstList').show();
                $('#divMbrcstList').empty();
                $('#divMbrcstList').html(json.message);
                $('#tblMbrcstList').show();
                $('#divHint').hide();
                
                //��ʾ��
                var rdoMbrcstList = $('#tblTop5Mbrcst input[type=radio][name=rdoMbrcstList][value='+json.LastAddressID+']').get(0);
                if (rdoMbrcstList != null){
                	rdoMbrcstList.checked = true;
                }else{
                	rdoMbrcstList = $('#tblTop5Mbrcst input[type=radio][name=rdoMbrcstList]').get(0);
                	if (rdoMbrcstList != null){
                		rdoMbrcstList.checked = true;
                	}
                }
                if (rdoMbrcstList != null){
                	loadprice();
                	//ShowPayList(rdoMbrcstList.value);
                	//ShowTkt(); //��ʾ�Ż�ȯ
                }
        	}else{
        		alert(json.message);
        		window.location.href="/wap/flowCheck.jsp";
        	}
        }
    });
}


//�������ջ��˰�ť
function ToggleAddEditMbrcst(){
    $('#btnAddEditMbrcst').hide();
    if ($('#tblAddEditMbrct').is(":hidden")){
    	$('#tblAddEditMbrct').show();
        var ddlProvince = $('#ddlProvince');
        if (ddlProvince.get(0).options.length <= 1){
            BindProvince("-1");
        }
    }
}

// �ջ��˱?���
function CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode){
    var blnSuccess = true;
    if (!CheckName()) blnSuccess = false;
    if (!CheckProvince()) blnSuccess = false;
    if (!CheckCity()) blnSuccess = false;
    if (!CheckRAddress()) blnSuccess = false;
    if (!CheckRPhone()) blnSuccess = false;
    if (!CheckTelePhone()) blnSuccess = false;
    if (!CheckREmail()) blnSuccess = false;
    if (!CheckRZipcode()) blnSuccess = false;
    return blnSuccess;
}

//����ջ�������
function CheckName(strName){
    if (typeof(strName) == 'undefined'){
        strName = $.trim($('#txtName').val());
    }
    var spanName = $('#spanName');
    if (strName == null || strName.length == 0){
    	 spanName.html('姓名不能为空！');
        spanName.show();
        return false;
    }else{
        spanName.hide();
    }
    return true;
}

// ���ʡ��
function CheckProvince(strProvince){
    if (typeof (strProvince) == 'undefined'){
        strProvince = $.trim($('#ddlProvince').val());
    }
    var spanProvinceCity = $('#spanProvinceCity');
    if (strProvince == null || strProvince.length == 0){
    	 spanProvinceCity.html('请选择省份！');
        spanProvinceCity.show();
        return false;
    }else{
        spanProvinceCity.hide();
    }
    return true;
}

// ������
function CheckCity(strCity){
    if (typeof (strCity) == 'undefined'){
        strCity = $.trim($('#ddlCity').val());
    }
    var spanProvinceCity = $('#spanProvinceCity');
    if (strCity == null || strCity.length == 0){
    	 spanProvinceCity.html('请选择城市！');
        spanProvinceCity.show();
        return false;
    }else{
        spanProvinceCity.hide();
    }
    return true;
}

// ����ַ
function CheckRAddress(strRAddress){
    if (typeof(strRAddress) == 'undefined'){
        strRAddress = $.trim($('#txtRAddress').val());
    }
    var spanRAddress = $('#spanRAddress');
    if (strRAddress == null || strRAddress.length == 0){
    	 spanRAddress.html('地址不能为空！');
        spanRAddress.show();
        return false;
    }else{
        spanRAddress.hide();
    }
    return true;
}

// ����ֻ����
function CheckRPhone(strRPhone){
    if (typeof(strRPhone) == 'undefined'){
        strRPhone = $.trim($('#txtRPhone').val());
    }
    var spanRPhone = $('#spanRPhone');
    if (strRPhone == null || strRPhone.length == 0){
    	   spanRPhone.html('手机号码不能为空！');
        spanRPhone.show();
        return false;
    }
    if (!isMobile(strRPhone)){
    	 spanRPhone.html('无效手机号码！');
        spanRPhone.show();
        return false;
    }
    spanRPhone.html('');
    spanRPhone.hide();
    return true;
}

// ���̶��绰
function CheckTelePhone(strTelePhone){
    if (typeof (strTelePhone) == 'undefined'){
        strTelePhone = $.trim($('#txtTelePhone').val());
    }
    var spanTelePhone = $('#spanTelePhone');
    if (strTelePhone != null && strTelePhone.length > 0){
        if (!isPhoneCall(strTelePhone)){
        	 spanTelePhone.html('无效电话号码！');
            spanTelePhone.show();
            return false;
        }
    }
    spanTelePhone.html('');
    spanTelePhone.hide();
    return true;
}

// ��������ַ
function CheckREmail(strREmail){
    if (typeof (strREmail) == 'undefined'){
        strREmail = $.trim($('#txtREmail').val());
    }
    var spanREmail = $('#spanREmail');
    if (strREmail == null || strREmail.length == 0){
    	  spanREmail.html('邮箱地址不能为空！');
        spanREmail.show();
        return false;
    }
    if (!isEmail(strREmail)){
    	 spanREmail.html('无效邮箱地址！');
        spanREmail.show();
        return false;
    }
    spanREmail.html('');
    spanREmail.hide();
    return true;
}

// �����������
function CheckRZipcode(strRZipcode){
    if (typeof (strRZipcode) == 'undefined'){
        strRZipcode = $.trim($('#txtRZipcode').val());
    }
    var spanRZipcode = $('#spanRZipcode');
    if (strRZipcode == null || strRZipcode.length == 0){
    	spanRZipcode.html('邮政编码不能为空！');
        spanRZipcode.show();
        return false;
    }
    if (!isPostalCode(strRZipcode)){
    	 spanRZipcode.html('无效邮政编码！');
        spanRZipcode.show();
        return false;
    }
    spanRZipcode.html('');
    spanRZipcode.hide();
    return true;
}

// �ı�ʡ��ѡ��
function ChangeProv(ddlProv){
    GetNextLevel(ddlProv, "/ajax/user/getProvCity.jsp", "ProvinceID", "#ddlCity");
    if (CheckProvince()){
        CheckCity();
    }
}

//�����˵�
function GetNextLevel(vID, vUrl, vParam, vTargetID){
	var ParentID = $(vID).val();
	var str = vParam + "=" + ParentID;
    var dllSub = $(vTargetID);
    
	$.ajax({
      type: "GET",
      url: vUrl,
      data: str,
      success: function(data){
          if (data != "-1"){
        	  dllSub.empty();
        	  $("<option value=''>==请选择==</option>").appendTo(dllSub);
              var subject = data.split(",");
              $.each(subject, function(){
                  var opt = this.split("|");
                  $("<option value=" + opt[0] + ">" + opt[1] + "</option>").appendTo(dllSub);
              });
          }else{
        	  dllSub.empty();
        	  $("<option value=''>==请选择==</option>").appendTo(dllSub);
          }
      },error: function(request, settings){
    	  dllSub.empty();
    	  $("<option value=''>==请选择==</option>").appendTo(dllSub);
      }
  });
}
//��ʡ���½������
function BindProvince(id){
    var dllProv = $('#ddlProvince');
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
//��ʡ���µĳ���
function BindProvCity(strProvinceID, strCityID){
    var ddlCity = $('#ddlCity');
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
//ȡ���޸�
function CancelMbrcst(){
	$('#hdnMbrcstID').val("0");
	$('#MbrcstAction').val("new_save_consignee");
    $('#btnAddEditMbrcst').show();
    ReSetMbrcst();
    $('#tblAddEditMbrct').hide();
}
//�����ջ���
function AddMbrcst(type){
	var i=0;
	var strName = $.trim($('#txtName').val());
    var strSex = $('input[type=radio][name=rdoSex]:checked').val();
    if(strSex==null){
    	strSex=0;
    	i=1;
    }
  
    var strProvinceID = $('#ddlProvince').val();
    var strCityID = $('#ddlCity').val();
    var strRAddress = $.trim($('#txtRAddress').val());
    var strRPhone = $.trim($('#txtRPhone').val());
    var strTelePhone = $.trim($('#txtTelePhone').val());
    var strREmail = $.trim($('#txtREmail').val());
    var strRZipcode = $.trim($('#txtRZipcode').val());
    var strMbrcstID = $.trim($('#hdnMbrcstID').val());
    var MbrcstAction = $.trim($('#MbrcstAction').val());
    var isAdd = (MbrcstAction=="new_save_consignee"?true:false);
    
    var blnOK = CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode);
    if (blnOK){
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/ajax/user/address_add.jsp",
            cache: false,
            data:{
		        MbrcstID: strMbrcstID,
		        Name: strName,
		        Sex: strSex,
		        ProvinceID: strProvinceID,
		        CityID: strCityID,
		        RAddress: strRAddress,
		        RPhone: strRPhone,
		        TelePhone: strTelePhone,
		        REmail: strREmail,
		        RZipcode: strRZipcode,
		        Action: MbrcstAction
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
		    	var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.removeAttr('disabled');
                btnSaveMbrcst.removeClass('WaitSaveMbrcst');
                btnSaveMbrcst.addClass('SaveMbrcst');
                btnSaveMbrcst.attr('value', '');
                alert('添加收货人失败！');
                spanMbrcstMsg.html('添加收货人失败！');
                spanMbrcstMsg.show();
                setInterval(FadeOutMbrcstMsg, iInterVal);
            },success: function(strRet){
                var iRet;
                var iMbrcstID;
                eval(strRet);
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                switch (iRet){
                    case -201:
                    	 alert('会员ID参数出错！');
                         spanMbrcstMsg.html('会员ID参数出错！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -202:
                    	alert('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -203:
                    	 alert('请选择省份！');
                         spanMbrcstMsg.html('请选择省份！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -204:
                    	 alert('请选择城市！');
                         spanMbrcstMsg.html('请选择城市！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -205:
                    	 alert('地址超200个字符(一个汉字占两个字符)！');
                         spanMbrcstMsg.html('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -206:
                    	  alert('已存在相同姓名和地址的收货人！');
                          spanMbrcstMsg.html('已存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -207:
                    	   alert('添加收货人失败！');
                           spanMbrcstMsg.html('添加收货人失败！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case 1:
                    	if(isAdd){
                            spanMbrcstMsg.hide();
                            if(typeof type == 'undefined'){
    	                        AppendMbrcstRow(iMbrcstID);
    	                        CancelMbrcst();
                            }else{
                            	if(i==1){
                            		alert('添加成功！');
                            		window.location.href='/user/address.jsp';
                            		}
                            	else{window.location.href='/wap/flowCheck.jsp';}
                            }
                    	}else{
                    		if(i==1){
                    			CancelMbrcst();
                    			alert('修改收货人信息成功！');
                        		window.location.href='/wap/user/address.jsp';
                        		}
                    		 spanMbrcstMsg.html('修改收货人信息成功！');
                             spanMbrcstMsg.fadeIn(iSpeed);
                             UpdateMbrcstRow();
                             setInterval(FadeOutMbrcstMsg, 1000);
                             ChangeMbrcst($('#hdnMbrcstID').get(0));
                             CancelMbrcst();
                             break;
                    	}
                        break;
                }
            },beforeSend: function(){
                var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.attr('disabled', 'disabled');
                btnSaveMbrcst.removeClass('SaveMbrcst');
                btnSaveMbrcst.addClass('WaitSaveMbrcst');
                btnSaveMbrcst.attr('value', '  保存中,请稍等...');
            },complete: function(){
            	if(typeof(type) == 'undefined'){
	                var btnSaveMbrcst = $('#btnSaveMbrcst');
	                btnSaveMbrcst.removeAttr('disabled');
	                btnSaveMbrcst.removeClass('WaitSaveMbrcst');
	                btnSaveMbrcst.addClass('SaveMbrcst');
	                btnSaveMbrcst.attr('value', '');
            	}
            }
        });
    }
}
//����޸��ջ�����Ϣ
function GetUpdMbrcst(addId){
    $('#btnAddEditMbrcst').hide();
    $.ajax({
        type: "post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/user/address_info.jsp",
        cache: false,
        data:{id: addId,m: new Date().getTime()},
        error: function(XmlHttpRequest, textStatus, errorThrown){
        	$('#btnSaveMbrcst').removeAttr('disabled');
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(json){
        	if(json.success){
        		FillUpdateMbrcst(json);
        	    //��ʾ�?
        	    if ($('#tblAddEditMbrct').is(":hidden")){
        	    	$('#tblAddEditMbrct').show();
        	    }
        	    $('#hdnMbrcstID').val(addId);
        	    $('#MbrcstAction').val("update_save_consignee");
        	}else{
        		var spanMbrcstMsg = $('#spanMbrcstMsg');
        		alert(json.message);
                spanMbrcstMsg.html(json.message);
                spanMbrcstMsg.fadeIn(iSpeed);
                setInterval(FadeOutMbrcstMsg, iInterVal);
        	}
        },beforeSend: function(){
            $('#btnSaveMbrcst').attr('disabled', 'disabled');
        },complete: function(){
            $('#btnSaveMbrcst').removeAttr('disabled');
        }
    });
}
//ɾ���ջ���
function DeleteMbrcst(addId){
	if(!window.confirm('确认要删除该收货人吗?')) return;
	$.post("/ajax/user/address_del.jsp",{"id":addId,"m":new Date().getTime()},function(json){
		if(json.success){
			$("#address_"+addId).remove();
			var addList = $("input[type='radio'][name='rdoMbrcstList']");
			if(addList.length==0){//ˢ�¸�ҳ�档
				window.location.href='/flowCheck.jsp';
				return;
			}else{//����Ĭ�ϵ�һ��ѡ�С�
				addList.eq(0).attr("checked",true);
			}
			CancelMbrcst();
		}else{
			var spanMbrcstMsg = $('#spanMbrcstMsg');
			spanMbrcstMsg.html(json.message);
            spanMbrcstMsg.fadeIn(iSpeed);
            setInterval(FadeOutMbrcstMsg, iInterVal);
		}
	},"json");
}
//�޸ģ������ջ��˱?
function ReSetMbrcst(){
    $('#tblAddEditMbrct input[type=text]').each(function(){
        $(this).val('');
    })

    $('#tblAddEditMbrct span[id^=span]').each(function(){
        $(this).html('');
        $(this).hide();
    })
    $('#ddlProvince').val('');
    $('#ddlCity').val('');
}
//�����ջ�����Ϣ
function FadeOutMbrcstMsg(){
    var spanMbrcstMsg = $('#spanMbrcstMsg');
    spanMbrcstMsg.fadeOut(iSpeed);
}
//����֧����Ϣ
function FadeOutPayMsg(){
    var spanPayMsg = $('#spanPayMsg');
    spanPayMsg.fadeOut(iSpeed);
}
//�����ͻ�ʱ��
function FadeOutShipTimeMsg(){
    var spanShipTimeMsg = $('#spanShipTimeMsg');
    spanShipTimeMsg.fadeOut(iSpeed);
}
//����޸��ջ�����Ϣ�?
function FillUpdateMbrcst(modMbrcst){
    var ddlProvince = $('#ddlProvince');
    if (ddlProvince.get(0).options.length <= 1){
        BindProvince(modMbrcst.ProvID);
    }
    
    $('#txtName').val(modMbrcst.Name);
    if (modMbrcst.Sex == '0' || modMbrcst.Sex == 0){
        $('#rdoSex0').attr('checked', 'checked');
        $('#rdoSex1').removeAttr('checked');
    }else{
        $('#rdoSex0').removeAttr('checked');
        $('#rdoSex1').attr('checked', 'checked');
    }
    BindProvCity(modMbrcst.ProvID, modMbrcst.CityID);
    $('#ddlProvince').val(modMbrcst.ProvID);
    $('#ddlCity').val(modMbrcst.CityID);
    $('#txtRAddress').val(modMbrcst.RAddress);
    $('#txtRPhone').val(modMbrcst.RPhone);
    $('#txtTelePhone').val(modMbrcst.RTelephone);
    $('#txtREmail').val(modMbrcst.REmail);
    $('#txtRZipcode').val(modMbrcst.RZipCode);
}
//׷���ջ����б���
function AppendMbrcstRow(iMbrcstID){
	$('#spanMbrcstMsg').html('添加收货人信息成功！').show();
    setInterval(FadeOutMbrcstMsg, iInterVal);
    
    var strMbrID = $('#hdnMbrID').val();
    var tblTop5Mbrcst = $('#tblTop5Mbrcst');
    if (tblTop5Mbrcst.length==0){
        ShowMbrcst();
        return;
    }
    tblTop5Mbrcst.append("<tr id=\"address_"+iMbrcstID+"\">" +
    		"<td ><input type=\"radio\" name=\"rdoMbrcstList\" value=\""+iMbrcstID+"\" onclick=\"ChangeMbrcst(this)\"></td>" +
    		"<td  class=\"t00\" id=\"tdName"+iMbrcstID+"\" align=\"left\">"+$('#txtName').val()+"</td>" +
    		"<td align=\"left\" class=\"t00\" id=\"tdAddress"+iMbrcstID+"\">"+$('#txtRAddress').val()+"<br/>&nbsp;" +
    		$('#txtRPhone').val()+
    		"&nbsp;<a href=\"###\" onclick=\"javascript:GetUpdMbrcst('"+iMbrcstID+"')\">修改</a>" +
    		"&nbsp;<a href=\"###\" onclick=\"javascript:DeleteMbrcst('"+iMbrcstID+"')\">删除</a></td>" +
    		"</tr>");
    $('#address_'+iMbrcstID).find("input[name=rdoMbrcstList]").attr("checked",true);
}
//�޸��ջ�����
function UpdateMbrcstRow(){
    var addId = $('#hdnMbrcstID').val();

    $('#tdAddress'+addId).html($('#txtRAddress').val());
    $('#tdName'+addId).html($('#txtName').val());
}
//����ջ��˵�ѡ��ť
//rdoSelected:��ѡ��ť
//objHplUpdate:�޸�����
function ChangeMbrcst(rdoSelected){
  var blnUpdate = false;//�޸ĵ�ǰ�ջ��˼���
  if(rdoSelected.value!=$('#hdnMbrcstID').val()){
	  blnUpdate = true;
  }
  if (blnUpdate){
	  $('#hdnMbrcstID').val(rdoSelected.value);

	  $.post("/ajax/flow/isCanHF.jsp",{"MbrcstID":$('#hdnMbrcstID').val(),"m":new Date().getTime()},function(json){
		  if(json.success){
			  JudgeCanHF(json.CanHF);
		  }else{
			  alert(json.message);
		  }
		  loadprice();
	  },"json");
  }// if
}

//判断是否支持货到款
function JudgeCanHF(iCanHF){
    if (iCanHF == 1 || iCanHF == '1'){
        $('#trPayID0').show();
        var iChecked = $('input[type=radio][name=req_payid]:checked').length;
        if (iChecked == null || iChecked <= 0){
            var spanPayMsg = $('#spanPayMsg');
            spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
            spanPayMsg.fadeIn(iSpeed);
            setInterval(FadeOutPayMsg, iInterVal + 2000);
        }
    }else{
        var id_paykindr1 = $('#id_paykindr1');
        if (id_paykindr1.length>0){
            if (id_paykindr1.attr('checked')==true){
                var spanPayMsg = $('#spanPayMsg');
                spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
                spanPayMsg.fadeIn(iSpeed);
                setInterval(FadeOutPayMsg, iInterVal + 2000);
            }else{//当前无选中项
                var iChecked = $('input[type=radio][name=req_payid]:checked').length;
                if (iChecked == null || iChecked <= 0){
                    var spanPayMsg = $('#spanPayMsg');
                    spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
                    spanPayMsg.fadeIn(iSpeed);
                    setInterval(FadeOutPayMsg, iInterVal + 2000);
                }
            }
            id_paykindr1.attr('checked',false);
            $('#trPayID0').hide();
        }
    }
}
//使用优惠券
function useTicket(){
	$("#divTktList").hide();
	$("#tTicket").show();
	loadprice();  
}
//取消使用优惠券
function cancleTicket(){
	 var sendpay = $('input[type=radio][name=tktid]');
	    if(sendpay.length > 0){
	    	sendpay.each(function(){
	    		$(this).attr('checked',false);
	    	});
	    }
	    $("#tTicket").hide();
	    loadprice();  
}

function showmoemo(){
$("#tr1").show();	
$("#tr2").show();
}
function clearmoemo(){
	$("#txtCustomerMemo").val("");
}
function canclememo(){
	$("#txtCustomerMemo").val("");
	$("#tr1").hide();	
	$("#tr2").hide();	
}

//ajax更新总金额
function loadprice(){
    var aj_tktid = -1; //选择的优惠券ID
    var aj_payid = -1; //选择的支付方式ID

    // 遍历支付方式, 记录选中项
    var req_pay = $('input[type=radio][name=req_payid]');
    if (req_pay.length > 0){
    	req_pay.each(function(){
    		if(this.checked){
    			aj_payid = this.value;
    			return false;
    		}
    	});
    }
    // 遍历优惠券，记录选中项
    var sendpay = $('input[type=radio][name=tktid]');
    if(sendpay.length > 0){
    	sendpay.each(function(){
    		if(this.checked && this.value !="0"){
    			aj_tktid = this.value;
    			return false;
    		}
    	});
    }

    var strGdsFee = $('#lblGdsFee').text(); //商品金额
    var iIsUsePrepay = 0;
    var chkPrepay = $('#chkPrepay').get(0);
    if (chkPrepay != null && chkPrepay.checked){
        iIsUsePrepay = 1;
    }
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/loadPrice_wap.jsp",
        cache: false,
        data:{tktid: aj_tktid,payid: aj_payid,IsUsePrepay: iIsUsePrepay,addId:$("input[type='radio'][name='rdoMbrcstList']:checked").val()},
        error: function(XmlHttpRequest, textStatus, errorThrown){
            alert("更新总金额出错，请刷新总金额！");
        },success: function(json){
        	if(json.success){
        		$('#spanShipFee').html(json.ShipFee);
                $('#spanTktValue').html(json.TktValue);
                $('#spanUsePrepay').html(json.UsePrepay);
                $('#lblTotal').html(json.Total);
                $('#lblGdsFee').html(json.lblGdsFee);
                $("#tvalue").html(json.TktValue);
                if(json.tblPrePay>0){
                	$('#tblPrePay').html(json.litPrepay);
                }else{
                	$('#tblPrePay').html('');
                }
        	}else{
        		alert(json.message);
        		if(json.message == '找不到地址！'){
        			window.location.href='/wap/flowCheck.jsp';
        		}
        	}
        }
    });
}
//检查券支付方式及计算结算信息
function paykindrchange(){
    //检查卷
    checktktpayid();
    loadprice();
}
//检查券的支付方式
function checktktpayid(){
    var payid = -1; //选中的支付方式
    var tktid = '0';
    var sendpay = $('input[type=radio][name=tktid]');
    if(sendpay.length > 0){
    	var req_pay = $('input[type=radio][name=req_payid]');
    	if(req_pay.length>0){
    		req_pay.each(function(){
		    	if(this.checked){
		    		payid = this.value;//选中的支付方式
		    		return false;
		    	}
		    });
    	}
    	sendpay.each(function(){
    		var tktid = this.value;
    		var tktpayid = $(this).attr("payId");//券要求的支付方式ID
    		if(tktid != '0' && tktpayid == payid){//券要求的支付方式与选择的支付方式相符
    			this.disabled=false;
    		}else if (tktid != '0' && (tktpayid == '' || parseInt(tktpayid) < 0)){//券无要求支付方式
    			this.disabled=false;
    		}else if (tktid != '0' && tktpayid != payid){//选择的支付方式与券要求的支付方式不一致
    			this.checked = false;
    			this.disabled = true;
    		}
    	});
    }
}
//显示券
function ShowTkt(){
	var payid = -1; //选中的支付方式
	var req_pay = $('input[type=radio][name=req_payid]');
	if(req_pay.length>0){
		req_pay.each(function(){
	    	if(this.checked){
	    		payid = this.value;//选中的支付方式
	    	}
	    });
	}
    $.ajax({
        type: "post",
        dataType: "html",
        url: "/ajax/flow/getTktHtml_wap.jsp",
        data:{payId: payid},
        cache: false,
        error: function(XmlHttpRequest){
            alert("获取优惠券出错！");
        },success: function(strHtml){
        	$('#divTktList').show();
            $('#divTktList').empty();
            $(strHtml).appendTo($('#divTktList'));
            $('#useTKT').get(0).onclick = function(){
            	_d1.fnEmpty();
            };
        },beforeSend: function(){
            $('#divLoadTkt').show();
            $('#divTktList').hide();
        },complete: function(){
            $('#divLoadTkt').hide();
            $('#divTktList').show();
        }
    });
}
//隐藏网上支付区域
function HidePayNet(){
    if ($('#rdoPayShow1').length>0){
        $('#rdoPayShow1').attr("checked",false);
        $('#trPayNet').hide();
    }
}
//激活券
function ActivateTkt(iIsPingAn){
	var payid = -1; //选中的支付方式
	var req_pay = $('input[type=radio][name=req_payid]');
	if(req_pay.length>0){
		req_pay.each(function(){
	    	if(this.checked){
	    		payid = this.value;//选中的支付方式
	    	}
	    });
	}
	var strCardNo = $('#txtCardNo').val();
    var btnActivate = $('#btnActivate');
    if (strCardNo == null || strCardNo.length == 0){
        alert('请输入优惠券号码!');
        return;
    }
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/activateTicket.jsp",
        cache: false,
        data:{CardNo: strCardNo,payId:payid},
        error: function(XmlHttpRequest){
            alert("激活优惠券错误！");
            btnActivate.removeAttr('disabled');
            btnActivate.attr('value', '激活优惠券');
        },
        success: function(json){
            if(json.success){
                alert('激活优惠券成功!');
                ShowTkt();
            }else{
                alert(json.message);
            }
        },beforeSend: function(){
            btnActivate.attr('disabled', 'disabled');
            btnActivate.removeClass('ActivateEquan');
            btnActivate.addClass('WaitActiveEQ');
            btnActivate.attr('value', '激活中,请稍等...');
        },complete: function(){
            btnActivate.removeAttr('disabled');
            btnActivate.removeClass('WaitActiveEQ');
            btnActivate.addClass('ActivateEquan');
            btnActivate.attr('value', '');
        }
    });
}
//下单按钮
function sendupdate(){
	var iIsChkMbrcst = $('table input[type=radio][name=rdoMbrcstList]:checked');
    if (iIsChkMbrcst == null || iIsChkMbrcst.length==0){
        alert("请选择收货人！");
        window.location.href="#address_top";
        var spanMbrcstMsg1 = $("#spanMbrcstMsg");
        spanMbrcstMsg1.html('请选择收货人！');
        spanMbrcstMsg1.fadeIn(iSpeed);
        setInterval(FadeOutMbrcstMsg, iInterVal + 2000);
        return false;
    }
    //遍历检查是否选中支付方式
    var intSelFlag = 0;
    var payid = -1; //选中的支付方式
	var req_pay = $('input[type=radio][name=req_payid]');
	if(req_pay.length>0){
		req_pay.each(function(){
	    	if(this.checked){
	    		intSelFlag = 1;//选中的支付方式
	    		payid = this.value;
	    		return false;
	    	}
	    });
	}
	//全额E券支付
    var strPayID22 = $('#hdnPayID22').val();
    if (strPayID22 == '22' || strPayID22 == 22){
        intSelFlag = 1;
        payid = "23";
    }
	if (intSelFlag == 0){
        alert("请选择支付方式！");
        window.location.href="#pay_top";
        var spanPayMsg1 = $('#spanPayMsg');
        spanPayMsg1.html('请选择支付方式！');
        spanPayMsg1.fadeIn(iSpeed);
        setInterval(FadeOutPayMsg, iInterVal + 2000);
        return false;
    }
	//送货时间要求
    var submitFlag1 = 0;
    var deliverStr = "";
    var shipTime = $('input[type=radio][name=shipTime]');
    if(shipTime.length>0){
    	shipTime.each(function(){
	    	if(this.checked){
	    		submitFlag1 = 1;//选中的支付方式
	    		deliverStr = this.value;
	    		return false;
	    	}
	    });
	}
    if (submitFlag1 == 0){
        window.location.href="#shipTime_top";
        var spanShipTimeMsg = $('#spanShipTimeMsg');
        spanShipTimeMsg.html('请选择送货时间！');
        spanShipTimeMsg.fadeIn(iSpeed);
        setInterval(FadeOutShipTimeMsg, iInterVal + 5000);
        $.alert("请选择送货时间！");
        return false;
    }
    var selecttkt; //是否选择了优惠券
    var havetkt; //是否使用了优惠券
    var ticketIdStr = "";
    var tktid = $('input[type=radio][name=tktid]');
    if(tktid.length>0){
    	tktid.each(function(){
    		if(this.value != "0"){
    			havetkt = true;
    		}
    		if(this.checked && this.value != "0"){
    			selecttkt = true;
    			ticketIdStr = this.value;
    		}
    	});
    }
    if (havetkt && !selecttkt){//有优惠券但未使用
    	//if (!window.confirm('你有可以使用的优惠券,是否确定不使用!')) return false;
    }
    
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/flowDone.jsp",
        cache: false,
        data:{addressId: iIsChkMbrcst.val(),payId:payid,deliver:deliverStr,ticketId:ticketIdStr,userPrepay:$('#chkPrepay').attr('checked')==true?1:0,memo:$('#txtCustomerMemo').val()},
        error: function(XmlHttpRequest){
            alert("创建订单失败，请重新再试或者联系客服处理！");
            $('#divBtnOrder').show();
            $('#Submit33').attr("disabled",false);
            $('#divLoadOrder').hide();
        },
        success: function(json){
            if(json.success){
                $('#divLoadOrder').html('下单成功，正在跳转！').css('color','blue');
                top.location.href='/wap/flowDone.jsp';
            }else{
                alert(json.message);
                $('#divBtnOrder').show();
            	$('#Submit33').attr("disabled",false);
                $('#divLoadOrder').hide();
            }
        },beforeSend: function(){
        	$('#divBtnOrder').hide();
        	$('#Submit33').attr("disabled",true);
            $('#divLoadOrder').show();
        }
    });
}