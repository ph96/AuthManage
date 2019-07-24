package com.vo;
//登陆
public class Login {

	//用户名
	private String userCode;
	//密码
	private String userPwd;
	//验证码
	private String vCode;
	
	public Login() {}

	public Login(String userCode, String userPwd, String vCode) {
		this.userCode = userCode;
		this.userPwd = userPwd;
		this.vCode = vCode;
	}

	public String getUserCode() {
		return userCode;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public String getvCode() {
		return vCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public void setvCode(String vCode) {
		this.vCode = vCode;
	}

	@Override
	public String toString() {
		return "Login [userCode=" + userCode + ", userPwd=" + userPwd + ", vCode=" + vCode + "]";
	}
	
	
}
