using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class Login : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            try
            {
                string tk = txtTaiKhoan.Text.Trim();
                string mk = txtMatKhau.Text.Trim();

                if (string.IsNullOrEmpty(tk) || string.IsNullOrEmpty(mk))
                {
                    Response.Write("<script>alert('Vui lòng nhập đầy đủ tài khoản và mật khẩu!');</script>");
                    return;
                }

                // Kiểm tra dựa trên dữ liệu bảng TAIKHOAN trong CSDL QL_NhaHang_Moi
                string query = $"SELECT * FROM TAIKHOAN WHERE (matkhoan = '{tk}' OR tennguoidung = N'{tk}') AND matkhau = '{mk}'";
                DataTable dt = db.LayDuLieu(query);

                if (dt != null && dt.Rows.Count > 0)
                {
                    Session["TaiKhoan"] = dt.Rows[0]["matkhoan"].ToString();
                    Session["TenNguoiDung"] = dt.Rows[0]["tennguoidung"].ToString();
                    Session["QuyenTruyCap"] = dt.Rows[0]["quyentruycap"].ToString();

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Tài khoản hoặc mật khẩu không chính xác!');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi đăng nhập: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}
