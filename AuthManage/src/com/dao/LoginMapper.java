package com.dao;

import java.util.HashMap;
import java.util.List;

import com.vo.AuthInfo;
import com.vo.Login;
import com.vo.UserInfo;

public interface LoginMapper {

	//查询用户
	public UserInfo QueryUserJudgment(Login login) ;
	
	//查询用户拥有的权限
	public List<AuthInfo> userRight(HashMap<String,Integer> hm);
}
