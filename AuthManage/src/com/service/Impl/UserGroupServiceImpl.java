package com.service.Impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.UserGroupMapper;
import com.service.UserGroupService;
import com.vo.Role;
import com.vo.UserGroup;
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	//查询所有用户组
	@Override
	public List<UserGroup> fullUserGroup(HashMap<String,Object> hm) {
		return userGroupMapper.fullUserGroup(hm);
	}

	//查询用户组是否已删除
	@Override
	public boolean hasGroupDelete(String groupId) {
		return null == userGroupMapper.hasGroupDelete(groupId)?true:false;//删除true,未删除false
	}
	//删除用户组
	@Override
	public boolean deleteGroup(String groupId) {
		return userGroupMapper.deleteGroup(groupId) != 1?true:false;
	}

	//更新用户组
	@Override
	public boolean updateGroup(UserGroup userGroup) {
		return userGroupMapper.updateGroup(userGroup) != 1?true:false;
	}

	
	//禁用或启用
	@Override
	public boolean DisableOrEnable(HashMap<String, Object> hm) {
		return userGroupMapper.DisableOrEnable(hm) != 1?true:false;
	}
	
	//查村用户组角色
	@Override
	public List<Role> groupRole(String groupId) {
		return userGroupMapper.groupRole(groupId);
	}
	//判断传的字符串与group_role表是否一致，一致不插入
	@Override
	public boolean roleIdEqGroupRole(String groupId, String roleIds) {
		String groupRoles = userGroupMapper.roleIdEqGroupRole(groupId);
		if(null == groupRoles) {//判断是否为空,为空更新
			return false;
		}
		return roleIds.equals(groupRoles)?true:false;//相等不更新
	}
	//删除当前用户组所有角色
	@Override
	public boolean deleteGroupRole(String groupId) {
		if(null == userGroupMapper.roleIdEqGroupRole(groupId)) {
			return false;
		}
		return userGroupMapper.deleteGroupRole(groupId) <= 0?true:false;
	}

	//更新用户组角色
	@Override
	public boolean updaeGroupRole(HashMap<String, Object> hm) {
		return userGroupMapper.updaeGroupRole(hm)!=1?true:false;
	}

	
	//查询用户组名和用户组Code是否重复
	@Override
	public boolean isGroupRedo(HashMap<String, Object> hm) {
		return null == userGroupMapper.isGroupRedo(hm)?true:false;
	}

	//添加用户组
	@Override
	public boolean addGroup(UserGroup userGroup) {
		return userGroupMapper.addGroup(userGroup) != 1?true:false;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
