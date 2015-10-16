 function pad(num, n) {
	    var len = num.toString().length;
	    while(len < n) {
	        num = "0" + num;
	        len++;
	    }
	    return num;
	}
   
   function $getid(id)
   {
       return document.getElementById(id);
   }

 //��ʱ����
	var the_s=new Array();
	function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = " 倒计时：";
	        if(the_D!=0) html += the_D+"天";
	        if(the_D!=0 || the_H!=0) html += pad(the_H,2)+":";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += pad(the_M,2)+":";
	        html += pad(the_S,2);
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }
	}