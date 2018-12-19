<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
  .container {
	padding-top: 198px;
	box-sizing: border-box;
	}
	
  </style>
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-md-offset-4 col-md-4">
			<c:choose>
				<c:when test="${param.fail eq 'check' }">
					<div class="alert alert-danger">
						<strong>확인 실패</strong> 가입 된 아이디가 없습니다.
					</div>
				</c:when>
			</c:choose>
					<div class="panel panel-info">
					<div class="panel-heading">아이디찾기</div>
					<div class="panel-body">
						<form method="post" action="findid.do" id="findid-form">
							<div class="form-group">
								<label>이름</label>
								<input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력하세요." value="" />
							</div>
							<div class="form-group">
								<label>이메일로 찾기</label>
								<input type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요." value=""/>
							</div>
							<div class="text-right">
								<input type="submit" class="btn btn-romi" value="확인" id="submit-btn">				
							</div>
						</form>					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
document.getElementById("findid-form").onsubmit = function() {

	if(document.getElementById("name").value == "") {
		alert("이름을 입력하지 않았습니다.");
		document.getElementById("name").focus();
		return false;
	}
	if(document.getElementById("name").value.length<2) {
		alert("이름을 2글자 이상 입력해주세요.")
		document.getElementById("name").focus()
		return false;
	}
	//이메일 공백체크
	if(document.getElementById("email").value == "") {
		alert("이메일을 입력하지 않았습니다.")
		document.getElementById("email").focus()
		return false;
	}
	return true;
}

</script>
</html>