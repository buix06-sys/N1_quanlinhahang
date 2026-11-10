using System;
using System.Web.UI;

namespace N1_quanlinhahang
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TaiKhoan"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                string taiKhoan = Session["TaiKhoan"]?.ToString() ?? "";
                string tenNguoiDung = Session["TenNguoiDung"]?.ToString() ?? "Nhân viên";
                string quyenTruyCap = Session["QuyenTruyCap"]?.ToString() ?? "Phục vụ";

                // Gán tên và thông tin tài khoản
                lblUserName.Text = tenNguoiDung;
                lblModalUser.Text = tenNguoiDung + " (" + taiKhoan + ")";

                // Phân quyền hiển thị theo chuẩn quản trị
                if (taiKhoan.Equals("TK001", StringComparison.OrdinalIgnoreCase))
                {
                    lblUserRole.Text = "Quản lý cấp cao";
                    lblCardRole.Text = "Toàn Quyền Quản Trị";
                    menuNhanVien.Visible = true; // Admin TK001 thấy menu Quản lý nhân viên
                }
                else
                {
                    lblUserRole.Text = quyenTruyCap;
                    lblCardRole.Text = quyenTruyCap;
                    menuNhanVien.Visible = false; // Các tài khoản phục vụ/thu ngân bị ẩn menu nhân viên
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}