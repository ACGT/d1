package com.d1.xunlei;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import com.d1.PubConfig;
import com.d1.util.Base64;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;


public class OAuth implements java.io.Serializable {
    private static final String HMAC_SHA1 = "HmacSHA1";
    private static final PostParameter OAUTH_SIGNATURE_METHOD = new PostParameter("oauth_signature_method", "HMAC-SHA1");
    static final long serialVersionUID = -4368426677157998618L;
    private String consumerKey = "";
    private String consumerSecret;

    public OAuth(String consumerKey, String consumerSecret) {
        setConsumerKey(consumerKey);
        setConsumerSecret(consumerSecret);
    }

    /*package*/public String generateAuthorizationHeader(String method,String url, PostParameter[] params, String nonce, String timestamp, OAuthToken otoken) {
        if (null == params) {
            params = new PostParameter[0];
        }
        List<PostParameter> oauthHeaderParams = new ArrayList<PostParameter>(5);
       
        oauthHeaderParams.add(new PostParameter("oauth_consumer_key", consumerKey));
        oauthHeaderParams.add(OAUTH_SIGNATURE_METHOD);
        oauthHeaderParams.add(new PostParameter("oauth_timestamp", timestamp));
        oauthHeaderParams.add(new PostParameter("oauth_nonce", nonce));        
        oauthHeaderParams.add(new PostParameter("oauth_version", "1.0"));
        
        if (null != otoken) {
            oauthHeaderParams.add(new PostParameter("oauth_token", otoken.getToken()));
            oauthHeaderParams.add(new PostParameter("oauth_verifier", otoken.getTokenSecret()));
        }else{
        	 oauthHeaderParams.add(new PostParameter("oauth_callback", PubConfig.get("xunlei_oauth_callback")));
        }
        
        List<PostParameter> signatureBaseParams = new ArrayList<PostParameter>(oauthHeaderParams.size() + params.length);
        signatureBaseParams.addAll(oauthHeaderParams);
        signatureBaseParams.addAll(toParamList(params));
        parseGetParameters(url, signatureBaseParams);
        
        StringBuffer base = new StringBuffer(method).append("&")
                .append(encode(constructRequestURL(url))).append("&");
        base.append(encode(normalizeRequestParameters(signatureBaseParams)));
        
        String oauthBaseString = base.toString();

        String signature = generateSignature(oauthBaseString, otoken);


        oauthHeaderParams.add(new PostParameter("oauth_signature", signature));
        return encodeParameters(oauthHeaderParams, ",", true);
    //return oauthBaseString;
    }

    
    
    /*package*/public String generateaccesstokenHeader(String method, String url, String oauth_token,String oauth_verifier, PostParameter[] params, String nonce, String timestamp, OAuthToken otoken) {
        if (null == params) {
            params = new PostParameter[0];
        }
        List<PostParameter> oauthHeaderParams = new ArrayList<PostParameter>(5);
        oauthHeaderParams.add(new PostParameter("oauth_consumer_key", consumerKey));
        oauthHeaderParams.add(new PostParameter("oauth_nonce", nonce)); 
        oauthHeaderParams.add(OAUTH_SIGNATURE_METHOD);
       
        oauthHeaderParams.add(new PostParameter("oauth_timestamp", timestamp));
        oauthHeaderParams.add(new PostParameter("oauth_token", oauth_token));   
        oauthHeaderParams.add(new PostParameter("oauth_verifier", oauth_verifier));
        oauthHeaderParams.add(new PostParameter("oauth_version", "1.0"));
        
       
        
        List<PostParameter> signatureBaseParams = new ArrayList<PostParameter>(oauthHeaderParams.size() + params.length);
        signatureBaseParams.addAll(oauthHeaderParams);
        signatureBaseParams.addAll(toParamList(params));
        parseGetParameters(url, signatureBaseParams);
        
        StringBuffer base = new StringBuffer(method).append("&")
                .append(encode(constructRequestURL(url))).append("&");
        base.append(encode(normalizeRequestParameters(signatureBaseParams)));
        
        String oauthBaseString = base.toString();

        String signature = generateSignature(oauthBaseString, otoken);


        oauthHeaderParams.add(new PostParameter("oauth_signature", signature));
       return encodeParameters(oauthHeaderParams, ",", true);
    //return signature;
    }
    
    
    /*package*/public String generateUserHeader(String method, String url, String oauth_token, PostParameter[] params, String nonce, String timestamp, OAuthToken otoken) {
        if (null == params) {
            params = new PostParameter[0];
        }
        List<PostParameter> oauthHeaderParams = new ArrayList<PostParameter>(5);
        oauthHeaderParams.add(new PostParameter("oauth_consumer_key", consumerKey));
        oauthHeaderParams.add(new PostParameter("oauth_nonce", nonce)); 
        oauthHeaderParams.add(OAUTH_SIGNATURE_METHOD);
       
        oauthHeaderParams.add(new PostParameter("oauth_timestamp", timestamp));
        oauthHeaderParams.add(new PostParameter("oauth_token", oauth_token));   
     
        oauthHeaderParams.add(new PostParameter("oauth_version", "1.0"));
        
       
        
        List<PostParameter> signatureBaseParams = new ArrayList<PostParameter>(oauthHeaderParams.size() + params.length);
        signatureBaseParams.addAll(oauthHeaderParams);
        signatureBaseParams.addAll(toParamList(params));
        parseGetParameters(url, signatureBaseParams);
        
        StringBuffer base = new StringBuffer(method).append("&")
                .append(encode(constructRequestURL(url))).append("&");
        base.append(encode(normalizeRequestParameters(signatureBaseParams)));
        
        String oauthBaseString = base.toString();

        String signature = generateSignature(oauthBaseString, otoken);


        oauthHeaderParams.add(new PostParameter("oauth_signature", signature));
       return encodeParameters(oauthHeaderParams, ",", true);
    //return oauthBaseString;
    }
    
    private void parseGetParameters(String url, List<PostParameter> signatureBaseParams) {
        int queryStart = url.indexOf("?");
        if (-1 != queryStart) {
            String[] queryStrs = url.substring(queryStart + 1).split("&");
            try {
                for (String query : queryStrs) {
                    String[] split = query.split("=");
                    if (split.length == 2) {
                        signatureBaseParams.add(
                                new PostParameter(URLDecoder.decode(split[0],
                                        "UTF-8"), URLDecoder.decode(split[1],
                                        "UTF-8")));
                    } else {
                        signatureBaseParams.add(
                                new PostParameter(URLDecoder.decode(split[0],
                                        "UTF-8"), ""));
                    }
                }
            } catch (UnsupportedEncodingException ignore) {
            }

        }

    }

    private static Random RAND = new Random();

    /**
     * @return
     * @see <a href="http://oauth.net/core/1.0#rfc.section.5.4.1">OAuth Core - 5.4.1.  Authorization Header</a>
     */
    /*package*/ String generateAuthorizationHeader(String method, String url, PostParameter[] params, OAuthToken token) {
        long timestamp = System.currentTimeMillis() / 1000;
        long nonce = timestamp + RAND.nextInt();
        return generateAuthorizationHeader(method, url, params, String.valueOf(nonce), String.valueOf(timestamp), token);
    }


    /**
     * Computes RFC 2104-compliant HMAC signature.
     *
     * @param data the data to be signed
     * @return signature
     * @see <a href="http://oauth.net/core/1.0/#rfc.section.9.2.1">OAuth Core - 9.2.1.  Generating Signature</a>
     */
    /*package*/ String generateSignature(String data, OAuthToken token) {
        byte[] byteHMAC = null;
        try {
            Mac mac = Mac.getInstance(HMAC_SHA1);
            SecretKeySpec spec;
            if (null == token) {
                String oauthSignature = encode(consumerSecret) + "&";
                spec = new SecretKeySpec(oauthSignature.getBytes(), HMAC_SHA1);
            } else {
                if (null == token.getSecretKeySpec()) {
                    String oauthSignature = encode(token.getToken()) + "&" + encode(token.getTokenSecret());
                    spec = new SecretKeySpec(oauthSignature.getBytes(), HMAC_SHA1);
                    token.setSecretKeySpec(spec);
                }
                spec = token.getSecretKeySpec();
            }
            mac.init(spec);
            byteHMAC = mac.doFinal(data.getBytes());
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException ignore) {
            // should never happen
        }
        return Base64.encodeBytes(byteHMAC);
    }

    /*package*/ String generateSignature(String data) {
        return generateSignature(data, null);
    }


    /**
     * The request parameters are collected, sorted and concatenated into a normalized string:<br>
     * 鈥�Parameters in the OAuth HTTP Authorization header excluding the realm parameter.<br>
     * 鈥�Parameters in the HTTP POST request body (with a content-type of application/x-www-form-urlencoded).<br>
     * 鈥�HTTP GET parameters added to the URLs in the query part (as defined by [RFC3986] section 3).<br>
     * <br>
     * The oauth_signature parameter MUST be excluded.<br>
     * The parameters are normalized into a single string as follows:<br>
     * 1.	Parameters are sorted by name, using lexicographical byte value ordering. If two or more parameters share the same name, they are sorted by their value. For example:<br>
     * 2.	                    a=1, c=hi%20there, f=25, f=50, f=a, z=p, z=t<br>
     * 3.	<br>
     * 4.	Parameters are concatenated in their sorted order into a single string. For each parameter, the name is separated from the corresponding value by an 鈥�鈥�character (ASCII code 61), even if the value is empty. Each name-value pair is separated by an 鈥�鈥�character (ASCII code 38). For example:<br>
     * 5.	                    a=1&c=hi%20there&f=25&f=50&f=a&z=p&z=t<br>
     * 6.	<br>
     *
     * @param params parameters to be normalized and concatenated
     * @return nomarized and concatenated parameters
     * @see <a href="http://oauth.net/core/1.0#rfc.section.9.1.1">OAuth Core - 9.1.1.  Normalize Request Parameters</a>
     */
    public static String normalizeRequestParameters(PostParameter[] params) {
        return normalizeRequestParameters(toParamList(params));
    }

    @SuppressWarnings("unchecked")
	public static String normalizeRequestParameters(List<PostParameter> params) {
        Collections.sort(params);
        return encodeParameters(params);
    }

    @SuppressWarnings("unchecked")
	public static String normalizeAuthorizationHeaders(List<PostParameter> params) {
        Collections.sort(params);
        return encodeParameters(params);
    }

    public static List<PostParameter> toParamList(PostParameter[] params) {
        List<PostParameter> paramList = new ArrayList<PostParameter>(params.length);
        paramList.addAll(Arrays.asList(params));
        return paramList;
    }

    /**
     * @param postParams parameters to be enocded and concatenated
     * @return eoncoded string
     * @see <a href="http://wiki.oauth.net/TestCases">OAuth / TestCases</a>
     * @see <a href="http://groups.google.com/group/oauth/browse_thread/thread/a8398d0521f4ae3d/9d79b698ab217df2?hl=en&lnk=gst&q=space+encoding#9d79b698ab217df2">Space encoding - OAuth | Google Groups</a>
     */
    public static String encodeParameters(List<PostParameter> postParams) {
        return encodeParameters(postParams, "&", false);
    }

    public static String encodeParameters(List<PostParameter> postParams, String splitter, boolean quot) {
        StringBuffer buf = new StringBuffer();
        for (PostParameter param : postParams) {
            if (buf.length() != 0) {
                if (quot) {
                    buf.append("\"");
                }
                buf.append(splitter);
            }
            buf.append(encode(param.name)).append("=");
            if (quot) {
                buf.append("\"");
            }
            buf.append(
                    encode(param.value));
        }
        if (buf.length() != 0) {
            if (quot) {
                buf.append("\"");
            }
        }
        return buf.toString();
    }

    /**
     * @param value string to be encoded
     * @return encoded string
     * @see <a href="http://wiki.oauth.net/TestCases">OAuth / TestCases</a>
     * @see <a href="http://groups.google.com/group/oauth/browse_thread/thread/a8398d0521f4ae3d/9d79b698ab217df2?hl=en&lnk=gst&q=space+encoding#9d79b698ab217df2">Space encoding - OAuth | Google Groups</a>
     * @see <a href="http://tools.ietf.org/html/rfc3986#section-2.1">RFC 3986 - Uniform Resource Identifier (URI): Generic Syntax - 2.1. Percent-Encoding</a>
     */
    public static String encode(String value) {
        String encoded = null;
        try {
            encoded = URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException ignore) {
        }
        StringBuffer buf = new StringBuffer(encoded.length());
        char focus;
        for (int i = 0; i < encoded.length(); i++) {
            focus = encoded.charAt(i);
            if (focus == '*') {
                buf.append("%2A");
            } else if (focus == '+') {
                buf.append("%20");
            } else if (focus == '%' && (i + 1) < encoded.length()
                    && encoded.charAt(i + 1) == '7' && encoded.charAt(i + 2) == 'E') {
                buf.append('~');
                i += 2;
            } else {
                buf.append(focus);
            }
        }
        return buf.toString();
    }

    /**
     * The Signature Base String includes the request absolute URL, tying the signature to a specific endpoint. The URL used in the Signature Base String MUST include the scheme, authority, and path, and MUST exclude the query and fragment as defined by [RFC3986] section 3.<br>
     * If the absolute request URL is not available to the Service Provider (it is always available to the Consumer), it can be constructed by combining the scheme being used, the HTTP Host header, and the relative HTTP request URL. If the Host header is not available, the Service Provider SHOULD use the host name communicated to the Consumer in the documentation or other means.<br>
     * The Service Provider SHOULD document the form of URL used in the Signature Base String to avoid ambiguity due to URL normalization. Unless specified, URL scheme and authority MUST be lowercase and include the port number; http default port 80 and https default port 443 MUST be excluded.<br>
     * <br>
     * For example, the request:<br>
     * HTTP://Example.com:80/resource?id=123<br>
     * Is included in the Signature Base String as:<br>
     * http://example.com/resource
     *
     * @param url the url to be normalized
     * @return the Signature Base String
     * @see <a href="http://oauth.net/core/1.0#rfc.section.9.1.2">OAuth Core - 9.1.2.  Construct Request URL</a>
     */

    public static String constructRequestURL(String url) {
        int index = url.indexOf("?");
        if (-1 != index) {
            url = url.substring(0, index);
        }
        int slashIndex = url.indexOf("/", 8);
        String baseURL = url.substring(0, slashIndex).toLowerCase();
        int colonIndex = baseURL.indexOf(":", 8);
        if (-1 != colonIndex) {
            // url contains port number
            if (baseURL.startsWith("http://") && baseURL.endsWith(":80")) {
                // http default port 80 MUST be excluded
                baseURL = baseURL.substring(0, colonIndex);
            } else if (baseURL.startsWith("https://") && baseURL.endsWith(":443")) {
                // http default port 443 MUST be excluded
                baseURL = baseURL.substring(0, colonIndex);
            }
        }
        url = baseURL + url.substring(slashIndex);

        return url;
    }

    public void setConsumerKey(String consumerKey) {
        this.consumerKey = null != consumerKey ? consumerKey : "";
    }

    public void setConsumerSecret(String consumerSecret) {
        this.consumerSecret = null != consumerSecret ? consumerSecret : "";
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OAuth)) return false;

        OAuth oAuth = (OAuth) o;

        if (consumerKey != null ? !consumerKey.equals(oAuth.consumerKey) : oAuth.consumerKey != null)
            return false;
        if (consumerSecret != null ? !consumerSecret.equals(oAuth.consumerSecret) : oAuth.consumerSecret != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = consumerKey != null ? consumerKey.hashCode() : 0;
        result = 31 * result + (consumerSecret != null ? consumerSecret.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "OAuth{" +
                "consumerKey='" + consumerKey + '\'' +
                ", consumerSecret='" + consumerSecret + '\'' +
                '}';
    }
}
