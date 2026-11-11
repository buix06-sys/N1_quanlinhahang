
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="QuanLyMonAn.aspx.cs"
    Inherits="N1_quanlinhahang.QuanLyMonAn" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Quản Lý Món Ăn - Nhà Hàng N1</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet" />

    <style>
        :root {
            --sidebar-width: 260px;
            --primary: #ffc107;
            --sidebar-bg: #181b20;
            --body-bg: #181b20;
            --card-bg: #20242a;
            --border-color: #30363d;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--body-bg);
            color: #fff;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--border-color);
            overflow-y: auto;
            z-index: 1000;
        }

        .brand {
            height: 70px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 22px;
            font-size: 19px;
            font-weight: 700;
            border-bottom: 1px solid var(--border-color);
            color: #fff;
        }

        .brand i {
            font-size: 24px;
            color: var(--primary);
        }

        .menu-header {
            padding: 20px 20px 8px;
            color: #8b949e;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .sidebar .nav-link {
            color: #adb5bd;
            padding: 12px 20px;
            margin: 3px 12px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: .2s;
        }

        .sidebar .nav-link i {
            width: 20px;
            text-align: center;
        }

        .sidebar .nav-link:hover {
            color: #fff;
            background: #2b3036;
        }

        .sidebar .nav-link.active {
            background: #ffc107;
            color: #212529;
            font-weight: 600;
        }

        /* MAIN */
        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            padding: 28px;
            display: flex;
            flex-direction: column;
        }

        .page-title {
            color: #fff;
            font-size: 27px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .page-title i {
            color: #ffc107;
        }

        /* CARD */
        .custom-card {
            background: #20242a;
            border: 1px solid #30363d;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 24px;
        }

        .card-title {
            font-size: 19px;
            font-weight: 700;
            margin-bottom: 22px;
        }

        /* FORM */
        .form-label {
            color: #fff;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control,
        .form-select {
            background: #181b20 !important;
            color: #fff !important;
            border: 1px solid #30363d !important;
            min-height: 43px;
            border-radius: 7px;
        }

        .form-control::placeholder {
            color: #8b949e;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #ffc107 !important;
            box-shadow: 0 0 0 .2rem rgba(255,193,7,.15) !important;
        }

        .form-select option {
            background: #20242a;
            color: #fff;
        }

        /* BUTTON */
        .btn-warning {
            background: #ffc107;
            border-color: #ffc107;
            color: #212529;
            font-weight: 700;
        }

        .btn-warning:hover {
            background: #e0a800;
            border-color: #e0a800;
            color: #212529;
        }

        /* TABLE */
        .table-responsive {
            border-radius: 8px;
        }

        .table {
            margin-bottom: 0;
            white-space: nowrap;
            border-color: #30363d;
        }

        .table thead th {
            background: #2b3036 !important;
            color: #ffc107 !important;
            padding: 14px 12px;
            border-color: #30363d;
            vertical-align: middle;
        }

        .table tbody td {
            background: #20242a;
            color: #fff;
            padding: 12px;
            border-color: #30363d;
            vertical-align: middle;
        }

        .table-striped tbody tr:nth-of-type(odd) td {
            background: #252a30;
            color: #fff;
        }

        .table tbody tr:hover td {
            background: #343a40 !important;
            color: #fff;
        }

        /* FOOTER */
        .footer-text {
            margin-top: auto;
            padding-top: 20px;
            text-align: center;
            color: #8b949e;
            font-size: 13px;
        }

        /* MESSAGE */
        .alert-success {
            background: #173d2b;
            border-color: #246b45;
            color: #a3e4bd;
        }

        .alert-danger {
            background: #4a2025;
            border-color: #842029;
            color: #f5b7bd;
        }

        /* RESPONSIVE */
        @media (max-width: 992px) {
            :root {
                --sidebar-width: 220px;
            }

            .main-content {
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .main-content {
                margin-left: 0;
                padding: 15px;
            }

            .page-title {
                font-size: 22px;
            }

            .custom-card {
                padding: 16px;
            }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>N1 - NHÀ HÀNG</span>
        </div>

        <ul class="nav flex-column mt-2">
            <li class="menu-header">Tổng quan</li>

            <li>
                <a class="nav-link" href="Dashboard.aspx">
                    <i class="fa-solid fa-chart-pie"></i>
                    Bảng điều khiển
                </a>
            </li>

            <li class="menu-header">Quản trị hệ thống</li>

            <li>
                <a class="nav-link" href="QuanLyDatBan.aspx">
                    <i class="fa-solid fa-calendar-check"></i>
                    Quản lý đặt bàn
                </a>
            </li>

            <li>
                <a class="nav-link active" href="QuanLyMonAn.aspx">
                    <i class="fa-solid fa-burger"></i>
                    Quản lý món ăn
                </a>
            </li>

            <li>
                <a class="nav-link" href="QuanLyBanAn.aspx">
                    <i class="fa-solid fa-chair"></i>
                    Quản lý bàn ăn
                </a>
            </li>

            <li>
                <a class="nav-link" href="QuanLyDonHang.aspx">
                    <i class="fa-solid fa-receipt"></i>
                    Đơn hàng & Hóa đơn
                </a>
            </li>

            <li>
                <a class="nav-link" href="QuanLyKho.aspx">
                    <i class="fa-solid fa-warehouse"></i>
                    Quản lý kho
                </a>
            </li>
        </ul>
    </div>

    <!-- MAIN -->
    <main class="main-content">

        <h3 class="page-title">
            <i class="fa-solid fa-burger me-2"></i>
            Quản Lý Thực Đơn & Món Ăn
        </h3>

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server"
            Visible="false"
            CssClass="alert d-block mb-4" />

        <!-- FORM -->
        <div class="custom-card">

            <h5 class="card-title text-warning">
                <i class="fa-solid fa-plus-circle me-2"></i>
                Thêm / Cập Nhật Món Ăn
            </h5>

            <div class="row g-3">

                <div class="col-md-3">
                    <label class="form-label">Mã món ăn</label>
                    <asp:TextBox ID="txtMaMon" runat="server"
                        CssClass="form-control"
                        MaxLength="20"
                        placeholder="VD: M001" />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Tên món ăn</label>
                    <asp:TextBox ID="txtTenMon" runat="server"
                        CssClass="form-control"
                        MaxLength="100"
                        placeholder="Nhập tên món ăn..." />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Đơn giá</label>
                    <asp:TextBox ID="txtDonGia" runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        placeholder="Nhập đơn giá..." />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Danh mục</label>
                    <asp:DropDownList ID="ddlDanhMuc" runat="server"
                        CssClass="form-select">
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Tên hình ảnh</label>
                    <asp:TextBox ID="txtHinhAnh" runat="server"
                        CssClass="form-control"
                        placeholder="VD: phobo.jpg" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Trạng thái món ăn</label>
                    <asp:DropDownList ID="ddlTrangThai" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Đang bán" Value="Đang bán" />
                        <asp:ListItem Text="Ngừng bán" Value="Ngừng bán" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Mã sản phẩm (nếu có)</label>
                    <asp:TextBox ID="txtMaSanPham" runat="server"
                        CssClass="form-control"
                        placeholder="VD: NL001" />
                </div>

            </div>

            <!-- BUTTON -->
            <div class="mt-4 d-flex flex-wrap gap-2">

                <asp:Button ID="btnThem" runat="server"
                    Text="Thêm Món Ăn"
                    CssClass="btn btn-warning px-4"
                    OnClick="btnThem_Click" />

                <asp:Button ID="btnCapNhat" runat="server"
                    Text="Cập Nhật"
                    CssClass="btn btn-success px-4 fw-bold"
                    OnClick="btnCapNhat_Click"
                    Visible="false" />

                <asp:Button ID="btnLamMoi" runat="server"
                    Text="Làm Mới"
                    CssClass="btn btn-secondary px-4"
                    OnClick="btnLamMoi_Click" />

            </div>

        </div>

        <!-- DANH SACH -->
        <div class="custom-card">

            <h5 class="card-title text-info">
                <i class="fa-solid fa-table-list me-2"></i>
                Danh Sách Món Ăn
            </h5>

            <div class="table-responsive">

                <asp:GridView ID="gvMonAn" runat="server"
                    CssClass="table table-dark table-striped table-bordered text-center align-middle"
                    AutoGenerateColumns="False"
                    DataKeyNames="mamonan"
                    EmptyDataText="Chưa có món ăn nào!"
                    OnRowCommand="gvMonAn_RowCommand">

                    <Columns>

                        <asp:BoundField DataField="mamonan"
                            HeaderText="Mã món ăn" />

                        <asp:BoundField DataField="tenmonan"
                            HeaderText="Tên món ăn" />

                        <asp:BoundField DataField="hinhanh"
                            HeaderText="Hình ảnh" />

                        <asp:BoundField DataField="dongia"
                            HeaderText="Đơn giá"
                            DataFormatString="{0:N0}" />

                        <asp:BoundField DataField="trangthaimonan"
                            HeaderText="Trạng thái" />

                        <asp:BoundField DataField="madanhmuc"
                            HeaderText="Mã danh mục" />

                        <asp:BoundField DataField="masanpham"
                            HeaderText="Mã sản phẩm" />

                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>

                                <asp:LinkButton ID="btnSua" runat="server"
                                    CommandName="Sua"
                                    CommandArgument='<%# Eval("mamonan") %>'
                                    CssClass="btn btn-warning btn-sm fw-bold me-1">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnXoa" runat="server"
                                    CommandName="Xoa"
                                    CommandArgument='<%# Eval("mamonan") %>'
                                    CssClass="btn btn-danger btn-sm fw-bold"
                                    OnClientClick="return confirm('Bạn có chắc muốn xóa món ăn này không?');">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>
        </div>

        <div class="footer-text">
            © 2026 N1 Restaurant Management System
        </div>

    </main>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
