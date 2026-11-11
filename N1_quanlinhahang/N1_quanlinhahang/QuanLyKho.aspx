<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyKho.aspx.cs" Inherits="N1_quanlinhahang.QuanLyKho" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Kho - Nhà Hàng N1</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #181b20; color: #fff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        p, label, .form-label, .text-muted, h3, h5, th { color: #fff !important; }
        .sidebar { width: 260px; height: 100vh; position: fixed; top: 0; left: 0; background-color: #21252b; border-right: 1px solid #2c313a; padding-top: 20px; z-index: 100; overflow-y: auto; }
        .sidebar .brand { font-size: 1.1rem; font-weight: bold; color: #fff; padding: 0 20px 20px 20px; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #2c313a; }
        .sidebar .nav-link { color: #abb2bf; padding: 10px 20px; margin: 4px 12px; border-radius: 8px; display: flex; align-items: center; gap: 12px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #ff7b00; color: #fff; }
        .menu-header { font-size: 0.75rem; text-transform: uppercase; color: #6c757d; padding: 10px 20px 5px 20px; font-weight: bold; }
        .main-content { margin-left: 260px; padding: 20px 30px; }
        .custom-card { background-color: #21252b; border: 1px solid #2c313a; border-radius: 14px; padding: 25px; color: #fff; margin-bottom: 25px; }
        .form-control { background-color: #181b20 !important; border: 1px solid #2c313a !important; color: #fff !important; }
        .form-control:focus { background-color: #181b20 !important; color: #fff !important; border-color: #ff7b00 !important; box-shadow: none !important; }
        .table-dark-custom th { background-color: #1a1d23 !important; color: #ffc107 !important; border-color: #2c313a !important; }
        .table-dark-custom td { background-color: #21252b !important; color: #fff !important; border-color: #2c313a !important; vertical-align: middle; }
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
                <li class="nav-item"><a class="nav-link" href="QuanLyDonHang.aspx"><i class="fa-solid fa-receipt"></i> Đơn hàng & Thanh toán</a></li>
                <li class="nav-item"><a class="nav-link active" href="QuanLyKho.aspx"><i class="fa-solid fa-warehouse"></i> Quản lý kho</a></li>
            </ul>
        </div>
        <main class="main-content">
            <h3 class="fw-bold text-white mb-4"><i class="fa-solid fa-warehouse text-warning me-2"></i> Quản Lý Kho & Nguyên Liệu</h3>
            <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info d-block py-2"></asp:Label>
            
            <!-- Khu vực thao tác -->
            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-warning"><i class="fa-solid fa-pen-to-square me-2"></i> Thêm / Sửa / Xóa Nguyên Liệu</h5>
                <div class="row g-3">
                    <div class="col-md-3"><label class="form-label small fw-bold">Mã Sản Phẩm</label><asp:TextBox ID="txtMaNL" runat="server" CssClass="form-control" placeholder="VD: NL001"></asp:TextBox></div>
                    <div class="col-md-3"><label class="form-label small fw-bold">Tên Nguyên Liệu</label><asp:TextBox ID="txtTenNL" runat="server" CssClass="form-control" placeholder="Nhập tên..."></asp:TextBox></div>
                    <div class="col-md-3"><label class="form-label small fw-bold">Đơn Vị Tính</label><asp:TextBox ID="txtDonViTinh" runat="server" CssClass="form-control" placeholder="Kg, Lít..."></asp:TextBox></div>
                    <div class="col-md-3"><label class="form-label small fw-bold">Công Nghiệp / NCC</label><asp:TextBox ID="txtCongHiep" runat="server" CssClass="form-control" placeholder="Nhập NCC..."></asp:TextBox></div>
                    <div class="col-md-3"><label class="form-label small fw-bold">Mức Tối Thiểu</label><asp:TextBox ID="txtMucToiThieu" runat="server" CssClass="form-control" TextMode="Number" step="0.01" placeholder="Nhập mức tối thiểu..."></asp:TextBox></div>
                </div>
                <div class="mt-4 d-flex gap-2">
                    <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-warning fw-bold px-4 text-dark" OnClick="btnThem_Click" />
                    <asp:Button ID="btnSua" runat="server" Text="Sửa" CssClass="btn btn-primary px-4" OnClick="btnSua_Click" />
                    <asp:Button ID="btnXoa" runat="server" Text="Xóa" CssClass="btn btn-danger px-4" OnClick="btnXoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa nguyên liệu này?');" />
                    <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới" CssClass="btn btn-secondary px-4" OnClick="btnLamMoi_Click" />
                </div>
            </div>

            <!-- Biểu đồ Histogram -->
            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-chart-column me-2"></i> Biểu Đồ Phân Phối Tồn Kho (Histogram)</h5>
                <div style="position: relative; height: 300px; width: 100%;">
                    <canvas id="histogramKho"></canvas>
                </div>
            </div>

            <!-- Danh sách -->
            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-table-list me-2"></i> Danh Sách Kho <span class="small text-muted" style="font-size: 0.8rem;">(💡 Click chữ **Chọn** ở cột thao tác để đưa dữ liệu lên form sửa)</span></h5>
                <div class="table-responsive">
                    <asp:GridView ID="gvKho" runat="server" CssClass="table table-dark table-striped table-bordered table-dark-custom text-center" AutoGenerateColumns="False" OnRowCommand="gvKho_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="masanpham" HeaderText="Mã Sản Phẩm" />
                            <asp:BoundField DataField="tennl" HeaderText="Tên Nguyên Liệu" />
                            <asp:BoundField DataField="donvitinh" HeaderText="Đơn Vị Tính" />
                            <asp:BoundField DataField="conghiep" HeaderText="Công Nghiệp / NCC" />
                            <asp:BoundField DataField="muctoithieunl" HeaderText="Mức Tối Thiểu" DataFormatString="{0:N2}" />
                            <asp:TemplateField HeaderText="Thao Tác">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkChonSua" runat="server" CommandName="ChonSua" CommandArgument='<%# Eval("masanpham") %>' CssClass="text-info fw-bold text-decoration-underline">Chọn</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </main>
    </form>
    
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            new Chart(document.getElementById('histogramKho').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: <%= HtmlLabels %>,
                    datasets: [{
                        label: 'Mức tồn / tối thiểu (muctoithieunl)',
                        data: <%= HtmlValues %>,
                        backgroundColor: 'rgba(13, 202, 240, 0.75)',
                        borderColor: 'rgba(13, 202, 240, 1)',
                        borderWidth: 1,
                        borderRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: { beginAtZero: true, grid: { color: '#2c313a' }, ticks: { color: '#fff' } },
                        x: { grid: { display: false }, ticks: { color: '#fff' } }
                    },
                    plugins: { legend: { labels: { color: '#fff' } } }
                }
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
