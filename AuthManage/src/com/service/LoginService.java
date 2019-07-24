package com.service;

import java.util.HashMap;
import java.util.List;

import com.vo.AuthInfo;
import com.vo.Login;
import com.vo.UserInfo;

public interface LoginService {

	//查询用户并判断
	public boolean QueryUserJudgment(Login login) ;
	
	//获取用户
	public UserInfo getUser();
	
	//查询用户拥有的权限
	public List<AuthInfo> userRight(HashMap<String,Integer> hm);
}
