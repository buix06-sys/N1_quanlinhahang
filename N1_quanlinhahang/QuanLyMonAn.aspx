<%@ Page Title="Quản Lý Món Ăn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyMonAn.aspx.cs" Inherits="N1_quanlinhahang.QuanLyMonAn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-hamburger text-warning mr-2"></i> Quản Lý Thực Đơn Món Ăn</h3>

    
<div class="card p-4 mb-4 shadow-sm">
        <h5 class="text-warning mb-3">Thêm Món Ăn Mới</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaMon" runat="server" CssClass="form-control" Placeholder="Mã Món (MA007)"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:TextBox ID="txtTenMon" runat="server" CssClass="form-control" Placeholder="Tên Món Ăn"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtDonGia" runat="server" CssClass="form-control" Placeholder="Đơn Giá"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaDM" runat="server" CssClass="form-control" Placeholder="Mã Danh Mục (DM01)"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:Button ID="btnThem" runat="server" Text="Thêm Món" CssClass="btn btn-warning btn-block font-weight-bold" OnClick="btnThem_Click" />
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvMonAn" runat="server" CssClass="table table-bordered table-hover table-striped" 
                AutoGenerateColumns="False" DataKeyNames="mamonan"
                OnRowEditing="gvMonAn_RowEditing" 
                OnRowUpdating="gvMonAn_RowUpdating" 
                OnRowCancelingEdit="gvMonAn_RowCancelingEdit" 
                OnRowDeleting="gvMonAn_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="mamonan" HeaderText="Mã Món" ReadOnly="True" />
                    <asp:BoundField DataField="tenmonan" HeaderText="Tên Món Ăn" />
                    <asp:BoundField DataField="dongia" HeaderText="Đơn Giá" />
                    <asp:BoundField DataField="trangthaimonan" HeaderText="Trạng Thái" />
                    <asp:BoundField DataField="madanhmuc" HeaderText="Mã Danh Mục" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="Sửa" DeleteText="Xóa" UpdateText="Lưu" CancelText="Hủy" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
