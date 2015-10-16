package com.d1.dangdang;


public class ApiConfigs {
	public static String APP_KEY = null;
	public static String APP_SECRET = null;
	public static String API_URL = "http://api.open.dangdang.com/openapi/rest?v=1.0";
	public static String SESSION = null;
	public static Integer CONNECTTIMEOUT = 100000;
	public static Integer READTIMEOUT = 600000;

	private String app_key = null;
	private String app_secret = null;
	private String api_url = null;

	public String getApp_key() {
		return app_key;
	}

	public void setApp_key(String app_key) {
		this.app_key = app_key;
	}

	public String getApp_secret() {
		return app_secret;
	}

	public void setApp_secret(String app_secret) {
		this.app_secret = app_secret;
	}

	public String getApi_url() {
		return api_url;
	}

	public void setApi_url(String api_url) {
		this.api_url = api_url;
	}

}