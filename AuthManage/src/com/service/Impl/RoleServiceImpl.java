package com.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoleMapper;
import com.service.RoleService;
import com.vo.AuthInfo;
import com.vo.Role;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleMapper;
	
	//全查角色
	@Override
	public List<Role> fullRoles(Map<String, Object> hm) {
		System.out.println("全查角色传参="+hm.get("Role"));
		return roleMapper.fullRoles(hm);
	}

	//查询角色是否删除
	@Override
	public boolean hasDelete(String roleId) {
		return null == roleMapper.hasDelete(roleId)?true:false;//删除true,未删除false
	}
	//删除角色
	@Override
	public boolean deleteRole(String roleId) {
		return roleMapper.deleteRole(roleId) != 1?true:false;
	}
	//更新角色信息
	@Override
	public boolean updateRole(Role role) {
		return roleMapper.updateRole(role) != 1?true:false;
	}
	//更新人修改update_by
	@Override
	public boolean updateRoleBy(Map<String, Object> hm) {
		return roleMapper.updateRoleBy(hm) != 1?true:false;
	}
	//禁用或启用
	@Override
	public boolean DisableOrEnable(Map<String, Object> hm) {
		return roleMapper.DisableOrEnable(hm) != 1?true:false;
	}

	//查询角色权限
	@Override
	public List<AuthInfo> findRoleAuth(String roleId) {
		return roleMapper.findRoleAuth(roleId);
	}

	//判断传的字符串与role_auth表是否一致，一致不插入
	@Override
	public boolean roleAuthEqAuth(String roleId, String authIds) {
		String authId = roleMapper.roleAuthEqAuth(roleId);
		if(null == authId) {//判断是否为空,为空更新
			return false;
		}
		return authIds.equals(authId)?true:false;//相等不更新
	}
	// 删除角色权限

	@Override
	public boolean deleteRoleAuth(String roleId) {
		String authId = roleMapper.roleAuthEqAuth(roleId);
		if(null == authId ) {//判断是否为空,为空不删除
			return false;
		}
		int s = roleMapper.deleteRoleAuth(roleId);
		return s<=0?true:false;
	}
	//添加权限
	@Override
	public boolean updateRoleAuth(Map<String, Object> hm) {
		int s = roleMapper.updateRoleAuth(hm);
		return s != 1?true:false;
	}

	
	//判断角色名和角色Code是否重复
	@Override
	public boolean isRoleRedo(Map<String, Object> hm) {
		return null == roleMapper.isRoleRedo(hm)?true:false;
	}

	//添加角色
	@Override
	public boolean addRole(Role role) {
		return roleMapper.addRole(role) != 1?true:false;
	}

}
