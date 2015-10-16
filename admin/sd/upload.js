
$(document).ready(function(){
	 $("#uploadify").uploadify({
         'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
         'script'         : '/servlet/Upload?va=' + (new Date()).getTime(),//��̨���������
     	 'method' :'GET',
         'cancelImg'      : '/res/js/uploadify/cancel.png',
         'folder'         : '/uploads/sd',//���뽫�ļ����浽��·��
         'queueID'        : 'fileQueue',//�������id��Ӧ
         'queueSizeLimit'  :1, 
        // 'simUploadLimit' ��5, // ����ͬʱ�ϴ��ĸ��� Ĭ��ֵ��1 ��
         'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
         'fileExt' : '*.jpg;*.jpeg;*.png;*.gif', //���ƿ��ϴ��ļ�����չ�����ñ���ʱ��ͬʱ����fileDesc                
         'auto'           : true,//�Ƿ������ϴ�
         'multi'          : false,//�Ƿ�����ϴ�����ļ�
         'sizeLimit': 5120000,//�����ļ��ϴ���С( ��λ��KB)
         'buttonImg':'http://images.d1.com.cn/images2012/sd/an_03.jpg',
         'hideButton':true, 
         'buttonText'     : 'BROWSE'

     });
	 

	 var imgurl=$.trim($("#himgurl").val());
	  if(imgurl.length>0){
		  $("#testimgs").attr("src",imgurl);
		  var imgwidth = $("#hw").val();
			var imgheight =  $("#hh").val();//ԭͼƬ��
			var w=imgwidth;
			var h=imgheight;
			 if(imgwidth>400){
				w=400;
				h=(imgheight * 400) / imgwidth;
			}
			 $("#divshowmsg").show();
			 $("#testimgs").attr("width",w);
			 $("#testimgs").attr("height",h);
			 $("#aimg").attr("href",imgurl);
	  }else{
		  $("#divshowmsg").hide();
	  }
});

  //����ɹ��
  function cmtshoworder(){
	  var gdsid=$.trim($("#showgdsid").val());
	  var content=$.trim($("#tcontent").val());	
	  var imgurl=$.trim($("#himgurl").val());
	  var w=$.trim($("#hw").val());
	  var h=$.trim($("#hh").val());
	  var sddate=$.trim($("#cdate").val());
	  var uid=$.trim($("#uid").val());
	  if(gdsid.length==0){
		  alert("请输入商品编号"); 
	  }else if(uid.length==0){
		 alert("请输入用户名!"); 
	  }
	  else if(imgurl.length==0){
		  alert("请选择上传图片！"); 
	  }
	  else if(content.length==0 ){
		  alert("请输入晒单内容！");
	  }
	  else{
			$.ajax({
				type: "get",
				dataType: "json",
				url: 'sdop.jsp',
				cache: false,
				data: {gdsid:gdsid,imgurl:imgurl,w:w,h:h,uid:uid,content:content,sddate:sddate},
				error: function(XmlHttpRequest){
					alert("晒单错误 ");
				},success: function(json){
					if(json.success){
						alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	  }
  }
 
  