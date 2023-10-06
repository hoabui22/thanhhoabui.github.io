create database QLyDatHang_CSDL

GO
USE QLyDatHang_CSDL
GO

CREATE TABLE DonDatHang (
	MaDonHang INT IDENTITY(1,1),
	NgayLap DATE,
	NgayGiaoHang DATE,
	TinhTrangDonHang NVARCHAR(20),
	SoDienThoai CHAR(10),
	HinhThucThanhToan NVARCHAR(20),
	TinhTrangThanhToan INT,
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	PhiSanPham FLOAT,
	PhiVanChuyen FLOAT,
	TongTien FLOAT, 
	SoLuong INT, 
	TuyChon NVARCHAR(20),
	MaKhachHang INT,
	MaTaiXe INT NOT NULL,
	MaSTTChiNhanh INT NOT NULL,
	CONSTRAINT PK_DonDatHang PRIMARY KEY (MaDonHang),
	CONSTRAINT CHECK_HinhThucThanhToan
	CHECK  (HinhThucThanhToan IN (N'Thẻ',N'Chuyển Khoản', N'Ví')),
)

CREATE TABLE ChiTietDonDatHang (
	MaSTT INT IDENTITY(1,1),
	MaDonHang INT NOT NULL,
	SoLuong INT,
	TongGia FLOAT,
	MaMonAn INT NOT NULL,
	CONSTRAINT PK_ChiTietDonDatHang PRIMARY KEY (MaSTT)
)

CREATE TABLE LoaiMonAn (
	MaLoai INT NOT NULL IDENTITY(1,1),
	TenLoai NVARCHAR(20)
	CONSTRAINT PK_LoaiMonAn PRIMARY KEY (MaLoai)
)

CREATE TABLE TaiXe (
	MaTaiXe INT,
	CMND CHAR(12),
	SoDienThoai CHAR(10),
	Email VARCHAR(20), 
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	BienSoXe VARCHAR(10),
	SoTaiKhoan VARCHAR(20),
	TenNganHang NVARCHAR(20),
	ChiNhanh NVARCHAR(20),
	PhiThueChan FLOAT,
	Rating FLOAT
	CONSTRAINT PK_TaiXe PRIMARY KEY (MaTaiXe)
)

CREATE TABLE KhuVucHoatDong(
	MaKV INT IDENTITY(1,1),
	MaTaiXe INT NOT NULL,
	Quan NVARCHAR(20)
	CONSTRAINT PK_KhuVucHoatDong PRIMARY KEY (MaKV)
)

CREATE TABLE AdminQly (
	MaAdmin INT,
	--MatKhau varchar(10),
	--Ten nvarchar(30),
	CMND CHAR(12),
	SoDienThoai CHAR(10),
	Email VARCHAR(20), 
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	CONSTRAINT PK_AdminQly PRIMARY KEY (MaAdmin)
) 

CREATE TABLE KhachHangDat (
	Ma INT ,
	--MatKhau varchar(10),
	--Ten nvarchar(30),
	CMND CHAR(12),
	SoDienThoai char(10),
	Email VARCHAR(20), 
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	CONSTRAINT PK_KhachHang PRIMARY KEY (Ma)
)

CREATE TABLE NhanVien (
	MaNhanVien INT ,
	--MatKhau varchar(10),
	--Ten nvarchar(30),
	CMND CHAR(12),
	SoDienThoai char(10),
	Email VARCHAR(20), 
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	CONSTRAINT PK_NhanVien PRIMARY KEY (MaNhanVien)
)

CREATE TABLE HopDong (
	MaHopDong INT IDENTITY(1,1),
	NgayLap DATE,
	MaSoThue CHAR(10),
	SoTaiKhoan VARCHAR(20),
	NganHang NVARCHAR(20),
	SoLuongChiNhanh INT,
	NgayHetHan DATE,
	MaNhanVienQLy INT NOT NULL, 
	MaDoiTac INT NOT NULL,
	CONSTRAINT PK_HopDong PRIMARY KEY (MaHopDong)
)

CREATE TABLE DoiTac (
	MaDoiTac INT, 
	NguoiDaiDien NVARCHAR(20),
	--MatKhau varchar(10),
	--Ten nvarchar(30),
	SoDienThoai char(10),
	Email VARCHAR(20),
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	--LoaiAmThuc nvarchar(20),
	NgayCapNhat DATETIME
	CONSTRAINT PK_DoiTac PRIMARY KEY (MaDoiTac)
)

CREATE TABLE ChiNhanh (
	STT INT IDENTITY(1,1),
	MaDoiTac INT NOT NULL,
	SoNha VARCHAR(10),
	Duong NVARCHAR(20),
	Quan NVARCHAR(20),
	Thanhpho NVARCHAR(20),
	SDT CHAR(10), 
	TinhTrang NVARCHAR(20),
	ThGianHoatDong CHAR(10)
	CONSTRAINT PK_ChiNhanh PRIMARY KEY (STT)
)

CREATE TABLE ThucDon (
	MaThucDon INT IDENTITY(1,1),
	SoLuong INT,
	MaDoiTac INT NOT NULL,
	Rating FLOAT
	CONSTRAINT PK_ThucDon PRIMARY KEY (MaThucDon)
)

CREATE TABLE MonAn (
	MaMonAn INT IDENTITY(1,1),
	MaThucDon INT NOT NULL,
	Ten NVARCHAR(30),
	Gia FLOAT,
	MaLoai INT,
	Ava VARCHAR(100),
	TinhTrang NVARCHAR(10)
	CONSTRAINT PK_MonAn PRIMARY KEY (MaMonAn),
	CONSTRAINT CHECK_TinhTrang
	CHECK  (TinhTrang IN (N'Còn',N'Hết món')),
)

CREATE TABLE DanhGia (
	MaDonHang INT,
	RatingDonHang int,
	BinhLuanDonHang NVARCHAR(50),
	RatingTaiXe int,
	BinhLuanTaiXe NVARCHAR(50),
	CONSTRAINT PK_DanhGia PRIMARY KEY (MaDonHang)
)

CREATE TABLE ThongBao (
	MaTB INT IDENTITY(1,1),
	MaNguoiGui INT NOT NULL,
	MaNguoiNhan INT NOT NULL,
	NoiDung NVARCHAR(50),
	Tinhtrang INT,
	CONSTRAINT PK_ThongBao PRIMARY KEY (MaTB)
	--Tinh Trạng: 0 - chua doc, 1 - da doc
)

CREATE TABLE TaiKhoan (
	MaTK INT IDENTITY(1,1),
	TenTaiKhoan NVARCHAR(50) UNIQUE,
	MatKhau VARCHAR(10),
	LoaiTK INT,
	Ava VARCHAR(100),
	--TinhTrang INT, --0 lock, --1 unlock
	CONSTRAINT PK_TaiKhoan PRIMARY KEY (MaTK) 
	--Khoa ngoai: MaDT, MaAdmin, MaNV, MaKH, MaTaiXe
)
--LoaiTK: 1. Admin, 2.NhanVien, 3. KhachHang, 4.TaiXe, 5.DoiTac

--tạo khóa ngoại
--ChiTietDonHang
ALTER TABLE ChiTietDonDatHang
ADD CONSTRAINT FK_ChiTietDonDatHang_DonDatHang
FOREIGN KEY (MaDonHang)
REFERENCES DonDatHang(MaDonHang)

ALTER TABLE ChiTietDonDatHang
ADD CONSTRAINT FK_ChiTietDonDatHang_MonAn
FOREIGN KEY (MaMonAn)
REFERENCES dbo.MonAn(MaMonAn)

--ThucDon 
ALTER TABLE ThucDon
ADD CONSTRAINT FK_ThucDon_DoiTac
FOREIGN KEY (MaDoiTac)
REFERENCES DoiTac(MaDoiTac)

--MonAn 
ALTER TABLE MonAn
ADD CONSTRAINT FK_MonAn_ThucDon
FOREIGN KEY (MaThucDon)
REFERENCES ThucDon(MaThucDon) 

ALTER TABLE MonAn
add constraint FK_MonAn_LoaiMonAn
foreign key (MaLoai)
references LoaiMonAn(MaLoai) 

--DanhGia
alter table DanhGia
add constraint FK_DanhGia_DonDatHang
foreign key (MaDonHang)
references DonDatHang(MaDonHang) 

--HopDong
alter table HopDong
add constraint FK_HopDong_NhanVien
foreign key (MaNhanVienQly) 
references NhanVien(MaNhanVien)

alter table HopDong
add constraint FK_HopDong_DoiTac
foreign key (MaDoiTac) 
references DoiTac(MaDoiTac)

--ChiNhanh
alter table ChiNhanh
add constraint FK_ChiNhanh_DoiTac
foreign key (MaDoiTac)
references DoiTac(MaDoiTac)

--ThongBao
alter table ThongBao
add constraint FK_GuiThongBao_TaiKhoan
foreign key (MaNguoiGui)
REFERENCES TaiKhoan(MaTK)

alter table ThongBao
add constraint FK_NhanThongBao_TaiKhoan
foreign key (MaNguoiNhan)
REFERENCES TaiKhoan(MaTK)

--DDH
alter table DonDatHang
add constraint FK_DonDatHang_KhachHang
foreign key (MaKhachHang) 
references KhachHangDat(Ma)  

alter table DonDatHang
add constraint FK_DonDatHang_ChiNhanh
foreign key (MaSTTChiNhanh) 
references ChiNhanh(STT) 

alter table DonDatHang
add constraint FK_DonDatHang_TaiXe 
foreign key (MaTaiXe) 
references TaiXe(MaTaiXe)

--TaiKhoan

--admin
alter table AdminQly
add constraint FK_AdminQLY_TaiKhoan
FOREIGN key (MaAdmin)
references TaiKhoan(MaTK)

--KH
alter table KhachHangDat
add constraint FK_KhachHangDat_TaiKhoan
FOREIGN key (Ma)
references TaiKhoan(MaTK)

--Taixe
alter table TaiXe
add constraint FK_TaiXe_TaiKhoan
FOREIGN key (MaTaiXe)
references TaiKhoan(MaTK)

alter table dbo.KhuVucHoatDong
add constraint FK_KhuVucHoatDong_TaiXe
FOREIGN key (MaTaiXe)
references TaiXe(MaTaiXe)

--NhanVien
alter table NhanVien
add constraint FK_NhanVien_TaiKhoan
FOREIGN key (MaNhanVien)
references TaiKhoan(MaTK)

--DoiTac
alter table DoiTac
add constraint FK_DoiTac_TaiKhoan
FOREIGN key (MaDoiTac)
references TaiKhoan(MaTK)



