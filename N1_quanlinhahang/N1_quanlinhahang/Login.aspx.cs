using System;
using System.Data;
using System.Data.SqlClient;

namespace N1_quanlinhahang
{
    public partial class Login : System.Web.UI.Page
    {
        KetNoiCSDL conn = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                HienThiLoi("Vui lòng nhập đầy đủ mã tài khoản và mật khẩu!");
                return;
            }

            try
            {
                string query = "SELECT * FROM TAIKHOAN WHERE matkhoan = @matkhoan AND matkhau = @matkhau AND trangthaitaikhoan = N'Hoạt động'";

                using (SqlConnection sqlConn = conn.LayKetNoi())
                {
                    using (SqlCommand cmd = new SqlCommand(query, sqlConn))
                    {
                        cmd.Parameters.AddWithValue("@matkhoan", username);
                        cmd.Parameters.AddWithValue("@matkhau", password);

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                Session["TaiKhoan"] = dt.Rows[0]["matkhoan"].ToString();
                                Session["TenNguoiDung"] = dt.Rows[0]["tennguoidung"].ToString();
                                Session["QuyenTruyCap"] = dt.Rows[0]["quyentruycap"].ToString();

                                Response.Redirect("Dashboard.aspx", false);
                                Context.ApplicationInstance.CompleteRequest();
                            }
                            else
                            {
                                HienThiLoi("Mã tài khoản hoặc mật khẩu không chính xác, hoặc tài khoản đã bị khóa!");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                HienThiLoi("Lỗi kết nối cơ sở dữ liệu: " + ex.Message);
            }
        }

        private void HienThiLoi(string msg)
        {
            pnlError.Visible = true;
            lblError.Text = msg;
        }
    }
}