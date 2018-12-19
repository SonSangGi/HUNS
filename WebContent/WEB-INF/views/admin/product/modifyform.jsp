<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link
	href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
 


</head>
<body>
<%@include file="../include/header.jsp"%>
            <div id="content-wrapper" style="width: 1300px;">
                <div class="container-fluid">
                    <!-- Breadcrumbs-->
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">상품관리</a></li>
                        <li class="breadcrumb-item active">상품등록</li>
                    </ol>
                    <!-- DataTables Example -->
                    <div class="card mb-3 ">
                        <div class="card-header bg-secondary text-white"> <i class="fas fa-table"></i> 상품 수정 폼 </div>
                        <div class="card-body">
                            <form id="form-box" onsubmit="return false;" method="post" action="modify.do" enctype="multipart/form-data">
                            <input type="hidden" value="${item.no }" name="itemNo"/>
                                <div class="form-group ">
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <p class="card-title"> <i class="fas fa-caret-square-right"></i> 카테고리를 설정하세요.</p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-sm-4">
                                            <select class="form-control" id="top-category" name="topCategory">
                                                <option value="">상위 카테고리 설정</option>
                                                <c:forEach items="${topCategorys}" var="category">
                                                	
                                                    <option value="${category.no }" ${item.category.no eq category.no ? 'selected' : '' }>${category.contents}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="child-category" class="form-control" style="display:none" name="childCategory">
                                            		<option value="${category.no }">${category.contents }</option>
                                            </select>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <p class="card-title"> <i class="fas fa-tshirt"></i> 상품 이름을 입력하세요. </p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class="form-label-group">
                                                <input type="text" id="name-box" class="form-control" placeholder="상품 이름을 입력하세요." autofocus="autofocus" name="name" value="${item.name}">
                                                <label for="name-box">${item.name}</label>
                                            </div>
                                            <hr>
                                            <div class="form-item">
                                                <label for=""><i class="fas fa-keyboard"></i> 상품 화면 이미지 등록</label>
                                                <textarea style="width: 100%" rows="10" name="content" id="textAreaContent" cols="80">${item.contents }</textarea>
                                            </div>
                                            <hr> 
                                      </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <p class="card-title"> <i class="fas fa-won-sign"></i> 판매가</p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div style="width:200px">
                                            <div class="form-label-group">
                                                <input type="number" id="price-box" class="form-control" placeholder="예)32,000" autofocus="autofocus" style="max-width: 200px" name="price"  value="${item.price}">
                                                <label for="price-box">${item.price }</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <p class="card-title"> <i class="fas fa-won-sign"></i> 할인가 </p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div style="width:200px">
                                            <div class="form-label-group">
                                                <input type="number" id="discount-box" class="form-control" placeholder="예)30,000" autofocus="autofocus" style="max-width: 200px" name="discount" value="${item.currentDiscount}" >
                                                <label for="discount-box">${item.currentDiscount}</label>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4">
                                            <h2>
									<i class="fas fa-won-sign"></i>
								</h2> </div>
                                    </div>
                                    <hr>
                                    <div class="form-row">
                                        <div class="col-md-12"> 진열상태
                                            <input type="radio" name="display" value="Y" ${item.displayAvailable eq 'Y'? 'checked':'' }>상품 진열
                                            <input type="radio" name="display" value="N" ${item.displayAvailable eq 'N'? 'checked':'' }>상품 진열안함 </div>
                                        <div class="col-md-12"> 판매상태
                                            <input type="radio" name="sell" value="Y" ${item.sellAvailable eq 'Y'? 'checked':'' }>상품 판매
                                            <input type="radio" name="sell" value="N" ${item.sellAvailable eq 'N'? 'checked':'' }>상품 판매안함 </div>
                                    </div>
                                    <hr>
                                    <div class="form-row">
                                        <div class="col-md-7">
                                            <p class="card-title"> <i class="fas fa-won-sign"></i>옵션/재고 </p>
                                        </div>
                                    </div>
                                    <div class="form-row" id="option-box">
	                                        <div class="col-md-2">
	                                            <div class="form-label-group">
	                                                <input type="text" id="color" class="form-control" placeholder="예)32,000" autofocus="autofocus"" onkeydown="enterkey()">
	                                                <label for="color"><small>색상 입력</small></label>
	                                            </div>
	                                        </div>
	                                        <h1>></h1>
	                                        <div class="col-md-2">
	                                            <div class="form-label-group">
	                                                <input type="text" id="size" class="form-control" placeholder="예)32,000" autofocus="autofocus" onkeydown="enterkey()">
	                                                <label for="size"><small>사이즈 입력</small></label>
	                                            </div>
	                                        </div>
	                                        <h1>></h1>
	                                        <div class="col-md-2">
	                                            <div class="form-label-group">
	                                                <input type="number" id="stock" class="form-control" placeholder="예)32,000" autofocus="autofocus" onkeydown="enterkey()">
	                                                <label for="stock"><small >재고 입력</small></label>
	                                            </div>
	                                        </div>
	                                        <br><button type="button" class="btn btn-primary btn-sm" id="add-btn" onclick="addoption();" >+</button>
	                                        <input type="hidden" name="option" id="option-submit">
	                                        <div class="col-md-2">
	                                            <div class="form-label-group">
	                                                <input type="hidden" id="current-price" class="form-control" placeholder="예)32,000" autofocus="autofocus" onkeydown="enterkey()">
	                                                <label for="current-price"></label>
	                                            </div>
	                                        </div>
	                                        
                                    </div>
                                    <p id="cate-content">
                                    	<c:forEach items="${item.option }" var="opt">
                                    	
                                    		<div style='margin:3px;' id="option-load${opt.no }">
									    	<button class='btn btn-success btn-sm'><b>색상: ${opt.color}</b></button>
                                    		<button class='btn btn-primary btn-sm'><b>사이즈: ${opt.size }</b></button>
									    	<button class='btn btn-warning btn-sm'><b>재고: ${opt.stock }개</b></button> 
									    	<button class='btn btn-info btn-sm'><b>판매가:${opt.currentPrice } 원</b></button> 
									    	<button class='btn btn-sm btn-danger' onclick="deleteOption(${opt.no})">X</button></div>
                                    	</c:forEach>
                                    </p>
                                    <hr>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <p class="card-title"> <i class="fas fa-won-sign"></i> 대표 사진 등록<span class="text-danger"> ※미등록시 기존 이미지가 등록됩니다.※</span> </p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12"> 권장이미지 : 500px * 500px / 5M 이하 / gif, png, jpg(jpeg)
                                            <input type="file" class="form-control" name="main" id="file-box"> </div>
                                    </div>
                                    <hr>
                                    <div class="form-row">
                                        <button class="btn btn-primary col-md-" onclick="addform()">상품 저장</button>
                                    </div>
                                </div>
                            </form>
                            </div>
                        </div>
                    </div>
                </div>
	<!--컨테이너 끝-->


    <!-- 하위 카테고리 생성 -->
    <script>
    document.getElementById("top-category").onchange = function(event){
		var categoryNo = event.target.value;
    	
		if(categoryNo) {
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status ==200)	{
					var text = xhr.responseText;
					var childCategorys = JSON.parse(text);
					
					var options = "";
					document.getElementById("child-category").style.display = "";
					options += "<option value='0'>하위 카테고리를 선택해주세요.</option>"
					childCategorys.forEach(function(item,index){
						options +="<option value='"+item.no+"'>"+item.contents+"</option>";
					})
					var childCategoryBox = document.getElementById("child-category");
					childCategoryBox.innerHTML = options;
					if(!childCategorys.length){
						$("#child-category").html("<option value='0'>하위 카테고리가 없습니다.</option>");
					}
				}
			}
			xhr.open("GET",'childCategory.do?categoryNo=' + categoryNo);
			xhr.send();
		}
		else if (categoryNo == ''){
			document.getElementById("child-category").style.display = "none";
		}
	}
    var optionList = [];
    <!--옵션 추가-->
    function addoption(){
    	var size = $("#size").val();
    	var color = $("#color").val();
    	var stock = $("#stock").val();
    	var currentPrice = '';
    	
    	if($("#current-price").val()){
    		var currentPrice = document.getElementById("current-price").value;
    	} else if ($("#discount-box").val()){
    		currentPrice = $("#discount-box").val();
    	} else if (!size == '' & !color == '' & !stock == ''){
			alert("할인가 혹은 옵션 가격을 입력해주세요.")
			return false;
    	}
    	if(!size == '' & !color == '' & !stock == ''){
	    	optionList.push(color,size,stock,currentPrice);
	    	var row = ""; 
	    	row += "<div style='margin:3px;'><button class='btn btn-success btn-sm'><b>색상: "+color+"</b></button> "
	    	row +="<button class='btn btn-primary btn-sm'><b>사이즈: "+size+"</b></button> ";
	    	row += "<button class='btn btn-warning btn-sm'><b>재고: "+stock+"개</b></button> ";
	    	row += "<button class='btn btn-danger btn-sm'><b>가격: "+currentPrice+"원</b></button> </div>";
	    	$("#cate-content").append(row);
	    	$("#size").val('');
	    	$("#color").val('');
	    	$("#stock").val('');
	    	$("#current-price").val('');
	    	$("#size").focus();
    	}else {
    		alert('옵션을 모두 입력해주세요.')
    	}
    }
    document.addEventListener('keydown', function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
        }
    }, true);
 	//옵션 엔터키 체크
	function enterkey() {
        if (window.event.keyCode == 13) {
 
             addoption();
        }
	}
	
	   function deleteOption(optNo){
		   console.log(optNo)
		    $.ajax({
		        url: "delOpt.do",
		        type:"post", 
		        data: {"optNo":optNo},
		        success: function(result){
		            if (result.result=="OK") {
		                alert("옵션이 삭제되었습니다.");
			                $("#option-load"+optNo).remove();
		            } else{
		                alert("카테고리를 추가하는 도중 문제가 발생하였습니다.");
		            }
		        }
		    })
	   }
	
	<!-- 유효성 검사 및 전송-->
	function addform(elClickedObj){
		var category = $("#top-category");
		var name = $("#name-box");		
		var content = $("#textAreaContent");
		var price = $("#price-box");
		var file = $("#file-box");
		
		if(category.val() === ""){
			alert("카테고리를 선택해주세요.");
			category.focus();
			return false;
		}
		if($("#child-category").val() == null || $("#child-category").val() == 0){
			alert('하위 카테고리를 설정해주세요.')
			$("#child-category").focus();
			return false;
		}	
		if(name.val() === ""){
			alert("상품이름을 입력해주세요.");
			name.focus();
			return false;
		}
		if(price.val() === ""){
			alert("상품가격을 입력해주세요.");
			price.focus();
			return false;
		}
		if(file.val() === ""){
			if(confirm('대표이미지를 변경하지 않을 경우 기존 이미지가 등록됩니다.  \n 기존 이미지를 사용하시겠습니까?')){
				} else {
					file.focus();
					return false;
				}
		}
		
		optionList.forEach(function(item,index){
	    	document.getElementById("option-submit").value += item;
			if(index != optionList.length-1 && index%4 == 3){
				document.getElementById("option-submit").value +=",";
            } else if(index!=optionList.length-1){
				document.getElementById("option-submit").value +="&";
			}
		});
		
	    oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	  
	    for(var i in optionList){
	    	document.getElementById("option-submit").val += i;
	    }
	  
	    try {
	        elClickedObj.form.submit();
	    } catch(e) {
	    }
	    alert("상품이 수정되었습니다.");
		document.getElementById("form-box").submit();
	}
	</script>
	
	
	<!-- Smart Editor -->
<script type="text/javascript">
 
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "textAreaContent",
    sSkinURI: "<%=request.getContextPath()%>/resources/se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
 
 
// textArea에 이미지 첨부
function pasteHTML(filepath){
    var sHTML = '<img src="<%=request.getContextPath()%>/images/items/'+filepath+'">';
    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
}
 
</script>
	<%@include file="../include/footer.jsp"%>
	<!-- 게시판 에디터 -->
</body>
</html>