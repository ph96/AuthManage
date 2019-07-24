package com.dao;

import java.util.List;
import java.util.Map;

import com.vo.AuthInfo;
import com.vo.Role;

public interface RoleMapper {

	
	//查询所有角色
	public List<Role> fullRoles(Map<String,Object> hm);
	
	//查询角色是否删除
	public Role hasDelete(String roleId);
	//删除角色
	public int deleteRole(String roleId);
	
	//更新角色信息
	public int updateRole(Role role);
	//更新人添加
	public int updateRoleBy(Map<String,Object> hm);
	
	//禁用或启用
	public int DisableOrEnable(Map<String,Object> hm);
	
	//查询角色权限
	public List<AuthInfo> findRoleAuth(String roleId);
	//判断传的字符串与role_auth表是否一致，一致不插入
	public String roleAuthEqAuth(String roleId);
	//删除用户权限
	public int deleteRoleAuth(String roleId);
	//更新角色权限
	public int updateRoleAuth(Map<String,Object> hm);
	
	//判断角色名和角色Code是否重复
	public String isRoleRedo(Map<String,Object> hm);
	//添加角色
	public int addRole(Role role);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
