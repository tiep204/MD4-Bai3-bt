create database quanlybanhang;
use quanlybanhang;
create table khachhang
(
    maKh     nvarchar(4) primary key,
    tenKh    nvarchar(30),
    diaChi   nvarchar(50),
    ngaySinh datetime,
    soDT     nvarchar(15) unique
);

create table nhanVien
(
    MaNV       nvarchar(4) primary key,
    hoTen      nvarchar(30),
    gioiTinh   bit,
    diaChi     nvarchar(50),
    ngaySinh   datetime,
    dienThoai  nvarchar(15),
    email      text,
    noiSinh    nvarchar(20),
    ngayVaoLam datetime,
    maSQL      nvarchar(4)
);

create table nhaCungCap
(
    maNCC     nvarchar(5) primary key,
    tenNCC    nvarchar(50),
    diaChi    nvarchar(50),
    dienThoai nvarchar(15),
    email     nvarchar(30),
    website   nvarchar(30)
);

create table phieuNhap
(
    soPN     nvarchar(5) primary key,
    maNV     nvarchar(4),
    maNCC    nvarchar(5),
    ngayNhap datetime default now(),
    ghiChu   nvarchar(100),
    foreign key (maNV) references nhanVien (MaNV),
    foreign key (maNCC) references nhaCungCap (maNCC)
);

create table loaiSP
(
    maLoaiSP  nvarchar(4) primary key,
    tenLoaiSP nvarchar(30),
    ghiChu    nvarchar(100)
);

create table phieuXuat
(
    soPX    nvarchar(5) primary key,
    maNV    nvarchar(4),
    maKH    nvarchar(4),
    ngayBan datetime,
    ghiChu  text,
    foreign key (maNV) references nhanVien (MaNV),
    foreign key (maKH) references khachhang (maKh)
);

create table sanPham
(
    maSP      nvarchar(4) primary key,
    maLoaiSP  nvarchar(4),
    tenSP     nvarchar(50),
    donViTinh nvarchar(10),
    ghiChu    nvarchar(100),
    foreign key (maLoaiSP) references loaiSP (maLoaiSP)
);

create table ctPhieuXuat
(
    soPX    nvarchar(5),
    maSP    nvarchar(4),
    soLuong smallint,
    giaBan  real,
    check ( soLuong >= 0 and giaBan >= 0),
    primary key (soPX, maSP),
    foreign key (soPX) references phieuXuat (soPX),
    foreign key (maSP) references sanPham (maSP)
);

create table ctPhieuNhap
(
    maSP    nvarchar(4),
    soPN    nvarchar(5),
    soLuong smallint default (0),
    giaNhap real CHECK (giaNhap > 0),
    primary key (maSP, soPN),
    foreign key (maSP) references sanPham (maSP),
    foreign key (soPN) references phieuNhap (soPN)
);

-- Thêm dữ liệu vào bảng khachhang
INSERT INTO khachhang (maKh, tenKh, diaChi, ngaySinh, soDT)
VALUES ('KH01', 'Nguyễn Văn A', 'Hà Nội', '1990-01-01', '0123456789'),
       ('KH02', 'Trần Thị B', 'Hồ Chí Minh', '1995-02-15', '0987654321'),
       ('KH03', 'Lê Văn C', 'Đà Nẵng', '1992-07-10', '0369876543'),
       ('KH04', 'Phạm Thị D', 'Hải Phòng', '1998-04-20', '0932145678'),
       ('KH05', 'Nguyễn Thị E', 'Huế', '1993-12-05', '0765432198');

-- Thêm dữ liệu vào bảng nhanVien
INSERT INTO nhanVien (MaNV, hoTen, gioiTinh, diaChi, ngaySinh, dienThoai, email, noiSinh, ngayVaoLam, maSQL)
VALUES ('NV01', 'Nguyễn Văn X', 1, 'Hà Nội', '1985-03-10', '0123456789', 'nvx@gmail.com', 'Hà Nội', '2020-01-01','SQL1'),
       ('NV02', 'Trần Thị Y', 0, 'Hồ Chí Minh', '1990-05-20', '0987654321', 'ty@gmail.com', 'Hồ Chí Minh','2021-02-15', 'SQL2'),
       ('NV03', 'Lê Văn Z', 1, 'Đà Nẵng', '1992-10-15', '0369876543', 'lvz@gmail.com', 'Đà Nẵng', '2019-07-10','SQL3'),
       ('NV04', 'Phạm Thị K', 0, 'Hải Phòng', '1998-09-05', '0932145678', 'ptk@gmail.com', 'Hải Phòng', '2022-04-20','SQL4'),
       ('NV05', 'Nguyễn Thị M', 0, 'Huế', '1995-08-25', '0765432198', 'ntm@gmail.com', 'Huế', '2023-01-01', 'SQL5');

-- Thêm dữ liệu vào bảng nhaCungCap
INSERT INTO nhaCungCap (maNCC, tenNCC, diaChi, dienThoai, email, website)
VALUES ('NCC1', 'Công ty A', 'Hà Nội', '0123456789', 'ctyA@gmail.com', 'www.congtyA.com'),
       ('NCC2', 'Công ty B', 'Hồ Chí Minh', '0987654321', 'ctyB@gmail.com', 'www.congtyB.com'),
       ('NCC3', 'Công ty C', 'Đà Nẵng', '0369876543', 'ctyC@gmail.com', 'www.congtyC.com'),
       ('NCC4', 'Công ty D', 'Hải Phòng', '0932145678', 'ctyD@gmail.com', 'www.congtyD.com'),
       ('NCC5', 'Công ty E', 'Huế', '0765432198', 'ctyE@gmail.com', 'www.congtyE.com');

-- Thêm dữ liệu vào bảng phieuNhap
INSERT INTO phieuNhap (soPN, maNV, maNCC, ngayNhap, ghiChu)
VALUES ('PN01', 'NV01', 'NCC1', '2023-06-01', 'Ghi chú phiếu nhập 1'),
       ('PN02', 'NV02', 'NCC2', '2023-06-02', 'Ghi chú phiếu nhập 2'),
       ('PN03', 'NV03', 'NCC3', '2023-06-03', 'Ghi chú phiếu nhập 3'),
       ('PN04', 'NV04', 'NCC4', '2023-06-04', 'Ghi chú phiếu nhập 4'),
       ('PN05', 'NV05', 'NCC5', '2023-06-05', 'Ghi chú phiếu nhập 5');

-- Thêm dữ liệu vào bảng loaiSP
INSERT INTO loaiSP (maLoaiSP, tenLoaiSP, ghiChu)
VALUES ('LSP1', 'Loại sản phẩm 1', 'Ghi chú loại sản phẩm 1'),
       ('LSP2', 'Loại sản phẩm 2', 'Ghi chú loại sản phẩm 2'),
       ('LSP3', 'Loại sản phẩm 3', 'Ghi chú loại sản phẩm 3'),
       ('LSP4', 'Loại sản phẩm 4', 'Ghi chú loại sản phẩm 4'),
       ('LSP5', 'Loại sản phẩm 5', 'Ghi chú loại sản phẩm 5');

-- Thêm dữ liệu vào bảng phieuXuat
INSERT INTO phieuXuat (soPX, maNV, maKH, ngayBan, ghiChu)
VALUES ('PX001', 'NV01', 'KH01', '2023-07-01', 'Ghi chú phiếu xuất 1'),
       ('PX002', 'NV02', 'KH02', '2023-07-02', 'Ghi chú phiếu xuất 2'),
       ('PX003', 'NV03', 'KH03', '2023-07-03', 'Ghi chú phiếu xuất 3'),
       ('PX004', 'NV04', 'KH04', '2023-07-04', 'Ghi chú phiếu xuất 4'),
       ('PX005', 'NV05', 'KH05', '2023-07-05', 'Ghi chú phiếu xuất 5');

-- Thêm dữ liệu vào bảng sanPham
INSERT INTO sanPham (maSP, maLoaiSP, tenSP, donViTinh, ghiChu)
VALUES ('SP01', 'LSP1', 'Sản phẩm 1', 'Cái', 'Ghi chú sản phẩm 1'),
       ('SP02', 'LSP2', 'Sản phẩm 2', 'Hộp', 'Ghi chú sản phẩm 2'),
       ('SP03', 'LSP3', 'Sản phẩm 3', 'Chai', 'Ghi chú sản phẩm 3'),
       ('SP04', 'LSP4', 'Sản phẩm 4', 'Thùng', 'Ghi chú sản phẩm 4'),
       ('SP05', 'LSP5', 'Sản phẩm 5', 'Gói', 'Ghi chú sản phẩm 5');

-- Thêm dữ liệu vào bảng ctPhieuXuat
INSERT INTO ctPhieuXuat (soPX, maSP, soLuong, giaBan)
VALUES ('PX001', 'SP01', 10, 100000),
       ('PX002', 'SP02', 5, 200000),
       ('PX003', 'SP03', 8, 150000),
       ('PX004', 'SP04', 15, 50000),
       ('PX005', 'SP05', 20, 30000);

-- Thêm dữ liệu vào bảng ctPhieuNhap
INSERT INTO ctPhieuNhap (maSP, soPN, soLuong, giaNhap)
VALUES ('SP01', 'PN01', 50, 90000),
       ('SP02', 'PN01', 30, 180000),
       ('SP03', 'PN02', 25, 120000),
       ('SP04', 'PN02', 40, 60000),
       ('SP05', 'PN03', 60, 40000);
