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
import com.service.RoleService;
import com.vo.AuthInfo;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/RoleManage1")
public class RoleManage {

	@Autowired
	private RoleService roleService;
	@Autowired
	private IndexUserManageService indexUserManageService;
	
	Map<String,Object> hm = new HashMap<>();
	{
		PageSize=6;
	}
	Integer PageSize ;
	
	//查询所有角色
	@RequestMapping("/fullRoles.action")
	public void fullRoles(Integer bsh,Role role,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("查询数据="+role);
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("Role", role);
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
		hm1.put("Role", role);
		
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), roleService.fullRoles(hm1).size(), pageUtil.getPageNum(), roleService.fullRoles(hm), "RoleManage1/fullRoles.action", null);
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
		//存入模糊搜索参数
		request.setAttribute("FuzzyQueryRole", role);
		//存入角色信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入分页标识
		request.setAttribute("roleFuzzyQuery", 0);
		request.getRequestDispatcher("/pages/role-list.jsp").forward(request, response);
	}
	
	//角色模糊查询
	@RequestMapping("/roleFuzzyQuery.action")
	public void roleFuzzyQuery(Role role,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("模糊查询数据="+role);
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("Role", role);
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
		hm1.put("Role", role);
		StringBuffer sb = new StringBuffer("&roleState="+role.getRoleState()+"&roleName="+role.getRoleName());
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), roleService.fullRoles(hm1).size(), pageUtil.getPageNum(), roleService.fullRoles(hm), "RoleManage1/roleFuzzyQuery.action", sb);
		
		//存入模糊搜索参数
		request.setAttribute("FuzzyQueryRole", role);
		//存入角色信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入分页标识
		request.setAttribute("roleFuzzyQuery", 1);
		request.getRequestDispatcher("/pages/role-list.jsp").forward(request, response);
	}
	
	//删除角色
	@RequestMapping("/deleteRole.action")
	public void deleteRole(String roleId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("要删除的id为="+roleId);
		Role role = new Role();
		PageUtil pageUtil = new PageUtil();
		if(roleService.hasDelete(roleId)) {//查询是否已删除
			fullRoles(null, role, pageUtil, request, response);
			return;
		}
		if(roleService.deleteRole(roleId)) {//删除失败
			fullRoles(0, role, pageUtil, request, response);
			return;
		}else {//删除成功
			fullRoles(1, role, pageUtil, request, response);
		}
	}

	//更新角色信息
	@RequestMapping("/updateRole.action")
	public void updateRole(Role role,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("更新用户的信息="+role);
		Role role1 = new Role();
		PageUtil pageUtil = new PageUtil();
		if(roleService.updateRole(role)) {//失败
			fullRoles(5, role1, pageUtil, request, response);//刷新
			return;
		}
		//成功
		updateRoleBy(request, role.getRoleName(),null);//存入更新人
		fullRoles(6, role1, pageUtil, request, response);//刷新
	} 
	//更新人添加
	public void updateRoleBy(HttpServletRequest request,String roleName,Integer roleId) {
		if(null == this.hm.get("UserId")) {
			UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
			if(null == userInfo) {
				request.getRequestDispatcher("/pages/login.jsp");
				return;
			}
			this.hm.put("UserId", userInfo.getUserId());
		}
		this.hm.put("roleName", roleName);
		this.hm.put("roleId", roleId);
		roleService.updateRoleBy(hm);
	}
	
	//禁用和启用
	@RequestMapping("/DisableOrEnable.action")
	public void DisableOrEnable(Integer forbuddenId,Integer roleId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("roleId", roleId);
		hm.put("forbuddenId",forbuddenId);
		Role role = new Role();
		PageUtil pageUtil = new PageUtil();
		if(roleService.DisableOrEnable(hm)) {//禁用失败
			fullRoles(2, role, pageUtil, request, response);
			return;
		}
		//禁用成功
		updateRoleBy(request,null,roleId);
		fullRoles(null, role, pageUtil, request, response);
		return;
	}
	
	//查询角色权限
	@RequestMapping("/findRoleAuth.action")
	public void findRoleAuth (String roleId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		List<AuthInfo> authInfos = indexUserManageService.ownershipLimit();
		List<AuthInfo> roleAuths = roleService.findRoleAuth(roleId);//查询角色权限
		JSONArray jsonArray = new JSONArray();
		//int i = 0;
		for(AuthInfo aif:authInfos) {
			//System.out.println("第"+(++i)+"aif="+aif);
			//System.out.println("authInfo.get(i).getAuthState().equals('1')="+aif.getAuthState().equals("1"));
			if(aif.getAuthState().equals("1")) {
				JSONObject jo = new JSONObject();
				jo.put("id", aif.getAuthId());
				jo.put("pId", aif.getParentId());
				jo.put("name", aif.getAuthName());
				if(null != roleAuths) {
					for(AuthInfo ai:roleAuths) {//遍历用户权限
						//System.out.println("第"+i+"个ai="+ai);
						//System.out.println("用户权限与所有权限的id相同aif.getAuthId()==ai.getAuthId()="+(aif.getAuthId()==ai.getAuthId()));
						if(aif.getAuthId()==ai.getAuthId()) {//用户权限与所有权限的id相同
							//System.out.println("用户权限与所有权限的id相同");
							jo.put("open", "true");//打开
							jo.put("checked", "true");//选中
							break;
						}else {
							//System.out.println("用户权限与所有权限的id不相同");
							jo.put("open", "false");
							jo.put("checked", "false");
						}
					}
				}
				jsonArray.add(jo);
				//System.out.println("JSONObject="+jo);
			}
		}
		request.setAttribute("roleAuth", jsonArray);
		request.setAttribute("roleId", roleId);
		request.getRequestDispatcher("/pages/RoleTree.jsp").forward(request, response);
	}
	//更新角色权限
	@RequestMapping("/roleAuth.action")
	public void roleAuth(String roleId,String authIds,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("roleId="+roleId);
		System.out.println("authIds="+authIds);
		if(authIds.endsWith(",")) {
			authIds = authIds.substring(0, authIds.length()-1);
		}
		Role role = new Role();
		PageUtil pageUtil = new PageUtil();
		//判断传的字符串与role_auth表是否一致，一致不插入
		if(roleService.roleAuthEqAuth(roleId, authIds)) {
			fullRoles(null, role, pageUtil, request, response);
			return;
		}
		if(roleService.deleteRoleAuth(roleId)) {//删除失败
			fullRoles(5, role, pageUtil, request, response);
			return;
		}
		String[] authIdArr = authIds.split(",");
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("roleId", roleId);
		//成功的次数
		int num = 0;
		for(String s:authIdArr) {
			hm.put("authId", s);
			if(roleService.updateRoleAuth(hm)) {//添加失败
				fullRoles(5, role, pageUtil, request, response);
				return;
			}else {
				num++;
			}
		}
		if(num != authIdArr.length) {//次数不等于数组的长度
			fullRoles(5, role, pageUtil, request, response);
			return;
		}else {
			//添加成功
			fullRoles(6, role, pageUtil, request, response);	
		}
	}
	
	//查询角色名和角色Code是否重复
	@RequestMapping("/isRoleRedo.action")
	@ResponseBody
	public JSONObject isRoleRedo(String roleName,String roleCode) {
		JSONObject jo = new JSONObject();
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("roleName", roleName);
		hm.put("roleCode", roleCode);
		if(roleService.isRoleRedo(hm)) {//不重复
			jo.put("pd", "Y");
		}else jo.put("pd", "N");//重复
		return jo;
	}
	//添加角色
	@RequestMapping("/addRole.action")
	public void addRole(Role role,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加的数据为:"+role);
		UserInfo userInfo = ((UserInfo)request.getSession().getAttribute("USER"));
		if(null == userInfo) {
			response.sendRedirect("../pages/login.jsp");
			return;
		}
		role.setCreateBy(userInfo.getUserId());
		role.setUpdateBy(userInfo.getUserId());
		//System.out.println("传参的userInfo对象="+userInfo);
		Role role1 = new Role();
		PageUtil pageUtil = new PageUtil();
		if(roleService.addRole(role)) {//添加失败
			fullRoles(4, role1, pageUtil, request, response);
			return;
		}
		//添加成功
		fullRoles(3, role1, pageUtil, request, response);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
