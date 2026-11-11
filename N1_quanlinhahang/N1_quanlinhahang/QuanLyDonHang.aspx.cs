using System;
using System.Data;
using System.Web.UI.WebControls;

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
                DataTable dt = db.ExecuteQuery("SELECT * FROM DONHANG");
                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi tải dữ liệu: " + ex.Message, "danger");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = "alert alert-" + type + " d-block py-2";
            lblMessage.Text = message;
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maDH = txtMaDH.Text.Trim();
            string maDatBan = txtMaDatBan.Text.Trim();
            string maNV = txtMaNhanVien.Text.Trim();
            string maKH = txtMaKhachHang.Text.Trim();
            string ghiChu = txtGhiChu.Text.Trim();

            if (string.IsNullOrEmpty(maDH) || string.IsNullOrEmpty(maDatBan) || string.IsNullOrEmpty(maNV) || string.IsNullOrEmpty(maKH))
            {
                ShowMessage("Vui lòng điền đầy đủ Mã đơn hàng, Mã đặt bàn, Mã nhân viên và Mã khách hàng!", "danger");
                return;
            }

            try
            {
                // 1. Kiểm tra trùng mã đơn hàng
                DataTable dtCheck = db.ExecuteQuery("SELECT COUNT(*) FROM DONHANG WHERE madonhang = '" + maDH + "'");
                if (dtCheck != null && dtCheck.Rows.Count > 0 && Convert.ToInt32(dtCheck.Rows[0][0]) > 0)
                {
                    ShowMessage("Mã đơn hàng [" + maDH + "] đã tồn tại! Vui lòng nhập mã mới.", "danger");
                    return;
                }

                // 2. Tự động thêm NHÂN VIÊN nếu chưa có trong CSDL
                DataTable dtNV = db.ExecuteQuery("SELECT COUNT(*) FROM NHANVIEN WHERE manhanvien = '" + maNV + "'");
                if (dtNV == null || dtNV.Rows.Count == 0 || Convert.ToInt32(dtNV.Rows[0][0]) == 0)
                {
                    db.ExecuteNonQuery("INSERT INTO NHANVIEN (manhanvien, hoten, sodienthoai, chucvu) VALUES ('" + maNV + "', N'Nhân viên " + maNV + "', '0000000000', N'Phục vụ')");
                }

                // 3. Tự động thêm KHÁCH HÀNG nếu chưa có trong CSDL
                DataTable dtKH = db.ExecuteQuery("SELECT COUNT(*) FROM KHACHHANG WHERE makhachhang = '" + maKH + "'");
                if (dtKH == null || dtKH.Rows.Count == 0 || Convert.ToInt32(dtKH.Rows[0][0]) == 0)
                {
                    db.ExecuteNonQuery("INSERT INTO KHACHHANG (makhachhang, hoten, sodienthoai) VALUES ('" + maKH + "', N'Khách " + maKH + "', '0000000000')");
                }

                // 4. Tự động thêm BÀN và ĐẶT BÀN nếu chưa có trong CSDL
                DataTable dtDB = db.ExecuteQuery("SELECT COUNT(*) FROM DATBAN WHERE madatban = '" + maDatBan + "'");
                if (dtDB == null || dtDB.Rows.Count == 0 || Convert.ToInt32(dtDB.Rows[0][0]) == 0)
                {
                    string maBanDefault = "B01";
                    DataTable dtBanAn = db.ExecuteQuery("SELECT COUNT(*) FROM BANAN WHERE maban = '" + maBanDefault + "'");
                    if (dtBanAn == null || dtBanAn.Rows.Count == 0 || Convert.ToInt32(dtBanAn.Rows[0][0]) == 0)
                    {
                        db.ExecuteNonQuery("INSERT INTO BANAN (maban, trangthaiban) VALUES ('" + maBanDefault + "', N'Đang dùng')");
                    }
                    db.ExecuteNonQuery("INSERT INTO DATBAN (madatban, ngaydatban, giobatdau, manhanvien, maban) VALUES ('" + maDatBan + "', GETDATE(), CAST(GETDATE() AS TIME), '" + maNV + "', '" + maBanDefault + "')");
                }

                // 5. Thêm mới đơn hàng
                string query = "INSERT INTO DONHANG (madonhang, manhanvien, makhachhang, madatban, ghichu, trangthaidonhang) VALUES ('" + maDH + "', '" + maNV + "', '" + maKH + "', '" + maDatBan + "', N'" + ghiChu + "', N'Chờ xử lý')";
                db.ExecuteNonQuery(query);

                LoadData();
                btnLamMoi_Click(sender, e);
                ShowMessage("Thêm đơn hàng và tự động cập nhật thông tin mới thành công!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi thêm: " + ex.Message, "danger");
            }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string maDH = txtMaDH.Text.Trim();
            string maDatBan = txtMaDatBan.Text.Trim();
            string maNV = txtMaNhanVien.Text.Trim();
            string maKH = txtMaKhachHang.Text.Trim();
            string ghiChu = txtGhiChu.Text.Trim();

            if (string.IsNullOrEmpty(maDH))
            {
                ShowMessage("Vui lòng chọn mã đơn hàng cần sửa!", "danger");
                return;
            }

            try
            {
                string query = "UPDATE DONHANG SET madatban = '" + maDatBan + "', manhanvien = '" + maNV + "', makhachhang = '" + maKH + "', ghichu = N'" + ghiChu + "' WHERE madonhang = '" + maDH + "'";
                db.ExecuteNonQuery(query);
                LoadData();
                ShowMessage("Cập nhật thông tin đơn hàng [" + maDH + "] thành công!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi sửa: " + ex.Message, "danger");
            }
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            string maDH = txtMaDH.Text.Trim();
            if (string.IsNullOrEmpty(maDH))
            {
                ShowMessage("Vui lòng nhập hoặc chọn mã đơn hàng cần xóa!", "danger");
                return;
            }

            try
            {
                try { db.ExecuteNonQuery("DELETE FROM CHITIETDONHANG WHERE madonhang = '" + maDH + "'"); } catch { }
                try { db.ExecuteNonQuery("DELETE FROM THANHTOAN WHERE madonhang = '" + maDH + "'"); } catch { }

                db.ExecuteNonQuery("DELETE FROM DONHANG WHERE madonhang = '" + maDH + "'");
                LoadData();
                btnLamMoi_Click(sender, e);
                ShowMessage("Đã xóa thành công đơn hàng [" + maDH + "].", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi xóa: " + ex.Message, "danger");
            }
        }

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string maDH = e.CommandArgument.ToString();

            if (e.CommandName == "XacNhanThanhToan")
            {
                try
                {
                    db.ExecuteNonQuery("UPDATE DONHANG SET trangthaidonhang = N'Đã thanh toán' WHERE madonhang = '" + maDH + "'");
                    LoadData();
                    ShowMessage("Đơn hàng [" + maDH + "] đã được XÁC NHẬN THANH TOÁN thành công!", "success");
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi xác nhận thanh toán: " + ex.Message, "danger");
                }
            }
            else if (e.CommandName == "ChonSua")
            {
                try
                {
                    DataTable dt = db.ExecuteQuery("SELECT * FROM DONHANG WHERE madonhang = '" + maDH + "'");
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        txtMaDH.Text = dt.Rows[0]["madonhang"].ToString();
                        txtMaDH.ReadOnly = true;
                        txtMaDatBan.Text = dt.Rows[0]["madatban"].ToString();
                        txtMaNhanVien.Text = dt.Rows[0]["manhanvien"].ToString();
                        txtMaKhachHang.Text = dt.Rows[0]["makhachhang"].ToString();
                        txtGhiChu.Text = dt.Rows[0]["ghichu"].ToString();
                        ShowMessage("Đã tải thông tin đơn hàng [" + maDH + "] lên form chỉnh sửa.", "info");
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi: " + ex.Message, "danger");
                }
            }
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            txtMaDH.Text = "";
            txtMaDH.ReadOnly = false;
            txtMaDatBan.Text = "";
            txtMaNhanVien.Text = "";
            txtMaKhachHang.Text = "";
            txtGhiChu.Text = "";
            lblMessage.Visible = false;
        }
    }
}
