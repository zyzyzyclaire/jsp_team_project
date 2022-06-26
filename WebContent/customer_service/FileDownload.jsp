<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int bid = Integer.parseInt(request.getParameter("fileN"));
	QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getFileName(bid);
	
	String fileName="";
	String realFileName="";
	
	if(board != null){
		fileName = board.getB_fname();
		realFileName = board.getB_rfname();
	}
	
	String saveDirectory = application.getRealPath("/upload");
	String path = saveDirectory + File.separator + fileName;
	
	File file = new File(path);
	long length = file.length();
	realFileName = new String(realFileName.getBytes("ms949"),"8859_1");
	
	response.setContentType("application/octet-stream");
	response.setContentLength((int)length);
	response.setHeader("Content-Disposition", "attachment;filename="+realFileName);
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	
	out.clear();
	
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	int data;
	while((data=bis.read()) != -1){
		bos.write(data);
		bos.flush();
	}
	
	bis.close();
	bos.close();
%>
