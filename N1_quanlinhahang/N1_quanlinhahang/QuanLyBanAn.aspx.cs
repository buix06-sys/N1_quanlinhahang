using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class QuanLyBanAn : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            try
            {
                string query = "SELECT * FROM BANAN";
                DataTable dt = db.ExecuteQuery(query);
                gvBanAn.DataSource = dt;
                gvBanAn.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Lỗi tải dữ liệu: " + ex.Message;
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maBan = txtMaBan.Text.Trim();
            string tenBan = txtTenBan.Text.Trim();

            if (string.IsNullOrEmpty(maBan))
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Vui lòng nhập mã bàn ăn!";
                return;
            }

            try
            {
                string query = $"INSERT INTO BANAN (maban, tenban) VALUES ('{maBan}', N'{tenBan}')";
                db.ExecuteNonQuery(query);
                LoadData();

                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-success d-block py-2";
                lblMessage.Text = "Thêm bàn ăn thành công!";
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            txtMaBan.Text = "";
            txtTenBan.Text = "";
            lblMessage.Visible = false;
        }
    }
}