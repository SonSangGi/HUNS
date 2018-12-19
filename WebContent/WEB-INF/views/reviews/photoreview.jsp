<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html lang="ko">
<head>
<title>리이뷰</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>

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
<body>

<%@ include file="../include/header.jsp"%>
<div class="container">
<form id="search-form" class="form-inline" method="get" action="photoreview.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<input type="hidden" id="rows-box" name="rows" value="5" />
<%@ include file="bestreview.jsp" %>	
	
		<div class="row">
			<div class="col-xs-offset-1 col-xs-10">
			
				<div style="text-align: center; margin-bottom:50px; margin-top:50px; font-weight:bold;">
				<a href="allreview.do">
				<label class="btn btn-default btn-xl" style="width: 450px; margin-right:100px;">
				<strong>실시간전체 상품 후기</strong></label>
				</a> 
				
				<a href="photoreview.do">
				<label class="btn btn-default btn-xl" style="width: 350px;">
				<strong>포토후기</strong></label>
				</a>
				</div>
				
				<div style="margin-bottom: -5px;">
				<strong style="font-size: 9px;">PHOTO REVIEW</strong> <span>|</span> <span
					style="font-size: 9px;">포토 리뷰</span>
				</div>
				<hr />
				<div  class="row" style="border: 1px solid black; padding: 10px;">
					<div class="col-xs-9" style="padding:0px;  width:80%;" id="search-select" >
						<div>
							<span style="width:20%;">카테고리별 보기</span> 
							<!-- NAME : category의 문제 -->
							<select onchange="searchHR();" style="width: 70%; height: 35px;" id="search-category" class="form-control" name="category">
								<option style="height: 35px;" value="">카테고리를 선택해주세요</option>
								
								<c:forEach var="category" items="${categorys }">
									<option value="${category.no }" ${param.category eq category.no  ? 'selected' : '' } > ${category.contents }</option>
								</c:forEach>
							
							</select> 
							<select onchange="searchHR();" style="width: 15%; height: 35px;" class="form-control" name="sort">
								<option value="score" ${param.sort eq 'score' ? 'selected' : '' }>평점순</option>
								<option value="likes" ${param.sort eq 'likes' ? 'selected' : '' }>추천순</option>
								<option value="recent" ${param.sort eq 'recent' ? 'selected' : '' }>최신순</option>
							</select> 
						
						</div>
					</div>
					<div class="col-xs-3" style="padding:0px; width:20%;" id="search-form-area" >
						<button class="glyphicon glyphicon-search" aria-hidden="false" id="search-button" style="height:26px; width:30px;"></button>
						<input class="form-control" name="keyword" type="text" placeholder="검색어 입력" style="width:70%;" id="search-input-trigger" value="${param.keyword }"/>
					</div>
				</div>
				<%@ include file="photoreviewoption.jsp" %>
				
				
			</div>
		</div>

		<div class="row" style="margin-top:50px;">
			<div class="col-xs-offset-1 col-xs-10">
			
			<c:forEach var="photoReview" items="${photoReviews }">	
				<div class="col-xs-2 review_box">
					<div class="panel panel-default">
						<img onclick="getPhotoReviewDetail(${photoReview.no})" src="/images/reviews/images/${photoReview.photo }" class="img-thumbnail review_main_image" >
						<p class="review_title">${photoReview.contents }</p>
						<div class="review_form_middle" style="">
							<span class="review_writer" >***</span>
							<fmt:formatDate value="${photoReview.createDate }" pattern="yyyy.MM.dd" var="formattedDate"/>
							<span class="review_date" >${formattedDate }</span>
						</div>
						<hr style="margin-top:-3px;"/>
						<div class="review_form_bottom_box">
							<div class="review_form_bottom">
								<img class="review_bottom_image" src="/images/items/${photoReview.item.image }" >
							</div>

							<div class="review_bottom_font">
								<div onclick="redirectItem(${photoReview.item.no})">
									<div>${photoReview.item.name }</div>
									<span class="review_bottom_title_color">
										리뷰 
										<strong class="review_bottom_content1">${photoReview.count}</strong>
									</span> 
									<span class="review_bottom_title_color">
										평점 
										<strong class="review_bottom_content2">${photoReview.score }</strong>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
		
			</div>

		</div>
	<!-- 페이지 네이션 -->	
	
	<div class="row">
		<div class="col-xs-offset-5 col-xs-4">
			<ul class="pagination">
			
				<c:if test="${pagination.currentBlock gt 1 }">
					<li><a href="javascript:searchHR(${pagination.prevBlock })">&laquo;</a></li>
				</c:if>

				<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					<li class="${num eq pagination.cp ? 'active' : ''}"><a href="javascript:searchHR(${num })">${num }</a></li>
				</c:forEach>
			
				<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
					<li><a href="javascript:searchHR(${pagination.nextBlock })">&raquo;</a></li>
				</c:if>
				
			</ul>
		</div>
	</div>

<%@include file="reviewmodal.jsp" %>	
	

	
</form>
</div>


</body>
<script>
	
	var trigger = document.getElementById("search-input-trigger");
	
	var searchSelect = document.getElementById("search-select");
	var searchCategory = document.getElementById("search-category");
	var searchForm = document.getElementById("search-form-area");
	
	
	
	trigger.onfocus = function() {
	
		searchSelect.style.width="70%";
		searchCategory.style.width ="65%";
		searchForm.style.width= "30%";
	}
	
	trigger.onblur = function() {
		searchSelect.style.width="80%";
		searchCategory.style.width ="70%";
		searchForm.style.width= "20%";
		
	}
	
	
	function searchHR(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		
		document.getElementById("search-form").submit();
	}
	
	function redirectItem(redirectNo) {
		location.href="/stores/detail.do?no="+redirectNo;
	}
	
	
	
	
</script>

</html>