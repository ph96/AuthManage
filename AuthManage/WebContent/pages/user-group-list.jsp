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

    <title>用户组</title>

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
          <h1 class="page-header">用户组列表</h1>
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
            	<button type="button" class="btn btn-default show-add-form" data-toggle="modal" data-target="#role-form-div">添加用户组</button>
                <!--添加新角色表单-->
                <div class="modal fade " id="role-form-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="role-form-title" >添加用户组</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="add-role-form" method="post">
                          <input type="hidden" name="roleId" class="form-control" id="roleIdInput">
                          <div class="form-group">
                            <label for="roleNameInput">用户组名称</label>
                            <label class="qingkong" id="addRoleNameErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="groupName" class="form-control" id="addRoleNameInput" placeholder="角色名" onkeyup="this.value=this.value.replace(/\s+/g,'')">
                          </div>
                          <div class="form-group">
                            <label for="descInput">用户组描述</label>
                            <label class="qingkong" id="addDescErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="groupDesc" class="form-control" id="addDescInput" placeholder="角色描述" onkeyup="this.value=this.value.replace(/\s+/g,'')">
                          </div>
                          <div class="form-group">
                            <label for="codeInput">用户组代码</label>
                             <label class="qingkong" id="addCodeErrInput" style="margin-left: 200px;"></label>
                            <input type="text" name="groupCode" class="form-control" id="addCodeInput" placeholder="角色代码" onkeyup="this.value=this.value.replace(/\s+/g,'')">
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
                <input type="text" id="groupName" style="margin-left: 625px;margin-top: 1px;height: 31px;" name="groupName"  placeholder="请输入用户组名关键字" value="${FuzzyQueryUserGroup.groupName }">
                <select id="groupState"  style="width: 85px;height: 31px;">
                	<option ${empty FuzzyQueryUserGroup.groupState ?selected:"" } style="display: none;" value="">状态</option>
                	<option value="1" ${FuzzyQueryUserGroup.groupState eq 1?"selected":""}>启用</option>
                	<option value="0" ${(not empty FuzzyQueryUserGroup.groupState and  FuzzyQueryUserGroup.groupState eq 0)?"selected":""}>禁用</option>
                	<option value="99" ${FuzzyQueryUserGroup.groupState eq 99?"selected":""}>全部</option>
                </select>
                <button type="button" class="btn btn-primary show-group-form" >确定查询</button>
            </div>
            <div class="space-div"></div>
            <table class="table table-hover table-bordered group-list">
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
                <c:forEach items="${page.resultList }" var="group">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value="${group.groupId }"/></td>
	                    <td class="groupId">${group.groupId }</td>
	                    <td class="groupName">${group.groupName }</td>
	                    <td class="groupDesc">${group.groupDesc }</td>
	                    <td>${group.groupCode }</td>
	                    <td style="${group.groupState eq 0?'color:red;':'' }">${group.groupState eq 1?"启用":"禁用" }</td>
	                    <!-- <td><a href="javascript:void(0);" class="show-role-perms" >查看所有权限</a></td> -->
	                    <td>
	                    	<a class="glyphicon glyphicon-pencil show-UserGroup-form" aria-hidden="true" title="修改角色信息" href="javascript:void(0);" data-toggle="modal" data-target="#update-role-div"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-group" aria-hidden="true" title="删除角色" href="javascript:void(0);" style="color:red"></a>
	                   		<a href="${pageContext.request.contextPath}/UserGroupManage1/DisableOrEnable.action?groupId=${group.groupId }&groupState=${group.groupState }">
	                    		<button type="button" class="btn btn-warning forbudden" style="width: 72px;padding-left: 6px;" >${group.groupState eq 1?"禁用":"启用" }</button>
	                    	</a>
	                    	<c:if test="${group.groupState eq 1}" > 
		                    	 <button type="button" class="btn btn-primary update-group-roles" style="width: 72px;padding-left: 6px;" data-toggle="modal" data-target="#update-groupRole-dialog">更改角色</button>
	                    	</c:if>
	                    </td>
	                </tr>
                </c:forEach>
            </table>
            <form id="deleteGroupId" action="${pageContext.request.contextPath}/UserGroupManage1/deleteGroup.action" method="post">
            	<input id="groupId" name="groupId" type="text" value="" style="display: none;">
            </form>
            <jsp:include page="group-standard.jsp"/>
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
    <!-- 更新用户组 -->
    <div class="modal fade " id="update-role-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
       <div class="modal-dialog modal-md" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="role-form-title" >更新用户组</h4>
           </div>
           <div class="modal-body">
           	<form class="update-group-form" method="post">
               <input type="hidden" name="roleId" class="form-control" id="roleIdInput">
               <div class="form-group">
                 <label for="roleNameInput">名称</label>
                 <input disabled type="text" name="groupName" class="form-control" id="updategroupNameInput1" >
                 <input type="text" style="display: none;" name="groupName" class="form-control" id="updategroupNameInput">
               </div>
               <div class="form-group">
                 <label for="descInput">描述</label>
                 <label style="margin-left: 200px;" for="updateGroupDescInput" id="updateGroupDescErrInput">描述</label>
                 <input type="text" name="groupDesc" class="form-control" id="updateGroupDescInput" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="角色描述">
               </div>
               <!-- <div class="form-group">
                 <label for="codeInput">代码</label>
                 <input type="text" name="roleCode" class="form-control" id="codeInput" placeholder="角色代码">
               </div> -->
             </form>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
             <button type="button" class="btn btn-primary update-group-submit">提交</button>
           </div>
         </div>
       </div>
     </div>
     <!--修改用户组角色表单-->
      <div class="modal fade " id="update-groupRole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" >修改用户组角色</h4>
                </div>
                <div class="modal-body">
                	<form id="updateGroupRoleForm" class="update-userrole-form" method="post">
                		<div class="form-group">
                  		<label for="updateGroupInput">用户Id</label>
                  		<input id="updateGroupInput" readonly name="groupId" class="form-control groupIdRole" type="text" />
                  	</div>
                  	<div class="form-group">
                       <label for="updateGroupNameInput">用户名</label>
                       <input type="text" name="groupName" readonly value="" class="form-control groupNameRole" id="updateGroupNameInput" >
                   </div>
                   <div class="form-group">
                   	<label >角色 : </label><br/>
                   	<c:forEach items="${Role }" var="role">
                   		<input class="Role" type="checkbox" name="roleId" value="${ role.roleId }" >${ role.roleName}&emsp;&emsp;&emsp;&emsp;
                       </c:forEach>
                       <input style="display: none;" type="text" name="roleIds" value="" class="form-control " id="roleIds" >
                   </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                  <button type="button" class="btn btn-primary update-groupRole-submit">提交 </button>
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
		$(".show-group-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
		});
		function getAllRoles(obj){
			//alert("进入模糊查询");
			var groupName = $("#groupName").val();
			var groupState = $("#groupState").val();
			location.href="${pageContext.request.contextPath}/UserGroupManage1/groupFuzzyQuery.action?groupName="+groupName+"&groupState="+groupState;
		}
//********************************删除角色*******************************************************************************************************************
		//删除角色
		$(".group-list").on("click",".delete-this-group",function(){
			var groupTr=$(this).parents("tr");
			var groupId=groupTr.find(".groupId").html();
			//alert("获取标签tr="+userTr.html());
			if(confirm('确认删除ID为"'+groupId+'"的用户吗？')){
				//请求删除该用户
				//location.href="${pageContext.request.contextPath}/indexUserManage/deleteUser.action?userId="+userid;
				$("#groupId").val(groupId);
				$("#deleteGroupId").submit();
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
		
		var GroupDescPd = false;
			$(".group-list").on("click",".show-UserGroup-form",function(){
					//点击修改用户组清空提示
					$("#updateGroupDescErrInput").html("");
					var groupName=$(this).parents("tr").find(".groupName").html();
					var groupDesc=$(this).parents("tr").find(".groupDesc").html();
					$("#updategroupNameInput1").val(groupName);
					$("#updategroupNameInput").val(groupName);
					$("#updateGroupDescInput").val(groupDesc);
				});
			$(".update-group-submit").mouseup(function(){
				if(GroupDescPd){
					$(".update-group-form").attr("action","${pageContext.request.contextPath}/UserGroupManage1/updateGroup.action");
					$(".update-group-form").submit();
				}else{
					alert("请完善信息!");
				}
			});
		$(function(){
			//用户组描述光标离开事件
			$("#updateGroupDescInput").blur(function(){
				if($(this).val() == "" || $(this).val() == " "){
					$("#updateGroupDescErrInput").css({color:"red"}).html("描述不能为空!");
					GroupDescPd = false;
				}else{
					GroupDescPd = true;
				}
			});
			//用户组描述光标获取事件
			$("#updateGroupDescInput").focus(function(){
				$("#updateGroupDescErrInput").html("");
			});
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
					var groupName=$(this).val();
					$.ajax({
						url:"${pageContext.request.contextPath}/UserGroupManage1/isGroupRedo.action",
						data:{groupName:groupName},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#addRoleNameErrInput").css({color:"green"}).html("组名可用!");
								roleNamePd = true;
								return;
							}else if(data.pd === "N"){
								$("#addRoleNameErrInput").css({color:"red"}).html("组名不可用!");
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
					$("#addDescErrInput").css({color:"red"}).html("组描述不能为空!");
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
					$("#addCodeErrInput").css({color:"red"}).html("组Code不能为空!");
					roleCodePd = false;
					return;
				}else{
					var groupCode=$(this).val();
					$.ajax({
						url:"${pageContext.request.contextPath}/UserGroupManage1/isGroupRedo.action",
						data:{groupCode:groupCode},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#addCodeErrInput").css({color:"green"}).html("组Code可用!");
								roleCodePd = true;
								return;
							}else if(data.pd === "N"){
								$("#addCodeErrInput").css({color:"red"}).html("组Code不可用!");
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
					$(".add-role-form").attr("action","${pageContext.request.contextPath}/UserGroupManage1/addGroup.action");
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
//*******************************更新用户组角色*********************************************************************************
		//获取页面的值 赋值给更新用户组角色弹框
		$(".group-list").on("click",".update-group-roles",function(){
			var groupId = $.trim($(this).parents("tr").find(".groupId").text());
			var groupName = $(this).parents("tr").find(".groupName").html();
			$("#updateGroupRoleForm input[name='groupId']").val(groupId);
			$("#updateGroupRoleForm input[name='groupName']").val(groupName);
			//alert("roles="+$("#updateUserRoleForm .Role").length);
			//请求查看用户角色
			$.ajax({
				url:"${pageContext.request.contextPath}/UserGroupManage1/groupRole.action",
				data:{groupId:groupId},
				type:"POST",
				dataType:"json",
				success:function(data){
					$("#updateGroupRoleForm .Role").removeAttr("checked");
					$.each(data,function(key,value){
						$("#updateGroupRoleForm .Role").each(function(){
							if($(this).val() == value.roleId){
								//$(this).attr("checked","true");不稳定
								$(this)[0].checked = true;
							}
						});
					});
				}
			});
		});
		//更新用户组角色
		//点击提交
		$(function(){
			$(".update-groupRole-submit").click(function(){
				//拼接当前用户角色的id
				var roleId = "";
				//记录没选角色
				var notRoleId = 0;
				$("#updateGroupRoleForm .Role").each(function(){
					console.log($(this)[0].checked);
					if($(this)[0].checked){
						roleId +=$(this).val()+","; 
					}else{
						notRoleId++;
					}
				});
				console.log("roleId="+roleId);
				console.log("notRoleId="+notRoleId);
				if(notRoleId == $("#updateGroupRoleForm .Role").length){
					alert("至少选择一个用户角色! !");
				}else{
					$("#roleIds").val(roleId);
					$("#updateGroupRoleForm").attr("action","${pageContext.request.contextPath}/UserGroupManage1/updateGroupRole.action");
					$("#updateGroupRoleForm").submit();
				}
			});
		});
		
		
		
		
		
//***********************************************************************************************************************************************************************
     
	
		
    </script>
  </body>
</html>
