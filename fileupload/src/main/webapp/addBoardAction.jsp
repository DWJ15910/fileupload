<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %>

<%@ page import = "vo.*" %>
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
%>