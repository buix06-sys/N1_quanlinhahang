using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyNhanVien : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TaiKhoan"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string taiKhoan = Session["TaiKhoan"]?.ToString() ?? "";
            if (!taiKhoan.Equals("TK001", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            try
            {
                string query = "SELECT manhanvien, hoten, sodienthoai, chucvu, trangthailamviec, matkhoan FROM NHANVIEN";
                DataTable dt = db.ExecuteQuery(query);
                gvNhanVien.DataSource = dt;
                gvNhanVien.DataBind();
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi tải danh sách nhân viên: " + ex.Message, "danger");
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maNV = txtMaNhanVien.Text.Trim();
            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSoDienThoai.Text.Trim();
            string chucVu = txtChucVu.Text.Trim();
            string matKhoan = txtMatKhoan.Text.Trim();
            string trangThai = ddlTrangThai.SelectedValue;

            if (string.IsNullOrEmpty(maNV) || string.IsNullOrEmpty(hoTen))
            {
                HienThiThongBao("Vui lòng nhập đầy đủ Mã nhân viên và Họ tên!", "danger");
                return;
            }

            try
            {
                // 1. Tự động kiểm tra & tạo tài khoản (Đã bổ sung đầy đủ cột tennguoidung để không bị lỗi NULL)
                if (!string.IsNullOrEmpty(matKhoan))
                {
                    string checkTK = $"SELECT COUNT(*) FROM TAIKHOAN WHERE matkhoan = '{matKhoan}'";
                    DataTable dtTK = db.ExecuteQuery(checkTK);
                    if (dtTK != null && Convert.ToInt32(dtTK.Rows[0][0]) == 0)
                    {
                        string insertTK = $"INSERT INTO TAIKHOAN (matkhoan, tennguoidung, matkhau, quyentruycap) VALUES ('{matKhoan}', N'{hoTen}', '123456', N'{chucVu}')";
                        db.ExecuteNonQuery(insertTK);
                    }
                }

                // 2. Thêm nhân viên trực tiếp trên web
                string query = string.IsNullOrEmpty(matKhoan)
                    ? $"INSERT INTO NHANVIEN (manhanvien, hoten, sodienthoai, chucvu, trangthailamviec, matkhoan) VALUES ('{maNV}', N'{hoTen}', '{sdt}', N'{chucVu}', N'{trangThai}', NULL)"
                    : $"INSERT INTO NHANVIEN (manhanvien, hoten, sodienthoai, chucvu, trangthailamviec, matkhoan) VALUES ('{maNV}', N'{hoTen}', '{sdt}', N'{chucVu}', N'{trangThai}', '{matKhoan}')";

                db.ExecuteNonQuery(query);

                LoadData();
                XoaForm();
                HienThiThongBao("Thêm nhân viên mới thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi thêm: " + ex.Message, "danger");
            }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string maNV = txtMaNhanVien.Text.Trim();
            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSoDienThoai.Text.Trim();
            string chucVu = txtChucVu.Text.Trim();
            string matKhoan = txtMatKhoan.Text.Trim();
            string trangThai = ddlTrangThai.SelectedValue;

            if (string.IsNullOrEmpty(maNV))
            {
                HienThiThongBao("Vui lòng chọn nhân viên cần sửa từ bảng danh sách bên dưới!", "danger");
                return;
            }

            try
            {
                if (!string.IsNullOrEmpty(matKhoan))
                {
                    string checkTK = $"SELECT COUNT(*) FROM TAIKHOAN WHERE matkhoan = '{matKhoan}'";
                    DataTable dtTK = db.ExecuteQuery(checkTK);
                    if (dtTK != null && Convert.ToInt32(dtTK.Rows[0][0]) == 0)
                    {
                        string insertTK = $"INSERT INTO TAIKHOAN (matkhoan, tennguoidung, matkhau, quyentruycap) VALUES ('{matKhoan}', N'{hoTen}', '123456', N'{chucVu}')";
                        db.ExecuteNonQuery(insertTK);
                    }
                }

                string query = string.IsNullOrEmpty(matKhoan)
                    ? $"UPDATE NHANVIEN SET hoten = N'{hoTen}', sodienthoai = '{sdt}', chucvu = N'{chucVu}', trangthailamviec = N'{trangThai}', matkhoan = NULL WHERE manhanvien = '{maNV}'"
                    : $"UPDATE NHANVIEN SET hoten = N'{hoTen}', sodienthoai = '{sdt}', chucvu = N'{chucVu}', trangthailamviec = N'{trangThai}', matkhoan = '{matKhoan}' WHERE manhanvien = '{maNV}'";

                db.ExecuteNonQuery(query);

                LoadData();
                XoaForm();
                HienThiThongBao("Cập nhật thông tin nhân viên thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi cập nhật: " + ex.Message, "danger");
            }
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            string maNV = txtMaNhanVien.Text.Trim();

            if (string.IsNullOrEmpty(maNV))
            {
                HienThiThongBao("Vui lòng chọn nhân viên cần xóa từ bảng danh sách!", "danger");
                return;
            }

            try
            {
                string query = $"DELETE FROM NHANVIEN WHERE manhanvien = '{maNV}'";
                db.ExecuteNonQuery(query);

                LoadData();
                XoaForm();
                HienThiThongBao("Xóa nhân viên thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi xóa: " + ex.Message, "danger");
            }
        }

        protected void gvNhanVien_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvNhanVien.SelectedRow;
            txtMaNhanVien.Text = row.Cells[1].Text.Trim();
            txtHoTen.Text = row.Cells[2].Text.Trim() == "&nbsp;" ? "" : row.Cells[2].Text.Trim();
            txtSoDienThoai.Text = row.Cells[3].Text.Trim() == "&nbsp;" ? "" : row.Cells[3].Text.Trim();
            txtChucVu.Text = row.Cells[4].Text.Trim() == "&nbsp;" ? "" : row.Cells[4].Text.Trim();
            txtMatKhoan.Text = row.Cells[5].Text.Trim() == "&nbsp;" ? "" : row.Cells[5].Text.Trim();

            string trangThai = row.Cells[6].Text.Trim();
            if (ddlTrangThai.Items.FindByValue(trangThai) != null)
            {
                ddlTrangThai.SelectedValue = trangThai;
            }

            txtMaNhanVien.ReadOnly = true;
            lblMessage.Visible = false;
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            XoaForm();
            lblMessage.Visible = false;
        }

        private void XoaForm()
        {
            txtMaNhanVien.Text = "";
            txtMaNhanVien.ReadOnly = false;
            txtHoTen.Text = "";
            txtSoDienThoai.Text = "";
            txtChucVu.Text = "";
            txtMatKhoan.Text = "";
            if (ddlTrangThai.Items.Count > 0) ddlTrangThai.SelectedIndex = 0;
        }

        private void HienThiThongBao(string msg, string type)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = "alert alert-" + type + " d-block py-2";
            lblMessage.Text = msg;
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
