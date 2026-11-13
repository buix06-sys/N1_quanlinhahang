<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="N1_quanlinhahang.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Đăng Nhập - Quản Lý Nhà Hàng N1</title>
    <!-- Bootstrap 4 CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        body {
            background-color: #12151e;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            width: 420px;
            background-color: #1e222d;
            border: 1px solid #2d3748;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            color: #fff;
            text-align: center;
        }
        .login-card .icon-box {
            font-size: 2.5rem;
            color: #fbbf24;
            margin-bottom: 15px;
        }
        .form-control {
            background-color: #12151e;
            border: 1px solid #2d3748;
            color: #fff;
            height: 45px;
        }
        .form-control:focus {
            background-color: #12151e;
            color: #fff;
            border-color: #fbbf24;
            box-shadow: none;
        }
        .input-group-text {
            background-color: #12151e;
            border: 1px solid #2d3748;
            color: #a0aec0;
        }
        .btn-login {
            background-color: #ffbf00;
            border: none;
            color: #12151e;
            font-weight: bold;
            height: 45px;
            transition: 0.2s;
        }
        .btn-login:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="w-100 d-flex justify-content-center">
        <div class="login-card">
            <div class="icon-box">
                <i class="fas fa-utensils"></i>
            </div>
            <h3 class="font-weight-bold mb-1">NHÀ HÀNG N1</h3>
            <p class="text-muted small mb-4">Đăng nhập hệ thống quản lý</p>

            <div class="form-group text-left">
                <label class="small text-muted">Tài khoản</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                    </div>
                    <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Nhập mã tài khoản..."></asp:TextBox>
                </div>
            </div>

            <div class="form-group text-left">
                <label class="small text-muted">Mật khẩu</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    </div>
                    <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập mật khẩu..."></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP" CssClass="btn btn-login btn-block font-weight-bold mt-4" OnClick="btnLogin_Click" />
            
            <asp:Label ID="lblErr" runat="server" CssClass="text-danger small mt-3 d-block" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>