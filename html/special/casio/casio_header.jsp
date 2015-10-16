<%@ page contentType="text/html; charset=UTF-8"%>

<table width="1004" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:8px;">
  <form name=frm_srch method=post action="/html/result_s.asp" style="MARGIN-BOTTOM: 2px; MARGIN-TOP: 0px">
    <tr>
      <td align=middle bgColor=#dbdbdb height=30>名表型号:<input name="productname" size="10" style="width:125px">
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        名表品牌:<select name="productsort" size="1" class="input2" style="width:125px">
          <option selected value="015002004">全部</option>
          <option value="015002004001" selected>CASIO卡西欧手表 </option>
          <option value="015002004002">CITIZEN西铁城手表 </option>
          <option value="015002004007">TISSOT天梭 </option>
          <option value="015002004008">手表配件 </option>
          <option value="015002004010">欧米茄 </option>
          <option value="015002004011">雷 达 </option>
          <option value="015002004012">浪 琴 </option>
          <option value="015002004013">东方双狮 </option>
          <option value="015002004017">梅花 </option>
          <option value="015002004018">瑞尔玛 </option>
          <option value="015002004019">SUUNTO </option>
          <option value="015002004021">摩凡陀 </option>
          <option value="015002004022">CK </option>
          <option value="015002004023">IWC万国 </option>
          <option value="015002004030">TAG Heuer 豪雅 </option>
          <option value="015002004031">Polar博能 </option>
          <option  value="015">全部时尚礼品</option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        价格范围:<select name="productprice" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="-200"> 小于200</option>
          <option value="200-300"> 200-300</option>
          <option value="300-500"> 300-500</option>
          <option value="500-1000"> 500-1000</option>
          <option value="1000-2000"> 1000-2000</option>
          <option value="2000-3000"> 2000-3000</option>
          <option value="3000-5000"> 3000-5000</option>
          <option value="5000-10000"> 5000-10000</option>
          <option value="10000-"> 大于10000</option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        性别款式:<select name="productother1" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="男式">男式 </option>
          <option value="女式">女式 </option>
          <option value="中性">中性 </option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        外观形状:<select name="productother2" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="圆形">圆形 </option>
          <option value="方形">方形 </option>
        </select>
      </td>
	</tr>
	<tr>
      <td align=middle bgColor=#dbdbdb height=30>
        机芯类型:<select name="productother3" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="电子">电子 </option>
          <option value="石英">石英 </option>
          <option value="机械">机械 </option>
          <option value="光动能">光动能 </option>
          <option value="电波">电波 </option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        表盘颜色:<select name="productother4" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="白色">白色 </option>
          <option value="银色">银色 </option>
          <option value="黑色">黑色 </option>
          <option value="灰色">灰色 </option>
          <option value="红色">红色 </option>
          <option value="粉色">粉色 </option>
          <option value="橙色">橙色 </option>
          <option value="黄色">黄色 </option>
          <option value="绿色">绿色 </option>
          <option value="蓝色">蓝色 </option>
          <option value="紫色">紫色 </option>
          <option value="棕色">棕色 </option>
          <option value="金色">金色 </option>
          <option value="液晶">液晶 </option>
          <option value="多种颜色">多种颜色 </option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        表带颜色:<select name="productother5" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="白色">白色 </option>
          <option value="银色">银色 </option>
          <option value="黑色">黑色 </option>
          <option value="灰色">灰色 </option>
          <option value="红色">红色 </option>
          <option value="粉色">粉色 </option>
          <option value="橙色">橙色 </option>
          <option value="黄色">黄色 </option>
          <option value="绿色">绿色 </option>
          <option value="蓝色">蓝色 </option>
          <option value="紫色">紫色 </option>
          <option value="棕色">棕色 </option>
          <option value="金色">金色 </option>
          <option value="液晶">液晶 </option>
          <option value="多种颜色">多种颜色 </option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        表带材质:<select name="productother6" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="树脂">树脂 </option>
          <option value="橡胶">橡胶 </option>
          <option value="纺织">纺织 </option>
          <option value="皮革">皮革 </option>
          <option value="铝">铝 </option>
          <option value="纯钢">纯钢 </option>
          <option value="钛金">钛金 </option>
          <option value="银">银 </option>
          <option value="镀金">镀金 </option>
          <option value="白金">白金 </option>
          <option value="高科技陶瓷">高科技陶瓷 </option>
          <option value="钨钢">钨钢 </option>
          <option value="钻石">钻石 </option>
        </select>
      </td>
      <td align=middle bgColor=#dbdbdb height=30>
        防水深度:<select name="productother7" size="1" style="width:125px">
          <option value="">全部</option>
          <option value="日常防水">日常防水 </option>
          <option value="30M">30M </option>
          <option value="50M">50M </option>
          <option value="100M">100M </option>
          <option value="200M">200M </option>
          <option value="300M">300M </option>
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="5" align=center bgColor=#dbdbdb height=30><input type=submit name=button value="名表搜索">
      </td>
    </tr>
  </form>
</table>
<table width="1004" align="center"  cellpadding="5" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#000000" class="border">
  <tr>
    <td align="center" valign="middle"><a href="casio.jsp" target="_blank">CASIO卡西欧手表首页</a></td>
    <td align="center" valign="middle"><a href="http://www.d1.com.cn/html/special/casio/casio_edifice.asp" target="_blank">CASIO卡西欧EF商务指针手表</a></td>
    <td align="center" valign="middle"><a href="http://www.d1.com.cn/html/special/casio/casio_sheen.asp" target="_blank">CASIO卡西欧SHEEN商务女表</a></td>
    <td align="center" valign="middle"><a href="/result.jsp?productsort=015002004001016&productsortflag=0" target="_blank">CASIO卡西欧双显手表</a></td>
    <td align="center" valign="middle" rowspan=3>
	</td>
  </tr>
  <tr>
    <td align="center" valign="middle"><a href="../mini/index.jsp?id=122" target="_blank">CASIO卡西欧PRG登山航海手表</a></td>
    <td align="center" valign="middle"><a href="/result.jsp?productsortflag=0&productsort=015002004001001" target="_blank">CASIO卡西欧BABY-G手表</a></td>
    <td align="center" valign="middle"><a href="/result.jsp?productsortflag=0&productsort=015002004001002,015002004001003,015002004001004,015002004001006,015002004001015" target="_blank">CASIO卡西欧G-SHOCK运动手表</a></td>
    <td align="center" valign="middle"><a href="/result.jsp?productsortflag=0&productsort=015002004001007" target="_blank">CASIO卡西欧ILLUMINATOR手表</a></td>
  </tr>
  <tr>
    <td align="center" valign="middle"><a href="/result.jsp?productsortflag=0&productsort=015002004001" target="_blank">CASIO卡西欧电波手表</a></td>
    <td align="center" valign="middle"><a href="/result.jsp?productsortflag=0&productsort=015002004001014,015002004001019,015002004001016" target="_blank">CASIO卡西欧普通&amp;指针手表</a></td>
    <td align="center" valign="middle" ><span style="color:#ffffff">CASIO团购51665136-8008</span></td>
    <td align="center" valign="middle"></td>
  </tr>
</table>