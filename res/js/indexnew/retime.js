function retime(t, o_text) {
    this.time = t;
    this.timeSec = parseInt(this.time / 1000);
    this.tt = 1;
    this.startTime = parseInt(new Date() / 1000);
    this.offsetTime = this.startTime;
    this.text = o_text;
};

retime.prototype.starTime = function(o) {
    var oid = o.text.id; //由于对象o始终是存在的，所以即使o.text这个真实的标签不存在了，o.text.id这个值也是可以获取的，从对象o中。
    if (oid != '') {
        if (document.getElementById(oid) == null) {//当这个标签不存在的时候，应该终止循环
            return;
        }
    }
    if (this.tt > 0) {
        var endTime = parseInt(new Date() / 1000);
        var b = Math.abs(endTime - this.offsetTime);
        if (b > 60) {
            this.startTime += (endTime - this.offsetTime);
        }
        this.offsetTime = parseInt(new Date() / 1000);
        var c = Math.floor(this.timeSec - (endTime - this.startTime));

        if (c > 0) { this.tt = c } else { this.tt = 0; }
        var senconds = Math.floor(this.tt % 60);
        var minutes = Math.floor((this.tt / 60) % 60);
        var hours = Math.floor((this.tt / 3600) % 24);
        var day = Math.floor(this.tt / 86400);
        day < 10 ? day = "0" + day : day = day;
        hours < 10 ? hours = "0" + hours : hours = hours;
        senconds < 10 ? senconds = "0" + senconds : senconds = senconds;
        minutes < 10 ? minutes = "0" + minutes : minutes = minutes;

        o.setText(o, [day, hours, minutes, senconds]);
        setTimeout(function() { o.starTime(o) }, 1000);
    }else {
        o.setTextEnd(o);
    }
};

retime.prototype.setText = function(o, t) {
    var nid = o.text.id;
    o.text.innerHTML = '<em>' + t[0] + '</em>天<em>' + t[1] + '</em>小时<em>' + t[2] + '</em>分<em>' + t[3] + '</em>秒';
};

retime.prototype.setTextEnd = function(o) {
    o.text.innerHTML = "活动已结束";
};

retime.prototype.sTime = function(o) {
    if (o.text == null) {
        alert("me");
        return;
    }
    setTimeout(function() { o.starTime(o) }, 1000);
};

function xsms2011(id) {
	$('#'+id+' .countdown').each(function(){
		var b = $(this).attr('time');
		if(b){
			var ttime = new retime(b, this);
            ttime.sTime(ttime);
		}
	});
};




//显示限时特卖
function ShowXSTM() {
    $.ajax({
        type: "get",
        dataType: "html",
        url: "/ajax/html/getIndexXSTM_new.jsp",
        cache: false,
        data: {},
        success: function(strHtml) {
            if (typeof strHtml != 'undefined') {
                $('#xstm_201211').empty();
                $(strHtml).appendTo($('#xstm_201211'));
            }
        },beforeSend: function() {},
        complete: function() {xsms2011('xstm_201211');}
    });
};
// end function