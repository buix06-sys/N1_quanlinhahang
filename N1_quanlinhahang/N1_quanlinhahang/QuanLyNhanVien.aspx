<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyNhanVien.aspx.cs" Inherits="N1_quanlinhahang.QuanLyNhanVien" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Nhân Viên - Hệ Thống Nhà Hàng N1</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body { background-color: #181b20; color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        p, label, .form-label, .text-muted, h3, h5, th { color: #ffffff !important; }
        
        /* Sidebar */
        .sidebar { width: 260px; height: 100vh; position: fixed; top: 0; left: 0; background-color: #21252b; border-right: 1px solid #2c313a; padding-top: 20px; z-index: 100; overflow-y: auto; }
        .sidebar .brand { font-size: 1.1rem; font-weight: bold; color: #fff; padding: 0 20px 20px 20px; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #2c313a; }
        .sidebar .nav-link { color: #abb2bf; padding: 10px 20px; margin: 4px 12px; border-radius: 8px; display: flex; align-items: center; gap: 12px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #ff7b00; color: #fff; }
        .menu-header { font-size: 0.75rem; text-transform: uppercase; color: #6c757d; padding: 10px 20px 5px 20px; font-weight: bold; }
        
        /* Main Content */
        .main-content { margin-left: 260px; padding: 20px 30px; }
        .custom-card { background-color: #21252b; border: 1px solid #2c313a; border-radius: 14px; padding: 25px; color: #fff; }
        
        /* Ép chữ ô nhập liệu màu trắng */
        .form-control, .form-select {
            background-color: #181b20 !important;
            border: 1px solid #2c313a !important;
            color: #ffffff !important;
        }
        .form-control:focus, .form-select:focus {
            background-color: #181b20 !important;
            color: #ffffff !important;
            border-color: #ff7b00 !important;
            box-shadow: none !important;
        }
        .form-control::placeholder { color: #adb5bd !important; opacity: 1; }
        
        /* Bảng Dark-theme */
        .table-dark-custom { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; }
        .table-dark-custom th { background-color: #1a1d23 !important; color: #ffc107 !important; border-color: #2c313a !important; }
        .table-dark-custom td { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; vertical-align: middle; }
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
                    <a class="nav-link" href="Dashboard.aspx"><i class="fa-solid fa-chart-pie"></i> Bảng điều khiển</a>
                </li>

                <li class="menu-header mt-2">Quản trị hệ thống</li>
                <li class="nav-item">
                    <a class="nav-link active" href="QuanLyNhanVien.aspx"><i class="fa-solid fa-id-badge"></i> Quản lý nhân viên</a>
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

        <!-- MAIN CONTENT -->
        <main class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold text-white"><i class="fa-solid fa-id-badge text-warning me-2"></i> Quản Lý Nhân Sự & Tài Khoản</h3>
                <span class="badge bg-warning text-dark px-3 py-2 fw-bold">Phân quyền: Quản Trị Cấp Cao (TK001)</span>
            </div>

            <!-- THÔNG BÁO -->
            <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info d-block py-2 mb-3"></asp:Label>

            <!-- FORM NHẬP LIỆU & NÚT THÊM, SỬA, XÓA -->
            <div class="custom-card mb-4">
                <h5 class="fw-bold mb-3 text-warning"><i class="fa-solid fa-user-gear me-2"></i> Thông Tin Chi Tiết Nhân Sự</h5>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Mã Nhân Viên</label>
                        <asp:TextBox ID="txtMaNV" runat="server" CssClass="form-control" placeholder="VD: NV001"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Họ và Tên</label>
                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nhập họ tên nhân viên..."></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Giới Tính</label>
                        <asp:DropDownList ID="ddlGioiTinh" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Nam" Value="Nam"></asp:ListItem>
                            <asp:ListItem Text="Nữ" Value="Nữ"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Số Điện Thoại</label>
                        <asp:TextBox ID="txtSdt" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại..."></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Chức Vụ</label>
                        <asp:TextBox ID="txtChucVu" runat="server" CssClass="form-control" placeholder="VD: Phục vụ, Thu ngân..."></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Mã Tài Khoản Liên Kết</label>
                        <asp:TextBox ID="txtMaTK" runat="server" CssClass="form-control" placeholder="VD: TK002"></asp:TextBox>
                    </div>
                </div>

                <!-- CÁC NÚT THAO TÁC: THÊM, SỬA, XÓA, LÀM MỚI -->
                <div class="mt-4 d-flex gap-2 flex-wrap">
                    <asp:Button ID="btnThem" runat="server" Text="Thêm Mới" CssClass="btn btn-warning fw-bold px-4 text-dark" OnClick="btnThem_Click" />
                    <asp:Button ID="btnSua" runat="server" Text="Cập Nhật (Sửa)" CssClass="btn btn-primary fw-bold px-4" OnClick="btnSua_Click" />
                    <asp:Button ID="btnXoa" runat="server" Text="Xóa Nhân Viên" CssClass="btn btn-danger fw-bold px-4" OnClick="btnXoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này không?');" />
                    <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới Form" CssClass="btn btn-secondary px-4" OnClick="btnLamMoi_Click" />
                </div>
            </div>

            <!-- DANH SÁCH NHÂN VIÊN (GRIDVIEW CÓ TÍNH NĂNG CHỌN DÒNG) -->
            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-table-list me-2"></i> Danh Sách Nhân Sự Nhà Hàng</h5>
                <div class="table-responsive">
                    <asp:GridView ID="gvNhanVien" runat="server" CssClass="table table-dark table-striped table-bordered table-dark-custom align-middle text-center" AutoGenerateColumns="False" DataKeyNames="manhanvien" OnSelectedIndexChanged="gvNhanVien_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandButtonField ShowSelectButton="True" SelectText="Chọn" HeaderText="Thao tác" ControlStyle-CssClass="btn btn-sm btn-outline-warning text-white" />
                            <asp:BoundField DataField="manhanvien" HeaderText="Mã NV" />
                            <asp:BoundField DataField="hoten" HeaderText="Họ và Tên" />
                            <asp:BoundField DataField="gioitinh" HeaderText="Giới Tính" />
                            <asp:BoundField DataField="sodienthoai" HeaderText="Số Điện Thoại" />
                            <asp:BoundField DataField="chucvu" HeaderText="Chức Vụ" />
                            <asp:BoundField DataField="trangthailamviec" HeaderText="Trạng Thái" />
                            <asp:BoundField DataField="matkhoan" HeaderText="Mã TK" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </main>
    </form>
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>