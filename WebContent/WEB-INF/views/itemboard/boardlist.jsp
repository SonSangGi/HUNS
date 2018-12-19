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
<style type="text/css">
#top-menu-Font{
	text-indent: 0px;
    font: 12px verdana,굴림;
    text-align: left;
    word-break: break-all;
}
#top-menu{
	width: 100%; 
	height: 48px;
	text-align: center;
	border-bottom: 1px solid #999;
	border-left: 1px solid #999;
	border-top: 1px solid #999;
	margin: 22px auto;
	
}
#col-xs-3 {
	position: relative;
    min-height: 1px;
    width: 25%;
    float: left;
}
table td{
	padding: 15px 0;
    border-top: 1px dotted #e3e3e3;
    line-height: 140%;
    text-align: center;
    vertical-align: middle;
}
th{
	text-align: center;
}

#table-font{
	text-align: center;
    font: 9px 'Open Sans',sans-serif;
    font-weight: 600;
    color: #555;
    text-transform: uppercase;
    letter-spacing: 2px;
    vertical-align: middle;
    padding: 10px;
}
#table-itemtitle{
	font: 11px verdana,돋움;
    color: #aaa;
    text-indent: 0px;
    display: block;
    padding: 0 0 5px;
    letter-spacing: -1px;
}
#number{
	font: 9px tahoma;
	vertical-align: middle;
}
#thumb{
	width: 70px;
    overflow: hidden;
    text-align: center;
    vertical-align: middle;
}
#subject{
	text-indent: 0px;
    font: 12px verdana,굴림;
    text-align: left;
    word-break: break-all;
    vertical-align: middle;
}
#writer{
	font: 11px verdana,돋움;
	vertical-align: middle;
}
#date{
	font: 9px tahoma;
	vertical-align: middle;
}
#content-menu{
	height: 45px;
	/* 
	border-bottom: 1px solid #dbdad8;
	border-top: 1px solid #dbdad8;
	vertical-align: middle;
	 */
    padding-top: 10px;
    font: 13px/14px verdana;
	
}
#formBtn{
	display: inline-block;
    font: normal 11px 돋움;
    letter-spacing: -1px;
    cursor: pointer;
    padding: 8px 18px 6px;
    border: #555 1px solid;
    background: #3c3c3c;
    color: #fff;
}
a:link { 
	 color: #555; 
	text-decoration: none;
}
a:visited { 
	 color: #555;  
	text-decoration: none;
}
a:hover { 
	 color: #555;  
	text-decoration: none;
}
</style>
</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 195px">
	<div class="row">
		
		<%-- <c:if test="${param.fail eq 'secret' }">
			<div class="col-xs-offset-4 col-xs-4">
				<div class="alert alert-danger text-center" id="fail">
					<strong>비밀글</strong>이므로 접근 불가능
				</div>
			</div>
			
		</c:if> --%>
		
		<form action="list.do" method="get" id="itemQuestion-form">
		<div class="col-xs-12" id="content-menu">
		<input type="hidden" id="cp-box" name="cp" value="1" />
		
			<select onchange="itemQuestionSearch();" style="height: 25px; width: 170px;" name="title">
					<c:set var="typeno" value="${param.title }"></c:set>
					<!-- 세션 이름 받아서또는 유저이름 받아서 -->
					<c:forEach var="type" items="${types }">
						<option value="${type.no }" ${typeno == type.no ? 'selected':'' }>${type.contents }</option>
					</c:forEach>
					</select>
					
		</div>
		<div class="col-xs-12">
			<table class="table table-striped" id="table-font">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="*%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>NO</th>
						<th>ITEM</th>
						<th class="text-center">SUBJECT</th>
						<th>NAME</th>
						<th>DATE</th>
					</tr>
				</thead>		
				<tbody id="category-table">
					<c:forEach var="board" items="${boards }">
						<tr>
							<td id="name">${board.no }</td>
							<!-- 이미지 -->
							<c:choose>
							  <c:when test="${not empty board.filename}">
							      <td id="thumb">
									<span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
								</td>
							  </c:when>
							
							  <c:when test="${empty board.filename}">
							      <td id="thumb"></td>	
							  </c:when>
							</c:choose>
							<!-- glyphicon glyphicon-lock -->
							<td id="subject">
								<c:if test="${'S' eq board.secret.toUpperCase() }">
									<span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
								</c:if>
								<a href="#" id="board-link-${board.no }">${board.user.name}고객님의 ${board.itemQuestionType.contents }입니다.</a></td>
							<td id="writer">${board.user.name }</td>
							<td id="date"><fmt:formatDate value="${board.createDate }"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-xs-12">
			<div>
				<a href="form.do?load=board" class="pull-right" id="formBtn">글쓰기</a>
			</div>
		</div>
		<div class="text-center">
			<ul class="pagination">
			
			<c:if test="${pagination.currentBlock gt 1 }">
				<li><a href="javascript:itemQuestionSearch(${pagination.prevBlock })">&laquo;</a></li>
			</c:if>
			
			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
				<li class="${num eq pagination.cp ? 'active' : ''}"><a href="javascript:itemQuestionSearch(${num })">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
				<li><a href="javascript:itemQuestionSearch(${pagination.nextBlock })">&raquo;</a></li>
			</c:if>
			
			</ul>
			
		</div>
		<div class="col-xs-12">
			<div>
				<select name="opt" style="margin-top: 11px; height: 26px;">
					<option value="titlename" ${param.opt eq 'titlename' ? 'selected': '' } >제목</option>
					<option value="contents" ${param.opt eq 'contents' ? 'selected': '' }>내용</option>
					<option value="id" ${param.opt eq 'id' ? 'selected': '' }>아이디</option>
					<option value="write" ${param.opt eq 'write' ? 'selected': '' }>글쓴이</option>
				</select>
				<input type="text" id="" name="keyword" value="${param.keyword }"/>
				<button onclick="itemQuestionSearch();" style="color: black; background-color: white;">찾기</button>
			</div>
		</div>
		</form>
	</div>
	<div class="col-xs-12">
			<h2>
				<img src="../images/itemQuestions/boardcenter.png" alt="상품문의" style="width: 1140px;" >
			</h2>
	</div>
</div>
<script type="text/javascript">
	
	function itemQuestionSearch(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		var scmove = $('#table-font').offset().top;
		$('html, body').animate( { scrollTop : scmove }, 400 );
		document.getElementById("itemQuestion-form").submit();
			
		
	}
	var formBtn = document.getElementById("formBtn");
	formBtn.onclick = function(evnet){
		location.href='form.do';
		
	}
	
	
	$('a[id^=board-link]').click(function(){
		var boardno = $(this).attr('id').replace('board-link-', '');
		$.ajax({
			data : {boardno:boardno},
			url : 'befordetail.do',
			type : 'get',
			success : function(result){
				if(result.fail == true){
					location.href="redirect:/users/loginform.do?fail=deny";
					return;
				}
				if(result.result == false){
					alert("비밀글입니다.");
					return;
				}
				location.href = "detail.do?boardno="+boardno;
			},
			error: function(xhr, status, error) {
	            alert(error);
			}
		});
		return false;
	});

</script>
</body>
</html>