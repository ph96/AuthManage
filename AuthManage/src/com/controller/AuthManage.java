package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.AuthService;
import com.service.IndexUserManageService;
import com.vo.AuthInfo;
import com.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/AuthManage1")
public class AuthManage {

	@Autowired
	public IndexUserManageService indexUserManageService;
	@Autowired
	public AuthService authService;
	
	//获取当前用户信息
	public UserInfo userInfo(HttpServletRequest request,HttpServletResponse response) throws IOException {
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
		return userInfo;
	}
	
	//查询所有权限
	@RequestMapping("/selectAllAuth.action")
	public void selectAllAuth(Integer bsh,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//过去session用户信息
		UserInfo userInfo = userInfo(request, response);
		if(null == userInfo) {
			System.out.println("**AuthManage**selectAllAuth*");
			response.sendRedirect(request.getServletContext().getContextPath()+"/pages/login.jsp");
			return;
		}
		List<AuthInfo> authInfo = indexUserManageService.ownershipLimit();
		JSONArray jsonArray = new JSONArray();
		for(AuthInfo aio:authInfo) {
			JSONObject jo = new JSONObject();
			jo.put("id", aio.getAuthId());
			jo.put("pId", aio.getParentId());
			jo.put("name", aio.getAuthName());
			jo.put("state", aio.getAuthState());
			jo.put("desc", aio.getAuthDesc());
			jo.put("grade", aio.getAuthGrade());
			jsonArray.add(jo);
		}
		/*for(int i=0;i<jsonArray.size();i++) {
			JSONObject jjo = jsonArray.getJSONObject(i);
			System.out.println("遍历的第"+i+"个JSONObject="+jjo);
		}*/
		if(null == bsh) {//
			//request.setAttribute("identify", 1);
		}else if(bsh == 1) {//删除失败
			request.setAttribute("identify", 1);
		}else if(bsh == 2){//删除成功
			request.setAttribute("identify", 2);
		}else if(bsh == 3){//恢复失败
			request.setAttribute("identify", 3);
		}else if(bsh ==4){//恢复成功
			request.setAttribute("identify", 4);
		}else if(bsh == 5){//更新失败
			request.setAttribute("identify", 5);
		}else if(bsh ==6){//更新成功
			request.setAttribute("identify", 6);
		}else if(bsh == 7){//添加失败
			request.setAttribute("identify", 7);
		}else if(bsh ==8){//添加成功
			request.setAttribute("identify", 8);
		}
		request.setAttribute("authJson", jsonArray);
		
		request.getRequestDispatcher("/pages/authTree.jsp").forward(request, response);
	}
	
	//删除权限
	@RequestMapping("/deleteAuth.action")
	public void deleteAuth(String input1,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除权限authId="+input1);
		if(!authService.IfDelete(input1)) {
			selectAllAuth(null,request, response);
			return;
		}
		if(authService.deleteAuth(input1)) {//删除失败
			selectAllAuth(1,request, response);
			return;
		}
		selectAllAuth(2,request, response);
	}
	
	//恢复权限
	@RequestMapping("/recoverAuth.action")
	public void recoverAuth(String input1,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("恢复权限authId="+input1);
		if(authService.IfDelete(input1)) {
			selectAllAuth(null,request, response);
			return;
		}
		if(authService.recoverAuth(input1)) {//删除失败
			selectAllAuth(3,request, response);
			return;
		}
		selectAllAuth(4,request, response);
	}
	
	//判断权限名,Url,Code是否重复
	@RequestMapping("/isAuthName.action")
	@ResponseBody
	public JSONObject isAuthName(String authName,String authUrl,String authCode) {
		JSONObject jo = new JSONObject();
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("authName", authName);
		hm.put("authUrl", authUrl);
		hm.put("authCode", authCode);
		if(authService.isAuthName(hm)) {//不重复
			jo.put("pd", "Y");
		}else jo.put("pd", "N");//重复
		return jo;
	}
	
	//更新权限信息
	@RequestMapping("/updateAuth.action")
	public void updateAuth(AuthInfo authInof,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("更新权限信息传参的值="+authInof);
		if(authService.updateAuth(authInof)) {//更新失败
			selectAllAuth(5, request, response);
			return;
		}
		//更新成功
		UserInfo userInfo = userInfo(request, response);//更新修改人
		HashMap<String, Object> hm = new HashMap<>();
		if(null == userInfo) {
			System.out.println("**AuthManage**updateAuth*");
			response.sendRedirect(request.getServletContext().getContextPath()+"/pages/login.jsp");
			return;
		}
		hm.put("userId", userInfo.getUserId());
		hm.put("authId", authInof.getAuthId());
		if(authService.updateUpdateBy(hm)) {//更新修改人失败
			selectAllAuth(5, request, response);
			return;
		}
		selectAllAuth(6, request, response);
	}
	
	//添加权限
	@RequestMapping("/addAuth.action")
	public void addAuth(AuthInfo authInfo,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		JSONObject jo = isAuthName(authInfo.getAuthName(), null, null);
		if(jo.get("pd").equals("N")) {//重复不添加
			selectAllAuth(null, request, response);
			return;
		}
		if(null == authInfo.getParentId()) {
			authInfo.setParentId(0);
		}
		//过去session用户信息
		UserInfo userInfo = userInfo(request, response);
		if(null == userInfo) {
			System.out.println("**AuthManage**addAuth*");
			response.sendRedirect(request.getServletContext().getContextPath()+"/pages/login.jsp");
			return;
		}
		authInfo.setCreateBy(userInfo.getUserId());
		authInfo.setUpdateBy(userInfo.getUserId());
		System.out.println("添加用户的信息为:"+authInfo);
		if(authService.addAuth(authInfo)) {//添加失败
			selectAllAuth(7, request, response);
			return;
		}
		//添加成功
		selectAllAuth(8, request, response);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
