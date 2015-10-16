package com.d1.alipay;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * �������칤����
 * 
 * @author jun.huyj
 * @version $Id: wapParameterUtil.java,v 1.1 2012/06/14 05:34:44 ysw Exp $
 */
public class wapParameterUtil {

    /**
     * ��Map��װ�ɴ�ǩ�����ݡ�
     * ��ǩ�������ݱ��밴��һ����˳������ �����֧�����ṩ�ķ���Ĺ淶���������֧�����ķ����ͨ����ǩ����֤
     * @param params
     * @return ���ش�ǩ��������
     */
    public static String getSignData(Map<String, String> params) {
        StringBuffer content = new StringBuffer();

        // ����key������
        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);

        for (int i = 0; i < keys.size(); i++) {
            String key = (String) keys.get(i);
            if ("sign".equals(key)||"sign_type".equals(key)) {
                continue;
            }
            String value = (String) params.get(key);
            if (value != null) {
                content.append((i == 0 ? "" : "&") + key + "=" + value);
            } else {
                content.append((i == 0 ? "" : "&") + key + "=");
            }

        }

        return content.toString();
    }

    /**
     * ��Map�е�������װ��url
     * @param params
     * @return ����url������ʽ���ݣ���sec_id=MD5&v=2.0
     * @throws UnsupportedEncodingException 
     */
    public static String mapToUrl(Map<String, String> params) throws UnsupportedEncodingException {
        StringBuilder sb = new StringBuilder();
        boolean isFirst = true;
        for (String key : params.keySet()) {
            String value = params.get(key);
            if (isFirst) {
                sb.append(key + "=" + URLEncoder.encode(value, "utf-8"));
                isFirst = false;
            } else {
                if (value != null) {
                    sb.append("&" + key + "=" + URLEncoder.encode(value, "utf-8"));
                } else {
                    sb.append("&" + key + "=");
                }
            }
        }
        return sb.toString();
    }

    /**
     * ȡ��URL�еĲ���ֵ��
     * <p>�粻���ڣ����ؿ�ֵ��</p>
     * 
     * @param url
     * @param name
     * @return ���ز���ֵ
     */
    public static String getParameter(String url, String name) {
        if (name == null || name.equals("")) {
            return null;
        }
        name = name + "=";
        int start = url.indexOf(name);
        if (start < 0) {
            return null;
        }
        start += name.length();
        int end = url.indexOf("&", start);
        if (end == -1) {
            end = url.length();
        }
        return url.substring(start, end);
    }
}

