<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="N1_quanlinhahang.Dashboard" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hệ Thống Quản Lý Nhà Hàng - N1</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body { background-color: #181b20; color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        p, label, .form-label, .text-muted, .custom-card { color: #ffffff !important; }
        .sidebar { width: 260px; height: 100vh; position: fixed; top: 0; left: 0; background-color: #21252b; border-right: 1px solid #2c313a; padding-top: 20px; z-index: 100; overflow-y: auto; }
        .sidebar .brand { font-size: 1.1rem; font-weight: bold; color: #fff; padding: 0 20px 20px 20px; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #2c313a; }
        .sidebar .nav-link { color: #abb2bf; padding: 10px 20px; margin: 4px 12px; border-radius: 8px; display: flex; align-items: center; gap: 12px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #ff7b00; color: #fff; }
        .menu-header { font-size: 0.75rem; text-transform: uppercase; color: #6c757d; padding: 10px 20px 5px 20px; font-weight: bold; }
        .main-content { margin-left: 260px; padding: 20px 30px; }
        .top-navbar { background-color: #21252b; border-radius: 12px; padding: 12px 20px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; border: 1px solid #2c313a; }
        .custom-card { background-color: #21252b; border: 1px solid #2c313a; border-radius: 14px; padding: 20px; color: #fff; transition: transform 0.2s; }
        .custom-card:hover { transform: translateY(-3px); border-color: #ff7b00; }
        .db-badge { cursor: pointer; transition: all 0.2s; }
        .db-badge:hover { opacity: 0.85; transform: scale(1.02); }
        .table-dark-custom { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; }
        .table-dark-custom th { background-color: #1a1d23 !important; color: #ffc107 !important; border-color: #2c313a !important; }
        .table-dark-custom td { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; vertical-align: middle; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="sidebar">
            <div class="brand">
                <i class="fa-solid fa-utensils text-warning"></i>
                <span>N1 - NHÀ HÀNG</span>
            </div>
            
            <ul class="nav flex-column mt-2">
                <li class="menu-header">Tổng quan</li>
                <li class="nav-item">
                    <a class="nav-link active" href="Dashboard.aspx"><i class="fa-solid fa-chart-pie"></i> Bảng điều khiển</a>
                </li>

                <li class="menu-header mt-2">Quản trị hệ thống</li>
                <li id="menuNhanVien" runat="server" class="nav-item">
                    <a class="nav-link" href="QuanLyNhanVien.aspx"><i class="fa-solid fa-id-badge"></i> Quản lý nhân viên</a>
                </li>
                <li class="nav-item"><a class="nav-link" href="QuanLyDatBan.aspx"><i class="fa-solid fa-calendar-check"></i> Quản lý đặt bàn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyMonAn.aspx"><i class="fa-solid fa-burger"></i> Quản lý món ăn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyBanAn.aspx"><i class="fa-solid fa-chair"></i> Quản lý bàn ăn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyDonHang.aspx"><i class="fa-solid fa-receipt"></i> Đơn hàng & Hóa đơn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyKho.aspx"><i class="fa-solid fa-warehouse"></i> Quản lý kho</a></li>

                <li class="my-2"><hr class="text-secondary mx-3" /></li>

                <li class="nav-item mb-4">
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link text-danger" OnClick="btnLogout_Click">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </asp:LinkButton>
                </li>
            </ul>
        </div>

        <main class="main-content">
      
            <div class="top-navbar">
                <span class="badge bg-warning text-dark px-3 py-2 fw-bold db-badge shadow-sm" data-bs-toggle="modal" data-bs-target="#modalCSDL" title="Nhấp để xem chi tiết CSDL QL_NhaHang_Moi">
                    <i class="fa-solid fa-database me-1"></i> CSDL: QL_NhaHang_Moi <i class="fa-solid fa-circle-info ms-1"></i>
                </span>
                
                <div class="d-flex align-items-center gap-2 px-3 py-1 rounded border border-secondary" style="cursor: pointer; background-color: #181b20;" data-bs-toggle="modal" data-bs-target="#modalProfileQuanLy">
                    <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center fw-bold shadow" style="width: 38px; height: 38px;">
                        <i class="fa-solid fa-user-tie"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 text-white fw-bold small"><asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label> <i class="fa-solid fa-chevron-down text-warning ms-1" style="font-size: 0.7rem;"></i></h6>
                        <small class="text-warning" style="font-size: 0.75rem;"><asp:Label ID="lblUserRole" runat="server" Text="Role"></asp:Label></small>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="custom-card border-start border-warning border-4 h-100" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalTrangThai">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted text-uppercase small">Trạng thái kết nối CSDL</h6>
                                <h3 class="fw-bold mt-2 text-white">Hoạt Động Ổn Định</h3>
                                <span class="small text-success"><i class="fa-solid fa-check-circle"></i> SQL Server sẵn sàng vận hành</span>
                            </div>
                            <div class="text-warning fs-1"><i class="fa-solid fa-circle-nodes"></i></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="custom-card border-start border-primary border-4 h-100" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalPhanQuyen">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted text-uppercase small">Cấp độ phân quyền</h6>
                                <h3 class="fw-bold mt-2 text-white"><asp:Label ID="lblCardRole" runat="server" Text="Quản lý"></asp:Label></h3>
                                <span class="small text-primary"><i class="fa-solid fa-shield-halved"></i> Kiểm soát truy cập hệ thống</span>
                            </div>
                            <div class="text-primary fs-1"><i class="fa-solid fa-user-shield"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-xl-5">
                    <div class="custom-card h-100">
                        <h5 class="fw-bold mb-3 text-warning"><i class="fa-solid fa-chart-pie me-2"></i> Tỷ Lệ Món Ăn Trong Thực Đơn</h5>
                        <p class="text-muted small">Phân bổ tổng số lượng món đã bán so với chưa bán.</p>
                        <div style="position: relative; height: 260px; width: 100%; display: flex; justify-content: center;">
                            <canvas id="chartMonAn"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-xl-7">
                    <div class="custom-card h-100">
                        <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-table-list me-2"></i> Bảng Chi Tiết Trạng Thái Món Ăn</h5>
                        <p class="text-muted small">Danh sách chi tiết từng món ăn, số lượng đã bán và trạng thái hiện tại.</p>
                        <div class="table-responsive" style="max-height: 260px; overflow-y: auto;">
                            <asp:GridView ID="gvChiTietMonAn" runat="server" CssClass="table table-dark table-striped table-bordered table-dark-custom align-middle text-center small" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="mamonan" HeaderText="Mã Món" />
                                    <asp:BoundField DataField="tenmonan" HeaderText="Tên Món Ăn" ItemStyle-CssClass="text-start fw-bold" />
                                    <asp:BoundField DataField="soluongban" HeaderText="SL Đã Bán" ItemStyle-CssClass="text-warning fw-bold" />
                                    <asp:TemplateField HeaderText="Trạng Thái">
                                        <ItemTemplate>
                                            <span class='badge <%# Convert.ToInt32(Eval("soluongban")) > 0 ? "bg-success" : "bg-secondary" %>'>
                                                <%# Convert.ToInt32(Eval("soluongban")) > 0 ? "Đã bán" : "Chưa bán" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-12">
                    <div class="custom-card">
                        <div class="row text-center g-3">
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary">
                                    <h6 class="text-muted small text-uppercase">Tổng Số Đầu Mục Món</h6>
                                    <h3 class="fw-bold text-warning mb-0"><asp:Label ID="lblTongMonAn" runat="server" Text="0"></asp:Label></h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary">
                                    <h6 class="text-muted small text-uppercase">Tổng Đơn Hàng Thành Công</h6>
                                    <h3 class="fw-bold text-success mb-0"><asp:Label ID="lblTongDonHang" runat="server" Text="0"></asp:Label></h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary">
                                    <h6 class="text-muted small text-uppercase">Tổng Doanh Thu Giao Dịch</h6>
                                    <h3 class="fw-bold text-info mb-0"><asp:Label ID="lblTongDoanhThu" runat="server" Text="0 VNĐ"></asp:Label></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="modal fade" id="modalCSDL" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content bg-dark text-light border border-secondary shadow-lg">
                    <div class="modal-header border-secondary bg-black">
                        <h5 class="modal-title text-white fw-bold"><i class="fa-solid fa-database text-warning me-2"></i> Cơ Sở Dữ Liệu: QL_NhaHang_Moi</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <p class="text-white small">Hệ thống quản lý dữ liệu nhà hàng được thiết kế đồng bộ với các bảng thực thể cốt lõi:</p>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="p-3 bg-black rounded border border-secondary h-100">
                                    <h6 class="text-warning fw-bold mb-2"><i class="fa-solid fa-table me-2"></i> Nhóm Nhân Sự & Tài Khoản</h6>
                                    <ul class="list-unstyled text-white small mb-0">
                                        <li>• <strong>TAIKHOAN:</strong> Quản lý phân quyền, mật khẩu tài khoản.</li>
                                        <li>• <strong>NHANVIEN:</strong> Lưu thông tin nhân sự, chức vụ.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 bg-black rounded border border-secondary h-100">
                                    <h6 class="text-primary fw-bold mb-2"><i class="fa-solid fa-table me-2"></i> Nhóm Phục Vụ & Đặt Bàn</h6>
                                    <ul class="list-unstyled text-white small mb-0">
                                        <li>• <strong>BANAN:</strong> Quản lý vị trí bàn, trạng thái.</li>
                                        <li>• <strong>DATBAN:</strong> Quản lý lịch đặt bàn của khách hàng.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-secondary bg-black">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalTrangThai" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-light border border-secondary">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-circle-nodes me-2"></i> Trạng Thái Kết Nối CSDL</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-white small">Hệ thống đang kết nối trực tiếp với SQL Server, đảm bảo tốc độ phản hồi nhanh chóng và an toàn dữ liệu tuyệt đối.</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalPhanQuyen" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-light border border-secondary">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title text-primary fw-bold"><i class="fa-solid fa-shield-halved me-2"></i> Cơ Chế Phân Quyền Động</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-white small">Mô hình phân quyền dựa trên mã tài khoản (Session). Tài khoản TK001 toàn quyền quản trị, các tài khoản khác phân tách theo nghiệp vụ.</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalProfileQuanLy" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content bg-dark text-light border border-secondary shadow-lg">
                    <div class="modal-header border-secondary bg-black">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center fw-bold fs-4" style="width: 45px; height: 45px;">
                                <i class="fa-solid fa-user-tie"></i>
                            </div>
                            <div>
                                <h5 class="modal-title text-white fw-bold mb-0">Hồ Sơ Người Dùng Hệ Thống</h5>
                                <small class="text-warning">Điều hành Nhà hàng N1</small>
                            </div>
                        </div>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <p class="mb-2"><strong>Đang đăng nhập:</strong> <asp:Label ID="lblModalUser" runat="server" Text="Hoạt động"></asp:Label></p>
                        <p class="mb-2"><strong>Bảo mật:</strong> <span class="badge bg-success">Session Secured</span></p>
                    </div>
                    <div class="modal-footer border-secondary bg-black">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var daBan = <%= SoLuongDaBan %>;
        var chuaBan = <%= SoLuongChuaBan %>;

        const ctx = document.getElementById('chartMonAn').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['Món Đã Được Bán', 'Món Chưa Bán'],
                datasets: [{
                    data: [daBan, chuaBan],
                    backgroundColor: ['#ff7b00', '#21252b'],
                    borderColor: ['#ffffff', '#6c757d'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#ffffff', font: { size: 12 } }
                    }
                }
            }
        });
    </script>
</body>
</html>
