USE master;
GO

-- Xóa CSDL cũ nếu có
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'QL_NhaHang_Moi')
BEGIN
    ALTER DATABASE QL_NhaHang_Moi SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QL_NhaHang_Moi;
END
GO

-- Tạo CSDL mới
CREATE DATABASE QL_NhaHang_Moi;
GO

USE QL_NhaHang_Moi;
GO

-- =============================================
-- TẠO BẢNG
-- =============================================

CREATE TABLE TAIKHOAN (
    matkhoan VARCHAR(20) PRIMARY KEY,
    tennguoidung NVARCHAR(50) NOT NULL UNIQUE,
    matkhau VARCHAR(255) NOT NULL,
    quyentruycap NVARCHAR(20) NOT NULL,
    trangthaitaikhoan NVARCHAR(20) DEFAULT N'Hoạt động',
    ngaytao DATE DEFAULT CAST(GETDATE() AS DATE)
);
GO

CREATE TABLE NGUYENLIEU (
    masanpham VARCHAR(20) PRIMARY KEY,
    tennl NVARCHAR(100) NOT NULL,
    donvitinh NVARCHAR(20) NOT NULL,
    conghiep NVARCHAR(100),
    muctoithieunl DECIMAL(10,2) DEFAULT 0
);
GO

CREATE TABLE NHANVIEN (
    manhanvien VARCHAR(20) PRIMARY KEY,
    hoten NVARCHAR(100) NOT NULL,
    gioitinh NVARCHAR(10),
    ngaysinh DATE,
    sodienthoai VARCHAR(15) NOT NULL,
    diachi NVARCHAR(255),
    chucvu NVARCHAR(30) NOT NULL,
    trangthailamviec NVARCHAR(20) DEFAULT N'Đang làm',
    matkhoan VARCHAR(20) UNIQUE,
    FOREIGN KEY (matkhoan) REFERENCES TAIKHOAN(matkhoan)
);
GO

CREATE TABLE BANAN (
    maban VARCHAR(20) PRIMARY KEY,
    sohang INT,
    socot INT,
    vitri NVARCHAR(50),
    trangthaiban NVARCHAR(20) DEFAULT N'Trống'
);
GO

CREATE TABLE KHACHHANG (
    makhachhang VARCHAR(20) PRIMARY KEY,
    hoten NVARCHAR(100) NOT NULL,
    sodienthoai VARCHAR(15) NOT NULL,
    diachi NVARCHAR(255),
    ngaydangky DATE DEFAULT CAST(GETDATE() AS DATE)
);
GO

CREATE TABLE DANHMUC (
    madanhmuc VARCHAR(20) PRIMARY KEY,
    tendanhmuc NVARCHAR(100) NOT NULL,
    mota NVARCHAR(500),
    trangthai NVARCHAR(20) DEFAULT N'Hoạt động'
);
GO

CREATE TABLE MONAN (
    mamonan VARCHAR(20) PRIMARY KEY,
    tenmonan NVARCHAR(100) NOT NULL,
    hinhanh VARCHAR(255),
    dongia DECIMAL(18,2) NOT NULL,
    trangthaimonan NVARCHAR(20) DEFAULT N'Đang bán',
    madanhmuc VARCHAR(20) NOT NULL,
    masanpham VARCHAR(20) NULL,
    FOREIGN KEY (madanhmuc) REFERENCES DANHMUC(madanhmuc),
    FOREIGN KEY (masanpham) REFERENCES NGUYENLIEU(masanpham)
);
GO

CREATE TABLE PHEUKHO (
    mapheukho VARCHAR(20) PRIMARY KEY,
    ngaynhapheu DATETIME NOT NULL DEFAULT GETDATE(),
    diachi NVARCHAR(255),
    ghichu NVARCHAR(500),
    manhanvien VARCHAR(20) NOT NULL,
    FOREIGN KEY (manhanvien) REFERENCES NHANVIEN(manhanvien)
);
GO

CREATE TABLE CHITIETPHEUKHO (
    mapheukho VARCHAR(20) NOT NULL,
    masanpham VARCHAR(20) NOT NULL,
    soluong INT NOT NULL,
    dongia DECIMAL(18,2) NOT NULL,
    hansudung DATE,
    PRIMARY KEY (mapheukho, masanpham),
    FOREIGN KEY (mapheukho) REFERENCES PHEUKHO(mapheukho),
    FOREIGN KEY (masanpham) REFERENCES NGUYENLIEU(masanpham)
);
GO

CREATE TABLE DATBAN (
    madatban VARCHAR(20) PRIMARY KEY,
    ngaydatban DATE NOT NULL,
    giobatdau TIME NOT NULL,
    gioketthuc TIME,
    trangthaidatban NVARCHAR(20) DEFAULT N'Chờ xác nhận',
    manhanvien VARCHAR(20) NOT NULL,
    maban VARCHAR(20) NOT NULL,
    FOREIGN KEY (manhanvien) REFERENCES NHANVIEN(manhanvien),
    FOREIGN KEY (maban) REFERENCES BANAN(maban)
);
GO

CREATE TABLE DONHANG (
    madonhang VARCHAR(20) PRIMARY KEY,
    ngaydonhang DATETIME NOT NULL DEFAULT GETDATE(),
    trangthaidonhang NVARCHAR(30) DEFAULT N'Chờ xử lý',
    ghichu NVARCHAR(500),
    manhanvien VARCHAR(20) NOT NULL,
    makhachhang VARCHAR(20) NOT NULL,
    madatban VARCHAR(20) NOT NULL,
    FOREIGN KEY (manhanvien) REFERENCES NHANVIEN(manhanvien),
    FOREIGN KEY (makhachhang) REFERENCES KHACHHANG(makhachhang),
    FOREIGN KEY (madatban) REFERENCES DATBAN(madatban)
);
GO

CREATE TABLE CHITIETDONHANG (
    madonhang VARCHAR(20) NOT NULL,
    mamonan VARCHAR(20) NOT NULL,
    mamonphu VARCHAR(20) NULL,
    soluong INT NOT NULL,
    dongia DECIMAL(18,2) NOT NULL,
    trangthai NVARCHAR(20) DEFAULT N'Đã nhận',
    ghichu NVARCHAR(255),
    PRIMARY KEY (madonhang, mamonan),
    FOREIGN KEY (madonhang) REFERENCES DONHANG(madonhang),
    FOREIGN KEY (mamonan) REFERENCES MONAN(mamonan)
);
GO

-- GỘP HOADON + THANHTOAN → 1 BẢNG DUY NHẤT
CREATE TABLE THANHTOAN (
    mathanhtoan VARCHAR(20) PRIMARY KEY,
    mahoadon VARCHAR(20) NOT NULL UNIQUE,
    ngayhoadon DATETIME NOT NULL DEFAULT GETDATE(),
    tongtien DECIMAL(18,2) NOT NULL,
    loaitt NVARCHAR(20),
    tinhtrang NVARCHAR(30) DEFAULT N'Chưa xác nhận',
    hinhthuc NVARCHAR(30) NOT NULL,
    sotien DECIMAL(18,2) NOT NULL,
    ngaythanhtoan DATETIME NOT NULL DEFAULT GETDATE(),
    trangthai NVARCHAR(20) DEFAULT N'Chưa thanh toán',
    manhanvien VARCHAR(20) NOT NULL,
    madonhang VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (manhanvien) REFERENCES NHANVIEN(manhanvien),
    FOREIGN KEY (madonhang) REFERENCES DONHANG(madonhang)
);
GO

-- =============================================
-- NHẬP DỮ LIỆU CHÍNH XÁC — ĐÚNG THỨ TỰ
-- =============================================

INSERT INTO TAIKHOAN (matkhoan, tennguoidung, matkhau, quyentruycap, trangthaitaikhoan, ngaytao) VALUES
('TK001', N'Quản Lý Chính', '123456', N'Quản lý', N'Hoạt động', DEFAULT),
('TK002', N'Nhân Viên Phục Vụ', '123456', N'Nhân viên', N'Hoạt động', DEFAULT),
('TK003', N'Nhân Viên Kho', '123456', N'Nhân viên', N'Hoạt động', DEFAULT);
GO

-- NGUYÊN LIỆU TRƯỚC → MÓN ĂN SAU
INSERT INTO NGUYENLIEU (masanpham, tennl, donvitinh, conghiep, muctoithieunl) VALUES
('NL001', N'Thịt bò', N'Kg', N'Công ty TNHH Thực phẩm An Bình', 5.0),
('NL002', N'Gạo tẻ', N'Kg', N'Công ty Lương thực Miền Nam', 10.0),
('NL003', N'Rau tươi', N'Kg', N'Nông trại Xanh', 8.0),
('NL004', N'Bột gạo', N'Kg', N'Công ty Nguyên liệu Sạch', 5.0);
GO

INSERT INTO NHANVIEN (manhanvien, hoten, gioitinh, ngaysinh, sodienthoai, diachi, chucvu, trangthailamviec, matkhoan) VALUES
('NV001', N'Nguyễn Văn An', N'Nam', '1990-05-10', '0901234567', N'Quận 1, TP.HCM', N'Quản lý', N'Đang làm', 'TK001'),
('NV002', N'Trần Thị Bình', N'Nữ', '1995-08-15', '0912345678', N'Quận 3, TP.HCM', N'Nhân viên phục vụ', N'Đang làm', 'TK002'),
('NV003', N'Lê Văn Cường', N'Nam', '1992-03-20', '0923456789', N'Quận 5, TP.HCM', N'Nhân viên kho', N'Đang làm', 'TK003');
GO

INSERT INTO BANAN (maban, sohang, socot, vitri, trangthaiban) VALUES
('B01', 4, 4, N'Tầng trệt', N'Trống'),
('B02', 4, 6, N'Tầng trệt', N'Có khách'),
('B03', 6, 8, N'Tầng 1', N'Trống'),
('B04', 2, 2, N'Tầng 1', N'Đặt trước');
GO

INSERT INTO KHACHHANG (makhachhang, hoten, sodienthoai, diachi, ngaydangky) VALUES
('KH001', N'Phạm Thị Dung', '0934567890', N'Quận 10, TP.HCM', DEFAULT),
('KH002', N'Hoàng Văn Em', '0945678901', N'Quận Bình Thạnh, TP.HCM', DEFAULT);
GO

INSERT INTO DANHMUC (madanhmuc, tendanhmuc, mota, trangthai) VALUES
('DM01', N'Món chính', N'Các món ăn chính trong bữa ăn', DEFAULT),
('DM02', N'Đồ uống', N'Nước giải khát, nước ép, sinh tố', DEFAULT),
('DM03', N'Tráng miệng', N'Bánh, kem, chè', DEFAULT);
GO

-- MÓN ĂN SAU KHI CÓ NGUYÊN LIỆU
INSERT INTO MONAN (mamonan, tenmonan, hinhanh, dongia, trangthaimonan, madanhmuc, masanpham) VALUES
('MA001', N'Phở bò', 'phobo.jpg', 45000, N'Đang bán', 'DM01', 'NL001'),
('MA002', N'Cơm tấm sườn', 'comtam.jpg', 35000, N'Đang bán', 'DM01', 'NL002'),
('MA003', N'Gỏi cuốn', 'goicuon.jpg', 25000, N'Đang bán', 'DM01', 'NL003'),
('MA004', N'Nước cam ép', 'camep.jpg', 20000, N'Đang bán', 'DM02', NULL),
('MA005', N'Sinh tố bơ', 'sinhtobo.jpg', 28000, N'Đang bán', 'DM02', NULL),
('MA006', N'Chè đậu đỏ', 'chedaudu.jpg', 15000, N'Đang bán', 'DM03', 'NL004');
GO

INSERT INTO PHEUKHO (mapheukho, ngaynhapheu, diachi, ghichu, manhanvien) VALUES
('PK001', '2026-11-01 08:00:00', N'Kho chính - Khu A, Quận 8', N'Nhập hàng định kỳ đầu tháng', 'NV003');
GO

INSERT INTO CHITIETPHEUKHO (mapheukho, masanpham, soluong, dongia, hansudung) VALUES
('PK001', 'NL001', 20, 120000, '2026-11-20'),
('PK001', 'NL002', 50, 18000, '2027-05-10'),
('PK001', 'NL003', 30, 15000, '2026-11-10'),
('PK001', 'NL004', 10, 20000, '2027-01-15');
GO

INSERT INTO DATBAN (madatban, ngaydatban, giobatdau, gioketthuc, trangthaidatban, manhanvien, maban) VALUES
('DB001', '2026-11-05', '10:00:00', '12:00:00', N'Đã xác nhận', 'NV002', 'B04'),
('DB002', '2026-11-05', '11:30:00', NULL, N'Chờ xác nhận', 'NV002', 'B02');
GO

INSERT INTO DONHANG (madonhang, ngaydonhang, trangthaidonhang, ghichu, manhanvien, makhachhang, madatban) VALUES
('DH001', '2026-11-05 10:15:00', N'Đang phục vụ', N'Ít hành, nhiều tiêu', 'NV002', 'KH001', 'DB001'),
('DH002', '2026-11-05 11:45:00', N'Chờ xử lý', NULL, 'NV002', 'KH002', 'DB002');
GO

INSERT INTO CHITIETDONHANG (madonhang, mamonan, mamonphu, soluong, dongia, trangthai, ghichu) VALUES
('DH001', 'MA001', NULL, 2, 45000, N'Đã phục vụ', N'Nước dùng thanh'),
('DH001', 'MA004', NULL, 2, 20000, N'Đã phục vụ', NULL),
('DH002', 'MA002', NULL, 3, 35000, N'Chờ chế biến', N'Không mỡ hành'),
('DH002', 'MA005', NULL, 3, 28000, N'Chờ chế biến', NULL);
GO

-- THANHTOAN = HÓA ĐƠN + THANH TOÁN
INSERT INTO THANHTOAN (mathanhtoan, mahoadon, ngayhoadon, tongtien, loaitt, tinhtrang, hinhthuc, sotien, ngaythanhtoan, trangthai, manhanvien, madonhang) VALUES
('TT001', 'HD001', '2026-11-05 12:30:00', 130000, N'Tiền mặt', N'Đã thanh toán', N'Tiền mặt', 130000, '2026-11-05 12:30:00', N'Hoàn thành', 'NV002', 'DH001');
GO

PRINT N'✅ HOÀN THÀNH! Tạo CSDL + Nhập dữ liệu chính xác không lỗi!';
GO

-- =============================================
-- KIỂM TRA
-- =============================================
SELECT * FROM NGUYENLIEU;
SELECT * FROM MONAN;
SELECT * FROM DONHANG;
SELECT * FROM THANHTOAN;
GO
