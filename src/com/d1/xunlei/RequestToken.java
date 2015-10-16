package com.d1.xunlei;



public class RequestToken extends OAuthToken {
    private HttpClient httpClient;
    private static final long serialVersionUID = -8214365845469757952L;

    RequestToken(Response res, HttpClient httpClient) throws TBlogException{
        super(res);
        this.httpClient = httpClient;
    }

   public RequestToken(String token, String tokenSecret) {
        super(token, tokenSecret);
    }

    public String getAuthenticationURL() {
        return httpClient.getAuthenticationRL() + "?oauth_token=" + getToken();
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;

        RequestToken that = (RequestToken) o;

        if (httpClient != null ? !httpClient.equals(that.httpClient) : that.httpClient != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + (httpClient != null ? httpClient.hashCode() : 0);
        return result;
    }
}

