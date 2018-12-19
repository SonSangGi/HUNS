<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- modal -->

<div id="photo-review-modal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 730px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xs-7"
						style="width: 450px; height: 600px; padding: 0px;">
						<div class="">
							<img id="photo-review-image" style="width: 430px; height: 580px;" />
						</div>
					</div>

					<div class="col-xs-5" style="width: 270px; padding: 0px;">

						<div class="" style="height: 165px;">
							<div style="padding: 5px;">
								<div class="row">
									<div class="col-xs-4" style="padding-left: 20px;">
										<input type="hidden" id="item_modal_no" />	
										<img id="detail-item-image" style="width: 50px; height: 50px;"
											onclick="redirectModal()" />
									</div>
									<div class="col-xs-8" style="padding: 0px;">
										<p
											style="margin-bottom: 0px; color: #323232; font-size: 12px; font-weight: bold;"
											id="detail-item-title">상품상품임</p>
										<p style="color: red; font-size: 12px;" id="detail-item-score">★★☆</p>
										<p style="color: #7b7b7b; font-size: 11px;">***</p>
									</div>
								</div>
							</div>
							<div id="photo-review-helpful-count">
								<!--  도움없을때를 c if로 -->

								<c:choose>
									<c:when test="">

									</c:when>
									<c:otherwise>

									</c:otherwise>
								</c:choose>


								<div style="margin: 10px;"
									id="photo-review-helpful-count-content">
									이 리뷰에 대해<br /> <span id="review_modal_likes_participate">2</span>명중
									<span id="review_modal_likes">1</span>명이 도움이 된다 선택했습니다.
								</div>

							</div>

						</div>

						<div class="">
							<div
								style="overflow-y: scroll; height: 400px; margin-left: 10px;">
								<hr />
								<div class="review_options">

									<div class="review_option">
										<span class="review_option_title">성별</span> <span
											class="review_option_content" id="review_option_content_sex"></span>
									</div>

									<div class="review_option">
										<span class="review_option_title">연령대</span> <span
											class="review_option_content" id="review_option_content_age"></span>
									</div>

									<div class="review_option">
										<span class="review_option_title">키</span> <span
											class="review_option_content"
											id="review_option_content_height"></span>
									</div>

									<div class="review_option">
										<span class="review_option_title">몸무게</span> <span
											class="review_option_content"
											id="review_option_content_weight"></span>
									</div>

									<div class="review_option">
										<span class="review_option_title">평소사이즈</span> <span
											class="review_option_content" id="review_option_content_size"></span>
									</div>

								</div>
								<hr />
								<p id="photo-review-content"></p>

								<p id="photo-review-date"></p>
								<hr />
								<span id="photo-review-helpful">이 리뷰가 도움이 되었나요?</span> <input
									type="hidden" id="review_modal_no" />

								<button id="photo-review-button-like" type="button"
									onclick="addLikes()">네</button>
								<button id="photo-review-button-dislike" type="button"
									onclick="disLikes()">아니요</button>

							</div>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<script>
	var buttonLike = document.getElementById("photo-review-button-like");
	var buttonDisLike = document.getElementById("photo-review-button-dislike");

	function getPhotoReviewDetail(reviewNo) {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(event) {
			if (xhr.readyState == 4 && xhr.status == 200) {

				var text = xhr.responseText;
				var details = JSON.parse(text);

				var sex = details.reviewInfo.sex;

				if (sex == 'male') {
					sex = "남자";
				} else if (sex == 'female') {
					sex = "여자";
				}

				document.getElementById("photo-review-image").setAttribute(
						"src",
						"/images/reviews/images/" + details.reviews[0].photo);
				document.getElementById("photo-review-content").textContent = details.reviews[0].contents;
				document.getElementById("photo-review-date").textContent = details.reviews[0].createDate;

				document.getElementById("detail-item-image").setAttribute(
						"src", "/images/items/" + details.image);
				document.getElementById("detail-item-title").textContent = details.name;

				document.getElementById("review_option_content_sex").textContent = sex;
				document.getElementById("review_option_content_age").textContent = details.reviewInfo.age
						+ ' 세';
				document.getElementById("review_option_content_height").textContent = details.reviewInfo.height
						+ ' cm';
				document.getElementById("review_option_content_weight").textContent = details.reviewInfo.weight
						+ ' kg';
				document.getElementById("review_option_content_size").textContent = details.reviewInfo.textSize;

				document.getElementById("review_modal_likes_participate").textContent = details.reviews[0].likesParticipate;
				document.getElementById("review_modal_likes").textContent = details.reviews[0].likes;

				document.getElementById("review_modal_no").value = details.reviews[0].no;
				document.getElementById("item_modal_no").value = details.item.no;

				var scoreStar = details.reviews[0].score;

				if (scoreStar > 8) {
					scoreStar = "★★★★★";
				} else if (scoreStar > 6) {
					scoreStar = "★★★★";
				} else if (scoreStar > 4) {
					scoreStar = "★★★";
				} else if (scoreStar > 2) {
					scoreStar = "★★";
				} else {
					scoreStar = "★";
				}

				document.getElementById("detail-item-score").textContent = scoreStar;

				$("#photo-review-modal").modal('show');
			}
		}

		xhr.open("GET", "detail.do?reviewNo=" + reviewNo);
		xhr.send();

	}

	
	var x = '${param.modalreviewNo }';
	if(x) {
		getPhotoReviewDetail(x);
		
		
	} 
	
	
	var buttonYesClicked = false;
	var buttonNoClicked = false;

	function addLikes() {
		buttonLike.style.backgroundColor = "black";

		var reviewNo = document.getElementById("review_modal_no").value;
		var likesCount = 0;

		var xhr = new XMLHttpRequest();

		// 증가
		if (buttonYesClicked == false) {
			xhr.onreadystatechange = function(event) {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var text = xhr.responseText;
					var likes = JSON.parse(text);

					document.getElementById("review_modal_likes_participate").textContent = likes.likesParticipate;
					document.getElementById("review_modal_likes").textContent = likes.likes;
				}
			}

			likesCount = 1;
			buttonYesClicked = true;
			buttonDisLike.disabled = true;
			// 취소	
		} else if (buttonYesClicked == true) {

			xhr.onreadystatechange = function(event) {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var text = xhr.responseText;
					var likes = JSON.parse(text);

					document.getElementById("review_modal_likes_participate").textContent = likes.likesParticipate;
					document.getElementById("review_modal_likes").textContent = likes.likes;
				}
			}

			likesCount = -1;
			buttonYesClicked = false;
			buttonDisLike.disabled = false;
			buttonLike.style.backgroundColor = "white";

		}

		xhr.open('GET', 'likes.do?reviewNo=' + reviewNo + '&likes='
				+ likesCount + '&reclick=' + buttonYesClicked);
		xhr.send();
	}

	function disLikes() {

		buttonDisLike.style.backgroundColor = "black";

		var reviewNo = document.getElementById("review_modal_no").value;
		var likesCount = 0;

		var xhr = new XMLHttpRequest();

		// 감소 (좋아요 1개 감소)
		if (buttonNoClicked == false) {
			xhr.onreadystatechange = function(event) {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var text = xhr.responseText;
					var likes = JSON.parse(text);

					document.getElementById("review_modal_likes_participate").textContent = likes.likesParticipate;
					document.getElementById("review_modal_likes").textContent = likes.likes;
				}
			}

			likesCount = -1;
			buttonNoClicked = true;
			buttonLike.disabled = true;
			// 취소
		} else if (buttonNoClicked == true) {

			xhr.onreadystatechange = function(event) {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var text = xhr.responseText;
					var likes = JSON.parse(text);

					document.getElementById("review_modal_likes_participate").textContent = likes.likesParticipate;
					document.getElementById("review_modal_likes").textContent = likes.likes;
				}
			}

			likesCount = +1;
			buttonNoClicked = false;
			buttonLike.disabled = false;

			buttonDisLike.style.backgroundColor = "white";

		}

		xhr.open('GET', 'likes.do?reviewNo=' + reviewNo + '&likes='
				+ likesCount + '&reclick=' + buttonNoClicked);
		xhr.send();

	}

	buttonLike.onmouseenter = function() {
		if (buttonNoClicked == false) {
			buttonLike.style.backgroundColor = "black";
		}
	}
	buttonDisLike.onmouseenter = function() {
		if (buttonYesClicked == false) {
			buttonDisLike.style.backgroundColor = "black";
		}
	}

	buttonLike.onmouseleave = function() {
		if (buttonYesClicked == false) {
			buttonLike.style.backgroundColor = "white";
		}
	}
	buttonDisLike.onmouseleave = function() {
		if (buttonNoClicked == false) {
			buttonDisLike.style.backgroundColor = "white";
		}
	}

	
	function redirectModal() {
		var redirectNo = document.getElementById("item_modal_no").value;
		location.href = "/stores/detail.do?no="+ redirectNo;
	}
</script>
<!-- modal -->
