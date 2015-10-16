
 
<%List<Promotion> index_banner = PromotionHelper.getBrandListByCode("3884" , 1);
if(index_banner != null && !index_banner.isEmpty()){
	Promotion pt=index_banner.get(0);
	if(pt!=null){
 %>
<style type="text/css">
.index_banner {
	background-repeat: no-repeat;
	background-position: center;
	height:70px;
}
</style>
<div style="margin:0px auto;background:<%=pt.getSplmst_picstr2()%>" align="center">
<a href="<%=pt.getSplmst_url()%>" target="_blank">
<div class="index_banner" style="background-image: url(<%=pt.getSplmst_picstr()%>);"></div></a>
</div>
<%}} %>

