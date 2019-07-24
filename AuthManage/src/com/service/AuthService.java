package com.service;

import java.util.HashMap;

import com.vo.AuthInfo;

public interface AuthService {
	
	
	//查询权限是否已删除
	public boolean IfDelete(String authId);
	//删除权限
	public boolean deleteAuth(String authId);
	
	//恢复权限
	public boolean recoverAuth(String authId);
	
	//判断权限名,Url,Code是否重复
	public boolean isAuthName(HashMap<String, Object> hm);
	//更新权限信息
	public boolean updateAuth(AuthInfo authInof);
	//更新修改人
	public boolean updateUpdateBy(HashMap<String, Object> hm);
	
	//添加权限
	public boolean addAuth(AuthInfo authInfo);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
