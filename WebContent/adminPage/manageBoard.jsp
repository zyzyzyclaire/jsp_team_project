<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function(){
	  
	  $('#main_menu > li > a').click(function(){
	    $(this).next($('.snd_menu')).slideToggle('fast');
	  })

	  // 버튼 클릭 시 색 변경
	  $('li > a').focus(function(){
	    $(this).addClass('selec');
	  })
	  $("li > a").blur(function(){
	    $(this).removeClass('selec');
	  })
	  
	})
</script>
<style>
	nav {
  		width: 150px;
	}
	
	ul { padding: 0; 
  	}
  		 
	li {
 		 list-style: none;
  		 line-height: 34px;
  		 float: left;
	}
	
	a {
	  display: block; /* 중요 */
	  text-decoration: none;
	  color: #616161;
	  text-align: center;
	}
	
	.snd_menu { background: #efefef; }
	.sub_menu { display: none; } /* 서브메뉴들 숨김 */
	.selec { background: #c45; color: #efefef; }
</style>
<title>게시판관리</title>
</head>
<body>
	<nav>
		<a class="nav-link" href="../adminPage/adminPage.jsp"><span></span>관리페이지</a>
	</nav>
	
	<h2>게시판관리</h2>
	<hr><br>
	<nav>
	  <ul id="main_menu">
	      <li><a href="#">공지사항 관리</a>
	        <ul class="snd_menu sub_menu">
	          <li><a href="../customer_service/notice_write.jsp">공지사항 등록</a></li>
	          <li><a href="../customer_service/notice_list.jsp">공지사항 수정/삭제</a></li>
   	       </ul>
	      </li>
	      <li><a href="#">QnA 게시판 관리</a>
	        <ul class="snd_menu sub_menu">
	          <li><a href="../customer_service/.jsp">QnA 게시판 답하기</a></li>
	          <li><a href="../customer_service/qnaList.jsp">게시글 수정/삭제</a></li>
   	       </ul>
	      </li>
	  </ul>
	</nav>
</body>
</html>