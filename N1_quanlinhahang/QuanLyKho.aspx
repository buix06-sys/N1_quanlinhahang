<%@ Page Title="Quản Lý Kho" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyKho.aspx.cs" Inherits="N1_quanlinhahang.QuanLyKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-boxes text-warning mr-2"></i> Quản Lý Kho Nguyên Liệu</h3>

    <!-- Khung Thêm Mới -->
    <div class="card p-4 mb-4 shadow-sm">
        <h5 class="text-warning mb-3">Thêm Nguyên Liệu Mới</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaSP" runat="server" CssClass="form-control" Placeholder="Mã SP (NL005)"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:TextBox ID="txtTenNL" runat="server" CssClass="form-control" Placeholder="Tên Nguyên Liệu"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtDVT" runat="server" CssClass="form-control" Placeholder="Đơn Vị Tính (Kg)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMucToiTheu" runat="server" CssClass="form-control" Placeholder="Mức Tối Thiểu"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:Button ID="btnThem" runat="server" Text="Thêm Nguyên Liệu" CssClass="btn btn-warning btn-block font-weight-bold" OnClick="btnThem_Click" />
            </div>
        </div>
    </div>

    <!-- Bảng Dữ Liệu Trực Tiếp Thêm - Sửa - Xóa -->
    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvKho" runat="server" CssClass="table table-bordered table-hover table-striped" 
                AutoGenerateColumns="False" DataKeyNames="masanpham"
                OnRowEditing="gvKho_RowEditing" 
                OnRowUpdating="gvKho_RowUpdating" 
                OnRowCancelingEdit="gvKho_RowCancelingEdit" 
                OnRowDeleting="gvKho_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="masanpham" HeaderText="Mã SP" ReadOnly="True" />
                    <asp:BoundField DataField="tennl" HeaderText="Tên Nguyên Liệu" />
                    <asp:BoundField DataField="donvitinh" HeaderText="Đơn Vị Tính" />
                    <asp:BoundField DataField="muctoithieunl" HeaderText="Mức Tối Thiểu" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="Sửa" DeleteText="Xóa" UpdateText="Lưu" CancelText="Hủy" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
