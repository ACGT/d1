<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Welcome to my FlexBox</title>
  <link rel="stylesheet" type="text/css" href="/res/css/jquery.flexbox.css" />
<script src="/res/js/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/res/js/jsSource/jquery.flexbox.js"></script>

   <script type="text/javascript">
   $(function() {
      var countries = {};
      countries.results = [
		{id:'AF',name:'Afghanistan'},
		{id:'AL',name:'Albania'},
		{id:'DZ',name:'Algeria'},
		{id:'AS',name:'American Samoa'},
		{id:'AD',name:'Andorra'},
		{id:'AO',name:'Angola'},{id:'ZW',name:'Zimbabwe'}
      ];
      countries.total = countries.results.length;
	  
	  $('#ffb1').flexbox('/ajax/search/hotkeys.jsp',{
		  autoCompleteFirstMatch: false,
		    selectFirstMatch:false,
		    noResultsText: '',
		    paging: false,
		    width:200,
		    initialValue:'请输入您要搜索的商品名称或编码',
		    inputClass:'',
		    containerClass:'ffb',
		    contentPos:{w:-7,t:-10,l:-1}
		  
		  });
    });
   </script>
   </head>
   <body>
   <div id="ffb1"></div>
   </body>
   </html>