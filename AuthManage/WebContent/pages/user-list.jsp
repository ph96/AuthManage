<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>用户管理 - 用户列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
  </head>
  <body>
<c:if test="${empty USER }">
	<c:redirect url="/pages/login.jsp"></c:redirect>
</c:if>
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">用户列表</h1>
          <div class="row placeholders" style="margin-top: -30px;">
          <%-- <div>
          <input type="text" name="userName"  placeholder="用户名" value="${param.userName }">
          </div> --%><br/>
         	<div>
         	
                <button type="button" id="derive" class="btn btn-warning " >导出数据</button>
                <!--  删除所选对话框 -->
                 <!-- <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                     	   确认删除所选用户吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" id="addQX" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary delete-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div>-->
                 <button type="button"   class="btn btn-primary addUser" data-toggle="modal" data-target="#add-user-form">添加用户</button>
                
                <!--添加新用户表单-->
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加新用户</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="user-form1" action="${pageContext.request.contextPath}/indexUserManage/addUser.action" method="post">
                          <div class="form-group">
                            <label for="userNameInput">用户名</label><label class="delAdd" style="margin-left: 63px;" id="userErrInput"></label>
                            <input type="text" name="userCode" value="${param.userName}" onkeyup="this.value=this.value.replace(/\s+/g,'')" class="form-control addInput" id="userNameInput" placeholder="用户名">
                          </div>
                          <div class="form-group">
                            <label for="userNameInput">昵称</label><label class="delAdd" style="margin-left: 100px;" id="userNickErrInput"></label>
                            <input type="text" name="nickName" value="${param.userName}" onkeyup="this.value=this.value.replace(/\s+/g,'')" class="form-control addInput" id="userNickInput" placeholder="昵称">
                          </div>
                          <div class="form-group">
                            <label for="userNameInput">部门</label>
                            <%-- <input type="text" name="" value="${param.userName}" class="form-control" id="" placeholder="用户名"> --%>
                            <select id="userGuoup" name="groupId" class="form-control" >
			                	<c:forEach var="ug" items="${userGroup }">
			                		<option value="${ug.groupId }" >${ug.groupName }</option>
			                	</c:forEach>
                            </select>
                          </div>
                          <div class="form-group">
                            <label for="passwordInput">密码</label><label class="delAdd" style="margin-left: 100px;" id="passwordErrInput"></label>
                            <input type="password" name="password" class="form-control addInput" id="passwordInput" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="密码">
                          </div>
                          <div class="form-group">
                            <label for="passwordInput">确认密码</label><label class="delAdd" style="margin-left: 74px;" id="QRpasswordErrInput"></label>
                            <input type="password" name="userPwd" class="form-control addInput" id="QRpasswordInput" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="确认密码">
                          </div>
                         </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>    <!-- btn-default" data-dismiss="modal -->
                        <button type="button" class="btn btn-primary add-user-submit">添加 </button>
                      </div>
                    </div>
                  </div>
                </div>
                <input type="text" id="userName" style="margin-left: 425px;margin-top: 1px;height: 31px;" name="userName"  placeholder="请输入用户名关键字" value="${userFuzzyQueryUserInfo.userCode }">
                <select id="userRole" style="width: 85px;height: 31px;">
                	<option  value="" ${userInfo.roleId eq null?selected:"" } style="display: none;">用户类型</option>
                	<c:forEach var="userInfo" items="${USERINFO }">
                		<option value="${userInfo.roleId }" ${userFuzzyQueryUserInfo.userType eq userInfo.roleId?"selected":""} >${userInfo.roleName }</option>
                	</c:forEach>
                	<option value="99" ${userFuzzyQueryUserInfo.userType eq 99?"selected":""}>全部</option>
                </select>
                <select id="userState" style="width: 85px;height: 31px;">
                	<option ${empty userInfo.userType ?selected:"" } style="display: none;" value="">用户状态</option>
                	<option value="1" ${userFuzzyQueryUserInfo.userState eq 1?"selected":""}>启用</option>
                	<option value="0" ${(not empty userFuzzyQueryUserInfo.userState and  userFuzzyQueryUserInfo.userState eq 0)?"selected":""}>禁用</option>
                	<option value="99" ${userFuzzyQueryUserInfo.userState eq 99?"selected":""}>全部</option>
                </select>
                <button type="button" class="btn btn-primary show-user-form" >确定查询</button>
            </div>
            <div class="space-div"></div>
            <table class="table table-hover table-bordered user-list" >
            	<tr style="text-align: center;">
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>用户ID</td>
                    <td>用户名</td>
                    <td>昵称</td>
                    <td>部门</td>
                    <td>用户类型</td>
                    <td>用户状态</td>
                    <td>创建时间</td>
                    <td>操作</td>
                </tr>
                <!--  <tr>
                	<td><input type="checkbox" name="userIds" value="11"/></td>
                    <td class="userid">1</td>
                    <td class="username">sisu</td>
                    <td><a href="javascript:void(0);" class="show-user-roles" >查看所有角色</a></td>
                    <td>
                    	<a class="glyphicon glyphicon-wrench show-userrole-form" aria-hidden="true" title="修改所有角色" href="javascript:void(0);" data-toggle="modal" data-target="#update-userrole-dialog"></a>
                    	<a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);"></a>
                    </td>
                </tr>-->
                <c:forEach items="${page.resultList }" var="user">
                	<tr >
                		<td style="text-align: center;"><input type="checkbox" name="userIds" value="${user.userId }"/></td>
                		<td style="text-align: center;" class="userid">${user.userId }</td>
                		<td style="text-align: center;" class="username">${user.userCode }</td>
                		<td class="UserNickName" style="text-align: center;">${user.nickName }</td>
                		<td class="UserGroupId" style="display: none;">${user.groupId }</td>
                		<td class="UserGroupName" style="text-align: center;">${user.groupName }</td>
                		<td style="text-align: center;">${user.roleName }</td>
                		<td style="text-align: center;${user.userState eq 0?'color:red;':'' }">${user.userState eq 0?"禁用":"启用" }</td>
                		<td style="text-align: center;"><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                		<!-- <td><a href="javascript:void(0);" class="show-user-roles" >显示所有角色</a></td> -->
	                    <td >
	                    	<a class="glyphicon glyphicon-wrench show-userrole-form" aria-hidden="true" title="修改用户" href="javascript:void(0);" data-toggle="modal" data-target="#update-user-dialog"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);" style="color:red"></a>
	                    	<a href="${pageContext.request.contextPath}/indexUserManage/forbuddenUser.action?userId=${user.userId }&forbuddenId=${user.userState }">
	                    		<button type="button" class="btn btn-warning forbudden" style="width: 72px;padding-left: 6px;" >${user.userState eq 1?"禁用":"启用" }</button>
	                    	</a>
	                    	<c:if test="${user.userState eq 1}" > 
	                    	 <button type="button" class="btn btn-primary resetPassword" style="width: 72px;padding-left: 6px;">重置密码</button>
	                    	 <button type="button" class="btn btn-primary show-user-roles" style="width: 72px;padding-left: 6px;" data-toggle="modal" data-target="#update-userrole-dialog">分配角色</button>
	                    	 <a href="${pageContext.request.contextPath}/indexUserManage/ownershipLimit.action?userId=${user.userId}">
	                    	 	<button type="button" class="btn btn-primary " style="width: 72px;padding-left: 6px;">更改权限</button>
	                    	 </a>
	                    	</c:if>
	                    </td>
                	</tr>
                </c:forEach>
            </table>
            <form id="deleteUserId" action="${pageContext.request.contextPath}/indexUserManage/deleteUser.action" method="post">
            	<input id="userId" name="userId" type="text" value="" style="display: none;">
            </form>
              <jsp:include page="standard.jsp"/>
            <!--修改用户表单-->
            <div class="modal fade " id="update-user-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改用户</h4>
                      </div>
                      <div class="modal-body">
                      	<form id="updateUserForm" class="update-userrole-form" method="post">
                      		<div class="form-group">
                        		<label for="UpdateUserIdInput">用户Id</label>
                        		<input id="UpdateUserIdInput" readonly name="userId" class="form-control " type="text" />
                        	</div>
                        	<div class="form-group">
	                            <label for="UpdateUserNameInput">用户名</label>
	                            <input type="text" name="userCode" readonly value="" class="form-control " id="UpdateUserNameInput" >
	                        </div>
	                        <div class="form-group">
	                            <label for="UpdateUserNickInput">昵称</label><label class="" style="margin-left: 100px;" id="updateUserNickErrInput"></label> 
	                            <input type="text" name="nickName" value="" class="form-control " id="UpdateUserNickInput" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="用户昵称">
	                        </div>
	                        <div class="form-group">
	                            <label for="updateUserGuoup">部门</label>
	                            <select id="updateUserGuoup" name="groupId" class="form-control" >
				                	<c:forEach var="ug" items="${userGroup }">
				                		<option  value="${ug.groupId }" >${ug.groupName }</option>
				                	</c:forEach>
                            </select>
	                            <!-- <input type="text" name="groupId" value="" class="form-control " id="UpdateUserGroupIdInput" > -->
	                        </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-user-submit">提交 </button>
                      </div>
                    </div>
                  </div>
            </div>
            <!--修改用户角色表单-->
            <div class="modal fade " id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改用户角色</h4>
                      </div>
                      <div class="modal-body">
                      	<form id="updateUserRoleForm" class="update-userrole-form" method="post">
                      		<div class="form-group">
                        		<label for="UpdateUserIdInput">用户Id</label>
                        		<input id="UpdateRoleUserIdInput" readonly name="userId" class="form-control RoleUserId" type="text" />
                        	</div>
                        	<div class="form-group">
	                            <label for="UpdateUserNameInput">用户名</label>
	                            <input type="text" name="userCode" readonly value="" class="form-control RoleUserName" id="UpdateRoleUserNameInput" >
	                        </div>
	                        <div class="form-group">
	                        	<label >角色 : </label><br/>
	                        	<c:forEach items="${USERINFO }" var="role">
	                        		<input class="Role" type="checkbox" name="roleId" value="${ role.roleId }" >${ role.roleName}&emsp;&emsp;&emsp;&emsp;
	                            </c:forEach>
	                            <input style="display: none;" type="text" name="roleIds" value="" class="form-control " id="roleIds" >
	                        </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-userrole-submit">提交 </button>
                      </div>
                    </div>
                  </div>
            </div>
          </div>          
        </div>
    </div>
    
    
    <!-- 提示框 -->
	<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
        	<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >提示信息</h4>
          </div>
          <div class="modal-body" id="op-tips-content">
          </div>
        </div>
      </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
  //********************************导出*******************************************************************************************************************		
    	$(function(){
    		$("#derive").click(function(){
    			//alert("进入导出");
    			location.href="${pageContext.request.contextPath}/indexUserManage/derivedData.action";
    		});
    		
    	});
//********************************模糊查询*******************************************************************************************************************		
    	function getAllRoles(obj){
    		//alert("进入模糊查询");
    		var userCode = $("#userName").val();
    		var userType = $("#userRole").val();
    		var userState = $("#userState").val();
    		/* console.log("用户名关键字="+userCode);
    		console.log("用户类型="+userType);
    		console.log("用户状态="+userState); */
    		location.href="${pageContext.request.contextPath}/indexUserManage/userFuzzyQuery.action?userCode="+userCode+"&userType="+userType+"&userState="+userState;
    	}

       	function showTips(content){
       		$("#op-tips-content").html(content);
			$("#op-tips-dialog").modal("show");
       	}
    	$(".select-all-btn").change(function(){
			if($(this).is(":checked")){//$(this).prop("checked")
				$(".user-list input[type='checkbox']:gt(0)").prop("checked",true);
			}else{
				$(".user-list input[type='checkbox']:gt(0)").prop("checked",false);
			}
		});
		/* $(".delete-selected-confirm").click(function(){
			$("#delete-confirm-dialog").modal("hide");
			var cbs=$("input[name='userIds']:checked")
			if(cbs.length===0){
				showTips("没有选中任意项！");
			}else{
				var userids=new Array();
				$.each(cbs,function(i,cb){
					userids[i]=cb.value;
				});
				//请求删除所选用户
				 $.ajax({
					url:"deletemore.html",
					data:{userIds:userids},
					type:"POST",
					traditional:true,
					success:function(){
						cbs.parent().parent().remove();
						showTips("删除所选成功！");
					}
				}); 
			}
		}); */
		//查询
		$(".show-user-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
		});
		
		function getRolesByUserName(username,doSuccess){
			$.ajax({
				url:"showroles.html",
				data:{userName:username},
				type:"POST",
				dataType:"json",
				success:function(data){
					doSuccess(data);
				}
			});
		}
//********************************更新用户角色*******************************************************************************************************************		
		//获取页面的值 赋值给更新角色弹框
		$(".user-list").on("click",".show-user-roles",function(){
			var userid = $.trim($(this).parents("tr").find(".userid").text());
			var userCode = $(this).parents("tr").find(".username").html();
			$("#updateUserRoleForm input[name='userId']").val(userid);
			$("#updateUserRoleForm input[name='userCode']").val(userCode);
			//alert("roles="+$("#updateUserRoleForm .Role").length);
			//请求查看用户角色
			$.ajax({
				url:"${pageContext.request.contextPath}/indexUserManage/groupIdUser.action",
				data:{userId:userid},
				type:"POST",
				dataType:"json",
				success:function(data){
					//alert("进入查看用户角色 " +data[0].roleId);
					$("#updateUserRoleForm .Role").removeAttr("checked");
					$.each(data,function(key,value){
						//console.log("id为="+value.roleId);
						$("#updateUserRoleForm .Role").each(function(){
							if($(this).val() == value.roleId){
								//$(this).attr("checked","true");不稳定
								$(this)[0].checked = true;
							}
						});
					});
				}
			});
		});
		//点击添加角色 
		$(".update-userrole-submit").click(function(){
			//拼接当前用户角色的id
			var roleId = "";
			//记录没选角色
			var notRoleId = 0;
			$("#updateUserRoleForm .Role").each(function(){
				console.log($(this)[0].checked);
				if($(this)[0].checked){
					roleId +=$(this).val()+","; 
				}else{
					notRoleId++;
				}
			});
			console.log("roleId="+roleId);
			console.log("notRoleId="+notRoleId);
			if(notRoleId == $("#updateUserRoleForm .Role").length){
				alert("至少选择一个用户角色! !");
			}else{
				$("#roleIds").val(roleId);
				$("#updateUserRoleForm").attr("action","${pageContext.request.contextPath}/indexUserManage/updatRoleUser.action");
				$("#updateUserRoleForm").submit();
			}
		});
//********************************更新用户信息*******************************************************************************************************************
		//获取页面的值 赋值给更新弹框
		$(".user-list").on("click",".show-userrole-form",function(){
			var userid = $.trim($(this).parents("tr").find(".userid").text());
			//$.trim($(this).parents("tr").find(".userid").attr("readOnly",'true');
			var userCode = $(this).parents("tr").find(".username").html();
			var userNickName = $(this).parents("tr").find(".UserNickName").html();
			var userGroupId = $.trim($(this).parents("tr").find(".UserGroupId").text());
			var userGroupName = $.trim($(this).parents("tr").find(".UserGroupName").text());
			$(".update-userrole-form input[name='userId']").val(userid);
			$(".update-userrole-form input[name='userCode']").val(userCode);
			$(".update-userrole-form input[name='nickName']").val(userNickName);
			//删除option的selected属性
			$("#updateUserGuoup option").removeAttr("selected");
			//添加一个option并给赋属性selected
			$("#updateUserGuoup").prepend("<option selected value='"+userGroupId+"'>"+userGroupName+"</option>");
			//获取option的value=userGroupId 的最大索引(一个)
			$("#updateUserGuoup option[value='"+userGroupId+"']:last").remove();
		});
		//光标获取到 昵称错误信息置空
		$("#UpdateUserNickInput").focus(function(){
			$("#updateUserNickErrInput").html("");
		});
		var updateUserNick = false;
		//判断昵称是否为空
		$("#UpdateUserNickInput").blur(function(){
			if($(this).val() == ""){
				$("#updateUserNickErrInput").css({color:"red"}).html("昵称不能为空!");
				updateUserNick = false
			}else{
				updateUserNick = true;
			}
		});
		//确认修改用户信息
		$(".update-user-submit").click(function(){
			$("#UpdateUserNickInput").blur();
			if(updateUserNick){
				$("#updateUserForm").attr("action","${pageContext.request.contextPath}/indexUserManage/updateUser.action");//action("");
				$("#updateUserForm").submit();
			}else{
				alert("请完善信息! !");
			}
		});
//********************************删除用户*******************************************************************************************************************
		//删除用户
		$(".user-list").on("click",".delete-this-user",function(){
			var userTr=$(this).parents("tr");
			var userid=userTr.find(".userid").html();
			//alert("获取标签tr="+userTr.html());
			if(confirm('确认删除ID为"'+userid+'"的用户吗？')){
				//请求删除该用户
				//location.href="${pageContext.request.contextPath}/indexUserManage/deleteUser.action?userId="+userid;
				$("#userId").val(userid);
				$("#deleteUserId").submit();
			}
		});
//********************************重置用户密码*******************************************************************************************************************
		//重置密码
		$(".user-list").on("click",".resetPassword",function(){
			var userTr=$(this).parents("tr");
			var userid=userTr.find(".userid").html();
			var s = "true1";
			//alert("userId="+userid);
			if(confirm('确认重置ID为"'+userid+'"的用户密码吗？')){
				$.ajax({
					url:"${pageContext.request.contextPath}/indexUserManage/resetPassword.action",
					data:{userId:userid},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.resetPassword === "Y") {
							showTips("重置成功！");
						}else if(data.resetPassword === "N"){
							showTips("重置失败！");
						}
					},
					error: function(data){
						console.log("服务器异常");
					}
				});
			}
		});
//********************************添加用户*******************************************************************************************************************
		//点击添加新用户清除form表单
      	$(".addUser").click(function(){
      		//alert("进入清除form表单");
      		$("#add-user-form form .addInput").val("");
      		$("#add-user-form form .delAdd").html("");
      	});
		//获取光标事件,让提示消失
		$("#userNameInput").focus(function(){
			$("#userErrInput").html("");
		});
		var userNamepd = false;
		//判断用户名是否重复
		$("#userNameInput").blur(function(){
			//alert("进入异步判断 "+$(this).val());
			//获取用户名
			var userName = $(this).val();
			//alert($(this).val().length <5+","+$(this).val().length);
			if(userName==""){
				$("#userErrInput").css({color:"red"}).html("用户名不能为空");
				userNamepd = false;
				return;
			}else if($(this).val().length <5){
				$("#userErrInput").css({color:"red"}).html("用户名少于5个字符或数字");
				userNamepd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/indexUserManage/redoUser.action",
				data:{userName:userName},
				type:"POST",
				dataType:"json",
				success:function(data){
					//alert("data="+data.pd);
					//var data1 = ""+data;
					if(data.pd){//无用户
						$("#userErrInput").css({color:"green"}).html("用户名可用");
						userNamepd = true;
					}else {
						//有用户
						$("#userErrInput").css({color:"red"}).html("用户名不可用");
						userNamepd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   userNamepd = false;
	                }
			});
		});
		//存密码
		var password;
		var passwordpd = false;
		//判断密码是否一致
		//密码
		$("#passwordInput").blur(function(){
			if($(this).val()==""){
				$("#passwordErrInput").css({color:"red"}).html("密码不能为空");
				passwordpd = false;
			}else if($(this).val().length <6){
				$("#passwordErrInput").css({color:"red"}).html("密码少于6位");
				passwordpd = false;
			}else{
				password = $(this).val();
			}
		});
		//确认密码
		$("#QRpasswordInput").blur(function(){
			if($(this).val()=="" ){
				$("#QRpasswordErrInput").css({color:"red"}).html("密码不能为空");
				passwordpd = false;
			}else if($(this).val().length <6){
				$("#QRpasswordErrInput").css({color:"red"}).html("密码少于6位");
				passwordpd = false;
			}else{
				if(password === $(this).val()){
					//alert("密码相等");
					$("#passwordErrInput").css({color:"red"}).html("");
					$("#QRpasswordErrInput").css({color:"red"}).html("");
					passwordpd = true;
				}else{
					//alert("密码不相等");
					$("#passwordErrInput").css({color:"red"}).html("密码不相等");
					$("#QRpasswordErrInput").css({color:"red"}).html("密码不相等");
					passwordpd = false;
				}
			}
		});
		//密码清空
		$("#passwordInput").focus(function(){
			$("#passwordErrInput").html("");
		});
		//确认密码清空
		$("#QRpasswordInput").focus(function(){
			$("#QRpasswordErrInput").html("");
		});
		//判断昵称
		var nickpd = false;
		//判断昵称是否为空
		$("#userNickInput").blur(function(){
			if($(this).val()==""){
				$("#userNickErrInput").css({color:"red"}).html("昵称不能为空");
				nickpd = false;
			}else{
				nickpd = true;
			}
		});
		$("#userNickInput").focus(function(){
			$("#userNickErrInput").html("");
		});
		$(".add-user-submit").mousedown(function(){
			$("#userNameInput").trigger("blur");
			$("#passwordInput").trigger("blur");
			$("#QRpasswordInput").trigger("blur");
			$("#userNickInput").trigger("blur");
		});
		//添加用户
		$(".add-user-submit").mouseup(function(){
			//请求添加新用户
			//alert("进入添加用户");
			/* console.log("用户名="+userNamepd);
			console.log("密码="+passwordpd);
			console.log("昵称="+nickpd); */
			if(userNamepd && passwordpd && nickpd){
				$(".user-form1").submit();
			}else{
				alert("请完善信息! !");
			}
		});
				
		
		
		
		
		
		
		
		
		
		
		
		
		
		//}); 
		function identify(){
			if(${identify == 99} ){
				//alert("☻返回为99");
			}else if(${identify == 0}){
				//alert("返回为0");
				showTips("删除失败！");
			}else if(${identify == 1}){
				//alert("返回为1");
				showTips("删除成功！");
			}else if(${identify == 3}){
				showTips("☻添加成功！");
			}else if(${identify == 4}){
				showTips("添加失败！");
			}else if(${identify == 5}){
				showTips("更新失败！");
			}else if(${identify == 6}){
				showTips("☻更新成功！");
			}
		}
		window.onload = identify; 
    </script>
  </body>
</html>
