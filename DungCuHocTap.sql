/*drop db trong truong hop in use*/
USE master
alter database DungCuHocTap set single_user with rollback immediate
drop database DungCuHocTap

CREATE DATABASE DungCuHocTap
GO

USE DungCuHocTap
GO

/*Tao bang du lieu*/
CREATE TABLE TheLoai
(
	MaTL INT PRIMARY KEY IDENTITY(1, 1),
	TenTL nvarchar(255) UNIQUE NOT NULL,
	MetaKeyword nvarchar(50),
	NgayTao datetime DEFAULT getdate()
)
GO

CREATE TABLE SanPham
(
	MaSP INT PRIMARY KEY IDENTITY(1, 1),
	TenSP nvarchar(255) NOT NULL,
	GiaSP DECIMAL(18, 0) NOT NULL,
	KhuyenMai DECIMAL(18, 0) DEFAULT 0,
	MotaSP NVARCHAR(MAX),
    AnhSP_1 NVARCHAR(MAX) DEFAULT N'',
    AnhSP_2 NVARCHAR(MAX) DEFAULT N'',
	Rating INT CHECK (RATING >=0 AND RATING <= 5),
	NgayTao DATETIME DEFAULT getdate(),
	TrangThaiSP bit,

	MaTL INT REFERENCES dbo.TheLoai(MaTL) ON DELETE CASCADE
)
GO

CREATE TABLE Mau(
	MaMau int PRIMARY KEY,
	TenMau nvarchar(255)
)
GO

CREATE TABLE CTSP(
	MaCTSP int PRIMARY KEY IDENTITY(1,1),
	MaSP int REFERENCES SanPham(MaSP) ON DELETE CASCADE,
	MaMau int REFERENCES Mau(MaMau) ON DELETE CASCADE
)
GO

CREATE TABLE KhachHang
(
    MaKH INT PRIMARY KEY IDENTITY(1, 1),
    UserName NVARCHAR(255) UNIQUE NOT NULL,
    UserPassword NVARCHAR(255) NOT NULL,
    EmailKH NVARCHAR(255),
    TenKH NVARCHAR(255) NOT NULL,
    SDTKH NVARCHAR(20),
    DiaChiKH NVARCHAR(255),
    NgayTao DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE TrangThai(
	MaTT int PRIMARY KEY IDENTITY(1,1),
	TenTT nvarchar(255),
	NgayTao datetime DEFAULT getdate()
)
GO

CREATE TABLE HoaDon
(
    MaHD INT PRIMARY KEY IDENTITY(1, 1),
    NgayTao DATETIME DEFAULT GETDATE(),
    TenKH nvarchar(255),
	SDT varchar(15),
	DiaChi nvarchar(MAX),
	TongTien decimal(18, 2),

	MaKH int REFERENCES dbo.KhachHang(MaKH) ON DELETE CASCADE,
	MaTT int REFERENCES dbo.TrangThai(MaTT) ON DELETE CASCADE
)
GO

CREATE TABLE CTHD
(
    MaCTHD int PRIMARY KEY IDENTITY(1,1),
	SoLuong int,

	MaHD int REFERENCES HoaDon(MaHD) ON DELETE CASCADE,
	MaSP int REFERENCES SanPham(MaSP) ON DELETE CASCADE,
	MaMau int REFERENCES dbo.Mau(MaMau) ON DELETE CASCADE
)
GO

CREATE TABLE [Admin]
(
    MaAdmin INT PRIMARY KEY IDENTITY(1, 1),
    AdminUserName NVARCHAR(255) UNIQUE NOT NULL,
    AdminPassword NVARCHAR(255) NOT NULL,
    TenAdmin NVARCHAR(255),

    NgayTao DATETIME DEFAULT getdate()
)
GO

/*Nhap du lieu*/
INSERT INTO dbo.TheLoai
VALUES
    (N'Bút các loại', N'but-cac-loai', getdate()),
	(N'Balo học sinh', N'balo-hoc-sinh', getdate()),
	(N'Hộp bút', N'hop-but', getdate()),
	(N'Dụng cụ khác', N'dung-cu-khac', getdate())
GO

INSERT INTO dbo.TrangThai
VALUES
    (N'Đang xử lý', getdate()),
	(N'Đang giao hàng', getdate()),
	(N'Đã giao hàng', getdate()),
	(N'Đã huỷ', getdate()),
	(N'Hàng có lỗi', getdate())
GO

INSERT INTO dbo.Mau
VALUES
(1, N'Xanh'), (2, N'Đỏ'), (3, N'Vàng'), (4, N'Đen')
GO

--but
INSERT INTO dbo.SanPham
VALUES
(
    N'Bút Semi gel Super-SG03', -- TenSP - nvarchar
    4000, -- GiaSP - DECIMAL
    0, -- KhuyenMai - DECIMAL
    N'Bút Gel dành cho học sinh - sinh viên & văn phòng
		Sản phẩm đột phá về công nghệ sản xuất mực - phát huy tối đa ưu điểm của bút gel và bút bi', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    4, -- Rating - INT
    '2020-06-22 22:57:26', -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    1 -- MaTL - INT
),
(
	N'Bút Semi gel Super-SG03', -- TenSP - nvarchar
    5500, -- GiaSP - DECIMAL
    0, -- KhuyenMai - DECIMAL
    N'Bút Gel dành cho học sinh - sinh viên & văn phòng
		Sản phẩm đột phá về công nghệ sản xuất mực - phát huy tối đa ưu điểm của bút gel và bút bi', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    '2020-06-22 22:57:26', -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    1 -- MaTL - INT
),
(
	N'Bút Semi Gel SG 2600', -- TenSP - nvarchar
    6000, -- GiaSP - DECIMAL
    0, -- KhuyenMai - DECIMAL
    N'Bút Gel dành cho học sinh - sinh viên & văn phòng
		Sản phẩm đột phá về công nghệ sản xuất mực - phát huy tối đa ưu điểm của bút gel và bút bi', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    '2020-06-22 22:57:26', -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    1 -- MaTL - INT
)
GO
--cap sach
INSERT INTO dbo.SanPham
VALUES
(
    N'Cặp học sinh Cozy', -- TenSP - nvarchar
    115000, -- GiaSP - DECIMAL
	0,
    N'Cặp nhựa Hồng Hà Cozy dành cho học sinh', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    2 -- MaLoai - INT
),
(
	N'Cặp học sinh SQ06', -- TenSP - nvarchar
    58000, -- GiaSP - DECIMAL
	0,
    N'Sản phẩm cặp nhựa dành cho học sinh', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    4, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    2 -- MaLoai - INT
)


INSERT INTO [Admin]
VALUES
    (N'hoang', N'123', N'Thái Việt Hoàng', getdate())
GO
--hop but
INSERT INTO dbo.SanPham
VALUES
(
    N'Hộp bút MJ Star Travel Astronaut 22x8.5', -- TenSP - nvarchar
    80000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    3 -- MaLoai - INT
),
(
	N'Hộp bút MJ Gấu nâu 8x20', -- TenSP - nvarchar
    60000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    4, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    3 -- MaLoai - INT
)
GO
--san pham khac
INSERT INTO dbo.SanPham
VALUES
(
    N'Bộ thước kẻ Cute Cat Cherry Blossom 20cm', -- TenSP - nvarchar
    25000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
),
(
	N'Bộ thước kẻ compa Thỏ Molang and Friends', -- TenSP - nvarchar
    70000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
),
(
	N'Kẹp tài liệu A4 Sumikko Gurashi NB 22x31', -- TenSP - nvarchar
    35000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
),
(
	N'Túi đựng tài liệu MJ Bake Time Sweet 24x33', -- TenSP - nvarchar
    30000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    4, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
),
(
	N'Cục tẩy gôm Xương rồng Cactus đầu hoa - Xanh lá cây', -- TenSP - nvarchar
    10000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
),
(
    N'Cắt băng dính Pink heart', -- TenSP - nvarchar
    25000, -- GiaSP - DECIMAL
	0,
    N'abc', -- MotaSP - NVARCHAR
    N'https://cdn.nhanh.vn/cdn/store/7534/ps/20200116/20012133_XX_thumb_350x350.JPG', -- AnhSP_1 - NVARCHAR
    N'', -- AnhSP_2 - NVARCHAR
    5, -- Rating - INT
    getdate(), -- NgayTao - DATETIME
    1, -- TrangThaiSP - bit
    4 -- MaLoai - INT
)
GO

INSERT INTO dbo.CTSP
VALUES
(1, 1), (1,2), (1,3), (2,2), (2,3), (3,1), (3,3)
GO
