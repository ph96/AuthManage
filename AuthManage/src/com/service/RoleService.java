package com.service;

import java.util.List;
import java.util.Map;

import com.vo.AuthInfo;
import com.vo.Role;

public interface RoleService {

	
	//查询所有角色
	public List<Role> fullRoles(Map<String,Object> hm);
	
	//查询角色是否删除
	public boolean hasDelete(String roleId);
	//删除角色
	public boolean deleteRole(String roleId);
	
	//更新角色信息
	public boolean updateRole(Role role);
	//更新人添加
	public boolean updateRoleBy(Map<String,Object> hm);
	
	//禁用或启用
	public boolean DisableOrEnable(Map<String,Object> hm);
	
	//查询角色权限
	public List<AuthInfo> findRoleAuth(String roleId);
	//判断传的字符串与role_auth表是否一致，一致不插入
	public boolean roleAuthEqAuth(String roleId,String authIds);
	//删除用户权限
	public boolean deleteRoleAuth(String roleId);
	//更新角色权限
	public boolean updateRoleAuth(Map<String,Object> hm);
	
	//判断角色名和角色Code是否重复
	public boolean isRoleRedo(Map<String,Object> hm);
	//添加角色
	public boolean addRole(Role role);
	
	
	
	
	
	
	
	
	
	
	
}
