package com.d1.xunlei;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.PasswordAuthentication;
import java.net.Proxy;
import java.net.URL;
import java.net.URLEncoder;
import java.net.Authenticator.RequestorType;
import java.net.Proxy.Type;
import java.security.AccessControlException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.activation.MimetypesFileTypeMap;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;



import com.d1.PubConfig;


public class HttpClient implements java.io.Serializable {
	
    private static final long serialVersionUID = 808018030183407996L;
	
    private static final int OK = 200;// OK: Success!
    private static final int NOT_MODIFIED = 304;// Not Modified: There was no new data to return.
    private static final int BAD_REQUEST = 400;// Bad Request: The request was invalid.  An accompanying error message will explain why. This is the status code will be returned during rate limiting.
    private static final int NOT_AUTHORIZED = 401;// Not Authorized: Authentication credentials were missing or incorrect.
    private static final int FORBIDDEN = 403;// Forbidden: The request is understood, but it has been refused.  An accompanying error message will explain why.
    private static final int NOT_FOUND = 404;// Not Found: The URI requested is invalid or the resource requested, such as a user, does not exists.
    private static final int NOT_ACCEPTABLE = 406;// Not Acceptable: Returned by the Search API when an invalid format is specified in the request.
    private static final int INTERNAL_SERVER_ERROR = 500;// Internal Server Error: Something is broken.  Please post to the group so the team can investigate.
    private static final int BAD_GATEWAY = 502;// Bad Gateway: server is down or being upgraded.
    private static final int SERVICE_UNAVAILABLE = 503;// Service Unavailable: The servers are up, but overloaded with requests. Try again later. The search and trend methods use this to indicate when you are being rate limited.

    private String basic;
    private int retryCount = 3;
    private int retryIntervalMillis =10 * 1000;
    private String proxyHost ="";
    private int proxyPort = 1;
    private String proxyAuthUser ="";
    private String proxyAuthPassword = "";
    private int connectionTimeout = 20000;
    private int readTimeout = 120000;

    private String requestTokenURL = PubConfig.get("xunlei_request_token");
    private String authenticationURL = PubConfig.get("xunlei_authorize");
    private String accessTokenURL = PubConfig.get("xunlei_access_token");
    

    private static boolean isJDK14orEarlier = false;
    private Map<String, String> requestHeaders = new HashMap<String, String>();
    
    private OAuth oauth = null;
    
  
    private OAuthToken oauthToken = null;
    
//    private String token = null;
    
    static {
        try {
            String versionStr = System.getProperty("java.specification.version");
            if (null != versionStr) {
                isJDK14orEarlier = 1.5d > Double.parseDouble(versionStr);
            }
        } catch (AccessControlException ace) {
            isJDK14orEarlier = true;
        }
    }

   

   
    
    public boolean isAuthenticationEnabled(){
        return null != basic || null != oauth;
    }
    public RequestToken getOAuthRequestToken() throws TBlogException {
        this.oauthToken = new RequestToken(httpRequest(requestTokenURL, null, true), this);
        return (RequestToken)this.oauthToken;
    }

    /**
     * Sets the consumer key and consumer secret.<br>
     * @param consumerKey Consumer Key
     * @param consumerSecret Consumer Secret
     */
    public void setOAuthConsumer(String consumerKey, String consumerSecret) {
       
        if (null != consumerKey && null != consumerSecret
                && 0 != consumerKey.length() && 0 != consumerSecret.length()) {
            this.oauth = new OAuth(consumerKey, consumerSecret);
        }
    }
    
    public RequestToken setToken(String token, String tokenSecret) {
    	this.oauthToken = new RequestToken(token, tokenSecret);
        return (RequestToken)this.oauthToken;
    }

  public String getUserAgent(){
        return getRequestHeader("User-Agent");
    }

  public AccessToken getOAuthAccessToken(RequestToken token) throws TBlogException {
      try {
          this.oauthToken = token;
          this.oauthToken = new AccessToken(httpRequest(accessTokenURL, new PostParameter[0], true));
      } catch (TBlogException te) {
          throw new TBlogException("The user has not given access to the account.", te, te.getStatusCode());
      }
      return (AccessToken) this.oauthToken;
  }
  
  /**
   * 
   * @param passport
   * @param password
   * @return
   * @throws TBlogException
   */
  public AccessToken getXAuthAccessToken(String passport, String password, boolean isMD5) throws TBlogException {
  	
  	String passtype = "1";
  	if(isMD5){
  		passtype = "0";
  	}
  	
  	PostParameter[] params = new PostParameter[]{
  		new PostParameter("x_auth_username", passport),
  		new PostParameter("x_auth_password", password),
  		new PostParameter("x_auth_mode", "client_auth"),
  		new PostParameter("x_auth_passtype", passtype),
  	};
      this.oauthToken = new AccessToken(httpRequest(accessTokenURL, params, true));
      return (AccessToken) this.oauthToken;
  }

  /**
   *
   * @param token request token
   * @return access token
   * @throws TBlogException
   */
  public AccessToken getOAuthAccessToken(RequestToken token, String pin) throws TBlogException {
      try {
          this.oauthToken = token;
          this.oauthToken = new AccessToken(httpRequest(accessTokenURL
                  , new PostParameter[]{new PostParameter("oauth_verifier", pin)}, true));
      } catch (TBlogException te) {
          throw new TBlogException("The user has not given access to the account.", te, te.getStatusCode());
      }
      return (AccessToken) this.oauthToken;
  }

  /**
   *
   * @param token request token
   * @param tokenSecret request token secret
   * @return access token
   * @throws TBlogException
   */
  public AccessToken getOAuthAccessToken(String token, String tokenSecret) throws TBlogException {
      try {
          this.oauthToken = new OAuthToken(token, tokenSecret) {};
          this.oauthToken = new AccessToken(httpRequest(accessTokenURL, new PostParameter[0], true));
      } catch (TBlogException te) {
          throw new TBlogException("The user has not given access to the account.", te, te.getStatusCode());
      }
      return (AccessToken) this.oauthToken;
  }

  /**
   *
   * @param token request token
   * @param tokenSecret request token secret
   * @param oauth_verifier oauth_verifier or pin
   * @return access token
   * @throws TBlogException
   */
  public AccessToken getOAuthAccessToken(String token, String tokenSecret
          , String oauth_verifier) throws TBlogException {
      try {
          this.oauthToken = new OAuthToken(token, tokenSecret) {};
          this.oauthToken = new AccessToken(httpRequest(accessTokenURL,
                  new PostParameter[]{new PostParameter("oauth_verifier", oauth_verifier)}, true));
      } catch (TBlogException te) {
          throw new TBlogException("The user has not given access to the account.", te, te.getStatusCode());
      }
      return (AccessToken) this.oauthToken;
  }

  /**
   * Sets the authorized access token
   * @param token authorized access token
   */
  public void setOAuthAccessToken(AccessToken token){
      this.oauthToken = token;
  }
    public Response post(String url, PostParameter[] postParameters,
                         boolean authenticated) throws TBlogException {
    	PostParameter[] newPostParameters=Arrays.copyOf(postParameters, postParameters.length);
        return httpRequest(url, newPostParameters, authenticated);
    }

   
 	
 	public Response multPartURL(String fileParamName,String url,  PostParameter[] params,File file,boolean authenticated) throws TBlogException{
  		PostMethod post = new PostMethod(url);
  		org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
    	try {
    		long t = System.currentTimeMillis();
    		Part[] parts=null;
    		if(params==null){
    			parts=new Part[1];
    		}else{
    			parts=new Part[params.length+1];
    		}
    		if (params != null ) {
    			int i=0;
      			for (PostParameter entry : params) {
      				parts[i++]=new StringPart( entry.getName(),(String)entry.getValue());
    			}
      		}
    		FilePart filePart=new FilePart(fileParamName,file.getName(), file,new MimetypesFileTypeMap().getContentType(file),"UTF-8");
    		filePart.setTransferEncoding("binary");
    		parts[parts.length-1]= filePart;

    		post.setRequestEntity( new MultipartRequestEntity(parts, post.getParams()) );
    		 List<Header> headers = new ArrayList<Header>();   
    		 
    		 if (authenticated) {
    	            if (basic == null && oauth == null) {
    	            }
    	            String authorization = null;
    	            if (null != oauth) {
    	                // use OAuth
    	                authorization = oauth.generateAuthorizationHeader( "POST" , url, params, oauthToken);
    	            } else if (null != basic) {
    	                // use Basic Auth
    	                authorization = this.basic;
    	            } else {
    	                throw new IllegalStateException(
    	                        "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
    	            }
    	            headers.add(new Header("Authorization", authorization)); 
    	         
    	        }
    	    client.getHostConfiguration().getParams().setParameter("http.default-headers", headers);
    		client.executeMethod(post);
 
    		Response response=new Response();
    		response.setResponseAsString(post.getResponseBodyAsString());
    		response.setStatusCode(post.getStatusCode());
    		
    		
        	return response;
    	} catch (Exception ex) {
    		 throw new TBlogException(ex.getMessage(), ex, -1);
    	} finally {
    		post.releaseConnection();
    		client=null;
    	}
  	}

    public Response post(String url, boolean authenticated) throws TBlogException {
        return httpRequest(url, new PostParameter[0], authenticated);
    }

    public Response post(String url, PostParameter[] PostParameters) throws
            TBlogException {
        return httpRequest(url, PostParameters, false);
    }

    public Response post(String url) throws
            TBlogException {
        return httpRequest(url, new PostParameter[0], false);
    }

    public Response get(String url, boolean authenticated) throws TBlogException {
        return httpRequest(url, null, authenticated);
    }

    public Response get(String url) throws TBlogException {
        return httpRequest(url, null, false);
    }
   
    public void setRequestTokenURL(String requestTokenURL) {
        this.requestTokenURL = requestTokenURL;
    }

    public String getRequestTokenURL() {
        return requestTokenURL;
    }

    public String getAuthenticationRL() {
        return authenticationURL;
    }

    public void setAccessTokenURL(String accessTokenURL) {
        this.accessTokenURL = accessTokenURL;
    }

    public String getAccessTokenURL() {
        return accessTokenURL;
    }
    protected Response httpRequest(String url, PostParameter[] postParams,
            boolean authenticated) throws TBlogException {
		int len = 1;
		PostParameter[] newPostParameters = postParams;
    	String method = "GET";
    	if (postParams != null) {
    		method = "POST";
			len = postParams.length;
			newPostParameters = Arrays.copyOf(postParams, len);
    	}
    	return httpRequest(url, newPostParameters, authenticated, method);
    }
    public Response httpRequest(String url, PostParameter[] postParams,
            boolean authenticated, String httpMethod) throws TBlogException {
		int retriedCount;
		int retry = retryCount + 1;
		Response res = null;
		for (retriedCount = 0; retriedCount < retry; retriedCount++) {
		int responseCode = -1;
		try {
		HttpURLConnection con = null;
		OutputStream osw = null;
		try {
		con = getConnection(url);
		con.setDoInput(true);
		setHeaders(url, postParams, con, authenticated, httpMethod);
		if (null != postParams || "POST".equals(httpMethod)) {
		   con.setRequestMethod("POST");
		   con.setRequestProperty("Content-Type",
		           "application/x-www-form-urlencoded");
		   con.setDoOutput(true);
		   String postParam = "";
		   if (postParams != null) {
		   	postParam = encodeParameters(postParams);
		   }
		 
		   byte[] bytes = postParam.getBytes("UTF-8");
		
		   con.setRequestProperty("Content-Length",
		           Integer.toString(bytes.length));
		   osw = con.getOutputStream();
		   osw.write(bytes);
		   osw.flush();
		   osw.close();
		} else if ("DELETE".equals(httpMethod)){
		   con.setRequestMethod("DELETE");
		} else {
		   con.setRequestMethod("GET");
		}
		res = new Response(con);
		responseCode = con.getResponseCode();
		
		if (responseCode != OK) {
		   if (responseCode < INTERNAL_SERVER_ERROR || retriedCount == retryCount) {
		       throw new TBlogException(getCause(responseCode) + "\n" + res.asString(), responseCode);
		   }
		   // will retry if the status code is INTERNAL_SERVER_ERROR 
		} else {
		   break;
		}
		} finally {
		try {
		   osw.close();
		} catch (Exception ignore) {
		}
		}
		} catch (IOException ioe) {
		// connection timeout or read timeout
		if (retriedCount == retryCount) {
		throw new TBlogException(ioe.getMessage(), ioe, responseCode);
		}
		}
		try {
		if( null != res){
		res.asString();
		}
		
		Thread.sleep(retryIntervalMillis);
		} catch (InterruptedException ignore) {
		//nothing to do
		}
		}
		return res;
}
    private HttpURLConnection getConnection(String url) throws IOException {
        HttpURLConnection con = null;
        if (proxyHost != null && !proxyHost.equals("")) {
            if (proxyAuthUser != null && !proxyAuthUser.equals("")) {
                Authenticator.setDefault(new Authenticator() {
                    @Override
                    protected PasswordAuthentication
                    getPasswordAuthentication() {
                        //respond only to proxy auth requests
                        if (getRequestorType().equals(RequestorType.PROXY)) {
                            return new PasswordAuthentication(proxyAuthUser,
                                    proxyAuthPassword
                                            .toCharArray());
                        } else {
                            return null;
                        }
                    }
                });
            }
            final Proxy proxy = new Proxy(Type.HTTP, InetSocketAddress
                    .createUnresolved(proxyHost, proxyPort));
           
            con = (HttpURLConnection) new URL(url).openConnection(proxy);
        } else {
            con = (HttpURLConnection) new URL(url).openConnection();
        }
        if (connectionTimeout > 0 && !isJDK14orEarlier) {
            con.setConnectTimeout(connectionTimeout);
        }
        if (readTimeout > 0 && !isJDK14orEarlier) {
            con.setReadTimeout(readTimeout);
        }
        return con;
    }

    public static String encodeParameters(PostParameter[] postParams) {
        StringBuffer buf = new StringBuffer();
        for (int j = 0; j < postParams.length; j++) {
            if (j != 0) {
                buf.append("&");
            }
            try {
                buf.append(URLEncoder.encode(postParams[j].name, "UTF-8"))
                        .append("=").append(URLEncoder.encode(postParams[j].value, "UTF-8"));
            } catch (java.io.UnsupportedEncodingException neverHappen) {
            }
        }
        return buf.toString();
    }

    /**
     * sets HTTP headers
     *
     * @param connection HttpURLConnection
     * @param authenticated boolean
     */
    private void setHeaders(String url, PostParameter[] params, HttpURLConnection connection, boolean authenticated, String httpMethod) {
       
        if (authenticated) {
            if (basic == null && oauth == null) {
            }
            String authorization = null;
            if (null != oauth) {
                // use OAuth
                authorization = oauth.generateAuthorizationHeader(httpMethod, url, params, oauthToken);
            } else if (null != basic) {
                // use Basic Auth
                authorization = this.basic;
            } else {
                throw new IllegalStateException(
                        "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
            }
            connection.addRequestProperty("Authorization", authorization);
          
        }
        for (String key : requestHeaders.keySet()) {
            connection.addRequestProperty(key, requestHeaders.get(key));
          
        }
    }

    public void setRequestHeader(String name, String value) {
        requestHeaders.put(name, value);
    }

    public String getRequestHeader(String name) {
        return requestHeaders.get(name);
    }

   
         
  

    private static String getCause(int statusCode){
        String cause = null;
        switch(statusCode){
            case NOT_MODIFIED:
                break;
            case BAD_REQUEST:
                cause = "The request was invalid.  An accompanying error message will explain why. This is the status code will be returned during rate limiting.";
                break;
            case NOT_AUTHORIZED:
                cause = "Authentication credentials were missing or incorrect.";
                break;
            case FORBIDDEN:
                cause = "The request is understood, but it has been refused.  An accompanying error message will explain why.";
                break;
            case NOT_FOUND:
                cause = "The URI requested is invalid or the resource requested, such as a user, does not exists.";
                break;
            case NOT_ACCEPTABLE:
                cause = "Returned by the Search API when an invalid format is specified in the request.";
                break;
            case INTERNAL_SERVER_ERROR:
                cause = "Something is broken.  Please post to the group so the team can investigate.";
                break;
            case BAD_GATEWAY:
                cause = "server is down or being upgraded.";
                break;
            case SERVICE_UNAVAILABLE:
                cause = "Service Unavailable: The servers are up, but overloaded with requests. Try again later. The search and trend methods use this to indicate when you are being rate limited.";
                break;
            default:
                cause = "";
        }
        return statusCode + ":" + cause;
    }
    
    public String test(String url,  PostParameter[] params,boolean authenticated) throws TBlogException{
    	String authorization = null;
    	PostMethod post = new PostMethod(url);
  		
    	try {

    		Part[] parts=null;
    		if(params==null){
    			parts=new Part[1];
    		}else{
    			parts=new Part[params.length+1];
    		}
    		if (params != null ) {
    			int i=0;
      			for (PostParameter entry : params) {
      				parts[i++]=new StringPart( entry.getName(),(String)entry.getValue());
    			}
      		}
    		

    		post.setRequestEntity( new MultipartRequestEntity(parts, post.getParams()) );
    		
    		 if (authenticated) {
    	            if (basic == null && oauth == null) {
    	            }
    	            
    	            if (null != oauth) {
    	                // use OAuth
    	                authorization = oauth.generateAuthorizationHeader( "GET" , url, params, oauthToken);
    	            } else if (null != basic) {
    	                // use Basic Auth
    	                authorization = this.basic;
    	            } else {
    	                throw new IllegalStateException(
    	                        "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
    	            }
    	           
    	        }
    	   return authorization;
    		
    	} catch (Exception ex) {
    		 throw new TBlogException(ex.getMessage(), ex, -1);
    	} finally {
    		post.releaseConnection();
    		
    	}
  	}
}
