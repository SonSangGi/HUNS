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
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 204px">
	<div class="row">
		<div class="col-xs-12">
			<table class="table table-hover">
			<colgroup>
				<col width="15%">
				<col width="*">
				<col width="10%">
				<col width="9%">
				<col width="9%">
			</colgroup>
    	<thead>
     		<tr class="breadcrumb">
        		<th>이미지</th>
       			<th>상품정보</th>
       			<th>판매가</th>
       			<th>리뷰평점</th>
       			<th>좋아요</th>
     		</tr>
    	</thead>
    	<tbody>
    		<c:forEach var="cookieItem" items="${cookieItems }">
    		<tr>
       			<td><a href="/stores/detail.do?no=${cookieItem.no }"><img  style="width:200px; height:200px;" src="/images/items/${cookieItem.image}" class="thumbnail"></a></td>
   				<td><a href="/stores/detail.do?no=${cookieItem.no }">${cookieItem.name }</a></td>
   				<!-- 판매가 -->
   				<td><span id="price-${cart.no }"><fmt:formatNumber value="${cookieItem.detailOption.currentPrice}"></fmt:formatNumber> </span>원</td>
   			    <td><span><fmt:formatNumber  value="${cookieItem.review.score}"></fmt:formatNumber>점</span></td>
   			    <td><span>${cookieItem.review.likes}/${cookieItem.review.likesParticipate }</span></td>
    		</tr>
 			</c:forEach>
    	</tbody>
		</table>
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