using System;
using System.Data;

namespace N1_quanlinhahang
{
    public partial class Dashboard : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadThongKe();
            }
        }

        void LoadThongKe()
        {
            try
            {
                // 1. Lấy danh sách món ăn hiển thị vào bảng chi tiết
                DataTable dtMon = db.LayDuLieu("SELECT mamonan, tenmonan, 2 AS soluongban, trangthaimonan FROM MONAN");
                gvThongKeMon.DataSource = dtMon;
                gvThongKeMon.DataBind();

                // 2. Đếm tổng số đầu mục món ăn
                DataTable dtTongMon = db.LayDuLieu("SELECT COUNT(*) FROM MONAN");
                if (dtTongMon.Rows.Count > 0)
                {
                    lblTongMon.Text = dtTongMon.Rows[0][0].ToString();
                }

                // 3. Đếm tổng số đơn hàng
                DataTable dtTongDon = db.LayDuLieu("SELECT COUNT(*) FROM DONHANG");
                if (dtTongDon.Rows.Count > 0)
                {
                    lblTongDonHang.Text = dtTongDon.Rows[0][0].ToString();
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu cơ sở dữ liệu chưa sẵn sàng bảng
                Response.Write("<script>alert('Lỗi tải dữ liệu bảng điều khiển: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}