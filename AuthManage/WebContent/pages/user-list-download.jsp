<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Word只需要把contentType="application/msexcel"改为contentType="application/msword" 
--%>
<%   
  //独立打开excel软件   
  response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//嵌套在ie里打开excel   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.doc");   
%>  
<html>  
<head>  
<title>测试导出Excel和Word</title>  
</head>  
<body>  
<table width="500" border="1" align="center">  
  <tr>  
    <td colspan="4" align="center">用户列表</td>  
  </tr>  
  <tr>
   	   <td><input type="checkbox" class="select-all-btn"/></td>
       <td>用户ID</td>
       <td>用户名</td>
       <td>昵称</td>
       <td>部门</td>
       <td>用户类型</td>
       <td>用户状态</td>
       <td>创建时间</td>
   </tr> 
  <c:forEach items="${fullUser }" var="user">
   	<tr>
   		<td><input type="checkbox" name="userIds" value="${user.userId }"/></td>
   		<td class="userid">${user.userId }</td>
   		<td class="username">${user.userCode }</td>
   		<td>${user.nickName }</td>
   		<td>${user.groupName }</td>
   		<td>${user.roleName }</td>
   		<td style="${user.userState eq 0?'color:red;':'' }">${user.userState eq 0?"禁用":"启用" }</td>
   		<td><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
   	</tr>
   </c:forEach>  
</table>  
</body>  
</html>  
