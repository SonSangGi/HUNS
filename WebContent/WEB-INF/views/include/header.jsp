<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<style type="text/css">
body .main {
	font: 12px verdana, "굴림", Dotum, sans-serif;
	
	color: #555;
	margin: 0;
}

.top_menu {
	padding: 0px 0 0px;
	font: normal 13px dotum;
	color: #606060;
	overflow: auto;
	padding-left: 60px;
	padding-right: 60px;
	padding-top: 15px;
	position: fixed;
	z-index: 999;
	width: 100%;
	
}

.top_menu-ul {
	/* padding-left: 400px;
    width: 1220px; */
	margin: 0 auto;
	background: #fff;
	display: block;

}

#menuTop {
	list-style: none;
	padding-right: 15px;
	float: right;
	
}
a:link { 
	color: black;
	text-decoration: none;
}
a:visited { 
	color: black; 
	text-decoration: none;
}
a:hover { 
	color: black; 
	text-decoration: none;
}


.top_menu li.menu_cart {
	position: relative;
	padding-right: 30px;
}

.navbar {
	overflow: hidden;
    background-color: white;
    padding-top: 5px;
    padding-bottom: 49px;
    padding-left: 60px;
    padding-right: 60px;
    position: fixed;
    z-index: 998;
    width: 100%;
}

.navbar a {
	float: left;
 	 font-size: 12px;
/* 	font: normal 11px dotum; */
	font-weight:normal;
	color: black;
	text-align: center;
	padding: 23px 16px;
	text-decoration: none;
}

.subnav {
	float: left;
	
}

.subnav .subnavbtn {
	font-size: 20px;
	border: none;
	outline: none;
	color: black;
	padding: 14px 16px;
	background-color: inherit;
	font-family: inherit;
	margin-top: 40px;
	
	
}

.navbar a:hover, .subnav:hover .subnavbtn {
	background-color: white;
}

.subnav-content {
	height: 43px;
	position: absolute;
	left: 0;
	background-color: white; /* 바 클릭시 바탕화면 */
	width: 100%;

	border-bottom : 1px solid #d6cfcf61;
	border-top : 1px solid #d6cfcf61;
	z-index: 1;
}

.subnav-content a {
	float: left;
	color: black;
	padding: 9px 16px;
	padding-top: 14px;
	text-decoration: none;
}

.subnav-content a:hover {
	background-color: #fff;   /* 메뉴바 클릭시 배경색 */
	color: black;
}

.subnav-content {
	padding-left: 50px;
	
}

.subnav:hover .subnav-content {
	display: block;
	
}

.search-container {
	float: right;
    border: 1px solid #d6cfcf61;
    border-radius: 6px;
    margin-top: 40px;
    margin-right: 11px;
    width: 199px;
	height: 44px;
}

.search-container button {
	float: left;
	padding: 6px 10px;
	margin-top: 4px;
	margin-bottom: 4px; margin-right : 0px;
	background: white;
	font-size: 17px;
	border: none;
	cursor: pointer;
	margin-right: 0px;
	
}
.badge {
  display: inline-block;
  min-width: 10px;
  padding: 3px 7px;
  font-size: 12px;
  font-weight: bold;
  line-height: 1;
  color: #777;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  background-color: #fff;
  border-radius: 10px;
  
}
.badge:empty {
  display: none;
}

/* input[type=text] */
#search-input {
	width: 158px;
    padding: 6px;
    margin-top: 6px;
    /* border-radius: 30px; */
    margin-bottom: 4px;
    font-size: 11px;
    border: none;
}
</style>

</head>
<body class="main">
	<div class="top_menu" >
		<ul class="top_menu-ul">
			<li id="menuTop"><a href="/admin/main/home.do">관리자페이지</a></li>
			<li id="menuTop"><a href="/mypage/home.do">마이페이지</a></li>
			<li id="menuTop"><a href="/orders/saveList.do">주문조회</a></li>
			<li class="menu_cart" id="menuTop"><a href="/carts/cart-list.do">장바구니<span class="badge">
			
			<c:if test="${not empty LOGIN_USER_INFO }">(${cartCount })</c:if>
			</span></a></li>
			<c:choose>
				<c:when test="${empty LOGIN_USER_INFO }">
					<li id="menuTop" style="margin-top: -3px;"><a href="/users/registerform.do">회원가입<span><img src="/images/menu/resister.PNG"></span></a></li>
				</c:when>
				<c:otherwise>
					<li id="menuTop"><a href=""></a></li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${empty LOGIN_USER_INFO }">
					<li id="menuTop"><a href="/users/cookieid.do">로그인</a></li>
				</c:when>
				<c:otherwise>
					<li id="menuTop"><a href="/users/logout.do">로그아웃</a></li>					
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<%-- <c:if test=""> --%>
	<div class="navbar" >
		<a href="/home.do" style="font-size: 50px; padding-left: 128px;"><strong>HTA</strong></a>
		<div class="subnav" style="padding-left: 50px">
			<button class="subnavbtn" id="store">
				store<!-- <i class="fa fa-caret-down"></i> -->
			</button>
			<div class="subnav-content" id="store-content" style="display: block; padding-left: 174px;">
				<a href="#" style="color: red;">BEST50</a>
				<a href="#" style="color: red;">NEW</a>
			</div>
		</div>
		<div class="subnav" onclick="reviewgo()">
			<button class="subnavbtn" id="review">
				review
			</button>
		</div>
		

		<div class="search-container" >
			<form action="/menu/search.do" method="get" id="header-search-form">
				<input type="hidden" name="opt" value="itemName">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
				<input type="text" placeholder="검색" name="keyword" id="search-input">
			</form>
		</div>
	</div>
<%-- 	</c:if> --%>
	<script type="text/javascript">
	function openBar() {
		
		/* var bar = document.getElementById('store');
		bar.backgroundColor = white; */
	}
	var store = document.getElementById('store');
	var review = document.getElementById('review');
	var storeContent = document.getElementById('store-content');
	var reviewContent = document.getElementById('review-content');
	var contents = document.querySelectorAll(".subnavbtn");
	contents.forEach(function(content,index){
		content.onclick = function(){
			var id = content.getAttribute('id');
			if(id == 'store'){
				review.style.color = '';
				store.style.color = 'red';
				reviewContent.style.display = 'none';
				storeContent.style.display ="";
				
			}else if (id == 'review') {
				store.style.color = '';
				review.style.color = 'red';
				storeContent.style.dislpay="none";
				reviewContent.style.display = "";
				
			}	
		}
		
	});
	
	$.ajax({
		url:"/admin/TopCategory.do",
		type:"post",
		success:function(data){
			data.forEach(function(item){
				var rows = "";
				rows += "<a href=/stores/list.do?category="+item.no+">"+item.contents+"</a>";
				$("#store-content").append(rows);
			});
		}
	});
	
	
	function reviewgo() {
		location.href = "/reviews/allreview.do";
	}
	
	</script>


</body>
</html>