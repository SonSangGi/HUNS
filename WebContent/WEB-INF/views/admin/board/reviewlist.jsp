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

<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item">리뷰 관리</li>
			</ol>

			<div class="card">
				<div class="card-header">리뷰 정보</div>
				<div class="card-body">
					<div class="alert alert-dark" style="margin-bottom: 0px">
						<button class="btn btn-danger btn-sm" onclick="delRev();">삭제</button>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-sm table-hover"
							width="100%" cellspacing="0" style="font-size: 14px; margin: 0px" id="dataTable">
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheck"></th>
									<th>아이디</th>
									<th>품명</th>
									<th>내용</th>
									<th>평점</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody id="review-content">
								<c:forEach items="${reviews }" var="review">
									<tr id="review${review.no}">
										<td><input type="checkbox" name="reviewCheck" value="${review.no }"></td>
										<td>${review.user.id}</td>
										<td>${review.item.name }</td>
										<td><a href="/reviews/photoreview.do?modalreviewNo=${review.no}" target="_blank">${review.contents }</a></td>
										<td>${review.score}</td>
										<td><fmt:formatDate value="${review.createDate }"
												pattern="yyyy-MM-dd" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="alert alert-dark" style="margin-bottom: 0px"></div>
					</div>
				</div>
			</div>
			<!--카드 끝-->
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->
	
	<%@include file="../include/footer.jsp"%>
</body>
<script>
	$("#allCheck").click(function() {
		var chk = $(this).is(":checked");//.attr('checked');
		if (chk) {
			$("input:checkbox[name=reviewCheck]").prop('checked', true);
		} else
			$("input:checkbox[name=reviewCheck]").prop('checked', false);
	});
	
	function delRev(){
		var value = "";
		$("input:checkbox[name=reviewCheck]").each(function(){
			var check = $(this).is(":checked")
			if(check){
				value += $(this).val()+",";
			}
			console.log(value);
		})
		 $.ajax({
			url: "delRev.do",
			type: "post",
			data: {"delRevNo":value},
			success:function(result){
				if(result.result=="OK"){
					alert("리뷰가 삭제 되었습니다.");
					window.location.reload();
				} else{
					alert("삭제처리중 오류가 발생하였습니다.")
				}
			}
		})	 	
	}

</script>
</html>