
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyMonAn : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        // Mã món đang sửa
        private string MaMonDangSua
        {
            get { return ViewState["MaMonDangSua"] as string; }
            set { ViewState["MaMonDangSua"] = value; }
        }

        // =========================
        // PAGE LOAD
        // =========================
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
                LoadDanhMuc();
                LoadData();
                LamMoiForm();
            }
        }

        // =========================
        // LOAD DANH MỤC
        // =========================
        private void LoadDanhMuc()
        {
            try
            {
                string sql = @"
                    SELECT madanhmuc, tendanhmuc
                    FROM DANHMUC
                    ORDER BY madanhmuc";

                DataTable dt = db.ExecuteQuery(sql);

                ddlDanhMuc.DataSource = dt;
                ddlDanhMuc.DataTextField = "tendanhmuc";
                ddlDanhMuc.DataValueField = "madanhmuc";
                ddlDanhMuc.DataBind();

                ddlDanhMuc.Items.Insert(
                    0,
                    new ListItem("-- Chọn danh mục --", "")
                );
            }
            catch (Exception ex)
            {
                ThongBao("Lỗi tải danh mục: " + ex.Message, false);
            }
        }

        // =========================
        // LOAD DANH SÁCH MÓN ĂN
        // =========================
        private void LoadData()
        {
            try
            {
                string sql = @"
                    SELECT mamonan,
                           tenmonan,
                           hinhanh,
                           dongia,
                           trangthaimonan,
                           madanhmuc,
                           masanpham
                    FROM dbo.MONAN
                    ORDER BY mamonan";

                DataTable dt = db.ExecuteQuery(sql);

                gvMonAn.DataSource = dt;
                gvMonAn.DataBind();
            }
            catch (Exception ex)
            {
                ThongBao("Lỗi tải danh sách món ăn: " + ex.Message, false);
            }
        }

        // =========================
        // THÔNG BÁO
        // =========================
        private void ThongBao(string noiDung, bool thanhCong)
        {
            lblMessage.Visible = true;

            lblMessage.CssClass = thanhCong
                ? "alert alert-success d-block mb-4"
                : "alert alert-danger d-block mb-4";

            lblMessage.Text = noiDung;
        }

        // =========================
        // XỬ LÝ CHUỖI SQL
        // =========================
        private string SqlSafe(string value)
        {
            return (value ?? "").Replace("'", "''");
        }

        // =========================
        // KIỂM TRA FORM
        // =========================
        private bool KiemTraForm()
        {
            decimal donGia;

            if (string.IsNullOrWhiteSpace(txtMaMon.Text))
            {
                ThongBao("Vui lòng nhập mã món ăn!", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtTenMon.Text))
            {
                ThongBao("Vui lòng nhập tên món ăn!", false);
                return false;
            }

            if (!decimal.TryParse(txtDonGia.Text, out donGia) || donGia < 0)
            {
                ThongBao("Đơn giá phải là số hợp lệ và không âm!", false);
                return false;
            }

            if (ddlDanhMuc.SelectedIndex <= 0 ||
                string.IsNullOrWhiteSpace(ddlDanhMuc.SelectedValue))
            {
                ThongBao("Vui lòng chọn danh mục món ăn!", false);
                return false;
            }

            if (ddlTrangThai.SelectedValue == "")
            {
                ThongBao("Vui lòng chọn trạng thái món ăn!", false);
                return false;
            }

            return true;
        }

        // =========================
        // KIỂM TRA MÃ MÓN
        // =========================
        private bool KiemTraMaMon(string maMon)
        {
            string sql = @"
                SELECT COUNT(*)
                FROM dbo.MONAN
                WHERE mamonan = N'" + SqlSafe(maMon) + "'";

            DataTable dt = db.ExecuteQuery(sql);

            return Convert.ToInt32(dt.Rows[0][0]) > 0;
        }

        // =========================
        // THÊM MÓN ĂN
        // =========================
        protected void btnThem_Click(object sender, EventArgs e)
        {
            if (!KiemTraForm())
                return;

            string maMon = txtMaMon.Text.Trim();

            if (KiemTraMaMon(maMon))
            {
                ThongBao("Mã món ăn đã tồn tại!", false);
                return;
            }

            try
            {
                string tenMon = txtTenMon.Text.Trim();
                decimal donGia = Convert.ToDecimal(txtDonGia.Text);

                string hinhAnh = txtHinhAnh.Text.Trim();
                string trangThai = ddlTrangThai.SelectedValue;
                string maDanhMuc = ddlDanhMuc.SelectedValue;
                string maSanPham = txtMaSanPham.Text.Trim();

                // Mã sản phẩm không nhập thì lưu NULL
                string sqlMaSanPham = string.IsNullOrWhiteSpace(maSanPham)
                    ? "NULL"
                    : "N'" + SqlSafe(maSanPham) + "'";

                string sql = @"
                    INSERT INTO dbo.MONAN
                    (
                        mamonan,
                        tenmonan,
                        hinhanh,
                        dongia,
                        trangthaimonan,
                        madanhmuc,
                        masanpham
                    )
                    VALUES
                    (
                        N'" + SqlSafe(maMon) + @"',
                        N'" + SqlSafe(tenMon) + @"',
                        N'" + SqlSafe(hinhAnh) + @"',
                        " + donGia.ToString(System.Globalization.CultureInfo.InvariantCulture) + @",
                        N'" + SqlSafe(trangThai) + @"',
                        N'" + SqlSafe(maDanhMuc) + @"',
                        " + sqlMaSanPham + ")";

                db.ExecuteNonQuery(sql);

                LoadData();
                LamMoiForm();

                ThongBao("Thêm món ăn thành công!", true);
            }
            catch (Exception ex)
            {
                ThongBao("Lỗi thêm món ăn: " + ex.Message, false);
            }
        }

        // =========================
        // GRIDVIEW SỬA / XÓA
        // =========================
        protected void gvMonAn_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            string maMon = Convert.ToString(e.CommandArgument);

            if (e.CommandName == "Sua")
            {
                HienThiMonCanSua(maMon);
            }
            else if (e.CommandName == "Xoa")
            {
                XoaMon(maMon);
            }
        }

        // =========================
        // HIỂN THỊ MÓN CẦN SỬA
        // =========================
        private void HienThiMonCanSua(string maMon)
        {
            try
            {
                string sql = @"
                    SELECT mamonan,
                           tenmonan,
                           hinhanh,
                           dongia,
                           trangthaimonan,
                           madanhmuc,
                           masanpham
                    FROM dbo.MONAN
                    WHERE mamonan = N'" + SqlSafe(maMon) + "'";

                DataTable dt = db.ExecuteQuery(sql);

                if (dt.Rows.Count == 0)
                {
                    ThongBao("Không tìm thấy món ăn!", false);
                    return;
                }

                DataRow row = dt.Rows[0];

                txtMaMon.Text = row["mamonan"].ToString();
                txtTenMon.Text = row["tenmonan"].ToString();
                txtDonGia.Text = row["dongia"].ToString();
                txtHinhAnh.Text = row["hinhanh"].ToString();
                txtMaSanPham.Text = row["masanpham"].ToString();

                string maDanhMuc = row["madanhmuc"].ToString();

                if (ddlDanhMuc.Items.FindByValue(maDanhMuc) != null)
                {
                    ddlDanhMuc.SelectedValue = maDanhMuc;
                }

                string trangThai = row["trangthaimonan"].ToString();

                if (ddlTrangThai.Items.FindByValue(trangThai) != null)
                {
                    ddlTrangThai.SelectedValue = trangThai;
                }

                MaMonDangSua = maMon;

                txtMaMon.Enabled = false;
                btnThem.Visible = false;
                btnCapNhat.Visible = true;

                ThongBao("Đang chỉnh sửa món ăn " + maMon, true);
            }
            catch (Exception ex)
            {
                ThongBao("Lỗi lấy thông tin món ăn: " + ex.Message, false);
            }
        }

        // =========================
        // CẬP NHẬT MÓN ĂN
        // =========================
        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            if (!KiemTraForm())
                return;

            if (string.IsNullOrEmpty(MaMonDangSua))
            {
                ThongBao("Vui lòng chọn món ăn cần sửa!", false);
                return;
            }

            try
            {
                string tenMon = txtTenMon.Text.Trim();
                decimal donGia = Convert.ToDecimal(txtDonGia.Text);
                string hinhAnh = txtHinhAnh.Text.Trim();
                string trangThai = ddlTrangThai.SelectedValue;
                string maDanhMuc = ddlDanhMuc.SelectedValue;
                string maSanPham = txtMaSanPham.Text.Trim();

                string sqlMaSanPham = string.IsNullOrWhiteSpace(maSanPham)
                    ? "NULL"
                    : "N'" + SqlSafe(maSanPham) + "'";

                string sql = @"
                    UPDATE dbo.MONAN
                    SET tenmonan = N'" + SqlSafe(tenMon) + @"',
                        hinhanh = N'" + SqlSafe(hinhAnh) + @"',
                        dongia = " + donGia.ToString(System.Globalization.CultureInfo.InvariantCulture) + @",
                        trangthaimonan = N'" + SqlSafe(trangThai) + @"',
                        madanhmuc = N'" + SqlSafe(maDanhMuc) + @"',
                        masanpham = " + sqlMaSanPham + @"
                    WHERE mamonan = N'" + SqlSafe(MaMonDangSua) + "'";

                db.ExecuteNonQuery(sql);

                LoadData();
                LamMoiForm();

                ThongBao("Cập nhật món ăn thành công!", true);
            }
            catch (Exception ex)
            {
                ThongBao("Lỗi cập nhật món ăn: " + ex.Message, false);
            }
        }

        // =========================
        // XÓA MÓN ĂN
        // =========================
        private void XoaMon(string maMon)
        {
            try
            {
                string sql = @"
                    DELETE FROM dbo.MONAN
                    WHERE mamonan = N'" + SqlSafe(maMon) + "'";

                db.ExecuteNonQuery(sql);

                LoadData();
                LamMoiForm();

                ThongBao("Xóa món ăn " + maMon + " thành công!", true);
            }
            catch (Exception ex)
            {
                ThongBao(
                    "Không thể xóa món ăn. Món ăn có thể đang được sử dụng. "
                    + ex.Message, false);
            }
        }

        // =========================
        // LÀM MỚI FORM
        // =========================
        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            LamMoiForm();
        }

        private void LamMoiForm()
        {
            txtMaMon.Text = "";
            txtTenMon.Text = "";
            txtDonGia.Text = "";
            txtHinhAnh.Text = "";
            txtMaSanPham.Text = "";

            if (ddlDanhMuc.Items.Count > 0)
                ddlDanhMuc.SelectedIndex = 0;

            if (ddlTrangThai.Items.FindByValue("Đang bán") != null)
                ddlTrangThai.SelectedValue = "Đang bán";

            txtMaMon.Enabled = true;

            btnThem.Visible = true;
            btnCapNhat.Visible = false;

            MaMonDangSua = null;
        }
    }
}
