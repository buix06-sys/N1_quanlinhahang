<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="N1_quanlinhahang.Dashboard" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hệ Thống Quản Lý Nhà Hàng - N1</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome -->
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- SIDEBAR -->
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
                <!-- Mục Quản lý nhân viên: Tự động ẩn nếu không phải tài khoản TK001 -->
                <li id="menuNhanVien" runat="server" class="nav-item">
                    <a class="nav-link" href="QuanLyNhanVien.aspx"><i class="fa-solid fa-id-badge"></i> Quản lý nhân viên</a>
                </li>
                <li class="nav-item"><a class="nav-link" href="QuanLyDatBan.aspx"><i class="fa-solid fa-calendar-check"></i> Quản lý đặt bàn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyMonAn.aspx"><i class="fa-solid fa-burger"></i> Quản lý món ăn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyBanAn.aspx"><i class="fa-solid fa-chair"></i> Quản lý bàn ăn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyDonHang.aspx"><i class="fa-solid fa-receipt"></i> Đơn hàng & Hóa đơn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyKho.aspx"><i class="fa-solid fa-warehouse"></i> Quản lý kho</a></li>

                <li class="my-2">
                    <hr class="text-secondary mx-3" />
                </li>

                <li class="nav-item mb-4">
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link text-danger" OnClick="btnLogout_Click">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </asp:LinkButton>
                </li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
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
                            <div class="text-warning fs-1">
                                <i class="fa-solid fa-circle-nodes"></i>
                            </div>
                        </div>
                        <div class="mt-3 text-warning small fw-bold">
                            <i class="fa-solid fa-hand-pointer"></i> Nhấp để xem thông số kết nối &rarr;
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
                            <div class="text-primary fs-1">
                                <i class="fa-solid fa-user-shield"></i>
                            </div>
                        </div>
                        <div class="mt-3 text-primary small fw-bold">
                            <i class="fa-solid fa-hand-pointer"></i> Nhấp để xem chi tiết quyền hạn &rarr;
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- MODAL CSDL -->
        <div class="modal fade" id="modalCSDL" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content bg-dark text-light border border-secondary shadow-lg">
                    <div class="modal-header border-secondary bg-black">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center fw-bold fs-4" style="width: 45px; height: 45px;">
                                <i class="fa-solid fa-database"></i>
                            </div>
                            <div>
                                <h5 class="modal-title text-white fw-bold mb-0">Cơ Sở Dữ Liệu: QL_NhaHang_Moi</h5>
                                <small class="text-warning">SQL Server 2012 Express (Integrated Security)</small>
                            </div>
                        </div>
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
                            <div class="col-md-6">
                                <div class="p-3 bg-black rounded border border-secondary h-100">
                                    <h6 class="text-success fw-bold mb-2"><i class="fa-solid fa-table me-2"></i> Nhóm Món Ăn & Giao Dịch</h6>
                                    <ul class="list-unstyled text-white small mb-0">
                                        <li>• <strong>MONAN:</strong> Danh mục thực đơn, đơn giá.</li>
                                        <li>• <strong>DONHANG & THANHTOAN:</strong> Quản lý hóa đơn.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 bg-black rounded border border-secondary h-100">
                                    <h6 class="text-info fw-bold mb-2"><i class="fa-solid fa-table me-2"></i> Nhóm Kho Nguyên Liệu</h6>
                                    <ul class="list-unstyled text-white small mb-0">
                                        <li>• <strong>NGUYENLIEU:</strong> Định mức nguyên vật liệu kho.</li>
                                        <li>• <strong>PHEUKHO:</strong> Lịch sử nhập/xuất kho.</li>
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

        <!-- MODAL TRẠNG THÁI -->
        <div class="modal fade" id="modalTrangThai" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-light border border-secondary">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-database"></i> Trạng Thái Kết Nối CSDL</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-white small">Hệ thống đang kết nối trực tiếp với instance SQL Server 2012 Express, đảm bảo tốc độ phản hồi nhanh chóng và an toàn dữ liệu tuyệt đối.</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL PHÂN QUYỀN -->
        <div class="modal fade" id="modalPhanQuyen" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-light border border-secondary">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title text-primary fw-bold"><i class="fa-solid fa-shield-halved"></i> Cơ Chế Phân Quyền Động</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-white small">Mô hình phân quyền dựa trên mã tài khoản (Session). Tài khoản <strong>TK001</strong> đóng vai trò quản trị cấp cao với toàn quyền điều hành, trong khi các tài khoản nhân sự khác bị giới hạn chức năng phù hợp với nghiệp vụ chuyên môn.</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL PROFILE -->
        <div class="modal fade" id="modalProfileQuanLy" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content bg-dark text-light border border-secondary shadow-lg">
                    <div class="modal-header border-secondary bg-black">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center fw-bold fs-4" style="width: 50px; height: 50px;">
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
                        <div class="row mb-4">
                            <div class="col-md-6 border-end border-secondary">
                                <h6 class="text-uppercase text-white small fw-bold mb-3"><i class="fa-solid fa-id-card me-2"></i> Thông tin phiên</h6>
                                <p class="mb-2"><strong>Đang đăng nhập:</strong> <asp:Label ID="lblModalUser" runat="server" Text="Hoạt động"></asp:Label></p>
                                <p class="mb-2"><strong>Bảo mật:</strong> <span class="badge bg-success">Session Secured</span></p>
                            </div>
                            <div class="col-md-6 ps-md-4">
                                <h6 class="text-uppercase text-white small fw-bold mb-3"><i class="fa-solid fa-chart-line me-2"></i> Trạng thái hoạt động</h6>
                                <div class="d-flex justify-content-between bg-black p-2 rounded mb-2 border border-secondary">
                                    <span>Quyền hạn hệ thống:</span>
                                    <strong class="text-warning">Đồng bộ theo CSDL</strong>
                                </div>
                            </div>
                        </div>
                        <hr class="border-secondary my-3" />
                        <h6 class="text-uppercase text-white small fw-bold mb-3"><i class="fa-solid fa-sitemap me-2"></i> Sơ đồ bộ phận nhà hàng</h6>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary text-center h-100">
                                    <div class="text-warning mb-2 fs-4"><i class="fa-solid fa-users-gear"></i></div>
                                    <h6 class="fw-bold text-white mb-1">Nhân Viên Kho</h6>
                                    <p class="text-white small mb-2">Quản lý nguyên liệu & phiếu kho.</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary text-center h-100">
                                    <div class="text-primary mb-2 fs-4"><i class="fa-solid fa-user-clock"></i></div>
                                    <h6 class="fw-bold text-white mb-1">Phục Vụ / Bàn</h6>
                                    <p class="text-white small mb-2">Xử lý đặt bàn, thực đơn món ăn.</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-3 bg-black rounded border border-secondary text-center h-100">
                                    <div class="text-success mb-2 fs-4"><i class="fa-solid fa-cash-register"></i></div>
                                    <h6 class="fw-bold text-white mb-1">Thu Ngân</h6>
                                    <p class="text-white small mb-2">Quản lý hóa đơn thanh toán.</p>
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
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>