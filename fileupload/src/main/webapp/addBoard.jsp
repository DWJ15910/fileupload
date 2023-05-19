<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String memberId = (String)session.getAttribute("loginMemberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add board</title>
<style type="text/css">
	table, th, td {
		border: 1px solid #FF0000;
	}
</style>
</head>
<body>
	<h1>자료 업로드</h1>
	<form action="<%=request.getContextPath() %>/addBoardAction.jsp" method="post" enctype="multipart/form-data">
		<table>
			<!-- 자료 업로드 제목글 -->
			<tr>
				<th>boardTitle</th>
				<td>
					<!-- required 는 자바스크립트 안쓸때만 사용할 예정 -->
					<!-- submit으로 자료를 보내려는대 자료값을 입력하지 않으면 보내지지 않도록 설정 -->
					<textarea rows="3" cols="50" name="boardTitle" required="required"></textarea>
				</td>
			</tr>
			
			<!-- 로그인 사용자 ID -->
			<tr>
				<th>memberId</th>
				<td>
					<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
				</td>
			</tr>
			
			<!-- 자료 업로드 -->
			<tr>
				<th>boardFile</th>
				<td>
					<input type="file" name="boardFile" required="required">
				</td>
			</tr>
		</table>
		<button type="submit">자료업로드</button>
	</form>
</body>
</html>