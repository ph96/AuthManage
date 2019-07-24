package com.dao;

import java.util.HashMap;

import com.vo.AuthInfo;

public interface AuthMapper {

	//查询用户是否已删除
	public String IfDelete(String authId);
	//删除权限
	public int deleteAuth(String authId);
	
	//恢复权限
	public int recoverAuth(String authId);
	
	//判断权限名,Url,Code是否重复
	public String isAuthName(HashMap<String, Object> hm);
	//更新权限信息
	public int updateAuth(AuthInfo authInof);
	//更新修改人
	public int updateUpdateBy(HashMap<String, Object> hm);
	
	//添加权限
	public int addAuth(AuthInfo authInfo);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
