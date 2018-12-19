<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>주문</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  	 
  	 #header {
        width: 1140px;
        margin: 0px auto;
        padding: 20px;
        border: 1px solid #bcbcbc;
 	 }
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
	
	.button1 {background-color: #000;}
	.button2 {background-color: #ccc;}
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
  
 
    </style>
</head>
<body>

<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 210px">  

   	<h6>국내 배송 상품 주문내역</h6>
	
    <input type="hidden" id="optNos"/>
    <input type="hidden" id="qtys"/>
	
  	<table class="table table-bordered">
    	<thead>
     		<tr class="breadcrumb">
        		<th>이미지</th>
       			<th>상품정보</th>
       			<th>판매가</th>
       			<th>수량</th>
        		<th>배송비</th> 
        		<th>합계</th>		
     		</tr>
    	</thead>
    	<tbody id="book-contents">
    	
    	
    	<c:set var="totalAllPrice" value="0"/>
    	<c:set var="totalDelivery" value="0"/>
    	<c:forEach var ="order" items="${orders }">
    	<c:set var="totalPrice" value="${order.qty  * order.option.currentPrice}"/>
    	<c:set var="totalAllPrice" value="${totalAllPrice+totalPrice}"/>
    	
    	<c:set var="qty" value="${order.qty }"/>
    		<tr>
    			<td><img alt="" src="/images/items/${order.option.item.image }" style="width:100px; height:100px;"></td>
    			<td>${order.option.item.name } <br/>
    				[옵션 : ${order.option.no } ${order.option.color } / ${order.option.size }]
    			</td>
    			<td><fmt:formatNumber value="${order.option.currentPrice }"/>원</td>
    			<td>${order.qty }개</td>
    			<td>
    			<c:choose>
    				<c:when test="${order.qty * order.option.currentPrice gt 50000}">
					<c:set var="delivery" value="0"/>
    					무료
    				</c:when>
    				<c:otherwise>
						<c:set var="delivery" value="2500"/>
						<c:set var="totalDelivery" value="${totalDelivery + delivery}"/>
    					2,500원
    				</c:otherwise>
    			</c:choose>
    			</td>
    			<td><fmt:formatNumber value="${order.qty * order.option.currentPrice }"/>원</td>
    		</tr>
    		<script>
    			document.getElementById("optNos").value += '${order.option.no},';
    			document.getElementById("qtys").value += '${order.qty},';
    		</script>
    	</c:forEach>
    	</tbody>
  	</table>
  		
	<ul class="list-group" style="position:relative; top:10px;">

		<li class="list-group-item">
		[기본배송]
		 상품구매금액 <span id="order-total-price"><fmt:formatNumber value="${totalAllPrice}"/>원</span> 
		 + 
		 배송비 
		 <span id="order-total-delivery-price">
		 <fmt:formatNumber value="${totalDelivery }"/>원
		 </span> 
		 = 
		 합계 : <span id="cart-all-total-price">
		 <fmt:formatNumber value="${totalAllPrice + totalDelivery}"/>
		 </span>원
		</li>

	</ul>
  		
  		
  		
	<div>
		
		<button class="btn btn-default" style="position:relative; left:1030px;"><a href="/home.do">쇼핑계속하기</a></button>
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
			
			var bookChecks = document.querySelectorAll("input[name='bookcheck']");
			for (var i=0; i<bookChecks.length; i++) {
				var bookCheck = bookChecks[i];
				bookCheck.checked = status;
				
			}
		}
		
	
		document.querySelector("#btn-del-selected").onclick = function(event) {
			
			var bookchecks = document.querySelectorAll("input[name='bookcheck']");
			
			var querystring = "";
			bookchecks.forEach(function(checkbox, index) {
				if (checkbox.checked) {
					var no = checkbox.value;
					querystring += "orderno=" + no + "&"
				}	
			});
			
			
			
			location.href = "deletemany.do?" + querystring;
		}
		
	</script>
	

<!-- 결제금액 JS --> 

<script type="text/javascript">
var sample = ${totalAllPrice}
function updateSummaryPrice(orderNo) 	{
		
	var price = document.getElementById("price-" + orderNo).textContent;
	var count = document.getElementById('count-' + orderNo).value;
	var total = price * count;
	
	if (total >= 50000) {
		document.getElementById("delivery-price-" + orderNo).textContent = '무료';
	} else {
		document.getElementById("delivery-price-" + orderNo).textContent = 2500;
	}
	
	document.getElementById("summary-price-" + orderNo).textContent = total;
	
	updateTotalPrice();
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
	
	document.getElementById("order-total-price").textContent = totalSummaryPrice;
	document.getElementById("order-total-delivery-price").textContent = totalDeliveryPrice;
	document.getElementById("order-all-total-price").textContent = totalSummaryPrice + totalDeliveryPrice;
	
}

</script>	 
				
<!--<p>결제수단</p>  -->

		<div id= "header"class="" style="position:relative; bottom: -100px;">
			<div class="form-group">			
  				<label class="radio-inline">
  					<input type="radio" name="" value="" checked/> 무통장 입금
  				</label>
  				<label class="radio-inline">
  					<input type="radio" name="" value="" disabled/> 에스크로(실시간 계좌이체)
  				</label>
           		<label class="radio-inline">
  					<input type="radio" name="" value="" disabled/> 휴대폰 결제
  				</label>
           		<label class="radio-inline">
  					<input type="radio" name="" value="" disabled/> 카드결제
  				</label>
           		<label class="radio-inline">
  					<input type="radio" name="" value="" disabled/> 페이코(간편결제)
            		<button type="button" class="btn btn-danger btn-xs" ><a href="https://www.payco.com/payco/guide.nhn">?</a></button>
  				</label>
  				
  				<strong><p style="position:relative; top: 10px;">* 최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</p></strong>
  			</div>
  			
  		<div class="container">
			<div class="row">
    			<div class="col-xs-9"></div>
   					<div class="col-xs-3" style="position:relative; bottom: 50px;">
   						<h4> 
       						<span >최종결제 금액</span> <br/>
       						<span id="cart-all-total-price"> <fmt:formatNumber value="${totalAllPrice+totalDelivery}"/>원</span>
       						<!--  <fmt:formatNumber value="${order.qty * option.currentPrice + delivery}"/> -->				
      						</h4>
      						
      					<!-- 결제버튼 클릭시 주문완료. -->
	           			<div class="">
	           				<a class="btn btn-primary" onclick="save();">결제하기</a>
	          			</div>
          			</div>
   				</div>	
  			</div>
		</div>   	
   	
   	
    <div id= "header" class="jumbotron" style="position:relative; bottom:-200px;">
    <h6>무이자 할부 이용안내</h6> 
    <p>무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 
적용되지 않습니다. 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</p> 
  	</div>
   
   <div class="">
   <div id="header" style="position:relative; bottom:-300px;">
			<h4><strong>WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.</strong></h4>
	
        	<p><a href="http://service-api.echosting.cafe24.com/shop/notice_XP_ActiveX.html">안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</a></p>
            <p><a href="https://support.microsoft.com/ko-kr/help/13858/windows-vista-service-pack-2-install">Service Pack 2에 대한 Microsoft사의 상세안내</a></p>
            <p>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다. <button>KCP Active-X</button> </p> 
      	
        	<h4><strong>아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</strong></h4>
            
            <p>KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</p>
            <p>결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능 (단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)</p>
            <p>최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다. (무통장, 휴대폰결제 포함)</p>
    	</div>
	</div>

</div>

<script type="text/javascript">
	var optNos;
	var qtys;
	function save(){
		var qtys = $("#qtys").val();
		var optNos = $("#optNos").val();
		location.href = "save.do?optNos="+optNos+"&qty="+qtys;
	}
</script>
</body>
</html>