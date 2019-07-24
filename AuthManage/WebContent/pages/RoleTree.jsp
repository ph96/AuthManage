<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>权限管理 - 权限列表</title>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/demo.css"
	type="text/css">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript">

       var setting = {    
        
        	/*    check:{
               enable:true,
               chkStyle: "radio",  //单选框
               radioType: "all"   //对所有节点设置单选
            },   */
            
               check:{//使用复选框
                enable:true
            },  
            data: {
                simpleData:{//是否使用简单数据模式
                    enable:true
                }
            },
            callback:{
                onCheck:onCheck
            }           
        };
         //id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中        
        var zNodes = ${roleAuth}
        	/* [
            { id:1, pId:0, name:"随意勾选 1", open:false,checked:true},
            { id:11, pId:1, name:"随意勾选 1-1", open:true},
            { id:111, pId:11, name:"随意勾选 1-1-1"},
            { id:112, pId:11, name:"随意勾选 1-1-2",checked:true},
            { id:12, pId:1, name:"随意勾选 1-2", open:true},
            { id:121, pId:12, name:"随意勾选 1-2-1"},
            { id:122, pId:12, name:"随意勾选 1-2-2"},
            { id:2, pId:0, name:"随意勾选 2",  open:false},
            { id:21, pId:2, name:"随意勾选 2-1"},
            { id:22, pId:2, name:"随意勾选 2-2", open:true},
            { id:221, pId:22, name:"随意勾选 2-2-1"},
            { id:222, pId:22, name:"随意勾选 2-2-2"},
            { id:23, pId:2, name:"随意勾选 2-13"}
        ]; */

        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
            
            
//请求添加权限        
	 /* function addAuth1(){ 
	 		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true),
            	v="";       
 			for(var i=0;i<nodes.length;i++){
            		v+=nodes[i].id;
            		//alert(nodes[i].id); //获取选中节点的值
            		// $("#authIdInput").val(v); /
            	}
			var an=$("#authNameInput1").val();
      		var ac=$("#codeInput1").val();
      		var ad=$("#descInput1").val();
      		var au=$("#authUrlInput").val();	
      		var af=v;
      		if(!af){ 
      			af="0";
      		}
      		alert(an+ac+ad+af);
      		
      		if(!!an&&!!ac&&!!ad&&!!af){
				$.ajax({
					url:"${pageContext.request.contextPath}/auth/insertAuth.action",
					dataType:"json",
					type:"POST",
					data:{
					authName:an,
					authCode:ac,
					authDesc:ad,
					authFaId:af,
					},
					success:function(data){
						if(data.isexist=='1'){
						alert("添加成功！");
					   window.location.href="${pageContext.request.contextPath}/auth/authtree.action";						
						}
					    if(data.isexist=='0'){
						alert("此类权限已经存在");
						window.location.href="${pageContext.request.contextPath}/auth/authtree.action";
						}
					},
					error:function(){ 
					alert("执行异常");
						window.location.href="${pageContext.request.contextPath}/auth/authtree.action"; 
                		},
					});
				}else{ 
				alert("请正确填写");
				}
			} */
			
			 
		
		/* $(".delete-auth-submit").click(function(){ */
		 /* function deleteAuth(){
      		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true),
            	v="";       
 			for(var i=0;i<nodes.length;i++){
            		v+=nodes[i].id;
            		//alert(nodes[i].id); //获取选中节点的值
            		// $("#authIdInput").val(v);
            	}	
      		var authId =v;
      		if(!!authId){
				$.ajax({
					url:"${pageContext.request.contextPath}/auth/deleteAuth.action",
					type:"POST",
					data:{
					authId:authId,
					},
					success:function(){
						alert("删除成功！");
					    window.location.href="${pageContext.request.contextPath}/auth/authtree.action";						
						
					},
					error:function(){ 
					alert("执行异常");
					window.location.href="${pageContext.request.contextPath}/auth/authtree.action"; 
                		},
					});
		    }else{
		    	alert("请选择要删除的权限");
		    }
  		} */
  		/*恢复权限
  		 */
  	/* function reinAuth(){
      	var authId=document.getElementsByName("authId");
      	var authIds="";
			for(var i=0;i<authId.length;i++){
				if(authId[i].checked){
					if(i!=authId.length-1){
						authIds+=authId[i].value+",";
					}else if(i=authId.length-1){
						authIds+=authId[i].value;
					}
				}
			}
			alert(authIds);
      	if(!!authIds){
			$.ajax({
				url:"${pageContext.request.contextPath}/auth/reinAuth.action",
				type:"POST",
				data:{
				authIds:authIds,
				},
				success:function(){
					alert("恢复成功");
					window.location.href="${pageContext.request.contextPath}/auth/authtree.action";		
				},
					});
		    }else{
		    	alert("请选择要删除的权限");
		    }
  		} */
//****************************更新用户权限*******************************************************************************		
	  	//选中复选框后触发事件
	    function onCheck(e,treeId,treeNode){
	    	var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
	    	nodes=treeObj.getCheckedNodes(true),
	    	v="";
	    	//获取选中的复选框的值
	    	for(var i=0;i<nodes.length;i++){
	    		v+=nodes[i].id+",";
	    		//alert(nodes[i].id); //获取选中节点的值
	    		/* $("#authIdInput").val(v); */
	    	}
	   	 	//alert(v);
	    } 
    	
    	function updateAuth(){
      		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true),
            	v="";       
 			for(var i=0;i<nodes.length;i++){
            		v+=nodes[i].id+",";
            		//alert(nodes[i].id); //获取选中节点的值
            		/* $("#authIdInput").val(v); */
            	}
            var userId=$("#userId").val();
      		var authIds = v;
      		if(!!authIds){
      			$("#authIds").val(authIds);
      			$("#authForm").attr("action","${pageContext.request.contextPath}/RoleManage1/roleAuth.action");
      			$("#authForm").submit();
		    }else{
		    	alert("请选择要修改的权限");
		    } 
		}
		
    	$(function(){$(".btn-primary").click(function(){
    			updateAuth();
    		});
    	});
    
    
    
    </script>
</head>

<body>
	<c:if test="${empty USER }">
		<c:redirect url="/pages/login.jsp"></c:redirect>
	</c:if>
	<!-- 头部 -->
	<jsp:include page="header.jsp" />

	<div class="container-fluid" style="margin-top: 30px;">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="navibar.jsp" />
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">用户${USER.userCode }权限列表</h1>
				<div class="row placeholders">
					<!--添加权限表单 start-->
					<div>
						<button type="button" style="width:100px;margin-left: 15px;" class="btn btn-primary">确认修改</button>
						<a href="${pageContext.request.contextPath}/RoleManage1/fullRoles.action">
							<button type="button" class="btn btn-default" style="width:100px;">取消</button>
						</a>
						<form id="authForm" method="post">
							<input style="display: none;" id="roleId" name="roleId" value="${roleId }">
							<input style="display: none;" id="authIds" name="authIds">
						</form>
					</div>
				</div>
				<div class="zTreeDemoBackground left" style="margin-top: -21px;">
					<ul id="treeDemo" class="ztree" style="width:1024px;"></ul>
				</div>
				<div class="space-div"></div>
															
			</div>
			</div>
		</div>
	<!-- </div> -->
	

	<!-- 提示框 -->
	<!-- <div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提示信息</h4>
				</div>
				<div class="modal-body" id="op-tips-content"></div>
			</div>
		</div>
	</div> -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

</body>
</html>
