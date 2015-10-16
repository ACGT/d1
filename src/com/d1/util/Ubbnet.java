package com.d1.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 替换ubb代码类
 * @author woaizhaozhao
 *
 */
public class Ubbnet {
	
	public static String ConvertBSS(String strContent){
		if(Tools.isNull(strContent)) return "";
		if ((strContent.indexOf("[") < 0 || strContent.indexOf("]") < 0) && strContent.indexOf("http://") < 0){
            return strContent;
        }
		//过滤script
		if (strContent.indexOf("on", 1) >= 0){
			strContent = strContent.replaceAll("on(\\w+)=", "on_$1=");
		}
		strContent = strContent.replace("file:","file :");
		strContent = strContent.replace("files:","files :");
		strContent = strContent.replace("script:","script :");
		strContent = strContent.replace("js:","js :");
		
		//过滤表格
        if (strContent.indexOf("[table]", 1) >= 0){
        	strContent = strContent.replace("<br>","");
        	strContent = strContent.replace("&nbsp;"," ");
        	strContent = strContent.replace("[table]","<table width=\"750px\" border=\"0\" cellspacing=\"1\" cellpadding=\"3\" align=\"center\" bgcolor=\"#FFFFFF\" class=\"main1\">");
        	strContent = strContent.replace("[/table]","</table>");
        	strContent = strContent.replace("[tr1]","<TR    align=\"center\">");
        	strContent = strContent.replace("[/tr1]","</tr>");
        	strContent = strContent.replace("[tr]","<tr  align=\"center\">");
        	strContent = strContent.replace("[trl]","<tr align=\"center\">");
        	strContent = strContent.replace("[trr]","<tr  align=\"center\">");
        	strContent = strContent.replace("[/tr]","</tr>");
        	strContent = strContent.replace("[td]","<TD>");
        	strContent = strContent.replace("[tdl]","<TD  align=\"left\">");
        	strContent = strContent.replace("[tdr]","<TD  align=\"right\">");
        	strContent = strContent.replace("[/td]","</td>");
        }
        Matcher m = null;
        //图片去掉宽度限制
        if(strContent.indexOf("[IMG]",1)>0 || strContent.indexOf("[img]", 1) > 0){
        	m = getMatcher(strContent , "(\\[IMG\\])(.[^\\[]*)(\\[\\/IMG\\])");
        	int imgUbb=1;
        	if(imgUbb==1){
        		if(strContent.indexOf("[img]/message/face",1)<0&&strContent.indexOf("[img]face",1)<0){
        			strContent = m.replaceAll("<a href=\"$2\" target=\"_blank\"><IMG SRC=\"$2\" border=\"0\" alt=\"按此在新窗口浏览图片\"></a>");
        		}else{
        			strContent = m.replaceAll("<IMG SRC=\"$2\" border=\"0\">");
        		}
        	}else{
        		strContent = m.replaceAll("<img align=\"absmiddle\" src=\"images/url.gif\"><a href=\"$2\" target=\"_blank\">$2</a>");
        	}
        }
        //图片自定义高宽
        if (strContent.indexOf("[/imgurl]",1)>=0){
        	m = getMatcher(strContent , "(\\[imgurl=(.[^\\]]*)\\])(.[^\\[]*)(\\[\\/imgurl\\])");
    		strContent = m.replaceAll("<A HREF=\"$2\" TARGET=\"_blank\"><img src=\"$3\" border=\"0\"></A>");
        }
        if(strContent.indexOf("[/imgnew]",1)>=0){
        	m = getMatcher(strContent , "\\[imgnew=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/imgnew]");
    		strContent = m.replaceAll("<a href=\"$3\" target=\"_blank\"><IMG SRC=\"$3\" width=\"$1\" height=\"$2\" border=0 alt=\"按此在新窗口浏览图片\" onload=\"javascript:if(this.width>550)this.width=550;if(this.height>550)this.height=550\"></a>");
        }
        //图片去掉宽度限制
        if(strContent.indexOf("[uploadimg]",1)>=0){
        	m = getMatcher(strContent , "(\\[uploadimg\\])(.[^\\[]*)(\\[\\/uploadimg\\])");
    		strContent = m.replaceAll("<a href=\"$2\" target=\"_blank\"><IMG SRC=\"$2\" border=\"0\" alt=\"按此在新窗口浏览图片\"></a>");
        }
        if(strContent.indexOf("[/dir]",1)>=0){
        	m = getMatcher(strContent , "\\[DIR=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/DIR]");
        	strContent = m.replaceAll("<object classid=\"clsid:166B1BCA-3F9C-11CF-8075-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=7,0,2,0\" width=$1 height=$2><param name=src value=$3><embed src=$3 pluginspage=\"http://www.macromedia.com/shockwave/download/\" width=$1 height=$2></embed></object>");
        }
        if(strContent.indexOf("[/qt]",1)>=0){
        	m = getMatcher(strContent , "\\[QT=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/QT]");
        	strContent = m.replaceAll("<embed src=$3 width=$1 height=$2 autoplay=true loop=false controller=true playeveryframe=false cache=false scale=TOFIT bgcolor=#000000 kioskmode=false targetcache=false pluginspage=http://www.apple.com/quicktime/>");
        }
        if(strContent.indexOf("[/mp]",1)>=0){
        	m = getMatcher(strContent , "\\[MP=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/MP]");
        	strContent = m.replaceAll("<object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=$1 height=$2 ><param name=ShowStatusBar value=-1><param name=Filename value=$3><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src=$3  width=$1 height=$2></embed></object>");
        }
        if(strContent.indexOf("[/rm]",1)>=0){
        	m = getMatcher(strContent , "\\[RM=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/RM]");
        	strContent = m.replaceAll("<OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=$1 height=$2><PARAM NAME=SRC VALUE=$3><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=$1><PARAM NAME=SRC VALUE=$3><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT>");
        }
        if(strContent.indexOf("[flash]",1)>=0){
        	m = getMatcher(strContent , "(\\[FLASH\\])(.[^\\[]*)(\\[\\/FLASH\\])");
        	strContent = m.replaceAll("<OBJECT codeBase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0 classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=500 height=400><PARAM NAME=movie VALUE=\"$2\"><PARAM NAME=quality VALUE=high><embed src=\"$2\" quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width=500 height=400>$2</embed></OBJECT>");
        }
        if(strContent.indexOf("[/url]",1)>=0){
        	m = getMatcher(strContent , "(\\[URL\\])(.[^\\[]*)(\\[\\/URL\\])");
        	strContent = m.replaceAll("<A HREF=\"$2\" TARGET=_blank>$2</A>");
        	m = getMatcher(strContent , "(\\[URL=(.[^\\]]*)\\])(.[^\\[]*)(\\[\\/URL\\])");
        	strContent = m.replaceAll("<A HREF=\"$2\" TARGET=_blank>$3</A>");
        }
        if(strContent.indexOf("[/email]",1)>=0){
        	m = getMatcher(strContent , "(\\[EMAIL\\])(.[^\\[]*)(\\[\\/EMAIL\\])");
        	strContent = m.replaceAll("<img align=absmiddle src=images/email.gif><A HREF=\"mailto:$2\">$2</A>");
        	m = getMatcher(strContent , "(\\[EMAIL=(.[^\\[]*)\\])(.[^\\[]*)(\\[\\/EMAIL\\])");
        	strContent = m.replaceAll("<img align=absmiddle src=images/email.gif><A HREF=\"mailto:$2\">$3</A>");
        }
        int ifhttp=0;
        if(strContent.indexOf("[/data]",1)>=0){
        	m = getMatcher(strContent , "\\[data=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/data]");
        	strContent = m.replaceAll("<OBJECT height=\"$2\" width=\"$1\" data=\"$3\"></OBJECT>");
        	ifhttp=1;
        }
        if(strContent.indexOf("[/iframe]",1)>=0){
        	m = getMatcher(strContent , "\\[iframe=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/iframe]");
        	strContent = m.replaceAll("<iframe height=\"$2\" width=\"$1\" frameborder=0 src=\"$3\"></iframe>");
        	ifhttp=1;
        }
        if(strContent.indexOf("http://",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "^(http://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "(http://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)$");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "([^>=\"])(http://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("$1<img align=absmiddle src=images/url.gif><a target=_blank href=$2>$2</a>");
        }
        if(strContent.indexOf("ftp://",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "^(ftp://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "(ftp://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)$");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "([^>=\"])(ftp://[A-Za-z0-9\\.\\/=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("$1<img align=absmiddle src=images/url.gif><a target=_blank href=$2>$2</a>");
        }
        if(strContent.indexOf("rtsp://",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "^(rtsp://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "(rtsp://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)$");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "([^>=\"])(rtsp://[A-Za-z0-9\\.\\/=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("$1<img align=absmiddle src=images/url.gif><a target=_blank href=$2>$2</a>");
        }
        if(strContent.indexOf("mms://",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "^(mms://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "(mms://[A-Za-z0-9\\./=\\?%\\-&_~`@':+!]+)$");
        	strContent = m.replaceAll("<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>");
        	m = getMatcher(strContent , "([^>=\"])(mms://[A-Za-z0-9\\.\\/=\\?%\\-&_~`@':+!]+)");
        	strContent = m.replaceAll("$1<img align=absmiddle src=images/url.gif><a target=_blank href=$2>$2</a>");
        }
        if(strContent.indexOf("[/color]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[color=(.[^\\[]*)\\])(.[^\\[]*)(\\[\\/color\\])");
        	strContent = m.replaceAll("<font color=$2>$3</font>");
        }
        if(strContent.indexOf("[/face]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[face=(.[^\\[]*)\\])(.[^\\[]*)(\\[\\/face\\])");
        	strContent = m.replaceAll("<font face=$2>$3</font>");
        }
        if(strContent.indexOf("[/align]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[align=(.[^\\[]*)\\])(.[^\\[]*)(\\[\\/align\\])");
        	strContent = m.replaceAll("<div align=$2>$3</div>");
        }
        if(strContent.indexOf("[/fly]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[fly\\])(.[^\\[]*)(\\[\\/fly\\])");
        	strContent = m.replaceAll("<marquee width=90% behavior=alternate scrollamount=3>$2</marquee>");
        }
        if(strContent.indexOf("[br]",1)>=0 && ifhttp==0){
        	strContent = strContent.replace("[br]", "<br/>");
        }
        if (strContent.indexOf("[BR]", 1) >= 0 && ifhttp == 0){
        	strContent = strContent.replace("[BR]", "<br/>");
        }
        if(strContent.indexOf("[/move]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[move\\])(.[^\\[]*)(\\[\\/move\\])");
        	strContent = m.replaceAll("<MARQUEE scrollamount=3>$2</marquee>");
        }
        if(strContent.indexOf("[/glow]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "\\[GLOW=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/GLOW]");
        	strContent = m.replaceAll("<table width=$1 style=\"filter:glow(color=$2, strength=$3)\">$4</table>");
        }
        if(strContent.indexOf("[/shadow]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "\\[SHADOW=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/SHADOW]");
        	strContent = m.replaceAll("<table width=$1 style=\"filter:shadow(color=$2, strength=$3)\">$4</table>");
        }
        if(strContent.indexOf("[/i]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[i\\])(.[^\\[]*)(\\[\\/i\\])");
        	strContent = m.replaceAll("<i>$2</i>");
        }
        if(strContent.indexOf("[/u]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[u\\])(.[^\\[]*)(\\[\\/u\\])");
        	strContent = m.replaceAll("<u>$2</u>");
        }
        if(strContent.indexOf("[/b]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[b\\])(.[^\\[]*)(\\[\\/b\\])");
        	strContent = m.replaceAll("<b>$2</b>");
        }
        if(strContent.indexOf("[/size]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[size=1\\])(.[^\\[]*)(\\[\\/size\\])");
        	strContent = m.replaceAll("<font size=1>$2</font>");
        	m = getMatcher(strContent , "(\\[size=2\\])(.[^\\[]*)(\\[\\/size\\])");
        	strContent = m.replaceAll("<font size=2>$2</font>");
        	m = getMatcher(strContent , "(\\[size=3\\])(.[^\\[]*)(\\[\\/size\\])");
        	strContent = m.replaceAll("<font size=3>$2</font>");
        	m = getMatcher(strContent , "(\\[size=4\\])(.[^\\[]*)(\\[\\/size\\])");
        	strContent = m.replaceAll("<font size=4>$2</font>");
        }
        if(strContent.indexOf("[/quote]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[quote\\])(.[^\\[]*)(\\[\\/quote\\])");
        	strContent = m.replaceAll("<div class=\"msgborder\">$2</div>");
        }
        if(strContent.indexOf("[/center]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "(\\[center\\])(.[^\\[]*)(\\[\\/center\\])");
        	strContent = m.replaceAll("<center>$2</center>");
        }
        if(strContent.indexOf("usemap",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "\\[img\\s([^]]*)\\]");
        	strContent = m.replaceAll("<img $1>");
        }
        if(strContent.indexOf("[/map]",1)>=0 && ifhttp==0){
        	m = getMatcher(strContent , "\\[map\\s([^]]*)\\]");
        	strContent = m.replaceAll("<map $1>");
        	m = getMatcher(strContent , "\\[area([^]]*)\\]");
        	strContent = m.replaceAll("<area $1>");
        	strContent = strContent.replace("[/MAP]", "</map>");
        	strContent = strContent.replace("[/map]", "</map>");
        	strContent = strContent.replace("[/Map]", "</map>");
        }
        return strContent;
	}
	
	/**
	 * 获得***
	 * @param source - 要替换的字符串
	 * @param target - 替换的字符
	 * @return Matcher
	 */
	public static Matcher getMatcher(String source , String target){
		Pattern p = Pattern.compile(target, Pattern.CASE_INSENSITIVE);
		return p.matcher(source);
	}
	
	/**
	 * 正则替换
	 * @param source - 要替换的字符串
	 * @param target - 要替换的字符
	 * @param replacement - 替换成的字符
	 * @param flags - flags Match flags, a bit mask that may include CASE_INSENSITIVE, MULTILINE, DOTALL, UNICODE_CASE, CANON_EQ, UNIX_LINES, LITERAL and COMMENTS
	 * @return String
	 */
	public static String regexReplace(String source , String target , String replacement , int flags){
		Pattern p = Pattern.compile(target, flags);
		Matcher m = p.matcher(source);
		return m.replaceAll(replacement);
	}

}
