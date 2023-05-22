<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%
		if(session.getAttribute("loginMemberId")==null){
	%>
			<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
				<table>
					<tr>
						<th>아이디</th>
						<td><input type ="text" name="memberId" required="required"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type ="password" name="memberPw" required="required"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit">로그인</button>
						</td>
					</tr>
				</table>
			</form>
	<%
		}else{
			response.sendRedirect(request.getContextPath()+"/boardList.jsp");
		}
	%>
</body>
</html>