package com.d1.xunlei;


public class AccessToken extends OAuthToken {
    private static final long serialVersionUID = -8344528374458826291L;
    private String screenName;
    private int userId;
    
    AccessToken(Response res) throws TBlogException {
        this(res.asString());
    }

    // for test unit
    AccessToken(String str) {
        super(str);
        screenName = getParameter("screen_name");
	String sUserId = getParameter("user_id");
	if (sUserId != null) userId = Integer.parseInt(sUserId);

    }

    public AccessToken(String token, String tokenSecret) {
        super(token, tokenSecret);
    }

	public String getScreenName() {
		return screenName;
	}
	
	public int getUserId() {
		return userId;
	}
}

