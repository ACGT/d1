
var qfCss = '<style type="text/css">';
qfCss += '.vjiaQFFloat{width:155px; height:425px; background:url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/vjia_qfBg1.gif) no-repeat 0px 0px; position:fixed; _position:absolute; right:1px; top:130px; _top:expression(offsetParent.scrollTop+130); font-size:12px; _z-index:10000; overflow:hidden; zoom:1;}';
qfCss += '.vjiaQFFloat a{ color:#519004; text-decoration:none;}';
qfCss += '.vjiaQFFloat a:hover{ color:#519004; text-decoration:underline;}';
qfCss += '.vjiaQFFloat ul{ width:130px; height:350px; margin:0px; padding:0px; padding-top:85px; background:url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/vjia_qfBg1.gif) no-repeat -30px 0px #519004; overflow:hidden;}';
qfCss += '.vjiaQFFloat span,.vjiaQFFloat ul{ float:left; display:block;}';
qfCss += '.vjiaQFFloat span{ width:25px; height:425px;}';
qfCss += '.vjiaQFFloat ul li{ display:block; height:34px; line-height:32px; background:url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/vjia_qfBg1.gif) no-repeat -30px -104px #519004; text-align:left; margin-left:20px;}';
qfCss += '.vjiaQFFloat ul .btn-QF{ height:30px; line-height:30px; padding-bottom:10px; *padding-bottom:7px; background:none; overflow:hidden;}';
qfCss += '.vjiaQFFloat ul .btn-QF a,.vjiaQFFloat ul .btn-QF img{ display:block; width:80px; height:30px; margin:0px auto; border:0px;}</style>';
var qfCode = '<div id="vjiaQF" class="vjiaQFFloat"><span>&nbsp;</span><ul>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/activities/limittime.jsp" target="_blank">24小时特价抢购</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111219lndq2/xnsc.jsp" target="_blank">满300返200</a></li>';
qfCode += '<li><a style="color:white; font-weight:blod;" href="http://www.d1.com.cn/jifen/index.jsp" target="_blank">年度积分大换礼</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111220zyhk/" target="_blank">这样买最优惠</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111215xnzp/index.jsp" target="_blank">美妆专场</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111219sjdc/index.jsp" target="_blank">服饰专场</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111216sp/index.jsp" target="_blank">美饰专场</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111220NanRenBang/" target="_blank">男装专场</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111214bag/index.jsp" target="_blank">箱包专场</a></li>';
qfCode += '<li><a style=" color:white; font-weight:blod;" href="http://www.d1.com.cn/zhuanti/20111219WQC/index.jsp" target="_blank">名品专场</a></li></ul></div>';
$(document).ready(function () {

    var weburl = location.href;
    weburl = weburl.replace("http://", "").replace("https://", "");
    var folders = weburl.split("/");

    var isRun = true;
    if (folders.length > 1 && (folders[1].toLowerCase() == "usercenter" || folders[1].toLowerCase() == "helpcenter")) {
        isRun = false;
    }
    if (isRun == false) {
        return;
    }

    $("#adright").hide();
    $("body").append(qfCss);
    $("body").append(qfCode);
    vjiaQFHide();
    $("#vjiaQF").hover(function () {
        if ($(this).attr("class").indexOf("QFFloatblur") > -1) {
            $(this).animate({ width: '155px' }, 200, function () { $(this).removeClass("QFFloatblur"); });
        }
    });
    $("#vjiaQF").mouseleave(function () { vjiaQFHide(); });
});
function vjiaQFHide() { setTimeout(function () { $("#vjiaQF").animate({ width: "25px" }, 300, function () { $("#vjiaQF").addClass("QFFloatblur"); }); }, 10000); }