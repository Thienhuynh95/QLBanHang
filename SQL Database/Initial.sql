use master
go
drop database Sales_Mng
go
create database Sales_Mng
go
use Sales_Mng
go
create table Customer
(
	CustID nvarchar(20) NOT NULL primary key,
	CustName nvarchar(50) NOT NULL,
	Addres nvarchar(50),
	Phone nvarchar(20),
	Fax nvarchar(20),
	Email nvarchar(50),
	Overdue int default 0,
	Amount decimal(13,1),
	OverdueAmt decimal(13,1),
	DueAmt decimal(13,1), 
	Stat nvarchar(2) check (Stat = 'DE'OR Stat='AV' OR Stat = 'UA'),
	Descript nvarchar(200)
)
go
create table InvoiceType
(
	InvoiceType nvarchar(2) primary key check(InvoiceType = 'ND' OR InvoiceType = 'NT' OR InvoiceType = 'IN' OR InvoiceType = 'CM' OR InvoiceType = 'NP' OR InvoiceType = 'NM'),
	TypeName nvarchar(50) NOT NULL
)
go
create table Unit
(
	UnitID int identity(1,1) primary key,
	UnitName nvarchar(50)
)
go
create table SalesPerson
(
	SalesPersonID int identity(1,1) primary key,
	SalesPersonName nvarchar(50) NOT NULL,
	Addres nvarchar(50),
	Phone nvarchar(20),
	Email nvarchar(50),
	Salary float,
	Pos nvarchar(20) check (Pos = N'Trưởng Phòng' OR Pos = N'Nhân viên'),
	LimitEarning int,
	Stat nvarchar(2) check (Stat = 'DE'OR Stat='AV' OR Stat = 'UA'),
	Descript nvarchar(200)
)
go
create table Vendor
(
	VendorID nvarchar(20) primary key,
	VendorName nvarchar(50) NOT NULL,
	Addres nvarchar(50),
	Email nvarchar(50),
	Phone nvarchar(20),
	Fax nvarchar(20),
	DueAmt decimal(13,1),
	Amount decimal(13,1),
	OverdueAmt decimal(13,1),
	Stat nvarchar(2) check (Stat = 'DE'OR Stat='AV' OR Stat = 'UA'),
	Descript nvarchar(200)
)
go
create table GroupUser
(
	GroupID int identity(1,1) primary key,
	GroupName nvarchar(20)
)
go
create table Users
(
	UserID int identity(1,1) NOT NULL references SalesPerson(SalesPersonID),
	UserName nvarchar(20) NOT NULL,
	Pass nvarchar(30) NOT NULL,
	GroupID int NOT NULL references GroupUser(GroupID)
)
go
create table Inventory
(
	InvtID nvarchar(20) NOT NULL primary key,
	InvtName nvarchar(50) NOT NULL,
	ClassName nvarchar,
	UnitID_T int NOT NULL foreign key references Unit(UnitID),
	UnitID_L int NOT NULL foreign key references Unit(UnitID),
	UnitRate int NOT NULL,
	SalesPriceT decimal(13,1),
	SalePriceL decimal(13,1),
	QtyStock int,
	SlsTax decimal(13,1),
	Stat nvarchar(2) check(Stat = 'DE'OR Stat='AV' OR Stat = 'UA'),
	Descript nvarchar(200)
)
go

create table SalesOrder
(
	OrderNo nvarchar(20) NOT NULL primary key,
	OrderDate Date,
	InvoiceType nvarchar(2) foreign key references InvoiceType(InvoiceType),
	CustID nvarchar(20) foreign key references Customer(CustID),
	OverdueDate Date,
	OrderDisc decimal(13,1),
	TaxAmt decimal(13,1),
	TotalAmt decimal(13,1),
	Payment decimal(13,1),
	Debt decimal(13,1),
	Descript nvarchar(200),
	Del int default 0
)
go
create table SlsOrderDetail
(
	ID int identity(1,1) primary key,
	OrderNo nvarchar(20) NOT NULL foreign key references SalesOrder(OrderNo),
	InvtID nvarchar(20) NOT NULL foreign key references Inventory(InvtID),
	Qty int,
	SalesPrice decimal(13,1),
	Discount decimal(13,1),
	TaxAmt decimal(13,1),
	Amount decimal(13,1),
	Del int default 0
)
go
create table Payment
(
	PaymentID int identity(1,1) primary key,
	PaymentNo nvarchar(20) NOT NULL,
	PaymentDate Date,
	PaymentAmt decimal(13,1),
	CustID nvarchar(20) foreign key references Customer(CustID),
	SalesPersonID int NOT NULL foreign key references SalesPerson(SalesPersonID),
	Descript nvarchar(200),
	Del int default 0
)
go
create table StockTransfer
(
	TransID nvarchar(20) primary key,
	TransDate Date,
	FromStockID nvarchar(20) NOT NULL,
	ToStockID nvarchar(20) NOT NULL,
	TotalAmt decimal(13,1),
	Descript nvarchar(200)
)
go
create table StkTransDetail
(
	TransID nvarchar(20) NOT NULL foreign key references StockTransfer(TransID),
	InvtID nvarchar(20) NOT NULL foreign key references Inventory(InvtID),
	Qty int,
	Amount decimal(13,1)
)
go
alter table StkTransDetail
	add constraint pk_StkTransDetail primary key (TransID,InvtID)
go
create table PurchaseOrder
(
	OrderNo nvarchar(20) primary key,
	OrderDate Date,
	OrderType nvarchar(2) check(OrderType = 'PO'OR OrderType='PR'),
	OverdueDate int,
	DiscAmt decimal(13,1),
	PromAmt decimal(13,1),
	ComAmt decimal(13,1),
	TaxAmt decimal(13,1),
	TotalAmt decimal(13,1),
	TransferID nvarchar(20),
	MoneyTransfer int,
	DateTransfer Datetime,
	Descript nvarchar(50),
	Del int default 0
)
go
create table PurchaseOrdDetail
(
	OrderNo nvarchar(20) NOT NULL references PurchaseOrder(OrderNo),
	InvtID nvarchar(20) NOT NULL references Inventory(InvtID),
	Qty int,
	PurchasePrice decimal(13,1),
	StockID int NOT NULL,
	QtyProm int,
	QtyPromAmt decimal(13,1),
	AmtProm decimal(13,1),
	TaxAmt decimal(13,1),
	Amount decimal(13,1),
	Del int default 0
)
go
alter table PurchaseOrdDetail
	add constraint pk_PurchaseOrdDetail primary key (OrderNo,InvtID)
go
create table InventoryCheck
(
	CheckID int identity(1,1) primary key NOT NULL,
	CheckDate Datetime,
	Descript nvarchar(50),
	Del int default 0
)
go
create table InventChkDetail
(
	CheckID int identity(1,1) NOT NULL references InventoryCheck(CheckID),
	InvtID nvarchar(20) NOT NULL references Inventory(InvtID),
	Qty int,
	Descript nvarchar(50),
	Del int default 0
)
alter table InventChkDetail
	add constraint pk_IventChk_Detail primary key (CheckID,InvtID)