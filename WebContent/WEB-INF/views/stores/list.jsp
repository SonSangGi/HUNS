<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>예시</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	.jumbotron {
		background-color: #F2F2F2;
		border: 1px solid;
		text-align: center;
		font-size: 35px;
	}
	.buttons {
		margin-top: 30px;
	}
	.button {
		background-color: white;
		border: 1px solid;
		font-size: 14px;
		width: 125px;
		height: 35px;
		margin-left: 4px;
		cursor: pointer;
		color: #333;
		transition:all 0.9s, color 0.3;
	}
	.button:hover{
		color: white;}
	.hover1:hover {
		box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset,
				-200px 0 0 0 rgba(0,0,0,0.25) inset;
	}
	
	.orders {
		margin-bottom: 40px;
	}
	.order {
		background-color: white;
		border: 1px solid;
		margin-left: 7px;
	}	 
	.cloth {
		font-size: 20px;
	}
	.line {
		text-decoration: line-through;
	}
	#myCarousel {
		width: 300px;
		height: 75px;
	}
</style>
</head>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container" style="padding-top: 205px;">
<form id="form-order" method="get" action="list.do">
	<input type="hidden" id="cp-field" name="cp" value="${param.cp }" />
	<input type="hidden" id="order-field" name="order" value="${param.order }" >
	<input type="hidden" id="cat-field" name="category" value="${param.category }" >
	<input type="hidden" id="sub-field"  name="subCategory" value="${param.subCategory }">
	<div class="row">
		<div class="col-xs-offset-1 col-xs-10">
			<div class="jumbotron text-center">
				${cateName.contents }
				<br>
				<div class="buttons">
			   <!--	<button onclick="pageAndSort()" value="cloth1" name="target" class="button hover1" ${param.target eq cloth1 ? 'selected' : '' }><strong>자켓</strong></button>
					<button onclick="pageAndSort()"	value="cloth2" name="target" class="button hover1" ${param.target eq cloth2 ? 'selected' : '' }><strong>가디건</strong></button>
					<button onclick="pageAndSort()" value="cloth3" name="target" class="button hover1" ${param.target eq cloth3 ? 'selected' : '' }><strong>항공점퍼/블루종</strong></button>
					<button onclick="pageAndSort()" value="cloth4" name="target" class="button hover1" ${param.target eq cloth4 ? 'selected' : '' }><strong>코트</strong></button>
					<button onclick="pageAndSort()" value="cloth5" name="target" class="button hover1" ${param.target eq cloth5 ? 'selected' : '' }><strong>점퍼</strong></button>
					<button onclick="pageAndSort()" value="cloth6" name="target" class="button hover1" ${param.target eq cloth6 ? 'selected' : '' }><strong>패딩/봄버</strong></button> -->
					 
					<c:forEach var="categorys" items="${categorys }">
						<button onclick="changeCategory('${param.category }', '${categorys.no}');" class="button hover1"><strong  ${param.subCategory eq categorys.no ? 'style="color:red; !important;"' : '' } >${categorys.contents }</strong></button>
					</c:forEach>
				
				</div>
			</div>
			<div class="body">
				<div class="row">
					<div class="col-xs-12">
					<div class="orders text-right">		
						<button onclick="changeOrder('newp');" class="order"  ${empty param.order or param.order eq 'newp' ? 'style="color:blue !important;"' : '' }>신상품</button>
						<button onclick="changeOrder('pop');" class="order" ${param.order eq 'pop' ? 'style="color:blue !important;"' : '' }>인기상품</button>
						<button onclick="changeOrder('min');" class="order" ${param.order eq 'min' ? 'style="color:blue !important;"' : '' }>낮은가격</button>
						<button onclick="changeOrder('max');" class="order" ${param.order eq 'max' ? 'style="color:blue !important;"' : '' }>높은가격</button>							
					</div>	
					<div class="row">
						<div class="col-xs-12">
							<c:forEach var="item" items="${items }">
								<div class="col-xs-4" style="margin-top: 15px;">
									<div>
		 								<a href="/stores/detail.do?no=${item.no }"><img src ="<c:out value='${pageContext.request.contextPath}' />/images/items/${item.image}" style="width: 275px; height: 325px;"></a>
		 								<div class="caption">
		 								<br>
		 									<div>
		 										<div class="cloth"><a href="/stores/detail.do?no=${item.no }"><strong>${item.name }</strong></a></div>
		 										<span class="help-block"> color: ${item.colorCount }가지 / size: ${item.sizeCount }가지 </span> 
		 										<div class="line"><span class="help-block">${item.price}</span></div>
		 										<div class="cloth"><span style="color:red">SALE! <!--<span class="glyphicon glyphicon-circle-arrow-down"></span>--><img src="https://static.thenounproject.com/png/743651-200.png" style="width: 30px; height: 30px;"></span>&nbsp;&nbsp;${item.optCurrentPrice }원</div> 
		 									</div>	
		 								</div>
		 							</div>		
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				</div>
			</div>
			<hr>
		</div>
		
		<div class="col-xs-1">
			<div>
					
		    </div>
		</div>	
	</div>
	<div class="row">
		<div class="col-xs-offset-3 col-xs-6" style="text-align: center;">
			<ul class="pagination">
			
			<c:if test="${pagination.currentBlock gt 1 }">
				<li><a href="javascript:changePage(${pagination.prevBlock })">&laquo;</a></li>
			</c:if>
			
			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
				<li class="${num eq pagination.cp ? 'active' : ''} }"><a href="javascript:changePage(${num })">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
				<li><a href="javascript:changePage(${pagination.nextBlock })">&raquo;</a></li>
			</c:if>
			
			</ul>
		</div>
	</div>
</form>	
</div>
</body>
<script type="text/javascript">
	function changeCategory(categoryNo,subcategoryNo) {
		document.getElementById("cat-field").value = categoryNo; 	
		document.getElementById("cp-field").value = 1; 	
		document.getElementById("sub-field").value = subcategoryNo;
		document.getElementById("order-field").value = 'newp'; 	
		
		document.getElementById("form-order").submit();
	}
	
	function changeOrder(orderType) {	
		document.getElementById("cp-field").value = 1; 	
		document.getElementById("order-field").value = orderType; 	
		
		document.getElementById("form-order").submit();
		
	}
	
	function changePage(cp) {	
		cp = cp || 1;
		document.getElementById("cp-field").value = cp; 	
		
		document.getElementById("form-order").submit();
		
	}
</script>
</html>