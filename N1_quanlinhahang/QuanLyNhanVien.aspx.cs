using System;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyNhanVien : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        void LoadData()
        {
            gvNhanVien.DataSource = db.LayDuLieu("SELECT manhanvien, hoten, sodienthoai, chucvu, trangthailamviec FROM NHANVIEN");
            gvNhanVien.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string manv = txtMaNV.Text.Trim();
                string hoten = txtHoTen.Text.Trim();
                string sdt = txtSDT.Text.Trim();
                string chucvu = txtChucVu.Text.Trim();

                if (string.IsNullOrEmpty(manv)) return;

                string sql = $"INSERT INTO NHANVIEN (manhanvien, hoten, sodienthoai, chucvu, trangthailamviec) VALUES ('{manv}', N'{hoten}', '{sdt}', N'{chucvu}', N'Đang làm')";
                db.ThucThiNonQuery(sql);

                txtMaNV.Text = ""; txtHoTen.Text = ""; txtSDT.Text = ""; txtChucVu.Text = "";
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm nhân viên: " + ex.Message + "');</script>");
            }
        }

        protected void gvNhanVien_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvNhanVien.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvNhanVien_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvNhanVien.EditIndex = -1;
            LoadData();
        }

        protected void gvNhanVien_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string manv = gvNhanVien.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtHoTenEdit = (TextBox)gvNhanVien.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtSDTEdit = (TextBox)gvNhanVien.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtChucVuEdit = (TextBox)gvNhanVien.Rows[e.RowIndex].Cells[3].Controls[0];
                TextBox txtTrangThaiEdit = (TextBox)gvNhanVien.Rows[e.RowIndex].Cells[4].Controls[0];

                string sql = $"UPDATE NHANVIEN SET hoten=N'{txtHoTenEdit.Text.Trim()}', sodienthoai='{txtSDTEdit.Text.Trim()}', chucvu=N'{txtChucVuEdit.Text.Trim()}', trangthailamviec=N'{txtTrangThaiEdit.Text.Trim()}' WHERE manhanvien='{manv}'";
                db.ThucThiNonQuery(sql);

                gvNhanVien.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message + "');</script>");
            }
        }

        protected void gvNhanVien_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string manv = gvNhanVien.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM NHANVIEN WHERE manhanvien='{manv}'");
                LoadData();
            }
            catch
            {
                Response.Write("<script>alert('Không thể xóa nhân viên này vì đang vướng dữ liệu liên quan!');</script>");
            }
        }
    }
}