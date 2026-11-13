using System;
using System.Data;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyDatBan : System.Web.UI.Page
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
                DataTable dt = db.LayDuLieu("SELECT madatban, ngaydatban, giobatdau, trangthaidatban, manhanvien, maban FROM DATBAN");
                gvDatBan.DataSource = dt;
                gvDatBan.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi tải dữ liệu: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // Thêm mới
        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string madb = txtMaDB.Text.Trim();
                string ngaydat = txtNgayDat.Text.Trim();
                string giobd = txtGioBD.Text.Trim();
                string manv = txtMaNV.Text.Trim();
                string maban = txtMaBan.Text.Trim();
                string trangthai = txtTrangThai.Text.Trim();

                if (string.IsNullOrEmpty(madb))
                {
                    Response.Write("<script>alert('Vui lòng nhập mã đặt bàn!');</script>");
                    return;
                }

                string sqlNgay = string.IsNullOrEmpty(ngaydat) ? "NULL" : $"'{ngaydat}'";
                string sqlGio = string.IsNullOrEmpty(giobd) ? "NULL" : $"'{giobd}'";

                string sql = $"INSERT INTO DATBAN (madatban, ngaydatban, giobatdau, trangthaidatban, manhanvien, maban) VALUES ('{madb}', {sqlNgay}, {sqlGio}, N'{trangthai}', '{manv}', '{maban}')";

                db.ThucThiNonQuery(sql);
                LoadData();
                ClearForm();
                Response.Write("<script>alert('Thêm lịch đặt bàn thành công!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm đặt bàn: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // Khi bấm nút "Chọn" trên dòng của bảng, đổ dữ liệu lên form phía trên để sửa
        protected void gvDatBan_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvDatBan.SelectedRow;
            txtMaDB.Text = row.Cells[1].Text.Trim();

            // Xử lý ngày tháng hiển thị an toàn vào ô input type="date"
            if (DateTime.TryParse(row.Cells[2].Text, out DateTime dtNgay))
            {
                txtNgayDat.Text = dtNgay.ToString("yyyy-MM-dd");
            }
            else
            {
                txtNgayDat.Text = "";
            }

            txtGioBD.Text = row.Cells[3].Text.Trim() == "&nbsp;" ? "" : row.Cells[3].Text.Trim();
            txtTrangThai.Text = row.Cells[4].Text.Trim();
            txtMaNV.Text = row.Cells[5].Text.Trim();
            txtMaBan.Text = row.Cells[6].Text.Trim();

            // Khóa mã đặt bàn không cho sửa khóa chính
            txtMaDB.ReadOnly = true;
        }

        // Nút Lưu Cập Nhật (Sửa)
        protected void btnSua_Click(object sender, EventArgs e)
        {
            try
            {
                string madb = txtMaDB.Text.Trim();
                string ngaydat = txtNgayDat.Text.Trim();
                string giobd = txtGioBD.Text.Trim();
                string manv = txtMaNV.Text.Trim();
                string maban = txtMaBan.Text.Trim();
                string trangthai = txtTrangThai.Text.Trim();

                if (string.IsNullOrEmpty(madb))
                {
                    Response.Write("<script>alert('Vui lòng chọn bản ghi cần sửa từ bảng!');</script>");
                    return;
                }

                string sqlNgay = string.IsNullOrEmpty(ngaydat) ? "NULL" : $"'{ngaydat}'";
                string sqlGio = string.IsNullOrEmpty(giobd) ? "NULL" : $"'{giobd}'";

                string sql = $"UPDATE DATBAN SET ngaydatban = {sqlNgay}, giobatdau = {sqlGio}, trangthaidatban = N'{trangthai}', manhanvien = '{manv}', maban = '{maban}' WHERE madatban = '{madb}'";

                db.ThucThiNonQuery(sql);
                LoadData();
                ClearForm();
                Response.Write("<script>alert('Cập nhật thành công!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật đặt bàn: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        // Xử lý nút bấm nhanh "Đã xác nhận" hoặc các command khác trên dòng
        protected void gvDatBan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "XacNhanNhanh")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string madb = gvDatBan.DataKeys[rowIndex].Value.ToString();

                string sql = $"UPDATE DATBAN SET trangthaidatban = N'Đã xác nhận' WHERE madatban = '{madb}'";
                db.ThucThiNonQuery(sql);
                LoadData();
            }
        }

        // Xóa dòng
        protected void gvDatBan_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string madb = gvDatBan.DataKeys[e.RowIndex].Value.ToString();
                string sql = $"DELETE FROM DATBAN WHERE madatban='{madb}'";

                db.ThucThiNonQuery(sql);
                LoadData();
                ClearForm();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Không thể xóa vì lịch đặt bàn này đang liên kết với đơn hàng! Chi tiết: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        void ClearForm()
        {
            txtMaDB.Text = "";
            txtMaDB.ReadOnly = false;
            txtNgayDat.Text = "";
            txtGioBD.Text = "";
            txtMaNV.Text = "";
            txtMaBan.Text = "";
            txtTrangThai.Text = "Chờ xác nhận";
            gvDatBan.SelectedIndex = -1;
        }
    }
}