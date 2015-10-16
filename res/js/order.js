// JavaScript Document
function $aa(id) { return document.getElementById(id) };

function bindtags(tags1,contentlist,bigdiv)
{
   var 	t0=$aa(tags1).getElementByNames("a");
   var c0=$aa(contentlist).getElementByNames("div");
   
}
function switch_tags(tags, contents, cls, index, method, time) {
    this.time = time;
    this.method = method;
    this.tags = tags;
    this.contents = contents;
    this.cls = cls;
    this.c_index = index;
    tags[index].className = cls;
    if(index==0)
	{
	 $aa("tags").className="tags";
	}
    else if(index==1)
	{
	 $aa("tags").className="tags1";
	}
    else if(index==2)
    	{
    	$aa("tags").className="tags2";
    	}
    else
    	{
    	$aa("tags").className="tags";
    	}
    contents[index].style.display = "";
    this.bind_switch();
};

switch_tags.prototype.bind_switch = function() {
    var nb = this;
    var set_int;
    for (var i = 0; i < this.tags.length; i++) {
        this.tags[i].index = i;
        //onmouseover	
        if (this.method == "click") {
            this.tags[i].onmouseover = function() {
                var o = this;
                set_int = setTimeout(function() { sw(o.index) }, nb.time);
            };
            this.tags[i].onmouseout = function() {clearTimeout(set_int); }
        }
        //onclick
        else if (this.method == "mouseover") {
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
		switch(m)
		{
			case 0:
					 {
						 //obj.style.color="#fff";
						 //nb.tags[1].style.color="#333";
						// nb.tags[2].style.color="#333";
						 $aa("tags").className="tags";
						 break;
					 };
			case 1:
			{
				//obj.style.color="#fff";
			    //nb.tags[0].style.color="#333";
				//nb.tags[2].style.color="#333";
				$aa("tags").className="tags1";
						 break;
			};
			case 2:
			{
				//obj.style.color="#fff";
				$aa("tags").className="tags2";
						 break;
			};
			
			default:
					{
				   $aa("tags").className="tags";
						 break;
				};
		}
    };
	
};

var t0 = $aa("tags").getElementsByTagName("a");
var c0 = $aa("content_list").getElementsByTagName("div");
var strHref = window.document.location.href;
if(strHref.indexOf("?")>0)
	{
	  if(strHref.lastIndexOf('=')>5)
		  {
		     strHref=strHref.substr((strHref.lastIndexOf('=')-7),7);
		     if(strHref=='pageno1')
		    	 {
		    	 new switch_tags(t0, c0, "active", 0, "mouseover");
		    	 }
		     else if(strHref=='pageno2')
		    	 {
		    	 new switch_tags(t0, c0, "active", 1, "mouseover");
		    	 }
		     else if(strHref=='pageno3')
		    	 {
		    	 new switch_tags(t0, c0, "active", 2, "mouseover");
		    	 }
		     else
		    	 {
		    	 new switch_tags(t0, c0, "active", 0, "mouseover");
		    	 }
		  }
	  else
		  {
		  new switch_tags(t0, c0, "active", 0, "mouseover");
		  }
	}
else
	{
	  new switch_tags(t0, c0, "active", 0, "mouseover");
	}

//new switch_tags(t0, c0, "active", 0, "mouseover");

//var t1 = $aa("yh_tags").getElementsByTagName("a");
//var c1 = $aa("yh_content_list").getElementsByTagName("div");
//new switch_tags(t1, c1, "active", 0, "mouseover");



