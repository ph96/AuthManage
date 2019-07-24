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
    var Id;
       var setting = {    
        
        	check:{
               enable:true,
               chkStyle: "radio",  //单选框
               radioType: "all"   //对所有节点设置单选
            },   
            
            /* check:{//使用复选框
                enable:true  
            }, */ 
            data: {
                simpleData:{//是否使用简单数据模式
                    enable:true
                }
            },
            callback:{
                onCheck:onCheck
            },
            view:{
            	fontCss:setFontCss
            }
        };
         //id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中        
        var zNodes = ${authJson}; 

        function setFontCss(treeId, treeNode){
        	return treeNode.state == "0"?{color:"gray"}:{};
        }
        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
//**************************************提示信息*********************************************************
        $(function(){
        	if(${null == identify}){
        		//showTips("请选择一个节点,方可操作! !");
        	}else if(${identify == 1}){
        		showTips("删除失败! !");
        	}else if(${identify == 2}){
        		showTips("删除成功! !");
        	}else if(${identify == 3}){
        		showTips("恢复失败! !");
        	}else if(${identify == 4}){
        		showTips("恢复成功! !");
        	}else if(${identify == 5}){
        		showTips("更新失败! !");
        	}else if(${identify == 6}){
        		showTips("更新成功! !");
        	}else if(${identify == 7}){
        		showTips("添加失败! !");
        	}else if(${identify == 8}){
        		showTips("添加成功! !");
        	}
        });
    	function showTips(content){
       		$("#op-tips-content").html(content);
			$("#op-tips-dialog").modal("show");
       	}    
//***************************选中复选框后触发事件***************************************************************
        //选中复选框后触发事件
        function onCheck(e,treeId,treeNode){
        	var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
        	nodes=treeObj.getCheckedNodes(true),
        	nodes1=treeObj.getCheckedNodes(false),//点击取消redio消失
        	v="";//authId
        	for(var i=0;i<nodes1.length;i++){//点击取消redio消失
        		$(".xiugai").css({display:"none"});
        		$(".shanchu").css({display:"none"});
        		$(".huifu").css({display:"none"});
        	}
        	//获取选中的复选框的值
        	for(var i=0;i<nodes.length;i++){
        		v+=nodes[i].id;
        		//alert("等级为="+nodes[i].level);
        		//alert("选择的id为="+nodes[i].id); //获取选中节点的值
        		//alert("选择的pId为="+nodes[i].pId+"  权限等级="+nodes[i].level);
        		/* $("#authIdInput").val(v); */
        		$(".xiugai").css({display:"none"});
        		$(".shanchu").css({display:"none"});
        		$(".huifu").css({display:"none"});
        		//$(".tianjia").css({display:"none"});
        		//alert("state="+nodes[i].state);
        		if(nodes[i].state == "0"){
        			$(".xiugai").css({display:""});
        			$(".huifu").css({display:""});
        			$(".tianjia").css({display:""});
        		}else if(nodes[i].state == "1"){
        			$(".xiugai").css({display:""});
        			$(".shanchu").css({display:""});
        			$(".tianjia").css({display:""});
        		}
        		//点击我的所谓二级权限不让弹框和不让添加
        		/* if(nodes[i].level == 2){
        			$(".tianjia").attr("data-target","");
        		}else{
        			$(".tianjia").attr("data-target","#role-form-div");
        		} */
        	}
        	Id=v;
       	 	//alert(v);
        }
//*****************************添加权限  *********************************************************************       
	//权限名成功还是失败
	var addAuthNamePd = false;
	//权限描述是否为空
	var addAuthDescPd = false;
	//权限url成功还是失败
	var addAuthUrlPd = false;
	//权限Code成功还是失败
	var addAuthCodePd = false;
	
	$(function(){
		//点击添加按钮
		$(".tianjia").click(function(){
			var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
        	nodes=treeObj.getCheckedNodes(true),
        	v="";
			//清除添加form表单的内容
			$(".add-form input").val("");
			$(".qingkong").html("");
			//alert("清空form表单");
			//禁用下拉列表显示该显示的
			$("#authType option").attr("disabled", "");
			
			//[0].setAttribute("disabled", "");
			$("#authType option").removeAttr("selected");
			//[0].removeAttribute("selected");
			//$("#authGrade option").attr("disabled", "");
			//[0].setAttribute("disabled", "");
			//$("#authGrade option")
			//[0].removeAttribute("selected");
			$(".authUrl").css("display", "none");
			$(".authCode").css("display", "none");
			
			if(nodes.length == 0){
				$("#authType option[value='1']").removeAttr("disabled");
				$("#authType option[value='1']")[0].setAttribute("selected", "");
				//$("#authGrade option[value='1']").removeAttr("disabled");
				/*
    			//alert("等级为1")
    			$("#authType option[value='1']")[0].setAttribute("selected", "");
    			$("#authType option[value='1']")[0].removeAttribute("disabled");
    			$("#authGrade option[value='1']")[0].setAttribute("selected", "");
    			$("#authGrade option[value='1']")[0].removeAttribute("disabled"); */
    		}else{
				v=nodes[0].id;
				//alert("等级="+nodes[0].level)
        		if(nodes[0].level == "0"){
        			//alert("等级为2,给一级权限添加子权限")
        			$("#authType option[value='1']").attr("disabled","");
        			$("#authType option[value='2']").removeAttr("disabled");
					$("#authType option[value='2']")[0].setAttribute("selected", "");
        			/* $("#authType option[value='2']")[0].setAttribute("selected", "");
	    			$("#authType option[value='2']")[0].removeAttribute("disabled");
	    			$("#authGrade option[value='2']")[0].setAttribute("selected", "");
	    			$("#authGrade option[value='2']")[0].removeAttribute("disabled"); */
	    			$(".authUrl").css("display", "");
        		}else if(nodes[0].level == "1"){
        			//alert("等级为3,给二级权限添加子权限")
        			$("#authType option[value='1']").attr("disabled","");
        			$("#authType option[value='2']").attr("disabled","");
        			$("#authType option[value='3']").removeAttr("disabled");
        			$("#authType option[value='3']")[0].setAttribute("selected", "");
        			//.attr("selected", "");
        			/* $("#authType option[value='3']")[0].setAttribute("selected", "");
	    			$("#authType option[value='3']")[0].removeAttribute("disabled");
	    			$("#authGrade option[value='3']")[0].setAttribute("selected", "");
	    			$("#authGrade option[value='3']")[0].removeAttribute("disabled"); */
	    			$(".authUrl").css("display", "");
        			$(".authCode").css("display", "");
        		}else if(nodes[0].level == "2"){
        			alert("您正在添加同级权限");
        			//alert("等级为3,给三级权限添加平级权限")
        			$("#authType option[value='1']").attr("disabled","");
        			$("#authType option[value='2']").attr("disabled","");
        			$("#authType option[value='3']").removeAttr("disabled");
        			//$("#authType option[value='3']").removeAttr("selected");
        			$("#authType option[value='3']")[0].setAttribute("selected", "selected");
        			//$("#authType option[value='3']").attr("selected", "");
        			/* $("#authType option[value='3']")[0].setAttribute("selected", "");
	    			$("#authType option[value='3']")[0].removeAttribute("disabled");
	    			$("#authGrade option[value='3']")[0].setAttribute("selected", "");
	    			$("#authGrade option[value='3']")[0].removeAttribute("disabled"); */
	    			$(".authUrl").css("display", "");
        			$(".authCode").css("display", "");
        			//点击我的所谓二级权限不让弹框和不让添加
        			//alert("不能添加权限");
        		}
    		}	
			
		});
		$("#authNameInput1").focus(function(){//鼠标获取清空提示
			$("#addAuthNameErrInput").html("");
		});
		//判断权限名是否重复
		$("#authNameInput1").blur(function(){
			if($(this).val() == ""){
				$("#addAuthNameErrInput").css({color:"red"}).html("权限名不能为空!");
				addAuthNamePd = false;
				return;
			}else{
				var authName = $(this).val();
				//alert("传的参数为="+authName);
				$.ajax({
					url:"${pageContext.request.contextPath}/AuthManage1/isAuthName.action",
					data:{authName:authName},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.pd === "Y") {
							$("#addAuthNameErrInput").css({color:"green"}).html("权限名可用!");
							addAuthNamePd = true;
							return;
						}else if(data.pd === "N"){
							$("#addAuthNameErrInput").css({color:"red"}).html("权限名不可用!");
							addAuthNamePd = false;
							return;
						}
					},
					error: function(data){
						console.log("服务器异常");
						addAuthNamePd = false;
					}
				});
			}
		});
		$("#addDescInput1").focus(function(){//鼠标获取清空提示
			$("#addAuthDescErrInput").html("");
		});
		//判断权限描述是否为空
		$("#addDescInput1").blur(function(){
			if($(this).val() == ""){
				$("#addAuthDescErrInput").css({color:"red"}).html("权限描述不能为空!");
				addAuthDescPd = false;
			}else{
				addAuthDescPd = true;
			}
		});
		$("#addUrlInput1").focus(function(){//鼠标获取清空提示
			$("#addAuthUrlErrInput").html("");
		});
		//判断权限URL是否重复
		$("#addUrlInput1").blur(function(){
			if($(this).val() == ""){
				$("#addAuthUrlErrInput").css({color:"red"}).html("权限Url不能为空!");
				addAuthUrlPd = false;
				return;
			}else{
				var authUrl = $(this).val();
				//alert("传的参数为="+authUrl);
				$.ajax({
					url:"${pageContext.request.contextPath}/AuthManage1/isAuthName.action",
					data:{authUrl:authUrl},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.pd === "Y") {
							$("#addAuthUrlErrInput").css({color:"green"}).html("权限Url可用!");
							addAuthUrlPd = true;
							return;
						}else if(data.pd === "N"){
							$("#addAuthUrlErrInput").css({color:"red"}).html("权限Url不可用!");
							addAuthUrlPd = false;
							return;
						}
					},
					error: function(data){
						console.log("服务器异常");
						addAuthUrlPd = false;
					}
				});
			}
		});
		$("#addCodeInput1").focus(function(){//鼠标获取清空提示
			$("#addAuthCodeErrInput").html("");
		});
		//判断权限Code是否重复
		$("#addCodeInput1").blur(function(){
			if($(this).val() == ""){
				$("#addAuthCodeErrInput").css({color:"red"}).html("权限Code不能为空!");
				addAuthCodePd = false;
				return;
			}else{
				var authCode = $(this).val();
				//alert("传的参数为="+authCode);
				$.ajax({
					url:"${pageContext.request.contextPath}/AuthManage1/isAuthName.action",
					data:{authCode:authCode},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.pd === "Y") {
							$("#addAuthCodeErrInput").css({color:"green"}).html("权限Code可用!");
							addAuthCodePd = true;
							return;
						}else if(data.pd === "N"){
							$("#addAuthCodeErrInput").css({color:"red"}).html("权限Code不可用!");
							addAuthCodePd = false;
							return;
						}
					},
					error: function(data){
						console.log("服务器异常");
						addAuthCodePd = false;
					}
				});
			}
		});
		
		
		
		
		
		
		
	});
	//请求添加权限        
	 function addAuth1(){ 
	 		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true);
	 		if(nodes.length == 0){
	 			$("#authNameInput1").blur();
      			$("#addDescInput1").blur();
      			//alert("运行完成事件");
      			if(addAuthNamePd && addAuthDescPd){
      				//alert("进入给0级后台验证");
      				$("#addAuthTypeInput").val("1");//类型Type
      				$(".add-form").attr("action","${pageContext.request.contextPath}/AuthManage1/addAuth.action");
      				$(".add-form").submit();
      			}else{
					alert("请正确填写");
	 			}
	 		}else{ 
	 			//alert("当前等级为:"+nodes[0].level+"级");
	 			if(nodes[0].level == "0"){
	 				//alert("给1及权限添加");
	 				$("#authNameInput1").blur();
	      			$("#addDescInput1").blur();
	      			$("#addUrlInput1").blur();
	      			if(addAuthNamePd && addAuthDescPd && addAuthUrlPd){
	      				var authPid=nodes[0].id;
	      				//alert("进入给1及后台验证 Pid为当前id="+authPid);
	      				$("#addParentIdInput").val(authPid);//父id
	      				$("#addAuthTypeInput").val("2");//类型Type
	      				$(".add-form").attr("action","${pageContext.request.contextPath}/AuthManage1/addAuth.action");
	      				$(".add-form").submit();
	      			}else{
						alert("请正确填写");
		 			}
	 			}else if(nodes[0].level == "1"){
	 				//alert("给2及权限添加");
	 				$("#authNameInput1").blur();
	      			$("#addDescInput1").blur();
	      			$("#addUrlInput1").blur();
	      			$("#addCodeInput1").blur();
	      			if(addAuthNamePd && addAuthDescPd && addAuthUrlPd && addAuthCodePd){
	      				var authPid=nodes[0].id;
	      				//alert("进入给2及后台验证 Pid为当前id="+authPid);
	      				$("#addParentIdInput").val(authPid);//父id
	      				$("#addAuthTypeInput").val("3");//类型Type
	      				$(".add-form").attr("action","${pageContext.request.contextPath}/AuthManage1/addAuth.action");
	      				$(".add-form").submit();
	      			}else{
						alert("请正确填写");
		 			}
	 			}else if(nodes[0].level=="2"){
	 				//alert("给2及权限添加3");
	 				$("#authNameInput1").blur();
	      			$("#addDescInput1").blur()
	      			$("#addUrlInput1").blur();
	      			$("#addCodeInput1").blur();
	      			//alert("addAuthNamePd="+addAuthNamePd+"addAuthDescPd="+addAuthDescPd+"addauthUrlPd="+addAuthUrlPd+"addAuthCodePd="+addAuthCodePd);
	      			if(addAuthNamePd && addAuthDescPd && addAuthUrlPd && addAuthCodePd){
	      				var authPid=nodes[0].pId;
	      				//无限极
	      				//var authPid=nodes[0].Id;
	      				//alert("进入给3及后台验证 Pid为父id="+authPid);
	      				$("#addParentIdInput").val(authPid);//父id
	      				$("#addAuthTypeInput").val("3");//类型Type
	      				$(".add-form").attr("action","${pageContext.request.contextPath}/AuthManage1/addAuth.action");
	      				$(".add-form").submit();
	      			}else{
						alert("请正确填写");
		 			}
	 			}
			}
		}
			
//******************************修改权限***************************************************************************			 
		function updateClick(){
			var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
        	nodes=treeObj.getCheckedNodes(true),
        	v=""; 
			for(var i=0;i<nodes.length;i++){
        		v+=nodes[i].id;
        		//alert(nodes[i].id); //获取选中节点的值
        		/* $("#authIdInput").val(v); */
        	}
			if(v != ""){
		 		var authName="";//权限名
		 		var authDesc="";//权限描述
				for(var i=0;i<nodes.length;i++){
		       		v=nodes[i].id;
		       		//alert("选中id="+v);
		       		authName=nodes[i].name;
		       		//alert("选中name="+authName);
		       		authDesc=nodes[i].desc;
		       		//alert("选中描述="+authDesc);
		       		//alert(nodes[i].id); //获取选中节点的值
		       		/* $("#authIdInput").val(v); */
		       	}
				var id=$("#authIdInput").val(v);
		       	var an=$("#authNameInput").val(authName);
		 		var ad=$("#descInput").val(authDesc);
		 		$("#updateAuthDescErrInput").html("");
		 		$("#updateAuthNameErrInput").html("");
			}else{
				alert("请选择要修改的权限");
			}
		}
		var authNamePd=false;//判断权限名是否正确
		var authDescPd=false;//判断权限描述是否正确
		$(function(){
			//判断权限名是否正确
			$("#authNameInput").blur(function(){
				//alert("进入判断权限名是否正确");
				if($(this).val() == ""){
					$("#updateAuthNameErrInput").css({color:"red"}).html("权限名不能为空!");
					authNamePd=false;
					return;
				}else {
					var authName = $(this).val();
					//alert("传的参数为="+authName);
					$.ajax({
						url:"${pageContext.request.contextPath}/AuthManage1/isAuthName.action",
						data:{authName:authName},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#updateAuthNameErrInput").css({color:"green"}).html("权限名可用!");
								authNamePd=true;
							}else if(data.pd === "N"){
								$("#updateAuthNameErrInput").css({color:"red"}).html("权限名不可用!");
								authNamePd=false;
							}
						},
						error: function(data){
							console.log("服务器异常");
							authNamePd=false;
						}
					});
				}
				
			});
			$("#authNameInput").focus(function(){
				$("#updateAuthNameErrInput").html("");
			});
			//判断权限描述是否正确
			$("#descInput").blur(function(){
				if($(this).val() == ""){
					$("#updateAuthDescErrInput").css({color:"red"}).html("权限描述不能为空!");
					authDescPd=false;
					return;
				}else{
					authDescPd=true;
				}
			});
			$("#descInput").focus(function(){
				$("#updateAuthDescErrInput").html("");
			});
			
		});
		//点击提交执行的方法
		function updateAuth(){
			var authId=$("#authIdInput").val();
			$("#authIdInputCh").val($("#authIdInput").val());
      		if(!!authId){
      			//alert("将修改的值传入后台");
      			$("#descInput").blur();
      			$("#authNameInput").blur();
				if(authNamePd && authDescPd){
					$(".update-form").attr("action","${pageContext.request.contextPath}/AuthManage1/updateAuth.action");
					$(".update-form").submit();
				}else{
					showTips("请完善信息! !");
				}
		    }else{
		    	alert("请选择要修改的权限");
		    } 
		}
//******************************删除权限***************************************************************************		
		/* $(".delete-auth-submit").click(function(){ */
		 function deleteAuth(){
      		var authId =Id;
      		//alert("获取要删除的authId="+Id);
      		if(!!authId){
      			$("#input1").val(authId);
      			$("#fromBd").attr("action","${pageContext.request.contextPath}/AuthManage1/deleteAuth.action");
      			$("#fromBd").submit();
		    }else{
		    	alert("请选择要删除的权限");
		    }
  		}
//******************************恢复权限***************************************************************************		
  		/*恢复权限
  		 */
  	function reinAuth(){
		var authId =Id;
		//alert("恢复的id="+authId);
      	if(!!authId){
     		$("#input1").val(authId);
 			$("#fromBd").attr("action","${pageContext.request.contextPath}/AuthManage1/recoverAuth.action");
 			$("#fromBd").submit();
	    }else{
	    	alert("请选择要恢复的权限");
	    }
	}
  		
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
				<h1 class="page-header">权限列表</h1>
				<div class="row placeholders">
					<!--添加权限表单 start-->
					<div>
						<button type="button" class="btn btn-default show-add-form tianjia"
							data-toggle="modal" data-target="#role-form-div"
							style="width: 100px;">添加权限
						</button>
						<button type="button" class="btn btn-default xiugai show-add-form" 
							style="width:100px;display: none;"data-toggle="modal" onclick="updateClick()"
							data-target="#update-auth-form-div">修改权限
						</button>
						<button type="button" style="width:100px;display: none;" 
							class="btn btn-primary huifu" onclick="reinAuth()">恢复权限
						</button>
						<button type="button" style="width:100px;display: none;" 
							class="btn btn-primary shanchu" onclick="deleteAuth()">删除权限
						</button>
						<form id="fromBd" method="post">
							<input id="input1" name="input1" style="display: none;">
						</form>	
						
							
						<!-- 更新权限 -->
						<div class="modal fade " id="update-auth-form-div" tabindex="-1"
							role="dialog" aria-labelledby="mySmallModalLabel">
							<div class="modal-dialog modal-md" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="role-form-title">更新权限</h4>
									</div>
									<div class="modal-body">
										<form class="update-form" method="Post">
											<div class="form-group">
												<label for="authIdInput">权限id</label> 
												<input type="text" name="authId" disabled="disabled" 
												class="form-control" id="authIdInput">
												<input type="text" name="authId" style="display: none;" 
												class="form-control" id="authIdInputCh">
												
											</div>
											<!-- <input type="text" name="authId" class="form-control" id="authIdInput"> -->
											<div class="form-group">
												<label for="authNameInput">名称</label>
												<label class="" style="margin-left: 100px;" id="updateAuthNameErrInput"></label> 
												<input type="text" name="authName" class="form-control" 
													id="authNameInput" placeholder="要修改的权限名称" onkeyup="this.value=this.value.replace(/\s+/g,'')">
											</div>
											<div class="form-group">
												<label for="descInput">权限描述</label>
												<label class="" style="margin-left: 100px;" id="updateAuthDescErrInput"></label> 
												<input type="text" name="authDesc" class="form-control" 
													id="descInput" placeholder="要修改的权限描述" onkeyup="this.value=this.value.replace(/\s+/g,'')">
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">取消</button>
										<button type="button" class="btn btn-primary role-submit"
											id="checkon" onclick="updateAuth()">提交</button>
									</div>
								</div>
							</div>
						</div>
						<!-- 恢复权限 -->
						<%-- <div class="modal fade " id="rein-auth-form-div" tabindex="-1"role="dialog" aria-labelledby="mySmallModalLabel">
							<div class="modal-dialog modal-md" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="role-form-title">恢复权限</h4>
									</div>
									<div class="modal-body">
										<c:forEach items="${auth0}" var="auth0">
										<div><input type="checkbox" name="authId" value="${auth0.authId}"/>${auth0.authName}</div>
										</c:forEach>
										<button type="button" style="width:100px;" class="btn btn-primary" data-dismiss="modal" class="btn btn-default">取消</button>
										<button type="button" style="width:100px;" class="btn btn-primary" onclick="reinAuth()">提交</button>
									</div>
								</div>
							</div>
						</div> --%>
						
				</div>
				<!-- 添加权限 -->
				<div class="modal fade " id="role-form-div" tabindex="-1"
					role="dialog" aria-labelledby="mySmallModalLabel">
					<div class="modal-dialog modal-md" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="role-form-title">添加权限</h4>
							</div>
							<div class="modal-body">
								<form class="add-form" method="post">
									<!-- <input type="text" name="authId" class="form-control" id="authIdInput"> -->
									<div class="form-group">
										<label for="authNameInput1">名称</label> 
										<label class="qingkong" style="margin-left: 100px;" id="addAuthNameErrInput"></label> 
										<!-- 权限id -->
										<input type="text" name="authId"  id="addAuthIdInput" style="display: none;">
										<!-- 权限父id -->
										<input type="text" name="parentId"  id="addParentIdInput" style="display: none;">
										<input type="text" name="authName" class="form-control" 
											id="authNameInput1" placeholder="权限名称" onkeyup="this.value=this.value.replace(/\s+/g,'')">
									</div>
									<div class="form-group authCode" style="display: none;">
										<label for="codeInput1">权限code</label> 
										<label class="qingkong" style="margin-left: 100px;" id="addAuthCodeErrInput"></label> 
										<input type="text" name="authCode" class="form-control"
											id="addCodeInput1" placeholder="权限代码" onkeyup="this.value=this.value.replace(/\s+/g,'')">
									</div>
									<div class="form-group">
										<label for="descInput1">权限描述</label> 
										<label class="qingkong" style="margin-left: 100px;" id="addAuthDescErrInput"></label> 
										<input type="text" name="authDesc" class="form-control" 
											id="addDescInput1" placeholder="权限描述" onkeyup="this.value=this.value.replace(/\s+/g,'')">
										<!-- 权限Type -->
										<input type="text" name="authType"  id="addAuthTypeInput" style="display: none;">
									</div>
									<div class="form-group authUrl" style="display: none;">
										<label for="descInput1">权限url</label> 
										<label class="qingkong" style="margin-left: 100px;" id="addAuthUrlErrInput"></label> 
										<input type="text" name="authUrl" class="form-control" 
											id="addUrlInput1" placeholder="权限url" onkeyup="this.value=this.value.replace(/\s+/g,'')">
									</div>
									<!-- <div class="form-group" >
										<label for="descInput1">权限等级</label> 
										<select class="form-control" id="authGrade" name="authGrade">
											<option disabled value="1">一级权限</option>
											<option disabled value="2">二级权限</option>
											<option disabled value="3">三级权限</option>
										</select>
									</div> -->
									<div class="form-group" >
										<label for="descInput1">权限类型</label> 
										<select id="authType" >
											<option disabled value="1">模块</option>
											<option disabled value="2">列表</option>
											<option disabled value="3">按钮</option>
										</select>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">取消</button>
								<button type="button" class="btn btn-primary role-submit"
									id="checkon" onmouseup="addAuth1()">提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>
					
					<!--添加权限表单 end-->
					<div class="space-div"></div>

					<div class="zTreeDemoBackground left">
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

	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

</body>
</html>
