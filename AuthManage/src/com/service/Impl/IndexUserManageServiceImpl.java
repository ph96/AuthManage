package com.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.IndexUserManageMapper;
import com.service.IndexUserManageService;
import com.vo.AuthInfo;
import com.vo.Role;
import com.vo.UserGroup;
import com.vo.UserInfo;
import com.vo.UserRole;

@Service
public class IndexUserManageServiceImpl implements IndexUserManageService {

	@Autowired
	public IndexUserManageMapper indexUserManageMapper;

	
	//全查用户
	@Override
	public List<UserInfo> fullUser(Map<String,Object> hm) {
		System.out.println("全查用户传参="+hm.get("UserInfo"));
		return indexUserManageMapper.fullUser(hm);
	}
	//更新user_By
	@Override
	public void updateUserBy(Map<String, Object> hm) {
		indexUserManageMapper.updateUserBy(hm);
	}
	//查询所有部门信息
	@Override
	public List<UserGroup> findGroup() {
		return indexUserManageMapper.findGroup();
	}
	//查询所有组
	@Override
	public List<UserRole> fullRoles() {
		return indexUserManageMapper.fullRoles();
	}
	//删除用户
	@Override
	public boolean deleteUser(String userId) {
		int delete = indexUserManageMapper.deleteUser(userId);
		if(delete != 1) {
			return true;
		}
		return false;
	}
	//查询用户有无删除
	@Override
	public boolean hasDelete(String userId) {
		if(null == indexUserManageMapper.hasDelete(userId)) {
			return false;
		}
		return true;
	}
	//重置密码
	@Override
	@Transactional
	public boolean resetPassword(String userId) {
		int s = indexUserManageMapper.resetPassword(userId);
		String id = indexUserManageMapper.hasResetPassword(userId);
		System.out.println("重置密码返回值="+s);
		System.out.println("查询的用户="+id);
		if(s != 1 && null == id ) {//重置失败
			return false;
		}
		//重置成功
		return true;
	}
	//禁用启用 用户
	@Override
	public boolean forbuddenUser(HashMap<String, Object> hm) {
		if(indexUserManageMapper.forbuddenUser(hm) != 1) {
			return true;
		}
		return false;
	}
	//查询用户是否重复 
	@Override
	public boolean redoUser(String userName) {
		
		if(indexUserManageMapper.redoUser(userName).isEmpty()) {//无用户
			return true;
		}
		//有用户
		return false;
	}
	//添加用户
	@Override
	public boolean addUser(UserInfo userInfo) {
		Integer s = indexUserManageMapper.addUser(userInfo);//返回修改的行数
		if(s != 1) {//添加失败
			return true;
		}
		//添加成功
		return false;
	}
	//更新用户信息
	@Override
	public boolean updateUser(UserInfo userInfo) {
		Integer s = indexUserManageMapper.updateUser(userInfo);
		return s != 1?true:false;//失败true,成功false
	}
	//查询当前用户的角色
	@Override
	public List<Role> groupIdUser(String userId) {
		return indexUserManageMapper.groupIdUser(userId);
	}
	//删除当前用户的所有角色
	@Override
	@Transactional
	public boolean deleteAllRole(String userId) {
		String roleId = indexUserManageMapper.roleIdRqUserRole(userId);
		if(null == roleId ) {
			return false;
		}
		Integer s = indexUserManageMapper.deleteAllRole(userId);
		return s<=0?true:false;
	}
	//更新当前用户角色
	@Override
	public boolean updatRoleUser(HashMap<String, Object> hm) {
		Integer s = indexUserManageMapper.updatRoleUser(hm);
		return s!=1?true:false;
	}
	//判断传的字符串与user_role表是否一致
	@Override
	public boolean roleIdRqUserRole(String userId,String roleIds) {
		String roleId = indexUserManageMapper.roleIdRqUserRole(userId);
		if(null == roleId ) {
			return false;
		}
		return roleId.equals(roleIds)?true:false;
	}
	
	//查询所有的权限
	@Override
	public List<AuthInfo> ownershipLimit() {
		return indexUserManageMapper.ownershipLimit();
	}
	//查询用户权限
	@Override
	public List<AuthInfo> findAuthByUser(String userId) {
		return indexUserManageMapper.findAuthByUser(userId);
	}
	//判断传的字符串与user_auth表是否一致，一致不插入
	@Override
	public boolean authRqUserAuth(String userId, String authIds) {
		String authId = indexUserManageMapper.authRqUserAuth(userId);
		if(null == authId ) {//判断是否为空,为空更新
			return false;
		}
		return authIds.equals(authId)?true:false;//相等不更新
	}
	//删除用户权限
	@Override
	@Transactional
	public boolean deleteAllAuth(String userId) {
		String authId = indexUserManageMapper.authRqUserAuth(userId);
		if(null == authId ) {//判断是否为空,为空不删除
			return false;
		}
		int s = indexUserManageMapper.deleteAllAuth(userId);
		return s<=0?true:false;
	}
	//修改用户权限
	@Override
	public boolean updateAuthUser(HashMap<String, Object> hm) {
		int s = indexUserManageMapper.updateAuthUser(hm);
		return s != 1?true:false;
	}
	
	

}
