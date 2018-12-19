<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>주문조회</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" ></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 198px"> 
	<h5>주문조회</h5> 
	<div class="panel panel-default">
   		<div class="panel-heading">
   			<span>국내배송상품</span>
   		 	<!--  
   		 	<span><a href="해외배송상품 장바구니링크">취소/반품/교환 내역(0)</a></span> 
  			-->
   		</div> 
 	</div>

<!-- 기간조회 -->
<%@ include file="../orders/calendar.jsp"%>

	
<!-- 
<div class="container">
	<div class="row">
		<div class="col-md-offset-3">
			<div class="btn-group btn-group-sm">
   				<button type="button" class="btn btn-default">당일</button>
    			<button type="button" class="btn btn-default">1주일</button>
			    <button type="button" class="btn btn-default">1개월</button>
			    <button type="button" class="btn btn-default">3개월</button>
			    <button type="button" class="btn btn-default">6개월</button>
 			</div>	
 				<input type="date"/> 
				<input type="date"/>
				<button>조회</button> 
			</div>
			<div id="x" class="inline-form" method="", action="">
				<input type="hidden" name="cp" value="1"/>
				<div class="form-group"></div>
			
			</div>
			
		</div>
	</div> 	
-->	
 	
 	<ul>
 		<li>기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
 		<li>주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
 		<li>정상적으로 결제후 주문취소 및 반품/교환의 경우 게시글로 문의를 남겨주셔야 처리가능합니다.</li>
 		<li>위 사항 관련하여, 게시판 문의없이 요청하신 경우 교환/반품처리지연, 출고된 이 후에 발생되는 배송비는 고객님 부담이오니 교환/반품 접수시에 유의하시기 바랍니다.</li>	
 	</ul>
 	
 	<h5>주문상품 정보</h5>
 	
 	<table class="table table-bordered">
    	<thead>
     		<tr class="breadcrumb">
      			<th>주문일자 [주문번호]</th>
        		<th>상품정보</th>
       			<th>수량</th>
       			<th>가격</th>
       			<th>상품구매금액</th>
       			<th>주문처리상태</th>     
       			<th>리뷰작성</th>   	
     		</tr>
    	</thead>
    	<tbody>
   		<c:forEach var="orderDetail" items="${orders}">
     		<tr>
     			<td>
     				<fmt:formatDate value="${orderDetail.order.createDate }"/><br />
     				[${orderDetail.order.no}] 
     				</td>
        		<td>
        			<img src="/images/items/${orderDetail.option.item.image }" style="width: 100px; height:100px;"/>
        			<br/>
        			${orderDetail.option.item.name}<br/>
        			[옵션: [${orderDetail.option.no}] ${orderDetail.option.color }/${orderDetail.option.size } ]
        		</td>
      			<td>${orderDetail.qty } 개</td>
      			
      			<td><fmt:formatNumber value="${orderDetail.option.currentPrice }"/>원</td>
      			<td><fmt:formatNumber value="${orderDetail.qty * orderDetail.option.currentPrice }"/>원</td>

      			<td>${orderDetail.order.state }</td>
      			<td style="text-align:center;">
      			<c:choose>
      			
      				<c:when test="${orderDetail.order.state eq '입금대기'}">
      					<span>배송완료 후 리뷰를 작성하실 수 있습니다.</span>
      				</c:when>
      				<c:when test="${orderDetail.order.state eq '상품준비중'}">
      					<span>배송완료 후 리뷰를 작성하실 수 있습니다.</span>
      				</c:when>
      				<c:when test="${orderDetail.order.state eq '배송준비중'}">
      					<span>배송완료 후 리뷰를 작성하실 수 있습니다.</span>
      				</c:when>
      				<c:when test="${orderDetail.order.state eq '배송중'}">
      					<span>배송완료 후 리뷰를 작성하실 수 있습니다.</span>
      				</c:when>

      				<c:when test="${orderDetail.order.state eq '배송완료'}">
      					<c:if test="${orderDetail.option.reviewPass eq 'Y' }">
      						<span>리뷰 수정은 마이페이지에서 하실 수 있습니다.</span>
      					</c:if>
      					<c:if test="${orderDetail.option.reviewPass eq 'N' }">
	      					<button class="btn-md btn-primary" onclick="goreview(${orderDetail.option.no })" style="padding:10px;">리뷰 작성</button>
      					</c:if>
      					
      					<!--  
      					<c:if test="${orderDetail.reviewPassed eq 'true' }">
							<span>완</span>
      					</c:if>
      					
      					<c:if test="${orderDetail.reviewPassed eq 'false' }">
	      					<button class="btn-md btn-primary" onclick="goreview(${orderDetail.option.no })">리뷰 작성</button>
      					</c:if>
      					-->
      					
      				</c:when>

      			</c:choose>
      				
      			</td>
 
     		</tr>
    
     		</c:forEach>
  		</table>
 	
</div> 
</body>

<script>

	function goreview(reviewNo) {
		
		location.href="/reviews/reviewadd.do?no="+reviewNo;
		
	}

</script>

</html>