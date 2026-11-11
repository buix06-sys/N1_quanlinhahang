using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                LoadDropdownNhanVien();
                LoadData();
            }
        }

        private void LoadDropdownNhanVien()
        {
            try
            {
                string query = "SELECT manhanvien, hoten FROM NHANVIEN";
                DataTable dt = db.ExecuteQuery(query);
                ddlNhanVien.DataSource = dt;
                ddlNhanVien.DataTextField = "hoten";
                ddlNhanVien.DataValueField = "manhanvien";
                ddlNhanVien.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private void LoadData()
        {
            try
            {
                string query = @"SELECT 
                                    D.madatban AS madatban, 
                                    D.ngaydatban AS ngaydatban, 
                                    D.giobatdau AS giobatdau, 
                                    D.gioketthuc AS gioketthuc, 
                                    D.trangthaidatban AS trangthaidatban, 
                                    D.manhanvien AS manhanvien, 
                                    D.maban AS maban,
                                    (SELECT hoten FROM NHANVIEN WHERE NHANVIEN.manhanvien = D.manhanvien) AS hotennhanvien,
                                    (SELECT TOP 1 K.hoten FROM DONHANG DH JOIN KHACHHANG K ON DH.makhachhang = K.makhachhang WHERE DH.madatban = D.madatban) AS hotenkhachhang
                                 FROM DATBAN D";

                DataTable dt = db.ExecuteQuery(query);
                gvDatBan.DataSource = dt;
                gvDatBan.DataBind();
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi tải dữ liệu lịch đặt bàn: " + ex.Message, "danger");
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string maDB = txtMaDatBan.Text.Trim();
            string tenKhach = txtTenKhachHang.Text.Trim();
            string ngayDat = txtNgayDat.Text.Trim();
            string gioBD = txtGioBatDau.Text.Trim();
            string gioKT = txtGioKetThuc.Text.Trim();
            string maBan = txtMaBan.Text.Trim();
            string maNV = ddlNhanVien.SelectedValue;
            string trangThai = ddlTrangThai.SelectedValue;

            if (string.IsNullOrEmpty(maDB) || string.IsNullOrEmpty(tenKhach) || string.IsNullOrEmpty(ngayDat) || string.IsNullOrEmpty(gioBD))
            {
                HienThiThongBao("Vui lòng nhập đầy đủ Mã đặt bàn, Tên người đặt, Ngày đặt và Giờ bắt đầu!", "danger");
                return;
            }

            try
            {
                string maKH = "KH_" + DateTime.Now.Ticks.ToString().Substring(10);
                string checkKH = $"SELECT makhachhang FROM KHACHHANG WHERE hoten = N'{tenKhach}'";
                DataTable dtKH = db.ExecuteQuery(checkKH);
                if (dtKH != null && dtKH.Rows.Count > 0)
                {
                    maKH = dtKH.Rows[0]["makhachhang"].ToString();
                }
                else
                {
                    string insertKH = $"INSERT INTO KHACHHANG (makhachhang, hoten, sodienthoai, diachi) VALUES ('{maKH}', N'{tenKhach}', '0900000000', N'Tại nhà hàng')";
                    db.ExecuteNonQuery(insertKH);
                }
                string queryDatBan = string.IsNullOrEmpty(gioKT)
                    ? $"INSERT INTO DATBAN (madatban, ngaydatban, giobatdau, gioketthuc, trangthaidatban, manhanvien, maban) VALUES ('{maDB}', '{ngayDat}', '{gioBD}', NULL, N'{trangThai}', '{maNV}', '{maBan}')"
                    : $"INSERT INTO DATBAN (madatban, ngaydatban, giobatdau, gioketthuc, trangthaidatban, manhanvien, maban) VALUES ('{maDB}', '{ngayDat}', '{gioBD}', '{gioKT}', N'{trangThai}', '{maNV}', '{maBan}')";

                db.ExecuteNonQuery(queryDatBan);

                string checkDH = $"SELECT COUNT(*) FROM DONHANG WHERE madatban = '{maDB}'";
                DataTable dtCheck = db.ExecuteQuery(checkDH);
                if (dtCheck != null && Convert.ToInt32(dtCheck.Rows[0][0]) == 0)
                {
                    string maDH = "DH" + maDB;
                    string queryDH = $"INSERT INTO DONHANG (madonhang, trangthaidonhang, manhanvien, makhachhang, madatban) VALUES ('{maDH}', N'Chờ xử lý', '{maNV}', '{maKH}', '{maDB}')";
                    db.ExecuteNonQuery(queryDH);
                }

                LoadData();
                XoaForm();
                HienThiThongBao("Thêm phiếu đặt bàn và ghi nhận tên người đặt thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi thêm: " + ex.Message, "danger");
            }
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string maDB = txtMaDatBan.Text.Trim();
            string tenKhach = txtTenKhachHang.Text.Trim();
            string ngayDat = txtNgayDat.Text.Trim();
            string gioBD = txtGioBatDau.Text.Trim();
            string gioKT = txtGioKetThuc.Text.Trim();
            string maBan = txtMaBan.Text.Trim();
            string maNV = ddlNhanVien.SelectedValue;
            string trangThai = ddlTrangThai.SelectedValue;

            if (string.IsNullOrEmpty(maDB))
            {
                HienThiThongBao("Vui lòng chọn phiếu đặt bàn cần sửa từ bảng danh sách!", "danger");
                return;
            }

            try
            {
                string query = string.IsNullOrEmpty(gioKT)
                    ? $"UPDATE DATBAN SET ngaydatban = '{ngayDat}', giobatdau = '{gioBD}', gioketthuc = NULL, maban = '{maBan}', manhanvien = '{maNV}', trangthaidatban = N'{trangThai}' WHERE madatban = '{maDB}'"
                    : $"UPDATE DATBAN SET ngaydatban = '{ngayDat}', giobatdau = '{gioBD}', gioketthuc = '{gioKT}', maban = '{maBan}', manhanvien = '{maNV}', trangthaidatban = N'{trangThai}' WHERE madatban = '{maDB}'";

                db.ExecuteNonQuery(query);

                string getKH = $"SELECT makhachhang FROM DONHANG WHERE madatban = '{maDB}'";
                DataTable dtDH = db.ExecuteQuery(getKH);
                if (dtDH != null && dtDH.Rows.Count > 0)
                {
                    string maKH = dtDH.Rows[0]["makhachhang"].ToString();
                    db.ExecuteNonQuery($"UPDATE KHACHHANG SET hoten = N'{tenKhach}' WHERE makhachhang = '{maKH}'");
                }

                LoadData();
                XoaForm();
                HienThiThongBao("Cập nhật thông tin đặt bàn thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi cập nhật: " + ex.Message, "danger");
            }
        }

        protected void btnXacNhanDatHang_Click(object sender, EventArgs e)
        {
            string maDB = txtMaDatBan.Text.Trim();
            if (string.IsNullOrEmpty(maDB))
            {
                HienThiThongBao("Vui lòng chọn phiếu đặt bàn cần xác nhận từ danh sách!", "danger");
                return;
            }

            try
            {
                db.ExecuteNonQuery($"UPDATE DATBAN SET trangthaidatban = N'Đã xác nhận' WHERE madatban = '{maDB}'");
                db.ExecuteNonQuery($"UPDATE DONHANG SET trangthaidonhang = N'Đang xử lý' WHERE madatban = '{maDB}'");

                LoadData();
                HienThiThongBao($"Đã xác nhận thành công cho mã đặt bàn: {maDB}!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi xác nhận đặt hàng: " + ex.Message, "danger");
            }
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            string maDB = txtMaDatBan.Text.Trim();

            if (string.IsNullOrEmpty(maDB))
            {
                HienThiThongBao("Vui lòng chọn phiếu đặt bàn cần xóa!", "danger");
                return;
            }

            try
            {
                db.ExecuteNonQuery($"DELETE FROM DONHANG WHERE madatban = '{maDB}'");
                db.ExecuteNonQuery($"DELETE FROM DATBAN WHERE madatban = '{maDB}'");
                LoadData();
                XoaForm();
                HienThiThongBao("Xóa phiếu đặt bàn thành công!", "success");
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi khi xóa: " + ex.Message, "danger");
            }
        }

        protected void btnDSNhanVien_Click(object sender, EventArgs e)
        {
            try
            {
                string query = @"SELECT 
                                    D.madatban, 
                                    D.ngaydatban, 
                                    D.giobatdau, 
                                    D.maban, 
                                    D.trangthaidatban,
                                    N.hoten AS hotennhanvien, 
                                    N.sodienthoai,
                                    (SELECT TOP 1 K.hoten FROM DONHANG DH JOIN KHACHHANG K ON DH.makhachhang = K.makhachhang WHERE DH.madatban = D.madatban) AS hotenkhachhang
                                 FROM DATBAN D 
                                 LEFT JOIN NHANVIEN N ON D.manhanvien = N.manhanvien";

                DataTable dt = db.ExecuteQuery(query);

                string noiDungHTML = "<div class='table-responsive'><table class='table table-dark table-striped table-bordered text-center align-middle'><thead><tr><th>Mã Đặt Bàn</th><th>Tên Người Đặt Hàng</th><th>Ngày Đặt</th><th>Giờ Đặt</th><th>Mã Bàn</th><th>Nhân Viên Phụ Trách</th><th>Trạng Thái</th></tr></thead><tbody>";

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        string tenKH = (dr["hotenkhachhang"] != DBNull.Value && dr["hotenkhachhang"] != null) ? dr["hotenkhachhang"].ToString() : "Khách lẻ";
                        string tenNV = (dr["hotennhanvien"] != DBNull.Value && dr["hotennhanvien"] != null) ? dr["hotennhanvien"].ToString() : "Chưa phân công";
                        string ngayDat = dr["ngaydatban"] != DBNull.Value ? Convert.ToDateTime(dr["ngaydatban"]).ToString("yyyy-MM-dd") : "";

                        noiDungHTML += "<tr>" +
                                            "<td class='fw-bold text-warning'>" + dr["madatban"] + "</td>" +
                                            "<td class='text-light fw-bold'>" + tenKH + "</td>" +
                                            "<td>" + ngayDat + "</td>" +
                                            "<td>" + dr["giobatdau"] + "</td>" +
                                            "<td>" + dr["maban"] + "</td>" +
                                            "<td class='text-info fw-bold'>" + tenNV + "</td>" +
                                            "<td><span class='badge bg-warning text-dark'>" + dr["trangthaidatban"] + "</span></td>" +
                                       "</tr>";
                    }
                }
                else
                {
                    noiDungHTML += "<tr><td colspan='7' class='text-muted'>Chưa có dữ liệu đặt bàn nào.</td></tr>";
                }
                noiDungHTML += "</tbody></table></div>";

                lblModalTitle.Text = "Tra Cứu Nhân Viên & Người Đặt Hàng";
                litModalContent.Text = noiDungHTML;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "PopNhanVienPhuTrach", "setTimeout(hienModalChung, 100);", true);
            }
            catch (Exception ex)
            {
                HienThiThongBao("Lỗi tra cứu: " + ex.Message, "danger");
            }
        }

        protected void gvDatBan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "XemNhanVien")
            {
                string maNV = e.CommandArgument.ToString();
                try
                {
                    DataTable dt = db.ExecuteQuery($"SELECT * FROM NHANVIEN WHERE manhanvien = '{maNV}'");
                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        litModalContent.Text = "<div class='text-start p-3'>" +
                                "<p><strong>Mã Nhân Viên:</strong> " + dr["manhanvien"] + "</p>" +
                                "<p><strong>Họ và Tên:</strong> <span class='text-warning fw-bold fs-5'>" + dr["hoten"] + "</span></p>" +
                                "<p><strong>Số Điện Thoại:</strong> " + dr["sodienthoai"] + "</p>" +
                                "<p><strong>Chức Vụ:</strong> " + dr["chucvu"] + "</p>" +
                                "<p><strong>Trạng Thái:</strong> <span class='badge bg-success'>" + dr["trangthailamviec"] + "</span></p>" +
                            "</div>";

                        lblModalTitle.Text = "Chi Tiết Nhân Viên Phụ Trách";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "PopRow", "setTimeout(hienModalChung, 100);", true);
                    }
                }
                catch (Exception ex)
                {
                    HienThiThongBao("Không thể tải thông tin nhân viên: " + ex.Message, "danger");
                }
            }
        }

        protected void gvDatBan_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvDatBan.SelectedRow;
            txtMaDatBan.Text = row.Cells[1].Text.Trim();
            txtTenKhachHang.Text = row.Cells[2].Text.Trim() == "&nbsp;" ? "" : row.Cells[2].Text.Trim();

            if (DateTime.TryParse(row.Cells[3].Text.Trim(), out DateTime dtNgay))
            {
                txtNgayDat.Text = dtNgay.ToString("yyyy-MM-dd");
            }
            else
            {
                txtNgayDat.Text = row.Cells[3].Text.Trim();
            }

            txtGioBatDau.Text = row.Cells[4].Text.Trim();
            txtMaBan.Text = row.Cells[5].Text.Trim();

            txtMaDatBan.ReadOnly = true;
            lblMessage.Visible = false;
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            XoaForm();
            lblMessage.Visible = false;
        }

        private void XoaForm()
        {
            txtMaDatBan.Text = "";
            txtMaDatBan.ReadOnly = false;
            txtTenKhachHang.Text = "";
            txtNgayDat.Text = "";
            txtGioBatDau.Text = "";
            txtGioKetThuc.Text = "";
            txtMaBan.Text = "";
            if (ddlTrangThai.Items.Count > 0) ddlTrangThai.SelectedIndex = 0;
            if (ddlNhanVien.Items.Count > 0) ddlNhanVien.SelectedIndex = 0;
        }

        private void HienThiThongBao(string msg, string type)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = "alert alert-" + type + " d-block py-2";
            lblMessage.Text = msg;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
