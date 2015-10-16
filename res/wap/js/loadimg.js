var refreshTimer = null,
    meitem = meitem || {};
$(window).on('scrollstop', function () {
    if (refreshTimer) {
        clearTimeout(refreshTimer);
        refreshTimer = null;
    }
    refreshTimer = setTimeout(meitem.getInViewportList, 200);
});
     
     
$.belowthefold = function (element) {
    var fold = $(window).height() + $(window).scrollTop();
    return fold <= $(element).offset().top;
};
 
$.abovethetop = function (element) {
    var top = $(window).scrollTop();
    return top >= $(element).offset().top + $(element).height();
};
 
/*
*鍒ゆ柇鍏冪礌鏄惁鍑虹幇鍦╲iewport涓�渚濊禆浜庝笂涓や釜鎵╁睍鏂规硶 
*/
$.inViewport = function (element) {
    return !$.belowthefold(element) && !$.abovethetop(element)
};
 
meitem.getInViewportList = function () {
    var list = $('.mp_list li'),
        ret = [];

    list.each(function (i) {
        var li = list.eq(i);
	
        if ($.inViewport(li)) {
            meitem.loadImg(li);
        }
    });
};
 
meitem.loadImg = function (li) {
    if (li.find('img[_src]').length) {
        var img = li.find('img[_src]'),
            src = img.attr('_src');
        img.attr('src', src).load(function () {
            img.removeAttr('_src');
        });
    }
};