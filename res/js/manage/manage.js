function sgadminact(){
	var req_gdsid = $("#req_gdsid").val();
	var req_gdsname = $("#req_gdsname").val();
	var req_cls=$('#req_cls option:selected').val();
	var req_xsnum = $("#req_xsnum").val();
	var req_mailflag=$('#req_mailflag option:selected').val();
	var req_maxnum = $("#req_maxnum").val();
	var req_memo = $("#req_memo").val();
	var req_sort = $("#req_sort").val();
	var req_vallnum = $("#req_vallnum").val();
	var req_vusrnum = $("#req_vusrnum").val();
	var req_mailsort = $("#req_mailsort").val();
	var req_status=$('#req_status option:selected').val();
	var hsgimg = $("#hsgimg").val();
	var req_realbuynum = $("#req_realbuynum").val();
	var req_limitgroup = $("#req_limitgroup").val();
	var sgflag = $("#sgflag").val();
	var id = $("#id").val();
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/sgadmin_act.jsp',
		cache: false,
		data: {id:id,req_gdsid:req_gdsid,req_gdsname:req_gdsname,req_cls:req_cls,req_xsnum:req_xsnum,req_mailflag:req_mailflag,req_maxnum:req_maxnum
			,req_sort:req_sort,req_status:req_status,hsgimg:hsgimg,req_memo:req_memo,req_realbuynum:req_realbuynum,req_vallnum:req_vallnum,req_vusrnum:req_vusrnum
			,req_mailsort:req_mailsort,req_limitgroup:req_limitgroup,sgflag:sgflag},
		error: function(XmlHttpRequest){
		},success: function(json){	
			if(parseInt(json.code)==1){
				//sgimgact();
				alert(json.message);
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function sgimgact(){
	 $("#sgupload").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload?va=' + (new Date()).getTime(),
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue6',
		   'queueSizeLimit'  :1, 
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',                
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
		   'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	  
			   if(response.indexOf(';')>0){
	    		   var sg_arr=response.split(';');
	    		   var sgimgurl="http://www.d1.com.cn"+sg_arr[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt6').html('');
					$('#spzt6').append("<img src='"+sgimgurl+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
					$('#hsgimg').val(sg_arr[0]);
	    	   }					   
	       }

		});
}

function kfimgact(i){
	 $("#kfupload"+i).uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload?va=' + (new Date()).getTime(),
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue6',
		   'queueSizeLimit'  :1, 
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',                
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
		   'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	  
			   if(response.indexOf(';')>0){
	    		   var sg_arr=response.split(';');
	    		   var sgimgurl="http://www.d1.com.cn"+sg_arr[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt'+i).html('');
					$('#spzt'+i).append("<img src='"+sgimgurl+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
					$('#hsgimg'+i).val(sg_arr[0]);
	    	   }					   
	       }

		});
}
function sgdel(id)
{
	var b = window.confirm('确定要删除id为'+id+'的记录吗？')
	if(b){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/sgadmin_del.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
		        		alert(json.message);
						$('#sel_del_'+id).hide();
					}else{
						alert(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	
	}else{
		return false;
	}
}

function sgshow(id,flag)
{
	
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/sgadmin_upflag.jsp",
		        cache: false,
		        data:{id:id,showflag:flag},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
		        		alert(json.message);
		        		if(flag=="1"){
		        		$('#showbut'+id).html("<input type='submit' name='button2"+id+"'  onclick=sgshow('"+id+"','0'); id='button2"+id+"' value='设为不显示' />");
		        		}else{
		        			$('#showbut'+id).html("<input type='submit' name='button2"+id+"' onclick=sgshow('"+id+"','1'); id='button2"+id+"' value='设为显示'  />");
		        		}
					}else{
						alert(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	

}
function sgmain(id,flag)
{
	
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/sgadmin_upflag.jsp",
		        cache: false,
		        data:{id:id,mainflag:flag},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
		        		alert(json.message);
		        		if(flag=="1"){
			        		$('#mainbut'+id).html("<input type='submit' name='button3"+id+"'  onclick=sgmain('"+id+"','0'); id='button3"+id+"' value='邮件不显示' />");

		        		}else{
			        		$('#mainbut'+id).html("<input type='submit' name='button3"+id+"' onclick=sgmain('"+id+"','1'); id='button3"+id+"' value='邮件显示'  />");

		        		}
					}else{
						alert(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	

}
function sggetlist(obj){
	var req_gdsid=$('#req_gdsid').val();
    var req_mailflag=$('#req_mailflag option:selected').val();  
    var req_cls=$('#req_cls option:selected').val();  
    var req_status=$('#req_status option:selected').val(); 
	var req_gdsname=$('#req_gdsname').val();

$.get("/admin/ajax/getsglist.jsp",{"req_gdsid":req_gdsid,"req_mailflag":req_mailflag,"req_cls":req_cls,"req_status":req_status
	,"req_gdsname":req_gdsname,"m":new Date().getTime()},function(data){
	$('#sglist').html(data);
});
}