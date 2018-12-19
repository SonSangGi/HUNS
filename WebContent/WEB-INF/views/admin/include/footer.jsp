<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

</div>
<!-- 래퍼 닫는 태그 -->

<!-- 푸터 시작 -->

  <!-- 스크롤 상단으로 -->
    <a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
    </a>

    <!-- 로그아웃 기능 -->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃시 쇼핑몰페이지로 이동되며 <br>재접속 시 다시 로그인 해야합니다.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" href="../main/logout.do">로그아웃</a>
                </div>
            </div>
        </div>
    </div>




	<!-- 스크립트 인클루드 -->
    <script src="../../../resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="../../../resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../../../resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="../../../resources/admin/vendor/chart.js/Chart.min.js"></script>
    <script src="../../../resources/admin/vendor/datatables/jquery.dataTables.js"></script>
    <script src="../../../resources/admin/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../../../resources/admin/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="../../../resources/admin/js/demo/datatables-demo.js"></script>

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>