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
					<div class="panel-heading">비밀번호찾기</div>
					<div class="panel-body">
						<form method="post" action="findpwd.do" >
							<div class="form-group">
								<label>아이디</label>
								<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요." value="" />
							</div>
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

</html>