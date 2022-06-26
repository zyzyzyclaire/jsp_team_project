<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="login.UserDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="Board" class="notice.QnABean"></jsp:useBean>
<jsp:setProperty property="*" name="Board"/>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String path = request.getRealPath("upload"); //사용할 업로드 폴더 지정
	int size=1024*1024*10; //용량제한	
	int fileSize=0;
	String file="";
	String oriFile="";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	//Default -> 같은 이름의 파일을 알아서 번호 메겨줌
	Enumeration files = multi.getFileNames();
	String str = (String) files.nextElement();
	
	file = multi.getFilesystemName(str);	//파일이름을 가져옴
	
	if(file != null){	//파일이 널 값일때 값이 들어가기 위해
		oriFile = multi.getOriginalFileName(str);	//실제파일
		fileSize = file.getBytes().length;	//파일크기
	}
%>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();	

	QnADBBean qnaDB = QnADBBean.getInstance();
	QnABean board = new QnABean();
	UserDBBean udb = new UserDBBean();
	
	String user_id = (String) session.getAttribute("user_id");
	String user_name = (String) session.getAttribute("user_name");
	boolean isAdmin = udb.isAdmin(user_id);
	
	String pagecheck =   request.getParameter("pagecheck"); 
	System.out.println("@@@pagecheck@@"+pagecheck);
	board.setU_id(user_id);
	board.setB_category(multi.getParameter("b_category"));
	//board.setB_view(0);
	board.setB_title(multi.getParameter("b_title"));
	board.setB_content(multi.getParameter("b_content"));
	board.setB_ip(ip);
	board.setB_pwd(multi.getParameter("b_pwd"));

	board.setB_date(new Timestamp(System.currentTimeMillis()));
	
	int b_ref = Integer.parseInt(multi.getParameter("b_ref"));
	board.setB_ref(b_ref);
	int b_step = Integer.parseInt(multi.getParameter("b_step"));
	board.setB_step(b_step);
	int b_level = Integer.parseInt(multi.getParameter("b_level"));
	board.setB_level(b_level);
	int b_id = Integer.parseInt(multi.getParameter("b_id"));
	board.setB_id(b_id);
	
	if(file != null){
		board.setB_fname(file);
		board.setB_fsize(fileSize);
		board.setB_rfname(oriFile);
	}
	
	if (multi.getParameter("b_secret") == null || (isAdmin && b_ref == 0)) {
		//공개글
		board.setB_secret("0");
	} else {
		//비공개글
		board.setB_secret("1");
	}
	if (multi.getParameter("b_anschk") == null || b_step == 0 || !isAdmin) {
		//일반글
		board.setB_anschk("0");
	} else {
		//답변글
		board.setB_anschk("1");
	}
	System.out.println(b_id+"  "+pagecheck);
	if (qnaDB.writeBoard(board) == 1) {
		qnaDB.alreadyAnswered(board);
		
		if(pagecheck.equals("adminpage")){
			%>
			<script>
			location.href="../adminPage/adminPage.jsp?pageChange=../adminPage/qnaAnswerList.jsp";
			</script>
			<%
		}else if(pagecheck.equals("qnaList")){
			%>
			<script>
			location.href="qnaList.jsp";
			</script>
			<%
		}
	} else {
%>
		<script>
			alert("글 작성 실패");
			history.go(-1);
		</script>
<%
	}
%>
		