 $(function(){
 $('.tabAuto li:first').addClass('active');
 $('.tgh-box div:first').css('display','block');
 autoroll();
 hookThumb();
 $('.tabAuto1 li:first').addClass('active');
 $('.tgh-box1 div:first').css('display','block');
 autoroll1();
 hookThumb1();
 $('.tabAuto2 li:first').addClass('active');
 $('.tgh-box2 div:first').css('display','block');
 autoroll2();
 hookThumb2();
 $('.tabAuto3 li:first').addClass('active');
 $('.tgh-box3 div:first').css('display','block');
 autoroll3();
 hookThumb3();
 
 $('.tabAuto4 li:first').addClass('active');
 $('.tgh-box4 div:first').css('display','block');
 autoroll4();
 hookThumb4();
 $('.tabAuto5 li:first').addClass('active');
 $('.tgh-box5 div:first').css('display','block');
 autoroll5();
 hookThumb5();
 $('.tabAuto6 li:first').addClass('active');
 $('.tgh-box6 div:first').css('display','block');
 autoroll6();
 hookThumb6();
 

 $('.tabAuto08 li:first').addClass('active');
 $('.tgh-box08 div:first').css('display','block');
 $('.tabAuto08 span:first').css('display','none');
 autoroll8();
 hookThumb8();

 
 $('.j-sw-nav li:first').addClass('cur');
 $('.tabxpqx div:first').css('display','block');
 autorollxpqx();
 hookThumbxpqx();
 
//首页女装轮播
 $('.womenindex li:first').addClass('current');
 $('.womenindexcontent div:first').css('display','block');
 autorollwomen130122();
 hookThumwomen130122();
 
//首页男装轮播
 $('.menindex li:first').addClass('current');
 $('.menindexcontent div:first').css('display','block');
autorollmen130122();
 hookThummen130122();
 
//首页饰品轮播
 $('.spindex li:first').addClass('current');
 $('.spindexcontent div:first').css('display','block');
autorollsp130122();
 hookThumsp130122();
 
//首页化妆品轮播
 $('.cosmeticindex li:first').addClass('current');
 $('.cosmeticindexcontent div:first').css('display','block');
autorollcosmetic130122();
 hookThumcosmetic130122();

});
 
var m=-1; //第i+1个tab开始
var i=-1;
var y=-1;
var j=-1; //第i+1个tab开始
var k=-1; //第i+1个tab开始
var l=-1; //第i+1个tab开始
var x=-1; //第i+1个tab开始
var i130122=-1;//首页女装
var j130122=-1;//首页男装
var j1s30122=-1;//首页饰品

var offset = 3000; //轮换时间
var offset1 = 3000; //轮换时间
var offset2 = 3000; //轮换时间
var offset3 = 3000; //轮换时间
var offset4 = 3000; //轮换时间
var offset5 = 3000; //轮换时间
var offset6 = 3000; //轮换时间
var offset7 = 3000; //轮换时间
var offset8 = 3000; //轮换时间
var offset130122=3000;//首页女装轮换时间
var offsets130122=3000;//首页男装轮换时间
var offsetss130122=3000;//首页饰品轮换时间
var offsetxpqx = 3000; //轮换时间

var timer = null;
var timer1 = null;
var timer2 = null;
var timer3 = null;
var timer4 = null;
var timer5 = null;//首页女装
var timer6 = null;//首页男装
var timer7 = null;//首页饰品
var timer8 = null;//首页饰品
var timerxpqx = null;

function autoroll(){
 n = $('.tabAuto li').length-1;
 i++;
 if(i > n){
 i = 0;
 }
 slide(i);
    timer = window.setTimeout(autoroll, offset);
 }
function autoroll1(){
	 n = $('.tabAuto1 li').length-1;
	 j++;
	 if(j > n){
	 j = 0;
	 }
	 slide1(j);
	    timer1 = window.setTimeout(autoroll1, offset1);
	 }
function autoroll2(){
	 n = $('.tabAuto2 li').length-1;
	 k++;
	 if(k > n){
	 k = 0;
	 }
	 slide2(k);
	    timer2 = window.setTimeout(autoroll2, offset2);
	 }
function autoroll3(){
	 n = $('.tabAuto3 li').length-1;
	 l++;
	 if(l > n){
	 l = 0;
	 }
	 slide3(l);
	    timer3 = window.setTimeout(autoroll3, offset3);
	 }
function autoroll4(){
	 n = $('.tabAuto4 li').length-1;
	 l++;
	 if(l > n){
	 l = 0;
	 }
	 slide3(l);
	    timer3 = window.setTimeout(autoroll3, offset3);
	 }
function autoroll5(){
	 n = $('.tabAuto5 li').length-1;
	 l++;
	 if(l > n){
	 l = 0;
	 }
	 slide3(l);
	    timer3 = window.setTimeout(autoroll3, offset3);
	 }
function autoroll6(){
	 n = $('.tabAuto6 li').length-1;
	 l++;
	 if(l > n){
	 l = 0;
	 }
	 slide3(l);
	    timer3 = window.setTimeout(autoroll3, offset3);
	 }

function autoroll8(){
	 n = $('.tabAuto08 li').length-1;
	 m++;
	 if(m > n){
	 m = 0;
	 }
	 slide4(m);
	    timer4 = window.setTimeout(autoroll4, offset4);
	 }


function autorollxpqx(){
	 n = $('.j-sw-nav li').length-1;

	 x++;
	 if(x > n){
	 x = 0;
	 }
	    slidexpqx(x);
	    timerxpqx = window.setTimeout(autorollxpqx, offsetxpqx);
	 }
//首页女装
function autorollwomen130122(){
	 n = $('.womenindex li').length-1;
	 i130122++;
	 if(i130122>n){
		 i130122 = 0;
	 }
	 slidewomen130122(i130122);
	 //timer5 = window.setTimeout(autorollwomen130122, offset130122);
	 }
//首页男装
function autorollmen130122(){
	 n = $('.menindex li').length-1;
	 j130122++;
	 if(j130122>n){
		 j130122 = 0;
	 }
	 slidemen130122(j130122);
	 //timer6 = window.setTimeout(autorollmen130122, offsets130122);
	 }
//首页饰品
function autorollsp130122(){
	 n = $('.spindex li').length-1;
	 j1s30122++;
	 if(j1s30122>n){
		 j1s30122 = 0;
	 }
	 slidesp130122(j130122);
	 //timer7 = window.setTimeout(autorollsp130122, offsetss130122);
	 }
//首页化妆品
function autorollcosmetic130122(){
	 n = $('.cosmeticindex li').length-1;
	 j1s30122++;
	 if(j1s30122>n){
		 j1s30122 = 0;
	 }
	 slidecosmetic130122(j130122);
	 //timer7 = window.setTimeout(autorollsp130122, offsetss130122);
	 }
function slide(i){
 $('.tabAuto li').eq(i).addClass('current').siblings().removeClass('current');
 $('.tgh-box div').eq(i).css('display','block').siblings('div').css('display','none');
 
 }
function slide1(i){
	 $('.tabAuto1 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box1 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
function slide2(i){
	 $('.tabAuto2 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box2 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
function slide3(i){
	 $('.tabAuto3 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box3 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }

function slide4 (i){
	 $('.tabAuto4 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box4 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
function slide5(i){
	 $('.tabAuto5 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box5 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
function slide6(i){
	 $('.tabAuto6 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box6 div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }

function slide8(i){
	 $('.tabAuto08 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.tgh-box08 div').eq(i).css('display','block').siblings('div').css('display','none');
	 //alert($('.indexfloat').length);
	 //$('.indexfloat').eq(i).css('display','none').siblings().css('display','block');
	 $('.indexfloat').css('display','block');
	 $('.indexfloat').eq(i).css('display','none');
	 
}
//首页女装
function slidewomen130122(i){
	 $('.womenindex li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.womenindexcontent div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }

//首页男装
function slidemen130122(i){
	 $('.menindex li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.menindexcontent div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
//首页饰品
function slidesp130122(i){
	 $('.spindex li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.spindexcontent div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
//首页化妆品
function slidecosmetic130122(i){
	 $('.cosmeticindex li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.cosmeticindexcontent div').eq(i).css('display','block').siblings('div').css('display','none');
	 
	 }
function slidexpqx(i){
	 $('.j-sw-nav li').eq(i).addClass('cur').siblings().removeClass('cur');
	 
	 $('.tabxpqx').children('div').eq(i).css('display','block').siblings('div').css('display','none');
	// $('.tabxpqx').children('div').css('display','none');
	 //var a='#tabxpqx'+(i+1);
	// $(a).css('display','block');
	 
	// $('.tabxpqx div').eq(i).css('display','block').siblings('div').css('display','none');
	  
}

function hookThumb(){    
 $('.tabAuto li').hover(
  function () {
    if (timer) {
                clearTimeout(timer);
    i = $(this).prevAll().length;
             slide(i); 
            }
  },
  function () {
      
            timer = window.setTimeout(autoroll, offset);  
            this.blur();            
            return false;
  }
); 
 $('.tgh-box div').hover(
		  function () {
		    if (timer) {
		                clearTimeout(timer);
		    i = $(this).prevAll().length;
		             slide(i); 
		            }
		  },
		  function () {
		      
		            timer = window.setTimeout(autoroll, offset);  
		            this.blur();            
		            return false;
		  }
		); 
}
function hookThumb1(){    
	 $('.tabAuto1 li').hover(
	  function () {
	    if (timer1) {
	                clearTimeout(timer1);
	    i = $(this).prevAll().length;
	             slide1(i); 
	            }
	  },
	  function () {
	      
	            timer1 = window.setTimeout(autoroll1, offset1);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box1 div').hover(
			  function () {
			    if (timer1) {
			                clearTimeout(timer1);
			    i = $(this).prevAll().length;
			             slide1(i); 
			            }
			  },
			  function () {
			      
			            timer1 = window.setTimeout(autoroll1, offset1);  
			            this.blur();            
			            return false;
			  }
			); 
	}
function hookThumb2(){    
	 $('.tabAuto2 li').hover(
	  function () {
	    if (timer2) {
	                clearTimeout(timer2);
	    i = $(this).prevAll().length;
	             slide2(i); 
	            }
	  },
	  function () {
	      
	            timer2 = window.setTimeout(autoroll2, offset2);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box2 div').hover(
			  function () {
			    if (timer2) {
			                clearTimeout(timer2);
			    i = $(this).prevAll().length;
			             slide2(i); 
			            }
			  },
			  function () {
			      
			            timer2 = window.setTimeout(autoroll2, offset2);  
			            this.blur();            
			            return false;
			  }
			); 
	}
function hookThumb3(){    
	 $('.tabAuto3 li').hover(
	  function () {
	    if (timer3) {
	                clearTimeout(timer3);
	    i = $(this).prevAll().length;
	             slide3(i); 
	            }
	  },
	  function () {
	      
	            timer3 = window.setTimeout(autoroll3, offset3);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box3 div').hover(
			  function () {
			    if (timer3) {
			                clearTimeout(timer3);
			    i = $(this).prevAll().length;
			             slide3(i); 
			            }
			  },
			  function () {
			      
			            timer3 = window.setTimeout(autoroll3, offset3);  
			            this.blur();            
			            return false;
			  }
			); 
	}

function hookThumb4(){    
	 $('.tabAuto4 li').hover(
	  function () {
	    if (timer4) {
	                clearTimeout(timer4);
	    i = $(this).prevAll().length;
	             slide4(i); 
	            }
	  },
	  function () {
	      
	            timer4 = window.setTimeout(autoroll4, offset4);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box4 div').hover(
			  function () {
			    if (timer4) {
			                clearTimeout(timer4);
			    i = $(this).prevAll().length;
			             slide4(i); 
			            }
			  },
			  function () {
			      
			            timer4 = window.setTimeout(autoroll4, offset4);  
			            this.blur();            
			            return false;
			  }
			); 
	}

function hookThumb5(){    
	 $('.tabAuto5 li').hover(
	  function () {
	    if (timer5) {
	                clearTimeout(timer5);
	    i = $(this).prevAll().length;
	             slide5(i); 
	            }
	  },
	  function () {
	      
	            timer5 = window.setTimeout(autoroll5, offset5);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box5 div').hover(
			  function () {
			    if (timer5) {
			                clearTimeout(timer5);
			    i = $(this).prevAll().length;
			             slide5(i); 
			            }
			  },
			  function () {
			      
			            timer5 = window.setTimeout(autoroll5, offset5);  
			            this.blur();            
			            return false;
			  }
			); 
	}

function hookThumb6(){    
	 $('.tabAuto6 li').hover(
	  function () {
	    if (timer6) {
	                clearTimeout(timer6);
	    i = $(this).prevAll().length;
	             slide6(i); 
	            }
	  },
	  function () {
	      
	            timer6 = window.setTimeout(autoroll6, offset6);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box6 div').hover(
			  function () {
			    if (timer6) {
			                clearTimeout(timer6);
			    i = $(this).prevAll().length;
			             slide6(i); 
			            }
			  },
			  function () {
			      
			            timer6 = window.setTimeout(autoroll6, offset6);  
			            this.blur();            
			            return false;
			  }
			); 
	}

function hookThumb8(){    
	 $('.tabAuto08 li').hover(
	  function () {
	    if (timer8) {
	                clearTimeout(timer8);
	    i = $(this).prevAll().length;
	             slide8(i); 
	            }
	  },
	  function () {
	      
	            timer8 = window.setTimeout(autoroll8, offset8);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tgh-box08 div').hover(
			  function () {
			    if (timer8) {
			                clearTimeout(timer8);
			    i = $(this).prevAll().length;
			             slide8(i); 
			            }
			  },
			  function () {
			      
			            timer8 = window.setTimeout(autoroll8, offset8);  
			            this.blur();            
			            return false;
			  }
			); 
	 
	}

function hookThumbxpqx(){    
	 $('.j-sw-nav li').hover(
	  function () {
	    if (timerxpqx) {
	                clearTimeout(timerxpqx);
	    y = $(this).prevAll().length;
	             slidexpqx(y); 
	            }
	  },
	  function () {
	      
	            timerxpqx = window.setTimeout(autorollxpqx, offsetxpqx);  
	            this.blur();            
	            return false;
	  }
	); 
	 $('.tabxpqx div').hover(
			  function () {
			    if (timerxpqx) {
			                clearTimeout(timerxpqx);
			    y = $(this).prevAll().length;
			             slidexpqx(y); 
			            }
			  },
			  function () {
			      
			            timerxpqx = window.setTimeout(autorollxpqx, offsetxpqx);  
			            this.blur();            
			            return false;
			  }
			); 
	}

//首页女装
function hookThumwomen130122()
{
	 $('.womenindex li').hover(
			  function () {
			    //if (timer5) {
			                clearTimeout(timer5);
			    i = $(this).prevAll().length;
			    slidewomen130122(i); 
			           // }
			  },
			  function () {
			      
			            //timer5 = window.setTimeout(autorollwomen130122, offset130122);  
			            this.blur();            
			            return false;
			  }
			); 
			 $('.womenindexcontent div').hover(
					  function () {
					    //if (timer5) {
					                clearTimeout(timer5);
					    i = $(this).prevAll().length;
					    slidewomen130122(i); 
					           // }
					  },
					  function () {
					      
					            //timer5 = window.setTimeout(autorollwomen130122, offset130122);  
					            this.blur();            
					            return false;
					  }
					); 
}
//首页男装
function hookThummen130122()
{
	 $('.menindex li').hover(
			  function () {
			    //if (timer6) {
			                clearTimeout(timer6);
			    i = $(this).prevAll().length;
			    slidemen130122(i); 
			      //      }
			  },
			  function () {
			      
			           // timer6 = window.setTimeout(autorollmen130122, offsets130122);  
			            this.blur();            
			            return false;
			  }
			); 
			 $('.menindexcontent div').hover(
					  function () {
					    //if (timer6) {
					                clearTimeout(timer6);
					    i = $(this).prevAll().length;
					    slidemen130122(i); 
					    //        }
					  },
					  function () {
					      
					            //timer6 = window.setTimeout(autorollmen130122, offsets130122);  
					            this.blur();            
					            return false;
					  }
					); 
}

//首页饰品
function hookThumsp130122()
{
	 $('.spindex li').hover(
			  function () {
			    //if (timer7) {
			                clearTimeout(timer7);
			    i = $(this).prevAll().length;
			    slidesp130122(i); 
			      //      }
			  },
			  function () {
			      
			           // timer7 = window.setTimeout(autorollsp130122, offsetss130122);  
			            this.blur();            
			            return false;
			  }
			); 
			 $('.spindexcontent div').hover(
					  function () {
					    //if (timer7) {
					                clearTimeout(timer7);
					    i = $(this).prevAll().length;
					    slidesp130122(i); 
					    //        }
					  },
					  function () {
					      
					            //timer6 = window.setTimeout(autorollsp130122, offsetss130122);  
					            this.blur();            
					            return false;
					  }
					); 
}
//首页化妆品
function hookThumcosmetic130122()
{
	 $('.cosmeticindex li').hover(
			  function () {
			    //if (timer7) {
			                clearTimeout(timer7);
			    i = $(this).prevAll().length;
			    slidecosmetic130122(i); 
			      //      }
			  },
			  function () {
			      
			           // timer7 = window.setTimeout(autorollsp130122, offsetss130122);  
			            this.blur();            
			            return false;
			  }
			); 
			 $('.cosmeticindexcontent div').hover(
					  function () {
					    //if (timer7) {
					                clearTimeout(timer7);
					    i = $(this).prevAll().length;
					    slidecosmetic130122(i); 
					    //        }
					  },
					  function () {
					      
					            //timer6 = window.setTimeout(autorollsp130122, offsetss130122);  
					            this.blur();            
					            return false;
					  }
					); 
}