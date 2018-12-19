<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row" style="padding-top: 198px;">
	<div class="col-xs-offset-1 col-xs-10">
		<img src="http://huns8402.cafe24.com/sy/crm/reviewking_1.jpg"
			style="width: 100%; margin-bottom: 50px;">
	</div>
</div>

<div class="row">
	<div class="col-xs-offset-3 col-xs-9" style="margin-right:50px;">

		<c:forEach var="photoReview" items="${bestReviews }">	
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
								<img class="review_bottom_image" src="/images/items/${photoReview.item.image }" onclick="redirectItem(${photoReview.item.no})">
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




