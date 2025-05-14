package com.smarthonking;

public class UserInfo {
	static String rfid, name, email, mobile , id;

	public static String getRfid() {
		return rfid;
	}

	public static void setRfid(String rfid) {
		UserInfo.rfid = rfid;
	}

	public static String getName() {
		return name;
	}

	public static void setName(String name) {
		UserInfo.name = name;
	}

	public static String getEmail() {
		return email;
	}

	public static void setEmail(String email) {
		UserInfo.email = email;
	}

	public static String getMobile() {
		return mobile;
	}

	public static void setMobile(String mobile) {
		UserInfo.mobile = mobile;
	}

	public static String getId() {
		return id;
	}

	public static void setId(String id) {
		UserInfo.id = id;
	}
	
}
