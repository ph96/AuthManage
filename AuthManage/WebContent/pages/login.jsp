<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>登录页面</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet">
   <style type="text/css">
   	.red{color:red}
   </style>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
   
   <script type="text/javascript">
   	   //读取cookie
	   $(document).ready(function(){
	       var rem = $.cookie('userName');
	       if(rem){
	           $("#rememberMe").prop("checked",true);
	           $("#inputEmail").val($.cookie("userName"));
	           $("#inputPassword").val($.cookie("userPwd"));
	       }
	   });
   
     var flag=false;
    //判断验证码是否正确
	$(document).ready(function(){
		$("#login").click(function (){	
		var vCode=$("#inputCode").val();
	 	 if(!!vCode){
	 	 	$.ajax({  
	                type:"POST", //请求方式 
	                url:"${pageContext.request.contextPath}/login/validCode.action",
	                dataType:"json", //返回数据类型
	                data:{//请求参数
	               		vCode:vCode
	                },
	                success:function(data){ //请求成功后
	                	if(data.msg=='1'){
	                      	flag=true;
                      	 	//alert("验证码正确！");
                      	 	$("#error_html").removeClass("red").html("");
                      	 	login();
                       }else{
                        	//alert("验证码不正确！");
                        	$("#error_html").addClass("red").html("验证码不正确!");
                        	flag=false;
                       }
	                },
	                error:function (){
	                	alert("系统出现异常！");
	                }    
	         }); 
         }else{
           flag=false;
           alert("验证码不能为空")
         }
	} );
	
	}); 
		
	function login(){
        //登陆
		var userName=$("#inputEmail").val();//获取用户名
		var psw=$("#inputPassword").val();
		var vCode=$("#inputCode").val();
			if(!/^\w{4,16}$/.test(userName)){
				//alert("用户名不合法! 4-16位，字母，数字，下划线");
				$("#userNameError").addClass("red").text("用户名不合法! 4-16位，字母，数字，下划线");
				return false;
			}else if(psw.length>16 || psw.length<6){
			   alert("密码不合法! 6-16位，字母，数字");
				return false;
			}else if(!flag){
				alert("验证码不正确！");
				return false;
			}else{
				$.ajax({  
	                type:"POST",  
	                url:"${pageContext.request.contextPath}/login/loginVerify.action",
	                dataType:"json",  
	                data:{
	                	//vCode:vCode,
	               		userPwd:psw,
	                	userCode:userName
	                },  
	                success:function(data){ 
	                  if( data.res=="1"){
		                   //登录成功
		                 var chc=$("#rememberMe").prop("checked");
		                  //判断checkbox是否被选中
		                  if(chc){
		                    $.cookie("userName", userName,{expires:7});
		                    $.cookie("userPwd", psw,{expires:7});
		                   // $.cookie("token", token);
		                  }else{
		                  	 //清空
		                  	 $.cookie("userName", null);
		                  	 $.cookie("userPwd", null);
		                   } 
		                  //alert("登陆成功! !");
	                 	  window.location.href="${pageContext.request.contextPath}/login/loginJump.action";
	                  }else if(data.res=="0"){
	                  	alert("验证码错误！");
	                  	return false;
	                  }else{
	                  	alert("登录失败,用户名或密码错误! !");
	                  	return false;
	                  }
	                },
	                error:function (){
	                   alert("系统错误！");
	                }   
         });
	}

	}
	$(function(){
		$("#inputEmail").focus(function(){
			$("#userNameError").text("");
		});
	}); 
	$(function(){
		$("#inputCode").focus(function(){
			$("#error_html").text("");
		});
	});
	 $(function(){
		 $("body").keydown(function (event) {
			  if(event.keyCode==13){ 
				  //alert("键盘起作用"); 
				  $("#login").click(); 
			  }   
			});
	 });
	 
</script>
  </head>
  
  <body>
    	<form class="form-signin" method="post" action="##">
			<h3 class="form-signin-heading">请登录</h3>
			<label for="inputEmail" class="sr-only">用户名</label>
			<input type="text" id="inputEmail" class="form-control class123456" placeholder="用户名"  name="username" maxlength="20"  >
			 <label id="userNameError"></label>
			<label for="inputPassword" class="sr-only">密码</label>
			<input type="password"  id="inputPassword" class="form-control" placeholder="密码" name="password" maxlength="10">
		   
			<label for="inputEmail" class="sr-only" >验证码</label>
			<input type="text" id="inputCode" placeholder="验证码" name="code" tabindex="6" style="width:80px;text-transform:uppercase;ime-mode:disabled" maxlength="4">
			<img id="vdimgck"  src="${pageContext.request.contextPath}/pages/image.jsp?d="+new Date()+"" alt="看不清？点击更换" align="absmiddle" width="75" style="cursor:pointer" onclick="this.src=this.src+'?'" />
			<label id="error_html" style="font-size:18px;"></label>
		   <div class="checkbox" id="checkboxid" >
			  <label>
				<input type="checkbox" id="rememberMe" name="rememberMe" > 记住我&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </label>
			</div>
			<p class="bg-warning">${error}</p>
			<button class="btn btn-lg btn-primary btn-block" id="login" type="button"   >登录</button><!-- onclick="return login()" -->
     </form>
    
    
    
</body>
</html>
