<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="N1_quanlinhahang.Login" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Đăng Nhập - Hệ Thống Quản Lý Nhà Hàng N1</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        body { background-color: #12161f; color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card { background-color: #1e222d; border: 1px solid #2d3748; }
        .form-control { background-color: #12161f; border: 1px solid #2d3748; color: #fff; }
        .form-control:focus { background-color: #12161f; border-color: #ffc107; color: #fff; box-shadow: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container d-flex align-items-center justify-content-center min-vh-100">
            <div class="col-md-4">
                <div class="card p-4 shadow-lg rounded">
                    <div class="text-center mb-4">
                        <i class="fas fa-utensils fa-3x text-warning mb-2"></i>
                        <h4 class="font-weight-bold text-white">NHÀ HÀNG N1</h4>
                        <span class="text-muted small">Đăng nhập hệ thống quản lý</span>
                    </div>
                    
                    <div class="form-group">
                        <label class="small text-muted font-weight-bold"><i class="fas fa-user mr-1"></i> Tài khoản</label>
                        <asp:TextBox ID="txtTaiKhoan" runat="server" CssClass="form-control" Placeholder=""></asp:TextBox>
                    </div>
                    
                    <div class="form-group mb-4">
                        <label class="small text-muted font-weight-bold"><i class="fas fa-lock mr-1"></i> Mật khẩu</label>
                        <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Nhập mật khẩu"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnDangNhap" runat="server" Text="Đăng Nhập" CssClass="btn btn-warning btn-block font-weight-bold py-2" OnClick="btnDangNhap_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
