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

<title>관리자 문의 페이지</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item active">문의 관리</li>
			</ol>
			
			<div class="card">
				<div class="card-header">문의</div>
				<div class="card-body">
					<div class="alert alert-primary text-center" style="margin-bottom: 0px">
					<span><b>미답변 문의</b></span>
					</div>
					<div class="table-responsive" style="height:200px;max-height: 200px;overflow: auto;">
						<table class="table table-bordered table-sm table-hover" width="80%" cellspacing="0" style="font-size: 14px;margin:0px;">
							<thead>
								<tr>
									<th><i class="fas fa-lock"></i></th>
									<th>No</th>
									<th>분류</th>
									<th>내용</th>
									<th>작성자 번호</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${notAnswerQuestions }" var="question">
									<tr id="${question.no }">
										<td>
										<c:if test="${question.secret eq 'S'}">
										<i class="fas fa-lock"></i>
										</c:if>
										</td>
										<td>${question.no}</td>
										<td>${question.title}</td>
										<td>
											<a href="/itemBoard/detail.do?boardno=${question.no }">
												<c:choose>
													<c:when test="${fn:length(question.contents) > 30}">
													${fn:substring(question.contents,0,30) } ...
													</c:when>
													<c:otherwise>
													${question.contents }
		    								       </c:otherwise> 
												</c:choose>
											</a>
										</td>
										
										<td>${question.user.no }</td>
										<td><fmt:formatDate value="${question.createDate }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				</div>
				<hr>
					<div class="alert alert-danger text-center" style="margin-bottom: 0px;">
					<span><b>답변한 문의</b></span>
					</div>
				<div class="table-responsive"  style="max-height: 500px;overflow: auto;">
						<table class="table table-bordered table-sm table-hover" width="100%" cellspacing="0" style="font-size: 14px;margin:0px">
							<thead>
								<tr>
									<th><i class="fas fa-lock"></i></th>
									<th>No</th>
									<th>분류</th>
									<th>내용</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${AnsweredQuestions }" var="question">
									<tr id="${question.no }">
										<td>
										<c:if test="${question.secret eq 'S'}">
										<i class="fas fa-lock"></i>
										</c:if>
										</td>
										<td>${question.no}</td>
										<td>${question.title}</td>
										<td><a href="/itemBoard/detail.do?boardno=${question.no }">
										<c:choose>
											<c:when test="${fn:length(question.contents) > 30}">
											${fn:substring(question.contents,0,30) }...
											</c:when>
											<c:otherwise>
											${question.contents }
    								       </c:otherwise> 
										</c:choose></a>
										</td>
										<td>${question.user.no }</td>
										<td><fmt:formatDate value="${question.createDate }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!--카드 끝-->
		</div>
			<!--카드 끝-->
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->

	<%@include file="../include/footer.jsp"%>
</body>
</html>