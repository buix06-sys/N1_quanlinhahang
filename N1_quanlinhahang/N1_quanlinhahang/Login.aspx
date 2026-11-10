<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="N1_quanlinhahang.Login" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đăng Nhập - Quản Lý Nhà Hàng N1</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body { background-color: #181b20; color: #ffffff; height: 100vh; display: flex; align-items: center; justify-content: center; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .login-card { background-color: #21252b; border: 1px solid #2c313a; border-radius: 1rem; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.4); color: #ffffff; }
        .form-control { background-color: #181b20 !important; border: 1px solid #2c313a !important; color: #ffffff !important; }
        .form-control:focus { background-color: #181b20 !important; color: #ffffff !important; border-color: #ff7b00 !important; box-shadow: none !important; }
        .form-control::placeholder { color: #adb5bd !important; opacity: 1; }
        label, .form-label { color: #ffffff !important; }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card login-card p-4">
                    <div class="text-center mb-4">
                        <div class="mb-3 text-warning"><i class="fa-solid fa-utensils fa-3x"></i></div>
                        <h3 class="fw-bold text-white">NHÀ HÀNG N1</h3>
                        <p class="text-white-50 small">Đăng nhập hệ thống quản lý</p>
                    </div>

                    <asp:Panel ID="pnlError" runat="server" Visible="false" class="alert alert-danger py-2 small" role="alert">
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </asp:Panel>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small"> tài khoản </label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-light"><i class="fa-solid fa-user"></i></span>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập mã tài khoản..."></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-light"><i class="fa-solid fa-lock"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu..."></asp:TextBox>
                        </div>
                    </div>

                    <div class="d-grid">
                        <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP" CssClass="btn btn-warning py-2 fw-bold text-dark" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>