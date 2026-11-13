<%@ Page Title="Quản Lý Bàn Ăn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuanLyBanAn.aspx.cs" Inherits="N1_quanlinhahang.QuanLyBanAn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="mb-4 font-weight-bold text-white"><i class="fas fa-chair text-warning mr-2"></i> Quản Lý Sơ Đồ Bàn Ăn</h3>

    <div class="card p-4 mb-4 shadow-sm">
        <h5 class="text-warning mb-3">Thêm Bàn Ăn Mới</h5>
        <div class="form-row">
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtMaBan" runat="server" CssClass="form-control" Placeholder="Mã Bàn (VD: B05)"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtSoHang" runat="server" CssClass="form-control" Placeholder="Số Hàng"></asp:TextBox>
            </div>
            <div class="col-md-2 mb-2">
                <asp:TextBox ID="txtSoCot" runat="server" CssClass="form-control" Placeholder="Số Cột"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:TextBox ID="txtViTri" runat="server" CssClass="form-control" Placeholder="Vị Trí (VD: Tầng 1)"></asp:TextBox>
            </div>
            <div class="col-md-3 mb-2">
                <asp:Button ID="btnThem" runat="server" Text="Thêm Mới" CssClass="btn btn-warning btn-block font-weight-bold" OnClick="btnThem_Click" />
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvBanAn" runat="server" CssClass="table table-bordered table-hover table-striped" 
                AutoGenerateColumns="False" DataKeyNames="maban"
                OnRowEditing="gvBanAn_RowEditing" 
                OnRowUpdating="gvBanAn_RowUpdating" 
                OnRowCancelingEdit="gvBanAn_RowCancelingEdit" 
                OnRowDeleting="gvBanAn_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="maban" HeaderText="Mã Bàn" ReadOnly="True" />
                    <asp:BoundField DataField="sohang" HeaderText="Số Hàng" />
                    <asp:BoundField DataField="socot" HeaderText="Số Cột" />
                    <asp:BoundField DataField="vitri" HeaderText="Vị Trí" />
                    <asp:BoundField DataField="trangthaiban" HeaderText="Trạng Thái" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="Sửa" DeleteText="Xóa" UpdateText="Lưu" CancelText="Hủy" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>