<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="content-wrapper" style="max-width: 1300px;"
		class="pull-center">
		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">상품관리</a></li>
				<li class="breadcrumb-item active">카테고리</li>
			</ol>

			<div class="card">
				<div class="card-header">분류 관리</div>
				<div class="card-body row">
					<div class="col-md-4">
						<div class="jumbotron text-left jumbotron-primary" style="padding: 5px; min-height: 600px;max-height:600px; overflow: scroll;">
						
							<div class='alert alert-primary text-center'>
									<button data-toggle="collapse" data-target="#demo" class="btn btn-primary">카테고리 추가하기</button>
									<div id="demo" class="collapse">
										<div class="form-group">
											<div class="alert alert-danger alert-dismissible fade show" style="padding:0px; margin-top:3px; "><small>추가할 카테고리를 입력하세요.</small></div>
											<input type="text" class="form-control" id="add-parents-box">
										</div>
										<button onclick="addCategory('parents')" class="btn btn-primary">추가</button>
									</div>
								</div>
		
							<c:forEach items="${categorys}" var="category">
								<div class='alert alert-success' id="parents${category.no }" style="margin-bottom: 3px;" onclick="getChildCategory(${category.no})">
									<i class="far fa-folder-open"></i> 
									<a>${category.contents }</a>
									<button class='btn btn-sm text-right' onclick='deleteChild(${category.no},1)'>x</button>
								</div>
							</c:forEach>
							
						</div>
					</div>
					<div class="col-md-8">
						<div class="jumbotron text-left" style="padding: 5px; min-height: 600px;max-height:600px; overflow: scroll;" id="child-box">
							<h1 id="del">상위 카테고리를 선택해주세요.</h1>
						</div>
					</div>
				</div>
			</div>
			<!--카드 끝-->
		</div>
		<!--컨테이너 끝-->
	</div>
	<!--컨텐츠 끝-->
	
	<script>
   function getChildCategory(cateNo){
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status ==200)	{
					var text = xhr.responseText;
					var childCategorys = JSON.parse(text);
					var child = '<div class="alert alert-primary text-center"><button data-toggle="collapse" data-target="#demo2" class="btn btn-primary">카테고리 추가하기</button>';
					child += '<div id="demo2" class="collapse"><div class="form-group"><div class="alert alert-danger alert-dismissible fade show" style="padding:0px; padding-top:3px;">추가할 카테고리를 입력하세요.</div>';
					child += '<input type="text" class="form-control" id="add-child-box"></div><button onclick="addCategory('+"'child'"+')" class="btn btn-primary">추가</button></div></div>'
					child += '<input type="hidden" id="parents-value" value="'+cateNo+'">'
					
					var colorCount = 0;
					childCategorys.forEach(function(item,index){
						child += "<span class='btn "
						if(colorCount == 0){child += "btn-primary"; colorCount++}
						else if(colorCount == 1){child += "btn-danger"; colorCount++}
						else if(colorCount == 2){child += "btn-warning"; colorCount++}
						else if(colorCount == 3){child += "btn-success"; colorCount = 0;}
						child += " btn-lg' id='child"+item.no+"' style='margin:3px'><b>"+item.contents+" </b><button class='btn btn-sm' onclick='deleteChild("+item.no+")'>x</button></span> ";
					})
					var childCategoryBox = document.getElementById("child-box");
					childCategoryBox.innerHTML = child;
					
					if(!childCategorys.length){
						$("#child-box").append("<div id='alert-child'><h1>하위 카테고리가 없습니다.</h1><h2>새로운 카테고리를 추가해주세요.</h2></div>");
					}
					$("del").remove();
				}
			}
			xhr.open("GET",'childCategory.do?categoryNo=' + cateNo);
			xhr.send();
		}
   
   
   function deleteChild(cateNo,value){
	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }
	    $.ajax({
	        url: "deleteChild.do",
	        type:"post", 
	        data: {"cateNo":cateNo},
	        success: function(result){
	            if (result.result=="OK") {
	                $("#child"+cateNo).remove();
					if(value == 1){
						window.location.reload();
	                }
	                alert("삭제되었습니다.");
	                
	            } else{
	                alert("하위 카테고리 혹은 상품이 있습니다.\n하위 컨텐츠를 모두 지우고 다시 시도해주세요.");
	            }
	        }
	    })
	}
   
   function addCategory(category){
	    var cateNo;
	    var contents;
	    
	    if(category == "parents"){
	    	contents = $("#add-parents-box").val();
	    }
	    if(category == "child"){
	    	contents = $("#add-child-box").val();
	    	cateNo = $("#parents-value").val();
	    }
	    $.ajax({
	        url: "addCategory.do",
	        type:"post", 
	        data: {"cateNo":cateNo,"contents":contents},
	        success: function(result){
	            if (result.result=="OK") {
	            	$("#alert-child").remove();
	                alert("카테고리가 추가되었습니다.");
	            	if(cateNo != undefined){
		                $("#child-box").append("<span class='btn btn-primary' id='x'>"+contents+" <button class='btn btn-sm' onclick='reload()'>x</button></span> ");
		                $("#add-child-box").val("");
		                $("#add-child-box").focus();
	            	} else {
	            		window.location.reload()
	            	}
	            } else{
	                alert("카테고리를 추가하는 도중 문제가 발생하였습니다.");
	            }
	        }
	    })
	}
   
   function reload(){
	   alert("다시 시도해주세요.")
	   window.location.reload()
   }

	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>