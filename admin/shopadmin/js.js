function Bindrackcode(pcode, rcode,i){
	var ddl="#rackcode"+i;
    var rackcode2 = $(ddl);
    if (pcode == null || pcode.length == 0){
    	rackcode2.empty();
        return;
    }
    
    $.ajax({
        type: "GET",
        url: "getrackcode.jsp",
        data:{pcode:pcode},
        success: function(data){
        	rackcode2.empty();   
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function(){
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + (rcode==opt[0]?" selected":"") + ">" + opt[1] + "</option>").appendTo(rackcode2);
                });
                $(ddl).show();
                changeRck(i);  
            }else{
                 for(var k=i;k<=5;k++){
                		 ddl2="#rackcode"+k;
                		 $(ddl2).hide();
                	 }
                
                
            }
        },error: function(XmlHttpRequest){
        	rackcode2.empty();
        }
    });
}

function changeRck(i){
	var ddlpcode="#rackcode"+i;
	var pcode=$.trim($(ddlpcode).val());
	var rcode=$.trim($("#rackcode").val());
	if(rcode.length>=i*3){
		rcode=rcode.substr(0,i*3);
	}
	
	if(pcode.length>0){
		Bindrackcode(pcode, rcode,i+1);
	}
	 if(i==2){
     	getbrand();
     }
}

function getbrand(){
	var bcode=$.trim($("#bcode").val());
    var ddlbrand = $("#brand");
    var rackcode=$.trim($("#rackcode2").val())
    if (rackcode == null || rackcode.length == 0){
    	ddlbrand.empty();
        return;
    }
    
    $.ajax({
        type: "GET",
        url: "getrackcode.jsp",
        data:{rackcode:rackcode},
        success: function(data){
        	ddlbrand.empty();   
        	 $("<option value=''>==请选择==</option>").appendTo(ddlbrand);
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function(){
                    var opt = this.split("|");
                    $("<option value=" + opt[0] + (bcode==opt[0]?" selected":"") + ">" + opt[1] + "</option>").appendTo(ddlbrand);
                });
              
            }
        },error: function(XmlHttpRequest){
        	ddlbrand.empty();
        }
    });
}

//建立一个类
var Upload = {


//类方法,清除一个上传控件的内容
clear: function(id) {

        //如果传过来的参数是字符,则取id为该字符的元素,如果无此元素,则返回空
        var up = (typeof id == "string") ? document.getElementById(id) : id;
        if (typeof up != "object") return null;
        
        //创建一个span元素
        var tt = document.createElement("span");
        //添加id,以便后面使用
        tt.id = "__tt__";
        up.parentNode.insertBefore(tt, up);
        
        //创建一个form
        var tf = document.createElement("form");
        //将上传控件追加为form的子元素
        tf.appendChild(up);
        
        //将form加入到body
        document.getElementsByTagName("body")[0].appendChild(tf);
        
        //利用重置来清空上传控件内容
        tf.reset();
        
        //所上传控件放回原来的位置
        tt.parentNode.insertBefore(up, tt);
        
        //除上面创建的这个span
        tt.parentNode.removeChild(tt);
        tt = null;
        
        //移除上面临时创建的form
        tf.parentNode.removeChild(tf);
    },
    
    //类方法,清除多个上传控件的内容
    clearForm: function() {
    var inputs, frm;
        
        //如果没有参数传递过来,则获取所有inpur类型的控件
        if (arguments.length == 0) {
            inputs = document.getElementsByTagName("input");
        } 
        //如果有参数传递过来
        else {
            //如果传一个ID过来,则取得该ID的元素,否则直接使用该元素
            frm = (typeof arguments[0] == "string") ? document.getElementById(arguments[0]) : arguments[0];
            
            //如果不是一个object对象,返回null
            if (typeof frm != "object") return null;
            
            //如果传递的是一个object对象,取得这个对象内所有的input类型的元素
            inputs = frm.getElementsByTagName("input");
        }
        
        //遍历所有获取的元素,如果是上传控件类型,则加入到一个数组的末尾.
        var fs = [];
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type == "file") fs[fs.length] = inputs[i];
        }


        //创建一个form元素
        var tf = document.createElement("form");
        for (var i = 0; i < fs.length; i++) {
        
            //每个上传控件前创建一个span元素,用来标记它的位置,而span不会影响它的样式
            var tt = document.createElement("span");
            //为每个span加一个id,以便后面将上传控件放回原来位置
            tt.id = "__tt__" + i;
            
            //将这个span元素作为组中的每一个上传控件的兄弟元素插入到每一个上传控件之前
            fs[i].parentNode.insertBefore(tt, fs[i]);
            
            //将这个上传控件追加到新创建的form中
            tf.appendChild(fs[i]);
        }
        
        //将新创建的form追加到页面body中
        document.getElementsByTagName("body")[0].appendChild(tf);
        
        //重置form,以便清空各上传控件的值.(利用重置来清空内容)
        tf.reset();
        
        //将各个上传控件重新放回到原来的位置
        for (var i = 0; i < fs.length; i++) {
            var tt = document.getElementById("__tt__" + i);
            tt.parentNode.insertBefore(fs[i], tt);
            tt.parentNode.removeChild(tt);
        }
        tf.parentNode.removeChild(tf);
    }
} 
function getFullPath(obj) {    //获得图片完整路径 
    if (obj) {  
        //firefox  
        if (window.navigator.userAgent.indexOf("Firefox") >= 1) {  
            if (obj.files) {  
                return obj.files.item(0).getAsDataURL();  
            }  
            return obj.value;  
        }  
        return obj.value;  
    }  
} 

$(document).ready(function(){
	getgg();
	$("#loadFile").change(function () {  
	    var strSrc = $("#loadFile").val();  
	    img = new Image();  
	   // img.src = getFullPath(strSrc);  
	    img.src = getFullPath(this); 
	    //验证上传文件格式是否正确  
	    var pos = strSrc.lastIndexOf(".");  
	    var lastname = strSrc.substring(pos, strSrc.length)  
	   var fileext=lastname.toLowerCase()   
	if ((fileext!='.jpg')&&(fileext!='.jpeg')&&(fileext!='.png')&&(fileext!='.bmp')&&(fileext!='.gif')){ 
		  alert("您上传的文件类型为" + lastname + "，图片必须为 jpg,jpeg,png,bmp,gif 类型"); 
	        return false;  
	    }  
	  //验证上传文件宽高
		var w=img.width ;
		var h=img.height;
		w=img.width;
	   // if (w<400 || h < 400) {  
	    //	  alert("您上传的图片必须大于等于400*400");  
	    //    return;  
	   // }  
	    //验证上传文件是否超出了大小  
	    if (img.fileSize / 1024 > 1024) {  
	    	 alert("您上传的文件大小超出了1M限制！");  
	        return false;  
	    } 
	    $("#stuPic").attr("src", getFullPath(this)); 
	});
	
	$("#loadFile2").change(function () {  
	    var strSrc = $("#loadFile2").val();  
	    img22 = new Image();  
	   // img.src = getFullPath(strSrc);  
	    img22.src = getFullPath(this); 
	    //验证上传文件格式是否正确  
	    var pos = strSrc.lastIndexOf(".");  
	    var lastname = strSrc.substring(pos, strSrc.length)  
	   var fileext=lastname.toLowerCase()   
	if ((fileext!='.jpg')&&(fileext!='.jpeg')&&(fileext!='.png')&&(fileext!='.bmp')&&(fileext!='.gif')){ 
		  alert("您上传的文件类型为" + lastname + "，图片必须为 jpg,jpeg,png,bmp,gif 类型"); 
	        return false;  
	    }  
	  //验证上传文件宽高
		var w=img22.width ;
		var h=img22.height;
		w=img22.width;
		//alert(w);alert(h);
	  //  if (w<300 || h < 300) {  
	    	//  alert("您上传的图片必须大于等于300*300");  
	      //  return;  
	   // }  
	    //验证上传文件是否超出了大小  
	    if (img22.fileSize / 1024 > 1024) {  
	    	 alert("您上传的文件大小超出了1M限制！");  
	        return false;  
	    } 
	    $("#stuPic2").attr("src", getFullPath(this)); 
	});
	
	});
function getimg(){
	var img=$("#img").val();
	 $("#stuPic").attr("src", img); 
}
function getimg2(){
	var img=$("#img2").val();
	 $("#stuPic2").attr("src", img); 
}
//获取规格名
function getgg(){
	var standid=$.trim($("#standid").val());
    if (standid == null || standid.length == 0){
    	$("#gg").hide();
    	$("#req_stdvalue1").empty();
    	$("#req_stdvalue2").empty();
    	$("#req_stdvalue3").empty();
    	$("#req_stdvalue4").empty();
    	$("#req_stdvalue5").empty();
    	$("#req_stdvalue6").empty();
    	$("#req_stdvalue7").empty();
    	$("#req_stdvalue8").empty();
        return;
    }
    
    $.ajax({
        type: "GET",
        url: "getrackcode.jsp",
        data:{ggid:standid},
        success: function(data){
        	$("#gg").show();
            if (data != "-1"){
                var subject = data.split(",");
                for(var i=0;i<subject.length;i++){
                	 var opt = subject[i].split("|");
                	if(i==0){//规格名
                		for(var j=0;j<opt.length;j++){
                			var s="#gg"+(j+1);
                			$(s).html(opt[j]);
                		}
                	}else{//规格内容
                		for(var j=0;j<opt.length;j++){
                			var s="#req_stdvalue"+(j+1);
               			 	$(s).empty();
                			var content=opt[j].split(";");
                			for(var k=0;k<content.length;k++){
                			$("<option value=" + content[k] + ">" + content[k]+ "</option>").appendTo(s);
                			}
                		}
                	}
                	
                }
               
              
            }
        },error: function(XmlHttpRequest){
        	$("#req_stdvalue1").empty();
        	$("#req_stdvalue2").empty();
        	$("#req_stdvalue3").empty();
        	$("#req_stdvalue4").empty();
        	$("#req_stdvalue5").empty();
        	$("#req_stdvalue6").empty();
        	$("#req_stdvalue7").empty();
        	$("#req_stdvalue8").empty();
        }
    });
}