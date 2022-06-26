<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/sidebars/">
 <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 5rem;
        }
      }
    </style>
</head>
<body>
   <link href="../css/sidebars.css" rel="stylesheet">
 <div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
    <a href="adminPage.jsp" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
      <span class="fs-5 fw-semibold">Admin Page</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#product-collapse" aria-expanded="ture">
          	상품관리
        </button>
        <div class="collapse" id="product-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="?pageChange=productAdd.jsp" class="link-dark rounded">상품등록</a></li>
            <li><a href="?pageChange=productAllList.jsp" class="link-dark rounded">상품리스트</a></li>
          </ul>
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button onclick="location.href='?pageChange=manageOrder.jsp'" class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#order-collapse" aria-expanded="false">
          	주문관리
        </button>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1"><strong>&nbsp;게시판관리</strong><br><br>
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#notice-collapse" aria-expanded="false">
          	공지사항관리
        </button>
        <div class="collapse" id="notice-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="?pageChange=../customer_service/notice_write.jsp&pagecheck=adminpage" class="link-dark rounded">공지사항 등록</a></li>
			<li><a href="?pageChange=../customer_service/notice_list.jsp&pagecheck=adminpage" class="link-dark rounded">공지사항 수정/삭제</a></li>
          </ul>
        </div>
      </li><br>
      <li class="mb-1">
        <button onclick="location.href='?pageChange=qnaAnswerList.jsp&pagecheck=adminpage'" class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#board-collapse" aria-expanded="false">
          	QnA관리
        </button>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button onclick="location.href='?pageChange=manageMember.jsp'" class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#member-collapse" aria-expanded="false">
          	회원관리
        </button>
      </li>
    </ul>
  </div>	
	
	  <script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="../js/sidebars.js"></script>
</body>
</html>