<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
	rel="stylesheet">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">상품 관리</a></li>
				<li class="breadcrumb-item active">주문</li>
			</ol>

			<div class="card">
				<div class="card-header">주문 정보조회</div>
				<div class="card-body">
					<hr>
					<div class="alert alert-dark" style="margin: 0px">
					<select style="margin-top: 2px;height: 27px;" id="order-selectall-box">
												<option value="입금대기">입금대기</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송준비중">배송준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
										</select>
					<button class="btn-danger btn"  onclick="allUpdateState()">일괄변경</button>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-sm" width="100%" id="dataTable" cellspacing="0" style="font-size: 14px; margin: 0px; min-height: 100px;">
							<!-- id에 js에서 설정한 값-->
							<thead>
								<tr style="background-color: floralwhite">
									<th><input type="checkbox" id="allCheck"></th>
									<th>주문일(결제일)</th>
									<th>주문번호</th>
									<th>주문자</th>
									<th style="max-width: 175px;">상품명</th>
									<th>총상품구매금액</th>
									<th>배송상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orderDetails}" var="order">
									<tr>
										<td><input type="checkbox" name="orderCheck" value="${order.order.no}"></td>
										<td><fmt:formatDate value="${order.order.createDate }" pattern="yyyy-MM-dd" /></td>
										<td>${order.order.no }</td>
										<td class="text-center">${order.order.user.name }<small class="text-primary">(${order.order.user.id })</small></td>
										<td>
   										<div data-toggle="tooltip" data-placement="left" title='
   														<div class="text-left">
														옵션: ${order.option.color }-${order.option.size }<br>
														수량: ${order.qty } <br>
														재고: ${order.option.stock }
														</div>
   										' data-html="true" style="display:block;"><span class="text-primary">${order.option.item.name }</span></div>
										</td>	
										<td><fmt:formatNumber value="${order.option.currentPrice * order.qty }" />원</td>
										<td><select style="margin-top: 2px;height: 27px;" id="order-select-box${order.order.no }" >
												<option ${order.order.state eq '입금대기'? 'selected':''} value="입금대기">입금대기</option>
												<option ${order.order.state eq '상품준비중'? 'selected':''} value="상품준비중">상품준비중</option>
												<option ${order.order.state eq '배송준비중'? 'selected':''} value="배송준비중">배송준비중</option>
												<option ${order.order.state eq '배송중'? 'selected':''} value="배송중">배송중</option>
												<option ${order.order.state eq '배송완료'? 'selected':''} value="배송완료">배송완료</option>
										</select>
										<button class=""  onclick="updateState(${order.order.no})">변경</button>
										</td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="alert alert-dark" style="margin-top: 0px">
					
					</div>
				</div>

			</div>
			<!--카드 끝-->
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->
	<script>
	$("#allCheck").click(function() {
		var chk = $(this).is(":checked");//.attr('checked');
		if (chk) {
			$("input:checkbox[name=orderCheck]").prop('checked', true);
		} else
			$("input:checkbox[name=orderCheck]").prop('checked', false);
	});
	
	$(document).ready(function(){
	    $('[data-toggle="tooltip"]').tooltip();   
	}); 
	
	var available;
	
	function allUpdateState(){
		$('input:checkbox[name="orderCheck"]:checked').each(function(){
			var value = $(this).val();
			var state = $("#order-selectall-box").val();
			updateState(value,state);
			available = false;
		})
			alert("적용되었습니다.");
			window.location.reload();
	}
	function updateState(orderNo,state){
		if(state==''||state==undefined){
			var state = $("#order-select-box"+orderNo).val();
			available = true;
		}
		$.ajax({
			url:"orderUpdate.do",
			type:"post",
			data:{"orderNo":orderNo,"state":state},
			success:function(result){
				if(result.result == "OK"&&available){
					alert("변경되었습니다.");
				}else if(result.result == "NO"){alert("오류");window.location.reload()}
			}
		})
	};
	
	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>