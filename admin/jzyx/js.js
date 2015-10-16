function getGdsser(obj){
	var brand= $.trim($('#sbrand').val());
	BindGdsser(brand);
}
function BindGdsser(brand){
    var sgdsser = $('#sgdsser');
    if (brand == null || brand.length == 0){
        sgdsser.empty();
        $("<option value=''>==请选择==</option>").appendTo(sgdsser);
        return;
    }
    
    $.ajax({
        type: "GET",
        url: "getGdsser.jsp",
        data:{brand:brand},
        success: function(data){
        	sgdsser.empty();
        	$("<option value=''>==请选择==</option>").appendTo(sgdsser);
            if (data != "-1"){
                var subject = data.split(",");
                $.each(subject, function(){
                    var opt = this.split("|");
                    $("<option value=" + opt[0]+ ">" + opt[1] + "</option>").appendTo(sgdsser);
                });
            }
        },error: function(XmlHttpRequest){
        	sgdsser.empty();
        	$("<option value=''>==请选择==</option>").appendTo(sgdsser);
        }
    });
}