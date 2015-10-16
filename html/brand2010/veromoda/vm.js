function getindexp(gdsid,w,flag,left,position,endtop,tf)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
	{       
		    $(obj).html("");
		    $(obj).css("left","");
		    $(obj).css("top","");
		    $(obj).css("bottom","");
		    $("#tbimg_"+flag).css("top","");
		    //$(obj).css("background-color","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:100px; margin-top:100px; \"/>");
			$.post("/html/getindexp20120711.jsp",{"gdsid":gdsid,w:w,flag:flag,tf:tf},function(data){
			$(obj).html(data);
	
				if(flag==1||flag==2||flag==3||flag==4||flag==11)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm.png";
						}
						bgc="#d8d8d8";
						border="#545454";
					}

					if(flag==8||flag==9||flag==10)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png";
						}
						bgc="#dbd5c7";
						border="#a99c94";
					}
					if(flag==5||flag==6||flag==7)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png";
						}
						else
						{
						    bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png";
						}
						bgc="#b2366c";
						border="#722245";
					}
					for(var i=1;i<=11;i++)
					{
						var obj1=$("#div_"+i);
						if(obj1!=null&&i!=flag)
							{
							  obj1.css("display","none");
							}
					}
				
				$(obj).css("left",left);				
				$(obj).css(position,endtop);
				$(obj).css("display","block");
				$(obj).css("z-index","20000");
			});
	
    }
}


function mdmoverf(flag)
{
	var obj=$("#div_"+flag);
	obj.css("display","block");
}


 function mdmoutf(flag)
{
	 var obj=$("#div_"+flag);
		obj.css("display","none");
}
function mdmoverf1(gdsid,w,flag,left,position,endtop,tf)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
		{
		   getindexp(gdsid,w,flag,left,position,endtop,tf);
		}
    
}