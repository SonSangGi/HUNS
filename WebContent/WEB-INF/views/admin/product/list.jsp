<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
.text-stick {
	margin: 0px;
	padding: 0px;
	border: 0px;
}
.search-fixed{
	position: fixed; top: 0px; left: 214px; width: 64.4%; z-index: 100; background-color: white; overflow: hidden; border-bottom:1px solid silver
}
</style>

<title>Insert title here</title>
</head>
<body id="page-top">
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">상품관리</a></li>
				<li class="breadcrumb-item active">상품 조회</li>
			</ol>

			<div class="card">
				<div class="card-header">상품 조회</div>
				<div class="card-body">
						 <div class="ml-5 mr-5 text-center" id="search-box">

							<div class="form-row" style="max-height: 38px; margin-top: 5px;">
								<div class="form-item col-md-1">분류</div>
								<div class="col-sm-3">
									<select class="form-control" id="top-category" name="topCategory">
										<option value="0">전체</option>
										<c:forEach items="${topCategorys}" var="category">
											<option value="${category.no }">${category.contents}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-3">
									<select id="child-category" class="form-control"
										style="display: none" name="childCategory"></select>
								</div>
							</div>
							<hr>


							<div class="form-row" style="max-height: 38px; margin-top: 5px;">
								<div class="col-sm-1">상품등록일</div>
								<div class="col-sm-3">
									<input type="date" class="form-control" id="first-date"
										disabled>
								</div>
								<div class="col-sm-1 text-center"
									style="margin: 0px; max-width: 30px">
									<h1>~</h1>
								</div>
								<div class="col-sm-3">
									<input type="date" class="form-control" id="last-date" disabled>
								</div>
								<div class="col-sm-1" style="max-width: 60px;">
									<a class="btn btn-primary" style="color: white;" id="all-date">전체</a>
									<input type="hidden" id="all-date-submit" name="allDate" />
								</div>
							</div>
							<hr>

							<div class="form-row" style="max-height: 38px; margin-top: 5px;" id="radio-box">
								<div class="col-sm-1">진열상태</div>
								<div class="col-sm-3">
									<input type="radio" name="display" value="A" checked>
									전체 <input type="radio" name="display" value="Y"> 진열함 <input
										type="radio" name="display" value="N"> 진열안함
								</div>
								<div class="col-sm-1">판매상태</div>
								<div class="col-sm-3">
									<input type="radio" name="sell" value="A" checked> 전체 <input
										type="radio" name="sell" value="Y"> 판매함 <input
										type="radio" name="sell" value="N"> 판매안함
								</div>
							</div>
							<hr>

							<div class="form-row" style="max-height: 38px; margin-top: 5px;">
								<div class="form-item col-md-1">검색</div>
								<div class="input-group col-md-7">
									<input type="text" class="form-control" placeholder="검색할 키워드를 입력해주세요." id="keyword" name="keyword">
									<div class="input-group-append">
										<button class="btn fas fa-search" id="search-btn" type="button">
										</button>
									</div>
								</div>
							</div>
							<hr>

						</div> 
						<div class="table-responsive">
							<table class="table table-bordered table-hover"
								width="100%" cellspacing="0" style="font-size: 13px;" id="">
								<!-- id에 js에서 설정한 값-->

								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
								</colgroup>
								<tfoot>
									<tr>
										<th colspan="6" class="text-center text-primary"><h4 id="alert-scroll"><i class="fas fa-sort-amount-down"></i>스크롤을 아래로 내리면 상품이 표시됩니다.</h4></th>
									</tr>
								</tfoot>
								<tbody id="table-load">

									<%-- <c:forEach items="${items}" var="item">
										<c:set var="count" value="0" />
										<tr>
											<td>${item.no }</td>
											<td data-toggle="modal" data-target="#myModal" onclick="getItemDetail(${item.no})">
												<img src="/images/items/${item.image eq null ? 'not_image.PNG':item.image }" width="57px" height="57px;" style="border: 1px solid silver; padding: 2px;"
												class="float-left" />
												<ul
													style="list-style: none; margin-left: 27px; margin-bottom: 0px">
													<li>${item.name }</li>
													<c:if test="${!empty item.option }">
														<li class="text-primary">- 색상 : 
															<c:forEach items="${item.option }" var="option"> 
																${option.color }
															</c:forEach>
														</li>
														<li class="text-primary">- 사이즈 : 
														<c:forEach items="${item.option }" var="option"> 
															${option.size } 
															<c:set var="count" value="${count+option.stock }" />
														</c:forEach>
														</li>
													</c:if>
												</ul></td>
											<td>${item.price }</td>
											<td>${item.currentDiscount }</td>
											<td>${count }
											<td><fmt:formatDate value="${item.createDate }"
													pattern="yyyy.MM.dd" /></td>
										</tr>
									</c:forEach> --%>
								</tbody>
							</table>
						</div>
						<%-- 페이징 처리 . 버림 
						<div class="form-row">
							<div class="col-xs-offset-3 col-xs-6" style="text-align: center;">
								<ul class="pagination">

									<c:if test="${pagination.currentBlock gt 1 }">
										<li><a href="javascript:changePage(${pagination.prevBlock })">&laquo;</a></li>
									</c:if>

									<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
										<li class="${num eq pagination.cp ? 'active' : ''} page-item">
										<a href="javascript:changePage(${num })" class="page-link" target="">${num }</a></li>
									</c:forEach>

									<c:if
										test="${pagination.currentBlock lt pagination.totalBlocks }">
										<li>
										<a href="javascript:changePage(${pagination.nextBlock })">&raquo;</a></li>
									</c:if>

								</ul>
							</div>
						</div> --%>
				</div>
				<!--카드 끝-->
				<div class="card" style="width: 100px; margin: 0px; display: none">
					<img class="card-img-top" src="img/sample.jpg" alt="Card image"
						height="150px">
					<div class="card-body">
						<p>sa</p>
						<p>sa</p>
					</div>
				</div>
			</div>
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->

	<!-- Button to Open the Modal -->

	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="margin-left: 400px;">
			<div class="modal-content" style="width: 1000px;">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상품 디테일</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" style="height: 700px; overflow: scroll;">
					<table class="table table-bordered" id="item-option">
						<tr>
							<td>상품번호</td>
							<td colspan="3" id="item-no"></td>
						</tr>
						<tr>
							<td colspan="4" class="text-center"><img src="" style="max-width: 965px" id="item-img"></td>
						</tr>
						<tr>
							<th><small>상품이름</small></th>
							<td id="item-name"></td>
							<th><small>카테고리</small></th>
							<td id="item-category"></td>
						</tr>
						<tr>
							<td><small>정가</small></td>
							<td id="item-price"></td>
							<td><small>판매가</small></td>
							<td id="item-currentDiscount"></td>
						</tr>
						<tr>
							<td><small>판매여부</small></td>
							<td id="item-sell"></td>
							<td><small>진열여부</small></td>
							<td id="item-display"></td>
						</tr>
						<tr>
							<td><small>재고</small></td>
							<td><span id="item-stock"></span></td>
							<td><small>등록일</small></td>
							<td><span id="item-date"></span></td>
						</tr>
						<tr>
							<td colspan="1">옵션</td>
							<td id="item-opt" colspan="3"></td>
						</tr>
						<tr>
							<td colspan="4">상품 내용</td>
						</tr>
						<tr>
							<td colspan="4" id="item-contents" class="text-center"></td>
						</tr>
					</table>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<div id="item-btn"></div>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
	</div>
	<script>
	var scrollAvailable = false;
	var allcount = 0;
	var cp = 1;
	var totalRows = 1;
	var totalRowsValue = totalRows;
	var ItemisNotEmpty = true;
	var firstCate = true;
	
		function getItemDetail(itemNo){
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(event) {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var text = xhr.responseText;
					var item = JSON.parse(text);
					var stock = 0;
					item.option.forEach(function(item,index){stock+=item.stock});
					$("#item-opt").html("");
	
					var sell = "";
					if(item.sellAvailable == "Y"){
						sell = "판매중";
					}else {
						sell = "판매중이 아닙니다.";
					}
					var display = "";
					if(item.displayAvailable == "Y"){
						display = "진열중";
					}else {
						display = "진열중이 아닙니다.";
					}
					
					document.getElementById("item-no").textContent = item.no;
					document.getElementById("item-name").textContent = item.name;
					document.getElementById("item-category").textContent = item.category.contents;
					document.getElementById("item-price").textContent = item.price+" 원";
					document.getElementById("item-currentDiscount").textContent = item.currentDiscount+" 원";
					document.getElementById("item-sell").textContent = sell;
					document.getElementById("item-display").textContent = display;
					document.getElementById("item-stock").textContent = stock+" 개";
					document.getElementById("item-date").textContent = item.createDate;
					document.getElementById("item-img").setAttribute("src", "/images/items/"+item.image);
					$("#item-contents").html(item.contents);
					
					var row = '<button type="button" class="btn btn-primary" onclick="modifyItem('+item.no+')">수정</button>'
				        row += '<button type="button" class="btn btn-danger" onclick="deleteItem('+item.no+')" >삭제</button>'
					$("#item-btn").html(row);	
					// 옵션 초기화, 컬러 스타일 설정
					$('.option-box').remove();
					
					var optMenu = "";
					optMenu +="<div class='btn-group'><button class='btn btn-primary' style='width:200px;'>컬러</button> ";
			    	optMenu += "<button class='btn btn-success btn-sm' style='width:200px;'>사이즈</button> "
			    	optMenu += "<button class='btn btn-warning btn-sm' style='width:200px;'>재고</button> ";
			    	optMenu+= "<button class='btn btn-dark btn-sm' style='width:200px;'>판매가</button> </div>";
					
					$("#item-opt").append(optMenu);
					item.option.forEach(
							function(opt,index){
								var optRow = "";
								optRow +="<div style='margin:4px;' id='"+opt.no+"'><div class='btn-group'><button class='btn btn-primary btn-sm' style='width:198px;";
								if(opt.color == '블루'|| opt.color.toUpperCase() == 'BLUE'||opt.color == '파랑'){optRow += "background-color:blue;"}
								else if(opt.color == '레드'|| opt.color.toUpperCase() == 'RED'||opt.color == '빨강'){optRow += "background-color:red;"}
								else if(opt.color == '화이트'|| opt.color.toUpperCase() == 'WHITE'||opt.color == '흰색'||opt.color == '하양'){optRow += "background-color:white; color:black;"}
								else if(opt.color == '옐로우'|| opt.color.toUpperCase() == 'YELLOW'||opt.color == '노랑'||opt.color == '노란색'){optRow += "background-color:yellow;"}
								else if(opt.color == '실버'|| opt.color.toUpperCase() == 'SILVER'||opt.color == '회색'){optRow += "background-color:silver;color:black"}
								else if(opt.color == '그린'|| opt.color.toUpperCase() == 'GREEN'||opt.color == '녹색'||opt.color == '초록색'||opt.color == '초록'){optRow += "background-color:green;"}
								else if(opt.color == '레드'|| opt.color.toUpperCase() == 'RED'||opt.color == '빨강'){optRow += "background-color:blue;"}
								else if(opt.color == '그레이'|| opt.color.toUpperCase() == 'GRAY'||opt.color == '회색'){optRow += "background-color:gray;"}
								else if(opt.color == '아이보리'||opt.color == '크림'){optRow += "background-color:#F5F6CE;color:black"}
								else if(opt.color == '카키'){optRow += "background-color:#0B6121;"}
								else if(opt.color == '네이비'||opt.color == '남색'){optRow += "background-color:#08088A;"}
								else if(opt.color == '블랙'|| opt.color.toUpperCase() == 'BLACK'||opt.color == '검정'){optRow += "background-color:black;"}
								else if(opt.color == '주황'){optRow += "background-color:orange;"}
								else if(opt.color == '보라'|| opt.color.toUpperCase() == 'PURPLE'||opt.color == '퍼플'){optRow += "background-color:purple;"}
								else if(opt.color == '연두'){optRow += "background-color:#40FF00;"}
								else if(opt.color == '브라운'||opt.color == '갈색'){optRow += "background-color:#B45F04;"}
								optRow +="'>"+opt.color+"</button> ";
						    	optRow += "<button class='btn btn-success btn-sm' style='width:198px;'>"+opt.size+"</button> "
						    	optRow += "<button class='btn btn-warning btn-sm' style='width:198px;'>"+opt.stock+"</button> ";
						    	optRow += "<button class='btn btn-dark btn-sm' style='width:198px;'>"+opt.currentPrice+"</button></div></div>";
								
								$("#item-opt").append(optRow);
							});
					
					$("#item-detail-modal").modal('show');
				}
			}
			xhr.open("GET", "detail.do?itemNo=" + itemNo);
			xhr.send();
		}
		
		  function deleteItem(itemNo){
				 
			  if (!confirm("삭제하시겠습니까?")) {
			        return;
			    }
			    $.ajax({
			        url: "deleteItem.do",
			        type:"get", 
			        data: {"itemNo":itemNo},
			        success: function(result){
			            if (result.result=="OK") {
			                alert("삭제되었습니다.");
							window.location.reload();
			            } else{
			            	alert("삭제에 실패했습니다.");
			            }
			        }
			    })
			}
		
		function modifyItem(itemNo){
			if(confirm('상품 수정페이지로 가시겠습니까?')){
				location.href="modifyform.do?itemNo="+itemNo;
			} else {}
		}
		
		
		//카테고리
		document.getElementById("top-category").onchange = function(event){
			var categoryNo = event.target.value;
	    	
			if(categoryNo) {
				var xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function() {
					if(xhr.readyState == 4 && xhr.status ==200 &&$("#top-category").val() != 0)	{
						var text = xhr.responseText;
						var childCategorys = JSON.parse(text);
						
						var options = "";
						document.getElementById("child-category").style.display = "";
						options += "<option value='0'>전체</option>"
						childCategorys.forEach(function(item,index){
							options +="<option value='"+item.no+"'>"+item.contents+"</option>";
						})
						var childCategoryBox = document.getElementById("child-category");
						childCategoryBox.innerHTML = options;
						if(!childCategorys.length){
							$("#child-category").html("<option value='0'>하위 카테고리가 없습니다.</option>");
						}
						
						if(firstCate){
						firstCategory();
						firstCate = false;
						}
					}
					else {
						$("#child-category").css("display","none");
					}
					
				}
				xhr.open("GET",'childCategory.do?categoryNo=' + categoryNo);
				xhr.send();
			}
			else if (categoryNo == ''){
				document.getElementById("child-category").style.display = "none";
			}
		}
		
		//날짜 버튼
		var date = true;
		$(function(){
			$('#all-date').click(function(){
				  if(date){
					  $("#all-date").css("background","gray");
					  $("#first-date").attr("disabled",false);
					  $("#last-date").attr("disabled",false);
					  
					  date=false;
					 
				  }
				  else {
					  $("#all-date").css("background","blue");
					  $("#first-date").attr("disabled",true);
					  $("#last-date").attr("disabled",true);
					  $("#first-date").val(null);
					  $("#last-date").val(null);
					  date = true;
					  
					  totalRowsValue = totalRows;
						cp=1;
						allCount = 0;
						ItemisNotEmpty = true;
						$("#table-load").html("");
						getItems();
						cp++;
					  
				  }
			});
		});
		
		//자동 스크롤
		
		$(window).scroll(function(){
			if($(document).height() - $(window).height() - $(window).scrollTop() <= 0.05 && ItemisNotEmpty){
				getItems();
				++cp;
			}
		})
		
			$(window).scroll(function(){
			if($(document).height() - $(window).height() - $(window).scrollTop() == 0){
				$(window).scrollTop($(window).scrollTop()-5)
			}
		})
		
		$(window).scroll(function(){
			if($(window).scrollTop()>800){
				$("#search-box").addClass('search-fixed');
				$("#search-box").css("height","0px");
				$("#search-box").animate({height: "254px"},500);
				scrollAvailable  = true;
			}
			if($(window).scrollTop()<300 && scrollAvailable){
				scrollAvailable = false;
				$("#search-box").removeClass('search-fixed');
				$("#search-box").css("height","254px");
			}
		})
		
		//검색 전송
		
		$("#search-btn").click(function(){
			totalRowsValue = totalRows;
			cp=1;
			allCount = 0;
			ItemisNotEmpty = true;
			$("#table-load").html("");
			getItems();
			cp++;
		});
		
		$("#keyword").keyup(function(){
			$(window).scrollTop(0);
			totalRowsValue = totalRows;
			cp=1;
			allCount = 0;
			ItemisNotEmpty = true;
			$("#table-load").html("");
			getItems();
			cp++;
		});

		$('input:radio[name="display"]').click(function(){
			totalRowsValue = totalRows;
			cp=1;
			allCount = 0;
			ItemisNotEmpty = true;
			$("#table-load").html("");
			getItems();
			cp++;
		});
		
		$("#last-date").change(function() {
			var value = $("#first-date").val();
			if(value != ''){
				totalRowsValue = totalRows;
				cp=1;
				allCount = 0;
				ItemisNotEmpty = true;
				$("#table-load").html("");
				getItems();
				cp++;
			}
		})
		
		$("#top-category").change(function() {
			var value = $("#top-category").val();
				totalRowsValue = totalRows;
				cp=1;
				allCount = 0;
				ItemisNotEmpty = true;
				$("#table-load").html("");
				getItems();
				cp++;
		})
		$("#child-category").change(function() {
			var value = $("#child-category").val();
				totalRowsValue = totalRows;
				cp=1;
				allCount = 0;
				ItemisNotEmpty = true;
				$("#table-load").html("");
				getItems();
				cp++;
		})
		
		$('input:radio[name="sell"]').click(function(){
			totalRowsValue = totalRows;
			cp=1;
			allCount = 0;
			ItemisNotEmpty = true;
			$("#table-load").html("");
			getItems();
			cp++;
		});
		
		
		function firstCategory() {
			var value = $("#top-category").val();
				totalRowsValue = totalRows;
				cp=1;
				allCount = 0;
				ItemisNotEmpty = true;
				$("#table-load").html("");
				getItems();
				cp++;
			}
		
		function getItems(){
			var topCateNo = $("#top-category").val();
			var childCateNo = $("#child-category").val();
			var firstDate = $("#first-date").val();
			var lastDate = $("#last-date").val();
			var display = $("input[name=display]:checked").val();
			var sell= $("input[name=sell]:checked").val();
			var keyword = $("#keyword").val();
			$.ajax({
				url:"getItemScroll.do",
				type:"post",
				data:{
						"cp": cp,
						"topCateNo": topCateNo,
						"childCateNo":childCateNo,
						"keyword": keyword,
						"firstDate": firstDate,
						"lastDate": lastDate,
						"display": display,
						"sell": sell,
						"allDate":date
					},
				success:function(result){
					if(result.length == 0){
						$("#alert-scroll").html('<i class="fab fa-accusoft"></i>더이상 상품이 존재하지 않습니다.');
						ItemisNotEmpty = false;
						return;
					}else{
						$("#alert-scroll").html('<i class="fas fa-sort-amount-down"></i>스크롤을 아래로 내리면 상품이 표시됩니다.');
						ItemisNotEmpty = true;
					}
					if(cp%2 == 0){
						$("#table-load").append("<tr><th>No</th><th style='min-width: 150px'>상품명</th><th>정가</th><th>판매가</th><th>재고</th><th>등록일</th></tr>");
					}
					
					result.forEach(function(item,index){
						allcount++;
						var rows;
						var count = 0;
						var sizes = [];
						var colors = [];
						item.option.forEach(function(option,index){
							sizes.push(option.size);
							colors.push(option.color);
							count += option.stock;
						});
						var duplicatesSizes = removeDuplicatesArray(sizes);
						var duplicatesColors = removeDuplicatesArray(colors);
						
						rows +="<tr>";
						rows +="<td>"+totalRowsValue+"</td>";
						rows +="<td data-toggle='modal' data-target='#myModal' onclick='getItemDetail("+item.no+")'>";
						rows +='<img src="/images/items/';
						rows += item.image;
						rows +='"width="70px" height="70px;" style="border: 1px solid silver; padding: 2px;"class="float-left" />';
						rows +='<ul style="list-style: none; margin-left: 27px; margin-bottom: 0px">';
						rows +="<li>"+item.name+"</li>";
						if(item.option.length != 0){
							rows +='<li class="text-primary">- 색상 : ';
							duplicatesColors.forEach(function(color,index){
								rows +=color+" ";
							});
						} else {
							rows+= '<li class="text-danger"> 옵션 없음';
						};
							rows +="</li>";
							rows +='<li class="text-primary">';
						if(item.option.length != 0){
							rows +='<li class="text-primary">- 사이즈 : ';
							duplicatesSizes.forEach(function(size,index){
								rows +=size+" ";
							});
						};
							rows +='</li>';
						rows +='</ul></td>';
						rows +='<td>'+item.price+' 원</td>';
						rows +='<td>'+item.currentDiscount+' 원</td>';
						rows +='<td>'+count;
						rows +=' 개<td>'+item.createDate+'</td>';
						rows +='</tr>';
						$("#table-load").append(rows);
						
						totalRowsValue++;
					})
				}					
			})
		}
		//중복제거
	   function removeDuplicatesArray(arr) {
        var tempArr = [];
        for (var i = 0; i < arr.length; i++) {
            if (tempArr.length == 0) {
                tempArr.push(arr[i]);
            } else {
                var duplicatesFlag = true;
                for (var j = 0; j < tempArr.length; j++) {
                    if (tempArr[j] == arr[i]) {
                        duplicatesFlag = false;
                        break;
                    }
                }
                if (duplicatesFlag) {
                    tempArr.push(arr[i]);
                }
            }
        }
        return tempArr;
    }
		
	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>