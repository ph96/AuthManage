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
import com.vo.AuthInfo;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



@Controller
@RequestMapping("/indexUserManage")
public class UserManage {
	@Autowired
	public IndexUserManageService indexUserManageService;
	Map<String,Object> hm = new HashMap<>();
	{
		PageSize=6;
	}
	Integer PageSize ;
	
	public void updateUserBy(HttpServletRequest request,String userId) {
		if(null == this.hm.get("UserId")) {
			UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
			if(null == userInfo) {
				request.getRequestDispatcher("/pages/login.jsp");
				return;
			}
			this.hm.put("UserId", userInfo.getUserId());
		}
		this.hm.put("userId", userId);
		indexUserManageService.updateUserBy(hm);
	}
	
	//查询用户列表和分页
	@RequestMapping("/fullUser.action")
	public void fullUser(Integer bsh,UserInfo userInfo,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException  {
		HashMap<String,Object> hm = new HashMap<>();
		
		hm.put("UserInfo", userInfo);
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
		hm1.put("UserInfo", userInfo);
		
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), indexUserManageService.fullUser(hm1).size(), pageUtil.getPageNum(), indexUserManageService.fullUser(hm), "indexUserManage/fullUser.action", null);
		pageUtil2.setLimitIndex(pageUtil.getLimitIndex());
		
		/*for(UserInfo us:indexService.fullUser(hm)) {
			System.out.println(us);
		}
		System.err.println("#####"+pageUtil2);*/
		//查询用户角色(类型)
		request.getSession().setAttribute("USERINFO", indexUserManageService.fullRoles());
		//查询所有部门信息
		request.getSession().setAttribute("userGroup", indexUserManageService.findGroup());
		//System.out.println("部门信息="+indexUserManageService.findGroup());
		//存入模糊搜索参数
		request.setAttribute("userFuzzyQueryUserInfo", userInfo);
		//存入用户信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入分页标识
		request.setAttribute("userFuzzyQuery", 0);
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
		//request.getRequestDispatcher("/pages/index.jsp").forward(request, response);
		request.getRequestDispatcher("/pages/user-list.jsp").forward(request, response);
	}
	
	//用户列表模糊查询
	@RequestMapping("/userFuzzyQuery.action")
	public void userFuzzyQuery(UserInfo userInfo,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("进入模糊查询后台UserInfo="+userInfo);
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("UserInfo", userInfo);
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
		hm1.put("UserInfo", userInfo);
		StringBuffer sb = new StringBuffer("&userState="+userInfo.getUserState()+"&userCode="+userInfo.getUserCode()+"&userType="+userInfo.getUserType());
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), indexUserManageService.fullUser(hm1).size(), pageUtil.getPageNum(), indexUserManageService.fullUser(hm), "indexUserManage/userFuzzyQuery.action", sb);
		//System.err.println("#####"+pageUtil2);
		//查询所有用户
		/*for(UserInfo us:indexService.fullUser(hm)) {
			System.err.println(us);
		}*/
		//查询用户类型
		request.setAttribute("USERINFO", indexUserManageService.fullRoles());
		//存入用户信息和分页数据
		request.setAttribute("page", pageUtil2);
		//存入模糊搜索参数
		request.setAttribute("userFuzzyQueryUserInfo", userInfo);
		//存入分页标识
		request.setAttribute("userFuzzyQuery", 1);
		//储存不让报错的的信息
		request.setAttribute("identify", 99);
		request.getRequestDispatcher("/pages/user-list.jsp").forward(request, response);

	}

	//删除用户
	@RequestMapping("/deleteUser.action")
	public void deleteUser(String userId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("要删除的userId="+userId);
		UserInfo userInfo = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		if(indexUserManageService.hasDelete(userId)) {//查询是否已删除
			fullUser(null, userInfo, pageUtil, request, response);
			return;
		}
		if(indexUserManageService.deleteUser(userId)) {//删除失败
			fullUser(0, userInfo, pageUtil, request, response);
			return;
		}else {//删除成功
			updateUserBy(request,userId);
			fullUser(1, userInfo, pageUtil, request, response);
		}
	}
	
	//重置密码
	@RequestMapping("/resetPassword.action")
	@ResponseBody
	public JSONObject resetPassword(String userId,HttpServletRequest request) {
		JSONObject a2 = new JSONObject();
		if(indexUserManageService.resetPassword(userId)) {//重置成功
			updateUserBy(request,userId);
			a2.put("resetPassword", "Y");
			return a2;
		}
		//重置失败
		a2.put("resetPassword", "N");
		return a2;
	}
	
	//禁用用户
	@RequestMapping("/forbuddenUser.action")
	public void forbuddenUser(Integer forbuddenId,Integer userId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("UserId", userId);
		hm.put("forbuddenId",forbuddenId);
		UserInfo userInfo = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		if(indexUserManageService.forbuddenUser(hm)) {//禁用失败
			fullUser(2, userInfo, pageUtil, request, response);
			return;
		}
		//禁用成功
		updateUserBy(request,""+userId);
		fullUser(null, userInfo, pageUtil, request, response);
		return;
	}
	
	//判断用户名是否重复
	@RequestMapping("/redoUser.action")
	@ResponseBody
	public JSONObject redoUser(String userName) {
		//System.out.println("传参的用户名="+userName);
		JSONObject jo = new JSONObject();
		if(indexUserManageService.redoUser(userName)) {//无用户
			jo.put("pd", true);
		}else {//有用户
			jo.put("pd", false);
		}
		return jo;
	}
	
	//添加用户
	@RequestMapping("/addUser.action")
	public void addUser(UserInfo userInfo,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		Integer userId = ((UserInfo)request.getSession().getAttribute("USER")).getUserId();
		userInfo.setCreateBy(userId);
		userInfo.setUpdateBy(userId);
		//System.out.println("传参的userInfo对象="+userInfo);
		UserInfo userInfo1 = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		if(indexUserManageService.addUser(userInfo)) {//添加失败
			fullUser(4, userInfo1, pageUtil, request, response);
			return;
		}
		//添加成功
		fullUser(3, userInfo1, pageUtil, request, response);
	}
	
	//更新用户信息
	@RequestMapping("/updateUser.action")
	public void updateUser(UserInfo userInfo,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("更新用户的信息="+userInfo);
		UserInfo userInfo1 = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		if(indexUserManageService.updateUser(userInfo)) {//失败
			fullUser(5, userInfo1, pageUtil, request, response);//刷新
			return;
		}
		//成功
		updateUserBy(request, ""+userInfo.getUserId());//存入更新人
		fullUser(6, userInfo1, pageUtil, request, response);//刷新
	}
	
	//查询当前用户的角色
	@RequestMapping("/groupIdUser.action")
	@ResponseBody
	public JSONArray groupIdUser(String userId,HttpServletRequest request,HttpServletResponse response) throws IOException {
		//PrintWriter out = response.getWriter();
		List<Role> role = indexUserManageService.groupIdUser(userId);
		JSONArray jsonArray = new JSONArray();
		for(Role r:role) {
			JSONObject json1 = new JSONObject();
			json1.put("roleId", r.getRoleId());
			jsonArray.add(json1);
		}
		return jsonArray;
	}
	//更新当前用户角色
	@RequestMapping("/updatRoleUser.action")
	public void updatRoleUser(String userId,String userCode,String roleIds,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		if(roleIds.endsWith(",")) {
			roleIds = roleIds.substring(0, roleIds.length()-1);
		}
		UserInfo userInfo = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		//判断传的字符串与user_role表是否一致，一致不插入
		if(indexUserManageService.roleIdRqUserRole(userId, roleIds)) {
			fullUser(null, userInfo, pageUtil, request, response);
			return;
		}
		if(indexUserManageService.deleteAllRole(userId)) {//删除失败
			fullUser(5, userInfo, pageUtil, request, response);
			return;
		}
		String[] roleIdsArr = roleIds.split(",");
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("userId", userId);
		//成功的次数
		int num = 0;
		for(String s:roleIdsArr) {
			hm.put("roleId", s);
			if(indexUserManageService.updatRoleUser(hm)) {//添加失败
				fullUser(5, userInfo, pageUtil, request, response);
				return;
			}else {
				System.out.println("判断添加成功，成功");
				num++;
			}
		}
		if(num != roleIdsArr.length) {//次数不等于数组的长度
			fullUser(5, userInfo, pageUtil, request, response);
			return;
		}else {
			//添加成功
			fullUser(6, userInfo, pageUtil, request, response);			
		}
	}
	
	//查询所有的权限(查询所有正常状态的权限)
	@RequestMapping("/ownershipLimit.action")
	public void ownershipLimit(String userId,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		List<AuthInfo> authInfo = indexUserManageService.ownershipLimit();
		List<AuthInfo> userAuth = indexUserManageService.findAuthByUser(userId);//查询用户权限
		JSONArray jsonArray = new JSONArray();
		//int i = 0;
		for(AuthInfo aif:authInfo) {
			//System.out.println("第"+(++i)+"aif="+aif);
			//System.out.println("authInfo.get(i).getAuthState().equals('1')="+aif.getAuthState().equals("1"));
			if(aif.getAuthState().equals("1")) {
				JSONObject jo = new JSONObject();
				jo.put("id", aif.getAuthId());
				jo.put("pId", aif.getParentId());
				jo.put("name", aif.getAuthName());
				if(null != userAuth) {
					for(AuthInfo ai:userAuth) {//遍历用户权限
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
		request.setAttribute("userAuth", jsonArray);
		request.setAttribute("userId", userId);
		request.getRequestDispatcher("/pages/indexUserAuthTree.jsp").forward(request, response);
	}
	//修改用户权限
	@RequestMapping("/updateAuthUser.action")
	public void updateAuthUser(String userId,String authIds,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("userId="+userId);
		System.out.println("authIds="+authIds);
		if(authIds.endsWith(",")) {
			authIds = authIds.substring(0, authIds.length()-1);
		}
		UserInfo userInfo = new UserInfo();
		PageUtil pageUtil = new PageUtil();
		//判断传的字符串与user_auth表是否一致，一致不插入
		if(indexUserManageService.authRqUserAuth(userId, authIds)) {
			fullUser(null, userInfo, pageUtil, request, response);
			return;
		}
		if(indexUserManageService.deleteAllAuth(userId)) {//删除失败
			fullUser(5, userInfo, pageUtil, request, response);
			return;
		}
		String[] authIdArr = authIds.split(",");
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("userId", userId);
		//成功的次数
		int num = 0;
		for(String s:authIdArr) {
			hm.put("authId", s);
			if(indexUserManageService.updateAuthUser(hm)) {//添加失败
				fullUser(5, userInfo, pageUtil, request, response);
				return;
			}else {
				num++;
			}
		}
		if(num != authIdArr.length) {//次数不等于数组的长度
			fullUser(5, userInfo, pageUtil, request, response);
			return;
		}else {
			//添加成功
			fullUser(6, userInfo, pageUtil, request, response);			
		}
	}
	
	//导出数据
	@RequestMapping("/derivedData.action")
	public void derivedData(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HashMap<String,Object> hm = new HashMap<>();
		UserInfo userInfo = new UserInfo();
		hm.put("UserInfo", userInfo);
		List<UserInfo> userInfos = indexUserManageService.fullUser(hm);
		request.setAttribute("fullUser", userInfos);
		request.getRequestDispatcher("/pages/user-list-download.jsp").forward(request, response);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
