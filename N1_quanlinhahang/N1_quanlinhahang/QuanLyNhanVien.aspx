using System;
using System.Data;
using System.Data.SqlClient;
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

            // BẢO MẬT TUYỆT ĐỐI: Chỉ duy nhất TK001 mới được truy cập trang này
            string taiKhoanHienTai = Session["TaiKhoan"]?.ToString() ?? "";
            if (!taiKhoanHienTai.Equals("TK001", StringComparison.OrdinalIgnoreCase))
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
                string query = "SELECT * FROM NHANVIEN";
                DataTable dt = db.ExecuteQuery(query);
                gvNhanVien.DataSource = dt;
                gvNhanVien.DataBind();
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi tải dữ liệu: " + ex.Message, "danger");
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maNV = txtMaNV.Text.Trim();
            string hoTen = txtHoTen.Text.Trim();
            string gioiTinh = ddlGioiTinh.SelectedValue;
            string sdt = txtSdt.Text.Trim();
            string chucVu = txtChucVu.Text.Trim();
            string maTK = txtMaTK.Text.Trim();

            if (string.IsNullOrEmpty(maNV) || string.IsNullOrEmpty(hoTen))
            {
                HienThiThongBao("Vui lòng nhập đầy đủ Mã Nhân Viên và Họ Tên!", "danger");
                return;
            }

            try
            {
                string query = $"INSERT INTO NHANVIEN (manhanvien, hoten, gioitinh, sodienthoai, chucvu, trangthailamviec, matkhoan) " +
                               $"VALUES ('{maNV}', N'{hoTen}', N'{gioiTinh}', '{sdt}', N'{chucVu}', N'Đang làm', '{maTK}')";

                db.ExecuteNonQuery(query);
                LoadData();
                XoaForm();
                HienThiThongBao("Thêm nhân viên thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi thêm: " + ex.Message, "danger");
            }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string maNV = txtMaNV.Text.Trim();
            string hoTen = txtHoTen.Text.Trim();
            string gioiTinh = ddlGioiTinh.SelectedValue;
            string sdt = txtSdt.Text.Trim();
            string chucVu = txtChucVu.Text.Trim();
            string maTK = txtMaTK.Text.Trim();

            if (string.IsNullOrEmpty(maNV))
            {
                HienThiThongBao("Vui lòng chọn nhân viên cần sửa từ bảng danh sách bên dưới!", "danger");
                return;
            }

            try
            {
                string query = $"UPDATE NHANVIEN SET hoten = N'{hoTen}', gioitinh = N'{gioiTinh}', " +
                               $"sodienthoai = '{sdt}', chucvu = N'{chucVu}', matkhoan = '{maTK}' " +
                               $"WHERE manhanvien = '{maNV}'";

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
            string maNV = txtMaNV.Text.Trim();

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
                HienThiThongBao("Lỗi khi xóa (nhân viên có thể đang phát sinh dữ liệu liên quan): " + ex.Message, "danger");
            }
        }

        protected void gvNhanVien_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvNhanVien.SelectedRow;
            txtMaNV.Text = row.Cells[1].Text.Trim();
            txtHoTen.Text = row.Cells[2].Text.Trim();
            ddlGioiTinh.SelectedValue = row.Cells[3].Text.Trim();
            txtSdt.Text = row.Cells[4].Text.Trim();
            txtChucVu.Text = row.Cells[5].Text.Trim();
            txtMaTK.Text = row.Cells[7].Text.Trim();

            // Khóa mã nhân viên khi sửa để tránh lỗi khóa chính
            txtMaNV.ReadOnly = true;
            lblMessage.Visible = false;
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            XoaForm();
            lblMessage.Visible = false;
        }

        private void XoaForm()
        {
            txtMaNV.Text = "";
            txtMaNV.ReadOnly = false;
            txtHoTen.Text = "";
            txtSdt.Text = "";
            txtChucVu.Text = "";
            txtMaTK.Text = "";
            if (ddlGioiTinh.Items.Count > 0) ddlGioiTinh.SelectedIndex = 0;
        }

        private void HienThiThongBao(string msg, string type)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = $"alert alert-{type} d-block py-2";
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
