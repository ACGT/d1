var glide = new function() {
    function $id(id) { return document.getElementById(id); };
    this.layerGlide = function(auto, oEventCont, oTxtCont, oSlider, sSingleSize, second, fSpeed, point) {
        var oSubLi = $id(oEventCont).getElementsByTagName('li');
        var oTxtLi = $id(oTxtCont).getElementsByTagName('li');
        var interval, timeout, oslideRange;
        var time = 1;
        var speed = fSpeed
        var sum = oSubLi.length;
        var a = 0;
        var delay = second * 1000;
        var setValLeft = function(s) {
            return function() {
                oslideRange = Math.abs(parseInt($id(oSlider).style[point]));
                $id(oSlider).style[point] = -Math.floor(oslideRange + (parseInt(s * sSingleSize) - oslideRange) * speed) + 'px';
                if (oslideRange == [(sSingleSize * s)]) {
                    clearInterval(interval);
                    a = s;
                }
            }
        };
        var setValRight = function(s) {
            return function() {
                oslideRange = Math.abs(parseInt($id(oSlider).style[point]));
                $id(oSlider).style[point] = -Math.ceil(oslideRange + (parseInt(s * sSingleSize) - oslideRange) * speed) + 'px';
                if (oslideRange == [(sSingleSize * s)]) {
                    clearInterval(interval);
                    a = s;
                }
            }
        }

        function autoGlide() {
            for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; oTxtLi[c].className = ''; };
            clearTimeout(interval);
            if (a == (parseInt(sum) - 1)) {
                for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; oTxtLi[c].className = ''; };
                a = 0;
                oSubLi[a].className = "active";
                oTxtLi[a].className = "active";
                interval = setInterval(setValLeft(a), time);
                timeout = setTimeout(autoGlide, delay);
            } else {
                a++;
                oSubLi[a].className = "active";
                oTxtLi[a].className = "active";
                interval = setInterval(setValRight(a), time);
                timeout = setTimeout(autoGlide, delay);
            }
        }

        if (auto) { timeout = setTimeout(autoGlide, delay); };
        for (var i = 0; i < sum; i++) {
            oSubLi[i].onmouseover = (function(i) {
                return function() {
                    for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; oTxtLi[c].className = ''; };
                    clearTimeout(timeout);
                    clearInterval(interval);
                    oSubLi[i].className = "active";
                    oTxtLi[i].className = "active";
                    if (Math.abs(parseInt($id(oSlider).style[point])) > [(sSingleSize * i)]) {
                        interval = setInterval(setValLeft(i), time);
                        this.onmouseout = function() { if (auto) { timeout = setTimeout(autoGlide, delay); }; };
                    } else if (Math.abs(parseInt($id(oSlider).style[point])) < [(sSingleSize * i)]) {
                        interval = setInterval(setValRight(i), time);
                        this.onmouseout = function() { if (auto) { timeout = setTimeout(autoGlide, delay); }; };
                    }
                }
            })(i)
        }
    }
}
glide.layerGlide(true, 'iconBall', 'textBall', 'show_pic', 700, 5, 0.1, 'left');



var slide = new function() {
    function $id(id) { return document.getElementById(id); };
    this.layerGlide = function(auto, oEventCont, oSlider, oL, oR, sSingleSize, second, fSpeed, point) {
        var oSubLi = $id(oEventCont).getElementsByTagName('li');
        var interval, timeout, oslideRange;
        var time = 1;
        var speed = fSpeed
        var sum = oSubLi.length;
        var a = 0;
        var delay = second * 1000;
        var setValLeft = function(s) {
            return function() {
                oslideRange = Math.abs(parseInt($id(oSlider).style[point]));
                $id(oSlider).style[point] = -Math.floor(oslideRange + (parseInt(s * sSingleSize) - oslideRange) * speed) + 'px';
                if (oslideRange == [(sSingleSize * s)]) {
                    clearInterval(interval);
                    a = s;
                }
            }
        };
        var setValRight = function(s) {
            return function() {
                oslideRange = Math.abs(parseInt($id(oSlider).style[point]));
                $id(oSlider).style[point] = -Math.ceil(oslideRange + (parseInt(s * sSingleSize) - oslideRange) * speed) + 'px';
                if (oslideRange == [(sSingleSize * s)]) {
                    clearInterval(interval);
                    a = s;
                }
            }
        }

        function autoGlide() {
            for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
            clearTimeout(interval);
            if (a == (parseInt(sum) - 1)) {
                for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                a = 0;
                oSubLi[a].className = "active";
                interval = setInterval(setValLeft(a), time);
                timeout = setTimeout(autoGlide, delay);
            } else {
                a++;
                oSubLi[a].className = "active";
                interval = setInterval(setValRight(a), time);
                timeout = setTimeout(autoGlide, delay);
            }
        }

        if (auto) { timeout = setTimeout(autoGlide, delay); };
        for (var i = 0; i < sum; i++) {
            oSubLi[i].onmouseover = (function(i) {
                return function() {
                    for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                    clearTimeout(timeout);
                    clearInterval(interval);
                    oSubLi[i].className = "active";
                    if (Math.abs(parseInt($id(oSlider).style[point])) > [(sSingleSize * i)]) {
                        interval = setInterval(setValLeft(i), time);
                        this.onmouseout = function() { if (auto) { timeout = setTimeout(autoGlide, delay); }; };
                    } else if (Math.abs(parseInt($id(oSlider).style[point])) < [(sSingleSize * i)]) {
                        interval = setInterval(setValRight(i), time);
                        this.onmouseout = function() { if (auto) { timeout = setTimeout(autoGlide, delay); }; };
                    }
                }
            })(i)
        }
        $id(oR).onclick = (function() {
            return function() {
                for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                clearTimeout(timeout);
                clearInterval(interval);
                if (a == (parseInt(sum) - 1)) {
                    for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                    a = 0;
                    oSubLi[a].className = "active";
                    interval = setInterval(setValLeft(a), time);
                } else {
                    a++;
                    oSubLi[a].className = "active";
                    interval = setInterval(setValRight(a), time);
                }
            }
        })()
        $id(oL).onclick = (function() {
            return function() {
                for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                clearTimeout(timeout);
                clearInterval(interval);
                if (a == 0) {
                    for (var c = 0; c < sum; c++) { oSubLi[c].className = ''; };
                    a = sum - 1;
                    oSubLi[a].className = "active";
                    interval = setInterval(setValRight(a), time);
                } else {
                    a--;
                    oSubLi[a].className = "active";
                    interval = setInterval(setValLeft(a), time);
                }
            }
        })()
    }
}
slide.layerGlide(true, 'iconBall2', 'lpic', 'la', 'ra', 338, 3, 0.1, 'left');
slide.layerGlide(true, 'iconBall3', 'spic', 'sla', 'sra', 255, 3, 0.1, 'left');

function $aa(id) { return document.getElementById(id) };
function switch_tags(tags, contents, cls, index, method, time) {
    this.time = time;
    this.method = method;
    this.tags = tags;
    this.contents = contents;
    this.cls = cls;
    this.c_index = index;
    tags[index].className = cls;
    contents[index].style.display = "";
    this.bind_switch();
};

switch_tags.prototype.bind_switch = function() {
    var nb = this;
    var set_int;
    for (var i = 0; i < this.tags.length; i++) {
        this.tags[i].index = i;
        //onmouseover	
        if (this.method == "mouseover") {
            this.tags[i].onmouseover = function() {
                var o = this;
                set_int = setTimeout(function() { sw(o.index) }, nb.time);
            };
            this.tags[i].onmouseout = function() { clearTimeout(set_int); }
        }
        //onclick
        else if (this.method == "click") {
            this.tags[i].onclick = function() { sw(this.index); }
        }
    }
    //延时切换		
    function sw(m) {
        var obj = nb.tags[m];
        nb.tags[nb.c_index].className = "";
        nb.contents[nb.c_index].style.display = "none";
        obj.className = nb.cls;
        nb.contents[obj.index].style.display = "";
        nb.c_index = obj.index;
    };
};

var t0 = $aa("mentab").getElementsByTagName("a");
var c0 = $aa("content_list").getElementsByTagName("div");
new switch_tags(t0, c0, "active", 0, "mouseover");


//新的手表轮播


(function($) {
    $.fn.slides = function(option) {
        option = $.extend({}, $.fn.slides.option, option); return this.each(function() {
            $('.' + option.container, $(this)).children().wrapAll('<div class="slides_control"/>'); var elem = $(this), control = $('.slides_control', elem), total = control.children().size(), width = control.children().outerWidth(), height = control.children().outerHeight(), start = option.start - 1, effect = option.effect.indexOf(',') < 0 ? option.effect : option.effect.replace(' ', '').split(',')[0], paginationEffect = option.effect.indexOf(',') < 0 ? effect : option.effect.replace(' ', '').split(',')[1], next = 0, prev = 0, number = 0, current = 0, loaded, active, clicked, position, direction; if (total < 2) { return; }
            if (start < 0) { start = 0; }; if (start > total) { start = total - 1; }; if (option.start) { current = start; }; if (option.randomize) { control.randomize(); }
            $('.' + option.container, elem).css({ overflow: 'hidden', position: 'relative' }); control.css({ position: 'relative', width: (width * 3), height: height, left: -width }); control.children().css({ position: 'absolute', top: 0, left: width, zIndex: 0, display: 'none' }); if (option.autoHeight) { control.animate({ height: control.children(':eq(' + start + ')').outerHeight() }, option.autoHeightSpeed); }
            if (option.preload && control.children()[0].tagName == 'IMG') { elem.css({ background: 'url(' + option.preloadImage + ') no-repeat 50% 50%' }); var img = $('img:eq(' + start + ')', elem).attr('src') + '?' + (new Date()).getTime(); $('img:eq(' + start + ')', elem).attr('src', img).load(function() { $(this).fadeIn(option.fadeSpeed, function() { $(this).css({ zIndex: 5 }); elem.css({ background: '' }); loaded = true; }); }); } else { control.children(':eq(' + start + ')').fadeIn(option.fadeSpeed, function() { loaded = true; }); }
            if (option.bigTarget) { control.children().css({ cursor: 'pointer' }); control.children().click(function() { animate('next', effect); return false; }); }
            if (option.hoverPause && option.play) { control.children().bind('mouseover', function() { stop(); }); control.children().bind('mouseleave', function() { pause(); }); }
            if (option.generateNextPrev) { $('.' + option.container, elem).after('<a href="#" class="' + option.prev + '">Prev</a>'); $('.' + option.prev, elem).after('<a href="#" class="' + option.next + '">Next</a>'); }
            $('.' + option.next, elem).click(function(e) { e.preventDefault(); if (option.play) { pause(); }; animate('next', effect); }); $('.' + option.prev, elem).click(function(e) { e.preventDefault(); if (option.play) { pause(); }; animate('prev', effect); }); $('a.link', elem).click(function() {
                if (option.play) { pause(); }; clicked = $(this).attr('href').replace('#', '') - 1; if (current != clicked) { animate('pagination', paginationEffect, clicked); }
                return false;
            }); if (option.play) { playInterval = setInterval(function() { animate('next', effect); }, option.play); elem.data('interval', playInterval); }; function stop() { clearInterval(elem.data('interval')); }; function pause() { if (option.pause) { clearTimeout(elem.data('pause')); clearInterval(elem.data('interval')); pauseTimeout = setTimeout(function() { clearTimeout(elem.data('pause')); playInterval = setInterval(function() { animate("next", effect); }, option.play); elem.data('interval', playInterval); }, option.pause); elem.data('pause', pauseTimeout); } else { stop(); } }; function animate(direction, effect, clicked) {
                if (!active && loaded) {
                    active = true; switch (direction) {
                        case 'next': prev = current; next = current - 1; next = next === -1 ? total - 1 : next; position = 0; direction = 0; current = next; break; case 'prev': prev = current; next = current + 1; next = total === next ? 0 : next; position = width * 2; direction = -width * 2; current = next; break; case 'pagination': next = parseInt(clicked, 10); prev = $('.' + option.paginationClass + ' li.current a', elem).attr('href').replace('#', ''); if (next > prev) { position = width * 2; direction = -width * 2; } else { position = 0; direction = 0; }
                            current = next; break;
                    }
                    if (effect === 'fade') {
                        option.animationStart(); if (option.crossfade) { control.children(':eq(' + next + ')', elem).css({ zIndex: 10 }).fadeIn(option.fadeSpeed, function() { control.children(':eq(' + prev + ')', elem).css({ display: 'none', zIndex: 0 }); $(this).css({ zIndex: 0 }); option.animationComplete(next + 1); active = false; }); } else {
                            option.animationStart(); control.children(':eq(' + prev + ')', elem).fadeOut(option.fadeSpeed, function() {
                                if (option.autoHeight) { control.animate({ height: control.children(':eq(' + next + ')', elem).outerHeight() }, option.autoHeightSpeed, function() { control.children(':eq(' + next + ')', elem).fadeIn(option.fadeSpeed); }); } else { control.children(':eq(' + next + ')', elem).fadeIn(option.fadeSpeed, function() { if ($.browser.msie) { $(this).get(0).style.removeAttribute('filter'); } }); }
                                option.animationComplete(next + 1); active = false;
                            });
                        } 
                    } else { control.children(':eq(' + next + ')').css({ left: position, display: 'block' }); if (option.autoHeight) { option.animationStart(); control.animate({ left: direction, height: control.children(':eq(' + next + ')').outerHeight() }, option.slideSpeed, function() { control.css({ left: -width }); control.children(':eq(' + next + ')').css({ left: width, zIndex: 5 }); control.children(':eq(' + prev + ')').css({ left: width, display: 'none', zIndex: 0 }); option.animationComplete(next + 1); active = false; }); } else { option.animationStart(); control.animate({ left: direction }, option.slideSpeed, function() { control.css({ left: -width }); control.children(':eq(' + next + ')').css({ left: width, zIndex: 5 }); control.children(':eq(' + prev + ')').css({ left: width, display: 'none', zIndex: 0 }); option.animationComplete(next + 1); active = false; }); } }
                    if (option.pagination) { $('.' + option.paginationClass + ' li.current', elem).removeClass('current'); $('.' + option.paginationClass + ' li a[href=#' + next + ']', elem).parent().addClass('current'); } 
                } 
            };
        });
    }; $.fn.slides.option = { preload: false, preloadImage: '/img/loading.gif', container: '#dpic', generateNextPrev: false, next: 'next', prev: 'prev', pagination: true, generatePagination: true, paginationClass: 'pagination', fadeSpeed: 350, slideSpeed: 350, start: 1, effect: 'slide', crossfade: false, randomize: false, play: 0, pause: 0, hoverPause: false, autoHeight: false, autoHeightSpeed: 350, bigTarget: false, animationStart: function() { }, animationComplete: function() { } }; $.fn.randomize = function(callback) {
        function randomizeOrder() { return (Math.round(Math.random()) - 0.5); }
        return ($(this).each(function() {
            var $this = $(this); var $children = $this.children(); var childCount = $children.length; if (childCount > 1) {
                $children.hide(); var indices = []; for (i = 0; i < childCount; i++) { indices[indices.length] = i; }
                indices = indices.sort(randomizeOrder); $.each(indices, function(j, k) {
                    var $child = $children.eq(k); var $clone = $child.clone(true); $clone.show().appendTo($this); if (callback !== undefined) { callback($child, $clone); }
                    $child.remove();
                });
            } 
        }));
    };
})(jQuery);