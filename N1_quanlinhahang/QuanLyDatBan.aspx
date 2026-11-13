<%@ Page Title="Quản Lý Đặt Bàn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyDatBan.aspx.cs" Inherits="N1_quanlinhahang.QuanLyDatBan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-calendar-alt text-warning mr-2"></i> Quản Lý Lịch Đặt Bàn</h3>

    <!-- Khung Nhập Liệu & Thêm / Sửa -->
    <div class="card p-4 mb-4 shadow-sm">
        <h5 class="text-warning mb-3">Thông Tin Lịch Đặt Bàn</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Mã Đặt Bàn</label>
                <asp:TextBox ID="txtMaDB" runat="server" CssClass="form-control" Placeholder="VD: DB003"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Ngày Đặt</label>
                <asp:TextBox ID="txtNgayDat" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Giờ Bắt Đầu</label>
                <asp:TextBox ID="txtGioBD" runat="server" CssClass="form-control" Placeholder="10:00:00"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Mã Nhân Viên</label>
                <asp:TextBox ID="txtMaNV" runat="server" CssClass="form-control" Placeholder="VD: NV002"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Mã Bàn</label>
                <asp:TextBox ID="txtMaBan" runat="server" CssClass="form-control" Placeholder="VD: B01"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <label class="small text-muted">Trạng Thái</label>
                <asp:TextBox ID="txtTrangThai" runat="server" CssClass="form-control" Text="Chờ xác nhận"></asp:TextBox>
            </div>
        </div>

        <div class="mt-3">
            <asp:Button ID="btnThem" runat="server" Text="Thêm Mới" CssClass="btn btn-warning font-weight-bold px-4 mr-2" OnClick="btnThem_Click" />
            <asp:Button ID="btnSua" runat="server" Text="Lưu Cập Nhật" CssClass="btn btn-primary font-weight-bold px-4 mr-2" OnClick="btnSua_Click" />
            <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới Form" CssClass="btn btn-secondary px-4" OnClick="btnLamMoi_Click" />
        </div>
    </div>

    <!-- Bảng Dữ Liệu -->
    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvDatBan" runat="server" CssClass="table table-bordered table-hover table-striped" 
                AutoGenerateColumns="False" DataKeyNames="madatban"
                OnSelectedIndexChanged="gvDatBan_SelectedIndexChanged"
                OnRowCommand="gvDatBan_RowCommand"
                OnRowDeleting="gvDatBan_RowDeleting">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="Chọn" ControlStyle-CssClass="btn btn-sm btn-warning" HeaderText="Thao tác" />
                    <asp:BoundField DataField="madatban" HeaderText="Mã Đặt Bàn" />
                    <asp:BoundField DataField="ngaydatban" HeaderText="Ngày Đặt" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="giobatdau" HeaderText="Giờ Bắt Đầu" />
                    <asp:BoundField DataField="trangthaidatban" HeaderText="Trạng Thái" />
                    <asp:BoundField DataField="manhanvien" HeaderText="Mã NV" />
                    <asp:BoundField DataField="maban" HeaderText="Mã Bàn" />
                    <asp:ButtonField ButtonType="Button" CommandName="XacNhanNhanh" Text="Đã xác nhận" ControlStyle-CssClass="btn btn-sm btn-success" HeaderText="Xác Nhận Nhanh" />
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Xóa" ControlStyle-CssClass="btn btn-sm btn-danger" HeaderText="Xóa" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>