using System;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyBanAn : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        
        void LoadData()
        {
            gvBanAn.DataSource = db.LayDuLieu("SELECT * FROM BANAN");
            gvBanAn.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
        
            try
            {
                string maban = txtMaBan.Text.Trim();
                string sohang = txtSoHang.Text.Trim();
                string socot = txtSoCot.Text.Trim();
                string vitri = txtViTri.Text.Trim();

                if (string.IsNullOrEmpty(maban)) return;

                string sql = $"INSERT INTO BANAN (maban, sohang, socot, vitri, trangthaiban) VALUES ('{maban}', {sohang}, {socot}, N'{vitri}', N'Trống')";
                db.ThucThiNonQuery(sql);

                txtMaBan.Text = ""; txtSoHang.Text = ""; txtSoCot.Text = ""; txtViTri.Text = "";
                LoadData();
            }
            
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm dữ liệu: " + ex.Message + "');</script>");
            }
        }

        protected void gvBanAn_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBanAn.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvBanAn_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBanAn.EditIndex = -1;
            LoadData();
        }

        protected void gvBanAn_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string maBan = gvBanAn.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtSoHangEdit = (TextBox)gvBanAn.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtSoCotEdit = (TextBox)gvBanAn.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtViTriEdit = (TextBox)gvBanAn.Rows[e.RowIndex].Cells[3].Controls[0];
                TextBox txtTrangThaiEdit = (TextBox)gvBanAn.Rows[e.RowIndex].Cells[4].Controls[0];

                string sql = $"UPDATE BANAN SET sohang={txtSoHangEdit.Text.Trim()}, socot={txtSoCotEdit.Text.Trim()}, vitri=N'{txtViTriEdit.Text.Trim()}', trangthaiban=N'{txtTrangThaiEdit.Text.Trim()}' WHERE maban='{maBan}'";
                db.ThucThiNonQuery(sql);

                gvBanAn.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message + "');</script>");
            }
        }

        protected void gvBanAn_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string maBan = gvBanAn.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM BANAN WHERE maban='{maBan}'");
                LoadData();
            }
            
            catch
            {
                Response.Write("<script>alert('Không thể xóa bàn này vì đang bị ràng buộc dữ liệu!');</script>");
            }
        }
    }
}
