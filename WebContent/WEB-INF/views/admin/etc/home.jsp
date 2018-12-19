<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../../../../resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../../../resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="../../../../resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<link href="../../../../resources/admin/css/sb-admin.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

</head>
<body>
<%@include file="../include/header.jsp" %>

 <div id="content-wrapper">
 
        <div class="container-fluid">

          <!-- 브랜드 컬럼..-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">즐겨찾기</a>
            </li>
          </ol>

          <!-- 아이콘 카드..-->
          <div class="row">
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-primary o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-comments"></i>
                  </div>
                  <div class="mr-5"><span id="answer-count"></span> 개의 문의가 있습니다.</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="/admin/board/board.do">
                  <span class="float-left">자세히</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
            
            
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-warning o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-list"></i>
                  </div>
                  <div class="mr-5"><span id="review-count"></span>개의 새로운 리뷰가 있습니다.</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="../board/reviews.do">
                  <span class="float-left">자세히</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
            
            
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-success o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-shopping-cart"></i>
                  </div>
                  <div class="mr-5"><span id="order-count"></span> 개의 입금대기 주문이 있습니다.</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="../order/list.do">
                  <span class="float-left">자세히</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
            
            
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-danger o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-life-ring"></i>
                  </div>
                  <div class="mr-5">빠른 상품 등록</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="/admin/product/addform.do">
                  <span class="float-left">등록하러가기</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
          </div>
          
          
          <!-- Area 차트 .. 맨 밑에 javaScript 소스 있음 -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-chart-area"></i>
              최근 6개월 매출</div>
            <div class="card-body">
              <canvas id="myAreaChart" width="100%" height="30"></canvas>
            </div>
          </div>

          
          
		</div>
	</div>


</div>
<!-- 래퍼 닫는 태그 -->

<!-- 푸터 시작 -->

  <!-- 스크롤 상단으로 -->
    <a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
    </a>

<%@include file="../include/footer.jsp" %>
<!-- Area Chart .. -->
<script>

$.post("count.do",function(count){
	$("#order-count").append(count.orderCount);
	$("#review-count").append(count.reviewCount);
	$("#answer-count").append(count.notAnswerCount);
})












//area 값 지정..
var month5 ={"count":"","month":0};
var month4 ={"count":"","month":0};
var month3 ={"count":"","month":0};
var month2 = {"count":"","month":0};
var month1 = {"count":"","month":0};
var now = {"count":"","month":0};
//Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

$.ajax({
    url: "chart.do",
    success: function(data){
    	var result = data.result;
    	var monthly = data.monthly;
        if (result=="OK") {
        	var max = 0;
        	monthly.forEach(function(item,index){
        		if(max < item.monthlySales){
        			max = item.monthlySales
        		}
        		switch (index) { 
        		case 0 : month5 = {"count":item.monthlySales,"month":item.createDate} ;break;
        		case 1 : month4 = {"count":item.monthlySales,"month":item.createDate} ;break;
        		case 2 : month3 = {"count":item.monthlySales,"month":item.createDate} ;break;
        		case 3 : month2 = {"count":item.monthlySales,"month":item.createDate} ;break;
        		case 4 : month1 = {"count":item.monthlySales,"month":item.createDate} ;break;
        		case 5 : now = {"count":item.monthlySales,"month":item.createDate} ;break;
        		}
        	});
        	var ctx = document.getElementById("myAreaChart");
        	var myLineChart = new Chart(ctx, {
        	  type: 'line',
        	  data: {
        	    labels: [month5.month,month4.month,month3.month,month2.month,month1.month,now.month],
        	    datasets: [{
        	      label: "총매출",
        	      lineTension: 0.3,
        	      backgroundColor: "rgba(2,117,216,0.2)",
        	      borderColor: "rgba(2,117,216,1)",
        	      pointRadius: 5,
        	      pointBackgroundColor: "rgba(2,117,216,1)",
        	      pointBorderColor: "rgba(255,255,255,0.8)",
        	      pointHoverRadius: 5,
        	      pointHoverBackgroundColor: "rgba(2,117,216,1)",
        	      pointHitRadius: 50,
        	      pointBorderWidth: 2,
        	      data: [month5.count, month4.count, month3.count, month2.count, month1.count, now.count],
        	    }],
        	  },
        	  options: {
        	    scales: {
        	      xAxes: [{
        	        time: {
        	          unit: 'date'
        	        },
        	        gridLines: {
        	          display: false
        	        },
        	        ticks: {
        	          maxTicksLimit: 7
        	        }
        	      }],
        	      yAxes: [{
        	        ticks: {
        	          min: 0,
        	          max: max,
        	          maxTicksLimit: 5
        	        },
        	        gridLines: {
        	          color: "rgba(0, 0, 0, .125)",
        	        }
        	      }],
        	    },
        	    legend: {
        	      display: false
        	    }
        	  }
        	});
        } else{
        	alert("차트를 불러오는 도중 오류가 생겼습니다.");
        }
    }
})


function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
     
    return str;
 
}

</script>
</body>
</html>