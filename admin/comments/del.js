 function search(){
	 var txtstart = $('#txtstart').val();
	 var txtend = $('#txtend').val();
	 var txtgdsid = $('#txtgdsid').val();
	 var url = "/admin/comments/deletecomment.jsp?txtstart="+encodeURIComponent($('#txtstart').val())+"&txtend="+encodeURIComponent($('#txtend').val())+"&txtgdsid="+encodeURIComponent($('#txtgdsid').val());
	    top.location.href=url;
 }
 