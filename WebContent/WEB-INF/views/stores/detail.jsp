<%@page import="kr.co.team2.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	.other-images {
		border: 1px solid; 
		text-align: center;
		width:375px;
	}
	.photo-review {
		border: 1px solid;
		text-align: center;
		width: 375px;
		margin-top: 20px;
	}
	.info {
		font-size: 13px;
	}
	
	.help {
		font-size:12px;
		border: 1px solid;
		border-style: dashed;
	}
	.font {
		margin-left: 30px;
		font-size: 15px;
	}
	.mini{
		margin-top: 10px;
		text-align: center;
	}
	#progress { 
 	 	width: 91%;
  	 	background-color: #ddd;
	}
	#bar {
		width: 61%;
		text-align: center;
		background-color: green;
	}
	.option {
		top: 10%;
		margin-left: 30px;
	}
	.notice {
		font-size: 13px;
	}
	.price {
		border: 1px solid;
		text-align: right;
		background-color: #F2F2F2;
		width: 370px;
		height: 40px;
	}
	#buttons {
		display: inline-block;
		margin-left: 10px;
	}
	
	#Carousel {
		height: 225px;
		
	}
	.item {
		margin-top: 25px;
	}
	.detail {
		margin-top: 150px;
		text-align: center;
	}
	#first {
		margin-top: 80px;
		font-size: 15px;
	}
	.button {
		text-align: center;
		margin-left: 150px;
		display: block;
		width: 200px;
		height: 40px;
		border: 1px solid;
		background-color: white;
		cursor: pointer;
	}
	#second {
		margin-top: 50px;
	}
	.review {
		
	}
	#review-photo {
		opacity: 0;
		position: relative;
		z-index: -1;
	}
	
</style>
</head>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container" style="padding-top: 225px;">
	<div class="row">
		<div class="col-xs-4">
			<img src ="<c:out value='${pageContext.request.contextPath}' />/images/items/${item.image}" style="width: 375px; height: 450px;"><br><br>
			<div class="photo-review">
				PHOTO REVIEW
				<br>
				<c:forEach var="photos" items="${photos }">
					<img src="<c:out value='${pageContext.request.contextPath}' />/images/reviews/images/${photos.photo}" style="width: 50px; height: 50px;">
				</c:forEach>
			</div>
		</div>
		<div class="col-xs-4">
			<p style="margin-left: 10px; font-size: 25px;"><strong>${item.name }</strong></p>
			<hr>
			    <p style="margin-left: 10px;"><strong style="font-size: 13px;">소비자가</strong><strong style="margin-left: 30px; font-size: 13px;">${item.price }</strong></p>
			<hr>
				<p style="margin-left: 10px;"><strong style="font-size: 13px;">판매가</strong><strong style="margin-left: 45px; font-size: 13px;">${optionz[0].currentPrice }</strong></p>
				<!-- ex) ${options[0].price} -->
			<hr>
			<form name="choose-option" method="get" action="cart-order.do">
			<div id="options">
				<label>[제품 색상]</label>
					<select class="option" id="first-option" name="color-option" style="width: 240px;">
						<option value=""> -- 선택할 색상을 먼저 선택하세요 </option>
						<c:forEach var="optionz" items="${optionz }">
							<option value="${optionz.color }">${optionz.color }</option>
						</c:forEach>
					</select>	
					   <label>[제품 크기]</label>
						<select class="option" id="second-option" name="size-option" style="width: 240px;">
							<option value="">-- 색상 선택후 선택이 가능합니다.</option>
								<c:forEach var="options" items="${options }">
									<option value="${options.no}">${options.size}</option>	
								</c:forEach>
				        </select> 		
				<br>
			</div>
			</form>
			<br>
			<br>
			<div class="notice">
				(최소주문수량 1개)
				<span class="help-block">! 위 옵션박스를 선택하시면 아래에 상품이 추가됩니다.</span>
				<span style="color:red">! 무통장 입금시 입금자와 금액이 다른 경우 <br> 자동확인이 안되오니 주의 바랍니다.</span>
			</div>
			<br>
			<div id="detail-display" style="width: 370px; border: 1px solid; margin-bottom: 5px;">
				<label>선택 색상: </label><span id="color-view"></span>
				<label style="margin-left: 40px;">선택 사이즈: </label><span id="size-view"></span>
				<form name="form" method="get">
					<strong>수량 : </strong><input type="hidden" name="sellPrice" value="${optionz[0].currentPrice }">
					<input type="text" name="amount" id="qty" value="1" size="3" onchange="change();">
					<input type="button" value=" + " onclick="add();"><input type="button" value=" - " onclick="del();">
					<strong>가격 : </strong><input type="text" name="sum" size="11" readonly>원
				</form>
				
			</div>
			<div class="price">
				<p style="margin-top: 7px; margin-right: 10px;">총 상품금액(수량): <span id="sum">${optionz[0].currentPrice } </span>원(<span id="quantity">1</span>개)
			</div>
			<br>
			<div id="buttons" style="margin-left: 75px;">
				<c:choose>
					<c:when test="${not empty LOGIN_USER_INFO }">
						<button class="btn btn-default" onclick="goToCart();" ><img src="https://static.thenounproject.com/png/1589725-200.png" style="width: 20px; height: 20px;">장바구니</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-default disabled" ><img src="https://static.thenounproject.com/png/1589725-200.png" style="width: 20px; height: 20px;">장바구니</button>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${not empty LOGIN_USER_INFO }">
						<button class="btn btn-default" onclick="payment();"><img src="https://static.thenounproject.com/png/756509-200.png" style="width: 20px; height: 20px;">구매하기</button>					
					</c:when>
					<c:otherwise>
						<button class="btn btn-default disabled" onclick="payment();"><img src="https://static.thenounproject.com/png/756509-200.png" style="width: 20px; height: 20px;">구매하기</button>
					</c:otherwise>	
				</c:choose>		
			</div>
		</div>
		<div class="col-xs-4">
			<br><hr>
			<div class="info">
				<span style="color:red">신규회원 가입 혜택</span><br>				
				신규회원 가입시 <strong>적립금 2,000원</strong> 지급<br>
				<span style="color:red">(상품 구매금액 <strong>3만원 이상</strong> 구매시 사용가능)</span><br><br>
				신규회원 가입시 <strong>전상품 5% 할인 쿠폰</strong> 지급<br>
				<span style="color:red">(상품 구매금액 <strong>5만원 이상</strong> 구매시 사용가능)</span>
				<hr>
				<span style="color:red"><strong>HTA 회원 특별혜택</strong></span>
				<br>
				매일 업데이트 되는 <strong>신상 30%</strong><br>
				회원 등급별 <strong>최대 10%</strong> 적립<br>
				구매금액별 <strong>3,6,9 쿠폰 지급</strong><br>
				SNS(페이스북,인스타그램) 게릴라 이벤트<br> 
				포토리뷰 작성시 최대 <strong>~50,000원 적립금</strong> 지급<br>
				<div class="mini">
					<a href="/users/registerform.do"><input type="submit" class="btn-default btn-md" value="회원 가입 하러가기"></a>
				</div>
				<br>								
			</div>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-xs-12 text-center">	
			<hr>
			<ul class="nav nav-tabs nav-justified">
				<li class="active"><a href="#first">상품상세정보</a></li>
				<li><a href="#second">구매후기</a></li>
				<li><a href="#third">상품문의</a></li>
				<li><a href="#fourth">배송안내</a></li>			
			</ul>
			<div class="tab-content">
				<div id="first">
				 	<span style="color:red;"><strong>*SHOPPING TIP*</strong></span>	
				 	<br><br>
				 	HTA만의 회원 혜택 받고 쇼핑하자			
				 	<br><br>
					<a href="/users/registerform.do"><input type="button" class="btn btn-danger btn-lg" value="회원가입하기"></a>
					<br><br><br>
					<div class="col-xs-12">
						<div class="col-xs-3">
							<div class="thumbnail">
								<img src="https://static.thenounproject.com/png/1351305-200.png" style="width: 200px; height: 180px;">
								<div class="caption">
									<span style="color:red"><strong>신규 회원 할인쿠폰&적립금</strong></span>
									<p>신규 회원 가입시</p>
									<p>5% 할인쿠폰&2천원 적립금 지급</p>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="thumbnail">
								<img src="https://static.thenounproject.com/png/1422917-200.png" style="width: 200px; height: 180px;">
								<div class="caption">
									<span style="color:red"><strong>등급별 최대 10% 적립</strong></span>
									<p>구매 등급에 따라 등급이 나뉘며,</p>
									<p>각 등급별로 최대 10% 적립</p>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="thumbnail">
								<img src="https://static.thenounproject.com/png/606338-200.png" style="width: 200px; height: 180px;">
								<div class="caption">
									<span style="color:red"><strong>5만원 이상 무료배송</strong></span>
									<p>전 상품 5만원 이상 결제시</p>
									<p>무료배송</p>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="thumbnail">
								<img src="https://static.thenounproject.com/png/1207289-200.png" style="width: 215px; height: 180px;">
								<div class="caption">
									<span style="color:red"><strong>매달 리뷰왕 적립금</strong></span>
									<p>매달 첫주 리뷰왕 최대 10,000원</p>
									<p>(글:300원 / 글+사진:1000원)</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-offset-2 col-xs-8">
						<table class="table table-bordered">
							<colgroup>
								<col width="10%">						
								<col width="10%">						
								<col width="*">						
								<col width="15%">						
								<col width="10%">						
							</colgroup>
							<thead>
								<tr>
									<th class="text-center">번호</th>
									<th class="text-center">사진</th>
									<th class="text-center">제목</th>
									<th class="text-center">작성자</th>
									<th class="text-center">평점</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reviews" items="${reviews }">
								<tr>
									<td>${reviews.no }</td>
									<td><img src="https://static.thenounproject.com/png/1867142-200.png" style="width: 25px; height: 25px;"></td>
									<td>${reviews.contents }</td>
									<td>${reviews.user.id }</td>
									<td>
									<c:choose>
									 	<c:when test="${reviews.score ge 9}">
									 		<span style="color: red;">★★★★★</span>	
									 	</c:when>
									 	<c:when test="${reviews.score ge 7}">
									 		<span style="color: red;">★★★★</span>	
									 	</c:when>	 
									 	<c:when test="${reviews.score ge 5}">
									 		<span style="color: red;">★★★</span>	
									 	</c:when>
									 	<c:when test="${reviews.score ge 3}">
									 		<span style="color: red;">★★</span>	
									 	</c:when>
									 	<c:when test="${reviews.score ge 1}">
									 		<span style="color: red;">★</span>	
									 	</c:when>
									</c:choose>
									</td>
										<!-- ${reviews.score } -->
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="col-xs-offset-3 col-xs-6">
						<button class="button" onclick="location.href='#second'">상품 후기 더보기<img src="https://static.thenounproject.com/png/1970543-200.png" style="width: 25px; height: 25px;"></button>
					</div>
					<br>
					<div>
						${item.contents }					
					</div>
					<div id="second">
						<ul class="nav nav-tabs nav-justified">
							<li><a href="#first">상품상세정보</a></li>
							<li class="active"><a href="#second">구매후기</a></li>
							<li><a href="#third">상품문의</a></li>
							<li><a href="#fourth">배송안내</a></li>			
						</ul>
						<div class="review">
							<form method="post" id="review-add-form" class="form-horizontal" action="/reviews/add.do" enctype="multipart/form-data">
								<!--  userNo와 optionNo를 받아와야함 -->
								<input class="hidden" name="option-no" id="optno" />
								<!-- 아래 부분에 쿼리 스트링으로 넘어오는 주소 : .../stores/deail.do?no = '' -->
								
								<p style="margin-top: 100px; font-size: 13px; ">고객님의 소중한 후기가 많은 분들께 큰 도움이 됩니다.</p>
								<div style="margin-top: 50px; margin-bottom: 50px; text-align: center;">
									REVIEW | 문의글 혹은 악의적인 비방글은 무통보 삭제된다는 점 유의해주세요 ^^
								</div>									
								<span>성별</span>
								  	<input type="radio" name="option-sex" value="male" checked="checked"> 남자
									<input type="radio" name="option-sex" value="female"> 여자
								 <span style="margin-left: 10px;">나이</span>
								 	<input type="number" id="review-age" name="option-age" style="width: 50px;">
								 	<span id="review-age-warning"></span>
								 <span style="margin-left: 10px;">키</span>
								 	<input type="number" id="review-height" name="option-height" style="width: 50px;">
								 <span style="margin-left: 10px;">무게</span>
								 	<input type="number" id="review-weight" name="option-weight" style="width: 50px;">
								 <span style="margin-left: 10px;">사이즈</span>
								 	<select name="option-size" style="width:50px; height: 25px;">
                   							<option value="90">XS</option>
                   							<option value="95">S</option>
                   							<option value="100">M</option>
                   							<option value="105">L</option>
                   							<option value="110">XL</option>
                   					</select>
								<div class="form-group" style="position: relative; margin-top: 20px;">
									<textarea rows="6" id="review-contents" class="form-control" name="review-contents"></textarea>
								</div>
								   <label for="review-photo" style="cursor: pointer; margin-right: 1020px; display: inline-block; border: 1px solid; width: 180px;"><img src="https://static.thenounproject.com/png/1578143-200.png" style="width: 30px; height: 30px;"> + 사진추가</label> 
									<div>
										<input type="file" name="photo" id="review-photo" />
									</div>
								<div class="form-group" style="position:relative; margin-top: 5px;">
									<select id="rate"  name="option-star" style="position:relative; bottom:60px; width: 300px; height:30px; margin-left: auto; margin-right: auto; font-size: 13px;">
										<option value="9">★★★★★: 아주 좋아요</option>
										<option value="7">★★★★: 맘에 들어요</option>
										<option value="5">★★★: 보통이에요</option>
										<option value="3">★★: 그냥 그래요</option>
										<option value="1">★: 별로에요</option>										
									</select>
									<c:choose>
										<c:when test="${not empty LOGIN_USER_INFO }">
											<button type="submit" style="position:relative; left:350px; bottom:65px; background-color: white"><img src="https://static.thenounproject.com/png/1996044-200.png" style="width: 25px; height: 25px;">리뷰 등록하기</button>
										</c:when>
										<c:otherwise>
											<button onclick="returns();" style="position:relative; left:350px; bottom:65px; background-color: white"><img src="https://static.thenounproject.com/png/1996044-200.png" style="width: 25px; height: 25px;">리뷰 등록하기</button>
										</c:otherwise>
									</c:choose>			
								</div>					
							</form>
						</div>
					</div>
					<div id="third" style="margin-top: 35px;">
						<ul class="nav nav-tabs nav-justified">
							<li><a href="#first">상품상세정보</a></li>
							<li><a href="#second">구매후기</a></li>
							<li class="active"><a href="#third">상품문의</a></li>
							<li><a href="#fourth">배송안내</a></li>			
						</ul>
						<p style="text-align: center; font-size: 13px; margin-top: 100px;">상품에 대해 궁금한 점을 해결해 드립니다.</p>
						  <table class="table-bordered" style="margin-left: auto; margin-right: auto; width: 100%; margin-top: 50px;">
						  	<colgroup>
						  		<col width="10%">
						  		<col width="*%">
						  		<col width="10%">
						  		<col width="10%">
						  	</colgroup>
						  	<thead>
						  		<tr>
						  			<th class="text-center">no</th>
						  			<th class="text-center">subject</th>
						  			<th class="text-center">name</th>
						  			<th class="text-center">date</th>
						  		</tr>
						  	</thead>
						  	<tbody>
						  		<c:forEach var="questions" items="${questions }">
						  		<tr>
						  			<td>${questions.no }</td>
						  			<td>${questions.item.name }</td>
						  			<td>${questions.user.id }</td>
						  			<td><fmt:formatDate value="${questions.createDate}" pattern="yyyy-MM-dd"/></td>
						  		</tr>
						  		</c:forEach>
						  	</tbody>
						  </table>
						  <button class="btn" onclick="sendNo();" style="position:relative; left: 520px; background-color: black; height: 30px; margin-top: 15px;"><p style="font-size: 12px; color: white">상품문의하기</p></button>
					</div>
					<div id="fourth" style="margin-top: 100px;">
						<ul class="nav nav-tabs nav-justified">
							<li><a href="#first">상품상세정보</a></li>
							<li><a href="#second">구매후기</a></li>
							<li><a href="#third">상품문의</a></li>
							<li class="active"><a href="#fourth">배송안내</a></li>		
						</ul>
							<img src="http://binary1.cafe24.com/web/upload/NNEditor/20170411/TodayDelivery.jpg">	
					</div>
				</div>			
			</div>
		</div>
    </div>
</div>
</body>
<script type="text/javascript">
	// 아이템 , 색상 선택후 그 선택에 맞는 사이즈 조회
	document.getElementById("first-option").onchange = function(event) {
		var color = event.target.value;
		if(color) {
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					var options = JSON.parse(data);
					var content = ""; 
						content += "<option value=''>" + " -- 원하는 사이즈를 선택하세요. " + "</option>";
						for(var i=0; i<options.length; i++) {
							var opt = options[i];
							if (opt.stock == 0) {
								content += "<option value='' disabled>" +" -- 매진된 사이즈입니다.  "+ "</option>";
							} else {
								content += "<option value="+opt.no+">"+opt.size+"</option>";									
							}
						}
						
			  document.getElementById("second-option").innerHTML = content;
			}
		}
		
		xhr.open("GET", "optiondetail.do?itemNo=${item.no }&color="+ color);
		xhr.send();
		
		}
	}
	
	// 선택한 색상 , 사이즈 출력
	document.getElementById("second-option").onchange = function(event) {
		
		var firstOptionSelect = document.getElementById("first-option").value;
		document.getElementById("color-view").innerHTML = firstOptionSelect;
		
		var secondOptionSelect = document.getElementById("second-option")
		var ss = secondOptionSelect.options[secondOptionSelect.selectedIndex].text;
		document.getElementById("size-view").innerHTML = ss;
		document.getElementById("optno").value = secondOptionSelect.value;
	}  
	
	 /*document.getElementById("detail-display").onchange = function(event) {
		
		var color = document.getElementById("first-option").value; 
		var size = document.getElementById("second-option").value; 
		console.log("test");
		if (color == null) {
			console.log("null");
		}
		if (color == "") {
			console.log("공백");
		}
		
		if (color != null && size != null) {
			document.getElemntById("detail-display").style.display = "";
		}
	}*/
	
	// 선택한 제품의 수량, 가격 카운트
	var sellPrice; 
	var amount;
	
	window.onload = function () {
		//sellPrice = document.form.sellPrice.value;
		init();
	}
	
	function init() {
		sellPrice = document.form.sellPrice.value;
		amount = document.form.amount.value; 
		document.form.sum.value = sellPrice; 
		
		change();
		
		
	}
	
	function add() {
		hm = document.form.amount; 
		sum = document.form.sum;
		hm.value ++;
		
		console.log(hm.value);
		console.log("  " + sellPrice);
		
 		sum.value = parseInt(Number(hm.value)) * Number(sellPrice);
 		document.getElementById("sum").innerHTML = sum.value;
 		document.getElementById("quantity").innerHTML = hm.value;
 		
	}
	
	function del() {
		hm = document.form.amount;
		sum = document.form.sum;
		 if (hm.value > 1) {
			 hm.value --;
			 sum.value = parseInt(hm.value) * sellPrice;
		 }
		 document.getElementById("sum").innerHTML = sum.value;
	 	 document.getElementById("quantity").innerHTML = hm.value;
	}
	
	function change() {
		hm = document.form.amount; 
		sum = document.form.sum; 
		
			if (hm.value < 0) {
				hm.value = 0;
			}
		sum.value = parseInt(hm.value) * sellPrice;		
	}
	
	// 제품 선택 후 장바구니에 보내기
	function goToCart() {
		var optionNo = document.getElementById("second-option").value;
		var qty = document.getElementById("qty").value;
		if($("#first-option").val()==''||$("#second-option").val()==''){
			alert("옵션을 선택해주세요.");
			return false;
		}
		if(confirm("장바구니 페이지로 가시겠습니까?")){
			location.href = "/carts/cart-order.do?optNo="+optionNo+"&amount=" + qty;
		} else{
			
		}
	}	
	
	// 제품 선택 후 구매하기
	function payment() {
		var optionNo = document.getElementById("second-option").value;
		var qty = document.getElementById("qty").value;
		if($("#first-option").val()==''||$("#second-option").val()==''){
			alert("옵션을 선택해주세요.");
			return false;
		}
		if(confirm("구매 페이지로 가시겠습니까?")){
			location.href = "/orders/orders.do?optNo="+optionNo+"&amount=" + qty;
		} else{
			
		}
	}
	
	// 상품 문의 게시판에 아이템 번호 보내기
	function sendNo() {
		location.href = "/itemBoard/form.do?itemQuestionNo="+${item.no}+"&load=item";
	}
	
	var ageField = document.getElementById("review-age");
	var heightField = document.getElementById("review-height");
	var weightField = document.getElementById("review-weight");
	var contentField = document.getElementById("review-contents");
	var photoField = document.getElementById("review-photo");
	
	var ageWarning = document.getElementById("review-age-warning");
	var heightWarning = document.getElementById("review-height-warning");
	var weightWarning = document.getElementById("review-weight-warning");
	var contentWarning = document.getElementById("review-content-warning");
	var photoWarning = document.getElementById("review-photo-warning");
	
	
	
	document.getElementById("review-add-form").onsubmit = function() {
		
		/*
		ageWarning.textContent ="";
		heightWarning.textContent="";
		weightWarning.textContent="";
		photoWarning.textContent="";		
		contentWarning.textContent="";
		*/
		
		if (ageField.value == "") {
			//ageWarning.textContent="나이를 입력해주세요";
			ageField.focus();
			alert("나이를 입력해주세요")
			return false;
		}
		if (heightField.value == ""){
			//heightWarning.textContent="키를 입력해주세요";
			heightField.focus();
			alert("키를 입력해주세요")
			return false;
		}
		if (weightField.value == ""){
		//	heightWarning.textContent="키를 입력해주세요";
			weightField.focus();
			alert("무게를 입력해주세요")
			return false;
		}
		
		if (contentField.value == ""){
		//	contentWarning.textContent="리뷰 내용을 작성해주세요";
			contentField.focus();
			alert("리뷰 내용을 입력해주세요")
			return false;
		}
	
		if (photoField.value == "") {
		//	photoWarning.textContent="이미지를 올려주세요";
			alert("이미지 파일을 올려주세요")
			return false;
		}

		return true;
		
	}		
	
	function returns () {
		alert("로그인 후 작성 바랍니다.")
		location.href = "/users/cookieid.do"
	}
</script>
</html>