using System;
using System.Data;
using System.Web.UI;

namespace N1_quanlinhahang
{
    public partial class Dashboard : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        // Biến công khai để file .aspx đọc trực tiếp vẽ biểu đồ tròn khớp tuyệt đối với bảng
        public int SoLuongDaBan = 0;
        public int SoLuongChuaBan = 0;

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
                string taiKhoan = Session["TaiKhoan"]?.ToString() ?? "";
                string tenNguoiDung = Session["TenNguoiDung"]?.ToString() ?? "Nhân viên";
                string quyenTruyCap = Session["QuyenTruyCap"]?.ToString() ?? "Phục vụ";

                lblUserName.Text = tenNguoiDung;
                lblModalUser.Text = tenNguoiDung + " (" + taiKhoan + ")";

                if (taiKhoan.Equals("TK001", StringComparison.OrdinalIgnoreCase))
                {
                    lblUserRole.Text = "Quản lý cấp cao";
                    lblCardRole.Text = "Toàn Quyền Quản Trị";
                    menuNhanVien.Visible = true;
                }
                else
                {
                    lblUserRole.Text = quyenTruyCap;
                    lblCardRole.Text = quyenTruyCap;
                    menuNhanVien.Visible = false;
                }

                LoadThongKeBieuDoVaChiTiet();
            }
        }

        private void LoadThongKeBieuDoVaChiTiet()
        {
            try
            {
                // 1. Tổng số món ăn
                DataTable dtMonAn = db.ExecuteQuery("SELECT COUNT(*) FROM MONAN");
                if (dtMonAn != null && dtMonAn.Rows.Count > 0)
                {
                    lblTongMonAn.Text = dtMonAn.Rows[0][0].ToString();
                }

                // 2. Tổng số đơn hàng
                DataTable dtDonHang = db.ExecuteQuery("SELECT COUNT(*) FROM DONHANG");
                if (dtDonHang != null && dtDonHang.Rows.Count > 0)
                {
                    lblTongDonHang.Text = dtDonHang.Rows[0][0].ToString();
                }

                // 3. Tổng doanh thu
                DataTable dtDoanhThu = db.ExecuteQuery("SELECT SUM(tongtien) FROM THANHTOAN WHERE trangthai = N'Hoàn thành' OR tinhtrang = N'Đã thanh toán'");
                if (dtDoanhThu != null && dtDoanhThu.Rows.Count > 0 && dtDoanhThu.Rows[0][0] != DBNull.Value)
                {
                    decimal doanhThu = Convert.ToDecimal(dtDoanhThu.Rows[0][0]);
                    lblTongDoanhThu.Text = doanhThu.ToString("N0") + " VNĐ";
                }
                else
                {
                    lblTongDoanhThu.Text = "0 VNĐ";
                }

                // 4. Lấy danh sách chi tiết tất cả món ăn kết hợp tổng số lượng đã bán từ CSDL
                string queryChiTiet = @"SELECT 
                                            M.mamonan, 
                                            M.tenmonan, 
                                            ISNULL(SUM(CT.soluong), 0) AS soluongban
                                         FROM MONAN M
                                         LEFT JOIN CHITIETDONHANG CT ON M.mamonan = CT.mamonan
                                         GROUP BY M.mamonan, M.tenmonan";

                DataTable dtChiTiet = db.ExecuteQuery(queryChiTiet);
                gvChiTietMonAn.DataSource = dtChiTiet;
                gvChiTietMonAn.DataBind();

                // 5. Tính tổng số lượng món đã bán và chưa bán khớp với biểu đồ tròn
                SoLuongDaBan = 0;
                SoLuongChuaBan = 0;

                if (dtChiTiet != null && dtChiTiet.Rows.Count > 0)
                {
                    foreach (DataRow row in dtChiTiet.Rows)
                    {
                        int slBan = Convert.ToInt32(row["soluongban"]);
                        if (slBan > 0)
                        {
                            SoLuongDaBan += slBan;
                        }
                        else
                        {
                            SoLuongChuaBan += 1; // Đếm số lượng đầu mục món ăn chưa từng bán được
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi thống kê chi tiết món ăn: " + ex.Message);
            }
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
