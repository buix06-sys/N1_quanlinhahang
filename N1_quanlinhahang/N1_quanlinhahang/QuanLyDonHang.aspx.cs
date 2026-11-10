using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class QuanLyDonHang : System.Web.UI.Page
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
                string query = "SELECT * FROM DONHANG";
                DataTable dt = db.ExecuteQuery(query);
                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
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
            string maDH = txtMaDH.Text.Trim();
            string maBan = txtMaBan.Text.Trim();

            if (string.IsNullOrEmpty(maDH))
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Vui lòng nhập mã đơn hàng!";
                return;
            }

            try
            {
                string query = $"INSERT INTO DONHANG (madonhang, maban) VALUES ('{maDH}', '{maBan}')";
                db.ExecuteNonQuery(query);
                LoadData();

                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-success d-block py-2";
                lblMessage.Text = "Thêm đơn hàng thành công!";
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
            txtMaDH.Text = "";
            txtMaBan.Text = "";
            lblMessage.Visible = false;
        }
    }
}