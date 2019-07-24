<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>用户管理 - 角色列表</title>

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
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">角色列表</h1>
          <div class="row placeholders">
          	<div>
            	<!-- <button type="button" class="btn btn-warning delete-query" data-toggle="modal" data-target="#delete-confirm-dialog">删除所选</button>
                 删除所选对话框
                <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                        确认删除所选角色吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary delete-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div> -->
            	<button type="button" class="btn btn-default show-add-form" data-toggle="modal" data-target="#role-form-div">添加新角色</button>
                <!--添加新角色表单-->
                <div class="modal fade " id="role-form-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="role-form-title" >添加角色</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="add-role-form" method="post">
                          <input type="hidden" name="roleId" class="form-control" id="roleIdInput">
                          <div class="form-group">
                            <label for="roleNameInput">角色名称</label>
                            <label class="qingkong" id="addRoleNameErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="roleName" class="form-control" id="addRoleNameInput" placeholder="角色名" onkeyup="this.value=this.value.replace(/\s+/g,'')">
                          </div>
                          <div class="form-group">
                            <label for="descInput">角色描述</label>
                            <label class="qingkong" id="addDescErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="roleDesc" class="form-control" id="addDescInput" placeholder="角色描述" onkeyup="this.value=this.value.replace(/\s+/g,'')">
                          </div>
                          <div class="form-group">
                            <label for="codeInput">角色代码</label>
                             <label class="qingkong" id="addCodeErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="roleCode" class="form-control" id="addCodeInput" placeholder="角色代码" onkeyup="this.value=this.value.replace(/\s+/g,'')">
                          </div>
                          
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary add-role-submit">提交</button>
                      </div>
                    </div>
                  </div>
                </div>
                <input type="text" id="roleName" style="margin-left: 625px;margin-top: 1px;height: 31px;" name="roleName"  placeholder="请输入角色名关键字" value="${FuzzyQueryRole.roleName }">
                <select id="roleState" style="width: 85px;height: 31px;">
                	<option ${empty userInfo.userType ?selected:"" } style="display: none;" value="">角色状态</option>
                	<option value="1" ${FuzzyQueryRole.roleState eq 1?"selected":""}>启用</option>
                	<option value="0" ${(not empty FuzzyQueryRole.roleState and  FuzzyQueryRole.roleState eq 0)?"selected":""}>禁用</option>
                	<option value="99" ${FuzzyQueryRole.roleState eq 99?"selected":""}>全部</option>
                </select>
                <button type="button" class="btn btn-primary show-user-form" >确定查询</button>
            </div>
            <div class="space-div"></div>
            <table class="table table-hover table-bordered role-list">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>ID</td>
                    <td>名称</td>
                    <td>描述</td>
                    <td>代码</td>
                    <td>状态</td>
                    <td>操作</td>
                </tr>
                <!--  <tr>
                	<td><input type="checkbox" name="roleIds"/></td>
                    <td class="roleid">11</td>
                    <td>用户管理员</td>
                    <td>用户管理</td>
                    <td>user_admin</td>
                    <td><a href="javascript:void(0);" class="show-role-perms" >查看所有权限</a></td>
                    <td><a class="glyphicon glyphicon-pencil show-roleinfo-form" aria-hidden="true" title="修改角色信息" href="javascript:void(0);" data-toggle="modal" data-target="#role-form"></a>
                    	<a class="glyphicon glyphicon-remove delete-this-role" aria-hidden="true" title="删除角色" href="javascript:void(0);"></a></td>
                </tr>-->
                <c:forEach items="${page.resultList }" var="role">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value="${role.roleId }"/></td>
	                    <td class="roleId">${role.roleId }</td>
	                    <td class="roleName">${role.roleName }</td>
	                    <td class="roleDesc">${role.roleDesc }</td>
	                    <td>${role.roleCode }</td>
	                    <td style="${role.roleState eq 0?'color:red;':'' }">${role.roleState eq 1?"启用":"禁用" }</td>
	                    <!-- <td><a href="javascript:void(0);" class="show-role-perms" >查看所有权限</a></td> -->
	                    <td>
	                    	<a class="glyphicon glyphicon-pencil show-roleinfo-form" aria-hidden="true" title="修改角色信息" href="javascript:void(0);" data-toggle="modal" data-target="#update-role-div"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-role" aria-hidden="true" title="删除角色" href="javascript:void(0);" style="color:red"></a>
	                   		<a href="${pageContext.request.contextPath}/RoleManage1/DisableOrEnable.action?roleId=${role.roleId }&forbuddenId=${role.roleState }">
	                    		<button type="button" class="btn btn-warning forbudden" style="width: 72px;padding-left: 6px;" >${role.roleState eq 1?"禁用":"启用" }</button>
	                    	</a>
	                    	<c:if test="${role.roleState eq 1}" > 
		                    	 <a href="${pageContext.request.contextPath}/RoleManage1/findRoleAuth.action?roleId=${role.roleId}">
		                    	 	<button type="button" class="btn btn-primary " style="width: 72px;padding-left: 6px;">更改权限</button>
		                    	 </a>
	                    	</c:if>
	                    </td>
	                </tr>
                </c:forEach>
            </table>
            <form id="deleteRoleId" action="${pageContext.request.contextPath}/RoleManage1/deleteRole.action" method="post">
            	<input id="roleId" name="roleId" type="text" value="" style="display: none;">
            </form>
            <jsp:include page="Role-standard.jsp"/>
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
    <!-- 更新角色 -->
    <div class="modal fade " id="update-role-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
       <div class="modal-dialog modal-md" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="role-form-title" >更新角色</h4>
           </div>
           <div class="modal-body">
           	<form class="update-role-form" method="post">
               <input type="hidden" name="roleId" class="form-control" id="roleIdInput">
               <div class="form-group">
                 <label for="roleNameInput">名称</label>
                 <input disabled type="text" name="roleName" class="form-control" id="updateRoleNameInput1" >
                 <input type="text" style="display: none;" name="roleName" class="form-control" id="updateRoleNameInput">
               </div>
               <div class="form-group">
                 <label for="descInput">描述</label>
                 <input type="text" name="roleDesc" class="form-control" id="updateDescInput" placeholder="角色描述" onkeyup="this.value=this.value.replace(/\s+/g,'')">
               </div>
               <!-- <div class="form-group">
                 <label for="codeInput">代码</label>
                 <input type="text" name="roleCode" class="form-control" id="codeInput" placeholder="角色代码">
               </div> -->
             </form>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
             <button type="button" class="btn btn-primary update-role-submit">提交</button>
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
//*********************************模糊查询******************************************************************************
		//查询
		$(".show-user-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
		});
		function getAllRoles(obj){
			//alert("进入模糊查询");
			var roleName = $("#roleName").val();
			var roleState = $("#roleState").val();
			location.href="${pageContext.request.contextPath}/RoleManage1/roleFuzzyQuery.action?roleName="+roleName+"&roleState="+roleState;
		}
//********************************删除角色*******************************************************************************************************************
		//删除角色
		$(".role-list").on("click",".delete-this-role",function(){
			var roleTr=$(this).parents("tr");
			var roleId=roleTr.find(".roleId").html();
			//alert("获取标签tr="+userTr.html());
			if(confirm('确认删除ID为"'+roleId+'"的用户吗？')){
				//请求删除该用户
				//location.href="${pageContext.request.contextPath}/indexUserManage/deleteUser.action?userId="+userid;
				$("#roleId").val(roleId);
				$("#deleteRoleId").submit();
			}
		});	
//********************************提示信息*******************************************************************************************************************		
		$(function(){
			function showTips(contents){
	    		$("#op-tips-content").html(contents);
				$("#op-tips-dialog").modal("show");
	       	}
			if(${identify == 99} ){
				//alert("☻返回为99");
			}else if(${identify == 0}){
				showTips("删除失败！");
			}else if(${identify == 1}){
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
			/* //角色名光标失去事件
			$("#addRoleNameInput").blur(function(){
				if($(this).val == ""){
					alert("角色名不能为空!");
				}
			}); */
		});
//********************************修改角色信息*******************************************************************************************************************				
		$(".role-list").on("click",".show-roleinfo-form",function(){
				/* getAllPerms($(".perm-inputs"));
				resetRoleForm("更新角色信息","更新"); */
				var roleName=$(this).parents("tr").find(".roleName").html();
				var roleDesc=$(this).parents("tr").find(".roleDesc").html();
				$("#updateRoleNameInput1").val(roleName);
				$("#updateRoleNameInput").val(roleName);
				$("#updateDescInput").val(roleDesc);
			});
		$(".update-role-submit").mouseup(function(){
			$(".update-role-form").attr("action","${pageContext.request.contextPath}/RoleManage1/updateRole.action");
			$(".update-role-form").submit();
		});
//*********************************添加角色***************************************************************************************		
		//角色名验证
		var roleNamePd = false;
		//角色描述验证
		var roleDescPd = false;
		//角色代码验证
		var roleCodePd = false;
		$(function(){
			//角色名光标失去事件
			$("#addRoleNameInput").blur(function(){
				if($(this).val() == "" || $(this).val() == " "){
					$("#addRoleNameErrInput").css({color:"red"}).html("角色名不能为空!");
					roleNamePd = false;
					return;
				}else{
					var roleName=$(this).val();
					$.ajax({
						url:"${pageContext.request.contextPath}/RoleManage1/isRoleRedo.action",
						data:{roleName:roleName},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#addRoleNameErrInput").css({color:"green"}).html("角色名可用!");
								roleNamePd = true;
								return;
							}else if(data.pd === "N"){
								$("#addRoleNameErrInput").css({color:"red"}).html("角色名不可用!");
								roleNamePd = false;
								return;
							}
						},
						error: function(data){
							console.log("服务器异常");
							roleNamePd = false;
						}
					});
				}
			});
			//角色名光标获得事件
			$("#addRoleNameInput").focus(function(){
				$("#addRoleNameErrInput").html("");
			});
			//角色描述光标失去事件
			$("#addDescInput").blur(function(){
				if($(this).val() == "" || $(this).val() == " "){
					$("#addDescErrInput").css({color:"red"}).html("角色名不能为空!");
					roleDescPd = false;
					return;
				}else{
					roleDescPd = true;
				}
			});
			//角色描述光标获得事件
			$("#addDescInput").focus(function(){
				$("#addDescErrInput").html("");
			});
			//角色Code光标失去事件
			$("#addCodeInput").blur(function(){
				if($(this).val() == "" || $(this).val() == " "){
					$("#addCodeErrInput").css({color:"red"}).html("角色名不能为空!");
					roleCodePd = false;
					return;
				}else{
					var roleCode=$(this).val();
					$.ajax({
						url:"${pageContext.request.contextPath}/RoleManage1/isRoleRedo.action",
						data:{roleCode:roleCode},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#addCodeErrInput").css({color:"green"}).html("角色名可用!");
								roleCodePd = true;
								return;
							}else if(data.pd === "N"){
								$("#addCodeErrInput").css({color:"red"}).html("角色名不可用!");
								roleCodePd = false;
								return;
							}
						},
						error: function(data){
							console.log("服务器异常");
							roleCodePd = false;
						}
					});
				}
			});
			//角色Code光标获得事件
			$("#addCodeInput").focus(function(){
				$("#addCodeErrInput").html("");
			});
			//添加角色 点击提交事件
			$(".add-role-submit").mouseup(function(){
				$("#addRoleNameInput").blur();
				$("#addDescInput").blur();
				$("#addCodeInput").blur();
				if(roleNamePd && roleDescPd && roleCodePd){
					//alert("准备进入后台");
					$(".add-role-form").attr("action","${pageContext.request.contextPath}/RoleManage1/addRole.action");
					$(".add-role-form").submit();
				}
				
			});
		});
//******************************点击添加按钮***************************************************************************************		
		$(".show-add-form").click(function(){
			$("#addRoleNameInput").val("");
			$("#addRoleNameErrInput").html("");
			$("#addDescInput").val("");
			$("#addDescErrInput").html("");
			$("#addCodeInput").val("");
			$("#addCodeErrInput").html("");
		});

		
		
		
		
		
		
		
		
//***********************************************************************************************************************************************************************
     
     /*function resetRoleForm(title,button){
           	$(".role-form input[type='text']").val("");
			$(".role-form input[type='checkbox']").prop("checked",false);
       		$(".role-form-title").html(title);
			$(".role-submit").html(button);
      	}
       	function getAllPerms(obj){
        	obj.html("");
    		$.ajax({
				url:"listperms.html",
				type:"POST",
				dataType:"json",
				success:function(data){
					for(var i in data){
						obj.append('<input type="checkbox" name="permIds" value="'+
								data[i].permissionId+'"/>'+data[i].permissionDesc+':');
						if(data[i].isNavi===1){
							obj.append('<font color="red">导航结点</font>');
						}else{
							obj.append("非导航结点");
						}
						obj.append("<br/>");
					}
				}
			});
       	}
    	$(".select-all-btn").change(function(){
			if($(this).is(":checked")){//$(this).prop("checked")
				$(".role-list input[type='checkbox']:gt(0)").prop("checked",true);
			}else{
				$(".role-list input[type='checkbox']:gt(0)").prop("checked",false);
			}
		});
		$(".delete-selected-confirm").click(function(){
			$("#delete-confirm-dialog").modal("hide");
			var cbs=$("input[name='roleIds']:checked")
			if(cbs.length===0){
				showTips("没有选中任意项！");
			}else{
				var roleIds='';
				$.each(cbs,function(i,perm){
					//roleIds+=perm.value;
				});
				//请求删除所选角色
				$.ajax({
					url:"deletemore.html",
					data:{roleIds:roleIds},
					type:"POST",
					traditional:true,
					success:function(){
						cbs.parent().parent().remove();
						showTips("删除所选成功！");
					}
				});
			}
		});
		$(".show-add-form").click(function(){
			resetRoleForm("添加新角色","添加");
			getAllPerms($(".perm-inputs"));
		});
		function getPermsByRoleId(roleId,doSuccess){
			$.ajax({
				url:"showroleperms.html",
				data:{roleId:roleId},
				type:"POST",
				dataType:"json",
				success:function(data){
					doSuccess(data);
				}
			});
		}
		$(".role-list").on("click",".show-role-perms",function(){
			var roleId=$(this).parents("tr").find(".roleid").html();
			var rlTd=$(this).parent();
			//请求查看用户角色
			getPermsByRoleId(roleId,function(data){
				rlTd.html("");
				for(var i in data){
					var role=data[i].permissionDesc+"<br/>";
					rlTd.append(role);
				}
			});
		});
		$(".role-list").on("click",".show-roleinfo-form",function(){
			getAllPerms($(".perm-inputs"));
			resetRoleForm("更新角色信息","更新");
			var roleId=$(this).parents("tr").find(".roleid").html();
			$("input[name='roleId']").val(roleId);
			$.ajax({
				url:"getrole.html",
				data:{roleId:roleId},
				type:"POST",
				dataType:"json",
				success:function(data){
					$("input[name='roleName']").val(data.roleName);
					$("input[name='roleDesc']").val(data.roleDesc);
					$("input[name='roleCode']").val(data.roleCode);
				}
			});
			getPermsByRoleId(roleId,function(data){
				for(var i in data){
					$('.role-form input[name="permIds"][value="'+data[i].permissionId+'"]').prop("checked",true);
				}
			});
		});
		$(".role-submit").click(function(){
			if($(this).html()==="添加"){
				//请求添加新角色
				$.ajax({
					url:"add.html",
					type:"POST",
					data:$(".role-form").serialize(),
					dataType:"json",
					success:function(data){
						$("#role-form-div").modal("hide");
						showTips("添加成功！");
						
						
					}
				});
			}else{
				//更新角色信息
				$.ajax({
					url:"updaterole.html",
					data:$(".role-form").serialize(),
					type:"POST",
					success:function(){
						$("#role-form-div").modal("hide");
						showTips("更新成功！");
					}
				});
			}
		});
		$(".role-list").on("click",".delete-this-role",function(){
			var roleTr=$(this).parents("tr");
			var roleId=roleTr.find(".roleid").html();
			if(confirm('确认删除ID为"'+roleId+'"的角色吗？')){
				//请求删除该用户
				$.ajax({
					url:"delete.html",
					data:{roleId:roleId},
					type:"POST",
					success:function(){
						roleTr.remove();
						showTips("删除成功！");
					}
				});
			}
		}); */
	
		
    </script>
  </body>
</html>
