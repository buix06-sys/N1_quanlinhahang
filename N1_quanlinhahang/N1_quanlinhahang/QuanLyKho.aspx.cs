using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class QuanLyKho : System.Web.UI.Page
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
                string query = "SELECT * FROM NGUYENLIEU";
                DataTable dt = db.ExecuteQuery(query);
                gvKho.DataSource = dt;
                gvKho.DataBind();
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
            string maNL = txtMaNL.Text.Trim();
            string tenNL = txtTenNL.Text.Trim();

            if (string.IsNullOrEmpty(maNL))
            {
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block py-2";
                lblMessage.Text = "Vui lòng nhập mã nguyên liệu!";
                return;
            }

            try
            {
                string query = $"INSERT INTO NGUYENLIEU (manguyenlieu, tennguyenlieu) VALUES ('{maNL}', N'{tenNL}')";
                db.ExecuteNonQuery(query);
                LoadData();

                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-success d-block py-2";
                lblMessage.Text = "Thêm nguyên liệu thành công!";
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
            txtMaNL.Text = "";
            txtTenNL.Text = "";
            lblMessage.Visible = false;
        }
    }
}