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
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-md-offset-1 col-md-6">
			<div class="panel-heading">비밀번호 변경</div>
			<div class="panal-body">
				<form method="post" action="changepwd.do" id="myinfo-form">
					<div class="form-group">
						<label>비밀번호</label>
						<input type="hidden" class="form-control" id="userno" name="userno" value="${user.no }" />
						<input type="password" class="form-control" id="password" name="password" maxlength="16" value="" placeholder="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)" />
					</div>
					<div class="form-group">
						<label>비밀번호 확인</label>
						<input type="password" class="form-control" id="conformPass" name="conformPass" maxlength="20" value="" placeholder="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)" />
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

</body>
</html>
