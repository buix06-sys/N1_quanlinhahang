<%@ Page Title="Bảng Điều Khiển" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="N1_quanlinhahang.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- CSS tùy chỉnh hiệu ứng chuyển động khi di chuột và Dropdown -->
    <style>
        .hover-card {
            transition: all 0.3s ease-in-out;
            cursor: pointer;
        }
        .hover-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(255, 140, 0, 0.15) !important;
            border-color: #ff8c00 !important;
        }
        .interactive-row {
            transition: background-color 0.2s ease;
        }
        .interactive-row:hover {
            background-color: #2a303c !important;
        }
        /* Đảm bảo menu xổ xuống đè lên các thành phần khác và hiển thị chuẩn */
        .dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            left: auto;
            z-index: 1000;
        }
        .dropdown-menu.show {
            display: block !important;
        }
    </style>
    
    <!-- Thanh thông tin đầu trang kết hợp Dropdown Menu Tài Khoản -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div class="p-2 px-3 rounded bg-dark border border-secondary text-warning font-weight-bold shadow-sm">
            <i class="fas fa-database mr-2"></i> CSDL: QL_NhaHang_Moi
        </div>
        
        <!-- Dropdown Menu Tài Khoản (Quản Lý Chính) -->
        <div class="dropdown" style="position: relative;">
            <button class="btn btn-dark border border-secondary dropdown-toggle text-warning font-weight-bold px-3 py-2" type="button" id="userMenuButton" style="background-color: #1e222d;">
                <i class="fas fa-user-circle mr-2 text-warning"></i> Quản Lý Chính
            </button>
            <div id="myDropdownMenu" class="dropdown-menu shadow-lg border-secondary mt-2" style="background-color: #1e222d; min-width: 240px;">
                <div class="px-3 py-2 border-bottom border-secondary">
                    <span class="d-block text-white font-weight-bold">Tài khoản: Quản Trị Viên</span>
                    <span class="small text-muted">Hệ thống Nhà Hàng N1</span>
                </div>
                <a class="dropdown-item text-light py-2" href="QuanLyNhanVien.aspx">
                    <i class="fas fa-id-badge mr-2 text-warning"></i> Thông tin nhân sự
                </a>
                <a class="dropdown-item text-light py-2" href="Dashboard.aspx">
                    <i class="fas fa-chart-line mr-2 text-info"></i> Bảng điều khiển
                </a>
                <div class="dropdown-divider border-secondary my-1"></div>
                <a class="dropdown-item text-danger py-2 font-weight-bold" href="Login.aspx">
                    <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất hệ thống
                </a>
            </div>
        </div>
    </div>

    <!-- Hàng 1: Trạng thái kết nối & Phân quyền -->
    <div class="row mb-4">
        <div class="col-md-6 mb-3">
            <div class="card p-3 border-warning shadow-sm hover-card" style="border-left: 5px solid #ffc107;" onclick="location.href='QuanLyBanAn.aspx';">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small text-uppercase font-weight-bold">Trạng thái kết nối CSDL</span>
                        <h3 class="text-white font-weight-bold mb-1">Hoạt Động Ổn Định</h3>
                        <span class="text-success small"><i class="fas fa-check-circle mr-1"></i> SQL Server sẵn sàng vận hành (Click quản lý bàn)</span>
                    </div>
                    <div class="text-warning fa-2x">
                        <i class="fas fa-share-alt"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <div class="card p-3 border-primary shadow-sm hover-card" style="border-left: 5px solid #007bff;" onclick="location.href='QuanLyNhanVien.aspx';">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small text-uppercase font-weight-bold">Cấp độ phân quyền</span>
                        <h3 class="text-white font-weight-bold mb-1">Toàn Quyền Quản Trị</h3>
                        <span class="text-info small"><i class="fas fa-shield-alt mr-1"></i> Kiểm soát truy cập hệ thống (Click quản lý nhân sự)</span>
                    </div>
                    <div class="text-primary fa-2x">
                        <i class="fas fa-user-shield"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hàng 2: Tỷ lệ món ăn & Bảng chi tiết trạng thái món -->
    <div class="row mb-4">
        <div class="col-md-5 mb-3">
            <div class="card p-4 shadow-sm h-100 hover-card" onclick="location.href='QuanLyMonAn.aspx';">
                <h5 class="text-warning font-weight-bold mb-1"><i class="fas fa-chart-pie mr-2"></i> Tỷ Lệ Món Ăn Trong Thực Đơn</h5>
                <p class="text-muted small mb-4">Phân bổ tổng số lượng món đã bán so với chưa bán. (Click xem thực đơn)</p>
                <div class="text-center my-auto">
                    <div class="d-inline-block rounded-circle position-relative shadow" style="width: 160px; height: 160px; background: conic-gradient(#ff8c00 0% 75%, #2d3748 75% 100%);">
                        <div class="bg-dark rounded-circle position-absolute d-flex align-items-center justify-content-center text-white font-weight-bold shadow-inset" style="width: 100px; height: 100px; top: 30px; left: 30px;">
                            <span class="small text-warning">75% Đã Bán</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <span class="mr-3 text-white small"><span class="badge badge-warning p-1 mr-1">&nbsp;</span> Món Đã Được Bán</span>
                    <span class="text-white small"><span class="badge badge-secondary p-1 mr-1">&nbsp;</span> Món Chưa Bán</span>
                </div>
            </div>
        </div>

        <div class="col-md-7 mb-3">
            <div class="card p-4 shadow-sm h-100">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="text-info font-weight-bold mb-0"><i class="fas fa-list-alt mr-2"></i> Bảng Chi Tiết Trạng Thái Món Ăn</h5>
                    <a href="QuanLyMonAn.aspx" class="text-warning small text-decoration-none font-weight-bold">Xem tất cả <i class="fas fa-arrow-right ml-1"></i></a>
                </div>
                <p class="text-muted small mb-3">Danh sách chi tiết từng món ăn, số lượng đã bán và trạng thái hiện tại.</p>
                
                <div class="table-responsive" style="max-height: 250px; overflow-y: auto;">
                    <asp:GridView ID="gvThongKeMon" runat="server" CssClass="table table-bordered table-striped text-white small mb-0" 
                        AutoGenerateColumns="False" GridLines="None" RowStyle-CssClass="interactive-row">
                        <Columns>
                            <asp:BoundField DataField="mamonan" HeaderText="Mã Món" />
                            <asp:BoundField DataField="tenmonan" HeaderText="Tên Món Ăn" />
                            <asp:BoundField DataField="soluongban" HeaderText="SL Đã Bán" />
                            <asp:BoundField DataField="trangthaimonan" HeaderText="Trạng Thái" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Hàng 3: Thống kê tổng quan -->
    <div class="row">
        <div class="col-md-4 mb-3">
            <div class="card text-center p-4 shadow-sm bg-dark border-secondary hover-card" onclick="location.href='QuanLyMonAn.aspx';">
                <span class="text-muted font-weight-bold small text-uppercase">Tổng Số Đầu Mục Món</span>
                <h2 class="text-warning font-weight-bold mt-2 mb-0">
                    <asp:Label ID="lblTongMon" runat="server" Text="6"></asp:Label>
                </h2>
                <span class="small text-info mt-1"><i class="fas fa-hand-pointer mr-1"></i> Click để quản lý thực đơn</span>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-center p-4 shadow-sm bg-dark border-secondary hover-card" onclick="location.href='QuanLyDonHang.aspx';">
                <span class="text-muted font-weight-bold small text-uppercase">Tổng Đơn Hàng Thành Công</span>
                <h2 class="text-success font-weight-bold mt-2 mb-0">
                    <asp:Label ID="lblTongDonHang" runat="server" Text="2"></asp:Label>
                </h2>
                <span class="small text-info mt-1"><i class="fas fa-hand-pointer mr-1"></i> Click để xem đơn hàng</span>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-center p-4 shadow-sm bg-dark border-secondary hover-card" onclick="location.href='QuanLyDonHang.aspx';">
                <span class="text-muted font-weight-bold small text-uppercase">Tổng Doanh Thu Giao Dịch</span>
                <h2 class="text-info font-weight-bold mt-2 mb-0">
                    <asp:Label ID="lblDoanhThu" runat="server" Text="130.000 VNĐ"></asp:Label>
                </h2>
                <span class="small text-success mt-1"><i class="fas fa-chart-line mr-1"></i> Cập nhật trực tiếp từ CSDL</span>
            </div>
        </div>
    </div>

    <!-- Đoạn mã Script đảm bảo click vào nút là menu xổ ra bất chấp lỗi thư viện Bootstrap -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var btn = document.getElementById("userMenuButton");
            var menu = document.getElementById("myDropdownMenu");

            if (btn && menu) {
                btn.addEventListener("click", function (e) {
                    e.stopPropagation();
                    menu.classList.toggle("show");
                });

                window.addEventListener("click", function () {
                    if (menu.classList.contains("show")) {
                        menu.classList.remove("show");
                    }
                });
            }
        });
    </script>

</asp:Content>