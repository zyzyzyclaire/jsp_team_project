<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FAQ page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<style type="text/css">
	#scroll{
		position: sticky;
		top: 0;
		background-color: white;
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	#lastnav{
		padding-right: 50px;
	}
	.breadcrumb {
		 background: white; 
	}
	a:link { color:black; }
	a:visited { color:black; }
	a:hover { color:mute;}
	a:active { color:black; }
</style>
</head>
<body>

<div id="scroll">
<%
	String user_id = null;
	String pageNum = null;
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		System.out.print(user_id);
	}
	
%>

<nav class="py-2 border-bottom">
    <div class="container d-flex flex-wrap">
       <%
       		if(user_id==null){
       %>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/login.jsp" class="nav-link link-dark px-2 active" aria-current="page">로그인</a></li>
        <li class="nav-item"><a href="../login/register.jsp" class="nav-link link-dark px-2">회원가입</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">장바구니</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">주문조회</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">마이페이지</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+즐겨찾기</a></li>
      </ul>
      	<%
                	}else{
      	%>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/logOut.jsp" class="nav-link link-dark px-2 active" aria-current="page">로그아웃</a></li>
        <li class="nav-item"><a href="../login/userUpdate.jsp" class="nav-link link-dark px-2">정보수정</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">장바구니</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">주문조회</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">마이페이지</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+즐겨찾기</a></li>
      </ul>
      	<%
                	}
         %> 
      <ul class="nav">
        <li class="nav-item"><a href="../customer_service/notice_list.jsp" class="nav-link link-dark px-2">NOTICE</a></li>
        <li class="nav-item"><a href="../customer_service/qnaList.jsp" class="nav-link link-dark px-2">Q&A</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">REVIEW</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">MODEL</a></li>
      </ul>
    </div>
  </nav>
   <header class="py-3 mb-0 border-bottom">
    <div class="container d-flex flex-wrap justify-content-center">
      <a href="../main/main.jsp" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
        <svg class="bi me-4" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
        <span class="fs-1" style="padding-left: 350px;">
        shopping mall</span>
      </a>
      <form class="col-12 col-lg-auto mb-3 mb-lg-0">
        <input type="search" class="form-control" placeholder="Search?" aria-label="Search">
      </form>
    </div>
  </header>
  <div>
 <ul class="nav justify-content-center">
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">BEST 50</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">OUTER</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">TOP</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">BOTTOM</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SKIRT/OPS</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SHOSE/BAG</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">ACC</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SALE</a>
  </li>
</ul>
</div>

</div>
<!-- 스크롤 네비바 끝 -->
<!-- Breadcrumb 시작 -->
<center>
<div style="width: 1100px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item">Board</li>
			<li class="breadcrumb-item active" aria-current="page">FAQ</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb 끝 -->
<br><br><br><br>
<center>
<div style="width: 900px;"align="left">
<h2 class="hfont">FAQ</h2>
자주묻는 질문
<hr align="left" width=100%>
<div class="accordion accordion-flush" id="accordionFlushExample">
	<div class="accordion-item">
    	<h2 class="accordion-header" id="flush-heading1">
      		<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="true" aria-controls="flush-collapse1">
       		 1. 배송관련 기본 사항입니다.
      		</button>
    	</h2>
    	<div id="flush-collapse1" class="accordion-collapse collapse" aria-labelledby="flush-heading1" data-bs-parent="#accordionFlushExample">
      		<div class="accordion-body">
				[판매 업체들의 일반적인 출고 일정입니다.]<br>
				평일 (월~금)<br>
				- 오전에 결제 완료 시 : 대부분 당일 오후 중 출고 진행<br>
				- 오후~저녁에 결제 완료 시 : 다음날 출고 진행<br><br>
				주말 및 공휴일 (토~일, 빨간 날)<br>
				- 택배 업체 중단으로 돌아오는 평일부터 출고를 시작합니다.<br>
				- 주문량이 많을 경우 1~2일 정도 출고 일정이 미뤄질 수 있습니다.<br>
				- 설날, 추석 등 명절 직후에는 택배 업체 물량 과다로 출고 및 배송 지연이 지속적으로 발생할 수 있습니다.
			</div>
   		 </div>
  	</div>
  
	<div class="accordion-item">
		<h2 class="accordion-header" id="flush-heading2">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse2" aria-expanded="false" aria-controls="flush-collapse2">
	        2. 출고 처리 전/처리 완료 후 주소지를 변경할 수 있나요?
	      </button>
	    </h2>
	    <div id="flush-collapse2" class="accordion-collapse collapse" aria-labelledby="flush-heading2" data-bs-parent="#accordionFlushExample">
		    <div class="accordion-body">
		      	출고 처리 중부터는 주문 정보 변경이 불가능합니다. 입금 확인 상태에서는 [주문내역 조회]에서 배송지를 변경할 수 있습니다.
		    </div>
	    </div>
	</div>
 
	<div class="accordion-item">
	    <h2 class="accordion-header" id="flush-heading3">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse3" aria-expanded="false" aria-controls="flush-collapse3">
	        3. 환불 접수 절차 및 유의사항
	      </button>
	    </h2>
	    <div id="flush-collapse3" class="accordion-collapse collapse" aria-labelledby="flush-heading3" data-bs-parent="#accordionFlushExample">
		    <div class="accordion-body">	
				|절차|<br>
				1. [주문 내역]에서 반품할 제품의 환불 요청을 합니다.<br>
				2. 환불하실 반품 방법을 선택해야 합니다.<br>
				3. 환불 배송비를 선결제해야 합니다.<br>
				4. 반품이 도착 후 검수 완료까지 영업일 기준 2~3일 정도 소요됩니다.<br>
				5. 검수 과정 완료 후 환불됩니다.<br>
			</div>
		</div>
	</div>
	
	<div class="accordion-item">
	    <h2 class="accordion-header" id="flush-heading4">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse4" aria-expanded="false" aria-controls="flush-collapse4">
	        4. 상품 불량, 오배송 환불
	      </button>
	    </h2>
	    <div id="flush-collapse4" class="accordion-collapse collapse" aria-labelledby="flush-heading4" data-bs-parent="#accordionFlushExample">
		    <div class="accordion-body">	
				1. 초기 불량 및 오배송인 경우 스토어에서 반품 배송비를 부담합니다.<br>
				2. 환불 접수 시 회수해 주세요를 선택하여 회수 접수 신청 후 받아보셨던 상태 그대로 재 포장하여 기사님 방문 시 전달해주세요.<br>
				3. 제품박스에 테이핑, 송장부착 제품만 보낸 경우 환불이 불가능 합니다. 초기 배송된 상태와 같이 이중 포장 부탁드립니다.
			</div>
		</div>
	</div>
	<div class="accordion-item">
	    <h2 class="accordion-header" id="flush-heading5">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse5" aria-expanded="false" aria-controls="flush-collapse5">
	        5. 환불한 상품이 해당 업체에 도착하였는데 환불은 언제 되나요.
	      </button>
	    </h2>
	    <div id="flush-collapse5" class="accordion-collapse collapse" aria-labelledby="flush-heading5" data-bs-parent="#accordionFlushExample">
		    <div class="accordion-body">	
				반품하신 상품의 배송완료는 반품 주소지의 집하점에 도착했을 때 기준입니다. <br>아직 업체에 반품 입고가 되지 않은 상태일 수 있습니다.<br>
				업체에 입고 되었더라도 제품 상태에 대한 검수를 진행하게 되어, <br>집하점 도착부터 업체 입고/검수까지 평균 2~3일 정도 소요됩니다.<br> (※업체마다 검수 기간 상이할 수 있습니다.)<br>
				검수 완료 후 환불처리 되며, 1~3 영업일 이내 결제하신 수단으로 환불됩니다.
			</div>
		</div>
	</div>
  
	<div class="accordion-item">
	    <h2 class="accordion-header" id="headingSix">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
	        6. 해외 배송 상품을 환불하고 싶어요.
	      </button>
	    </h2>
	    <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
			        해외배송 상품일 경우도 왕복 택배비용 및 관세/통관 비용을 부담하여 주시면 환불이 가능합니다.<br>
				반송비용은 제품 상세 페이지, 반송지는 마이페이지 > 주문조회 에 명시되어 있으니 참고 부탁드립니다. <br>해외배송 상품을 환불할 시 영업일 기준 7일 이상이 소요되며, 반송비용 역시 국내 배송 상품에 비해 많이 소요되오니 신중한 구매 부탁드립니다.
			</div>
	    </div>
	</div>
	
	<div class="accordion-item">
	    <h2 class="accordion-header" id="headingSeven">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
	       7. 후기 작성 규정이 어떻게 되나요?
	      </button>
	    </h2>
	    <div id="collapseSeven" class="accordion-collapse collapse" aria-labelledby="headingSeven" data-bs-parent="#accordionExample">
			<div class="accordion-body">
		                  후기는 일반 후기 / 상품 사진 후기 / 스타일 후기로 구성되어 있으며, 상품 별로 모든 후기 등록이 가능합니다. <br>규정에 맞지 않는 후기는 적립금이 지급되지 않으니 아래의 규정을 참고해 주시기 바랍니다. 
			</div>
	    </div>
	</div>
	
	<div class="accordion-item">
		<h2 class="accordion-header" id="headingEight">
			<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseEight" aria-expanded="false" aria-controls="collapseTwo">
			 8. 상품이 불량인 것을 착용하고 나서 알았어요.
			</button>
		</h2>
	    <div id="collapseEight" class="accordion-collapse collapse" aria-labelledby="headingEight" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		    	착용 후에는 원칙적으로 교환 및 환불이 불가능합니다. 상품 수령 시, 상품의 불량 여부를 확인해 주시기 바랍니다.<br> 미 착용 상태에서 불량 확인 시, 무상으로 환불 및 교환 처리가 가능합니다.
		    </div>
	    </div>
	</div>
  
	<div class="accordion-item">
	    <h2 class="accordion-header" id="headingNine">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
	        9. 교환 접수 절차 및 유의사항
	      </button>
	    </h2>
	    <div id="collapseNine" class="accordion-collapse collapse" aria-labelledby="headingNine" data-bs-parent="#accordionExample">
		    <div class="accordion-body">	
				|절차|<br>
				1. [주문내역]에서 교환할 제품의 교환 요청을 합니다.<br>
				2. 교환하실 반품 방법을 선택해야 합니다.<br>
				3. 교환 배송비를 선결제해야 합니다.<br>
				4. 반품 도착 후 검수 완료까지 영업일 기준 2~3일 정도 소요됩니다.<br>
				5. 검수 완료 후 교환 상품이 발송됩니다.
		    </div>
	    </div>
	</div>
</div>

<hr align="left" width=100%>
</div>
</center>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>