<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<title>Insert title here</title>
</head>
<body>
<%@include file="../include/header.jsp" %>
	
	 <div id="content-wrapper" style="max-width: 1000px;" class="pull-center">
            <div class="container-fluid">

                <!-- Breadcrumbs-->
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="#">Dashboard</a>
                    </li>
                    <li class="breadcrumb-item active">Tables</li>
                </ol>

                <div class="card">
                    <div class="card-header">회원 정보조회</div>
                    <div class="card-body">
                       <div class="ml-5 mr-5">
                        <form class="form-group">
                            <div class="form-item">
                                <label>검색</label>
                                <select class="form-control">
                                    <option value="a" selected>전체</option>
                                    <option value="a">이름</option>
                                    <option value="a">번호</option>
                                    <option value="a">주소</option>
                                    <option value="a">등록</option>
                                </select><br>
                            </div>
                                 <div class="input-group">
                <input type="text" class="form-control" placeholder="검색" aria-label="table-search" aria-describedby="basic-addon2">
                <div class="input-group-append">
                    <button class="btn " type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
                        </form>
                        </div>
                        <hr>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <!-- id에 js에서 설정한 값-->
                                <thead>
                                    <tr>
                                        <th>이름</th>
                                        <th>아이디</th>
                                        <th>주소</th>
                                        <th>전화번호</th>
                                        <th>등록일</th>
                                        <th>등급</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>이름</th>
                                        <th>아이디</th>
                                        <th>주소</th>
                                        <th>전화번호</th>
                                        <th>등록일</th>
                                        <th>등급</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <tr>
                                        <td>정인혁</td>
                                        <td>jih3000</td>
                                        <td>수원</td>
                                        <td>010-0000-0000</td>
                                        <td>2018-10-19</td>
                                        <td class="text-center"><i class="fas fa-angry"></i></td>
                                    </tr>
                                    <tr>
                                        <td>김영환</td>
                                        <td>kyh3201</td>
                                        <td>서울</td>
                                        <td>010-0000-0000</td>
                                        <td>2018-10-19</td>
                                        <td class="text-center"><i class="fas fa-smile-beam"></i></td>
                                    </tr>
                                    <tr>
                                        <td>김승용</td>
                                        <td>kims3332</td>
                                        <td>강릉</td>
                                        <td>010-0000-0000</td>
                                        <td>2018-10-19</td>
                                        <td class="text-center"><i class="fas fa-grin-hearts"></i></td>
                                    </tr>
                                    <tr>
                                        <td>하재성</td>
                                        <td>ha2333</td>
                                        <td>서울</td>
                                        <td>010-0000-0000</td>
                                        <td>2018-10-19</td>
                                        <td class="text-center"><i class="fas fa-grin-hearts"></i></td>
                                    </tr>
                                    <tr>
                                        <td>김진용</td>
                                        <td>kimjin22</td>
                                        <td>서울</td>
                                        <td>010-0000-0000</td>
                                        <td>2018-10-19</td>
                                        <td class="text-center"><i class="fas fa-smile-beam"></i></td>
                                    </tr>
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

<%@include file="../include/footer.jsp" %>
</body>
</html>