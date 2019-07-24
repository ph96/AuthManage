package com.service.Impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AuthMapper;
import com.vo.AuthInfo;

@Service
public class AuthServiceImpl implements com.service.AuthService {

	@Autowired
	public AuthMapper authMapper;
	
	//查询是否已删除
	@Override
	public boolean IfDelete(String authId) {
		String s = authMapper.IfDelete(authId);
		//System.out.println("**AuthService**IfDelete***s="+s);
		return null == s?true:false;
	}
	//删除权限
	@Override
	public boolean deleteAuth(String authId) {
		int s = authMapper.deleteAuth(authId);
		return s != 1?true:false;//true删除失败
	}
	//恢复权限
	@Override
	public boolean recoverAuth(String authId) {
		int s = authMapper.recoverAuth(authId);
		return s != 1?true:false;//true删除失败
	}
	//判断权限名,Url,Code是否重复
	@Override
	public boolean isAuthName(HashMap<String, Object> hm) {
		String s = authMapper.isAuthName(hm);
		return null == s?true:false;
	}
	//更新权限信息
	@Override
	public boolean updateAuth(AuthInfo authInof) {
		int s = authMapper.updateAuth(authInof);
		return s != 1?true:false;
	}
	//更新修改人
	@Override
	public boolean updateUpdateBy(HashMap<String, Object> hm) {
		int s = authMapper.updateUpdateBy(hm);
		return s != 1?true:false;
	}
	//添加权限
	@Override
	public boolean addAuth(AuthInfo authInfo) {
		return authMapper.addAuth(authInfo) != 1?true:false;
	}

	

	

}
