var iSpeed = 2000;
var iInterVal = 1000;
var rdoPrevMbrcst = null;//当前选中的收货人单选按钮

$(document).ready(function()
{
    ShowMbrcst(); //显示收货人列表
    //ShowTkt(); //显示优惠券
});
//end document

//显示收货人列表
function ShowMbrcst()
{
    var strMbrID = $.trim($('#hdnMbrID').val());

    $.ajax({
        type: "post",
        dataType: "html",
        url: "GetMbrcstHtml.aspx",
        cache: false,
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(strHtml)
        {
            if (isNaN(strHtml))
            {
                $('#divMbrcstList').show();
                $('#divMbrcstList').empty();
                $(strHtml).appendTo($('#divMbrcstList'));
                $('#tblMbrcstList').show();
                $('#divHint').hide();

                //支付方式
                $('#tblPayHead').show();
                $('#divPayList').show();

                //送货时间
                $('#tblShipTimeHead').show();
                $('#tblShipTime').show();

                // 商品清单
                $('#tblGdsListHead').show();
                $('#tblBackCart').show();
                $('#tblGdsList').show();

                // 结算清单
                $('#tblAccountHead').show();
                $('#divTktList').show();
                $('#tblPrePay').show();
                $('#tblAccount').show();

                //留言
                $('#tblGestHead').show();
                $('#tblGest').show();

                //下单
                $('#tblOrder').show();
            }
            else
            {
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                var iRet = parseInt(strHtml);
                switch (iRet)
                {
                    case -201:
                        alert('您还未登录！');
                        spanMbrcstMsg.html('您还未登录！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -202:
                        alert('查询会员ID出错！');
                        spanMbrcstMsg.html('查询会员ID出错！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -203:
                        alert('查询收货人信息出错');
                        spanMbrcstMsg.html('查询收货人信息出错！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -204: //无收货人显示添加收货人表单
                        $('#tblMbrcstList').hide();
                        ToggleAddEditMbrcst();
                        $('#divHint').show();

                        //支付方式
                        $('#tblPayHead').hide();
                        $('#divPayList').hide();

                        //送货时间
                        $('#tblShipTimeHead').hide();
                        $('#tblShipTime').hide();

                        // 商品清单
                        $('#tblGdsListHead').hide();
                        $('#tblBackCart').hide();
                        $('#tblGdsList').hide();

                        // 结算清单
                        $('#tblAccountHead').hide();
                        $('#divTktList').hide();
                        $('#tblPrePay').hide();
                        $('#tblAccount').hide();

                        //留言
                        $('#tblGestHead').hide();
                        $('#tblGest').hide();

                        //下单
                        $('#tblOrder').hide();
                        break;
                } //switch
            } //else
        },
        beforeSend: function()
        {
            $('#divLoadMbrcst').show();
        },
        complete: function()
        {
            $('#divLoadMbrcst').hide();
            var strMbtmstID = $('#hdnMbrID').val();
            var rdoValue = strMbrID + '_';
            if (typeof (LastMbrcstID) != 'undefined' && LastMbrcstID != null)
            {
                rdoValue = rdoValue + LastMbrcstID
            }
            //选中收货人单选按钮
            var rdoMbrcstList = $('table input[type=radio][name=rdoMbrcstList][value=' + rdoValue + ']').get(0);
            if (rdoMbrcstList != null)
            {
                rdoMbrcstList.checked = true;
                rdoPrevMbrcst = rdoMbrcstList;
            }
            else
            {
                rdoMbrcstList = $('#tblTop5Mbrcst input[type=radio][name=rdoMbrcstList]').get(0);
                if (rdoMbrcstList != null)
                {
                    rdoMbrcstList.checked = true;
                    rdoPrevMbrcst = rdoMbrcstList;
                }
            }

            if (rdoMbrcstList != null)
            {
                var hdnMbrcstID = $(rdoMbrcstList).next().next('input[type=hidden][id^=hdnMbrcstID]');
                ShowPayList(hdnMbrcstID.val());
                ShowTkt(); //显示优惠券
            }
        }
    });
}

// 显示支付方式
function ShowPayList(iMbrcstID)
{
    $.ajax({
        type: "post",
        dataType: "html",
        url: "GetPayHtml1.aspx",
        cache: false,
        data:
        {
            MbrcstID: iMbrcstID
        },
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(strHtml)
        {
            if (isNaN(strHtml))
            {
                $('#divLoadPay').show();
                $('#divPayList').empty();
                $(strHtml).appendTo($('#divPayList'));
            }
            else
            {
                var spanPayMsg = $('#spanPayMsg');
                var iRet = parseInt(strHtml);
                switch (iRet)
                {
                    case -201:
                        alert('您还未登录！');
                        spanPayMsg.html('您还未登录！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -202:
                        alert('收货人参数ID出错！');
                        spanPayMsg.html('收货人参数ID出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -203:
                        alert('更新登录信息出错！');
                        spanPayMsg.html('更新登录信息出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -204:
                        alert('查询收货人信息出错！');
                        spanPayMsg.html('查询收货人信息出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -205:
                        alert('查询团购标识出错！');
                        spanPayMsg.html('查询团购标识出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -206:
                        alert('查询团购兑换商品数量出错！');
                        spanPayMsg.html('查询团购兑换商品数量出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -220:
                        $('#tblPayArea').hide();
                        document.getElementById('hdnPayID22').value = 22;
                        break;
                    case -207:
                        alert('查询支付宝支付方式出错！');
                        spanPayMsg.html('查询支付宝支付方式出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -208:
                        alert('查询网上支付方式出错！');
                        spanPayMsg.html('查询网上支付方式出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -209:
                        alert('无收货人城市是否支持货到付款的状态！');
                        spanPayMsg.html('无收货人城市是否支持货到付款的状态！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                    case -210:
                        alert('判断收货人城市是否支持货到付款出错！');
                        spanPayMsg.html('判断收货人城市是否支持货到付款出错！');
                        spanPayMsg.fadeIn(iSpeed);
                        setInterval(FadeOutPayMsg, iInterVal);
                        break;
                } //switch
            } //else
        },
        beforeSend: function()
        {
            $('#divLoadPay').show();
        },
        complete: function()
        {
            $('#divLoadPay').hide();

            //如果没有选中的支付方式则给默认值
            var iChecked = $('#tblPayNetList input[type=radio]:checked').length;
            if (iChecked == null || iChecked == 0)//没有选中的子项默认选中第1项
            {
                ShowPayNet();
            }
            
            loadprice();
        }
    });
}
// end function

// 点击添加收货人按钮
function ToggleAddEditMbrcst()
{
    $('#btnAddEditMbrcst').hide();
    var tblAddEditMbrct = document.getElementById('tblAddEditMbrct');
    if (tblAddEditMbrct.style.display == 'none')
    {
        tblAddEditMbrct.style.display = '';
        var ddlProvince = document.getElementById('ddlProvince');
        if (ddlProvince.options.length <= 1)
        {
            BindProvince();
        }
    }
//    else
//    {
//        tblAddEditMbrct.style.display = 'none';
//    }
}

// 保存收货人按钮
function SaveMbrcst()
{
    var strOptMbrCst = $('#hdnOptMbrCst').val();
    if (strOptMbrCst == '1' || strOptMbrCst == 1)
    {
        AddMbrcst();
    }
    else
    {
        UpdateMbrcst();
    }
}

// 新增收货人
function AddMbrcst()
{
    var strName = $.trim($('#txtName').val());
    var strSex = $('input[type=radio][name=rdoSex][:checked]').val();
    var strProvinceID = $('#ddlProvince').val();
    var strCityID = $('#ddlCity').val();
    var strRAddress = $.trim($('#txtRAddress').val());
    var strRPhone = $.trim($('#txtRPhone').val());
    var strTelePhone = $.trim($('#txtTelePhone').val());
    var strREmail = $.trim($('#txtREmail').val());
    var strRZipcode = $.trim($('#txtRZipcode').val());
    var strMbrID = $.trim($('#hdnMbrID').val());
    
    var blnOK = CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode);
    if (blnOK)
    {
        $.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "AddMbrcst.ashx",
            cache: false,
            data:
		    {
		        MbrID: strMbrID,
		        Name: strName,
		        Sex: strSex,
		        ProvinceID: strProvinceID,
		        CityID: strCityID,
		        RAddress: strRAddress,
		        RPhone: strRPhone,
		        TelePhone: strTelePhone,
		        REmail: strREmail,
		        RZipcode: strRZipcode
		    },
            error: function(XmlHttpRequest, textStatus, errorThrown)
            {
                var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.removeAttr('disabled');
                alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
            },
            success: function(strRet)
            {
                var iRet;
                var iMbrcstID;
                eval(strRet);
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                switch (iRet)
                {
                    case -201:
                        alert('会员ID参数出错！');
                        spanMbrcstMsg.html('会员ID参数出错！');
                        spanMbrcstMsg.show();
                        break;
                    case -202:
                        alert('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        break;
                    case -203:
                        alert('请选择省份！');
                        spanMbrcstMsg.html('请选择省份！');
                        spanMbrcstMsg.show();
                        break;
                    case -204:
                        alert('请选择城市！');
                        spanMbrcstMsg.html('请选择城市！');
                        spanMbrcstMsg.show();
                        break;
                    case -205:
                        alert('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        break;
                    case -206:
                        alert('添加失败，已存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.html('添加失败，已存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.show();
                        break;
                    case -207:
                        alert('添加收货人失败！');
                        spanMbrcstMsg.html('添加收货人失败！');
                        spanMbrcstMsg.show();
                        break;
                    case 1:
                        spanMbrcstMsg.hide();
                        AppendMbrcstRow(iMbrcstID);
                        CancelMbrcst();
                        break;
                }
            },
            beforeSend: function()
            {
                var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.attr('disabled', 'disabled');
                btnSaveMbrcst.removeClass('SaveMbrcst');
                btnSaveMbrcst.addClass('WaitSaveMbrcst');
                btnSaveMbrcst.attr('value', '  保存中,请稍等...');
            },
            complete: function()
            {
                var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.removeAttr('disabled');
                btnSaveMbrcst.removeClass('WaitSaveMbrcst');
                btnSaveMbrcst.addClass('SaveMbrcst');
                btnSaveMbrcst.attr('value', '');
            }
        });
    }
}
//end function

// 删除收货人
function DeleteMbrcst(objADelete, iMbrID, iMbrcstID)
{
    if (confirm('确认要删除该收货人吗?'))
    {
        $.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "DeleteMbrcst.aspx",
            cache: false,
            data:
		    {
		        MbrmstID: iMbrID,
		        MbrcstID: iMbrcstID
		    },
            error: function(XmlHttpRequest, textStatus, errorThrown)
            {
                alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
            },
            success: function(strRet)
            {
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                var iRet = parseInt(strRet);
                switch (iRet)
                {
                    case -201:
                        alert('您还未登录！');
                        spanMbrcstMsg.html('您还未登录！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -202:
                        alert('会员ID参数出错！');
                        spanMbrcstMsg.html('会员ID参数出错！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -203:
                        alert('非法进入页面！');
                        spanMbrcstMsg.html('非法进入页面！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -204:
                        alert('收货人ID参数出错！');
                        spanMbrcstMsg.html('非法进入页面！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -200:
                    case -300:
                        alert('删除收货人失败！');
                        spanMbrcstMsg.html('非法进入页面！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case 1:
                        DeleteMbrcstRow(objADelete);
                        DeleteUpdate(iMbrID, iMbrcstID); //删除是当前修改表单的收货人
                        break;
                }
            },
            beforeSend: function()
            {
            },
            complete: function()
            {
            }
        });
    }//if
}
// end function

// 删除是当前修改表单的收货人
function DeleteUpdate(iMbrID, iMbrcstID)
{
    var strOptCst = $('#hdnOptMbrCst').val();
    if (strOptCst == '2' || strOptCst == 2)
    {
        var strMbrID = $('#hdnMbrmstID').val();
        var strMbrcstID = $('#hdnMbrcstID').val();

        if (iMbrID == strMbrID && strMbrcstID == iMbrcstID)
        {
            CancelMbrcst();
        }
    } 
}
// end function

// 获得修改收货人信息
var objACurUpdate = null;
function GetUpdMbrcst(objAUpdate, iMbrID, iMbrcstID)
{
    objACurUpdate = objAUpdate;
    $('#hdnOptMbrCst').val('2');
    $('#hdnMbrmstID').val(iMbrID);
    $('#hdnMbrcstID').val(iMbrcstID);
    $('#btnAddEditMbrcst').hide();
    
    //显示表单
    var tblAddEditMbrct = document.getElementById('tblAddEditMbrct');
    if (tblAddEditMbrct.style.display == 'none')
    {
        tblAddEditMbrct.style.display = '';        
    }

    $.ajax({
        type: "post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "GetUpdMbrcstData.aspx",
        cache: false,
        data:
	    {
	        MbrmstID: iMbrID,
	        MbrcstID: iMbrcstID
	    },
        error: function(XmlHttpRequest, textStatus, errorThrown)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(modMbrcst)
        {
            var iRet = parseInt(modMbrcst.Ret);
            var spanMbrcstMsg = $('#spanMbrcstMsg');
            switch (iRet)
            {
                case -201:
                    alert('您还未登录！');
                    spanMbrcstMsg.html('您还未登录！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case -202:
                    alert('会员ID参数出错！');
                    spanMbrcstMsg.html('会员ID参数出错！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case -203:
                    alert('非法进入页面！');
                    spanMbrcstMsg.html('非法进入页面！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case -204:
                    alert('收货人ID参数出错！');
                    spanMbrcstMsg.html('收货人ID参数出错！');
                    spanMbrcstMsg.show();
                    break;
                case -205:
                    alert('查询收货人信息出错！');
                    spanMbrcstMsg.html('查询收货人信息出错！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case -206:
                    alert('收货人不存在！');
                    spanMbrcstMsg.html('收货人不存在！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case -200:
                case -300:
                    alert('查询收货信息出错！');
                    spanMbrcstMsg.html('查询收货信息出错！');
                    spanMbrcstMsg.fadeIn(iSpeed);
                    setInterval(FadeOutMbrcstMsg, iInterVal);
                    break;
                case 1:                    
                    FillUpdateMbrcst(modMbrcst);
                    break;
            }
        },
        beforeSend: function()
        {
            $('#btnSaveMbrcst').attr('disabled', 'disabled');
        },
        complete: function()
        {
            $('#btnSaveMbrcst').removeAttr('disabled');
        }
    });
}
// end function

// 修改收货人
function UpdateMbrcst()
{
    var iMbrmstID = $('#hdnMbrmstID').val();
    var iMbrcstID = $('#hdnMbrcstID').val();
    var strName = $.trim($('#txtName').val());
    var strSex = $('input[type=radio][name=rdoSex][:checked]').val();
    var strProvinceID = $('#ddlProvince').val();
    var strCityID = $('#ddlCity').val();
    var strRAddress = $.trim($('#txtRAddress').val());
    var strRPhone = $.trim($('#txtRPhone').val());
    var strTelePhone = $.trim($('#txtTelePhone').val());
    var strREmail = $.trim($('#txtREmail').val());
    var strRZipcode = $.trim($('#txtRZipcode').val());

    var blnOK = CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode);
    if (blnOK)
    {
        $.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "DoUpdateMbrcst.aspx",
            cache: false,
            data:
            {
                MbrmstID: iMbrmstID,
                MbrcstID: iMbrcstID,
                Name: strName,
                Sex: strSex,
                ProvinceID: strProvinceID,
                CityID: strCityID,
                RAddress: strRAddress,
                RPhone: strRPhone,
                TelePhone: strTelePhone,
                REmail: strREmail,
                RZipcode: strRZipcode
            },
            error: function(XmlHttpRequest, textStatus, errorThrown)
            {
                alert(XmlHttpRequest.responseText);
            },
            success: function(strRet)
            {
                var spanMbrcstMsg = $('#spanMbrcstMsg');
                var iRet = parseInt(strRet);
                switch (iRet)
                {
                    case -201:
                        alert('您还未登录！');
                        spanMbrcstMsg.html('您还未登录！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -202:
                        alert('会员ID参数出错！');
                        spanMbrcstMsg.html('会员ID参数出错！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -203:
                        alert('非法进入页面！');
                        spanMbrcstMsg.html('非法进入页面！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -204:
                        alert('收货人ID参数出错！');
                        spanMbrcstMsg.html('非法进入页面！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -205:
                        alert('请选择省份！');
                        spanMbrcstMsg.html('请选择省份！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -206:
                        alert('请选择城市！');
                        spanMbrcstMsg.html('请选择城市！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -207:
                        alert('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -208:
                        alert('存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.html('存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -209:
                        alert('修改收货人失败！');
                        spanMbrcstMsg.html('修改收货人失败！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case 1:
                        alert('修改收货人信息成功！');
                        spanMbrcstMsg.html('修改收货人信息成功！');
                        spanMbrcstMsg.fadeIn(iSpeed);
                        UpdateMbrcstRow();
                        setInterval(FadeOutMbrcstMsg, 1000);
                        ChangeMbrcst(null, objACurUpdate);
                        CancelMbrcst();
                        break;
                }
            }, //success
            beforeSend: function()
            {
                $('#btnSaveMbrcst').attr('disabled', 'disabled');
                $('#btnSaveMbrcst').removeClass('SaveMbrcst');
                $('#btnSaveMbrcst').addClass('WaitSaveMbrcst');
                $('#btnSaveMbrcst').attr('value', '  保存中,请稍等...');
            },
            complete: function()
            {
                $('#btnSaveMbrcst').removeAttr('disabled');
                $('#btnSaveMbrcst').removeClass('WaitSaveMbrcst');
                $('#btnSaveMbrcst').addClass('SaveMbrcst');
                $('#btnSaveMbrcst').attr('value', '');
            }
        });
    }
}
// end function

// 淡出收货人消息
function FadeOutMbrcstMsg()
{
    var spanMbrcstMsg = $('#spanMbrcstMsg');
    spanMbrcstMsg.fadeOut(iSpeed);
}
// end function

// 淡出支付消息
function FadeOutPayMsg()
{
    var spanPayMsg = $('#spanPayMsg');
    spanPayMsg.fadeOut(iSpeed);
}
// end function

// 淡出送货时间
function FadeOutShipTimeMsg()
{
    var spanShipTimeMsg = $('#spanShipTimeMsg');
    spanShipTimeMsg.fadeOut(iSpeed);
}

// 填充修改收货人信息表单
function FillUpdateMbrcst(modMbrcst)
{
    var ddlProvince = document.getElementById('ddlProvince');
    if (ddlProvince.options.length <= 1)
    {
        BindProvince();
    }
    
    $('#txtName').val(modMbrcst.Name);
    if (modMbrcst.Sex == '0' || modMbrcst.Sex == 0)
    {
        $('#rdoSex0').attr('checked', 'checked');
        $('#rdoSex1').removeAttr('checked');
    }
    else
    {
        $('#rdoSex0').removeAttr('checked');
        $('#rdoSex1').attr('checked', 'checked');
    }
    BindProvCity(modMbrcst.ProvID, modMbrcst.CityID);
    //$('#ddlProvince').val(modMbrcst.ProvID);
   // $('#ddlCity').val(modMbrcst.CityID);
    $('#txtRAddress').val(modMbrcst.RAddress);
    $('#txtRPhone').val(modMbrcst.RPhone);
    $('#txtTelePhone').val(modMbrcst.RTelephone);
    $('#txtREmail').val(modMbrcst.REmail);
    $('#txtRZipcode').val(modMbrcst.RZipCode);
}
// end function

// 追加收货人列表行
function AppendMbrcstRow(iMbrcstID)
{
    alert('添加收货人信息成功!');
    var strMbrID = $('#hdnMbrID').val();
    var tblTop5Mbrcst = document.getElementById('tblTop5Mbrcst');
    if (tblTop5Mbrcst == null)
    {
        ShowMbrcst();
        return;
    }
    var trNew = null;
    var iItemIndex = tblTop5Mbrcst.rows.length;
    trNew = tblTop5Mbrcst.insertRow(iItemIndex);

    var tdNew0 = trNew.insertCell();
    tdNew0.align = 'right';
    var rdoMbrcst = "<input type='radio' name='rdoMbrcstList'/>" +
                    "<input type='hidden' id='hdnMbrID" + iItemIndex + "' value='" + strMbrID + "'/>" +
                    "<input type='hidden' id='hdnMbrcstID" + iItemIndex + "' value='" + iMbrcstID + "'/>";
    $(rdoMbrcst).appendTo(tdNew0);

    var tdNew1 = trNew.insertCell();
    tdNew1.innerText = $('#txtName').val();
    tdNew1.align = 'left';

    var tdNew2 = trNew.insertCell();
    tdNew2.innerText = $('#txtRAddress').val();
    tdNew2.align = 'left';

    var btnUpdate = "<a href='javascript:void(0)' onclick='javascript:GetUpdMbrcst(this," + strMbrID + "," + iMbrcstID + ")'>修改</a>";
    var tdNew3 = trNew.insertCell();
    $(btnUpdate).appendTo(tdNew3);

    var btnDelete = "<a href='javascript:void(0)' onclick='javascript:DeleteMbrcst(this," + strMbrID + "," + iMbrcstID + ")'>删除</a>";
    var tdNew4 = trNew.insertCell();
    $(btnDelete).appendTo(tdNew4);
}
// end function

// 删除收货人数据行
function DeleteMbrcstRow(objADelete)
{
    var tblParent = GetParentTable(objADelete);
    $(objADelete).parent('td').parent('tr').remove();
}
// end function

// 修改收货人行
function UpdateMbrcstRow()
{
    var tdUpdate = $(objACurUpdate).parent('td');
    var tdAddress = tdUpdate.prev();
    var tdName = tdAddress.prev();

    tdAddress.html($('#txtRAddress').val());
    tdName.html($('#txtName').val());

     //ReSetMbrcst();
}
// end function

// 获得子元素所属的table
function GetParentTable(objSub)
{
    var objParent = objSub.parentNode;
    var strParentTag = null;
    if (objParent != null && objParent.tagName != null)
    {
        strParentTag = objParent.tagName.toLowerCase();
    }
    while (strParentTag != 'table')
    {
        objParent = objParent.parentNode;
        if (objParent != null && objParent.tagName != null)
        {
            strParentTag = objParent.tagName.toLowerCase();
        }
    }
    return objParent;
}

// 显示隐藏更多收货人
function ToggleMoreMbrcst()
{
    var tblAllMbrcst = document.getElementById('tblAllMbrcst');
    if (tblAllMbrcst.style.display == 'none')
    {
        tblAllMbrcst.style.display = 'block';
        $('#spanLef').html('>>');
        $('#spanRight').html('<<');
    }
    else
    {
        tblAllMbrcst.style.display = 'none';
        $('#spanLef').html('<<');
        $('#spanRight').html('>>');
    }
}

// 收货人表单检查
function CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode)
{
    var blnSuccess = true;
    if (!CheckName())
    {
        blnSuccess = false;
    }
    if (!CheckProvince())
    {
        blnSuccess = false;
    }
    if (!CheckCity())
    {
        blnSuccess = false;
    }
    if (!CheckRAddress())
    {
        blnSuccess = false;
    }
    if (!CheckRPhone())
    {
        blnSuccess = false;
    }
    if (!CheckTelePhone())
    {
        blnSuccess = false;
    }
    if (!CheckREmail())
    {
        blnSuccess = false;
    }
    if (!CheckRZipcode())
    {
        blnSuccess = false;
    }
    return blnSuccess;
}

// 检查收货人姓名
function CheckName(strName)
{
    if (typeof(strName) == 'undefined')
    {
        strName = $.trim($('#txtName').val());
    }
    var spanName = $('#spanName');
    if (strName == null || strName.length == 0)
    {
        spanName.html('收货人姓名不能为空！');
        spanName.show();
        return false;
    }
    else
    {
        spanName.hide();
    }
    return true;
}

// 检查省份
function CheckProvince(strProvince)
{
    if (typeof (strProvince) == 'undefined')
    {
        strProvince = $.trim($('#ddlProvince').val());
    }
    var spanProvinceCity = $('#spanProvinceCity');
    if (strProvince == null || strProvince.length == 0)
    {
        spanProvinceCity.html('请选择省份！');
        spanProvinceCity.show();
        return false;
    }
    else
    {
        spanProvinceCity.hide();
    }
    return true;
}

// 检查城市
function CheckCity(strCity)
{
    if (typeof (strCity) == 'undefined')
    {
        strCity = $.trim($('#ddlCity').val());
    }
    var spanProvinceCity = $('#spanProvinceCity');
    if (strCity == null || strCity.length == 0)
    {
        spanProvinceCity.html('请选择城市！');
        spanProvinceCity.show();
        return false;
    }
    else
    {
        spanProvinceCity.hide();
    }
    return true;
}

// 检查地址
function CheckRAddress(strRAddress)
{
    if (typeof(strRAddress) == 'undefined')
    {
        strRAddress = $.trim($('#txtRAddress').val());
    }
    var spanRAddress = $('#spanRAddress');
    if (strRAddress == null || strRAddress.length == 0)
    {
        spanRAddress.html('地址不能为空！');
        spanRAddress.show();
        return false;
    }
    else
    {
        spanRAddress.hide();
    }
    return true;
}

// 检查手机号码
function CheckRPhone(strRPhone)
{
    if (typeof(strRPhone) == 'undefined')
    {
        strRPhone = $.trim($('#txtRPhone').val());
    }
    
    var spanRPhone = $('#spanRPhone');
    if (strRPhone == null || strRPhone.length == 0)
    {
        spanRPhone.html('手机号码不能为空！');
        spanRPhone.show();
        return false;
    }
    if (!isMobile(strRPhone))
    {
        spanRPhone.html('无效手机号码！');
        spanRPhone.show();
        return false;
    }
    spanRPhone.html('');
    spanRPhone.hide();
    return true;
}

// 检查固定电话
function CheckTelePhone(strTelePhone)
{
    if (typeof (strTelePhone) == 'undefined')
    {
        strTelePhone = $.trim($('#txtTelePhone').val());
    }

    var spanTelePhone = $('#spanTelePhone');
    if (strTelePhone != null && strTelePhone.length > 0)
    {
        if (!isPhoneCall(strTelePhone))
        {
            spanTelePhone.html('无效电话号码！');
            spanTelePhone.show();
            return false;
        }
    }

    spanTelePhone.html('');
    spanTelePhone.hide();
    return true;
}

// 检查邮箱地址
function CheckREmail(strREmail)
{
    if (typeof (strREmail) == 'undefined')
    {
        strREmail = $.trim($('#txtREmail').val());
    }

    var spanREmail = $('#spanREmail');
    if (strREmail == null || strREmail.length == 0)
    {
        spanREmail.html('邮箱地址不能为空！');
        spanREmail.show();
        return false;
    }
    if (!isEmail(strREmail))
    {
        spanREmail.html('无效邮箱地址！');
        spanREmail.show();
        return false;
    }
    spanREmail.html('');
    spanREmail.hide();
    return true;
}

// 检查邮政编码
function CheckRZipcode(strRZipcode)
{
    if (typeof (strRZipcode) == 'undefined')
    {
        strRZipcode = $.trim($('#txtRZipcode').val());
    }

    var spanRZipcode = $('#spanRZipcode');
    if (strRZipcode == null || strRZipcode.length == 0)
    {
        spanRZipcode.html('邮政编码不能为空！');
        spanRZipcode.show();
        return false;
    }
    if (!isPostalCode(strRZipcode))
    {
        spanRZipcode.html('无效邮政编码！');
        spanRZipcode.show();
        return false;
    }
    spanRZipcode.html('');
    spanRZipcode.hide();
    return true;
}

// 改变省份选项
function ChangeProv(ddlProv)
{
    GetNextLevel(ddlProv, "../GetData/GetProvCity.ashx", "ProvinceID", "#ddlCity");
    if (CheckProvince())
    {
        CheckCity();
    }
}

// 绑定省份下接项数据
function BindProvince()
{
    $.ajax(
    {
        type: "GET",
        url: "/ajax/user/getProvCity.jsp",
        success: function(data)
        {
            var dllProv = $('#ddlProvince');
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function()
                {
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + ">" + opt[1] + "</option>").appendTo(dllProv);
                });
            }
            else
            {
                $("<option value=''>==请选择==</option>").appendTo(dllProv);
            }
        },
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        }
    });
}
//end function

// 绑定省份下的城市
function BindProvCity(strProvinceID, strCityID)
{
    var ddlCity = $('#ddlCity');
    if (strProvinceID == null || strProvinceID.length == 0)
    {
        ddlCity.empty();
        $("<option value=''>==请选择==</option>").appendTo(ddlCity);
        return;
    }
    
    $.ajax(
    {
        type: "GET",
        url: "/ajax/user/getProvCity.jsp",
        data:{ProvinceID:strProvinceID},
        success: function(data)
        {
            if (data != "-1")
            {
                var subject = data.split(",");
                $.each(subject, function()
                {
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + ">" + opt[1] + "</option>").appendTo(ddlCity);
                });
                $('#ddlProvince').val(strProvinceID);
                $('#ddlCity').val(strCityID);
            }
            else
            {
                ddlCity.empty();
                $("<option value=''>==请选择==</option>").appendTo(ddlCity);
            }
        },
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        }
    });
}
//end function

// 取消修改
function CancelMbrcst()
{
    $('#hdnOptMbrCst').val('1');
    $('#btnAddEditMbrcst').show();
    ReSetMbrcst();
    $('#tblAddEditMbrct').hide();    
}

//显示网上支付子区域
function ShowPayNet()
{
    $('#trPayNet').show();
    var iChecked = $('#tblPayNetList input[type=radio]:checked').length;
    if (iChecked == 0)//没有选中的子项默认选中第1项
    {
        //var rdoDefault = $('#tblPayList input[type=radio][value=21]').get(0); //快钱
        var rdoDefault = $('#tblPayNetList input[type=radio][value=25]').get(0); //腾讯财付通
        if (rdoDefault != null)
        {
            rdoDefault.checked = true;
        }
    }
}
//end function

// 检查券支付方式及计算结算信息
function paykindrchange()
{
    //检查卷
    checktktpayid();
    loadprice();
} 
//end function

//检查券的支付方式
function checktktpayid()
{
    var payid = -1; //选中的支付方式
    var tktid = '0';
    if (typeof (document.frm_sendpay.tktid) != "undefined")
    {
        //遍历支付方式(单选按钮)
        for (var i = 0; i < document.frm_sendpay.req_payid.length; i++)
        {
            if (document.frm_sendpay.req_payid[i].checked)
            {
                payid = document.frm_sendpay.req_payid[i].value; //选中的支付方式
                break;
            }
        } // for

        //遍历优惠券(单选)
        for (var j = 0; j < document.frm_sendpay.tktid.length; j++)
        {
            var tktid = document.frm_sendpay.tktid[j].value;
            var tktpayid = document.getElementById('tktpayid_' + tktid).value; //券要求的支付方式ID
            if (tktid != '0' && tktpayid == payid)//券要求的支付方式与选择的支付方式相符
            {
                document.frm_sendpay.tktid[j].disabled = false;
            }
            else if (tktid != '0' && (tktpayid == '' || tktpayid < 0))//券无要求支付方式
            {
                document.frm_sendpay.tktid[j].disabled = false;
            }
            else if (tktid != '0' && tktpayid != payid)//选择的支付方式与券要求的支付方式不一致
            {
                document.frm_sendpay.tktid[j].checked = false;
                document.frm_sendpay.tktid[j].disabled = true;
            }
        }
    } //if
} 
// end function

//ajax更新总金额
function loadprice()
{
    var aj_tktid = -1; //选择的优惠券ID
    var aj_payid = -1; //选择的支付方式ID
    if (typeof (document.frm_sendpay.req_payid) != "undefined")
    {
        // 遍历支付方式, 记录选中项
        for (var i = 0; i < document.frm_sendpay.req_payid.length; i++)
        {
            if (document.frm_sendpay.req_payid[i].checked)
            {
                aj_payid = document.frm_sendpay.req_payid[i].value;
                break;
            }
        }
    }

    // 遍历优惠券，记录选中项
    if (typeof (document.frm_sendpay.tktid) != "undefined")
    {
        if (document.frm_sendpay.tktid.length > 1)
        {
            for (var i = 0; i < document.frm_sendpay.tktid.length; i++)
            {
                if (document.frm_sendpay.tktid[i].checked && document.frm_sendpay.tktid[i].value != '0')
                {
                    aj_tktid = document.frm_sendpay.tktid[i].value;
                    break;
                }
            }
        }
        else
        {
            if (document.frm_sendpay.tktid.checked && document.frm_sendpay.tktid.value != '0')
            {
                aj_tktid = document.frm_sendpay.tktid.value;
            }
        }
    }

    var strGdsFee = $('#lblGdsFee').text(); //商品金额
    var iIsUsePrepay = 0;
    var chkPrepay = document.getElementById('chkPrepay');
    if (chkPrepay != null && chkPrepay.checked)
    {
        iIsUsePrepay = 1;
    }
    $.ajax({
        type: "post",
        dataType: "json",
        url: "LoadPrice1.aspx",
        cache: false,
        data:
	    {
	        tktid: aj_tktid,
	        payid: aj_payid,
	        GdsFee: strGdsFee,
	        IsUsePrepay: iIsUsePrepay
	    },
        error: function(XmlHttpRequest, textStatus, errorThrown)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(modAccount)
        {
            var iRet = parseInt(modAccount.iRet);

            switch (iRet)
            {
                case -201:
                    alert('支付方式参数ID出错!');
                    break;
                case -202:
                    alert('商品金额参数出错!');
                    break;
                case -203:
                    alert('查询会员信息出错!');
                    break;
                case -204:
                    alert('您还未登录！');
                    break;
                case -205:
                    alert('查询折扣券出错！');
                    break;
                case -206:
                    alert('查询团购商品不参与优惠券的金额出错！');
                    break;
                case -207:
                    alert('查询品牌减免券出错！');
                    break;
                case -208:
                    alert('查询优惠券金额出错！');
                    break;
                case -209:
                    alert('收货人城市运费标准出错！');
                    break;
                case -210:
                    alert('不存在收货人城市运费标准！');
                    break;
                case -211:
                    alert('查询用户预存款出错！');
                    break;
                case 1:
                    $('#spanShipFee').html(modAccount.ShipFee);
                    $('#spanTktValue').html(modAccount.TktValue);
                    $('#spanUsePrepay').html(modAccount.UsePrepay);
                    $('#lblTotal').html(modAccount.Total);
                    break;
            } //switch   
        }
    });
}
//function

//显示券
function ShowTkt()
{
    $.ajax({
        type: "post",
        dataType: "html",
        url: "GetTktHtml1.aspx",
        cache: false,
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(strHtml)
        {
            $('#divTktList').empty();
            $(strHtml).appendTo($('#divTktList'));
        },
        beforeSend: function()
        {
            $('#divLoadTkt').show();
            $('#divTktList').hide();
        },
        complete: function()
        {
            $('#divLoadTkt').hide();
            $('#divTktList').show();
        }
    });
}
//function

// 隐藏网上支付区域
function HidePayNet()
{
    if (document.frm_sendpay.rdoPayShow1 != null)
    {
        document.frm_sendpay.rdoPayShow1.checked = false;
        $('#trPayNet').hide();
    }
}

//点击收货人单选按钮
//rdoSelected:单选按钮
//objHplUpdate:修改链接
function ChangeMbrcst(rdoSelected, objHplUpdate){
    var blnUpdate = false;//修改当前收货人加载
    if (objHplUpdate != null){
        var tdParent = $(objHplUpdate).parent('td');
        var td0 = tdParent.prev('td').prev('td').prev('td');
        var rdoMbrcstList = td0.children().get(0);
        if (rdoMbrcstList == rdoPrevMbrcst)//修改的当前收货人
        {
            blnUpdate = true;
            rdoSelected = rdoMbrcstList;
        }
    }
    
    var blnChange = (rdoSelected != null && rdoSelected != rdoPrevMbrcst);//改变收货人加载
    if (blnChange || blnUpdate)
    {
        rdoPrevMbrcst = rdoSelected;
        var iMbrmstID = $(rdoSelected).next('input[type=hidden][id^=hdnMbrID]').val();
        var iMbrcstID = $(rdoSelected).nextAll('input[type=hidden][id^=hdnMbrcstID]').val();

        $.ajax({
            type: "post",
            dataType: "json",
            url: "JudgeCanHF.aspx",
            cache: false,
            data:
            {
                MbrmstID: iMbrmstID,
                MbrcstID: iMbrcstID
            },
            error: function(XmlHttpRequest, textStatus, errorThrown)
            {
                alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
            },
            success: function(modJudge)
            {
                var iRet = parseInt(modJudge.iRet);
                switch (iRet)
                {
                    case 1:
                        JudgeCanHF(modJudge.CanHF);
                        break;
                    case -201:
                        alert('会员ID参数出错！');
                        break;
                    case -202:
                        alert('收货人ID参数出错！');
                        break;
                    case -203:
                        alert('收货人不存在！');
                        break;
                    case -204:
                        alert('查询收货人城市出错！');
                        break;
                    case -205:
                        alert('更新登录信息出错！');
                        break;
                    case -206:
                        alert('查询购物车中团购商品数量出错！');
                        break;
                    case -207:
                        alert('无城市是否支持货到付款标识！');
                        break;
                    case -208:
                        alert('判断城市是否支持货到付款出错！');
                        break;
                } //switch
            }, //success
            beforeSend: function()
            {
            },
            complete: function()
            {
                loadprice();
            }
        });
    }// if
}
//end function

// 判断是否支持货到款
function JudgeCanHF(iCanHF)
{
    if (iCanHF == 1 || iCanHF == '1')
    {
        $('#trPayID0').show();
        var iChecked = $('input[type=radio][name=req_payid]:checked').length;
        if (iChecked == null || iChecked <= 0)
        {
            var spanPayMsg = $('#spanPayMsg');
            spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
            spanPayMsg.fadeIn(iSpeed);
            setInterval(FadeOutPayMsg, iInterVal + 2000);
        }
    }
    else
    {
        var id_paykindr1 = document.getElementById('id_paykindr1');
        if (id_paykindr1 != null)
        {
            if (id_paykindr1.checked)
            {
                var spanPayMsg = $('#spanPayMsg');
                spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
                spanPayMsg.fadeIn(iSpeed);
                setInterval(FadeOutPayMsg, iInterVal + 2000);
            }
            else//当前无选中项
            {
                var iChecked = $('input[type=radio][name=req_payid]:checked').length;
                if (iChecked == null || iChecked <= 0)
                {
                    var spanPayMsg = $('#spanPayMsg');
                    spanPayMsg.html('由于您更改了收货人，请重新选择支付方式！');
                    spanPayMsg.fadeIn(iSpeed);
                    setInterval(FadeOutPayMsg, iInterVal + 2000);
                }
            }

            id_paykindr1.checked = false;
            $('#trPayID0').hide();
        }
    }
}
// end function

//下单按钮
function sendupdate()
{
    var iIsChkMbrcst = $('table input[type=radio][name=rdoMbrcstList]:checked').length;
    if (iIsChkMbrcst == null || iIsChkMbrcst <= 0)
    {
        alert("请选择收货人！");
        var spanMbrcstMsg = document.getElementById('spanMbrcstMsg');
        //spanMbrcstMsg.scrollIntoView(true);
        var spanMbrcstMsg1 = $(spanMbrcstMsg);
        spanMbrcstMsg1.html('请选择收货人！');
        spanMbrcstMsg1.fadeIn(iSpeed);
        setInterval(FadeOutMbrcstMsg, iInterVal + 2000);
        return false;
    }
    
    // 遍历检查是否选中支付方式
    var intSelFlag = 0;
    var arrReq_PayID = document.getElementsByName('req_payid');
    if (arrReq_PayID != null && arrReq_PayID.length > 0)
    {
        for (var i = 0; i < arrReq_PayID.length; i++)
        {
            if (arrReq_PayID[i].checked)
            {
                intSelFlag = 1;
                break;
            }
        }
    }

    //全额E券支付
    var strPayID22 = document.getElementById('hdnPayID22').value;
    if (strPayID22 == '22' || strPayID22 == 22)
    {
        intSelFlag = 1;
    }

    if (intSelFlag == 0)
    {
        alert("请选择支付方式！");
        var spanPayMsg = document.getElementById('spanPayMsg');
        //spanPayMsg.scrollIntoView(true);
        var spanPayMsg1 = $(spanPayMsg);
        spanPayMsg1.html('请选择支付方式！');
        spanPayMsg1.fadeIn(iSpeed);
        setInterval(FadeOutPayMsg, iInterVal + 2000);
        return false;
    }
    
    //送货时间要求
    var submitFlag1 = 0;
    for (i = 0; i < document.frm_sendpay.shipTime.length; i++)
    {
        if (document.frm_sendpay.shipTime[i].checked)
        {
            submitFlag1 = 1;
            break;
        }
    }
    if (submitFlag1 == 0)
    {
        $.alert("请选择收货时间！");
        var spanShipTimeMsg = $('#spanShipTimeMsg');
        spanShipTimeMsg.html('请选择收货时间！');
        spanShipTimeMsg.fadeIn(iSpeed);
        setInterval(FadeOutShipTimeMsg, iInterVal + 2000);
        return false;
    }
    
    var selecttkt; //是否选择了优惠券
    var havetkt; //是否使用了优惠券
    for (var i = 0; i < document.getElementsByName('tktid').length; i++)
    {
        if (document.getElementsByName('tktid')[i].value != '0')
        {
            havetkt = true;
        }
        if (document.getElementsByName('tktid')[i].checked && document.getElementsByName('tktid')[i].value != '0')
        {
            selecttkt = true;
        }
    }
    if (havetkt && !selecttkt)//有优惠券但未使用
    {
        if (!window.confirm('你有可以使用的优惠券,是否确定不使用!'))
        {
            return false;
        }
    }
   
    frm_sendpay.Submit33.disabled = true;
    $('#divLoadOrder').show();
    __doPostBack('btnOrder', '');
    return true;
}
//end function 下单

//修改：重置收货人表单
function ReSetMbrcst()
{
    $('#tblAddEditMbrct input[type=text]').each(function()
    {
        $(this).val('');
    })

    $('#tblAddEditMbrct span[id^=span]').each(function()
    {
        $(this).html('');
        $(this).hide();
    })

    $('#ddlProvince').val('');
    $('#ddlCity').val('');
}
//end function

// 激活券
function ActivateTkt(iIsPingAn)
{
    var strCardNo = null;
    var btnActivate = null;
    if (iIsPingAn == 1 || iIsPingAn == '1')
    {
        strCardNo = $('#txtPingAnCardNo').val();
        btnActivate = $('#btnActivate1');
    }
    else
    {
        strCardNo = $('#txtCardNo').val();
        btnActivate = $('#btnActivate0');
    }
    if (strCardNo == null || strCardNo.length == 0)
    {
        alert('请输入券号!');
        return;
    }

    $.ajax({
        type: "post",
        dataType: "text",
        url: "ActivateTicket.aspx",
        cache: false,
        data:
	    {
	        CardNo: strCardNo,
	        pwd: 'www.d1.com.cn'
	    },
        error: function(XmlHttpRequest)
        {
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
            btnActivate.removeAttr('disabled');
            btnActivate.attr('value', '激活优惠券');
        },
        success: function(strRet)
        {
            if (strRet == 1 || strRet == '1')
            {
                alert('激活优惠券成功!');
                ShowTkt();
            }
            else
            {
                alert(strRet);
            }
        },
        beforeSend: function()
        {
//            btnActivate.attr('value', '请稍等...');
//            btnActivate.attr('disabled', 'disabled');
            btnActivate.attr('disabled', 'disabled');
            btnActivate.removeClass('ActivateEquan');
            btnActivate.addClass('WaitActiveEQ');
            btnActivate.attr('value', '  激活中,请稍等...');
        },
        complete: function()
        {
            //btnActivate.removeAttr('disabled');
            //btnActivate.attr('value', '');

            btnActivate.removeAttr('disabled');
            btnActivate.removeClass('WaitActiveEQ');
            btnActivate.addClass('ActivateEquan');
            btnActivate.attr('value', '');
        }
    });
}
//end function

// 让优惠券复选按钮
function RadioTktChkBox(chkThis)
{
    var blnChecked = chkThis.checked;
    $('input[type=checkbox][name=tktid]').each(function()
    {
        this.checked = false;
    });
    chkThis.checked = blnChecked;
}
//end function