--Table Customer
insert into Customer(CustID,CustName,Addres,Phone,Email,Stat,Descript,Overdue) values 
('Cus1','Nguyen Van A','27/12/29 Dien bien phu','01992834592','nguyenvana27@yahoo.com','AV','',''),
('Cus2','Tran Van Be','23/9E Tran Van Dang','0244788592','TranVanBe@yahoo.com','AV','',''),
('Cus3','Pha Thien Phu','37/9 Ngo Thua An','0133574592','PhaThienPhu@yahoo.com','AV','',''),
('Cus4','Tru Thien Tan','617/12/29 Tran Nhat Duat','01232834592','TruThienTan@yahoo.com','AV','',''),
('Cus5','Phan Thien Hong','217/12/29 Tran Binh Trong','01623834592','PhanThienHong27@yahoo.com','AV','',''),
('Cus6','Ngo Nhat Tan','262/1/19 Nguyen Binh Khiem','019964534592','NgoNhatTan@yahoo.com','AV','',''),
('Cus7','Do Minh Quang','276/122/2 Tran Dinh Tung','019235834592','DoMinhQuang@yahoo.com','AV','',''),
('Cus8','Tran The Phong','271/12/2E Phan Trong Dinh','01923834592','TranThePhong@yahoo.com','AV','','')

--Table GroupUser
insert into GroupUser(GroupName) values 
(N'Nhà  Phân Phối'),
(N'Kế Toán'),
(N'Thủ Kho'),
(N'Nhân Viên Bán Hàng')

--Table InvoiceType
insert into InvoiceType(InvoiceType,TypeName) values 
('ND',N'NPP xuất hàng cho NVBH'),
('NT',N'NVBH trả lại hàng cho NPP'),
('IN',N'Bán hàng cho khách hàng trả tiền ngay'),
('CM',N'Trả lại của đơn hàng IN'),
('NP',N'NVBH bán hàng cho khách hàng'),
('NM',N'Khách hàng trả lại hàng cho NVBH')

--Table Unit
insert into Unit(UnitName) values 
(N'kg'),
(N'Pound'),
(N'cái'),
(N'thùng'),
(N'hộp')
--Table SalesPerson

--Table Users

--Table Inventory

--Table SalesOrder

--Table SlsOrderDetail

--Table Payment

--Table PurchaseOrder

--Table PurchaseOrdDetail

--Table InventoryCheck

--Table InventChkDetail