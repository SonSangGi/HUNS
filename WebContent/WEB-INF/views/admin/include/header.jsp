<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 네이게이션 바 시작 -->

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

	<a class="navbar-brand mr-1" href="../../home.do">쇼핑몰 돌아가기</a>

	<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
		id="sidebarToggle" href="home.jsp">
		<i class="fas fa-bars"></i>
	</button>

	<!-- 검색 -->

	<!-- 네비게이션 바 -->
	<ul class="navbar-nav ml-auto ml-md-10">
		<li class="nav-item dropdown no-arrow">
		<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="font-size: 50px;padding: 0px;margin-left: 100px"> 
			<i class="fas fa-user-circle fa-fw"></i>
		</a>
			<div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
				<a class="dropdown-item" href="../main/registerform.do">관리자 생성</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="../main/logout.do" data-toggle="modal" data-target="#logoutModal">로그아웃</a>
			</div></li>
	</ul>

</nav>
<!-- 네비게이션바 끝 -->








<!-- 래퍼 시작 !!footer에 닫는 태그있음 -->
<div id="wrapper">

	<!-- 사이드 바 -->
	<ul class="sidebar navbar-nav">

		<li class="nav-item active"><a class="nav-link" href="../main/home.do">
				<i class="fas fa-fw fa-home"></i> <span>HOME</span>
		</a></li>

		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="a" role="button" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false">
			<i class="fas fa-shopping-cart"></i><span>상품/주문 관리</span>
		</a> <!-- 사이드바 메뉴 -->
			<div class="dropdown-menu" aria-labelledby="pagesDropdown">
				<h6 class="dropdown-header">Product</h6>
				<a class="dropdown-item" href="../product/list.do"><i class="fas fa-align-left"></i> 상품 목록</a> 
				<a class="dropdown-item" href="../product/addform.do"><i class="fas fa-pencil-alt"></i> 상품 등록</a> 
				<a class="dropdown-item" href="../product/category.do"><i class="fas fa-angle-double-right"></i> 분류 설정</a> 
				<a class="dropdown-item" href="../order/list.do"><i class="fas fa-people-carry"></i> 주문 조회</a>
			</div></li>


		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="user" role="button" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"> <i
				class="fas fa-clipboard-list"></i> <span>계정 관리</span>
		</a>

			<div class="dropdown-menu" aria-labelledby="user">
				<h6 class="dropdown-header">계정관리</h6>
				<a class="dropdown-item" href="../user/list.do"><i class="far fa-address-card"></i> 회원정보 조회</a> <a
					class="dropdown-item" href="../user/mgt.do"><i class="fas fa-address-card"></i> 탈퇴/휴면회원 조회</a>  
				<a class="dropdown-item" href="/admin/user/log.do"><i class="far fa-calendar-check"></i> 회원 로그 조회</a>
				<a class="dropdown-item" href="/admin/main/registerform.do"><i class="fas fa-unlock-alt"></i> 관리자 생성</a>
				</div></li>

		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="board" role="button" data-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"> <i
				class="fas fa-clipboard-list"></i> <span>관리 메뉴</span>
		</a>

			<div class="dropdown-menu" aria-labelledby="board">
				<h6 class="dropdown-header">관리 메뉴</h6>
				<a class="dropdown-item" href="../board/board.do"><i class="far fa-comment-alt"></i> 문의 관리</a> 
				<a class="dropdown-item" href="../board/reviews.do"><i class="fas fa-clipboard-list"></i> 리뷰 관리</a>
			</div></li>

		<!--사이드바 끝-->
	</ul>