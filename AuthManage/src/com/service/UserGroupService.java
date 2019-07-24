package com.service;

import java.util.HashMap;
import java.util.List;

import com.vo.Role;
import com.vo.UserGroup;

public interface UserGroupService {

	
	//查询所有用户组
	public List<UserGroup> fullUserGroup(HashMap<String,Object> hm);
	
	//查询用户组是否已删除
	public boolean hasGroupDelete(String groupId);
	//删除用户组
	public boolean deleteGroup(String groupId);
	
	//更新用户组
	public boolean updateGroup(UserGroup userGroup);
	
	//禁用或启用
	public boolean DisableOrEnable(HashMap<String,Object> hm);
	
	//获取用户组的角色
	public List<Role> groupRole(String groupId);
	//判断传的字符串与group_role表是否一致，一致不插入
	public boolean roleIdEqGroupRole(String groupId,String roleIds);
	//删除当前用户组所有角色
	public boolean deleteGroupRole(String groupId);
	//更新用户组角色
	public boolean updaeGroupRole(HashMap<String, Object> hm);
	
	//查询用户组名和用户组Code是否重复
	public boolean isGroupRedo(HashMap<String, Object> hm);
	//添加用户组
	public boolean addGroup(UserGroup userGroup);
	
	
	
	
	
	
}
