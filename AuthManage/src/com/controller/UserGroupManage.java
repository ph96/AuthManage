package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.IndexUserManageService;
import com.service.UserGroupService;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.UserGroup;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/UserGroupManage1")
public class UserGroupManage {

	@Autowired
	private UserGroupService userGroupService;
	@Autowired
	private IndexUserManageService indexUserManageService;
	Map<String,Object> hm = new HashMap<>();
	{
		PageSize=6;
	}
	Integer PageSize ;
	
	//查询所有用户组
	@RequestMapping("/fullUserGroup.action")
	public void fullUserGroup(Integer bsh,UserGroup userGroup,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("查询数据="+userGroup);
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("UserGroup", userGroup);
		if(null == pageUtil.getPageNum()) {
			pageUtil.setPageNum(1);
		}
		if(null != pageUtil.getPageSize()) {
			this.PageSize = pageUtil.getPageSize();
			
		}else {
			pageUtil.setPageSize(this.PageSize);
		}
		if(null == pageUtil.getLimitIndex()) {
			pageUtil.setLimitIndex(0);
		}
		hm.put("PageUtil", pageUtil);
		HashMap<String,Object> hm1 = new HashMap<>();
		hm1.put("UserGroup", userGroup);
		
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), userGroupService.fullUserGroup(hm1).size(), pageUtil.getPageNum(), userGroupService.fullUserGroup(hm), "/UserGroupManage1/fullUserGroup.action", null);
		pageUtil2.setLimitIndex(pageUtil.getLimitIndex());
		
		if(null == bsh) {
			//储存不让报错的的信息
			//request.setAttribute("identify", 99);
		}else if(bsh == 0) {
			//储存删除失败
			request.setAttribute("identify", 0);
		}else if(bsh == 1) {
			//储存删除成功
			request.setAttribute("identify", 1);
		}else if(bsh == 2) {
			//禁用或启用失败
			request.setAttribute("identify", 2);
		}else if(bsh == 3) {
			//添加成功
			request.setAttribute("identify", 3);
		}else if(bsh == 4) {
			//添加失败
			request.setAttribute("identify", 4);
		}else if(bsh == 5) {
			//更新失败
			request.setAttribute("identify", 5);
		}else if(bsh == 6) {
			//更新成功
			request.setAttribute("identify", 6);
		}
		//查询所有角色
		request.setAttribute("Role", indexUserManageService.fullRoles());
		//存入模糊搜索参数
		request.setAttribute("FuzzyQueryUserGroup", userGroup);
		//存入角色信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入分页标识
		request.setAttribute("userGroupFuzzyQuery", 0);
		request.getRequestDispatcher("/pages/user-group-list.jsp").forward(request, response);
	}
	//模糊查询
	@RequestMapping("/groupFuzzyQuery.action")
	public void groupFuzzyQuery(UserGroup userGroup,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("进入模糊查询后台UserInfo="+userInfo);
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("UserGroup", userGroup);
		if(null == pageUtil.getPageNum()) {
			pageUtil.setPageNum(1);
		}
		if(null != pageUtil.getPageSize()) {
			this.PageSize = pageUtil.getPageSize();
			
		}else {
			pageUtil.setPageSize(this.PageSize);
		}
		if(null == pageUtil.getLimitIndex()) {
			pageUtil.setLimitIndex(0);
		}
		hm.put("PageUtil", pageUtil);
		HashMap<String,Object> hm1 = new HashMap<>();
		hm1.put("UserGroup", userGroup);
		StringBuffer sb = new StringBuffer("&groupState="+userGroup.getGroupState()+"&groupName="+userGroup.getGroupName());
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), userGroupService.fullUserGroup(hm1).size(), pageUtil.getPageNum(), userGroupService.fullUserGroup(hm), "/UserGroupManage1/groupFuzzyQuery.action", sb);
		//System.err.println("#####"+pageUtil2);
		//查询所有用户
		/*for(UserInfo us:indexService.fullUser(hm)) {
			System.err.println(us);
		}*/
		//查询所有角色
		request.setAttribute("Role", indexUserManageService.fullRoles());
		//存入模糊搜索参数
		request.setAttribute("FuzzyQueryUserGroup", userGroup);
		//存入角色信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入分页标识
		request.setAttribute("userGroupFuzzyQuery", 1);
		request.getRequestDispatcher("/pages/user-group-list.jsp").forward(request, response);
	}
	
	//删除用户组
	@RequestMapping("/deleteGroup.action")
	public void deleteGroup(String groupId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("要删除的id为="+groupId);
		UserGroup userGroup  = new UserGroup();
		PageUtil pageUtil = new PageUtil();
		if(userGroupService.hasGroupDelete(groupId)) {//查询是否已删除
			//已删除
			fullUserGroup(null, userGroup, pageUtil, request, response);
			return;
		}
		if(userGroupService.deleteGroup(groupId)) {//删除失败
			fullUserGroup(0, userGroup, pageUtil, request, response);
			return;
		}else {//删除成功
			fullUserGroup(1, userGroup, pageUtil, request, response);
		}
	}
	
	//更新用户组
	@RequestMapping("/updateGroup.action")
	public void updateGroup(UserGroup userGroup,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("更新用户的信息="+userGroup);
		UserGroup userGroup1  = new UserGroup();
		PageUtil pageUtil = new PageUtil();
		if(userGroupService.updateGroup(userGroup)) {//失败
			fullUserGroup(5, userGroup1, pageUtil, request, response);//刷新
			return;
		}
		//成功
		fullUserGroup(6, userGroup1, pageUtil, request, response);//刷新
	}
	
	//禁用或启用
	@RequestMapping("/DisableOrEnable.action")
	public void DisableOrEnable(Integer groupState,Integer groupId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("groupId", groupId);
		hm.put("groupState",groupState);
		UserGroup userGroup  = new UserGroup();
		PageUtil pageUtil = new PageUtil();
		if(userGroupService.DisableOrEnable(hm)) {//禁用失败
			fullUserGroup(2, userGroup, pageUtil, request, response);
			return;
		}
		//禁用成功
		fullUserGroup(null, userGroup, pageUtil, request, response);
		return;
	}
	
	//查询用户组角色
	@RequestMapping("/groupRole.action")
	@ResponseBody
	public JSONArray groupRole(String groupId) {
		List<Role> roles = userGroupService.groupRole(groupId);//当前用户组的角色
		JSONArray ja = new JSONArray();
		for(Role r:roles) {
			JSONObject jo = new JSONObject();
			jo.put("roleId", r.getRoleId());
			ja.add(jo);
		}
		return ja;
	}
	//更新用户组角色
	@RequestMapping("/updateGroupRole.action")
	public void updateGroupRole(String groupId,String groupName,String roleIds,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		/*System.out.println("用户组id="+groupId);
		System.out.println("用户组name="+groupName);
		System.out.println("用户组要添加的角色id="+roleIds);*/
		if(roleIds.endsWith(",")) {
			roleIds = roleIds.substring(0, roleIds.length()-1);
		}
		UserGroup userGroup  = new UserGroup();
		PageUtil pageUtil = new PageUtil();
		//判断传的字符串与group_role表是否一致，一致不插入
		if(userGroupService.roleIdEqGroupRole(groupId, roleIds)) {
			fullUserGroup(null, userGroup, pageUtil, request, response);
			return;
		}
		if(userGroupService.deleteGroupRole(groupId)) {//删除失败
			fullUserGroup(5, userGroup, pageUtil, request, response);
			return;
		}
		String[] roleIdsArr = roleIds.split(",");
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("groupId", groupId);
		//成功的次数
		int num = 0;
		for(String s:roleIdsArr) {
			hm.put("roleId", s);
			if(userGroupService.updaeGroupRole(hm)) {//添加失败
				fullUserGroup(5, userGroup, pageUtil, request, response);
				return;
			}else {
				System.out.println("判断添加成功，成功");
				num++;
			}
		}
		if(num != roleIdsArr.length) {//次数不等于数组的长度
			fullUserGroup(5, userGroup, pageUtil, request, response);
			return;
		}else {
			//添加成功
			fullUserGroup(6, userGroup, pageUtil, request, response);	
		}
	}
	
	//查询用户组名和用户组Code是否重复
	@RequestMapping("/isGroupRedo.action")
	@ResponseBody
	public JSONObject isGroupRedo(String groupName,String groupCode) {
		System.out.println("查询的用户组名="+groupName);
		System.out.println("查询的用户组Code="+groupCode);
		JSONObject jo = new JSONObject();
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("groupName", groupName);
		hm.put("groupCode", groupCode);
		if(userGroupService.isGroupRedo(hm)) {//不重复
			jo.put("pd", "Y");
		}else jo.put("pd", "N");//重复
		return jo;
	}
	//添加用户组
	@RequestMapping("/addGroup.action")
	public void addGroup(UserGroup userGroup,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加的用户组="+userGroup);
		UserGroup userGroup1  = new UserGroup();
		PageUtil pageUtil = new PageUtil();
		if(userGroupService.addGroup(userGroup)) {//添加失败
			fullUserGroup(4, userGroup1, pageUtil, request, response);
			return;
		}
		//添加成功
		fullUserGroup(3, userGroup1, pageUtil, request, response);
	} 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
