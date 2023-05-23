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
	<!-- 메인메뉴 (가로) -->
	<div>
		<jsp:include page="/mainnavi.jsp"></jsp:include>
	</div>
	<%
		if(session.getAttribute("loginMemberId")==null){
	%>
		<div class="row">
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
			<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
			<br><br><br><br><br><br><br><br><br>
				<h3>로그인</h3>
				<table class="table">
					<tr>
						<th>아이디</th>
						<td><input class="form-control" type ="text" name="memberId" required="required"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input class="form-control" type ="password" name="memberPw" required="required"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button style="float:right;" class="btn btn-secondary" type="submit">로그인</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="col-sm-4"></div>
		</div>
	<%
		}else{
			response.sendRedirect(request.getContextPath()+"/boardList.jsp");
		}
	%>
</body>
</html>