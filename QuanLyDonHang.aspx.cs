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
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        void LoadData()
        {
            try
            {
                // Truy vấn kết hợp bảng DONHANG và DATBAN để lấy đúng cấu trúc CSDL của bạn
                string query = @"SELECT d.madonhang, d.ngaydonhang, d.trangthaidonhang, b.maban, d.makhachhang, d.manhanvien 
                                 FROM DONHANG d 
                                 LEFT JOIN DATBAN b ON d.madatban = b.madatban";

                DataTable dt = db.LayDuLieu(query);
                if (dt != null)
                {
                    gvDonHang.DataSource = dt;
                    gvDonHang.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi tải dữ liệu đơn hàng: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // Thêm mới đơn hàng nhanh
        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string madh = txtMaDH.Text.Trim();
                string makh = txtMaKH.Text.Trim();
                string maban = txtMaBan.Text.Trim();
                string manv = txtMaNV.Text.Trim();
                string madatban = txtMaDatBan.Text.Trim();

                if (string.IsNullOrEmpty(madh))
                {
                    Response.Write("<script>alert('Vui lòng nhập mã đơn hàng!');</script>");
                    return;
                }

                // Giá trị mặc định nếu bỏ trống khung
                if (string.IsNullOrEmpty(makh)) makh = "KH001";
                if (string.IsNullOrEmpty(manv)) manv = "NV002";
                if (string.IsNullOrEmpty(madatban)) madatban = "DB001";

                string sql = $"INSERT INTO DONHANG (madonhang, ngaydonhang, trangthaidonhang, ghichu, manhanvien, makhachhang, madatban) VALUES ('{madh}', GETDATE(), N'Chờ xử lý', NULL, '{manv}', '{makh}', '{madatban}')";

                db.ThucThiNonQuery(sql);
                LoadData();

                txtMaDH.Text = ""; txtMaKH.Text = ""; txtMaBan.Text = ""; txtMaNV.Text = ""; txtMaDatBan.Text = "";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm đơn hàng: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        protected void gvDonHang_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDonHang.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvDonHang_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDonHang.EditIndex = -1;
            LoadData();
        }

        // Cập nhật trạng thái / thông tin trực tiếp trên bảng
        protected void gvDonHang_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string madh = gvDonHang.DataKeys[e.RowIndex].Value.ToString();

                TextBox txtTrangThaiEdit = (TextBox)gvDonHang.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtKHEdit = (TextBox)gvDonHang.Rows[e.RowIndex].Cells[4].Controls[0];
                TextBox txtNVEdit = (TextBox)gvDonHang.Rows[e.RowIndex].Cells[5].Controls[0];

                string trangthai = txtTrangThaiEdit.Text.Trim();
                string makh = txtKHEdit.Text.Trim();
                string manv = txtNVEdit.Text.Trim();

                string sql = $"UPDATE DONHANG SET trangthaidonhang = N'{trangthai}', makhachhang = '{makh}', manhanvien = '{manv}' WHERE madonhang = '{madh}'";

                db.ThucThiNonQuery(sql);
                gvDonHang.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // Bấm nút "Thanh toán ngay" trực tiếp trên dòng
        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ThanhToanNhanh")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string madh = gvDonHang.DataKeys[rowIndex].Value.ToString();

                // Cập nhật trạng thái đơn hàng thành hoàn thành/đã thanh toán
                string sql = $"UPDATE DONHANG SET trangthaidonhang = N'Đã thanh toán' WHERE madonhang = '{madh}'";
                db.ThucThiNonQuery(sql);
                LoadData();
            }
        }

        protected void gvDonHang_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string madh = gvDonHang.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM DONHANG WHERE madonhang='{madh}'");
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Không thể xóa đơn hàng này vì vướng khóa ngoại chi tiết! Chi tiết: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}