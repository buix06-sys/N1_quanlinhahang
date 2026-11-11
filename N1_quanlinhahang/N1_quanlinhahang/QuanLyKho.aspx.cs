using System;
using System.Data;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyKho : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();
        protected string HtmlLabels = "[]";
        protected string HtmlValues = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TaiKhoan"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!IsPostBack) LoadData();
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = db.ExecuteQuery("SELECT * FROM NGUYENLIEU");
                gvKho.DataSource = dt;
                gvKho.DataBind();
                GenerateChartData(dt);
            }
            catch (Exception ex) { ShowMessage("Lỗi tải dữ liệu: " + ex.Message, "danger"); }
        }

        private void GenerateChartData(DataTable dt)
        {
            if (dt == null || dt.Rows.Count == 0) return;
            System.Text.StringBuilder labels = new System.Text.StringBuilder("[");
            System.Text.StringBuilder values = new System.Text.StringBuilder("[");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string tenNL = dt.Rows[i]["tennl"]?.ToString() ?? "SP " + (i + 1);
                decimal.TryParse(dt.Rows[i]["muctoithieunl"]?.ToString(), out decimal val);

                labels.Append("'" + tenNL.Replace("'", "\\'") + "'");
                values.Append(val.ToString(System.Globalization.CultureInfo.InvariantCulture));
                if (i < dt.Rows.Count - 1) { labels.Append(","); values.Append(","); }
            }
            HtmlLabels = labels.Append("]").ToString();
            HtmlValues = values.Append("]").ToString();
        }

        private void ShowMessage(string msg, string type)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = "alert alert-" + type + " d-block py-2";
            lblMessage.Text = msg;
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maNL = txtMaNL.Text.Trim();
            string tenNL = txtTenNL.Text.Trim();
            string donVi = txtDonViTinh.Text.Trim();
            string congHiep = txtCongHiep.Text.Trim();
            string mucToiThieu = string.IsNullOrEmpty(txtMucToiThieu.Text) ? "0" : txtMucToiThieu.Text.Trim();

            if (string.IsNullOrEmpty(maNL) || string.IsNullOrEmpty(tenNL) || string.IsNullOrEmpty(donVi))
            {
                ShowMessage("Vui lòng điền đầy đủ Mã sản phẩm, Tên nguyên liệu và Đơn vị tính!", "danger");
                return;
            }

            try
            {
                // Kiểm tra trùng mã sản phẩm
                DataTable dtCheck = db.ExecuteQuery("SELECT COUNT(*) FROM NGUYENLIEU WHERE masanpham = '" + maNL + "'");
                if (dtCheck != null && dtCheck.Rows.Count > 0 && Convert.ToInt32(dtCheck.Rows[0][0]) > 0)
                {
                    ShowMessage("Mã sản phẩm [" + maNL + "] đã tồn tại trong kho!", "danger");
                    return;
                }

                string query = string.Format("INSERT INTO NGUYENLIEU (masanpham, tennl, donvitinh, conghiep, muctoithieunl) VALUES ('{0}', N'{1}', N'{2}', N'{3}', {4})",
                    maNL, tenNL, donVi, congHiep, mucToiThieu);
                db.ExecuteNonQuery(query);

                LoadData();
                btnLamMoi_Click(null, null);
                ShowMessage("Thêm nguyên liệu mới thành công!", "success");
            }
            catch (Exception ex) { ShowMessage("Lỗi thêm: " + ex.Message, "danger"); }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string maNL = txtMaNL.Text.Trim();
            if (string.IsNullOrEmpty(maNL))
            {
                ShowMessage("Vui lòng chọn nguyên liệu cần sửa!", "danger");
                return;
            }

            try
            {
                string tenNL = txtTenNL.Text.Trim();
                string donVi = txtDonViTinh.Text.Trim();
                string congHiep = txtCongHiep.Text.Trim();
                string mucToiThieu = string.IsNullOrEmpty(txtMucToiThieu.Text) ? "0" : txtMucToiThieu.Text.Trim();

                string query = string.Format("UPDATE NGUYENLIEU SET tennl = N'{0}', donvitinh = N'{1}', conghiep = N'{2}', muctoithieunl = {3} WHERE masanpham = '{4}'",
                    tenNL, donVi, congHiep, mucToiThieu, maNL);
                db.ExecuteNonQuery(query);

                LoadData();
                ShowMessage("Cập nhật thông tin nguyên liệu [" + maNL + "] thành công!", "success");
            }
            catch (Exception ex) { ShowMessage("Lỗi sửa: " + ex.Message, "danger"); }
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            string maNL = txtMaNL.Text.Trim();
            if (string.IsNullOrEmpty(maNL))
            {
                ShowMessage("Vui lòng chọn nguyên liệu cần xóa!", "danger");
                return;
            }

            try
            {
                // Xử lý an toàn khóa ngoại trước khi xóa
                try { db.ExecuteNonQuery("DELETE FROM CHITIETPHEUKHO WHERE masanpham = '" + maNL + "'"); } catch { }
                try { db.ExecuteNonQuery("UPDATE MONAN SET masanpham = NULL WHERE masanpham = '" + maNL + "'"); } catch { }

                db.ExecuteNonQuery("DELETE FROM NGUYENLIEU WHERE masanpham = '" + maNL + "'");
                LoadData();
                btnLamMoi_Click(null, null);
                ShowMessage("Đã xóa thành công nguyên liệu [" + maNL + "].", "success");
            }
            catch (Exception ex) { ShowMessage("Lỗi xóa: " + ex.Message, "danger"); }
        }

        protected void gvKho_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ChonSua")
            {
                string maNL = e.CommandArgument.ToString();
                try
                {
                    DataTable dt = db.ExecuteQuery("SELECT * FROM NGUYENLIEU WHERE masanpham = '" + maNL + "'");
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        txtMaNL.Text = dt.Rows[0]["masanpham"].ToString();
                        txtMaNL.ReadOnly = true; // Khóa mã sản phẩm không cho sửa khi đang chọn sửa
                        txtTenNL.Text = dt.Rows[0]["tennl"].ToString();
                        txtDonViTinh.Text = dt.Rows[0]["donvitinh"].ToString();
                        txtCongHiep.Text = dt.Rows[0]["conghiep"]?.ToString() ?? "";
                        txtMucToiThieu.Text = dt.Rows[0]["muctoithieunl"].ToString();
                        ShowMessage("Đã tải thông tin nguyên liệu [" + maNL + "] lên form.", "info");
                    }
                }
                catch (Exception ex) { ShowMessage("Lỗi chọn sửa: " + ex.Message, "danger"); }
            }
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            txtMaNL.Text = "";
            txtMaNL.ReadOnly = false;
            txtTenNL.Text = "";
            txtDonViTinh.Text = "";
            txtCongHiep.Text = "";
            txtMucToiThieu.Text = "";
            lblMessage.Visible = false;
        }
    }
}
