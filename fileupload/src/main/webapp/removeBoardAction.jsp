<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "vo.*" %>
<%
	//유효성검사
	if(request.getParameter("boardNo")==null
		||request.getParameter("boardFileNo")==null
		||request.getParameter("boardNo").equals("")
		||request.getParameter("boardFileNo").equals("")){
		
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	}

	//파일경로
	String dir = request.getServletContext().getRealPath("/upload");	
	
	//보드넘버와 파일넘버받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int boardFileNo = Integer.parseInt(request.getParameter("boardFileNo"));
	//디버깅
	System.out.println(boardNo+"<--boardNo");
	System.out.println(boardFileNo+"<--boardFileNo");
	
	//디비연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/fileupload","root","java1234");
	
	//세이브 파일을 찾기 위해 select 문으로 먼저 찾기
	String saveFilenameSql = "SELECT save_filename FROM board_file WHERE board_file_no=?";
	PreparedStatement saveFilenameStmt = conn.prepareStatement(saveFilenameSql);
	saveFilenameStmt.setInt(1, boardFileNo);
	ResultSet saveFilenameRs = saveFilenameStmt.executeQuery();
	System.out.println(saveFilenameRs+"<-Rs");
	
	//세이브 파일명 저장할 변수선언
	String preSaveFilename = "";
	if(saveFilenameRs.next()){
		System.out.println("if문 진입");
		preSaveFilename = saveFilenameRs.getString("save_filename");
	}
	
	//경로 찾아가서 파일삭제
	File f = new File(dir+"/"+preSaveFilename);
	System.out.println(f+"<--파일경로");
	if(f.exists()) {
		System.out.println("파일삭제");
		f.delete();
	}
	
	//받아온 보드넘버와 동일한 튜플을 삭제
	String sql = "DELETE FROM board WHERE board_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,boardNo);
	int row = stmt.executeUpdate();
	System.out.println("row-->"+row);
	
	//row값에 따른 분기 메세지로 분기 예정
	if(row==1){
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	}
%>