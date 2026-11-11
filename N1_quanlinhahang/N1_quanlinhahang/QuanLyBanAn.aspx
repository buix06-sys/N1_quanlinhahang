
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="QuanLyBanAn.aspx.cs"
    Inherits="N1_quanlinhahang.QuanLyBanAn" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản lý bàn ăn - N1 Restaurant</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <!-- Font Awesome -->
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
        --text-color: #ffffff;
        --text-muted: #adb5bd;
    }

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: var(--body-bg);
        color: var(--text-color);
    }

    /* SIDEBAR */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: var(--sidebar-width);
        height: 100vh;
        background: var(--sidebar-bg);
        color: #fff;
        overflow-y: auto;
        z-index: 1000;
        border-right: 1px solid var(--border-color);
        box-shadow: none;
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
        padding: 22px 20px 8px;
        color: #8f98a1;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .sidebar .nav-link {
        color: #cbd0d5;
        padding: 12px 20px;
        margin: 3px 12px;
        border-radius: 8px;
        transition: .2s;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .sidebar .nav-link i {
        width: 20px;
        text-align: center;
        color: #adb5bd;
    }

    .sidebar .nav-link:hover {
        color: #fff;
        background: #2b3036;
    }

    .sidebar .nav-link.active {
        background: var(--primary);
        color: #212529;
        font-weight: 600;
    }

    .sidebar .nav-link.active i {
        color: #212529;
    }

    /* MAIN CONTENT */
    .main-content {
        margin-left: var(--sidebar-width);
        min-height: 100vh;
        padding: 28px;
        display: flex;
        flex-direction: column;
        background: var(--body-bg);
    }

    .page-title {
        font-size: 27px;
        font-weight: 700;
        margin-bottom: 25px;
        color: #fff;
    }

    .page-title i {
        color: var(--primary);
    }

    /* CARD */
    .custom-card {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: none;
        border: 1px solid var(--border-color);
    }

    .card-title {
        font-size: 19px;
        font-weight: 700;
        margin-bottom: 22px;
    }

    .card-title.text-warning {
        color: #ffc107 !important;
    }

    .card-title.text-info {
        color: #0dcaf0 !important;
    }

    /* FORM */
    .form-label {
        font-weight: 600;
        color: #fff;
        margin-bottom: 8px;
    }

    .form-control,
    .form-select {
        min-height: 43px;
        border-radius: 7px;
        background-color: #181b20;
        color: #fff;
        border: 1px solid #30363d;
    }

    .form-control::placeholder {
        color: #8b949e;
    }

    .form-control:focus,
    .form-select:focus {
        background-color: #181b20;
        color: #fff;
        border-color: #ffc107;
        box-shadow: 0 0 0 .2rem rgba(255,193,7,.15);
    }

    .form-select option {
        background: #20242a;
        color: #fff;
    }

    /* BUTTON */
    .btn-orange {
        background: #ffc107;
        color: #212529;
        border: none;
        font-weight: 700;
    }

    .btn-orange:hover {
        background: #e0a800;
        color: #212529;
    }

    .btn-warning {
        background: #ffc107;
        border-color: #ffc107;
        color: #212529;
    }

    .btn-warning:hover {
        background: #e0a800;
        color: #212529;
    }

    /* TABLE */
    .table-responsive {
        border-radius: 8px;
    }

    .table {
        margin-bottom: 0;
        white-space: nowrap;
        color: #fff;
        border-color: #30363d;
    }

    .table thead th {
        background: #2b3036 !important;
        color: #ffc107 !important;
        padding: 14px 12px;
        vertical-align: middle;
        font-weight: 700;
        border-color: #30363d;
    }

    .table tbody td {
        padding: 12px;
        vertical-align: middle;
        background: #20242a;
        color: #fff;
        border-color: #30363d;
    }

    .table-striped tbody tr:nth-of-type(odd) td {
        background: #252a30;
        color: #fff;
    }

    .table tbody tr:hover td {
        background: #343a40 !important;
        color: #fff;
    }

    /* STATUS */
    .badge-status {
        display: inline-block;
        padding: 7px 13px;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 600;
    }

    .status-empty {
        background: #198754;
        color: #fff;
    }

    .status-busy {
        background: #dc3545;
        color: #fff;
    }

    .status-booked {
        background: #ffc107;
        color: #212529;
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

    /* FOOTER */
    .footer-text {
        margin-top: auto;
        padding-top: 20px;
        text-align: center;
        color: #8b949e;
        font-size: 13px;
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

        .brand {
            height: 60px;
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

    <div class="sidebar">
        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>N1 - NHÀ HÀNG</span>
        </div>

        <ul class="nav flex-column mt-2">
            <li class="menu-header">Tổng quan</li>

            <li class="nav-item">
                <a class="nav-link" href="Dashboard.aspx">
                    <i class="fa-solid fa-chart-pie"></i>
                    Bảng điều khiển
                </a>
            </li>

            <li class="menu-header">Quản trị hệ thống</li>

            <li class="nav-item">
                <a class="nav-link" href="QuanLyDatBan.aspx">
                    <i class="fa-solid fa-calendar-check"></i>
                    Quản lý đặt bàn
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="QuanLyMonAn.aspx">
                    <i class="fa-solid fa-burger"></i>
                    Quản lý món ăn
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link active" href="QuanLyBanAn.aspx">
                    <i class="fa-solid fa-chair"></i>
                    Quản lý bàn ăn
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="QuanLyDonHang.aspx">
                    <i class="fa-solid fa-receipt"></i>
                    Đơn hàng & Hóa đơn
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="QuanLyKho.aspx">
                    <i class="fa-solid fa-warehouse"></i>
                    Quản lý kho
                </a>
            </li>
        </ul>
    </div>

    <main class="main-content">

        <h3 class="page-title">
            <i class="fa-solid fa-chair me-2"></i>
            Quản Lý Bàn Ăn Nhà Hàng
        </h3>

        <asp:Label ID="lblMessage" runat="server"
            Visible="false"
            CssClass="alert d-block mb-4" />

        <!-- FORM THEM / CAP NHAT -->
        <div class="custom-card">

            <h5 class="card-title text-warning">
                <i class="fa-solid fa-pen-to-square me-2"></i>
                Thêm / Cập Nhật Bàn Ăn
            </h5>

            <div class="row g-3">

                <div class="col-md-4">
                    <label class="form-label">Mã bàn</label>
                    <asp:TextBox ID="txtMaBan" runat="server"
                        CssClass="form-control"
                        MaxLength="20"
                        placeholder="VD: B05" />
                </div>

                <div class="col-md-4">
                    <label class="form-label">Số hàng</label>
                    <asp:TextBox ID="txtSoHang" runat="server"
                        CssClass="form-control"
                        Text="4"
                        TextMode="Number" />
                </div>

                <div class="col-md-4">
                    <label class="form-label">Số cột</label>
                    <asp:TextBox ID="txtSoCot" runat="server"
                        CssClass="form-control"
                        Text="4"
                        TextMode="Number" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Vị trí</label>
                    <asp:TextBox ID="txtViTri" runat="server"
                        CssClass="form-control"
                        placeholder="Tầng trệt / Tầng 1..." />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Trạng thái bàn</label>
                    <asp:DropDownList ID="ddlTrangThai" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Trống" Value="Trống" />
                        <asp:ListItem Text="Có khách" Value="Có khách" />
                        <asp:ListItem Text="Đặt trước" Value="Đặt trước" />
                    </asp:DropDownList>
                </div>

            </div>

            <div class="mt-4 d-flex flex-wrap gap-2">

                <asp:Button ID="btnThem" runat="server"
                    Text="Thêm bàn ăn"
                    CssClass="btn btn-orange px-4"
                    OnClick="btnThem_Click" />

                <asp:Button ID="btnCapNhat" runat="server"
                    Text="Cập nhật"
                    CssClass="btn btn-success px-4 fw-bold"
                    OnClick="btnCapNhat_Click"
                    Visible="false" />

                <asp:Button ID="btnLamMoi" runat="server"
                    Text="Làm mới"
                    CssClass="btn btn-secondary px-4"
                    OnClick="btnLamMoi_Click" />

            </div>
        </div>

        <!-- DANH SACH -->
        <div class="custom-card">

            <h5 class="card-title text-info">
                <i class="fa-solid fa-table-list me-2"></i>
                Danh Sách Bàn Ăn
            </h5>

            <div class="table-responsive">

                <asp:GridView ID="gvBanAn" runat="server"
                    CssClass="table table-bordered table-striped text-center align-middle"
                    AutoGenerateColumns="False"
                    DataKeyNames="maban"
                    EmptyDataText="Chưa có bàn ăn nào!"
                    OnRowCommand="gvBanAn_RowCommand">

                    <Columns>

                        <asp:BoundField DataField="maban"
                            HeaderText="Mã bàn" />

                        <asp:BoundField DataField="sohang"
                            HeaderText="Số hàng" />

                        <asp:BoundField DataField="socot"
                            HeaderText="Số cột" />

                        <asp:BoundField DataField="vitri"
                            HeaderText="Vị trí" />

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <span class='<%# LayClassTrangThai(Eval("trangthaiban").ToString()) %>'>
                                    <%# Eval("trangthaiban") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>

                                <asp:LinkButton ID="btnSua" runat="server"
                                    CommandName="Sua"
                                    CommandArgument='<%# Eval("maban") %>'
                                    CssClass="btn btn-warning btn-sm fw-bold me-1">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnXoa" runat="server"
                                    CommandName="Xoa"
                                    CommandArgument='<%# Eval("maban") %>'
                                    CssClass="btn btn-danger btn-sm fw-bold"
                                    OnClientClick="return confirm('Bạn có chắc muốn xóa bàn này không?');">
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
