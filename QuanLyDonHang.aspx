<%@ Page Title="Quản Lý Đơn Hàng & Hóa Đơn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="N1_quanlinhahang.QuanLyDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-file-invoice-dollar text-warning mr-2"></i> Quản Lý Đơn Hàng & Thanh Toán Hóa Đơn</h3>

    <!-- Khung Thêm Mới Đơn Hàng Nhanh -->
    <div class="card p-4 mb-4 shadow-sm border-warning" style="border-left: 5px solid #ffc107;">
        <h5 class="text-warning mb-3"><i class="fas fa-plus-circle mr-2"></i> Thêm Đơn Hàng Mới</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaDH" runat="server" CssClass="form-control" Placeholder="Mã ĐH (DH003)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaKH" runat="server" CssClass="form-control" Placeholder="Mã KH (KH001)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaBan" runat="server" CssClass="form-control" Placeholder="Mã Bàn (B01)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaNV" runat="server" CssClass="form-control" Placeholder="Mã NV (NV002)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaDatBan" runat="server" CssClass="form-control" Placeholder="Mã Đặt Bàn (DB001)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:Button ID="btnThem" runat="server" Text="Thêm Mới" CssClass="btn btn-warning btn-block font-weight-bold" OnClick="btnThem_Click" />
            </div>
        </div>
    </div>

    <!-- Bảng Danh Sách Đơn Hàng & Hóa Đơn -->
    <div class="card shadow-sm">
        <div class="card-header bg-dark border-secondary">
            <h5 class="text-info font-weight-bold mb-0"><i class="fas fa-list mr-2"></i> Danh Sách Đơn Hàng Trong Hệ Thống</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="gvDonHang" runat="server" CssClass="table table-bordered table-hover table-striped text-white" 
                    AutoGenerateColumns="False" DataKeyNames="madonhang"
                    OnRowEditing="gvDonHang_RowEditing"
                    OnRowUpdating="gvDonHang_RowUpdating"
                    OnRowCancelingEdit="gvDonHang_RowCancelingEdit"
                    OnRowCommand="gvDonHang_RowCommand"
                    OnRowDeleting="gvDonHang_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="madonhang" HeaderText="Mã Đơn Hàng" ReadOnly="True" />
                        <asp:BoundField DataField="ngaydonhang" HeaderText="Ngày Đơn Hàng" DataFormatString="{0:yyyy-MM-dd HH:mm}" ReadOnly="True" />
                        <asp:BoundField DataField="trangthaidonhang" HeaderText="Trạng Thái Đơn" />
                        <asp:BoundField DataField="maban" HeaderText="Mã Bàn" ReadOnly="True" />
                        <asp:BoundField DataField="makhachhang" HeaderText="Mã KH" />
                        <asp:BoundField DataField="manhanvien" HeaderText="Mã NV" />
                        <asp:ButtonField ButtonType="Button" CommandName="ThanhToanNhanh" Text="Thanh toán ngay" ControlStyle-CssClass="btn btn-sm btn-success" HeaderText="Thanh Toán Nhanh" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="Sửa" DeleteText="Xóa" UpdateText="Lưu" CancelText="Hủy" ControlStyle-CssClass="btn btn-sm btn-info mr-1" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>