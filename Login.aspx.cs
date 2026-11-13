using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class Login : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string maTK = txtUser.Text.Trim(); // Nhập vào: TK001, TK002 hoặc TK003
            string pass = txtPass.Text.Trim(); // Nhập vào: 123456

            // Truy vấn trực tiếp bằng mã tài khoản và mật khẩu (tránh lỗi font tiếng Việt)
            string sql = $"SELECT * FROM TAIKHOAN WHERE matkhoan = '{maTK}' AND matkhau = '{pass}'";
            DataTable dt = db.LayDuLieu(sql);

            if (dt.Rows.Count > 0)
            {
                // Đăng nhập thành công
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblErr.Text = "Mã tài khoản hoặc mật khẩu không chính xác!";
            }
        }
    }
}