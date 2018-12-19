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
	<div class="jumbotron">
		<h1>회원 탈퇴</h1>
		<p>회원 탈퇴가 완료되었습니다. 다음에 다시 이용해주세요.</p>
	</div>
	<div class="col-md-12">
		<div class=text-right>
			<input type="button" class="btn btn-inverse" value="메인 화면으로" onClick="location.href='/home.do'">
		</div>
	</div>
</div>

</body>
</html>
