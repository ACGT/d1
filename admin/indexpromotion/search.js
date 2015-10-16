 function search(){
	 var txtpromotionid = $('#txtpromotionid').val();
	 var url = "/admin/indexpromotion/index.jsp?txtpromotionid="+encodeURIComponent($('#txtpromotionid').val());
	    top.location.href=url;
 }
 