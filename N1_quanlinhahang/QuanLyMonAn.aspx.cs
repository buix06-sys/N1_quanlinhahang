using System;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyMonAn : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        void LoadData()
        {
            gvMonAn.DataSource = db.LayDuLieu("SELECT mamonan, tenmonan, dongia, trangthaimonan, madanhmuc FROM MONAN");
            gvMonAn.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
        
            try
            {
                string mamon = txtMaMon.Text.Trim();
                string tenmon = txtTenMon.Text.Trim();
                string dongia = txtDonGia.Text.Trim();
                string madm = txtMaDM.Text.Trim();

                if (string.IsNullOrEmpty(mamon)) return;

                string sql = $"INSERT INTO MONAN (mamonan, tenmonan, dongia, trangthaimonan, madanhmuc) VALUES ('{mamon}', N'{tenmon}', {dongia}, N'Đang bán', '{madm}')";
                db.ThucThiNonQuery(sql);

                txtMaMon.Text = ""; txtTenMon.Text = ""; txtDonGia.Text = ""; txtMaDM.Text = "";
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm món: " + ex.Message + "');</script>");
            }
        }

        protected void gvMonAn_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMonAn.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvMonAn_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMonAn.EditIndex = -1;
            LoadData();
        }

        protected void gvMonAn_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string mamon = gvMonAn.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtTen = (TextBox)gvMonAn.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtGia = (TextBox)gvMonAn.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtTrangThai = (TextBox)gvMonAn.Rows[e.RowIndex].Cells[3].Controls[0];

                string sql = $"UPDATE MONAN SET tenmonan=N'{txtTen.Text.Trim()}', dongia={txtGia.Text.Trim()}, trangthaimonan=N'{txtTrangThai.Text.Trim()}' WHERE mamonan='{mamon}'";
                db.ThucThiNonQuery(sql);

                gvMonAn.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message + "');</script>");
            }
        }

        protected void gvMonAn_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string mamon = gvMonAn.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM MONAN WHERE mamonan='{mamon}'");
                LoadData();
            }
            catch
            {
                Response.Write("<script>alert('Không thể xóa vì vướng ràng buộc dữ liệu đơn hàng!');</script>");
            }
        }
    }
}
