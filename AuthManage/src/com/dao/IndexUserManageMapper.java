package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vo.AuthInfo;
import com.vo.Role;
import com.vo.UserGroup;
import com.vo.UserInfo;
import com.vo.UserRole;

public interface IndexUserManageMapper {

	//更新user_By
	public void updateUserBy(Map<String,Object> hm);
	
	//全查用户
	public List<UserInfo> fullUser(Map<String,Object> hm);
	
	//查询所有部门信息
	public List<UserGroup> findGroup();
	
	//全查角色
	public List<UserRole> fullRoles();
	
	//删除用户
	public int deleteUser(String userId);
	//查询用户有无删除
	public UserInfo hasDelete(String userId);
	
	//重置密码
	public int resetPassword(String userId);
	//判断重置后的密码是否是重置密码
	public String hasResetPassword(String userId);
	
	//禁用用户
	public int forbuddenUser(HashMap<String, Object> hm);
	
	//判断用户名是否重复
	public List<UserInfo> redoUser(String userName);
	
	//添加用户
	public int addUser(UserInfo userInfo);
	
	//更新用户信息
	public int updateUser(UserInfo userInfo);
	
	//查询当前用户的角色
	public List<Role> groupIdUser(String userId);
	
	//删除当前用户的所有角色
	public int  deleteAllRole(String userId);
	//更新当前用户角色
	public int updatRoleUser(HashMap<String, Object> hm);
	//判断传的字符串与user_role表是否一致
	public String roleIdRqUserRole(String userId);
	
	//查询所有的权限
	public List<AuthInfo> ownershipLimit();
	//查询用户权限
	public List<AuthInfo> findAuthByUser(String userId);
	//判断传的字符串与user_auth表是否一致，一致不插入
	public String authRqUserAuth(String userId);
	//删除用户权限
	public int deleteAllAuth(String userId);
	//修改用户权限
	public int updateAuthUser(HashMap<String, Object> hm);
	
	
	
	
	
	
	
	
	
	
	
	
	
}
