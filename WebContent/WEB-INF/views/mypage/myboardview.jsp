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
a:link { 
	color: black;
	text-decoration: none;
	
}
#sort-btn:visited { 
	color: #7ca6d8;
	text-decoration: none;
}
a:hover { 
	color: black; 
	text-decoration: none;
}
#opt-btn{
	padding: 2px 7px;	
    color: black;
    background-color: white;
    /* border: 1px solid #999; */
}
input,select,button{
	font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}
th {
	text-align: center;
}
table td {
    padding: 11px 0 9px;
    border-top: 1px dotted #e3e3e3;
    line-height: 140%;
    vertical-align: middle;
}
</style>

</head>
<body>
<%@ include file="../include/header.jsp"%>
<div class="container" style="padding-top: 204px">
	<form action="mypageview.do" method="get" id="form-btn">
		<div class="row">
			<div class="col-xs-4" style="padding: 21px 16px;">
				
				<div style="display: inline;">분류선택</div>
				<select name="category" style="height: 27px;" onchange="boardreview();">
					<option value="review" ${param.category eq 'review' ? 'selected':'' }>리뷰 쓴 글</option>
					<option value="question" ${param.category eq 'question' ? 'selected':'' }>문의 쓴 글</option>
				</select>
				
			</div>
			<div class="col-xs-8">
			
			</div>
			<div class="col-xs-12">
				<table class="table table-condensed">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="*%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					
					<c:choose>
						<c:when test="${not empty reviews }">
							<tr style="background-color: #f7f6f6; ">
								<th>번호</th>
								<th>분류</th>
								<th>내용</th>
								<th>작성자</th>
								<th>작성일</th>
								<th></th>
							</tr>
							<c:forEach var="review" items="${reviews }" >
								<tr>
									<td style="text-align: center;">${review.no }</td>
									<td style="text-align: center;" id="sort-btn">리뷰작성글</td>
									<td><a href="/reviews/photoreview.do?modalreviewNo=${review.no }" target="_blank">${review.contents }</a></td>
									<td style="text-align: center;">${review.user.name }</td>
									<td style="text-align: center;"><fmt:formatDate value="${review.createDate }"/></td>	
									<td>
										<div onclick="delRev(${review.no });" class="btn-xs btn-danger" style="color:orange; font-weight:bold; text-align:center; width:40px;">
											삭제	
										</div>
										<div onclick="edtRev(${review.no});"class="btn-xs btn-primary" style="color:white; font-weight:bold; text-align:center; width:40px;">
											수정
										</div>
									</td>	
								</tr>
							</c:forEach>
						</c:when>
						<c:when test="${not empty questionviews }">
							<tr>
								<th>번호</th>
								<th>분류</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>댓글수</th>
							</tr>
							<c:forEach var="questionview" items="${questionviews }">
								<tr>
									<td style="text-align: center;">${questionview.no }</td>
									<td style="text-align: center;"><a href="/itemBoard/list.do" id="sort-btn">${questionview.itemQuestionType.contents }</a></td>
									<td><a href="/itemBoard/detail.do?boardno=${questionview.no }">${questionview.item.name }</a></td>
									<td style="text-align: center;">${questionview.user.name }</td>
									<td style="text-align: center;"><fmt:formatDate value="${questionview.createDate }"/></td>
									<td style="text-align: center;">${questionview.commentCount }</td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</table>
			</div>
			<div class="col-xs-5">
				<select name="opt"  style="height: 25px;" onchange="boardreview();">
					<option value="title" ${param.opt eq 'title' ? 'selected' : '' }>제목</option>
					<option value="content"  ${param.opt eq 'content' ? 'selected' : '' }>내용</option>
					<option value="write"  ${param.opt eq 'write' ? 'selected' : '' }>작성자</option>				
				</select>				
				<input type="text" name="keyword" id="keyword"  />
				<button type="button" onclick="boardreview();" id="opt-btn">검색</button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	function boardreview(){
		$("#form-btn").submit();
	}
	
	function delRev(revNo) {
		alert('리뷰가 삭제되었습니다.');
		location.href="/mypage/delRev.do?delRevNo="+revNo;
		
	}
	
	function edtRev(revNo) {
		location.href="/reviews/reviewedit.do?edtRevNo="+revNo;
	}
	
	
</script>
</body>
</html>