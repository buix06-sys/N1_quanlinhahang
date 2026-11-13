using System;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{﻿using System;
using System.Web.UI.WebControls;

namespace N1_quanlinhahang
{
    public partial class QuanLyKho : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        void LoadData()
        {
            gvKho.DataSource = db.LayDuLieu("SELECT masanpham, tennl, donvitinh, muctoithieunl FROM NGUYENLIEU");
            gvKho.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string masp = txtMaSP.Text.Trim();
                string tennl = txtTenNL.Text.Trim();
                string dvt = txtDVT.Text.Trim();
                string muctoithieu = txtMucToiTheu.Text.Trim();

                if (string.IsNullOrEmpty(masp)) return;

                string sql = $"INSERT INTO NGUYENLIEU (masanpham, tennl, donvitinh, muctoithieunl) VALUES ('{masp}', N'{tennl}', N'{dvt}', {muctoithieu})";
                db.ThucThiNonQuery(sql);

                txtMaSP.Text = ""; txtTenNL.Text = ""; txtDVT.Text = ""; txtMucToiTheu.Text = "";
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm nguyên liệu: " + ex.Message + "');</script>");
            }
        }

        protected void gvKho_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvKho.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvKho_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvKho.EditIndex = -1;
            LoadData();
        }

        protected void gvKho_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string masp = gvKho.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtTenEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtDVTEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtMucEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[3].Controls[0];

                string sql = $"UPDATE NGUYENLIEU SET tennl=N'{txtTenEdit.Text.Trim()}', donvitinh=N'{txtDVTEdit.Text.Trim()}', muctoithieunl={txtMucEdit.Text.Trim()} WHERE masanpham='{masp}'";
                db.ThucThiNonQuery(sql);

                gvKho.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message + "');</script>");
            }
        }

        protected void gvKho_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string masp = gvKho.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM NGUYENLIEU WHERE masanpham='{masp}'");
                LoadData();
            }
            catch
            {
                Response.Write("<script>alert('Không thể xóa vì nguyên liệu này đang được liên kết trong kho!');</script>");
            }
        }
    }
}
    public partial class QuanLyKho : System.Web.UI.Page
    {
        KetNoiCSDL db = new KetNoiCSDL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        void LoadData()
        {
            gvKho.DataSource = db.LayDuLieu("SELECT masanpham, tennl, donvitinh, muctoithieunl FROM NGUYENLIEU");
            gvKho.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string masp = txtMaSP.Text.Trim();
                string tennl = txtTenNL.Text.Trim();
                string dvt = txtDVT.Text.Trim();
                string muctoithieu = txtMucToiTheu.Text.Trim();

                if (string.IsNullOrEmpty(masp)) return;

                string sql = $"INSERT INTO NGUYENLIEU (masanpham, tennl, donvitinh, muctoithieunl) VALUES ('{masp}', N'{tennl}', N'{dvt}', {muctoithieu})";
                db.ThucThiNonQuery(sql);

                txtMaSP.Text = ""; txtTenNL.Text = ""; txtDVT.Text = ""; txtMucToiTheu.Text = "";
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi thêm nguyên liệu: " + ex.Message + "');</script>");
            }
        }

        protected void gvKho_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvKho.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvKho_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvKho.EditIndex = -1;
            LoadData();
        }

        protected void gvKho_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string masp = gvKho.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtTenEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtDVTEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtMucEdit = (TextBox)gvKho.Rows[e.RowIndex].Cells[3].Controls[0];

                string sql = $"UPDATE NGUYENLIEU SET tennl=N'{txtTenEdit.Text.Trim()}', donvitinh=N'{txtDVTEdit.Text.Trim()}', muctoithieunl={txtMucEdit.Text.Trim()} WHERE masanpham='{masp}'";
                db.ThucThiNonQuery(sql);

                gvKho.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi cập nhật: " + ex.Message + "');</script>");
            }
        }

        protected void gvKho_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string masp = gvKho.DataKeys[e.RowIndex].Value.ToString();
                db.ThucThiNonQuery($"DELETE FROM NGUYENLIEU WHERE masanpham='{masp}'");
                LoadData();
            }
            catch
            {
                Response.Write("<script>alert('Không thể xóa vì nguyên liệu này đang được liên kết trong kho!');</script>");
            }
        }
    }
}
