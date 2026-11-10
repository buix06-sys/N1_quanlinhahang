using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class QuanLyMonAn : System.Web.UI.Page
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
                string query = "SELECT * FROM MONAN";
                DataTable dt = db.ExecuteQuery(query);
                gvMonAn.DataSource = dt;
                gvMonAn.DataBind();
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
            string maMon = txtMaMon.Text.Trim();
            string tenMon = txtTenMon.Text.Trim();
            string donGia = txtDonGia.Text.Trim();

            if (string.IsNullOrEmpty(maMon) || string.IsNullOrEmpty(tenMon))
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Vui lòng nhập đầy đủ mã và tên món ăn!";
                return;
            }

            try
            {
                string query = $"INSERT INTO MONAN (mamonan, tenmonan, dongia) VALUES ('{maMon}', N'{tenMon}', '{donGia}')";
                db.ExecuteNonQuery(query);
                LoadData();

                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-success d-block py-2";
                lblMessage.Text = "Thêm món ăn thành công!";
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
            txtMaMon.Text = "";
            txtTenMon.Text = "";
            txtDonGia.Text = "";
            lblMessage.Visible = false;
        }
    }
}