package com.service.Impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.LoginMapper;
import com.service.LoginService;
import com.vo.AuthInfo;
import com.vo.Login;
import com.vo.UserInfo;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	public LoginMapper loginMapper ;
	//用户信息
	UserInfo userInfo;
	
	//查询用户并判断
	@Override
	public boolean QueryUserJudgment(Login login) {
		UserInfo userInfo = loginMapper.QueryUserJudgment(login);
		if(null == userInfo ) {//|| userInfo.getUserPwd().equals(login.getUserPwd())
			return true;
		}
		this.userInfo = userInfo;
		return false;
	}

	//获取用户
	@Override
	public UserInfo getUser() {
		return userInfo;
	}

	//
	@Override
	public List<AuthInfo> userRight(HashMap<String,Integer> hm) {
		List<AuthInfo> list = loginMapper.userRight(hm);
		return list;
	}
	
	

}
