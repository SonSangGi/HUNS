<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>장바구니</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  	 
 	 #payment {
 	 	width: 500px;
        margin: 0px auto;
        padding: 20px;
        border: 1px solid #bcbcbc;
 	 }

    .center {
    text-align: center;
	}
	
	.button {
   		background-color: #4CAF50;
  	 	border: none;
   		color: white;
   	 	padding: 15px 32px;
  	  	text-align: center;
  		text-decoration: none;
    	display: inline-block;
   		font-size: 16px;
   		margin-left: auto;
   		margin-right: auto;
    	cursor: pointer;
   	 
	}
	
	.button1 {background-color: blue;}
	.button2 {background-color: crimson;}
	.button3 {background-color: #fff;
				color: black;
				border: 1px solid #e7e7e7;}

	.button:hover {
   		 box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}
	
	#footer {
        width: 1140px;
        margin: 0px auto;
        padding: 20px;
        border: 1px solid #bcbcbc;
        
  	}
  
  	.center {
    	text-align: center;
	} 
    </style>
</head>
<body>

<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 210px">  
	<div class="panel panel-default">
   		<div class="panel-heading">
   		<c:forEach var="cart" items="${carts}" begin="1" end="1">
   			<span><a href="/carts/cart.do">국내배송상품(${carts.size() })</a></span> 		
   		 	<span><a href="/carts/cart-empty.do">해외배송상품(0)</a></span> 
   		 </c:forEach>	
   		 	<span>장바구니에 담긴 상품은 14일 동안 보관됩니다.</span>
   		</div> 
 	</div>
 
 	<c:forEach var="cart" items="${carts}" begin="1" end="1">
		<p class="success"> 일반상품( ${carts.size() }) </p>
 	</c:forEach>

	<form action="/orders/cart-order.do" id="cart-order-form">
  	<table class="table table-bordered">
    	<thead>
     		<tr class="breadcrumb">
      			<th><input type="checkbox" id="all-check"/></th>
        		<th>이미지</th>
       			<th>상품정보</th>
       			<th>판매가</th>
       			<th>수량</th>
        		<th>배송구분</th>
        		<th>배송비</th> 
        		<th>합계</th>		
        		<th>선택</th>
     		</tr>
    	</thead>
    	<tbody id="book-contents">
    		<c:set var="totalPrice" value="0"></c:set>
    		<c:set var="deliveryPrice" value="0"></c:set>
			<c:forEach var="cart" items="${carts}">
    		<tr id="row-${cart.no }">
      			<td><input type="checkbox" name="cartno" value="${cart.no}"/></td>
        		<td><img onclick="getCartOrderDetatil(${cart.option.item.no })" style="width:100px; height:100px;" src="/images/items/${cart.option.item.image }" class="thumbnail"></td>
      			<td>
      			${cart.option.item.name } <br/> 
      			[옵션: ${cart.option.no } ${cart.option.color } / ${cart.option.size}]   			
      			</td>
      			<!-- 판매가 -->
      			<td><span id="price-${cart.no }">${cart.option.currentPrice}</span>원</td>
      			<!-- 수량 -->
      			<td>
      				<input type="number" name="amount" id="count-${cart.no }" value="${cart.count }" style="width: 50px;">
					<button type="button"onclick="updateSummaryPrice(${cart.no})" value="${cart.count }" id="count-submit${cart.no}">변경</button>      			
      			</td>
        		<td>기본배송</td>
        		
        		 <!--배송비 조건-->
        		<td>
        		<c:choose>
        			<c:when test="${cart.option.currentPrice * cart.count < 50000}">
        				<c:set var="deliveryPrice" value="${deliveryPrice + 2500 }"></c:set>
        				<span id="delivery-price-${cart.no }">2500</span>
        			</c:when>
        			<c:when test="${cart.option.currentPrice * cart.count >= 50000}">
        				<span id="delivery-price-${cart.no }">무료</span>
        			</c:when>
        		</c:choose>
        		
        		<c:set var="totalPrice" value="${totalPrice +  cart.option.currentPrice * cart.count }"></c:set>	
        		</td>
        		
        		 <!-- 합계 -->
        		<td>
        			<span id="summary-price-${cart.no }">${cart.option.currentPrice * cart.count }</span>원
        		</td>
        		
        		<td>
        		
        		<a href="/orders/orders.do?optNo=${cart.option.no }&amount=${cart.count}" class="btn btn-default">주문하기</a>
        		<a href="delete.do?cartno=${cart.no }" class="btn btn-default">삭제</a>
        		</td>
        		
     		</tr>
 		</c:forEach>
  		</table>
  		</form>
		<div>
			<button id="btn-del-selected" type="button" class="btn btn-default" style="position:relative; left:0spx;">선택삭제</button>
			<a href="deleteAll.do" class="btn btn-default" style="position:relative; left:925px;">장바구니 비우기</a>
		</div>
	
<!-- 선택삭제, 전체삭제 JS -->
<script type="text/javascript">
	/* 	var deleteButtons = document.querySelectorAll("button[id^='btn-del']");
		for (var i=0; i<deleteButtons.length; i++) {
			var deleteBtn = deleteButtons[i];
			
			deleteBtn.onclick = function(event) {
				var bookNo = event.target.getAttribute("id").replace("btn-del-","");
				var tr = document.getElementById("row-" + bookNo);
				var tbody = document.getElementById("book-contents");
				
				tbody.removeChild(tr);
			}
		} */
		
		
		var allCheckbox = document.getElementById("all-check");
		allCheckbox.onchange = function() {
			var status = allCheckbox.checked;
			
			var bookChecks = document.querySelectorAll("input[name='cartno']");
			for (var i=0; i<bookChecks.length; i++) {
				var bookCheck = bookChecks[i];
				bookCheck.checked = status;
				
			}
		}
		
	
		document.querySelector("#btn-del-selected").onclick = function(event) {
			
			var checked = false;
			$("input:checkbox[name='cartno']").each(function(){
				var check = $(this).is(":checked");
				if(check){
					checked = check;
				}
			})
			if(checked){
			} else{
				alert("삭제하실 상품을 선택해주세요.")
				return false;
			}
			
			
			var bookchecks = document.querySelectorAll("input[name='cartno']");
			
			var querystring = "";
			bookchecks.forEach(function(checkbox, index) {
				if (checkbox.checked) {
					var no = checkbox.value;
					querystring += "cartno=" + no + "&"
				}	
			});
			alert("삭제되었습니다.");
			location.href = "deletemany.do?" + querystring;
		}
		
	</script>


 		<ul class="list-group" style="position:relative; top:10px;">
				<li class="list-group-item">
				[기본배송]
				 상품구매금액 <span id="cart-total-price">${totalPrice }</span>원 + 배송비 <span id="cart-total-delivery-price">${deliveryPrice }</span>원 = 합계 : <span id="cart-all-total-price">${totalPrice + deliveryPrice }</span>원
				</li>
		</ul>


   		<table class="table table-bordered" style="position:relative; top:10px;">
    		<thead>
     			<tr class="breadcrumb">
        			<th>총 상품금액</th>
       				<th>총 배송비</th>
       				<th>결제예정금액</th>
       			</tr>
    		</thead>
    		<tbody>
     			<tr>
        			<td> <span id="cart-total-price2">${totalPrice }</span>원</td>	
      				<td> <span id="cart-total-delivery-price2">${deliveryPrice }</span>원</td>	
      				<td> <span id="cart-all-total-price2">${totalPrice + deliveryPrice }</span>원</td>
     			</tr>
     		</tbody>
  		</table>
<!-- 결제금액 JS --> 

<script type="text/javascript">

function updateSummaryPrice(cartNo) 	{
		
	var price = document.getElementById("price-" + cartNo).textContent;
	var count = document.getElementById('count-' + cartNo).value;
	var total = price * count;
	
	if (total >= 50000) {
		document.getElementById("delivery-price-" + cartNo).textContent = '무료';
	} else {
		document.getElementById("delivery-price-" + cartNo).textContent = 2500;
	}
	
	document.getElementById("summary-price-" + cartNo).textContent = total;
	
	updateTotalPrice();
	
	$.ajax({
		url:"/carts/update.do",
		type:"get",
		data:{"count":count,"cartNo":cartNo},
		success:function(result){
			if(result.result == 'OK'){
				alert("변경되었습니다.");
			} else{
				alert("DB오류");
			}
		}
	});
}

function updateTotalPrice() {
	
	var summaryItems = document.querySelectorAll("[id^='summary-price']");
	var deliveryItems = document.querySelectorAll("[id^='delivery-price']");
	
	var totalSummaryPrice = 0;
	var totalDeliveryPrice = 0;
	
	for (var i=0; i<summaryItems.length; i++) {
		var item = summaryItems[i];
		var summaryPrice = parseInt(item.textContent);
		totalSummaryPrice += summaryPrice;
	}
	
	for (var j=0; j<deliveryItems.length; j++) {
		item = deliveryItems[j];
		var deliveryPrice = parseInt(item.textContent);
		if (deliveryPrice) {
			totalDeliveryPrice += deliveryPrice;
		}
	}
	
	document.getElementById("cart-total-price").textContent = totalSummaryPrice;
	document.getElementById("cart-total-delivery-price").textContent = totalDeliveryPrice;
	document.getElementById("cart-all-total-price").textContent = totalSummaryPrice + totalDeliveryPrice;
	document.getElementById("cart-total-price2").textContent = totalSummaryPrice;
	document.getElementById("cart-total-delivery-price2").textContent = totalDeliveryPrice;
	document.getElementById("cart-all-total-price2").textContent = totalSummaryPrice + totalDeliveryPrice;
	
}

function selectedOrder() {
	var checked = false;
	$("input:checkbox[name='cartno']").each(function(){
		var check = $(this).is(":checked");
		if(check){
			checked = check;
		}
	})
	if(checked){
	document.getElementById("cart-order-form").submit();
	} else{
		alert("주문하실 상품을 선택해주세요.")
	}
}

function allOrder() {
	var bookChecks = document.querySelectorAll("input[name='cartno']");
	for (var i=0; i<bookChecks.length; i++) {
		var bookCheck = bookChecks[i];
		bookCheck.checked = true;
	}
	document.getElementById("cart-order-form").submit();
}

</script>	 
		
 	    
 
  		<div class="buttons" style="text-align: center;">
			<button class="button button1" style="font-size: 13px; padding: 10px; position:relative; left:50px;" onclick="selectedOrder()">선택상품주문</button>
			<button class="button button2" style="font-size: 13px; padding: 10px; position:relative; left:50px;" onclick="allOrder()">전체상품주문</button>
			<button class="button button3" style="font-size: 13px; padding: 10px; position:relative; left:420px;"><a href="/home.do">쇼핑계속하기</a></button>
		</div>
		<div id="footer" style="position:relative; top:10px;">
    	<h4 class="center">장바구니 이용안내</h4>
    		<p class="center"> 해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다. <br/>
      			해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다. <br/>
      			선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다. <br/>
    			[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다. <br/>
       			 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.
       		</p>
       			 
       		<h4 class="center">무이자할부 이용안내</h4>
       		
       		<p class="center">상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다. <br/>
       		   [전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다. <br/>
       		      단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.
       		</p>   
     </div>
		
</div>
   
</body>
</html>