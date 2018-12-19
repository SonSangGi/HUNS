<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.container {
	padding-top: 198px;
	box-sizing: border-box;
}
.carousel-inner1{
	display: block;
    max-width: 100%;
   /*  height: auto; */
    height: auto;
}
.first {
	font-family: Verdana, sans-serif;
	margin: 0
}
body .main {
	font: 12px verdana, "굴림", Dotum, sans-serif;
	
	color: #555;
	margin: 0;
}

.mySlides {
	display: none
}

.first-img {
	vertical-align: middle;
	width: 1200px;
	height: 580px;
}

.second-img {
	width: 548px;
	height: 250px;
}

#third-img {
	width: 215px;
	height: 237px;
}
.thumbnails {
    display: block;
    padding: 4px;
    margin-bottom: 20px;
    line-height: 1.42857143;
    background-color: #fff;
    /* border: 1px solid #ddd; */
    /* border-radius: 4px; */
    -webkit-transition: border .2s ease-in-out;
    -o-transition: border .2s ease-in-out;
    transition: border .2s ease-in-out;
}
.avatar {
	vertical-align: middle;
	width: 50px;
	height: 50px;
	border-radius: 50%;
}

#review-image {
	width: 72px;
	height: 72px;
	border-radius: 100%;
}
#font-image{
	width: 100%; 
	padding: 50px 0px 100px;
}
#review-top {
	padding-top: 10px;
	top: 254px;
	width: 110px;
	font-size: 12px;
	font-weight: bold;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	height: 2.4em;
}
.listmain{
	padding: 30px 0px 50px;
    border-top: 1px solid #ccc;
}
#review-middle {
	height: 3em;
	line-height: 140%;
	white-space: normal;
	display: inline-block;
	padding-bottom: 5px;
	overflow: hidden;
	text-overflow: ellipsis;
}

#review-bottom {
	padding-top: 5px;
	padding-bottom: 5px; color : #aaa;
	font-size: 12px;
	color: #aaa;
}

#max-small {
	width: 350;
	height: 350px;
	max-width: 500px;
	max-height: 660px;
}

#review-table {
	min-height: 20px;
	padding-top: 28px;
	border-radius: 4px;
	border-radius: 4px;
	webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
	color: white;
	font-size: 25px;
}
#review-count:link{
    color: #aaa;
    text-decoration: none;
}
#review-font{
	font-size: smaller;

}
/* 신상품 메인 화면 정보 출력 */
.name{
	padding: 10px 0px 0px;
    margin: 0px 0 0px;
    text-align: left;
}
.summary{
	font-size: 12px;
    line-height: 15px;
    color: #c6c6c6;
    margin-top: 7px;
    font-weight: normal;
}
.viewimage {
	font: 17px/20px verdana,dotum!important;
    letter-spacing: -1px!important;
    font-weight: normal!important;
    color: #606060!important;
}
.prd_custom {
	font-size: 12px;
    line-height: 15px;
    text-decoration: line-through;
    color: #c6c6c6;
    font-weight: normal;
}
.salerate_red{
	font-size: 13px;
    line-height: 5px;
    color: #ec1313;
    font-weight: bold;
    float: left;
    margin-right: 5px;
}
.prd_price{
	font-size: 18px;
    line-height: 7px;
    color: #313131;
    font-weight: 900;
    
}
/* Slideshow container */
.slideshow-container {
	max-width: 1000px;
	position: relative;
	margin: auto;
}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* Caption text */
.text {
	color: #f2f2f2;
	font-size: 15px;
	padding: 8px 12px;
	position: absolute;
	bottom: 8px;
	width: 100%;
	text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
	color: #f2f2f2;
	font-size: 12px;
	padding: 8px 12px;
	position: absolute;
	top: 0;
}

/* The dots/bullets/indicators */
.dot {
	cursor: pointer;
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

.active, .dot:hover {
	background-color: #717171;
}

/* Fading animation */
.fade1 {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 1.5s;
	animation-name: fade;
	animation-duration: 1.5s;
}

.view {
	margin-left: 230px;
	position: absolute;
}
.carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
@
-webkit-keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
	.prev, .next, .text {
		font-size: 11px
	}
}

.column {
	float: left;
	width: 18%;
	margin-bottom: 16px;
	padding: 0 0px;
}

@media screen and (max-width: 650px) {
	.column {
		width: 100%;
		display: block;
	}
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	border: 1px solid white;
}

.contents {
	padding: 0 16px;
	background-color: white;
	/* display: inline-block; */
	font-family: "나눔고딕", "NanumGothic", "맑은 고딕", "Malgun Gothic", "돋움",
		"Dotum", "굴림", "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.contents::after, .row::after {
	content: "";
	clear: both;
	display: table;
}

.title {
	color: grey;
}

.button {
	border: none;
	outline: 0;
	display: inline-block;
	padding: 8px;
	color: white;
	background-color: #000;
	text-align: center;
	cursor: pointer;
	width: 100%;
}

.button:hover {
	background-color: #555;
}

	.review_box {width: 188px; min-height:320px;}
	.review_main_image {min-width:157px; max-width:157px; min-height:210px; max-height:210px;}
	.review_form_middle {text-align: center; margin-top:-10px; margin-bottom:15px;}
	.review_title {text-align: center; font-size: 10px; font-weight: bold;}
	.review_writer {color: grey; font-size: 8px; text-align:left; margin-right: 70px;}
	.review_date {color: grey; font-size: 8px; text-align: right;}
	
	.review_form_bottom_box {margin-top:-5px; margin-bottom: 20px;}
	.review_form_bottom {float: left; margin-left: 10px; margin-right: 10px;}
	.review_bottom_image {width: 35px; height: 35px;}
	.review_bottom_font {font-size:10px;}
	.review_bottom_title_color {color:#c3b799;}
	.review_bottom_content1 {color: black; margin-right: 5px;}
	.review_bottom_content2 {color: black;}
	
	.review_options {margin-bottom: 120px; margin-right:-40px;}
	.review_option_title {width:40%; float:left; font-weight:bold; font-size:12px;}
	.review_option_content {width:40%; float:left; text-align:right; color:#777; font-size:12px;}
	
	#photo-review-helpful-count {font-size:11px; color:#a4a4a4; border:1px solid #dadada; margin:5px;}
	#photo-review-content {font-size:12px;}
	#photo-review-date {font-size:11px; color:#cbcbcb; text-align:right;}
	
	#photo-review-helpful {font-size:11px; color:#7b7b7b; text-align:left; margin-right:5px;}
	#photo-review-button-like {color:#7b7b7b; padding:3px; padding-left:10px; padding-right:10px; 
							   border:1px solid #dadada; font-size:12px; text-align:center;
							   background-color:white;}
	#photo-review-button-dislike {color:#7b7b7b; padding:3px; padding-left:5px; padding-right:5px;
								  border:1px solid #dadada; font-size:12px; text-align:center;
								  background-color:white;}


</style>
</head>
<body class="main">
	<%@ include file="include/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-xs-offset-1 col-xs-10">
				<!-- <div class="slideshow-container">
					<div class="mySlides fade1">
						<div class="numbertext">1 / 3</div>
						<img src="images/menu/4.jpg" style="width: 100%" class="first-img">
						<div class="text"></div>
					</div>

					<div class="mySlides fade1">
						<div class="numbertext">2 / 3</div>
						<img src="images/menu/a.jpg" style="width: 100%" class="first-img">
						<div class="text"></div>
					</div>

					<div class="mySlides fade1">
						<div class="numbertext">3 / 3</div>
						<img src="images/menu/b.jpg" style="width: 100%" class="first-img">
						<div class="text"></div>
					</div>

					<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
						class="next" onclick="plusSlides(1)">&#10095;</a>

				</div> -->
				<!-- <br>

				<div style="text-align: center">
					<span class="dot" onclick="currentSlide(1)"></span> <span
						class="dot" onclick="currentSlide(2)"></span> <span class="dot"
						onclick="currentSlide(3)"></span>
				</div> -->
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
			    <!-- Indicators -->
			    <ol class="carousel-indicators">
			      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			      <li data-target="#myCarousel" data-slide-to="1"></li>
			      <li data-target="#myCarousel" data-slide-to="2"></li>
			    </ol>
			
			    <!-- Wrapper for slides -->
			    <div class="carousel-inner">
			
			      <div class="item active">
			        <img src="images/admin/banner2.gif" alt="Los Angeles" style="width:945px;height:580px; " class="first-img">
			        <div class="carousel-caption">
			        </div>
			      </div>
			
			      <div class="item">
			        <img src="images/admin/banner.jpg" style="width:100%; height:580px;" class="first-img">
			        <div class="carousel-caption">
			        </div>
			      </div>
			    
			      <div class="item">
			        <img src="images/items/f5ff45bd6296497a28e18bb2107c7354.gif" alt="New York" style="width:945px;height:580px; " class="first-img">
			        <div class="carousel-caption">
			        </div>
			      </div>
			  
			    </div>
			
			    <!-- Left and right controls -->
			    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left"></span>
			      <span class="sr-only">Previous</span>
			    </a>
			    <a class="right carousel-control" href="#myCarousel" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right"></span>
			      <span class="sr-only">Next</span>
			    </a>
			  </div>
		
			</div>
		</div>
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-offset-1 col-xs-5">
				<img src="images/menu/main_banner_2_01_1019_1.gif" style="width: 100%" class="second-img">
			</div>
			<div class="col-xs-5">
				<img src="images/menu/main_banner_2_02_1019.gif" style="width: 100%" class="second-img">
			</div>
		</div>
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-offset-1 col-xs-5">
				<img src="images/menu/main_banner_2_03_1019.gif" style="width: 100%" class="second-img">
			</div>
			<div class="col-xs-5">
				<img src="images/menu/main_banner_2_04_1019_1.gif" style="width: 100%" class="second-img">
			</div>
		</div>
	<!-- 스토어 베스트 상품  -->
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-12">
				<div class="listmain"
					style="margin-left: 15px; margin-right: 15px">
					<img src="images/menu/main_title_best.gif">
				</div>
			</div>
			
			<div class="col-xs-12" >				
			<c:forEach var="itemsScore" items="${itemsScores }">
				<div class="col-xs-4">
					<div class="thumbnails">
						<a href="/stores/detail.do?no=${itemsScore.no }"> 
						<c:choose>
							<c:when test="${itemsScore.detailOption.stock == 0}">
								<img src="images/menu/impo.png" alt="Lights" style="width: 100%" id="max-small">
							</c:when>
							<c:otherwise>
								<img src="images/items/${ itemsScore.image }" alt="Lights" style="width: 100%" id="max-small">							
							</c:otherwise>	
						</c:choose>	
							
							<div class="caption">
								<p class="name">
									<span class="viewimage">${itemsScore.name}</span>
								</p>
								<!-- 컬러갯수, 사이즈갯수 -->
								<p class="summary">${itemsScore.colorCount }color / ${itemsScore.sizeCount }size</p>
								
								<p class="prd_custom">${itemsScore.price}</p>
								<div class="salerate_red">
									할인가
								</div>
								<div class="prd_price">
									<b><fmt:formatNumber value="${itemsScore.detailOption.currentPrice  }" />원</b>
								</div>
							</div>
						</a>
					</div>
				</div>
				</c:forEach>
				
		</div>
		
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-12">
				<a href="/stores/list.do?category=${sub_no }"><img alt="판매순 TOP 50" src="images/menu/main_more_best_2.png" id="font-image" ></a>
			</div>
			<div class="col-xs-12">
				<div class="listmain"
					style="margin-left: 15px; margin-right: 15px">
					<img src="images/menu/main_title_new.gif">
				</div>
			</div>
			<!--신상품  -->
			<div class="col-xs-12">
			<c:forEach var="item" items="${items }">
				<div class="col-xs-4">
					<div class="thumbnails">
						<a href="/stores/detail.do?no=${item.no }"> 
						
							<c:choose>
								<c:when test="${item.detailOption.stock == 0}">
									<img src="images/menu/impo.png" alt="Lights" style="width: 100%" id="max-small">
								</c:when>
								<c:otherwise>
									<img src="images/items/${item.image }" alt="Lights" style="width: 100%" id="max-small">
								</c:otherwise>	
							</c:choose>	
						
							<div class="caption">
								<p class="name">
								<span class="viewimage">${item.name }</span>
								</p>
								<!-- 컬러갯수, 사이즈갯수 -->
								<p class="summary">${item.colorCount }color / ${item.sizeCount }size</p>
								
								<p class="prd_custom">${item.price }</p>
								
								<div class="salerate_red">
									할인가
								</div>
								<div class="prd_price"><fmt:formatNumber value="${item.detailOption.currentPrice  }" />원</div>
							</div>
						</a>
					</div>
				</div>
				</c:forEach>
		
			</div>
		</div>
		
		
		<!--  리뷰 -->
		<div class="row"
			style="height: 539px; background-color: black; margin-left: 15px; margin-right: 15px">
			<div class="col-xs-12">
				<div id="review-table"><img src="images/menu/main_review_title.gif" >
				</div>
			</div>
			<div class="col-xs-12" style="padding-top: 60px;">
			
				<%@include file="reviews/mainreview.jsp" %>
				<%@include file="reviews/reviewmodal.jsp" %>
				
			</div>
		</div>
		
		<!--상의 베스트  -->
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-12">
				<div class="listmain"
					style="margin-left: 15px; margin-right: 15px">
					<img src="images/menu/main_title_top.gif">
				</div>
			</div>

			<div class="col-xs-12">
				<c:forEach var="bestTopItem" items="${bestTopItems }">
				<div class="col-xs-4">
					<div class="thumbnails">
					<a href="/stores/detail.do?no=${bestTopItem.no }">
						<c:choose>
								<c:when test="${bestTopItem.detailOption.stock == 0}">
									<img src="images/menu/impo.png" alt="Lights" style="width: 100%" id="max-small">
								</c:when>
								<c:otherwise>
						 			<img src="images/items/${bestTopItem.image }" alt="Lights" style="width: 100%" id="max-small">
								</c:otherwise>	
						</c:choose>	
						
						
							<div class="caption">
								<p class="name">
								<span class="viewimage">${bestTopItem.name }</span>
								</p>
								<!-- 컬러갯수, 사이즈갯수 -->
								<p class="summary">${bestTopItem.colorCount }color / ${bestTopItem.sizeCount }size</p>
								
								<p class="prd_custom">${bestTopItem.price }</p>
								
								<div class="salerate_red">
									할인가
								</div>
								<div class="prd_price"><fmt:formatNumber value="${bestTopItem.detailOption.currentPrice  }" />원</div>
							</div>
						</a>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
		
		<!-- 팬츠 베스트  -->
		<div class="row" style="margin-top: 50px">
			<div class="col-xs-12">
				<div class="listmain"
					style="margin-left: 15px; margin-right: 15px">
					<img src="images/menu/main_title_pants.gif">
				</div>
			</div>

			<div class="col-xs-12">
				<c:forEach var="bestPantItem" items="${bestPantItems }">
				<div class="col-xs-4">
					<div class="thumbnails">
						<a href="/stores/detail.do?no=${bestPantItem.no }"> 
						
						<c:choose>
								<c:when test="${bestPantItem.detailOption.stock == 0}">
									<img src="images/menu/impo.png" alt="Lights" style="width: 100%" id="max-small">
								</c:when>
								<c:otherwise>
									<img src="images/items/${bestPantItem.image }" alt="Lights" style="width: 100%" id="max-small">
								</c:otherwise>	
						</c:choose>	
						
							<div class="caption">
								<p class="name">
								<span class="viewimage">${bestPantItem.name }</span>
								</p>
								<!-- 컬러갯수, 사이즈갯수 -->
								<p class="summary">${bestPantItem.colorCount }color / ${bestPantItem.sizeCount }size</p>
								
								<p class="prd_custom">${bestPantItem.price }</p>
								
								<div class="salerate_red">
									할인가
								</div>
								<div class="prd_price"><fmt:formatNumber value="${bestPantItem.detailOption.currentPrice  }" />원</div>
							</div>
						</a>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>

</div>
</body>
<script type="text/javascript">
	
	
	function redirectItem(redirectNo) {
		location.href="/stores/detail.do?no="+redirectNo;
	}
	
</script>
</html>