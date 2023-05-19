<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%
	String dir = request.getServletContext().getRealPath("/upload");
	int max = 10 * 1024 * 1024;
	// request객체를 MultipartRequest의 API를 사용할 수 있도록 랩핑
	MultipartRequest mRequest = new MultipartRequest(request,dir,max,"utf-8",new DefaultFileRenamePolicy());
	
	// MultipartRequest API를 사용하여 스트림내에서 문자값을 반환 받을수 있다
	
	// 업로드된 파일이 pdf형식의 파일이 아니면 
	if(!mRequest.getContentType("boardFile").equals("application/pdf")){
		//이미 저장된 파일을 삭제
		System.out.println("PDF파일이 아닙니다");
		String saveFilename = mRequest.getFilesystemName("boardFile");
		File f = new File(dir+"\\"+saveFilename); // new File("d:/abc/uploadsign.gif")
		if(f.exists()){
			f.delete();
			System.out.println(saveFilename+"<--파일삭제");
		}
		return;
	}
	
	// 1)
	// input type="text" 값반환 API -- > board 테이블 저장
	String boardTitle = mRequest.getParameter("boardTitle");
	String memberId = mRequest.getParameter("memberId");
	
	System.out.println(boardTitle + "<--boardTitle");
	System.out.println(memberId + "<--memeberId");
	
	Board board = new Board();
	board.setBoardTitle(boardTitle);
	board.setMemberId(memberId);
	
	// 2)
	// board_file 테이블에 저장
	// input type ="file" 값(파일 메타 정보) 반환 API(원본파일이름, 저장된파일이름, 컨텐츠타입)
	// 파일(바이너리)은 이미 MultipartRequest객체생성시(request랩핑시,10번라인) 먼저 저장
	String type = mRequest.getContentType("boardFile");
	String originFilename = mRequest.getOriginalFileName("boardFile");
	String saveFilename = mRequest.getFilesystemName("boardFile");
	
	BoardFile boardFile = new BoardFile();
	//boardFile.setBoardNo(boardNo);
	boardFile.setType(type);
	boardFile.setOriginFilename(originFilename);
	boardFile.setSaveFilename(saveFilename);
	
	System.out.println(type + "<--type");
	System.out.println(originFilename + "<--originFilename");
	System.out.println(saveFilename + "<--saveFilename");
	
	//DB연동
	String driver="org.mariadb.jdbc.Driver";
	String dburl="jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser="root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	
	String boardSql = "INSERT INTO board(board_title,member_id,updatedate,createdate) VALUES (?,?,now(),now())";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql,PreparedStatement.RETURN_GENERATED_KEYS);
	boardStmt.setString(1,boardTitle);
	boardStmt.setString(2,memberId);
	boardStmt.executeUpdate();
	
	ResultSet keyRs = boardStmt.getGeneratedKeys();
	int boardNo = 0;
	if(keyRs.next()){
		boardNo = keyRs.getInt(1);
	}
	
	String fileSql = "INSERT INTO board_file(board_no,origin_filename,save_filename,type,path,createdate) values (?,?,?,?,'upload',now())";
	PreparedStatement fileStmt = conn.prepareStatement(fileSql);
	fileStmt.setInt(1,boardNo);
	fileStmt.setString(2,originFilename);
	fileStmt.setString(3,saveFilename);
	fileStmt.setString(4,type);
	fileStmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	
%>