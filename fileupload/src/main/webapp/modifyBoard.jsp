<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int boardFileNo = Integer.parseInt(request.getParameter("boardFileNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/fileupload","root","java1234");
	String sql = "SELECT b.board_no boardNo, b.board_title boardTitle, f.board_file_no boardFileNo, f.origin_filename originFilename FROM board b INNER JOIN board_file f ON b.board_no = f.board_no WHERE b.board_no=? AND f.board_file_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	stmt.setInt(2, boardFileNo);
	ResultSet rs = stmt.executeQuery();
	HashMap<String, Object> map = null;
	if(rs.next()) {
		map = new HashMap<>();
		map.put("boardNo", rs.getInt("boardNo"));
		map.put("boardTitle", rs.getString("boardTitle"));
		map.put("boardFileNo", rs.getInt("boardFileNo"));
		map.put("originFilename", rs.getString("originFilename"));
	}
%>
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
	<div class="container">
	<br>
	<h1>수정페이지</h1>
	<hr>
		<form action="<%=request.getContextPath()%>/modifyBoardAction.jsp" method="post" enctype="multipart/form-data">
			<!-- 히든으로 넘어갈 데이터 -->
			<input class="form-control" type="hidden" name="boardNo" value="<%=map.get("boardNo")%>">
			<input class="form-control" type="hidden" name="boardFileNo" value="<%=map.get("boardFileNo")%>">
			
			<table class="table">
				<tr>
					<th>게시물 제목</th>
					<td>
						<textarea class="form-control" rows="3" cols="50" name="boardTitle"
							required="required"><%=map.get("boardTitle")%></textarea>
					</td>
				</tr>
				<tr>
					<th>게시물 파일<br>수정전 파일 : <%=map.get("originFilename")%></th>
					<td>
						<input class="form-control" type="file" name="boardFile">
					</td>
				</tr>
			</table>
			<button style="float:right;" class="btn btn-secondary" type="submit">수정</button>
		</form>
	</div>
</body>
</html>