<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyDatBan.aspx.cs" Inherits="N1_quanlinhahang.QuanLyDatBan" ValidateRequest="false" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Đặt Bàn - Hệ Thống Nhà Hàng N1</title>
  
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
        
        .table-dark-custom { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; }
        .table-dark-custom th { background-color: #1a1d23 !important; color: #ffc107 !important; border-color: #2c313a !important; }
        .table-dark-custom td { background-color: #21252b !important; color: #ffffff !important; border-color: #2c313a !important; vertical-align: middle; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

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
                <li class="nav-item"><a class="nav-link" href="QuanLyNhanVien.aspx"><i class="fa-solid fa-id-badge"></i> Quản lý nhân viên</a></li>
                <li class="nav-item">
                    <a class="nav-link active" href="QuanLyDatBan.aspx"><i class="fa-solid fa-calendar-check"></i> Quản lý đặt bàn</a>
                </li>
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
            <asp:UpdatePanel ID="upTraCuuVaModal" runat="server">
                <ContentTemplate>
                    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
                        <h3 class="fw-bold text-white mb-0"><i class="fa-solid fa-calendar-check text-warning me-2"></i> Quản Lý Lịch Đặt Bàn & Tiếp Đón</h3>
                        
                        <div>
                            <asp:Button ID="btnDSNhanVien" runat="server" Text="👥 Tra Cứu Nhân Viên Tiếp Đón" CssClass="btn btn-sm btn-outline-info fw-bold px-3 py-2" OnClick="btnDSNhanVien_Click" />
                        </div>
                    </div>

                    <div class="modal fade" id="modalThongTinChung" data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-xl">
                            <div class="modal-content bg-dark text-light border border-secondary shadow-lg">
                                <div class="modal-header border-secondary bg-black">
                                    <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-circle-info me-2"></i> <asp:Label ID="lblModalTitle" runat="server" Text="Thông Tin Hệ Thống"></asp:Label></h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-4">
                                    <asp:Literal ID="litModalContent" runat="server"></asp:Literal>
                                </div>
                                <div class="modal-footer border-secondary bg-black">
                                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-info d-block py-2 mb-3"></asp:Label>

            <div class="custom-card mb-4">
                <h5 class="fw-bold mb-3 text-warning"><i class="fa-solid fa-pen-to-square me-2"></i> Xử Lý Phiếu Đặt Bàn & Tên Người Đặt</h5>
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Mã Đặt Bàn</label>
                        <asp:TextBox ID="txtMaDatBan" runat="server" CssClass="form-control" placeholder="VD: DB001"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Tên Người Đặt Hàng</label>
                        <asp:TextBox ID="txtTenKhachHang" runat="server" CssClass="form-control" placeholder="VD: Nguyễn Văn A"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Ngày Đặt Bàn (YYYY-MM-DD)</label>
                        <asp:TextBox ID="txtNgayDat" runat="server" CssClass="form-control" placeholder="VD: 2026-11-05"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Giờ Bắt Đầu</label>
                        <asp:TextBox ID="txtGioBatDau" runat="server" CssClass="form-control" placeholder="VD: 10:00:00"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Giờ Kết Thúc</label>
                        <asp:TextBox ID="txtGioKetThuc" runat="server" CssClass="form-control" placeholder="VD: 12:00:00"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Mã Bàn Ăn</label>
                        <asp:TextBox ID="txtMaBan" runat="server" CssClass="form-control" placeholder="VD: B01"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Nhân Viên Phụ Trách</label>
                        <asp:DropDownList ID="ddlNhanVien" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold">Trạng Thái Đặt Bàn</label>
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Đã xác nhận" Value="Đã xác nhận"></asp:ListItem>
                            <asp:ListItem Text="Chờ xác nhận" Value="Chờ xác nhận"></asp:ListItem>
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="mt-4 d-flex gap-2 flex-wrap">
                    <asp:Button ID="btnThem" runat="server" Text="Thêm Mới" CssClass="btn btn-warning fw-bold px-3 text-dark" OnClick="btnThem_Click" />
                    <asp:Button ID="btnSua" runat="server" Text="Cập Nhật (Sửa)" CssClass="btn btn-primary fw-bold px-3" OnClick="btnSua_Click" />
                    <asp:Button ID="btnXacNhanDatHang" runat="server" Text="✅ Xác Nhận Đặt Bàn" CssClass="btn btn-success fw-bold px-3" OnClick="btnXacNhanDatHang_Click" />
                    <asp:Button ID="btnXoa" runat="server" Text="Xóa Đặt Bàn" CssClass="btn btn-danger fw-bold px-3" OnClick="btnXoa_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa phiếu đặt bàn này không?');" />
                    <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới Form" CssClass="btn btn-secondary px-3" OnClick="btnLamMoi_Click" />
                </div>
            </div>

            <div class="custom-card">
                <h5 class="fw-bold mb-3 text-info"><i class="fa-solid fa-table-list me-2"></i> Danh Sách Lịch Đặt Bàn & Tên Người Đặt</h5>
                <div class="table-responsive">
                    <asp:GridView ID="gvDatBan" runat="server" CssClass="table table-dark table-striped table-bordered table-dark-custom align-middle text-center" AutoGenerateColumns="False" DataKeyNames="madatban" OnSelectedIndexChanged="gvDatBan_SelectedIndexChanged" OnRowCommand="gvDatBan_RowCommand">
                        <Columns>
                            <asp:ButtonField CommandName="Select" Text="Chọn" HeaderText="Thao tác" ControlStyle-CssClass="btn btn-sm btn-warning text-dark fw-bold px-3" />
                            <asp:BoundField DataField="madatban" HeaderText="Mã Đặt Bàn" />
                            <asp:BoundField DataField="hotenkhachhang" HeaderText="Tên Người Đặt Hàng" />
                            <asp:BoundField DataField="ngaydatban" HeaderText="Ngày Đặt" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="giobatdau" HeaderText="Giờ Bắt Đầu" />
                            <asp:BoundField DataField="maban" HeaderText="Mã Bàn" />
                            
                            <asp:TemplateField HeaderText="Nhân Viên Tiếp Đón">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkNV" runat="server" CommandName="XemNhanVien" CommandArgument='<%# Eval("manhanvien") %>' CssClass="text-warning fw-bold text-decoration-underline">
                                        <%# Eval("hotennhanvien") != DBNull.Value && Eval("hotennhanvien") != null ? Eval("hotennhanvien") : "Chưa phân công" %>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="trangthaidatban" HeaderText="Trạng Thái" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </main>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function hienModalChung() {
            var myModalElement = document.getElementById('modalThongTinChung');
            if (myModalElement) {
                var myModal = bootstrap.Modal.getOrCreateInstance(myModalElement, { backdrop: 'static', keyboard: false });
                myModal.show();
            }
        }
    </script>
</body>
</html>
