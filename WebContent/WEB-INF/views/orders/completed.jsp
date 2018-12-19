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
<div class="container" style="position:relative; top:300px;">
  <div class="jumbotron">
    <h1>고객님의 주문이 완료 되었습니다.</h1>      
    <p>주문내역 및 배송에 관한 안내는 주문조회 를 통하여 확인 가능합니다.</p>
  </div>
</div>
  <button class="btn btn-primary" style="position:relative; left:800px; top:300px;"><a href="/orders/saveList.do">주문조회 바로가기</a></button>
</body>
</html>