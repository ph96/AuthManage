package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.service.LoginService;
import com.vo.AuthInfo;
import com.vo.Login;
import com.vo.UserInfo;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	public LoginService loginService;
	
	//判断验证码是否正确
	@RequestMapping("/validCode.action")
	@ResponseBody
	public JSONObject validCode(String vCode,HttpServletRequest request) {
		String rand01 = (String)request.getSession().getAttribute("rand01");
		System.out.println("得到输入的验证码: "+vCode);
		System.out.println("Session得到的验证码: "+rand01);
		JSONObject json1 = new JSONObject();
		if(rand01.equals(vCode)) {
			json1.put("msg", 1);
		}else {
			json1.put("msg", 0);
		}
		System.out.println("json值="+json1);
		return json1;
	}
	
	//登陆
	@RequestMapping("/loginVerify.action")
	@ResponseBody
	public JSONObject loginVerify(Login login,HttpServletRequest request) {
		JSONObject json1 = new JSONObject();
		if(loginService.QueryUserJudgment(login)) {
			json1.put("res", 3);
		}else {
			UserInfo uf = loginService.getUser();
			request.getSession().setAttribute("USER", uf);
			System.err.println("***LoginController***loginVerify**用户信息="+loginService.getUser());
			json1.put("res", 1);
		}
		return json1;
	}
	
	//登陆成功跳向的后台
	//用户权限信息
	@RequestMapping("/loginJump.action")
	public void loginJump(HttpServletRequest request,HttpServletResponse response) throws IOException {
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("userId", userInfo.getUserId());
		hm.put("groupId", userInfo.getGroupId());
		hm.put("authId", 0);
		List<AuthInfo> list = loginService.userRight(hm);
		for(AuthInfo ai:list) {
			ai.setParentId(ai.getAuthId());
			hm.put("authId", ai.getParentId());
			ai.setChildList(loginService.userRight(hm));
		}
		request.getSession().setAttribute("firstList", list);
		response.sendRedirect(request.getServletContext().getContextPath()+"/pages/index.jsp");
	}
	
	//退出
	@RequestMapping("/exit.action")
	public void exit(HttpServletRequest request,HttpServletResponse response) throws IOException {
		request.getSession().setAttribute("USER", null);
		response.sendRedirect(request.getServletContext().getContextPath()+"/pages/login.jsp");
	}
}
