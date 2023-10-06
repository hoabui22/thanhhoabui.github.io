GO 
USE QLyDatHang_CSDL
GO 

--1. ALL
-- ALL1: Đăng nhập

--SELECT * FROM dbo.TaiKhoan
--EXEC dbo.LogIn_All @TenTaiKhoan = N'Claire Sanford', -- nvarchar(50)
--                   @MatKhau = 'DGSC29'       -- varchar(10)

CREATE PROC LogIn_All 
	@TenTaiKhoan NVARCHAR(50),
	@MatKhau VARCHAR(10)
AS 
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS (
			SELECT *
			FROM TaiKhoan  
			WHERE TenTaiKhoan = @TenTaiKhoan)
		BEGIN
			PRINT N'Tên tài khoản không tồn tại!'
			ROLLBACK TRAN
			RETURN
		END

		IF NOT EXISTS (
			SELECT *
			FROM TaiKhoan
			WHERE TenTaiKhoan = @TenTaiKhoan AND MatKhau = @MatKhau
		)
		BEGIN 
			PRINT N'Mật khẩu không chính xác!'
			ROLLBACK TRAN
			RETURN
		END

		SELECT * FROM TaiKhoan WHERE TenTaiKhoan=@TenTaiKhoan
	END TRY

BEGIN CATCH
	--RETURN 0
	PRINT N'Đăng nhập thất bại'
	ROLLBACK TRANSACTION
	
END CATCH 
--RETURN 1
PRINT N'Đăng nhập thành công'
COMMIT TRAN 
GO 

--SELECT * FROM dbo.KhachHangDat
--Select * from TaiKhoan
--DELETE dbo.KhachHangDat WHERE Ma = 12095
--LoaiTK: 1. Admin, 2.NhanVien, 3. KhachHang, 4.TaiXe, 5.DoiTac
-- ALL2: Đăng ký 

alter proc SignUp_All
	@TenTaiKhoan NVARCHAR(50),
	@MatKhau varchar(10),
	@LoaiTK INT,
	@CMND CHAR(12),
	@Sdt CHAR(10),
	@Email varchar(20),
	@SoNha VARCHAR(10),
	@Duong NVARCHAR(20) ,
	@Quan NVARCHAR(20) ,
	@Thanhpho NVARCHAR(20)
as 
begin tran
	begin try
		if exists (
			select *
			from TaiKhoan 
			where TenTaiKhoan = @TenTaiKhoan)
		begin
			print N'Tên tài khoản đã tồn tại!'
			rollback tran
			return
		end
		BEGIN
			insert TaiKhoan(TenTaiKhoan, MatKhau, LoaiTK) 
			values ( @TenTaiKhoan, @MatKhau, @LoaiTK)
		END 
		if (@LoaiTK < 3 or @LoaiTK > 5)
		begin
			print N'Loại tài khoản không tồn tại!'
			rollback tran
			return
		end
		if (@LoaiTK = 3)
		BEGIN
			DECLARE @MaTK3 INT
			SET @MaTK3 = (SELECT MaTK FROM dbo.TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
			INSERT KhachHangDat VALUES (@MaTK3, @CMND, @Sdt, @Email, @SoNha, @Duong, @Quan, @Thanhpho)
		end

		if (@LoaiTK = 4)
		BEGIN 
			DECLARE @MaTK4 INT
			SET @MaTK4 = (SELECT MaTK FROM dbo.TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
			INSERT TaiXe(MaTaiXe, CMND, SoDienThoai,Email, SoNha, Duong,Quan,Thanhpho,PhiThueChan) VALUES (@MaTK4, @CMND, @Sdt, @Email, @SoNha, @Duong, @Quan, @Thanhpho, 0)
		end

		if (@LoaiTK = 5)
		begin
			DECLARE @MaTK5 INT
			SET @MaTK5 = (SELECT MaTK FROM dbo.TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
			INSERT DoiTac VALUES (@MaTK5, @CMND, @Sdt, @Email, @SoNha, @Duong, @Quan, @Thanhpho, '1/1/2020')
		END

		SELECT * FROM TaiKhoan WHERE TenTaiKhoan=@TenTaiKhoan
	end try

begin catch
	print N'Đăng ký không thành công'
	PRINT ERROR_MESSAGE()
	rollback transaction
	return 
end catch 
print N'Đăng ký thành công'
commit tran 
GO

--exec SignUp_All @TenTaiKhoan = 'Hello2' ,
--	@MatKhau ='123' ,
--	@LoaiTK = 3,
--	@CMND = '124334',
--	@Sdt = '12452',
--	@Email = 'adv@faws',
--	@SoNha = '12',
--	@Duong = 'bae',
--	@Quan = 'ergv',
--	@Thanhpho = 'arfv' 

GO 
CREATE proc SignUp_Admin
	@TenTaiKhoan NVARCHAR(50),
	@MatKhau varchar(10)
as 
begin tran
	begin try
		if exists (
			select *
			from TaiKhoan 
			where TenTaiKhoan = @TenTaiKhoan)
		begin
			print N'Tên tài khoản đã tồn tại!'
			rollback tran
			return
		end
		BEGIN
			insert TaiKhoan(TenTaiKhoan, MatKhau, LoaiTK) 
			values ( @TenTaiKhoan, @MatKhau, 1)
			DECLARE @MaTK1 INT
			SET @MaTK1 = (SELECT MaTK FROM dbo.TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
			INSERT AdminQly(MaAdmin) VALUES (@MaTK1)
		END 
	end try

begin catch
	print N'Đăng ký không thành công'
	PRINT ERROR_MESSAGE()
	rollback transaction
	return 
end catch 
print N'Đăng ký thành công'
commit tran 
GO

GO 
CREATE proc SignUp_NhanVien
	@TenTaiKhoan NVARCHAR(50),
	@MatKhau varchar(10)
as 
begin tran
	begin try
		if exists (
			select *
			from TaiKhoan 
			where TenTaiKhoan = @TenTaiKhoan)
		begin
			print N'Tên tài khoản đã tồn tại!'
			rollback tran
			return
		end
		BEGIN
			insert TaiKhoan(TenTaiKhoan, MatKhau, LoaiTK) 
			values ( @TenTaiKhoan, @MatKhau, 2)
			DECLARE @MaTK2 INT
			SET @MaTK2 = (SELECT MaTK FROM dbo.TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
			INSERT NhanVien(MaNhanVien) VALUES (@MaTK2)
		END 
	end try

begin catch
	print N'Đăng ký không thành công'
	PRINT ERROR_MESSAGE()
	rollback transaction
	return 
end catch 
print N'Đăng ký thành công'
commit tran 
GO


-- ALL3: Tra cứu 
create proc Search_All
	@TuKhoa nvarchar(50)
as 
begin tran
	begin try
		if not exists (
			select *
			from MonAn 
			where Ten = @TuKhoa)
		begin
			print N'Tên món ăn không tồn tại!'
			rollback tran
			return
		END
        
		ELSE
		BEGIN
		    SELECT* FROM dbo.MonAn WHERE Ten = @TuKhoa 
		END
	end try

begin catch
	rollback transaction
	return 
end catch 
commit tran 
GO

--ALL4: EditTK_All
CREATE proc Edit_All
	@MaTK int,
	@TenTaiKhoan NVARCHAR(50),
	@MatKhau varchar(10)
as 
begin tran
	begin try
		if not exists (
			select *
			from TaiKhoan  
			where MaTK = @MaTK)
		begin
			print N'Mã tài khoản không tồn tại!'
			rollback tran
			return
		end

		if exists (
			select *
			from TaiKhoan 
			where TenTaiKhoan = @TenTaiKhoan)
		begin
			print N'Tên tài khoản đã tồn tại!'
			rollback tran
			return
		end

		else 
		begin 
			update TaiKhoan 
			set TenTaiKhoan = @TenTaiKhoan 
			where MaTK = @MaTK

			update TaiKhoan
			set MatKhau = @MatKhau
			where MaTK = @MaTK
		end 
		SELECT * FROM TaiKhoan WHERE MaTK = @MaTK
	end try 
begin catch
	print N'Chỉnh sửa không thành công'
	rollback transaction
	return 
end catch 
print N'Chỉnh sửa thành công'
commit tran 
GO 

--EXEC dbo.Edit_All @MaTK = 12081,          -- int
--                  @TenTaiKhoan = N'hana1', -- nvarchar(50)
--                  @MatKhau = '123'       -- varchar(10)

--SELECT * FROM dbo.TaiKhoan WHERE MaTK=12081


--ALL5: xem ten doi tac
create proc XemDT
	@Madoitac INT 
as
begin tran
	begin try
		if not exists (
			select *
			from  DoiTac
			where MaDoiTac = @Madoitac)
		begin
			print N'Đối tác không tồn tại'
			rollback tran
			return
		end
		else
		begin
			select TK.TenTaiKhoan, DT.NguoiDaiDien
			from TaiKhoan TK, DoiTac DT
			where TK.MaTK = DT.MaDoiTac AND DT.MaDoiTac = @Madoitac
		end
	end try 
begin catch
	print N'Thất bại'
	rollback transaction
	return 
end catch 
print N'Tìm thấy thành công'
commit tran 
go





--2: ADMIN
--LoaiTK: 1. Admin, 2.NhanVien, 3. KhachHang, 4.TaiXe, 5.DoiTac
--AD1: Xóa tài khoản 
CREATE proc XoaTK_AD
	@MaTK INT
as
begin tran
	begin try
		if not exists (
			select *
			from TaiKhoan  
			where MaTK = @MaTK)
		begin
			print N'Mã tài khoản không tồn tại!'
			rollback tran
			return
		END
    
		if EXISTS (SELECT * FROM dbo.HopDong WHERE MaNhanVienQLy = @MaTK)
		BEGIN
			print N'Nhân viên này hiện đang quản lý hợp đồng, không thể xóa!'
			rollback tran
			return
		END
		if EXISTS (SELECT * FROM dbo.HopDong WHERE MaDoiTac = @MaTK)
		BEGIN
			print N'Đối tác này hiện đang có hợp đồng, không thể xóa!'
			rollback tran
			return
		END
		if EXISTS (SELECT * FROM dbo.DonDatHang WHERE MaKhachHang = @MaTK and TinhTrangDonHang != 'Đã nhận hàng')
		BEGIN
			print N'Khách hàng này đang có đơn hàng, không thể xóa!'
			rollback tran
			return
		END 
		if EXISTS (SELECT * FROM dbo.DonDatHang WHERE  MaTaiXe = @MaTK and TinhTrangDonHang != 'Đã nhận hàng')
		BEGIN
			print N'Tài xế này đang có đơn hàng, không thể xóa!'
			rollback tran
			return
		END 


		BEGIN
			DECLARE @LoaiTK int
			SET @LoaiTK = (SELECT LoaiTK FROM dbo.TaiKhoan WHERE MaTK = @MaTK)
			IF (@LoaiTK = 1)
				BEGIN
					DELETE dbo.AdminQly
					WHERE MaAdmin = @MaTK
				END

			IF (@LoaiTK = 2)
				BEGIN
					DELETE dbo.NhanVien
					WHERE MaNhanVien = @MaTK
				END

			IF (@LoaiTK = 3)
				BEGIN
					DELETE dbo.KhachHangDat
					WHERE Ma = @MaTK
				END

			IF (@LoaiTK = 4)
				BEGIN
					DELETE dbo.TaiXe
					WHERE MaTaiXe = @MaTK
				END
			
			IF (@LoaiTK = 5)
				BEGIN
					DELETE dbo.DoiTac
					WHERE MaDoiTac = @MaTK
				END
		END 

		BEGIN
			DELETE TaiKhoan
			where MaTK = @MaTK
		END 

	end try
	begin catch
		print N'Xóa thất bại'
		rollback tran
		return
	end catch
print N'Xóa thành công'
commit tran
GO

--AD2: Khóa tài khoản 
create proc Lock_AD
	@MaTK INT 
as 
begin tran
	begin try
		if not exists (
			select *
			from TaiKhoan  
			where MaTK = @MaTK)
		begin
			print N'Mã tài khoản không tồn tại!'
			rollback tran
			return
		end

		if exists (
			select *
			from TaiKhoan 
			where TinhTrang = 0 and MaTK = @MaTK)
		begin
			print N'Tài khoản đã bị khóa từ trước!'
			rollback tran
			return
		end

		else 
		begin
			Update TaiKhoan
			set TinhTrang = 0
			where MaTK = @MaTK
		end
	end try

begin catch
	print N'Khóa không thành công'
	rollback transaction
	return 
end catch 
print N'Khóa thành công'
commit tran 
go

--AD6: Kích hoạt tài khoản 
create proc UnLock_AD
	@MaTK INT 
as 
begin tran
	begin try
		if not exists (
			select *
			from TaiKhoan  
			where MaTK = @MaTK)
		begin
			print N'Mã tài khoản không tồn tại!'
			rollback tran
			return
		end

		if exists (
			select *
			from TaiKhoan 
			where TinhTrang = 1 and MaTK = @MaTK)
		begin
			print N'Tài khoản vẫn đang được kích hoạt!'
			rollback tran
			return
		end

		else 
		begin
			Update TaiKhoan
			set TinhTrang = 1
			where MaTK = @MaTK
		end
	end try

begin catch
	print N'Kích hoạt không thành công'
	rollback transaction
	return 
end catch 
print N'Kích hoạt thành công'
commit tran 
GO


-- ĐỐI TÁC
-- Cập nhập tình trạng cửa hàng
create proc CAP_NHAP_CUA_HANG
	@madoitac INT,
	@tinhtrang NVARCHAR(20)

	AS
	BEGIN TRANSACTION
		BEGIN TRY
			IF NOT EXISTS 
				(SELECT *
				FROM DoiTac
				WHERE MaDoiTac = @madoitac)
			BEGIN
				PRINT N'Thông tin đối tác không tồn tại'
				ROLLBACK TRANSACTION
				RETURN
			END

			BEGIN
				WAITFOR DELAY '00:00:01'
				UPDATE dbo.ChiNhanh
				SET TinhTrang = @tinhtrang
				where MaDoiTac = @madoitac
			end
		end try
		begin catch
			PRINT N'Cập nhật không thành công'
			ROLLBACK TRANSACTION
		END CATCH
			COMMIT TRANSACTION
		GO



-- Cập nhập món ăn trong thực đơn
CREATE PROC CAP_NHAP_MON
	@mamonan INT,
	@mathucdon INT,
	@ten NVARCHAR(30),
	@gia FLOAT,
	@maloai INT,
	@ava VARCHAR(100),
	@tinhtrang NVARCHAR(10)

	AS
	BEGIN TRANSACTION
		BEGIN TRY
        
			IF NOT EXISTS
				(SELECT *
				FROM dbo.MonAn
				WHERE MaMonAn = @mamonan)
			BEGIN
				PRINT N'Mã món ăn không tồn tại'
				ROLLBACK transaction
				return
			END
            
			if not exists
				(select *
				from ThucDon
				where MaThucDon = @mathucdon)
			begin
				print N'Mã thực đơn không tồn tại'
				rollback transaction
				return
			end

			if not exists
				(select *
				from LoaiMonAn
				where MaLoai = @maloai)
			begin
				print N'Mã loại đơn không tồn tại'
				rollback transaction
				return
			end

			begin
				update MonAn
				set Ten = @ten, Gia = @gia, Ava = @ava, TinhTrang = @tinhtrang
				WHERE (MaThucDon = @mathucdon) AND (MaMonAn = @mamonan) AND (MaLoai =@maloai)
			end

		end try
		BEGIN CATCH
			PRINT N'Cập nhật không thành công'
			ROLLBACK TRANSACTION
		END CATCH
			COMMIT TRANSACTION
		GO

-- Quản lí tình trạng đơn hàng

create proc QL_DON_HANG
	@tinhtrangdon nvarchar(20),
	@madonhang int

	as
	begin transaction
		begin try
			if not exists
				(select *
				from DonDatHang
				where MaDonHang = @madonhang)
			begin
				print N'Mã đơn hàng không tồn tại'
				rollback transaction
				return
			end

			begin
				update DonDatHang
				set TinhTrangDonHang = @tinhtrangdon
				where MaDonHang = @madonhang
			end

		end try
		begin catch
			print N'Cập nhật không thành công'
			rollback transaction
		end catch
			print N'Cập nhật thành công'
			commit transaction
		GO



-- Quản lí doanh thu trong tháng
create proc QL_DOANH_THU
	@ngaybd date,
	@sttchinhanh int

as
begin transaction
	begin try
		if not exists
			(select*
			from DonDatHang
			where MaSTTChiNhanh = @sttchinhanh)
		begin
			print N'Mã chi nhánh không tồn tại'
			rollback transaction
			return
		end

	end try
	begin catch
		print N'Không thể xuất doanh thu'
		rollback
		TRANSACTION
        
	end catch
		select DISTINCT dh.MaDonHang, dh.NgayLap, dh.PhiSanPham, dh.MaKhachHang
		from DonDatHang dh
		WHERE (dh.MaSTTChiNhanh = @sttchinhanh) AND ( day(@ngaybd) - day(NgayLap) <=30) AND (MONTH(@ngaybd) = MONTH(dh.NgayLap) AND (YEAR(@ngaybd)= YEAR(dh.NgayLap)))
		commit transaction
		GO

------------------------------------------------------------------------------------------------------------------------------------------------


-- TÀI XẾ
-- Xem đơn hàng chưa nhận
CREATE PROC XEM_DS_DON
	@matx INT
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS
			(SELECT*
			FROM TaiXe
			WHERE MaTaiXe = @matx)
		BEGIN
			PRINT N'Mã tài xế không tồn tại'
			ROLLBACK TRANSACTION
			RETURN
		END

		BEGIN
		SELECT DISTINCT DDH.MaDonHang,DDH.TinhTrangDonHang, DDH.SoLuong, DDH.TongTien, DDH.PhiSanPham, DDH.PhiVanChuyen, CN.SoNha, CN.Duong, CN.Quan, CN.Thanhpho, CN.SDT, DDH.SoNha, DDH.Duong, DDH.Quan, DDH.Thanhpho, DDH.SoDienThoai
		FROM DonDatHang DDH, ChiNhanh CN, ThucDon TD, TaiKhoan TK
		WHERE (DDH.TinhTrangDonHang = N'Chưa đặt') AND (DDH.MaSTTChiNhanh = CN.STT) AND (TD.MaDoiTac = CN.MaDoiTac) AND (TK.MaTK = CN.MaDoiTac)
        END

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
		COMMIT TRANSACTION
	GO



-- Cập nhập tình trạng đơn hàng
create proc CN_DON_HANG
	@tinhtrangdon nvarchar(20),
	@madonhang int

	as
	begin transaction
		begin try
			if not exists
				(select *
				from DonDatHang
				where MaDonHang = @madonhang)
			begin
				print N'Mã đơn hàng không tồn tại'
				rollback transaction
				return
			end
			

			begin
				update DonDatHang
				set TinhTrangDonHang = @tinhtrangdon
				where MaDonHang = @madonhang
			end

		end try
		begin catch
			rollback transaction
		end catch
			print N'Cập nhật thành công'
			commit transaction
		GO

        
-- Xem đánh giá của khách hàng
drop proc XEM_DANH_GIA
create proc XEM_DANH_GIA
	@matx int
as
begin transaction
	begin try
		if not exists
			(select *
			from TaiXe
			where MaTaiXe = @matx)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
		end

		end try
		begin catch
			print N'Lỗi thực hiện'
			rollback transaction
		end catch
			select MaTaiXe, RatingTaiXe, BinhLuanTaiXe
			from DanhGia dg, DonDatHang dh
			where (dg.MaDonHang = dh.MaDonHang) and (dh.MaTaiXe =@matx)
			commit transaction
		GO



-- Quản lí thu nhập trong tháng

create proc QL_THU_NHAP
	@ngaybd date,
	@matx int

as
begin transaction
	begin try
		if not exists
			(select*
			from TaiXe
			where MaTaiXe = @matx)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
			return
		end

	end try
	begin catch
		print N'Lỗi thực hiện'
		rollback
		transaction
	end CATCH
		select MaTaiXe, MaDonHang, NgayGiaoHang, PhiVanChuyen, MaKhachHang, PhiVanChuyen
		from DonDatHang
		where( day(@ngaybd) - day(NgayGiaoHang) <= 30) AND (MONTH(@ngaybd) = MONTH(NgayGiaoHang)) and (YEAR(@ngaybd)= YEAR(NgayGiaoHang)) AND (MaTaiXe = @matx)
		commit transaction
GO





--Phân hệ Nhân Viên
--NV1: Xem hợp đồng
create procedure XemHD
	@Madt INT
as
begin tran
	begin TRY
    	--Kiểm tra xem doi tac có tồn tại hay không
		if not exists (
			SELECT * 
			FROM DoiTac
			WHERE MaDoiTac = @Madt)
		begin
			print N'Mã đối tác không tồn tại'
			rollback transaction
			RETURN
        end
		--Kiểm tra xem hợp đồng có tồn tại hay không
		if not exists (
			SELECT * 
			FROM HopDong HD
			WHERE HD.MaDoiTac = @Madt)
		begin
			print N'Mã hợp đồng không tồn tại'
			rollback transaction
			RETURN
        end
	end try
	begin catch
		print N'Mã hợp đồng tồn tại'
		ROLLBACK TRAN
	end catch
		select * from HopDong where MaDoiTac = @Madt
	COMMIT tran
	GO
		

--NV2: Tạo hợp đồng
create Proc TaoHD
	@MaSoThue char(10),
	@MaDoiTac int,
	@NguoiDaiDien nvarchar(20),
	@SoTaiKhoan varchar(20),
	@NganHang nvarchar(20),
	@SoLuongChiNhanh int,
	@MaNhanVienQLy int,
	@NgayHetHan date
as
begin tran
	begin try
		--Kiểm tra mã hợp đồng đã tồn tại chưa
		if exists (select MaDoiTac from dbo.HopDong where MaDoiTac = @MaDoiTac)
			print N'Hợp đồng của đối tác đã tồn tại.'
			rollback transaction
			return

		--Kiểm tra mã nhân viên có tồn tại không
		if not exists (select MaNhanVien from NhanVien where @MaNhanVienQLy = MaNhanVien)
			print N'Nhân viên không tồn tại.'
			rollback transaction
			return
	end try
	begin catch
		print N'Tạo hợp đồng thành công.'
	end CATCH
		INSERT into HopDong(MaSoThue, SoTaiKhoan,NganHang,SoLuongChiNhanh,NgayHetHan, MaNhanVienQLy, MaDoiTac ) 
		VALUES (@MaSoThue, @SoTaiKhoan, @NganHang, @SoLuongChiNhanh, @NgayHetHan, @MaNhanVienQLy, @MaDoiTac)

		UPDATE HopDong
		SET NgayLap = GETDATE()
		WHERE MaDoiTac = @MaDoiTac
	COMMIT tran
GO


--NV3: Quản lý hợp đồng (cập nhật hợp đồng)
CREATE PROC  QLHD
	@MaHopDong int,
	@NgayHetHan date,
	@MaNhanVienQLy int
as
begin tran
	begin TRY
		--Kiểm tra mã hợp đồng có tồn tại không
		if not exists (
			SELECT * 
			FROM HopDong 
			WHERE  MaHopDong =@MaHopDong)
		begin
			print N'Mã hợp đồng không tồn tại.'
			rollback transaction
			RETURN
		END  
		--Kiểm tra nhân viên có được quyền quản lý hợp đồng này không
		if not exists (
			SELECT * 
			FROM HopDong 
			WHERE  MaHopDong =@MaHopDong AND MaNhanVienQLy = @MaNhanVienQLy)
		begin
			print N'Nhân viên không có quyền quản lý'
			rollback transaction
			RETURN
		END   
		--Cập nhật ngày hết hạn hợp đồng
		BEGIN
			UPDATE HopDong
			SET NgayHetHan = @NgayHetHan
			WHERE MaHopDong = @MaHopDong
        END

	end try
	begin catch

		print N'Cập nhật không thành công'
		rollback tran
	end CATCH
		print N'Cập nhật thành công'
commit tran
GO

--NV4: Tạo thông báo
create procedure TaoThongBao
	@MaNG int,
	@NoiDung NVARCHAR(50),
	@MaNN int
as
begin tran
	begin try
		--Kiểm tra người gửi người nhận có tồn tại không
		if not exists 
		(select NG.MaTK FROM TaiKhoan NG
		WHERE NG.MaTK = @MaNG)
		BEGIN
			print N'Người gửi không tồn tại.'
			rollback transaction
			RETURN
		END
		if not exists 
		(select NN.MaTK from TaiKhoan NN 
		WHERE NN.MaTK = @MaNN)
		BEGIN
			print N'Người nhận không tồn tại.'
			rollback transaction
			RETURN
		END   
	end try
	begin catch
		INSERT INTO ThongBao
		(
		    MaNguoiGui,
		    MaNguoiNhan,
		    NoiDung,
		    Tinhtrang
		)
		VALUES
		(
		    @MaNG,   -- MaNguoiGui - char(10)
		    @MaNN,   -- MaNguoiNhan - char(10)
		    @NoiDung, -- NoiDung - nvarchar(50)
		    0  -- Tinhtrang - int
		    )
	end catch
commit tran
GO


--nv5: XEM DANH SACH Hop Dong do NHAN VIEN QUAN LY
create procedure XemDoiTac
	@Manv int

as
begin tran
	begin TRY
		if not exists (select * from dbo.NhanVien where MaNhanVien = @Manv)
		BEGIN
			PRINT 'Khong ton tai nhan vien.'
			rollback transaction
			RETURN
         end
	end try
	begin catch
		print N'Không thể tìm thấy nhan vien.'
		ROLLBACK TRANSACTION
	end CATCH
		SELECT *
		FROM dbo.HopDong HD, dbo.DoiTac DT 
		WHERE (HD.MaDoiTac = DT.MaDoiTac) AND (HD.MaNhanVienQLy = @Manv)
		COMMIT tran
GO



--Phân hệ Khách Hàng

--kh1: XEM DANH SACH DON HANG DA DAT
create procedure dsdon
	@Makh int

as
begin tran
	begin try
		if not exists (select * from dbo.KhachHangDat where Ma = @Makh)
		BEGIN
			PRINT 'Khong ton tai khach hang.'
			rollback transaction
			RETURN
         END 
	end try
	begin catch
		print N'Không thể tìm thấy khach hang.'
		ROLLBACK TRAN
	end CATCH
		SELECT *
		FROM dbo.DonDatHang
		WHERE MaKhachHang = @Makh		
		COMMIT tran
GO


--kh2: xem chi tiet 1 don hang
create procedure CTDH
	@MaDH int,
	@Makh int
as
begin tran
	begin try
		if not exists (select * from dbo.KhachHangDat where Ma = @Makh)
		BEGIN 
			PRINT 'Khong ton tai khach hang.'
			rollback transaction
			RETURN
		END 
         if not exists (select * from dbo.DonDatHang where MaDonHang = @MaDH)
		BEGIN
			PRINT 'Khong ton tai Don Hang.'
			rollback transaction
			RETURN
		END 
         if not exists (select * from dbo.ChiTietDonDatHang CT, dbo.DonDatHang DH where CT.MaDonHang = @MaDH AND CT.MaDonHang = DH.MaDonHang AND DH.MaKhachHang = @MaDH)
		BEGIN PRINT 'Don hang khong phai cua ban.'
			rollback transaction
			RETURN
		END 
	end try
	begin catch
		print N'Không thể tìm thấy Don hang.'
		ROLLBACK TRAN
	end CATCH
		SELECT * from dbo.ChiTietDonDatHang CT, dbo.DonDatHang DH where CT.MaDonHang = @MaDH AND CT.MaDonHang = DH.MaDonHang AND DH.MaKhachHang = @MaDH
		COMMIT tran
GO

--kh3: Tao don hang
create PROCEDURE Tao_Don_Hang
	@Makh INT,
	@MaMonAn INT,
	@Soluong INT,
	@TuyChon NVARCHAR(20),
	@Sdt CHAR(10),
	@ThanhToan NVARCHAR(20),
	@Sonha VARCHAR(10),
	@Duong NVARCHAR(20),
	@Quan VARCHAR(20),
	@Tp VARCHAR(20),
	@MaCN INT
as
begin tran
	begin try
		if not exists (select * from dbo.KhachHangDat where Ma = @Makh)
		BEGIN
			PRINT 'Khong ton tai khach hang.'
			rollback transaction
			RETURN
         END 
		 IF NOT EXISTS
		 (SELECT MA.MaMonAn FROM MonAn MA, ChiNhanh CN, ThucDon TD
		 WHERE MA.MaMonAn = @MaMonAn AND CN.STT = @MaCN AND CN.MaDoiTac = TD.MaDoiTac AND TD.MaThucDon = MA.MaThucDon)
		 BEGIN
			PRINT 'Không tồn tại món ăn.'
			rollback transaction
			RETURN
         END
		 BEGIN
			INSERT DonDatHang
			(
			    TinhTrangDonHang,
			    SoDienThoai,
			    HinhThucThanhToan,
			    TinhTrangThanhToan,
			    SoNha,
			    Duong,
			    Quan,
			    Thanhpho,
			    PhiVanChuyen,
			    SoLuong,
			    TuyChon,
			    MaKhachHang,
			    MaTaiXe,
			    MaSTTChiNhanh
			)
			VALUES
			(  
			    N'Đang đặt', -- TinhTrangDonHang - nvarchar(20)
			    @Sdt, -- SoDienThoai - char(10)
			    @ThanhToan, -- HinhThucThanhToan - nvarchar(20)
			    0, -- TinhTrangThanhToan - int
			    @Sonha, -- SoNha - varchar(10)
			    @Duong, -- Duong - nvarchar(20)
			    @Quan, -- Quan - nvarchar(20)
			    @Tp, -- Thanhpho - nvarchar(20)
			    20, -- PhiVanChuyen - float
			    @Soluong, -- SoLuong - int
			    @TuyChon, -- TuyChon - nvarchar(20)
			    @Makh, -- MaKhachHang - int
			    NULL, -- MaTaiXe - int
			    @MaCN  -- MaSTTChiNhanh - int
			    )
			DECLARE @Madh INT
			SET @Madh = (SELECT MaDonHang
						FROM DonDatHang
						WHERE MaKhachHang = @Makh AND TinhTrangDonHang = N'Đang đặt')
			INSERT ChiTietDonDatHang
			(
			    MaDonHang,
			    SoLuong,
			    TongGia,
			    MaMonAn
			)
			VALUES
			(   @Madh, -- MaDonHang - int
			    @Soluong, -- SoLuong - int
			    0, -- TongGia - float
			    @MaMonAn  -- MaMonAn - int
			 )
			DECLARE @T FLOAT = 0
			SET @T = (SELECT Gia
					FROM MonAn
					WHERE MaMonAn = @MaMonAn)
			SET @T = @T * @Soluong
			UPDATE ChiTietDonDatHang
			SET TongGia = @T
			WHERE MaDonHang = @Madh AND
					MaMonAn = @MaMonAn
			UPDATE dbo.DonDatHang
			SET NgayLap = GETDATE(), NgayGiaoHang = GETDATE(), PhiSanPham = @T, TongTien = @T + PhiVanChuyen
			WHERE MaDonHang = @Madh
		 END
	end try
	begin catch
		print N'Không thể đặt hàng.'
		ROLLBACK TRAN
	end CATCH
	COMMIT tran
GO

--Kh4: Thêm món
create PROCEDURE ThemMon
	@Ma INT,
	@MaMA INT,
	@SL INT,
	@cn INT
as
begin tran
	begin try
		if not exists (select * from dbo.KhachHangDat where Ma = @Ma)
		BEGIN
			PRINT 'Khong ton tai khach hang.'
			rollback transaction
			RETURN
         END 
		 IF EXISTS(SELECT MaKhachHang
				FROM DonDatHang
				WHERE MaKhachHang = @Ma AND
					TinhTrangDonHang != N'Đang đặt')
		 BEGIN
			PRINT 'Đơn hàng không thể thêm sản phẩm'
			rollback transaction
			RETURN
         END 
		 IF NOT EXISTS(SELECT MaSTTChiNhanh
				FROM DonDatHang
				WHERE MaKhachHang = @Ma AND
					TinhTrangDonHang = N'Đang đặt')
		 BEGIN
			PRINT 'Bạn phải đặt cùng 1 chi nhánh'
			rollback transaction
			RETURN
         END 
		 IF NOT EXISTS (SELECT MaKhachHang FROM DonDatHang
						WHERE MaKhachHang = @Ma)
		 BEGIN
			DECLARE @sdt CHAR(10), @sonha VARCHAR(10), @d NVARCHAR(20), @Q NVARCHAR(20), @tp NVARCHAR(20)
			SELECT SoDienThoai = @sdt, SoNha = @sonha, Duong = @d, Quan = @Q, Thanhpho = @tp
			FROM KhachHangDat
			WHERE Ma = @Ma

			EXECUTE dbo.Tao_Don_Hang @Makh = @Ma,        -- int
			                         @MaMonAn = @MaMA,     -- int
			                         @Soluong = @SL,     -- int
			                         @TuyChon = N'',   -- nvarchar(20)
			                         @Sdt = @sdt,        -- char(10)
			                         @ThanhToan = NULL, -- nvarchar(20)
			                         @Sonha = @sonha,      -- varchar(10)
			                         @Duong = @d,      -- varchar(20)
			                         @Quan = @Q,       -- varchar(20)
			                         @Tp = @tp,         -- varchar(20)
			                         @MaCN = @cn         -- int
         END
		 ELSE
         BEGIN
			 DECLARE @madh INT, @T FLOAT = 0
			 SET @madh = (SELECT MaDonHang
						FROM DonDatHang
						WHERE MaKhachHang = @Ma AND TinhTrangDonHang = N'Đang đặt')
			SET @T = ( SELECT Gia
						FROM MonAn
						WHERE MaMonAn = @MaMA)
			SET @T = @T * @SL
			IF @MaMA NOT IN (SELECT @MaMA
						FROM ChiTietDonDatHang
						WHERE MaDonHang = @madh AND MaMonAn = @MaMA)
			BEGIN
				INSERT ChiTietDonDatHang
				(
					MaDonHang,
					SoLuong,
					TongGia,
					MaMonAn
				)
				VALUES
				(   @madh, -- MaDonHang - int
				   @SL, -- SoLuong - int
					@T, -- TongGia - float
				  @MaMA  -- MaMonAn - int
				 )
			END 
			ELSE
			BEGIN
				UPDATE dbo.ChiTietDonDatHang
				SET TongGia = TongGia + @T
				WHERE MaMonAn = @MaMA AND
					MaDonHang = @madh
			END
			UPDATE dbo.DonDatHang
			SET TongTien = TongTien + @T, PhiSanPham = PhiSanPham + @Tz
			WHERE MaDonHang = @madh
		 end
	end try
	begin catch
		print N'Không thể đặt hàng.'
		ROLLBACK TRAN
	end CATCH
	COMMIT tran
GO

--kh5: Xoá món trong đơn hàng


CREATE  PROC XOAMON
	@madh INT,
	@mamon INT 
AS
BEGIN 
	BEGIN TRAN 
		BEGIN TRY
			--Kiểm tra mã đơn hàng tồn tại
			IF NOT EXISTS (SELECT * FROM DonDatHang  WHERE MaDonHang = @madh)
			BEGIN 
				PRINT 'Không tồn tại đơn hàng'
				ROLLBACK TRANSACTION
				RETURN
			END
            
            --Kiểm tra tình trạng đơn hàng
            if exists (select * from DonDatHang where TinhTrangDonHang = N'Đã giao')
            begin
				print N'Đơn hàng đã được giao.'
                rollback transaction
                return
			END

            --Kiểm tra món ăn tồn tại trong đơn hàng
			IF NOT EXISTS ( SELECT * FROM dbo.ChiTietDonDatHang WHERE MaDonHang = @madh AND MaMonAn = @mamon )
			BEGIN
				PRINT 'Không tồn tại món ăn trong đơn hàng'
				ROLLBACK transaction
				RETURN
			END 
			ELSE
			BEGIN
				DELETE FROM dbo.ChiTietDonDatHang
				WHERE (MaMonAn = @mamon AND MaDonHang = @madh)
			END
			 --	Kiểm tra đơn đã đc giao chưa
			IF EXISTS (SELECT * FROM dbo.DanhGia WHERE MaDonHang = @madh)
            begin
				print N'Đơn hàng đã được giao đó.'
                rollback transaction
                return
			END
 
		END TRY
	BEGIN CATCH 
		print N'Không thể tìm thấy Don hang.'
		ROLLBACK TRAN
	END CATCH
			begin
				DELETE FROM dbo.DonDatHang
				WHERE (MaDonHang = @madh)
			END
	COMMIT TRAN 
	END 
GO

DROP PROC dbo.XOAMON

/*EXEC dbo.XOAMON @madh = 818, -- int
                @mamon = 818 -- int

SELECT DISTINCT dg.MaDonHang, ct.MaDonHang, dh.MaDonHang, ct.MaMonAn, dh.TinhTrangDonHang
FROM dbo.DanhGia dg, dbo.ChiTietDonDatHang ct, dbo.DonDatHang dh
where (dh.MaDonHang = ct.MaDonHang) AND (dg.MaDonHang = dh.MaDonHang) AND (dh.MaDonHang = 818)

SELECT dh.MaDonHang
FROM dbo.DanhGia dh
where dh.MaDonHang = 818

DELETE FROM dbo.DanhGia
WHERE MaDonHang = 818

SELECT dh.MaDonHang
FROM dbo.DonDatHang dh
where dh.MaDonHang = 818
*/			
	
--kh6: Thay doi thong tin giao hang
/CREATE PROC TTGH
	@ma int,
	@sdt CHAR(10),
	@sn varchar(10),
	@dg nvarchar(20),
	@quan nvarchar(20),
	@tp nvarchar(20)
AS
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM dbo.KhachHangDat WHERE Ma = @ma)
		BEGIN
			PRINT 'Khong ton tai khach hang.'
			rollback transaction
			RETURN
         END

	END TRY
    BEGIN CATCH 
		PRINT N'Không thể thay đổi thông tin.'
		ROLLBACK TRAN
	END CATCH
		UPDATE dbo.KhachHangDat
		SET SoDienThoai =@sdt, SoNha = @sn, Duong=@dg, Quan=@quan, Thanhpho = @tp
		WHERE Ma = @ma
	COMMIT TRAN
GO

/*EXEC TTGH
	@ma = 1,
	@sdt = 12345,
	@sn = '1gh2',
	@dg = 'adv',
	@quan = '123',
	@tp = 'hai'*/



--kh7: huy don hang
create proc HuyDon
	@MaDonHang int
as
begin tran
	begin try
		if not exists (select MaDonHang from DonDatHang where MaDonHang = @MaDonHang)
		begin
			print N'Mã đơn hàng không tồn tại.'
			rollback tran
			return
		end
		--if ((select TinhTrangDonHang from DonDatHang where @MaDonHang = MaDonHang) <> N'Đang xử lý')
			--print N'Đơn hàng đã được nhận.'
			--rollback tran
			--return
	end try

	begin catch
		print N'Không thể hủy đơn hàng.'
		rollback tran
		return
	end catch
	begin
		UPDATE DonDatHang
		SET TinhTrangDonHang = N'Đã hủy'
		where MaDonHang = @MaDonHang
	END 

commit tran
GO



--kh 8: Đánh giá đơn hàng
create proc DanhGiaDH
	@MaDonHang int,
    @RatingDH int,
	@BinhLuanDH NVARCHAR(50),
	@RatingTX int,
	@BinhLuanTX NVARCHAR(50)
AS
BEGIN transaction
	begin try
		--Kiểm tra mã đơn hàng tồn tại
        if not exists (select MaDonHang from DanhGia where MaDonHang = @MaDonHang)
		begin
			print N'Mã đơn hàng không tồn tại.'
            rollback transaction
            RETURN
        end
	end try
    
    begin catch
		print N'Không thể thực hiện đánh giá.'
        rollback transaction
        return
	end catch
    BEGIN 
		UPDATE DanhGia
		SET RatingDonHang = @RatingDH, BinhLuanDonHang = @BinhLuanDH, RatingTaiXe = @RatingTX, BinhLuanTaiXe = @BInhLuanTX
		WHERE MaDonHang = @MaDonHang
	END 
    
commit TRANSACTION
GO
/*DROP PROC DanhGiaDH
EXEC DanhGiaDH
	@MaDonHang = 2,
    @RatingDH =5,
	@BinhLuanDH ='Ngol lam',
	@RatingTX =5,
	@BinhLuanTX ='TX tuyet voi'*/




