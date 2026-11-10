<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="N1_quanlinhahang.QuanLyDonHang" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Đơn Hàng - Nhà Hàng N1</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body { background-color: #181b20; color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        p, label, .form-label, .text-muted, h3, h5, th { color: #ffffff !important; }
        .sidebar { width: 260px; height: 100vh; position: fixed; top: 0; left: 0; background-color: #21252b; border-right: 1px solid #2c313a; padding-top: 20px; z-index: 100; overflow-y: auto; }
        .sidebar .brand { font-size: 1.1rem; font-weight: bold; color: #fff; padding: 0 20px 20px 20px; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #2c313a; }
        .sidebar .nav-link { color: #abb2bf; padding: 10px 20px; margin: 4px 12px; border-radius: 8px; display: flex; align-items: center; gap: 12px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #ff7b00; color: #fff; }
        .menu-header { font-size: 0.75rem; text-transform: uppercase; color: #6c757d; padding: 10px 20px 5px 20px; font-weight: bold; }
        .main-content { margin-left: 260px; padding: 20px 30px; }
        .custom-card { background-color: #21252b; border: 1px solid #2c313a; border-radius: 14px; padding: 25px; color: #fff; }
        .form-control, .form-select { background-color: #181b20 !important; border: 1px solid #2c313a !important; color: #ffffff !important; }
        .form-control:focus, .form-select:focus { background-color: #181b20 !important; color: #ffffff !important; border-color: #ff7b00 !important; box-shadow: none !important; }
        .form-control::placeholder { color: #adb5bd !important; opacity: 1; }
        .table-dark-custom { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; }
        .table-dark-custom th { background-color: #1a1d23 !important; color: #ffc107 !important; border-color: #2c313a !important; }
        .table-dark-custom td { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; vertical-align: middle; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <div class="brand"><i class="fa-solid fa-utensils text-warning"></i><span>N1 - NHÀ HÀNG</span></div>
            <ul class="nav flex-column mt-2">
                <li class="menu-header">Tổng quan</li>
                <li class="nav-item"><a class="nav-link" href="Dashboard.aspx"><i class="fa-solid fa-chart-pie"></i> Bảng điều khiển</a></li>
                <li class="menu-header mt-2">Quản trị hệ thống</li>
                <li class="nav-item"><a class="nav-link" href="QuanLyDatBan.aspx"><i class="fa-solid fa-calendar-check"></i> Quản lý đặt bàn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyMonAn.aspx"><i class="fa-solid fa-burger"></i> Quản lý món ăn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyBanAn.aspx"><i class="fa-solid fa-chair"></i> Quản lý bàn ăn</a></li>
                <li class="nav-item"><a class="nav-link active" href="QuanLyDonHang.aspx"><i class="fa-solid fa-receipt"></i> Đơn hàng & Hóa đơn</a></li>
                <li class="nav-item"><a class="nav-link" href="QuanLyKho.aspx"><i class="fa-solid fa-warehouse"></i> Quản lý kho</a></li>
            </ul>
        </div>
        <main class="main-content">
            <h3 class="fw-bold text-white mb-4"><i class="fa-solid fa-receipt text-warning me-2"></i> Quản Lý Đơn Hàng & Hóa Đơn</h3>
            <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info d-block py-2"></asp:Label>
            
            <div class="custom-card mb-4">
                <h5 class="fw-bold mb-3 text-warning"><i class="fa-solid fa-plus-circle me-2"></i> Thêm / Cập Nhật Đơn Hàng</h5>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Mã Đơn Hàng</label>
                        <asp:TextBox ID="txtMaDH" runat="server" CssClass="form-control" placeholder="VD: DH001"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Mã Bàn</label>
                        <asp:TextBox ID="txtMaBan" runat="server" CssClass="form-control" placeholder="Nhập mã bàn..."></asp:TextBox>
                    </div>
                </div>
                <div class="mt-4 d-flex gap-2">
                    <asp:Button ID="btnThem" runat="server" Text="Thêm Đơn Hàng" CssClass="btn btn-warning fw-bold px-4 text-dark" OnClick="btnThem_Click" />
                    <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới" CssClass="btn btn-secondary px-4" OnClick="btnLamMoi_Click" />
                </div>
            </div>

            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-table-list me-2"></i> Danh Sách Đơn Hàng</h5>
                <div class="table-responsive">
                    <asp:GridView ID="gvDonHang" runat="server" CssClass="table table-dark table-striped table-bordered table-dark-custom text-center" AutoGenerateColumns="true">
                    </asp:GridView>
                </div>
            </div>
        </main>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>