<%@ Page Title="Quản Lý Nhân Viên" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyNhanVien.aspx.cs" Inherits="N1_quanlinhahang.QuanLyNhanVien" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-users text-warning mr-2"></i> Quản Lý Nhân Sự & Nhân Viên</h3>

    <div class="card p-4 mb-4 shadow-sm">
        <h5 class="text-warning mb-3">Thêm Nhân Viên Mới</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaNV" runat="server" CssClass="form-control" Placeholder="Mã NV (NV004)"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" Placeholder="Họ và Tên"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" Placeholder="Số Điện Thoại"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtChucVu" runat="server" CssClass="form-control" Placeholder="Chức Vụ"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:Button ID="btnThem" runat="server" Text="Thêm Nhân Viên" CssClass="btn btn-warning btn-block font-weight-bold" OnClick="btnThem_Click" />
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvNhanVien" runat="server" CssClass="table table-bordered table-hover table-striped" 
                AutoGenerateColumns="False" DataKeyNames="manhanvien"
                OnRowEditing="gvNhanVien_RowEditing" 
                OnRowUpdating="gvNhanVien_RowUpdating" 
                OnRowCancelingEdit="gvNhanVien_RowCancelingEdit" 
                OnRowDeleting="gvNhanVien_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="manhanvien" HeaderText="Mã NV" ReadOnly="True" />
                    <asp:BoundField DataField="hoten" HeaderText="Họ và Tên" />
                    <asp:BoundField DataField="sodienthoai" HeaderText="Số Điện Thoại" />
                    <asp:BoundField DataField="chucvu" HeaderText="Chức Vụ" />
                    <asp:BoundField DataField="trangthailamviec" HeaderText="Trạng Thái" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="Sửa" DeleteText="Xóa" UpdateText="Lưu" CancelText="Hủy" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>