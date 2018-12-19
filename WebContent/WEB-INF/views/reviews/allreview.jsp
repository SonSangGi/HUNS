<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
	
	.allreview_image {width:100%; height:248px;}
	.allreview_title {font-size:11px;}
	.allreview_price {font-size:10px; color:#cccccc;}
	
	.allreview_items_score {font-size:10px; color:#cccccc; margin-bottom:0px;}
	.allreview_score {margin-left:30px; font-size:16px; color:#494949;}
	.allreview_count {font-size:10px; color:#cccccc;}
	
	.allreview_comment_image {width:40px; height:40px;}
	.allreview_comment_text {padding-left:5px; padding-right:0px; font-size:12px;}

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
<form id="search-form" class="form-inline" method="get" action="allreview.do">
	<input type="hidden" id="cp-box" name="cp" value="1"/>
	<input type="hidden" id="rows-box" name="rows" value="4" />
<%@ include file="bestreview.jsp" %>	
	<div class="row">
	
		<div class="col-xs-offset-1 col-xs-10" style="margin-bottom:20px;">
		
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
			
			<div class="pull-right">
				<select onchange="searchHR();" style="margin-left:10px; margin-right:10px; height:100%;" name="sort">
					<option value="recent" ${param.sort eq 'recent' ? 'selected' : '' }>최신 리뷰순</option>
					<option value="likes" ${param.sort eq 'likes' ? 'selected' : '' }>추천 상품순</option>
					<option value="count" ${param.sort eq 'count' ? 'selected' : '' }>평점 높은순</option>
				</select>
				<span>|</span>
				<button type="button" class="glyphicon glyphicon-search" aria-hidden="false" id="search-button" style="height:100%;"></button>
			</div>
			
		</div>
		
		<!-- 검색창 (버튼 누르면 열림) -->
		<div class="col-xs-offset-1 col-xs-10" style="display:none; margin-bottom:50px;" id="search-field">
			<div class="col-xs-9">
				<input class="form-control" type="text" name="keyword" style="width:100%" placeholder="검색어를 입력해 주세요" value="${param.keyword }"/>
			</div>
			<div class="col-xs-1" style="width:170px; ">
				<select onchange="searchHR()" style="height:25px;" name="price">
					<option value="">가격대 선택</option>
					<option value="1m" ${param.price eq '1m' ? 'selected' : '' }>1만원 이하</option>
					<option value="2m" ${param.price eq '2m' ? 'selected' : '' }>1만원 이상 ~ 3만원 미만</option>
					<option value="3m" ${param.price eq '3m' ? 'selected' : '' }>3만원 이상 ~ 5만원 미만</option>
					<option value="4m" ${param.price eq '4m' ? 'selected' : '' }>5만원 이상 ~ 10만원 미만</option>
					<option value="5m" ${param.price eq '5m' ? 'selected' : '' }>10만원 이상</option>
				</select>
			</div>
		</div>
		
	<c:forEach var="allReview" items="${allReviews}">
			<div class="col-xs-3">
				<div class="panel panel-default">
					<img src="/images/items/${allReview.image}" class="img-thumbnail allreview_image" onclick="redirectItem(${allReview.no})">
					<div style="padding:10px;">
						<p class="allreview_title">${allReview.name}</p>
						<p class="allreview_price"><fmt:formatNumber value="${allReview.price }" type="number" />원</p>	
				
						<hr style="margin-top:5px; margin-bottom:5px;"/>
		
					
						<p class="allreview_items_score">평점 </p> 
						<span class="allreview_score">${allReview.scoreMean}</span> 
						<span class="pull-right allreview_count">${allReview.reviewsSize}개의 리뷰</span>
					</div>
			<c:choose>
				<c:when test="${allReview.reviewsSize  ge 3}" >
					<c:forEach var="reviewContents" items="${allReview.reviews }"  begin="0" end="2">		
						<!-- hr은 선을 그어주는 구분자 입니다. 지우지 말 것! -->	
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px;" onclick="getPhotoReviewDetail(${reviewContents.no})">
								<div class="col-xs-3" style="margin-left:5px; padding-right:5px;">
									<img src="/images/reviews/images/${reviewContents.photo }" class="allreview_comment_image" onclick="getPhotoReviewDetail(${reviewContents.no})" />
								</div>
								<div class="col-xs-8 allreview_comment_text">
									<span>${reviewContents.contents }</span>
								</div>
							</div>
						</div>
					</c:forEach>	
				</c:when>
				<c:when test="${allReview.reviewsSize eq 2 }">
					<c:forEach var="reviewContents" items="${allReview.reviews }">		
						<!-- hr은 선을 그어주는 구분자 입니다. 지우지 말 것! -->	
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px;" >
								<div class="col-xs-3" style="margin-left:5px; padding-right:5px;">
									<img src="/images/reviews/images/${reviewContents.photo }" class="allreview_comment_image" onclick="getPhotoReviewDetail(${reviewContents.no})" />
								</div>
								<div class="col-xs-8 allreview_comment_text">
									<span>${reviewContents.contents }</span>
								</div>
							</div>
						</div>
					</c:forEach>	
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>
				
				</c:when>
				<c:when test="${allReview.reviewsSize eq 1}">
					<c:forEach var="reviewContents" items="${allReview.reviews }">		
						<!-- hr은 선을 그어주는 구분자 입니다. 지우지 말 것! -->	
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px;">
								<div class="col-xs-3" style="margin-left:5px; padding-right:5px;">
									<img src="/images/reviews/images/${reviewContents.photo }" class="allreview_comment_image" onclick="getPhotoReviewDetail(${reviewContents.no})" />
							</div>
								<div class="col-xs-8 allreview_comment_text">
									<span onclick="getPhotoReviewDetail(${reviewContents.no})">${reviewContents.contents }</span>
								</div>
							</div>
						</div>
					</c:forEach>	
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>
						<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>
				
				</c:when>
				<c:otherwise>
					<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>	
					<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>
					<hr style="margin-top:5px; margin-bottom:5px;"/>
						<div class="center-block">
							<div class="row" style="padding:5px; height:50px;">
							</div>
						</div>	
				</c:otherwise>
			</c:choose>		
			 		
				</div>
			</div>
	</c:forEach>		
			
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
	
	
</div>	
</form>
</div>
</body>
<script>
		var searchButton = document.getElementById("search-button")
		var buttonPush = false;
		
		searchButton.onclick = function(event) {
			if(buttonPush == false) {
				document.getElementById("search-field").style.display='';
				buttonPush = true;
			} else if (buttonPush == true) {
				document.getElementById("search-field").style.display='none';
				buttonPush = false;
			}
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