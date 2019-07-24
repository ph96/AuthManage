<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Wordֻ��Ҫ��contentType="application/msexcel"��ΪcontentType="application/msword" 
--%>
<%   
  //������excel���   
  response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//Ƕ����ie���excel   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.doc");   
%>  
<html>  
<head>  
<title>���Ե���Excel��Word</title>  
</head>  
<body>  
<table width="500" border="1" align="center">  
  <tr>  
    <td colspan="4" align="center">�û��б�</td>  
  </tr>  
  <tr>
   	   <td><input type="checkbox" class="select-all-btn"/></td>
       <td>�û�ID</td>
       <td>�û���</td>
       <td>�ǳ�</td>
       <td>����</td>
       <td>�û�����</td>
       <td>�û�״̬</td>
       <td>����ʱ��</td>
   </tr> 
  <c:forEach items="${fullUser }" var="user">
   	<tr>
   		<td><input type="checkbox" name="userIds" value="${user.userId }"/></td>
   		<td class="userid">${user.userId }</td>
   		<td class="username">${user.userCode }</td>
   		<td>${user.nickName }</td>
   		<td>${user.groupName }</td>
   		<td>${user.roleName }</td>
   		<td style="${user.userState eq 0?'color:red;':'' }">${user.userState eq 0?"����":"����" }</td>
   		<td><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
   	</tr>
   </c:forEach>  
</table>  
</body>  
</html>  
