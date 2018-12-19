<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 로그인</title>
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">

  </head>
  <body class="bg-dark">
	 <div class="container">
	 <h1 class="text-center" style="margin-top:50px; font-size: 200px;"><i class="fas fa-cog" style="color: white;"></i></h1>
      <div class="card card-register mx-auto mt-5">
        <div class="card-header">관리자 생성</div>
        <div class="card-body">
          <form action="addAdmin.do" method="post" id="form-add">
            <div class="form-group">
              <div class="form-label-group">
                <input type="text" id="input-id" class="form-control" placeholder="아이디를 입력해주세요." required="required" name="id">
                <label for="input-id">아이디를 입력해주세요.</label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-row">
                <div class="col-md-6">
                  <div class="form-label-group">
                    <input type="password" id="input-password" class="form-control" placeholder="Password" required="required" name="password">
                    <label for="input-password">비밀번호를 입력하세요.</label>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-label-group">
                    <input type="password" id="input-check-password" class="form-control" placeholder="Confirm password" required="required">
                    <label for="input-check-password">비밀번호를 다시 입력하세요.</label>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-row">
	            <div class="col-md-6">
	            	<a class="btn btn-warning btn-block" style="color:white; font-weight: bold;" href="home.do">취소</a>
	            </div>
	            <div class="col-md-6">
	            	<a class="btn btn-primary btn-block" style="color:white; font-weight: bold;" onclick="submit();">생성</a>
	           </div>
           </div>
          </form>
        </div>
      </div>
    </div>
	
	<script>
	<c:choose>
    <c:when test="${result eq 'err'}">
    alert("이미 사용중인 아이디입니다.");
    </c:when>
    <c:when test="${result eq 'ok'}">
    alert("아이디가 생성되었습니다.");
    location.href = "/admin/main/home.do";
    </c:when>
    </c:choose>
		function submit(){
			var id = $("#input-id").val();
			var pw = $("#input-password").val();
			var pw2 = $("#input-check-password").val();
			
			if(id == ''){
				alert("아이디를 입력해주세요.");
				return false;
			}
			if(id.length < 5){
				alert("아이디를 5글자 이상 입력하세요.");
				return false;
			}
			if(pw == ''){
				alert("패스워드를 입력해주세요..");
				return false;
			}
			if(pw.length < 7){
				alert("패스워드가 너무 짧습니다.");
				return false;
			}
			if(pw != pw2){
				alert("패스워드가 일치하지 않습니다. 다시 입력해주세요.");
				return false;
			}
			$("#form-add").submit();
			
		}
	    document.addEventListener('keydown', function(event) {
	        if (event.keyCode === 13) {
	           	submit();
	        }
	    }, true);
	</script>
    <!-- Bootstrap core JavaScript-->
   <script src="../../../resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="../../../resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
   <script src="../../../resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  </body>

</html>
