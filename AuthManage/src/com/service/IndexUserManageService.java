package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vo.AuthInfo;
import com.vo.Role;
import com.vo.UserGroup;
import com.vo.UserInfo;
import com.vo.UserRole;

public interface IndexUserManageService {

	//全查用户
	public List<UserInfo> fullUser(Map<String,Object> hm);
	
	//更新 更新修改用户
	public void updateUserBy(Map<String,Object> hm);
	
	//查询所有部门信息
	public List<UserGroup> findGroup();
	
	//全查角色
	public List<UserRole> fullRoles();
	
	//删除用户
	public boolean deleteUser(String userId);
	//查询用户有无删除
	public boolean hasDelete(String userId);
	
	//重置密码
	public boolean resetPassword(String userId);
	
	//禁用用户
	public boolean forbuddenUser(HashMap<String, Object> hm);
	
	//判断用户名是否重复
	public boolean redoUser(String userName);
	
	//添加用户
	public boolean addUser(UserInfo userInfo);	
	
	//更新用户信息
	public boolean updateUser(UserInfo userInfo);
	
	//查询当前用户的角色
	public List<Role> groupIdUser(String userId);
	
	//删除当前用户的所有角色
	public boolean deleteAllRole(String userId);
	//更新当前用户角色
	public boolean updatRoleUser(HashMap<String, Object> hm);
	//判断传的字符串与user_role表是否一致
	public boolean roleIdRqUserRole(String userId,String roleIds);
	
	//查询所有的权限
	public List<AuthInfo> ownershipLimit();
	//查询用户权限
	public List<AuthInfo> findAuthByUser(String userId);
	//判断传的字符串与user_auth表是否一致，一致不插入
	public boolean authRqUserAuth(String userId,String authIds);
	//删除用户权限
	public boolean deleteAllAuth(String userId);
	//修改用户权限
	public boolean updateAuthUser(HashMap<String, Object> hm);
	
	
	
	
	
	
	
	
	
	
	
	
	
}
