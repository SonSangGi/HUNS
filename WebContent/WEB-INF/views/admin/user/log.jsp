<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;" class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"></li>
				<li class="breadcrumb-item active">Log</li>
			</ol>

			<div class="card">
				<div class="card-header">관리자/회원 기록</div>
				<div class="card-body">
					<div class="alert alert-dark" style="margin-bottom: 0px">
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-sm table-hover"
							width="100%" cellspacing="0" style="font-size: 14px; margin: 0px" id="dataTable">
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheck"></th>
									<th>아이디</th>
									<th>아이피</th>
									<th>내용</th>
									<th>접속일</th>
								</tr>
							</thead>
							<tbody id="log-content">
								<c:forEach items="${logs }" var="log">
									<tr id="log${log.no}">
										<td><input type="checkbox" name="logCheck"></td>
										<td>${log.id}</td>
										<td>${log.ip}</td>
										<td>${log.contents }</td>
										<td><fmt:formatDate value="${log.createDate }"
												pattern="yyyy-MM-dd hh:mm:ss" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="alert alert-dark" style="margin-bottom: 0px"></div>
					</div>
				</div>
				<!--카드 끝-->
			</div>
			<!--컨테이너 끝-->
		</div>
	</div>
	<!--컨텐츠 끝-->
	<script>
		$("#allCheck").click(function() {
			var chk = $(this).is(":checked");//.attr('checked');
			if (chk) {
				$("input:checkbox[name=logCheck]").prop('checked', true);
			} else
				$("input:checkbox[name=logCheck]").prop('checked', false);
		});

	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>