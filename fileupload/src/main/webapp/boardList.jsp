<%@page import="org.mariadb.jdbc.export.Prepare"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%
	//DB연동	
	String driver="org.mariadb.jdbc.Driver";
	String dburl="jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser="root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	
	String sql = "SELECT b.board_no boardNo,b.board_title boardTitle,f.board_file_no boardFileNo, f.origin_filename originFilename,f.save_filename saveFilename,path FROM board b INNER JOIN board_file f ON b.board_no = f.board_no ORDER BY b.createdate DESC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<>();
		m.put("boardNo",rs.getInt("boardNo"));
		m.put("boardFileNo",rs.getInt("boardFileNo"));
		m.put("boardTitle",rs.getString("boardTitle"));
		m.put("originFilename",rs.getString("originFilename"));
		m.put("saveFilename",rs.getString("saveFilename"));
		m.put("path",rs.getString("path"));
		list.add(m);
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
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4" style="height:100px; text-align: center;">
				<br><h1 style="margin:0;">PDF 자료 목록</h1>
			</div>
			<div class="col-sm-4"></div>
		</div>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<table class="table table-hover">
					<tr>
						<thead style="background-color: gray; color:white;">
							<th>보드 제목</th>
							<th>원본 이름</th>
							<th>수정</th>
							<th>삭제</th>
						</thead>
					</tr>
					<%
						for(HashMap<String,Object> m : list){
					%>
							<tr>
								<td><%=(String)m.get("boardTitle") %></td>
									<td>
										<a href="<%=request.getContextPath()%>/<%=(String)m.get("path")%>/<%=(String)m.get("saveFilename")%>" download="<%=(String)m.get("originFilename")%>">
											<%=(String)m.get("originFilename") %>
										</a>
									</td>
									<td><a href="<%=request.getContextPath()%>/modifyBoard.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>">수정</a></td>
									<td><a href="<%=request.getContextPath()%>/removeBoardAction.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>&saveFilename=<%=m.get("saveFilenma")%>">삭제</a></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div><!-- container -->
</body>
</html>