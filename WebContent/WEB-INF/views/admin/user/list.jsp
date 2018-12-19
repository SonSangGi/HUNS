<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1400px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">회원 관리</a></li> <li class="breadcrumb-item active">회원</li>
			</ol>

			<div class="card">
				<div class="card-header">회원 정보조회</div>
				<div class="card-body">
					<hr>
					<div class="alert alert-dark" style="margin-bottom: 0px">
						<button class="btn btn-sm btn-danger" id="delUser" onclick="delUser();"> <small>탈퇴처리</small> </button>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-sm table-hover" width="100%" cellspacing="0" style="font-size: 14px" id="dataTable">
							<!-- id에 js에서 설정한 값-->
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheck"></th>
									<th>등록일</th>
									<th>이름</th>
									<th>아이디</th>
									<th>일반전화</th>
									<th>휴대전화</th>
									<th>성별</th>
									<th>나이</th>
									<th>지역</th>
									<th>이메일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${users }" var="user">
									<c:if test="${user.available eq 'Y'}">
									<tr >
										<td><input type="checkbox" name="userCheck" value="${user.no}"></td>
										<td><fmt:formatDate value="${user.createDate }" pattern="yyyy-MM-dd" /></td>
										<td>${user.name }</td>
										<td>${user.id}</td>
										<td>${user.tel }</td>
										<td>${user.phoneTel }</td>
										<td>${user.gender eq 'F' ? '여자' : '남자' }</td>
										<td>${user.age }</td>
										<td>${user.address1 }${user.address2 }</td>
										<td>${user.email }</td>
									</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!--카드 끝-->
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->
	<script>
		//체크박스 전체 선택 / 해제
		$("#allCheck").click(function() {
			var chk = $(this).is(":checked");//.attr('checked');
			if (chk) {
				$("input:checkbox[name=userCheck]").prop('checked', true);
			} else
				$("input:checkbox[name=userCheck]").prop('checked', false);
		});

		function delUser(){
			var value = "";
			$("input:checkbox[name=userCheck]").each(function(){
				var check = $(this).is(":checked")
				if(check){
					value += $(this).val()+",";
				}
				console.log(value);
			})
			 $.ajax({
				url: "delUser.do",
				type: "post",
				data: {"userNos":value,"result":"N"},
				success:function(result){
					if(result.result=="OK"){
						alert("회원탈퇴처리 되었습니다.");
						window.location.reload();
					} else{
						alert("탈퇴처리중 오류가 발생하였습니다.")
					}
				}
			})	 	
		}
		
		
	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>