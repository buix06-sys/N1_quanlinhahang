using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class QuanLyDatBan : System.Web.UI.Page
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
                string query = "SELECT * FROM DATBAN";
                DataTable dt = db.ExecuteQuery(query);
                gvDatBan.DataSource = dt;
                gvDatBan.DataBind();
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
            string maDB = txtMaDatBan.Text.Trim();
            string maKH = txtMaKH.Text.Trim();
            string maBan = txtMaBan.Text.Trim();

            if (string.IsNullOrEmpty(maDB))
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Vui lòng nhập mã đặt bàn!";
                return;
            }

            try
            {
                string query = $"INSERT INTO DATBAN (madatban, makhachhang, maban) VALUES ('{maDB}', '{maKH}', '{maBan}')";
                db.ExecuteNonQuery(query);
                LoadData();

                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-success d-block py-2";
                lblMessage.Text = "Thêm đặt bàn thành công!";
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
            txtMaDatBan.Text = "";
            txtMaKH.Text = "";
            txtMaBan.Text = "";
            lblMessage.Visible = false;
        }
    }
}