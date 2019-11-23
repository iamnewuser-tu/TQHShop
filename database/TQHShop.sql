use master 
go

IF EXISTS(select * from sys.databases where name='THQShop')
DROP DATABASE THQShop

create database THQShop
go

use THQShop
go

--Status 0: FALSE, 1: TRUE

create table Categories
(
	categoryId varchar(10) primary key,
	categoryName nvarchar(100),
	categoryDesc nvarchar(500),
	categoryStatus bit,
	categoryIcon varchar(200)
)
go

create table ProductTypes
(
	typeId varchar(10) primary key,
	categoryId varchar(10) foreign key references Categories(categoryId),
	typeName nvarchar(50) unique,
	typeDesc nvarchar(300),
	typeIcon varchar(200),
	typeStatus bit 
)
go

create table Users
(
	userId varchar(30) primary key,
	[password] varchar(20),
	email varchar(50),
	fullname nvarchar(100),
	phone varchar(20),
	[role] varchar(20), --select box for seller or customer
	userStatus bit --manage user is banned or not.
)
go

create table Customers
(
	userId varchar(30) foreign key references Users(userId) primary key,
	dob varchar(50),
	gender varchar(10),
	[address] nvarchar(1000),
	point int
)
go

create table Seller
(
	userId varchar(30) foreign key references Users(userId) primary key,
	storeName nvarchar(1000),
	identityCard varchar(20), -- CMND -- unseen on Customer
	approvedDate varchar(50), -- CMND approved date -- unseen on Customer
	approvedPlace nvarchar(100), -- CMND approved place -- unseen on Customer
	storeAddress nvarchar(100), -- unseen on Customer
	storeIcon varchar(200), 
	storeSummary nvarchar(1000)
)
go

create table Brands
(
	brandId varchar(10) primary key,
	brandName nvarchar(100),
	brandIcon varchar(200),
	brandStatus bit 
)
go

create table Products
(
	productId varchar(10) primary key,
	typeId varchar(10) foreign key references ProductTypes(typeId),
	userId varchar(30) foreign key references Users(userId),
	brandId varchar(10) foreign key references Brands(brandId),
	productName nvarchar(500),
	productDesc nvarchar(3500),
	productSummary nvarchar(1000),
	productPrice float,
	productUnit nvarchar(50),
	productWeight	float,
	productWidth	float,
	productHeigth	float,
	productLength	float,
	productQuantity int,
	productImage varchar(4000),
	productDiscount int,
	productRating float,
	isApproved bit,
	datePosted datetime not null default getdate(),
	votedUsers varchar(4000),
	productStatus bit
)
go



create table ProductRating 
(
	productId varchar(10) foreign key references Products(productId),
	ratingPoint int,
	[count] int,
	primary key (productId, ratingPoint)
)
go

create table ProductsEditHistory
(
	productId varchar(10) foreign key references Products(productId),
	[version] int,
	productName nvarchar(500),
	productPrice float,
	productDiscount int,
	editTime datetime not null default getdate(),
	primary key([version], productId)
)
go

create table ProductsComment
(
	commentID varchar(10) primary key,
	userId varchar(30) foreign key references Users(userId),
	productId varchar(10) foreign key references Products(productId),
	commentContent nvarchar(3000),
	commentStatus bit
)
go

create table OrderMaster
(
	orderMId	varchar(10) primary key,
	userId varchar(30) foreign key references Users(userId),
	orderTotalPrice float,
	DeliveryPrice float,
	orderNote	nvarchar(1000),
	orderStatus	varchar(10), --Processing , Cancelled , Delievery , Done
	dateOrdered	datetime not null default getdate()
)
go

create table OrderDetails
(
	orderMId	varchar(10) foreign key references OrderMaster(orderMId),
	productId varchar(10) foreign key references Products(productId),
	quantity	int,
	primary key(orderMId,productId)
)
go

create table OrderAddress
(
	orderMId	varchar(10) foreign key references OrderMaster(orderMid) primary key,
	userId varchar(30) foreign key references Users(userId),
	orderAddressLat float,
	orderAddressLng	float,
	orderAddressDetail	nvarchar(1000),
	orderPhone varchar(20)
)
go

use THQShop
go

-- Users
insert into Users VALUES('admin','admin','THQShop.tatyuky@gmail.com',N'Tiến','0909882230','admin',1);
insert into Users VALUES('raejas','raejas','THQShop.raejas@gmail.com',N'Huân','0937752028','admin',1);
insert into Users VALUES('venky','venky','THQShop.venky@gmail.com',N'Vương','0909882230','admin',1);
insert into Users VALUES('uypoko','uypoko','THQShop.uypoko@gmail.com',N'Uy','0909882230','admin',1);
insert into Users VALUES('tuyetbich','123456','tuyetbich123@mailinator.com',N'Tuyết','0909882231','customer',1);
insert into Users VALUES('tungchaien','123456','tungchaien456@mailinator.com',N'Tùng','0909882232','customer',1);
insert into Users VALUES('ducchau','123456','ducchau778899@mailinator.com',N'Đức','0909882233','customer',1);
insert into Users VALUES('dieunhi','123456','dieunhi998877@mailinator.com',N'Nhi','0909882234','customer',1);
insert into Users VALUES('thixuka','123456','thixukaaa1@mailinator.com',N'Thi','0909882235','customer',1);
insert into Users VALUES('rainyday','123456','rainydayyy1@mailinator.com',N'Danny','0909882236','customer',1);
insert into Users VALUES('linhnhi','123456','linhnhinhanhhh111@mailinator.com',N'Linh','0909882237','customer',1);
insert into Users VALUES('tuanka','123456','tuankaa@mailinator.com',N'Tuấn','0909882238','customer',1);
insert into Users VALUES('HungDung','123456','hungg@mailinator.com',N'Hùng','0909882239','customer',1);
insert into Users VALUES('Thanh','123456','thanhh@mailinator.com',N'Thành','0909882240','customer',1);
insert into Users VALUES('Giangnhi','123456','gianng@mailinator.com',N'Giang','0909882241','customer',1);
insert into Users VALUES('dave','123456','daviddda@mailinator.com',N'David','0909882242','customer',1);
insert into Users VALUES('josh','123456','joshuaaad@mailinator.com',N'Joshua','0909882243','customer',1);
insert into Users VALUES('quocanh','123abca','quocanhhnhn@mailinator.com',N'Quốc Anh','0909882244','seller',1);
insert into Users VALUES('tienminh','123abca','tienminhh@mailinator.com',N'Minh Tiến','0909882245','seller',1);
insert into Users VALUES('thanhlong','123abca','thanhlongg@mailinator.com',N'Long Thành','0909882246','seller',1);
insert into Users VALUES('lylienkiet','123abca','lylienkiett@mailinator.com',N'Thành Kiệt','0909882247','seller',1);
insert into Users VALUES('uyenle','123abca','uyenlee@mailinator.com',N'Lê Uyên','0909882248','seller',1);
insert into Users VALUES('andy','123abca','andytruongg@mailinator.com',N'Andy','0909882249','seller',1);
insert into Users VALUES('kenny','123abca','kennyyy@mailinator.com',N'Kenny','0909882250','seller',1);
insert into Users VALUES('sonmai','123abca','sonmaiii@mailinator.com',N'Mai Sơn','0909882251','seller',1);
insert into Users VALUES('ringu','123abca','ringuuu@mailinator.com',N'Ring','0909882252','seller',1);
insert into Users VALUES('taidy','123abca','taidyyy@mailinator.com',N'Tai','0909882253','seller',1);


-- Customers
insert into Customers VALUES('tuyetbich','10/05/1990','female',N'07 Phan Đăng Lưu q.Bình Thạnh',135);
insert into Customers VALUES('tungchaien','12/12/1993','male',N'171 Phạm Văn Đồng q.Gò Vấp',29);
insert into Customers VALUES('ducchau','10/05/1990','male',N'172 Phạm Văn Đồng q.Gò Vấp',78);
insert into Customers VALUES('dieunhi','08/28/1993','female',N'173 Phạm Văn Đồng q.Gò Vấp',27);
insert into Customers VALUES('thixuka','08/05/1987','female',N'174 Phạm Văn Đồng q.Gò Vấp',70);
insert into Customers VALUES('rainyday','02/17/1989','male',N'175 Phạm Văn Đồng q.Gò Vấp',54);
insert into Customers VALUES('linhnhi','07/12/1990','female',N'176 Phạm Văn Đồng q.Gò Vấp',55);
insert into Customers VALUES('tuanka','04/22/1994','male',N'177 Phạm Văn Đồng q.Gò Vấp',45);
insert into Customers VALUES('HungDung','11/02/1990','male',N'178 Phạm Văn Đồng q.Gò Vấp',34);
insert into Customers VALUES('Thanh','12/13/1990','female',N'179 Phạm Văn Đồng q.Gò Vấp',58);
insert into Customers VALUES('Giangnhi','07/16/1990','female',N'180 Phạm Văn Đồng q.Gò Vấp',11);
insert into Customers VALUES('dave','12/18/1990','male',N'181 Phạm Văn Đồng q.Gò Vấp',67);
insert into Customers VALUES('josh','05/09/1990','male',N'182 Phạm Văn Đồng q.Gò Vấp',72);


-- Seller
insert into Seller VALUES('quocanh','Quoc Anh store','121245939','08/28/1993','TP.HCM',N'300 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Quoc Anh store - Selling beautiful and useful stuffs');
insert into Seller VALUES('tienminh','Venky company','121245940','08/05/1987','TP.HCM',N'301 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Venky company - Selling beautiful and useful stuffs');
insert into Seller VALUES('thanhlong','Longthanh Company','121245941','02/17/1989','TP.HCM',N'302 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Longthanh Company - Selling beautiful and useful stuffs');
insert into Seller VALUES('lylienkiet','LLK Technology','121245942','07/12/1990','TP.HCM',N'303 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','LLK Technology - Selling beautiful and useful stuffs');
insert into Seller VALUES('uyenle','UL Corp','121245943','04/22/1994','TP.HCM',N'304 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','UL Corp - Selling beautiful and useful stuffs');
insert into Seller VALUES('andy','NamemaN Corp','121245944','11/02/1990','TP.HCM',N'305 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','NamemaN Corp - Selling beautiful and useful stuffs');
insert into Seller VALUES('kenny','Kenny shop','121245945','12/13/1990','TP.HCM',N'306 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Kenny shop - Selling beautiful and useful stuffs');
insert into Seller VALUES('sonmai','Son gift','121245946','07/16/1990','TP.HCM',N'307 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Son gift - Selling beautiful and useful stuffs');
insert into Seller VALUES('ringu','Reajas Company','121245947','12/18/1990','TP.HCM',N'308 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','Reajas Company - Selling beautiful and useful stuffs');
insert into Seller VALUES('taidy','ABC Technology','121245948','12/12/1993','TP.HCM',N'309 Điện Biên Phủ, phường 15, quận Bình Thạnh','http://simpleicon.com/wp-content/uploads/shop-5-64x64.png','ABC Technology - Selling beautiful and useful stuffs');

-- Categories
insert into Categories values('CAT001','Computers','Tool and devices for computers',1,'http://computeraid.org/wp-content/uploads/2017/01/open-laptop-computer.png'),
								('CAT002','Laptops','Devices support for compiters',1,'http://graphiccave.com/wp-content/uploads/2015/04/Laptop-Illustration-PNG-Graphic-Cave.png'),
								('CAT003','Cellphones','Accessories for cellphones',1,'https://cdn2.iconfinder.com/data/icons/gadget-linicons/100/iPhone-512.png'),
								('CAT004','Smart Home','Automation tool for smart home',1,'https://d30y9cdsu7xlg0.cloudfront.net/png/132885-200.png'),
								('CAT005','Smart Toys','Cool stuffs for your life to enjoy',1,'https://cdn.shopify.com/s/files/1/2229/9277/files/shopify_header_logo-01-01-01-01.png?v=1502169034'),
								('CAT006','Others','Other stuffs',1,'http://pngimages.net/sites/default/files/question-mark-logo-png-image-80272.png')
go

-- Product Types
insert into ProductTypes values('PTY001','CAT001','Storage Devices',N'Devices store data for computer','https://www.shareicon.net/data/2016/08/05/807419_refresh_512x512.png',1),
							  ('PTY002','CAT001','Network Devices',N'Devices connect to internet or create intranet','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScwa5nwWlritFu_v7Z9akiL4rRIy3Ao5fWVwgft25-QalBe1efgw',1),
							  ('PTY003','CAT001','Peripheral Devices',N'Devices utilize to increases performance and user interactions for computer','https://cdn4.iconfinder.com/data/icons/computer-hardware-2/80/Computer_hardware_icons-04-512.png',1),
							  ('PTY004','CAT002','Laptop Bags',N'Bag contain laptops','https://cdn1.iconfinder.com/data/icons/mini-solid-icons-vol-3/16/133-512.png',1),
							  ('PTY005','CAT002','Peripheral','Devices support for laptops','https://cdn2.iconfinder.com/data/icons/system-icons/512/489744-Mouse-512.png',1),
							  ('PTY006','CAT002','Fan',N'Cooling Fan for desktop','https://cdn1.iconfinder.com/data/icons/computer-hardware-4/512/cpu_fan-512.png',1),
							  ('PTY007','CAT003','Card Reader',N'Card Reader for SD for Cell phones','https://www.iconshock.com/v2/image/RealVista/Computer_gadgets/usb_card_reader',1),
							  ('PTY008','CAT003','Pin / Charger',N'Charger for cell phones','http://www.pvhc.net/img238/jqnxrlcginjfvoqjfckx.png',1),
							  ('PTY009','CAT003','Cellphone Bags',N'Bags contain cellphones','http://www.freeiconspng.com/uploads/case-for-phone-communication-mobile-telephone-icon-10.png',1),
							  ('PTY010','CAT003','Headphones',N'Headphones','https://d30y9cdsu7xlg0.cloudfront.net/png/17471-200.png',1),
							  ('PTY011','CAT003','Bluetooth',N'Bluetooth devices support','https://cdn4.iconfinder.com/data/icons/network-and-sharing-1/60/bluetooth_circle-512.png',1),
							  ('PTY012','CAT004','Home Appliances',N'Support tools for home','http://cdn.onlinewebfonts.com/svg/img_370370.png',1),
							  ('PTY013','CAT004','Home Automation',N'Automation support for home','https://d30y9cdsu7xlg0.cloudfront.net/png/55027-200.png',1),
							  ('PTY014','CAT004','Cleaning',N'Cleaning tool for house','https://cdn2.iconfinder.com/data/icons/at-the-office/100/mop-512.png',1),
							  ('PTY015','CAT005','Gifts',N'Gifts','https://d30y9cdsu7xlg0.cloudfront.net/png/13360-200.png',1),
							  ('PTY016','CAT005','Electronic Stuffs',N'Cool electronic stuffs','http://icons.iconarchive.com/icons/icons8/ios7/256/Industry-Electronics-icon.png',1),
							  ('PTY017','CAT006','Others',N'Others stuffs','http://pngimages.net/sites/default/files/question-mark-logo-png-image-80272.png',1)
go

-- Brands
insert into Brands values
('BRN001','Western Digital','https://rocketdock.com/images/screenshots/Untitled-8.png',1),
('BRN002','Transcend','http://freelogo2016cdn.b-cdn.net/wp-content/uploads/2016/12/transcend-logo.png',1),
('BRN003','Kingston','http://in-queue.com/lamps/wp-content/uploads/2012/10/kingston_icon1.png',1),
('BRN004','LinkSprinter','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN005','Anker','https://d1bdmzehmfm4xb.cloudfront.net/original/3X/c/2/c2141320bf35fb216201569cd07da51a2c57c11e.png',1),
('BRN006','Ring','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN007','IOGEAR','https://images.anandtech.com/doci/8887/iogear_678x452.png',1),
('BRN008','Weme','http://www.weme.nu/imagens/logo-weme.png',1),
('BRN009','UGREEN','https://static.raru.co.za/news/header/4423.png?v=1498731250',1),
('BRN010','Taidy','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN011','Mosiso','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN012','CoolBELL','https://macrotronics.net/images/coolbell-logo.jpg',1),
('BRN013','ZOZO','https://cdn.dribbble.com/users/19868/screenshots/178182/logo_logo_zozo.png',1),
('BRN014','StarTech','http://logo-load.com/uploads/posts/2016-08/startech-logo.png',1),
('BRN015','Macally','https://c2.staticflickr.com/4/3576/3406172572_75411c1046.jpg',1),
('BRN016','Wind Speed','http://windspeedmonitoring.com/wp-content/uploads/2014/05/Windspeedmonitoring_Final_72.png',1),
('BRN017','HAVIT','https://www.electroon.com/shop/images/feature_variant/4/HAVIT.png',1),
('BRN018','Tenswall','https://cdn3.f-cdn.com/contestentries/721274/20662098/57b31ea8d1ce9_thumb900.jpg',1),
('BRN019','Acuvar','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN020','Wasserstein','https://s3.amazonaws.com/owler-image/logo/wasserstein-_owler_20160227_004930_original.png',1),
('BRN021','Exxact','https://insidehpc.com/wp-content/uploads/2016/06/exxact.jpg',1),
('BRN022','Wandlemate','https://images-na.ssl-images-amazon.com/images/I/41jpOdEC9FL.jpg',1),
('BRN023','Kobert','http://www.kobert.my/uploads/images/1482906682_20161221-kobert-new-logo.jpg',1),
('BRN024','KISS GOLD','http://cdn2.bigcommerce.com/n-arxsrf/5uke1sua/products/17594/images/17302/s7945m__12990.1432080535.220.220.jpg?c=2',1),
('BRN025','Otium','https://pbs.twimg.com/profile_images/639721284381749248/3lWVAUVB_400x400.jpg',1),
('BRN026','Mpow','http://geeknewscentral.com/wp-content/uploads/2015/10/logo.gif',1),
('BRN027','SoundPEATS','https://mark.trademarkia.com/logo-images/shenzhen-soundsoul-information-technology-co/soundpeats-86344272.jpg',1),
('BRN028','LinkS','http://cubo.org.uk/conference/logos/links_logo.jpg',1),
('BRN029','SOAIY','http://s.globalsources.com/IMAGES/SPL/LOGO/652/L8849679652.jpg',1),
('BRN030','Presto','https://seeklogo.com/images/P/presto-logo-3B42A2B53C-seeklogo.com.gif',1),
('BRN031','Collections ETC','https://www.shopathome.com/images/merchantlogos/collections-etc.jpg',1),
('BRN032','ThermoPro','https://cdn.shopify.com/s/files/1/1494/6186/files/thermopro-logo_large.png?v=1474602750',1),
('BRN033','Wink Relay','https://www.winkapp.com/assets/mediakit/wink-logo-d4501f9a934cb790be4972d913e58120.png',1),
('BRN034','BOND','https://www.bondbrandloyalty.com/content/img/shared/logoLarge.jpg',1),
('BRN035','kitchenhoney','https://www.britishlogodesign.co.uk/wp-content/uploads/2017/10/kitchens-logo-design-3.jpg',1),
('BRN036','Electric Spin','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUasYoynqxnK7UNhEcxIBxfBs6Nb1bKKMJv6Y9PIJjOrPRqJkJ',1),
('BRN037','RotoScrub','https://mark.trademarkia.com/logo-images/js2-enterprises/rotoscrub-87245843.jpg',1),
('BRN038','GermGuardian','http://www.centralvacuumstores.com/meta/images/sm/clean_air/germ-guardian-logo.jpg',1),
('BRN039','LIGHTBOWL','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN040','Duck Money Soap','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN041','Onlywax','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN042','Threeking','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN043','SmartLab','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN044','SGILE','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN045','Sophia Rose Jewellery ','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN046','Bottled Up Designs ','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1),
('BRN047','Cardtorial','http://fpttelecom.online/wp-content/uploads/2017/05/Newicon-tinh.png',1)
go

-- Products
insert into Products values     
('PRO001','PTY001','admin','BRN001',N'WD My Passport Ultra 3TB Portable External',N'<div><h3>Product Details</h3><div></div></div>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tbody>
				<tr>
						<td colspan="2"><span>Product Description</span>
		</td>
					</tr>
					<tr>
						<td colspan="2">
						<span>This Western Digital My Passport Ultra drive is an excellent storage solution for users who travel often. The My Passport Ultra model offers 3 TB storage space for digital content and data backup. This external drive connects and powers through USB 2.0 and USB 3.0 interfaces. It offers cloud storage and can be charged via a USB port. This disk is designed for PC. The dimensions of this storage unit are 0.83 inch height, 3.21 inch width, 4.33 inch depth, and its weight is 0.5 lb.</span>
		</td>
					</tr>
					<tr >
						<td><br></td>
					</tr>
				<tr>
						<td colspan="2"><span >Product Identifiers</span>
		</td>
					</tr>
					<tr>
						<td width="35%" valign="top">Brand</td>
						<td width="65%" valign="top">
						Western Digital</td>
					</tr>
					<tr>
						<td width="35%" valign="top">Model</td>
						<td width="65%" valign="top">
						My Passport Ultra</td>
					</tr>
					<tr>
						<td width="35%" valign="top">UPC</td>
						<td width="65%" valign="top">
						718037838199</td>
					</tr>
					<tr class="br">
						<td><br class="br"></td>
					</tr>
				<tr>
						<td colspan="2"><span class="product-details-title">Key Features</span>
		</td>
					</tr>
					<tr>
						<td width="35%" valign="top">Capacity</td>
						<td width="65%" valign="top">
						3TB</td>
					</tr>
					<tr>
						<td width="35%" valign="top">Hard Drive Type</td>
						<td width="65%" valign="top">
						Portable</td>
					</tr>
					<tr>
						<td width="35%" valign="top">Interface</td>
						<td width="65%" valign="top">
						USB 2.0, USB 3.0</td>
					</tr>
					<tr class="br">
						<td><br class="br"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
',N'This Western Digital My Passport Ultra drive is an excellent storage solution for users who travel often. The My Passport Ultra model offers 3 TB storage space for digital content and data backup. This external drive connects and powers through USB 2.0 and USB 3.0 interfaces. It offers cloud storage and can be charged via a USB port. This disk is designed for PC. The dimensions of this storage unit are 0.83 inch height, 3.21 inch width, 4.33 inch depth, and its weight is 0.5 lb. ',450,'item', 5.0, 8.0, 34.0, 65.0, 8,'https://cdn.pbrd.co/images/GZU9Ysu.jpg,https://cdn.pbrd.co/images/GZUax1x.jpg,https://cdn.pbrd.co/images/GZUaLPF.jpg,https://cdn.pbrd.co/images/GZUbknt.jpg, https://cdn.pbrd.co/images/GZUbxqh.jpg',0,3.0,1,'20171204 10:34:09','tuyetbich',1),

('PRO002','PTY001','admin','BRN002',N'Transcend 1TB StoreJet 25H3 USB 3.0 HDD External',N'<div ><ul><li>Wireless storage for cameras and drones</li> <li>One-touch SD card copy</li> <li>4K streaming over 802.11ac Wi-Fi</li> <li>All-day battery life (up to 10 hours)</li> <li>USB port to import from card readers</li> <li>Built-in power bank to charge devices</li> <li>Works with PC and Mac computers</li> <li>My Cloud mobile app to access content<br></li></ul></div>
        <div >
            <h5>
                Strong Wi-Fi Performance
            </h5>
            <p>Built with 802.11ac technology, you get fast performance for smooth streaming, &nbsp;wireless image transfers from a compatible camera and quick editing with a connected tablet or laptop.&nbsp;</p>
            <h5>
                Save Time With SD 3.0
            </h5>
            <p> Equipped with an integrated SD 3.0 card reader to offload or copy photos and videos from your camera’s SD card and create a workflow that keeps you moving.</p>
            <h5>
                All-day Battery Life
            </h5>
            <p> With a battery that provides up to 10 hours of continuous use<sup><a href="#footnote">1</a></sup>, you stay in the field longer. Bring it on an all-day photo shoot to keep your photos backed up and mobile devices powered</p>
        </div>
',N'Wireless storage for cameras and drones.',470 ,'item', 5.1, 2.3, 4.6, 3.7, 10, 'https://cdn.pbrd.co/images/GZUenZ3.jpg,https://cdn.pbrd.co/images/GZUeANq.jpg,https://cdn.pbrd.co/images/GZUeSRh.jpg,https://cdn.pbrd.co/images/GZUf1QV.jpg,https://cdn.pbrd.co/images/GZUfaPa.jpg', 0, 4.5, 1,'20171204 10:40:09','tuyetbich',1),

('PRO003','PTY001','admin','BRN003',N'Kingston DataTraveler 100 G3',N'<div>
            <h1>DataTraveler 100 G3</h1>
            <div>
                <p>Kingston&rsquo;s DataTraveler&reg; 100 G3 (DT100G3) USB Flash drive is compliant with next-generation USB 3.0 specifications to take advantage of technology in newer notebooks, desktop PCs and digital devices. DT100G3 makes storing and transferring documents, presentations, music, video and more quicker and easier than ever<br /><br />DT100G3 features a sleek, cost-effective design to make the transition to a satisfying USB 3.0 experience a minimal investment. Available in capacities from 16GB&ndash;128GB, DT100G3 is backward compatible with USB 2.0 and has five-year warranty. Future-proof your portable storage now!</p>
            </div>
            <div>
                <p style="font-size: 13px;"><strong>Features</strong></p>
                <ul>
                    <li>Compliant &ndash; with USB 3.0 specifications</li>
                    <li>Dual Compatibility &ndash; USB 3.0 connectivity; backwards compatible with USB 2.0</li>
                    <li>Customisable &ndash; Co-Logo program available</li>
                    <li>Guaranteed &ndash; five-year warranty, free technical support</li>
                </ul>
            </div>
        </div>
        <div class="product-block">
            <div class="spec-content"><p><span>Capacities{{Footnote.N37130}}</span>: 16GB, 32GB, 64GB, 128GB</p>
                <p><span>Speed{{Footnote.N37139}}</span>:<br />32GB, 64GB, 128GB: 100MB/s read, 10MB/s write</p>
                <p><span>Dimensions</span>: 2.362" x 0.835" x 0.394" (60mm x 21.2mm x10mm)</p>
                <p><span>Operating Temperatures</span>: 32&deg;F to 140&deg;F (0&deg;C to 60&deg;C)</p>
                <p><span>Storage Temperatures</span>: -4&deg;F to 185&deg;F (-20&deg;C to 85&deg;C)</p>
                <p><span>Compatible with</span>: Windows&reg;&nbsp;10, Windows 8.1, Windows 8, Windows 7 (SP1), Mac OS X v.10.9.x+, Linux v.2.6.x+, Chrome OS&trade;</p></div></div>
',N'USB Flash drive is compliant with next-generation USB 3.0 specifications to take advantage of technology in newer notebooks, desktop PCs and digital devices. DT100G3 makes storing and transferring documents, presentations, music, video and more quicker and easier than ever',65 ,'item', 3.7, 1.2, 2.2, 4.6, 15, 'https://cdn.pbrd.co/images/GZUlEp8.jpg,https://cdn.pbrd.co/images/GZUlMHx.jpg,https://cdn.pbrd.co/images/GZUlW4x.jpg', 0, 4.5, 1,'20171204 10:45:09','tuyetbich',1),

('PRO004','PTY002','admin','BRN004',N'LinkSprinter Network Tester',N'<div>

		<div>
			<strong>Power Over Ethernet (PoE) Tester</strong><br />
			This network tester can become a Power Over Ethernet - PoE tester that checks to make sure you can power a phone, security camera or Access Point through a specific port. The LinkSprinter Network Tester can even run without batteries on PoE.</div>


        <div>

            <div>
                <strong>Link to the Switch</strong><br />
                Perform a switch test, which indicates switch name, model, slot, port and VLAN you are connected to using CDP/LLDP/EDP. Know your available speed and duplex settings.</div>

        </div>


            <div>
                <strong>DHCP Connection</strong><br />
                Confirm that the DHCP server is running and responsive. Request an IP address, get your subnet information, troubleshooting DNS, and identify the default gateway and DNS server.</div>

        </div>

        <div>

            <div>
                <strong>Gateway Connection</strong><br />
                Verify the gateway/router address and reachability by pinging the device.</div>

        </div>

        <div>

            <div>
                <strong>Internet Connection</strong><br />
                Confirm cloud connectivity or internal service reachability. Verify DNS server lookup and application port connectivity.</div>
        </div>
</div>

<div>
    <strong>View Detailed Test Results on Your Mobile Device</strong><br />
    The LinkSprinter test results can be accessed through the browser of any mobile device with its built-in low-power Wi-Fi access point. By utilizing your mobile device and any web browser you can instantly see your test results without having to download a mobile application. This low-power Wi-Fi access point will not allow access to the internet like a hot spot, and it&rsquo;s range is less than 10 feet.
    <div></div>
</div>
          </div></div>
',N'The LinkSprinter test results can be accessed through the browser of any mobile device with its built-in low-power Wi-Fi access point. By utilizing your mobile device and any web browser you can instantly see your test results without having to download a mobile application. This low-power Wi-Fi access point will not allow access to the internet like a hot spot, and it&rsquo;s range is less than 10 feet.',220 ,'item', 4.2, 2.2, 3.5, 4.3, 7, 'https://cdn.pbrd.co/images/GZUmgZ3.jpg, https://cdn.pbrd.co/images/GZUmtqk.jpg,https://cdn.pbrd.co/images/GZUmERC.jpg,https://cdn.pbrd.co/images/GZUmPYz.jpg', 0, 4.0, 1,'20171204 10:52:09','tuyetbich',1),

('PRO005','PTY002','admin','BRN005',N'Anker 3-Port USB 3.0 Aluminum Portable Data Hub',N'<div >
            <p ><span ><span ><strong>Anker Unibody 3-Port USB 3.0 and Ethernet Hub</strong></span></span></p>

            <p ><span><span >Sync and connect through more ports at speed.</span></span></p>

            <p ><span ><span ><strong>SuperSpeed Transfer X3</strong></span></span></p>

            <p ><span><span >Dont deny your devices access to SuperSpeed ports. With transfer rates of up to 5Gbps, set aside less time for syncing and more time for work. And thanks to 3 extra data terminals, you no longer have to constantly switch and unplug everything.</span></span></p>

            <p ><span ><span ><strong>Lightspeed Link-Up</strong></span></span></p>

            <p ><span><span >Connect to the 1 gigabit ethernet port and access superfast network speeds of up to 1000Mbps. Weve also thrown in a 1.3ft USB 3.0 Cable to make sure your data syncing is just as quick.</span></span></p>

            <p ><span ><span ><strong>Keeping Things Light</strong></span></span></p>

            <p ><span><span >What good is such versatility if you cant take it out? With no screws and a compact, unibody design, the Anker Unibody 3-Port Hub expands your capabilities, wherever you are.</span></span></p>

            <p ><span ><span ><strong>Power Usage Alerts:</strong></span></span></p>

            <p ><span><span >To ensure a stable connection, dont use this hub with high power-consumption devices such as some large-capacity hard drives.</span></span></p>

            <p ><span><span >This hub is not meant to serve as a stand-alone charger. It is not compatible with iPads or other devices which require a higher charging input.</span></span></p>

            <p ><span ><span ><strong>Power Usage Alerts:</strong></span></span></p>

            <p ><span><span >Windows (32/64 bit) 10 / 8.1 / 8 / 7 / Vista / XP, Mac OS X 10.6 to 10.9, Linux 2.6.14 or above. On Windows, a driver needs to be manually installed to enable ethernet connection. No drivers required for data ports on all compatible systems.</span></span></p>

            <p ><span ><span ><strong>Notes:</strong></span></span></p>

            <p ><span><span >Mac OS X Lion 10.7.4 users should upgrade to Mountain Lion 10.8.2 or later to avoid unstable connections.</span></span></p>

            <p ><span><span >2.4Ghz wireless devices (keyboards, mice, etc.) may not work around USB 3.0 ports. Try using a USB 2.0 connection.</span></span></p>

            <p> </p>
        </div>
',N'Dont deny your devices access to SuperSpeed ports. With transfer rates of up to 5Gbps, set aside less time for syncing and more time for work. And thanks to 3 extra data terminals, you no longer have to constantly switch and unplug everything',170 ,'item', 3.6, 2.5, 3.5, 4.0, 9, 'https://cdn.pbrd.co/images/GZUmgZ3.jpg,https://cdn.pbrd.co/images/GZUmtqk.jpg,https://cdn.pbrd.co/images/GZUmERC.jpg,https://cdn.pbrd.co/images/GZUmPYz.jpg', 0, 4.5, 1,'20171204 11:03:09','tuyetbich',1),

('PRO006','PTY002','ringu','BRN006',N'Ring Video Doorbell Pro',N'<div>
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        See, hear and speak to anyone at your door from your smartphone, tablet or PC.

                    </span></li>

                <li><span class="a-list-item"> 
                        Watch over your home in crystal-clear 1080p HD video.

                    </span></li>

                <li><span class="a-list-item"> 
                        Protect your home—day or night—with infrared night vision.

                    </span></li>

                <li><span class="a-list-item"> 
                        Live View enabled: Check-in on your property at any time with video on demand.

                    </span></li>

                <li><span class="a-list-item"> 
                        Lifetime purchase protection: If your doorbell gets stolen, we’ll replace it, for free!

                    </span></li>

            </ul>
        </div>
',N'See, hear and speak to anyone at your door from your smartphone, tablet or PC.',260 ,'item', 3.7, 3.3, 3.6, 12.5, 5, 'https://images-na.ssl-images-amazon.com/images/I/41krBhgsduL.jpg, https://images-na.ssl-images-amazon.com/images/I/41ahkM%2Bo2CL.jpg,https://images-na.ssl-images-amazon.com/images/I/41Z4AR56Q2L.jpg,https://images-na.ssl-images-amazon.com/images/I/51YQC47UauL.jpg', 0, 4.5, 1,'20171204 11:12:09','tuyetbich',1),

('PRO007','PTY003','admin','BRN007',N'IOGEAR 3.0/4 Port Peripheral Sharing Switch',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">

            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Share four USB peripheral devices between four computers

                    </span></li>

                <li><span class="a-list-item"> 
                        Easily switch devices from one computer to another with the press of a button

                    </span></li>

                <li><span class="a-list-item"> 
                        USB 3.0 compliant, supporting data transfer rates of up to 5Gbps

                    </span></li>

                <li><span class="a-list-item"> 
                        LED indicates which computer is active

                    </span></li>

                <li><span class="a-list-item"> 
                        Over-current protection

                    </span></li>

                <li><span class="a-list-item"> 
                        Supports hot-plugging which allows easily add or remove computers connected to the installation without having to power down the switch

                    </span></li>

                <li><span class="a-list-item"> 
                        Requirements: Windows Vista, Windows 7, Windows 8, Windows 8.1. Mac OS X 10.3+. Chrome OS. Linux-based systems. Available USB 3.0 port

                    </span></li>

            </ul>	
        </div>
',N'Share four USB peripheral devices between four computers',350 ,'item', 3.7, 3.3, 3.6, 12.5, 5, 'https://images-na.ssl-images-amazon.com/images/I/31i4PL4941L.jpg,https://images-na.ssl-images-amazon.com/images/I/31ep8exwQWL.jpg,https://images-na.ssl-images-amazon.com/images/I/41wYx9uj0UL.jpg', 0, 4.0, 1,'20171204 11:15:09','tuyetbich',1),

('PRO008','PTY003','admin','BRN008',N'USB Extension Cable, Weme Active USB',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        USB 3.0 active extension cable extends the connection between a computer or Windows tablet and USB 3.0 or USB 2.0 peripherals such as keyboard, mouse, hard drives, USB hub, USB card reader, flash drives, printers, and more

                    </span></li>

                <li><span class="a-list-item"> 
                        Enjoy data transfer rates of up to 5Gbps for faster sync times while maintain backwards compatibility with USB 2.0 devices

                    </span></li>

                <li><span class="a-list-item"> 
                        Bus powered with an integrated amplification chipset to ensure the SuperSpeed USB 3.0 performance at 5m than a normal USB extension cable

                    </span></li>

                <li><span class="a-list-item"> 
                        Bare copper conductors and foil &amp; braid shielding, provides superior cable performance and no signal degradation

                    </span></li>

                <li><span class="a-list-item"> 
                        Plug and play, bus-powered required no external power supply

                    </span></li>

            </ul>
        </div>
',N'USB 3.0 active extension cable extends the connection between a computer or Windows tablet and USB 3.0 or USB 2.0 peripherals such as keyboard, mouse, hard drives, USB hub, USB card reader, flash drives, printers, and more',65 ,'item', 1.2, 0.5, 0.5, 100, 20, 'https://images-na.ssl-images-amazon.com/images/I/41h7-Rrc6BL.jpg,https://images-na.ssl-images-amazon.com/images/I/410LUqhP8HL.jpg,https://images-na.ssl-images-amazon.com/images/I/41t8a8BaNmL.jpg,https://images-na.ssl-images-amazon.com/images/I/31NCyG8J5jL.jpg', 0, 3.5, 1,'20171204 11:20:09','tuyetbich',1),

('PRO009','PTY003','admin','BRN009',N'UGREEN USB Switch Selector',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        This 4 Port USB Sharing Switch allows one button swapping between 2 computers to share 4 USB 2.0 peripheral devices without constantly swapping cables or set up complicated network sharing software;

                    </span></li>

                <li><span class="a-list-item"> 
                        Ideal for sharing devices such as printer, scanner, mouse, keyboard, card reader, flash drive and other USB deivce between 2 computers;

                    </span></li>

                <li><span class="a-list-item"> 
                        Great Compatibility, driver-free for Windows 10/8/8.1/7/Vista/XP and Mac OS X, Linux, and Chrome OS, simply plug and play;

                    </span></li>

                <li><span class="a-list-item"> 
                        Button and LED indicate lights, you can easily switch between 2 computers by a single click on the button with LED indicating the active computer;

                    </span></li>

                <li><span class="a-list-item"> 
                        STABLE Connection: USB 2.0 sharing switch with a separate micro usb female port for option power,which optimizing its compatibility with more devices, such as HDD,Digital Video Cameras, SSD etc. Important Note: Please use Standard DC 5V USB Power Adapter. Any charger with higher voltage output is NOT allowed and may affect the product performance.

                    </span></li>

            </ul>
        </div>
',N'STABLE Connection: USB 2.0 sharing switch with a separate micro usb female port for option power,which optimizing its compatibility with more devices, such as HDD,Digital Video Cameras, SSD etc. Important Note: Please use Standard DC 5V USB Power Adapter. Any charger with higher voltage output is NOT allowed and may affect the product performance.',320 ,'item', 5.7, 2.3, 4.2, 17.3, 6, 'https://images-na.ssl-images-amazon.com/images/I/41OmI%2BAVBQL.jpg,https://images-na.ssl-images-amazon.com/images/I/41jJItxmeDL.jpg,https://images-na.ssl-images-amazon.com/images/I/51n0I1sr2%2BL.jpg,https://images-na.ssl-images-amazon.com/images/I/51bEDXVsCUL.jpg,https://images-na.ssl-images-amazon.com/images/I/41uccQT09IL.jpg', 0, 4.0, 1,'20171204 11:25:09','tuyetbich',1),

('PRO010','PTY004','taidy','BRN010',N'15.6-Inch Laptop Shoulder Bag Case Sleeve - Taidy',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        15.6-Inch Laptop shoulder bag dimension: 15.8 x 0.6 x 11.8 Inch (LxWxH), compatible with 14" 14.1" 15" 15.4" 15.6 Inch laptop and macbook pro 15.

                    </span></li>

                <li><span class="a-list-item"> 
                        Super soft Neoprene material protect your laptop from dust, scratches and bumps.

                    </span></li>

                <li><span class="a-list-item"> 
                        Double zipper on the main compartment glides smoothly and allow convenient access to your laptop. External pocket for adapter, mouse and other small items.

                    </span></li>

                <li><span class="a-list-item"> 
                        The shoulder strap is adjustable and detachable. More, the laptop bag also have two outside padded handle for carrying.

                    </span></li>

                <li><span class="a-list-item"> 
                        Same vivid image on both side of bag, very stylish and fashionable. Can be repeated washing, easy to dry, never fade.

                    </span></li>
            </ul>
        </div>
',N'15.6-Inch Laptop shoulder bag dimension: 15.8 x 0.6 x 11.8 Inch (LxWxH), compatible with 14" 14.1" 15" 15.4" 15.6 Inch laptop and macbook pro 15',20 ,'item', 1.2, 1.1, 4.2, 20.5, 15, 'https://images-na.ssl-images-amazon.com/images/I/51zgr4rzrML.jpg,https://images-na.ssl-images-amazon.com/images/I/31UyRoV4v9L.jpg,https://images-na.ssl-images-amazon.com/images/I/51twwn3VXfL.jpg,https://images-na.ssl-images-amazon.com/images/I/5180fWNWf1L.jpg,https://images-na.ssl-images-amazon.com/images/I/41QoXtQjInL.jpg', 0, 4.0, 1,'20171204 11:27:09','tuyetbich',1),

('PRO011','PTY004','admin','BRN011',N'Mosiso Quatrefoil Style Canvas Fabric Laptop Sleeve Case Cover Bag with Shoulder Strap',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Internal Dimensions: 15.16 x 0.79 x 10.63 inches (L x W x H); External Dimensions: 15.75 x 0.79 x 11.22 inches (L x W x H). Suitable for Macbook Pro Retina 15 inch A1398 (Mid 2012-Mid 2015), Dell Inspiron 15.6 inch 2 in 1 and most popular 15-15.6 Inch Laptops / Notebooks / Ultrabooks; may not snugly fit all computers due to variations in the sizes of different models.

                    </span></li>

                <li><span class="a-list-item"> 
                        Outer canvas fabric of the case is printed with Quatrefoil / Moroccan Trellis style patterns that enable you to carry your MacBook / laptop / notebook / Ultrabook computer in a uniquely sleek style.

                    </span></li>

                <li><span class="a-list-item"> 
                        Features a polyester foam padding layer and fluffy fleece fabric lining for bump and shock absorption and protection of your computer from accidental scratches.

                    </span></li>

                <li><span class="a-list-item"> 
                        Removeable and adjustable padding shoulder strap varied from 27 inch to maximum 48 inch and dual sturdy handles for long time comfortably carrying, top handles also can tuck away in the pockets when not needed.

                    </span></li>

                <li><span class="a-list-item"> 
                        Side pocket of the bag is ideal for storage of small items such as power adapters, cables, pens and notepads, offering added convenience. Mosiso 1 year warranty on every bag.

                    </span></li>
            </ul>
        </div>
',N'Internal Dimensions: 15.16 x 0.79 x 10.63 inches (L x W x H); External Dimensions: 15.75 x 0.79 x 11.22 inches (L x W x H). Suitable for Macbook Pro Retina 15 inch A1398 (Mid 2012-Mid 2015), Dell Inspiron 15.6 inch 2 in 1 and most popular 15-15.6 Inch Laptops / Notebooks / Ultrabooks; may not snugly fit all computers due to variations in the sizes of different models',18 ,'item', 1.3, 1.1, 4.2, 20.5, 13, 'https://images-na.ssl-images-amazon.com/images/I/51pc0jTUoBL.jpg, https://images-na.ssl-images-amazon.com/images/I/41GRtsp-F2L.jpg, https://images-na.ssl-images-amazon.com/images/I/51cgA0I543L.jpg, https://images-na.ssl-images-amazon.com/images/I/51qnd%2BRrl-L.jpg, https://images-na.ssl-images-amazon.com/images/I/51iAH9ngnQL.jpg', 0, 3.5, 1,'20171204 11:30:09','tuyetbich',1),

('PRO012','PTY004','admin','BRN012',N'CoolBELL Convertible Backpack Messenger Bag Shoulder bag',N'<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Dimensions: 18.8 x 5.1 x 13.7 inches; Fits up to 17.3 inches laptop.

                    </span></li>

                <li><span class="a-list-item"> 
                        Three carrying styles. You could use it as backpack shoulder bag and messenger bag. Also the straps can be hidden when you use it a messenger bag and shoulder bag.

                    </span></li>

                <li><span class="a-list-item"> 
                        Four outside pockets, convenient to oganize your items you want to carry.

                    </span></li>

                <li><span class="a-list-item"> 
                        Roomy laptop compartment and accessory compartment.Special design laptop compartment with Telescopic belt provides more protection for your laptop. Still keep 3 days clothes for traveling. Roomy enough for your need.

                    </span></li>

                <li><span class="a-list-item"> 
                        Lightweight design is easy for carrying. The top grab handle offers quick grab-and-go style. Ergonomic design ensures the dispersion of gravity of the fulled bag.

                    </span></li>
            </ul>
        </div>
',N'Lightweight design is easy for carrying. The top grab handle offers quick grab-and-go style. Ergonomic design ensures the dispersion of gravity of the fulled bag.',25 ,'item', 1.3, 1.1, 4.2, 20.5, 13, 'https://images-na.ssl-images-amazon.com/images/I/51N5irb7ALL.jpg,https://images-na.ssl-images-amazon.com/images/I/51fnuxNSqLL.jpg,https://images-na.ssl-images-amazon.com/images/I/51F6uyNnyWL.jpg,https://images-na.ssl-images-amazon.com/images/I/51iGg7t12zL._SS40_.jpg', 0, 3.5, 1,'20171204 11:32:09','tuyetbich',1)
go

-- Product from PRO012
insert into Products VALUES ('PRO013','PTY005','admin','BRN013','ZOZO Laptop Power Adapter','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Multi Tip &amp; Voltage 90w Laptop AC charger, more convenient and high efficiency. Plug and play, easy to use with automatic voltage adjustment. You can power your different brand laptops with just one adapter.【Not compatible to all laptops, please do not use on devices over 90W】

                    </span></li>

                <li><span class="a-list-item"> 
                        Wide Output Voltage Range [15v-20v] - Input voltage: Worldwide 100-240V, 50 - 60Hz. Output Voltage: DC 15V, 16V, 18.5V, 19V, 19.5V, 20V, max 90W, compatible 65w 45w 40w 33w models which tips are included. Each Brand laptop has several different kinds of tips for different models. IF you are NOT SURE your laptop TIP SIZE, please send your laptop brand and model number to us before buying. We will give suggestions. Any problems, please contact us before returning it

                    </span></li>

                <li><span class="a-list-item"> 
                        Works with Asus Zenbook UX21E and UX31E Series, chromebook C200 C200MA C300 C300MA, X551MA, X555LA , X553M, F555LA-AB31, T300LA, F553M, C202SA-YS02, VivoBook F510UA F510UA-AH51, K501UX, ZenBook UX330UA-AH54 UX330UA-AH55 ; HP Stream 11 13 14, X360, 14-ax010nr 14-ax040nr 14-ax020nr 11-y010nr 11-y020nr 14-ak040nr 14-ax050nr, Chromebook 14 11 G3 G4 G5, ENVY TouchSmart Sleekbook M6, M7, 15-j, 17-j, DV14/15/2000/4000/5000/6000/8000, Dv4 Dv6 Dv7, Dm4 G6 G7, 2000; Sony VAIO VGP-AC19V39 VGP-AC19V47 etc

                    </span></li>

                <li><span class="a-list-item"> 
                        ACER Chromebook 11 13 14 15 C720, C720P R11 C740 Cb3 Cb5, Aspire P3 S5 S7; Acer Aspire E 15 E5-575G-57D4 E5-575-33BM A114-31-C4HH, CB3-131-C3SZ, CB3-131-C8GZ, 14 CB3-431-C5FM cb3-532 15 CB5-571-C09S; TOSHIBA Chromebook 2 Cb35 CB30, Satellite C55-C5241,P755 P775 P870 S855 S875 U305 U505; SAMSUNG NP530U4BL GS6/GT6/7/8, X05 Series, VM GT NT; DELL Inspiron 11Z-1121 1320 13Z-5323 14-3420 14Z-5423 15R-5520 15R-5537,14R 17R, N5010 N7110, Studio 15 17; LENOVO Thinkpad Z60 T410 SL400 SL510; GATEWAY NV55C

                    </span></li>

                <li><span class="a-list-item"> 
                        Package includes: 1 x ZOZO 90W AC adapter, 1 x AC power cord, 1 set x Tips

                    </span></li>
            </ul>
        </div>
','Wide Output Voltage Range [15v-20v] - Input voltage: Worldwide 100-240V, 50 - 60Hz. Output Voltage: DC 15V, 16V, 18.5V, 19V, 19.5V, 20V, max 90W, compatible 65w 45w 40w 33w models which tips are included. Each Brand laptop has several different kinds of tips for different models. IF you are NOT SURE your laptop TIP SIZE, please send your laptop brand and model number to us before buying. We will give suggestions. Any problems, please contact us before returning it',230,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/41krBhgsduL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/41ahkM%2Bo2CL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/41Z4AR56Q2L._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51YQC47UauL._SS150_.jpg',0,4,0,'20171204 11:32:09','tuyetbich',1);
insert into Products VALUES ('PRO014','PTY005','admin','BRN014','StarTech Thunderbolt 3 Docking Station','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        UNIVERSAL DOCKING STATION: The TB3DK2DPPD laptop dock is compatible with all Thunderbolt 3 equipped MacBook Pro (macOS 10.12 and up)and PC laptops (Windows 7 and up).

                    </span></li>

                <li><span class="a-list-item"> 
                        CONNECT DUAL MONITORS: Hook up two 4K Ultra HD monitors using one DisplayPort port and one Thunderbolt 3 port to easily multitask and view full size high definition graphics and video on each display.

                    </span></li>

                <li><span class="a-list-item"> 
                        HIGH RESOLUTION GRAPHICS: View content on your laptop and two 4K HD displays in full resolution (3840 x 2160p or 4096 x 2160p) without any loss of image quality between the monitors. A single 5K display can be connected using a Thunderbolt 3 port.

                    </span></li>

                <li><span class="a-list-item"> 
                        POWER AND CHARGE: This Thunderbolt 3 laptop docking station delivers up to 85W of power to power and charge your laptop and power all your connected peripherals. Use the always-on Fast-Charge USB 3.0 Type-A port to charge tablets and smartphones.

                    </span></li>

                <li><span class="a-list-item"> 
                        FASTER CONNECTIONS: Thunderbolt 3 technology offers the fastest laptop-dock connection with a throughput of 40Gbps. Work on multiple files at once without impacting system performance, making it ideal for graphic-intensive applications.

                    </span></li>
            </ul>
        </div>
','FASTER CONNECTIONS: Thunderbolt 3 technology offers the fastest laptop-dock connection with a throughput of 40Gbps. Work on multiple files at once without impacting system performance, making it ideal for graphic-intensive applications',325,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/31uq5XyNWdL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/41ErlrMMqNL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/419eamBeuaL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51z9j8NiC8L._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51Bz-ZORVGL._SS150_.jpg',0,4,0,'20171204 11:32:10','tuyetbich',1);
insert into Products VALUES ('PRO015','PTY005','admin','BRN015','Macally Aluminum Laptop Stand for Desk','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        STYLISH ALUMINUM DESIGN: Laptop stand will fit any laptop between 10"-17" wide &amp; satin finish aluminum is designed to match and fit all Macbooks, Macbook Airs, &amp; Macbook Pros

                    </span></li>

                <li><span class="a-list-item"> 
                        SECURE AND STURDY: Raised front edges hold the laptop in place &amp; rubberized non-slip pads secure your laptop in place and prevent unwanted scratches to your laptop

                    </span></li>

                <li><span class="a-list-item"> 
                        BETTER ERGONOMICS: Elevates your laptop by 6" to the perfect eye level and prevents you from hunching over your screen, preventing neck / shoulder strain

                    </span></li>

                <li><span class="a-list-item"> 
                        NATURAL AIR COOLING: Open aluminum design allows for natural air ventilation to keep your laptop cool and performing at high speeds

                    </span></li>

                <li><span class="a-list-item"> 
                        RECLAIM DESK SPACE: Stay organized by stashing your items such as your keyboard and mouse under the stand when not in use

                    </span></li>
            </ul>
        </div>
','RECLAIM DESK SPACE: Stay organized by stashing your items such as your keyboard and mouse under the stand when not in use',135,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/410Xu5iut9L._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/41XffEM4q%2BL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51bM7dWBIKL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51gThBg40LL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/41RYd1HWmIL._SS150_.jpg',0,4,0,'20171204 11:32:11','tuyetbich',1);
insert into Products VALUES ('PRO016','PTY006','admin','BRN016','Laptop Fan Cooler 13 Wind Speed','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        New Model: Updated LED screen dynamically displays the air temperature from your laptop vent and the working modes, 13 speeds to manage the airflow and noise; Quiet operation in auto mode and max. Noise is less than 70dbm.
                    </span></li>
                <li><span class="a-list-item"> 
                        Designed for notebok computer with air vents on both sides or rear, ideal for gaming laptops or systems that tax the CPU. Not recommended for Macbook or other ultrathin notebooks thinner than 0.4inch.
                    </span></li>
                <li><span class="a-list-item"> 
                        The best cooler (2600-5000RPM) to ease heat dissipation in laptops, Rapidly reduce both surface and internal temperature by 18 to 50 F degrees in minutes which is far better than cooling pads.
                    </span></li>
                <li><span class="a-list-item"> 
                        Two-way Installation: quick installation provides a easy mounting solution, just plug and play; 3M fixing glue with patented clamping arms, keeps the cooler firmly attached to laptop when moving.
                    </span></li>
                <li><span class="a-list-item"> 
                        There are auto and manual working modes; High quality Japanese motor ensure min. 5000 working hours; One year warranty and 30 day no hassle return and refund, no question asked.
                    </span></li>
            </ul>
        </div>
','There are auto and manual working modes; High quality Japanese motor ensure min. 5000 working hours; One year warranty and 30 day no hassle return and refund, no question asked.',37,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/510Gn--De1L._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51KjZyBS-kL._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51fIUAR7j7L._SS150_.jpg,https://images-na.ssl-images-amazon.com/images/I/51iUtLfnB8L._SS150_.jpg',0,4,0,'20171204 11:32:12','tuyetbich',1);
insert into Products VALUES ('PRO017','PTY006','admin','BRN017','HAVIT Laptop Cooler Cooling Pad','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        [Ultra-Portable]: Slim, portable, and light weight allowing you to protect your investment wherever you go

                    </span></li>

                <li><span class="a-list-item"> 
                        [Ergonomic Comfort]: Doubles as an ergonomic stand with two adjustable height settings

                    </span></li>

                <li><span class="a-list-item"> 
                        [Optimized for Laptop Carrying]: The high-quality multi-directional metal mesh provides your laptop with a wear-resisting and stable laptop carrying surface.

                    </span></li>

                <li><span class="a-list-item"> 
                        [Ultra-Quiet Fans]: Three ultra-quiet fans create a noise-free environment for you

                    </span></li>

                <li><span class="a-list-item"> 
                        [Extra USB Ports]: Extra USB port and power switch design. Built-in dual-USB hub allows for connecting more USB devices.

                    </span></li>
            </ul>
        </div>
','[Ultra-Portable]: Slim, portable, and light weight allowing you to protect your investment wherever you go',40,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/515pNcNtYRL._SX150.jpg,https://images-na.ssl-images-amazon.com/images/I/61-9lbGadxL._SX150.jpg,https://images-na.ssl-images-amazon.com/images/I/61Gwp5mQ--L._SX150.jpg,https://images-na.ssl-images-amazon.com/images/I/41E6RtCCoxL._SX150.jpg,https://images-na.ssl-images-amazon.com/images/I/41hne6oc57L._SX150.jpg',0,4,0,'20171204 11:32:13','tuyetbich',1);
insert into Products VALUES ('PRO018','PTY006','admin','BRN018','Tenswall Laptop Cooling Pad','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Powerful, Ultra-quiet and High Efficiency: 4 cooling fans with 1200RPM and red LED Lights help circulate excess heat dissipation from your laptop.

                    </span></li>

                <li><span class="a-list-item"> 
                        Multi-function Speed Controller and Wide–range Application: This laptop cooler features a multi-function speed controller, which can not only control the on/off switch but can also adjust the speed of the laptop cooling fan. The Tenswall laptop cooling fan is compatible with a variety of 11"-17" laptop computers including Apple Macbook Pro Air, Hp, Alienware, Dell, Lenovo, ASUS, etc.

                    </span></li>

                <li><span class="a-list-item"> 
                        Ultra-slim and Skid Proof Design: This slim, portable and light weight laptop cooler allows you to protect your laptops with a unique skid proof design. This sleek laptop pad reduces the damage sustained from crashes and the modern and delicate appearance and built-in LED indicators add a modern to your home.

                    </span></li>

                <li><span class="a-list-item"> 
                        Extra USB ports and switch: The Tenswall laptop cooling pad features an extra USB port and wind speed switch design as well as a built-in dual-USB hub. The dual-USB hub allows you to connect to more USB devices and the adjustable fan speed gives you the best balance between silence and performance.

                    </span></li>

                <li><span class="a-list-item"> 
                        Impact-resistant and Ergonomic Comfort: The Tenswall Laptop cooler is crafted from high-quality ABS material to extend the service life. It also doubles as an ergonomic stand with two adjustable height settings for even more customization.

                    </span></li>
            </ul>
        </div>
','Impact-resistant and Ergonomic Comfort: The Tenswall Laptop cooler is crafted from high-quality ABS material to extend the service life. It also doubles as an ergonomic stand with two adjustable height settings for even more customization',50,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/61%2BFt3q4eDL.jpg,https://images-na.ssl-images-amazon.com/images/I/51wWKKxjNFL.jpg,https://images-na.ssl-images-amazon.com/images/I/516Ou5n%2BH0L.jpg,https://images-na.ssl-images-amazon.com/images/I/41Yd79mmUdL.jpg,https://images-na.ssl-images-amazon.com/images/I/41usb1Dfu3L.jpg',0,4,0,'20171204 11:32:14','tuyetbich',1);
insert into Products VALUES ('PRO019','PTY007','admin','BRN002','Transcend USB 3.0 Card Reader','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        SuperSpeed USB 3.0 interface; backwards compatible with USB 2.0
                    </span></li>
                <li><span class="a-list-item"> 
                        Supports SDHC (UHS-I), SDXC (UHS-I), microSD, microSDHC (UHS-I), and microSDXC (UHS-I)
                    </span></li>
                <li><span class="a-list-item"> 
                        LED card insertion and data transfer activity indicator
                    </span></li>
                <li><span class="a-list-item"> 
                        Ideal for transferring high-resolution images and video recordings
                    </span></li>
                <li><span class="a-list-item"> 
                        Supports SD and security functions
                    </span></li>
                <li><span class="a-list-item"> 
                        Offers a free download of RecoveRx data recovery software
                    </span></li>
                <li><span class="a-list-item"> 
                        USB Powered
                    </span></li>
            </ul>
        </div>
','SuperSpeed USB 3.0 interface; backwards compatible with USB 2.0',20,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/31mvshhOrFL.jpg,https://images-na.ssl-images-amazon.com/images/I/316NrTkXsBL.jpg,https://images-na.ssl-images-amazon.com/images/I/51Tvz3LLP1L.jpg,https://images-na.ssl-images-amazon.com/images/I/31iZ9Us28rL.jpg',0,4,0,'20171204 11:32:15','tuyetbich',1);
insert into Products VALUES ('PRO020','PTY007','admin','BRN009','UGREEN SD Card Reader USB 3.0','<div id=""feature-bullets"" class=""a-section a-spacing-medium a-spacing-top-small"">
            <ul class=""a-unordered-list a-vertical a-spacing-none"">
                <li><span class=""a-list-item""> 
                        One Reader for Multi Cards: Ugreen USB Card Reader is designed with 4 card slots: SD, Micro SD, CF, MS slots and USB 3.0 connector, which allow you to read and transfer data the most popular flash media on the computer, laptop, tablet through USB 3.0 interface, including SDXC/SDHC/SD/Extreme I III SD/Ultra II SD/MMC/RS-MMC or Micro SD/TF/Micro SDXC/Micro SDHC/UHS-I or CF I 3.0/4.0 /Extreme I III CF/Ultra II CF/HS CF/XS-XS CF/CF Elite Pro/ CF Pro/CF Pro II or MS/MS PRO/MS PRO-HG/MS XC DUO.

                    </span></li>

                <li><span class=""a-list-item""> 
                        Super Speed&amp;High Capacity: Ugreen USB Memory Card Reader support SD/Micro SD card up to 512G and allows super fast data transfer up to 5Gbps - 10X faster than USB 2.0 (480 Mbps), which allows you to transfer HD movies or files in just seconds, when your host is equipped with USB 3.0 port. Also backward compatible with USB 2.0, 1.1 and 1.0 (speed limited by USB bus).

                    </span></li>

                <li><span class=""a-list-item""> 
                        Compact Design&amp;Premium Quality: So useful but so compact. Easy to grab and go. Reinforced cable, Tin-plated pure copper core and multi-shielded inside, sturdy exterior and heat-resistant connectors ensure high data transmission efficiency and ultimate durability. 1.5ft short cable tail would reduce stress on the USB port on your computer and wont affect the use of adjacent ports. LED indicator will be ON when the card reader is connected to computer.

                    </span></li>

                <li><span class=""a-list-item""> 
                        Broad Compatibility: Compatible with Windows XP/Vista/7/8/8.1/10, Mac OS, Linux, Chrome OS and etc. It could read and write mutiple cards at the same time to keep you away from the hassle of constant unplugging and re-plugging.

                    </span></li>

                <li><span class=""a-list-item""> 
                        One-sec Installation: Plug and Play. No driver needed. Hot swapping and auto detection. Backed by Ugreen One-Year Warranty and Lifetime Friendly Support.

                    </span></li>
            </ul>
        </div>
','Broad Compatibility: Compatible with Windows XP/Vista/7/8/8.1/10, Mac OS, Linux, Chrome OS and etc. It could read and write mutiple cards at the same time to keep you away from the hassle of constant unplugging and re-plugging.',22,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/41x25w5NTML.jpg,https://images-na.ssl-images-amazon.com/images/I/51adq5PAOsL.jpg,https://images-na.ssl-images-amazon.com/images/I/51U%2B%2BGlSYVL.jpg,https://images-na.ssl-images-amazon.com/images/I/51q2idhlVEL.jpg,https://images-na.ssl-images-amazon.com/images/I/41eOElc2LBL.jpg',0,4,0,'20171204 11:32:16','tuyetbich',1);
insert into Products VALUES ('PRO021','PTY007','admin','BRN019','Acuvar Memory Card Reader / Writer ','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Compatible with all versions of SD/SDHC, Micro SD, CF, XD, MS/Pro &amp; Duo Cards

                    </span></li>

                <li><span class="a-list-item"> 
                        Easy Plug-and-Play Installation

                    </span></li>

                <li><span class="a-list-item"> 
                        High Speed USB

                    </span></li>

                <li><span class="a-list-item"> 
                        USB Cable Cord Built In

                    </span></li>

                <li><span class="a-list-item"> 
                        Ideal For Travelers

                    </span></li>
            </ul>
        </div>
',' Compatible with all versions of SD/SDHC, Micro SD, CF, XD, MS/Pro &amp; Duo Cards',18,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/51AIW4ljV2L.jpg,https://images-na.ssl-images-amazon.com/images/I/41xoK4HRJNL.jpg',0,4,0,'20171204 11:32:17','tuyetbich',1);
insert into Products VALUES ('PRO022','PTY008','admin','BRN020','Multi Device Charging Station– by Wasserstein','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        ✔ ONE SOLUTION FOR ALL-DEVICES – Finally, one station to charge them ALL! Quick to charge your phones, tablets and all your other devices with our futuristic and practical charging dock.

                    </span></li>

                <li><span class="a-list-item"> 
                        ✔ FORM &amp; FUNCTION – Made of high quality bamboo, the natural color of the casing is aesthetically pleasing and will fit in easily with most home interiors. With 6 available slots, this charging station makes unorganized and messy cables are thing of the past. Perfectly compatible with your own USB cables (NOT included), transform your once chaotic and isolated charging units into one unify and elegant charging station.

                    </span></li>

                <li><span class="a-list-item"> 
                        ✔ LIGHTNING FAST CHARGING – Includes a 6-port USB power adapter, to support the quick charging of your devices of up to 12A. Each port contains a smart charging chip set (Max 2.4A) to identify the electrical needs of each individual devices, enabling the optimization current flow and maximizing charging efficiency.

                    </span></li>

                <li><span class="a-list-item"> 
                        ✔ WASSERSTEIN SAVINGS – Realize huge savings when you buy our Multi device charging station together with our short 8-inch lighting cables (ASIN: B06XZVM19B, B01N0R2J02) or our 8-inch micro USB charging cable (ASIN: B06XZVGD8G, B01N9HU2ON). Simply add both items to your Cart and use discount code SuperCha at the checkout.

                    </span></li>

                <li><span class="a-list-item"> 
                        ✔ SAFETY &amp; WARRANTY - The products are CE, FCC and ROHS certified with built-in over-voltage, over-current and short circuit protection. Wasserstein 3 months Warranty: If you are at all unhappy with the product, we will provide you with a replacement or issue a full refund, no questions, no charge, no kidding!

                    </span></li>
            </ul>
        </div>
','The products are CE, FCC and ROHS certified with built-in over-voltage, over-current and short circuit protection. Wasserstein 3 months Warranty: If you are at all unhappy with the product, we will provide you with a replacement or issue a full refund, no questions, no charge, no kidding!',53,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/41FsdD3qOaL.jpg,https://images-na.ssl-images-amazon.com/images/I/51I0br0UDdL.jpg,https://images-na.ssl-images-amazon.com/images/I/51zDpIXd42L.jpg,https://images-na.ssl-images-amazon.com/images/I/41ABUxfeutL.jpg,https://images-na.ssl-images-amazon.com/images/I/51czdhoMHmL.jpg',0,4,0,'20171204 11:32:18','tuyetbich',1);
insert into Products VALUES ('PRO023','PTY008','admin','BRN021','Exxact New Silicone Pad','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Convenient magnetic charging port with super fast micro USB 2 in 1 cable.GPS Dashboard Mount.

                    </span></li>

                <li><span class="a-list-item"> 
                        The New Upgrade Vehicle Dock,Cell Phone holder,simple structure and easy installation.Black dash mat with holes base design,security and stably. Also a good choice as stand for watching TV at home.

                    </span></li>

                <li><span class="a-list-item"> 
                        You can charge your phone on the go, while using it for navigation or hands free calling. The holder is adjustable to fit all sizes of cell phones and is flexible for conformity to most car dashes.

                    </span></li>

                <li><span class="a-list-item"> 
                        Non-magnetic,no adhesive or glue needed;It can be directly adhere to dashboard of cars,trucks,SUV etc.the base of this stand which is a flat silicone as well hold very well on the dashboard,doesnt slide when taking turns making it a good dashboard mount if your driving habits are speed limit and slow turns.

                    </span></li>

                <li><span class="a-list-item"> 
                        The holder base provides stability to be able to touch the cell phone screen without excess movement. It is older than the middle one more notch so more firmly your cell phone, mobile phone anti-skid function more enhanced, more flexibility.

                    </span></li>
            </ul>
        </div>
','The holder base provides stability to be able to touch the cell phone screen without excess movement. It is older than the middle one more notch so more firmly your cell phone, mobile phone anti-skid function more enhanced, more flexibility.',72,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/51FTHPhBtKL.jpg,https://images-na.ssl-images-amazon.com/images/I/51Jt1OHVZ-L.jpg,https://images-na.ssl-images-amazon.com/images/I/410mB%2BweICL.jpg,https://images-na.ssl-images-amazon.com/images/I/41G4aca1EpL.jpg,https://images-na.ssl-images-amazon.com/images/I/418IoOOB1rL.jpg',0,4,0,'20171204 11:32:19','tuyetbich',1);
insert into Products VALUES ('PRO024','PTY008','admin','BRN022','Wandlemate Cell Phone Charging Dock','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        MULTI-FUNCTION The cell phone charging station stand works as both universal phones &amp; tablets stand and also quick desktop charging dock station for iphone. Suitable height, perfect angle of view enable user read the phone handsfree.

                    </span></li>

                <li><span class="a-list-item"> 
                        APPLICATIONS The cell phone charging station stand can play a good role in your office, kitchen, nightstand or dining table. You can easily check Facetime and YouTube; easy to read message facebook emails and the phone holder charging dock helps cooking from a recipe online in the kitchen and more.

                    </span></li>

                <li><span class="a-list-item"> 
                        COMPATIBILITY As a phone holder its compatible with all smartphones including iPhones, Samsung Galaxy S8 S7 S6 Edge Note 5 4 2 Mini Tablets, Ipad, Ipod, etc; As a charging station it support iPhone 7 7Plus SE 6S Plus 6 6Plus 5S 5 and iPad.etc

                    </span></li>

                <li><span class="a-list-item"> 
                        STURDY RUBBER PROTECTION The phone pholder charging dock is with scientific design which makes the item stable on any desk or counter, and the rubber cushions of hook&amp;bottom protect your phone away from scratches and sliding.

                    </span></li>

                <li><span class="a-list-item"> 
                        TIPS If you find the phone charging dock stand doesnt work,please take off your case or use a thin case insteady of it.

                    </span></li>
            </ul>
        </div>
','STURDY RUBBER PROTECTION The phone pholder charging dock is with scientific design which makes the item stable on any desk or counter, and the rubber cushions of hook&amp;bottom protect your phone away from scratches and sliding.',55,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/41jpOdEC9FL.jpg,https://images-na.ssl-images-amazon.com/images/I/31M2zVblWxL.jpg,https://images-na.ssl-images-amazon.com/images/I/41%2B8O2uAY8L.jpg,https://images-na.ssl-images-amazon.com/images/I/41Dq%2BL0uqHL.jpg,https://images-na.ssl-images-amazon.com/images/I/41pYivIkWmL.jpg',0,4,0,'20171204 11:32:20','tuyetbich',1);
insert into Products VALUES ('PRO025','PTY009','admin','BRN023','Kobert Waterproof Cell Phone Case','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Your phone stays safe and dry. Experience the delight and confidence of not having to worry about your phone when close to water. Our waterproof bag is a simple and very effective way to keep your cell phone safe and dry. You can call, text, talk and play games while your phone is in the bag without loss of sound above the water. Take your phone to the toilet without worries, listen to your favorite music while taking a shower or give your precious phone to your kids while they are in the bath

                    </span></li>

                <li><span class="a-list-item"> 
                        Talk and take crisp photos through the transparent case. Take the most amazing underwater photos now for the first time. Hang on to your phone in the water so you never miss that precious shot again. It is a must have item for any adventurer - take it with you when you ski, snorkel, boat, kayak, swim, cruise or travel. It is strong and sturdy enough to withstand those crazy rides at the water park. With a Kobert waterproof case you can make your holiday experience the most memorable &zwnj;&zwnj;

                    </span></li>

                <li><span class="a-list-item"> 
                        The iPhone 7 home button only works through a Kobert Deluxe Navy case unlike all other Kobert waterproof bags - to make your home button work on all other Kobert cases, use Assistive Touch on your phone software - instructions will be e-mailed to you how to do this. Impress your friends when you show them your stylish and smart case or consider purchasing it as a Christmas or birthday gift

                    </span></li>

                <li><span class="a-list-item"> 
                        Durable adjustable lanyard included - carry your phone case around your neck or body for easy access. Simple to use snap and lock mechanism allows you easy access to your bags content. Please remember to use your phone volume control buttons to take pictures or a video under the water surface as the screen will be less responsive

                    </span></li>

                <li><span class="a-list-item"> 
                        Zero risk involved (lifetime warranty) - at Kobert International we stand by our products and offer a no questions asked 30 day money back guarantee. We will offer an additional limited lifetime replacement guarantee on the waterproof case if you purchase directly from Kobert International
                    </span></li>
            </ul>
        </div>
','Durable adjustable lanyard included - carry your phone case around your neck or body for easy access. Simple to use snap and lock mechanism allows you easy access to your bags content. Please remember to use your phone volume control buttons to take pictures or a video under the water surface as the screen will be less responsive',10,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/51pGOjuV9nL.jpg,https://images-na.ssl-images-amazon.com/images/I/51OdvRD4t5L.jpg,https://images-na.ssl-images-amazon.com/images/I/519s5QKc1BL.jpg,https://images-na.ssl-images-amazon.com/images/I/41zTKK4werL.jpg,https://images-na.ssl-images-amazon.com/images/I/515kCPqWPKL.jpg',0,4,0,'20171204 11:32:21','tuyetbich',1);
insert into Products VALUES ('PRO026','PTY009','admin','BRN024','KISS GOLD (TM) Luxury Matte PU ','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Imported

                    </span></li>

                <li><span class="a-list-item"> 
                        Perfect for holding your mobile phones, whose max size is less than 7.1 inch. Such as iPhone 8, iPhone 8 Plus(without case on it); iPhone 7, iPhone 7 Plus; iPhone 6, iPhone 6 Plus; Samsung Galaxy S5/S4/S3/S2 ; Samsung Galaxy Note 2/Note 3/Note 4(Without case on it); can also hold your credit card; ID card;money; or more other small gadgets

                    </span></li>

                <li><span class="a-list-item"> 
                        Made of soft matte PU leather material;Extreme overall back and front protection keep your phone from drops and scratches; 3 pockets inside, which can hold money,credit cards and all model of cellphones

                    </span></li>

                <li><span class="a-list-item"> 
                        With Shoulder Strap design, you can wear this pouch cross-body or Single shoulder

                    </span></li>

                <li><span class="a-list-item"> 
                        Durable materials keeps your cellphone and other eletric device safely protected.Super sturdy and Easy To Carry,add minimal bulk to you

                    </span></li>

                <li><span class="a-list-item"> 
                        Size: 4.5 (L)inch * 1.0(W)inch * 7.1 (H)inch Shoulder Strap length: 46 inch

                    </span></li>
            </ul>
        </div>
','Perfect for holding your mobile phones, whose max size is less than 7.1 inch. Such as iPhone 8, iPhone 8 Plus(without case on it); iPhone 7, iPhone 7 Plus; iPhone 6, iPhone 6 Plus; Samsung Galaxy S5/S4/S3/S2',7,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/41wpninLytL.jpg,https://images-na.ssl-images-amazon.com/images/I/415ZI72C2TL.jpg,https://images-na.ssl-images-amazon.com/images/I/51aH3olPeZL.jpg,https://images-na.ssl-images-amazon.com/images/I/41jX6UC%2BC-L.jpg',0,4,0,'20171204 11:32:22','tuyetbich',1);
insert into Products VALUES ('PRO027','PTY009','admin','BRN024','KISS GOLD(TM) Womens Folk Style ','<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">
            <ul class="a-unordered-list a-vertical a-spacing-none">
                <li><span class="a-list-item"> 
                        Imported

                    </span></li>

                <li><span class="a-list-item"> 
                        It perfectly fits your mobile phones , such as iPhone 8, iPhone 8 Plus(Without case on); iPhone 7, iPhone 7 Plus; iPhone 6, iPhone 6 Plus; Samsung Galaxy S5/S4/S3/S2; Samsung Galaxy Note 2/Note 3/ Note 4(Without Case on).

                    </span></li>

                <li><span class="a-list-item"> 
                        Made of high-class Pu leather material, the cellphone pouch/mini shoulder bag prevents your mobile phone from damage, scratch,and being moistened

                    </span></li>

                <li><span class="a-list-item"> 
                        The beautiful fashion design and unique folk style make it a best choice for ladies and girls.

                    </span></li>

                <li><span class="a-list-item"> 
                        The cellphone pouch/mini shoulder bag can be used in various occasions, such as shopping, dating, travel, doing sports.

                    </span></li>

                <li><span class="a-list-item"> 
                        Size: 4.5 inch(L)*7.0 inch(H)*1.0 inch(D)

                    </span></li>
            </ul>
        </div>
','The cellphone pouch/mini shoulder bag can be used in various occasions, such as shopping, dating, travel, doing sports',9,'item','11.3','5','7.3','20.3',17,'https://images-na.ssl-images-amazon.com/images/I/51KJMP%2Bpj2L.jpg,https://images-na.ssl-images-amazon.com/images/I/51FDfQ%2BDJ7L.jpg',0,4,0,'20171204 11:32:23','tuyetbich',1);

-- Products from 028
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO028','PTY001', 'quocanh','BRN001','WD 2TB WESN','2TB Storage Capacity
USB 3.0 and USB 2.0 compatibility
Up to 5 Gb/s Data Transfer Speed
Formatted for Windows 8, 7, Vista & XP
Easily Reformat Drive for Mac
Ultra-fast USB 3.0 data transfers. Massive capacity
For Mac compatibility this Hard Drive requires reformatting. Refer to Application Guide for guidance on this
Free trial of WD SmartWare Pro auto and cloud backup software
WD quality and reliability
Adding extra storage for your videos, music, photos, and files','WD 2TB Elements Portable External Hard Drive - USB 3.0 - WDBU6Y0020BBK-WESN',70,'item',3.5,3.5,2.3,2.3,20,'https://images-na.ssl-images-amazon.com/images/I/314XCz9A30L._SX425_.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO029','PTY001', 'quocanh','BRN001','Western Digital Caviar SE 320GB','320GB Capcity, 7200RPM, 8MB Buffer Size
3.5-inch, SATA II 3.0 Gbps Desktop Hard Drive
Best for Desktop PC/Mac or all-in-one PCs, Surveillance CCTV DVR
Passed Factory Diagnostic Software + RE-CERTIFIED by State-of-the-Art software - Full "Sector-by-Sector" test to ensure best HDD quality! ZERO Bad Sectors!
"Like New Refurbished" Worry Free Return! 100% Full Refund','Western Digital Caviar SE (WD3200AAJS) 320GB 8MB Cache 7200RPM SATA 3.0Gb/s 3.5" Internal Desktop Hard Drive [Certified Refurbished]- w/ 1 Year Warranty',52,'item',3.5,3.5,2.3,2.3,20,'https://images-na.ssl-images-amazon.com/images/I/61eKsimQtVL._SL1000_.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO030','PTY001', 'quocanh','BRN001','WD 2TB WDBU6Y0020BBK-WESN','Hard Disk Size:2 TB
Memory Storage Capacity:2 TB
Hardware Interface:usb3.0
Hardware Platform:PC, Mac
File System:NTFS','WD 2TB Elements Portable External Hard Drive - USB 3.0 - WDBU6Y0020BBK-WESN',61,'item',3.5,3.5,2.3,2.3,21,'https://images-na.ssl-images-amazon.com/images/I/314XCz9A30L._SX425_.jpg',5,4,1,'01/12/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO031','PTY001', 'quocanh','BRN001','WD Blue 1TB (WD10EZEX)','Hard Disk Size:1 TB
Memory Storage Capacity:1.0 TB
Hardware Interface:sata 6 0 gb
Form Factor:3.5
Hardware Platform:PC','WD Blue 1TB SATA 6 Gb/s 7200 RPM 64MB Cache 3.5 Inch Desktop Hard Drive (WD10EZEX)',45,'item',3.5,3.5,2.3,2.3,22,'https://images-na.ssl-images-amazon.com/images/I/41JjEu7FCkL._AC_US218_.jpg',5,4,1,'01/24/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO032','PTY001', 'quocanh','BRN001','WD 4TB Black My Passport  Portable External Hard Drive - USB 3.0 - WDBYFT0040BBK-WESN','Hard Disk Size:4 TB
Memory Storage Capacity:4.0 TB
Hardware Interface:usb3.0
Hardware Platform:PC
File System:NTFS','WD 4TB Black My Passport  Portable External Hard Drive - USB 3.0 - WDBYFT0040BBK-WESN',103,'item',3.5,3.5,2.3,2.3,22,'https://images-na.ssl-images-amazon.com/images/I/41u14pVvuiL._AC_US218_.jpg',5,4,1,'02/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO033','PTY002', 'andy','BRN003','goTenna Mesh','goTenna Mesh pairs to your phone to privately & automatically relay texts and GPS locations between devices, no service (or routers, towers or satellites!) necessary
Our super-smart mesh protocol powers private 1-to-1 & group chats or public broadcasts to all nearby users
The perfect off-grid tool: 24-hour battery life, weatherproof, compact & light
Free goTenna app includes detailed offline maps for any region in the world
Compatible with iOS or Android devices,sold in pairs, charging cables included

','goTenna Mesh – Devices to power the first consumer-friendly, long-range, off-grid mobile mesh network',179,'item',3.5,3.5,2.3,2.3,23,'https://images-na.ssl-images-amazon.com/images/I/41pxc+DPusL._AC_US218_.jpg',5,4,1,'02/14/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO034','PTY002', 'andy','BRN003','StarTech.com Network LPR Print Server (PM1115U2)','Share a standard USB printer with multiple users over an Ethernet network
10/100Mbps Ethernet to USB 2.0 network LPR print server
USB 10/100 Mbps print server / network print server / print server adapter
10/100 Mbps USB print server with 10Base-T/100Base-TX Auto-sensing
Supports LPR network printing
Converts a USB printer into a standalone network printer over a 10/100 Ethernet network
Windows based set-up program and web-management.Note: Check the user manual before use','StarTech.com 10/100Mbps Ethernet to USB 2.0 Network LPR Print Server (PM1115U2)',59,'item',3.5,3.5,2.3,2.3,24,'https://images-na.ssl-images-amazon.com/images/I/41nCQKkmA0L._SX425_.jpg',5,4,1,'02/21/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO035','PTY002', 'andy','BRN003','Fingbox Network Security System','Remote Home Monitoring: See who is at home and keep a history tab on who’s coming and going and when.
Network Security System: Detect nearby devices even if they are not connected to your WiFi.
Parental Control: Pause your children’s internet access in 1-click.
Network Troubleshooting and Bandwidth Analysis: Analyze the bandwidth consumption of devices in your home to identify why the internet is slow.
Internet Security Checks: Checks and alerts you about Internet security risks and malicious threats. Block hackers from accessing your network. Remotely monitor your network and devices from anywhere.
','Fingbox Network Security System - Remote Home Monitoring, Parental Control, Internet Security System, Alerts, Bandwidth Analysis, WiFi & Internet Troubleshooting
',55,'item',3.5,3.5,2.3,2.3,25,'https://images-na.ssl-images-amazon.com/images/I/51h0Hr2x4PL._SL1000_.jpg',5,4,1,'03/07/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO036','PTY002', 'kenny','BRN004','Anker 3-Port USB 3.0 Aluminum Portable Data Hub ','Add 3 USB 3.0 SuperSpeed ports to your PC and enjoy data transfer rates of up to 5Gbps for faster sync times.
1 gigabit ethernet port gives access to superfast network speeds, backward compatible with 10/100 ethernet.
Compact unibody aluminum design effectively saves precious desk space. Green LED indicates normal operation.
Built-in surge protection keeps your devices and data safe and supports hot swapping.
Package contents: Anker 3-Port USB and Ethernet Hub (with 1.3ft USB 3.0 cable), welcome guide, our fan-favorite 18-month warranty and friendly customer service.','Anker 3-Port USB 3.0 Aluminum Portable Data Hub with Gigabit Ethernet Port Network Adapter for Mac, PC, USB Flash Drives and Other Devices
',23,'item',3.5,3.5,2.3,2.3,26,'https://images-na.ssl-images-amazon.com/images/I/41H3gOHUo6L._SX425_.jpg',5,4,1,'03/12/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO037','PTY002', 'kenny','BRN004','3M MODEL 3M-0807-01 NETWORK INTERFACE DEVICE (NID)','Network interface device','3M MODEL 3M-0807-01 NETWORK INTERFACE DEVICE (NID) COMMUNICATION ENCLOSURE FAST SHIPPING!!!
',15,'item',3.5,3.5,2.3,2.3,27,'https://images-na.ssl-images-amazon.com/images/I/31NptTzJpiL._SX425_.jpg',5,4,1,'03/13/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO038','PTY003', 'kenny','BRN005','Portable Charger RAVPower 26800 Battery Packs','Choose the RAVPower Treatment: Entrusted by 100,000+ customers for keeping their devices charged when off the grid
Colossal Battery Capacity: 26800mAh charges most smartphones over 6 times or a tablet 2+ times for an average of 9 days of unrestrained usage per charge
Charges 3 Devices Simultaneously: 3 iSmart 2.0 USB ports provide a powerful total current output of 5.5A. Note: Does not support Qualcomm Quick Charge
High-Speed Recharging: Charges in just 14-15 hours with a 2.4A charger or 23-24 hours with a 1A charger
What You Get: 1 x RAVPower Xtreme Series 26800mAh Portable Charger, 2 x Micro USB Charging Cables, 1 x Carry Pouch, 1 x User Guide & Free 18 Month Warranty','Portable Charger RAVPower 26800 Battery Packs 26800mAh Total 5.5A Output 3-Port Power Bank (2A Input, iSmart 2.0 USB Power Pack) Portable Battery Charger for iPhone, iPad, and other Smart Devices
',59,'item',3.5,3.5,2.3,2.3,28,'https://images-na.ssl-images-amazon.com/images/I/510m5K46wSL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71zG6PnpU0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71lUFx0mk9L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71xIVpWva9L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61WJvKGK7aL._SL1000_.jpg',5,4,1,'03/29/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO039','PTY003', 'kenny','BRN005','Anker PowerCore 26800 Portable Charger','The Anker Advantage: Join the 20The Anker Advantage: Join the 20 million+ powered by Americas leading USB charging brand.
Colossal Capacity: 26800mAh of power charges most phones over 7 times, tablets at least 2 times and any other USB device multiple times.
High-Speed Charging: 3 USB output ports equipped with Ankers PowerIQ and VoltageBoost technology ensure high-speed charging for three devices—simultaneously (Not compatible with Qualcomm Quick Charge).
Recharge 2X Faster: Dual Micro USB (20W) input offers recharge speeds up to twice as fast as standard portable chargers—a full recharge takes just over 6 hours.
What You Get: PowerCore 26800, 2X Micro USB Cable, Travel Pouch, Welcome Guide, our worry-free 18-month warranty and friendly customer service.
 million+ powered by Americas leading USB charging brand.The Anker Advantage: Join the 20 million+ powered by Americas leading USB charging brand.
Colossal Capacity: 26800mAh of power charges most phones over 7 times, tablets at least 2 times and any other USB device multiple times.
High-Speed Charging: 3 USB output ports equipped with Ankers PowerIQ and VoltageBoost technology ensure high-speed charging for three devices—simultaneously (Not compatible with Qualcomm Quick Charge).
Recharge 2X Faster: Dual Micro USB (20W) input offers recharge speeds up to twice as fast as standard portable chargers—a full recharge takes just over 6 hours.
What You Get: PowerCore 26800, 2X Micro USB Cable, Travel Pouch, Welcome Guide, our worry-free 18-month warranty and friendly customer service.
','Anker PowerCore 26800 Portable Charger, 26800mAh External Battery with Dual Input Port and Double-Speed Recharging, 3 USB Ports for iPhone, iPad, Samsung Galaxy, Android and other Smart Devices
',62,'item',3.5,3.5,2.3,2.3,29,'https://images-na.ssl-images-amazon.com/images/I/61Fsgc8OR2L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61oHmMA-LPL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61btJ2X7XXL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61tRGd5qyWL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71bW1y8TQsL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71s2lwCDgJL._SL1500_.jpg',5,4,1,'04/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO040','PTY003', 'andy','BRN005','Anker PowerCore 10000','The Anker Advantage: Join the 10 million+ powered by our leading technology.
Remarkably Compact: One of the smallest and lightest 10000mAh portable charger. Provides almost three-and-a-half iPhone 6s charges or two-and-a-half Galaxy S6 charges.
High-speed-Charging Technology: Ankers exclusive PowerIQ and VoltageBoost combine to deliver the fastest possible charge for any device. Qualcomm Quick Charge not supported.
Certified Safe: Ankers MultiProtect safety system ensures complete protection for you and your devices.
What You Get: Anker PowerCore 10000 portable charger, Micro USB cable, travel pouch, welcome guide, our worry-free 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately
','Anker PowerCore 10000, One of the Smallest and Lightest 10000mAh External Batteries, Ultra-Compact, High-speed Charging Technology Power Bank for iPhone, Samsung Galaxy and More
',76,'item',3.5,3.5,2.3,2.3,30,'https://images-na.ssl-images-amazon.com/images/I/51eelPi3NmL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71wmX7linOL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81IYmsVarDL._SL1500_.jpg,',5,4,1,'04/10/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO041','PTY003', 'andy','BRN005','Anker 20100mAh Portable Charger PowerCore 20100','The Anker Advantage: Join the 10 million+ powered by our leading technology.
Ultra-High Capacity: Weighs as little as a can of soup (12.5 oz) yet charges the iPhone 7 almost seven times, the Galaxy S6 five times or the iPad mini 4 twice.
High-Speed Charging: PowerIQ and VoltageBoost combine to deliver the fastest possible charge(does not support Qualcomm Quick Charge). Recharges itself in 10 hours with a 2 amp charger, phone chargers (generally 1 amp) may take up to 20 hours.
Certified Safe: Ankers MultiProtect safety system ensures complete protection for you and your devices.
What You Get: Anker PowerCore 20100 Portable Charger, Micro USB cable, travel pouch, welcome guide, our fan-favorite 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately.','Anker 20100mAh Portable Charger PowerCore 20100 - Ultra High Capacity Power Bank with 4.8A Output, PowerIQ Technology for iPhone, iPad & Samsung Galaxy & More – Black
',56,'item',3.5,3.5,2.3,2.3,31,'https://images-na.ssl-images-amazon.com/images/I/31MnmAEjDaL.jpg,https://images-na.ssl-images-amazon.com/images/I/61kwBGC9OdL.jpg,https://images-na.ssl-images-amazon.com/images/I/515YoOr59zL.jpg,https://images-na.ssl-images-amazon.com/images/I/41YlRLcJ7cL.jpg',5,4,1,'04/14/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO042','PTY003', 'andy','BRN005','[Upgraded to 6700mAh] Anker Astro E1 Candy-Bar Sized','The Anker Advantage: Join the 10 million+ powered by our leading technology.
Exclusive PowerIQ Technology: Detects your device to deliver its fastest possible charge speed up to 2 amps. Does not support Qualcomm Quick Charge.
Upgraded Capacity: Add over two full charges to an iPhone 7 or 6s or at least one full charge to a 7 Plus, Galaxy S8, Nexus 5 or other smartphone(use your devices original cable).
Incredibly Compact: The size of a small candy bar (3.8 × 1.7 × 0.9in, 4.4oz) it fits perfectly in your pocket. Recharges in 5.5 hours with a 1A adapter (not included) and the included Micro USB cable.
What You Get: Anker Astro E1 Portable Charger, Micro USB Cable, travel pouch, welcome guide, our fan-favorite 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately.
','[Upgraded to 6700mAh] Anker Astro E1 Candy-Bar Sized Ultra Compact Portable Charger, External Battery Power Bank, with High-Speed Charging PowerIQ Technology (Black)
',24,'item',3.5,3.5,2.3,2.3,32,'https://images-na.ssl-images-amazon.com/images/I/31C3%2Bz6ixsL.jpg,https://images-na.ssl-images-amazon.com/images/I/416HCEVnqdL.jpg,https://images-na.ssl-images-amazon.com/images/I/41Cz0XHAZtL.jpg,https://images-na.ssl-images-amazon.com/images/I/5164W97O0DL.jpg,https://images-na.ssl-images-amazon.com/images/I/41x0ml%2BG9YL.jpg',5,4,1,'04/09/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO043','PTY004', 'tienminh','BRN006','Laptop Backpack, Sosoon Business Bags with USB Charging Port','High-Quality Material: Made of water repellent, tear-resistant and anti-scratch 1680D double-pile polyester for lasting durability.
Multi-Compartment: 14"x 5.7" x 19.5" (L*W*H). Generous main compartments with padded sleeve for 15.6-inch laptops and several functional pockets allow you to keep all of your gear secure and organized in its place.
External USB Interface: You can easily and conveniently charge your phone, tablet and other devices without opening up the backpack.Power bank not included,we suggest you to choose Ankers Power Bank:http://a.co/iP6SBVu.
Anti-Theft: The hidden zipper and invisible pockets located on the back keep your laptop and other valuables safe and handy.
Comfort: The innovative weight balance design makes you feel 20%-25% less weight. The body side and shoulder straps have excellent thick breathable mesh padding, offering your back plenty of cushioned comfort.','Laptop Backpack, Sosoon Business Bags with USB Charging Port Anti-Theft Water Resistant Polyester School Bookbag for College Travel Backpack for 15.6-Inch Laptop and Notebook, Black',29,'item',3.5,3.5,2.3,2.3,33,'https://images-na.ssl-images-amazon.com/images/I/712OSZcgHiL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71BZhbjizgL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81tpFirN8YL._SL1500_.jpg',5,4,1,'05/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO044','PTY004', 'tienminh','BRN006','Veking 13 - 13.3 Inch Laptop Bag Fashion Tablet Bag ','The Laptop Bag designed for Apple MacBook 13 Inch,alse fits most laptops with up to 12-13.3 Inch
2 Large,Zippered Exterior Pockets: let you securely transport digital devices,pens,keys,earphone and other small things
Durable Neoprene Material and Soft Foam cushioned interior help protect your macbook from bumps and scrapes
Slimline Design: enables you to slide your sleeve into backpacks,briefcases and other bags with ease
Soft Handbag：helps ensure comfortable carrying','Veking 13 - 13.3 Inch Laptop Bag Fashion Tablet Bag Carrying Sleeve Case for Macbook Air Pro (Retina) 12 13 Inch and Slim 12 13 Inch Laptop
',21,'item',3.5,3.5,2.3,2.3,34,'https://images-na.ssl-images-amazon.com/images/I/61VoOa5FCNL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71B-GQxDJNL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/714tSKBHkRL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61YRRUywtxL._SL1000_.jpg',5,4,1,'05/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO045','PTY004', 'tienminh','BRN006','Laptop USB Backpack, TanTaiNick Anti Thief Tear, Waterproof','USB Cord Charge: There is a USB cord can connect your power bank inside and your phone or pad outside, just need to plug in the usb cable from the cord outside,then charging.
High-Quality Material,The backpack has high-quality Oxford fabric that can anti-rain,anti-dust,and so on
High-Capacity: 40L Capacity,you can put your computer, pencil cases, cell phones, documents and so on;and the computer compartment part can protect your computer well
The Zipper Pocket: There is an external zipper pocket that allows you to use your single hand to take your items, it can easily find your items. Provide you the best space for your items;
Warranty: All of our bags have 1-YEAR WARRANTY(Replacement or Refund). Any problems with your bag, please contact us.','Laptop USB Backpack, TanTaiNick Anti Thief Tear, Waterproof And Dust-proof Travel Bags, Built-in USB Cable Charging Backpack, Fits up to 15 Inch Macbook Computer Notebooks and so on (Black-Gray)
',30,'item',3.5,3.5,2.3,2.3,35,'https://images-na.ssl-images-amazon.com/images/I/81zL2t2b4RL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61SuHHCGQkL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71unXe%2Bag0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71y9EmDdw%2BL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71d2Bmw8gIL._SL1000_.jpg',5,4,1,'05/10/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO046','PTY004', 'tienminh','BRN006','15.6-Inch Laptop Shoulder Bag Case Sleeve With Handle','15.6-Inch Laptop shoulder bag dimension: 15.8 x 0.6 x 11.8 Inch (LxWxH), compatible with 14" 14.1" 15" 15.4" 15.6 Inch laptop and macbook pro 15.
Super soft Neoprene material protect your laptop from dust, scratches and bumps.
Double zipper on the main compartment glides smoothly and allow convenient access to your laptop. External pocket for adapter, mouse and other small items.
The shoulder strap is adjustable and detachable. More, the laptop bag also have two outside padded handle for carrying.
Same vivid image on both side of bag, very stylish and fashionable. Can be repeated washing, easy to dry, never fade.','15.6-Inch Laptop Shoulder Bag Case Sleeve With Handle and extra pocket For 14" 14.1" 15" 15.6 Inch MacBook/Ultrabook/HP/Acer/Asus/ Dell/Lenovo/Thinkpad (Purple)
',18,'item',3.5,3.5,2.3,2.3,36,'https://images-na.ssl-images-amazon.com/images/I/71OFh8XgRuL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/61OzIW0jOUL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71SUgydvbdL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/813iCPtwJzL._SL1200_.jpg,',5,4,1,'05/15/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO047','PTY004', 'tienminh','BRN006','Ytonet Laptop Briefcase,15.6 Inch Laptop Bag,Business Office Bag for Men Women','MULTIFUNCTIONAL COMPARTMENT: Huge-roomy and 6 compartments can provide a separated space for iPad pro, macbook Pro, A4 files, books, laptop, tablet, pens, wallet, keys, clothes and more. Organizer Briefcase Dimensions FIXS UP TO 15.6 inch laptop(under 17 inch laptop)
DURABLE and LUXURIES:The Laptop case made of Durable Eco-Friendly Nylon Fabric mildly waterresistant function and can be more durable and high-end luxuries
PADDED LAPTOP COMPARTMENT: Made of high quality comfortable fabric, features a thick foam padding laptop compartment with velcro closure protecting your laptop from accidental bump, shock, scratch
COMFORTABLE and COMPATIBLE: Removeable and adjustable PU padding shoulder strap, and dual sturdy handles for long time comfortably carrying. Suitable for most 15.6inch laptops. Compatible with / Acer Chromebook / Acer Aspire / Acer Flagship / HP pavilion / Dell inspiron 15 / Dell inspiron 13 / MacBooks / Macbook air / Notebooks / Tablet / Ultrabooks / PC Computer devices / ASUS / Apple / Windows / Ipod / Netbook / Mac
CONVENIENCE: A wide luggage belt is convenient for fixing the bag on the trolley of a luggage. It is really helpful for your journey to any where','Ytonet Laptop Briefcase,15.6 Inch Laptop Bag,Business Office Bag for Men Women,Stylish Nylon Multi-Functional Shoulder Messenger Bag for Notebook/Computer/Tablet/MacBook/Acer/HP/Dell/Lenovo,Black Grey
',23,'item',3.5,3.5,2.3,2.3,37,'https://images-na.ssl-images-amazon.com/images/I/91SO5shaXCL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71j7PVBnRuL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71zzbsg4PYL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/612Vf8pTM7L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71g5iDQXchL._SL1500_.jpg',5,4,1,'05/20/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO048','PTY005', 'thanhlong','BRN013','UGREEN HDMI 2.0 Cable 18Gbps Premium High Speed HDMI Cable','4K @ 60Hz HDR Max, 3D, 18 Gbps - easily connect the computer, Blu-ray/DVD player, AV receiver, Apple TV, Roku streaming media player, Cable Box, Play Station 3/4, Xbox One/360, Nintendo Wii, or other HDMI compatible devices to your Ultra 4K TV (UHD TV), HDTV, monitor, or projector with a big screen;
Multi-functional Support - Audio Return Channel (ARC), HDMI Ethernet Channel (HEC), 48 Bit Deep Color, 32 channel audio, HDCP, Dolby True HD 7.1 audio, and 3D video,Plug and Play;
Category 2 Certified HDMI wire supports resolutions up to 4Kx2K (UHD) including 4096x2160, 3840x2160, 2560x1600, 2560x1440, 1920x1200, and 1080p Full HD,Backwards compatible with previous HDMI Standards (v1.4 & v1.3);
With gold-plated connectors, 28AWG bare copper conductors and triple shielding, this HDMI cord can make sure superior conductivity, maximum performance, anti-interference and long service time, helping to maintain the integrity and purity of the digital signal;
What you receive: 1*UGREEN HDMI 2.0 Cable with 12 months warranty and manufacturer lifetime service,Easy-to-reach Customer Service to solve your problems within 24 hours,If you have any question that is not explained here, please feel free to contact us.','UGREEN HDMI 2.0 Cable 18Gbps Premium High Speed HDMI Cable 4K HDR Support 4K@60Hz, 3D, Ethernet and ARC for Nintendo Switch, Xbox, PS3/PS4, Blu ray Player, Roku, Projector, HDTV, PC/Laptop etc
',9,'item',3.5,3.5,2.3,2.3,38,'https://images-na.ssl-images-amazon.com/images/I/61OWGlT9U0L._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61sutjbxQXL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61d%2B1LdAfkL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/719eQvHT-OL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/510EuKDBhNL._SL1001_.jpg',5,4,1,'05/25/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO049','PTY005', 'thanhlong','BRN013','VicTsing Cablor Gold Plated 1080P HDMI','Compact and Portable converter for connecting a HDMI contained device to a TV, monitor or projector with VGA port. Applicable to share videos in home theater, do presentations, deliver a speech, teaching and etc.
High Resolution. Support HD monitor or projector resolution up to 1920 x1080(HD) including 720P and 1600 x1200.
Built-in Innovative IC chip. Actively transmit the HDMI digital signal into VGA analog signal. Allow you receive high definition and flawless video. Connect the included USB power cable to the adapter and a USB computer port or wall charger to provide additional power.
Gold-plated connector resists corrosion and abrasion. Strengthen signal transmission capability.
Highly Compatible with HDMI equipped PC, laptop, set top box, Apple TV, Sony computer, MacBook Pro, Raspberry Pi, Chromebook, Roku streaming media player.','VicTsing Cablor Gold Plated 1080P HDMI to VGA Video Converter Adapter with Micro USB Power for PC Laptop HDTV Projector,Support Sony and Apple Devices',10,'item',3.5,3.5,2.3,2.3,39,'https://images-na.ssl-images-amazon.com/images/I/61EnunEx-OL._SL1280_.jpg,https://images-na.ssl-images-amazon.com/images/I/61vk5O1ayQL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61bh1kkj7gL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61-U%2BPA8RIL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61GWx0Kf1nL._SL1000_.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO050','PTY005', 'thanhlong','BRN013','Laptop Stand, SUPRBIRD Foldable Portable Tablet','PORTABLE ---Portable and foldable notebook stand, weighing about 100g (0.22lbs). No assembly required.Petite size easily into the bag.Enjoy efficiency at the coffee shop, library or anywhere you go
QUALITY & STYLE---Mainly composed of solid aluminum alloy, durable. With soft silicone parts and anti slip base design to protect devices & tablets safely and securely,Brushed aluminum style is designed to match any devices
COMPATIBLE & ADJUSTABLE---Adjust the stands width, height and angle, compatible with 7"-15"Laptop/Notebook/Macbook/iPad/Tablet/Books.Stable enough for direct typing & touch screen
DEGREES ADJUSTED---Height can be adjusted between 30 to 70 degrees in order to adapt to different height groups to using comfortly. Relax your neck & body
100% MONEY-BACK GUARANTEE---SUPRBRID SUPPORTS a 100% guarantee that fully money BACK if not satisfied','Laptop Stand, SUPRBIRD Foldable Portable Tablet Stand Aluminum Ultralight Support for Laptop/ Notebook/ iPad, Adjustable Height Width & Angle 
',28,'item',3.5,3.5,2.3,2.3,40,'https://images-na.ssl-images-amazon.com/images/I/61NzQh8Cf9L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/51i8rsFPnvL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81iuoGcJ3RL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61BECbvCcNL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71zBIkkxORL._SX522_.jpg',5,4,1,'05/30/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO051','PTY005', 'thanhlong','BRN013','VicTsing Gold-Plated HDMI to VGA Converter Adapter','Ultra-MINI, UNIQUE DESIGN. HDMI TO VGA converter can transport video from HDMI compatible device to a monitor or projector with VGA port. With this gadget, you can enjoy HD video in large screen.
ADVANCED ACTIVE IC CHIP. Built-in active IC chip converts HDMI digital signal to VGA analog signal.
SUPPORT HIGH RESOLUTION. The HDMI to VGA converter supports resolution up to 1920x1080（1080p Full HD） including 720p and 1600x1200 for HD monitors or projectors.
GOLD-PLATED HDMI INTERFACE. Gold-plated HDMI connector resists corrosion and abrasion, and enhances the signal transmission performance.
LARGE COMPATIBILITY. The HDMI-VGA converter is compatible with laptop, TVBOX, or other devices with HDMI port. VGA female port can be connected to projectors, HDTV, monitors/Displayer and other device with VGA male port.But this product is not compatible with Apple and Sony Devices while the New Version can support them.','VicTsing Gold-Plated HDMI to VGA Converter Adapter for PC, Laptop, DVD, Desktop and other HDMI Input Devices - Black (VS1-VC38BVT-VD)',9,'item',3.5,3.5,2.3,2.3,41,'https://images-na.ssl-images-amazon.com/images/I/51zf2A8p0KL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/613DTyCuVYL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61J1nbi4l0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61VUMTSZ7UL._SL1000_.jpg',5,4,1,'06/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO052','PTY005', 'thanhlong','BRN013','Power Strip Tower JACKYLED Surge Protector Electric Charging Station','MAX WATTAGE: Due to different voltages in different areas, this product is designed to support 110V-250V. If it is used under 125V, the max power will be 125V x 13A = 1625W,if under 250V, the max power can reach 3000W. This Surge Protector（780Joule, 13A） with 10 outlets and 4 USB Ports has large compitibility that can charge various appliances and devices at the same time to meet your power demands with safe guarantee.
SMART USB PORTS: The 4 Intelligent USB charging ports (Total 5 V/2.1A) can charge at the same time cellphone, ipad, MP3, digital camera, tablet etc. There would be an adjustable saftest max current according to different devices for protection when giving a quick charge. Max Output current per port is up to 2.1A.
SAFE & RELIABLE: RoHS, CE & FCC Certificates. This electric outlet is lightning-proof, overload protected and surge protected and has a fire-retardant shell. It will automatically cut power to protect connected devices when voltage surge is detected. With a 14-gauge system and 3-Line 780-Joule surge-suppression rating, the unit optimally transfers power and helps keep plugged-in devices safe, especially during storms and power outages.','Power Strip Tower JACKYLED Surge Protector Electric Charging Station 3000W 13A 16AWG 10 Outlet Plugs with 4 USB Slot + 6ft Cord Wire Extension Universal Socket for PC Laptops Mobile',25,'item',3.5,3.5,2.3,2.3,42,'https://images-na.ssl-images-amazon.com/images/I/614iSR6lfwL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71q%2BonWlbdL._SL1500_.jpg, https://images-na.ssl-images-amazon.com/images/I/81ddAkSuREL._SL1500_.jpghttps://images-na.ssl-images-amazon.com/images/I/71Xv3-kEPSL._SL1500_.jpg,',5,4,1,'06/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO053','PTY006', 'uyenle','BRN014','Computer Case Fan120mm with Blue LED and PWM','120mm Computer Case Fan, the most popular and commonly used size computer case fan
Case Fan with Blue LED, nice blue lighting effect to decorate computer
Case Fan with Advanced Hydraulic Bearing, it significantly reduces noise and improves performance
PWM (Pulse Width Modulation) Case fan at 500 - 1500RPM rotating speed and comes with 4-pin connector to fully support PWM function
Super Quiet with 6.9 - 26.2 dBA Noise Level (also depends on the rotating speed. PWM feature will reduce rotating speed during low temperature and increase it when temperature rises up)','Computer Case Fan120mm with Blue LED and PWM (Pulse Width Modulation) Function, Very Quiet Cooling Fan from Advanced Hydraulic Bearing, Rosewill Model RWCB-1612
',12,'item',3.5,3.5,2.3,2.3,43,'https://images-na.ssl-images-amazon.com/images/I/81on-eeO96L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81xDmpGKOML._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/91gOz9T7nLL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71epHFfWCWL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/7166kNf5sCL._SL1500_.jpg',5,4,1,'06/10/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO054','PTY006', 'uyenle','BRN014','AC Infinity AXIAL 8038, Muffin Cooling Fan, 115V AC 80mm by 80mm by 38mm Low Speed','Designed for projects that requires cooling or ventilation,or as a replacement fan for various products.
Includes a heavy-duty aluminum fan with power plug cord, two fan guards, and mounting screw set.
Dual-ball bearings have a lifespan of 67,000 hours and allows the fans to be laid flat or stand upright.
Low Speed: Has a lower noise and airflow rating than high speed models.
Dimensions: 80 x 80 x 38 mm | Airflow: 23 CFM | Noise: 28 dBA | Bearings: Dual Ball','AC Infinity AXIAL 8038, Muffin Cooling Fan, 115V AC 80mm by 80mm by 38mm Low Speed
',13,'item',3.5,3.5,2.3,2.3,44,'https://images-na.ssl-images-amazon.com/images/I/61x0MG3xpeL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61G6m1rs3TL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71gO962HtNL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/618J8j33jxL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71o2BT0sM8L._SL1000_.jpg;',5,4,1,'06/15/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO055','PTY006', 'uyenle','BRN014','Cooler Master Rifle Bearing 80mm Silent Cooling Fan for Computer Cases and CPU Coolers
','Strong air flow to enhance cooling performance
Silent operation for case cooling
RoHS compliance for protecting the environment
Voltag : 12 VDC ,Current (Ampere) : 0.09A (Max 0.11A)
Fan Life Expectancy : 50,000 hours ,Input (Watt) : 1.2W
Speed (R.P.M.) : 2000 R.P.M. ± 10%','Cooler Master Rifle Bearing 80mm Silent Cooling Fan for Computer Cases and CPU Coolers
',6,'item',3.5,3.5,2.3,2.3,45,'https://images-na.ssl-images-amazon.com/images/I/81cBgYCEhGL._SL1500_.jpg',5,4,1,'06/20/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO056','PTY006', 'uyenle','BRN014','AC Infinity AXIAL 8038, Muffin Cooling Fan, 115V AC 80mm by 80mm by 38mm Low Speed
','Designed for projects that requires cooling or ventilation,or as a replacement fan for various products.
Includes a heavy-duty aluminum fan with power plug cord, two fan guards, and mounting screw set.
Dual-ball bearings have a lifespan of 67,000 hours and allows the fans to be laid flat or stand upright.
Low Speed: Has a lower noise and airflow rating than high speed models.
Dimensions: 80 x 80 x 38 mm | Airflow: 23 CFM | Noise: 28 dBA | Bearings: Dual Ball','AC Infinity AXIAL 8038, Muffin Cooling Fan, 115V AC 80mm by 80mm by 38mm Low Speed
',17,'item',3.5,3.5,2.3,2.3,46,'https://images-na.ssl-images-amazon.com/images/I/61x0MG3xpeL._SL1000_.jpg, https://images-na.ssl-images-amazon.com/images/I/61G6m1rs3TL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71gO962HtNL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61ZOvZ2gADL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71mzuGv9tJL._SL1000_.jpg',5,4,1,'06/23/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO057','PTY006', 'uyenle','BRN014','Mini Handheld Fan, VersionTech Foldable Personal Portable Desk Desktop Table Cooling Fan','When you go outside, you can put it in the bag with you, especially suitable for summer travel or outdoor sports, you can take it to anywhere, like NBA/World Cup Qualifiers/Football Game/or any activity.','Mini Handheld Fan, VersionTech Foldable Personal Portable Desk Desktop Table Cooling Fan with USB Rechargeable Battery Operated Electric Fan for Office Room Outdoor Household Traveling (3 Speed, Blue)
',13,'item',3.5,3.5,2.3,2.3,47,'https://images-na.ssl-images-amazon.com/images/I/61x0MG3xpeL._SL1000_.jpg, https://images-na.ssl-images-amazon.com/images/I/61G6m1rs3TL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71gO962HtNL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61ZOvZ2gADL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71mzuGv9tJL._SL1000_.jpg',5,4,1,'06/26/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO058','PTY007', 'uyenle','BRN016','UGREEN SD Card Reader USB 3.0 ','A Good Companion for PC: UGREEN USB 3.0 card reader easily expands SD and TF slot on your computer. It supports SDXC/SDHC/SD/MMC/RS-MMC/Micro SD/TF /Micro SDXC/Micro SDHC/UHS-I memory cards.
Read and Write on 2 Cards Simultaneously(Dual Ports): The SD card reader could read and write on two cards at the same time to keep you away from the hassle of constant unplugging and re-plugging.
Super Speed & High Capacity: Supports up to 512G SD/Micro SD card read and super speed up to 5Gbps - 10X faster than USB 2.0 (480 Mbps), which allows you to transfer HD movies or files in just seconds through USB 3.0. Backward compatible with USB 2.0/1.1.
Broad Compatibility: For the USB 3.0 connection, compatible with Windows XP/Vista/7/8/8.1/10, Mac OS, Linux, Chrome OS.
Easy Installation: plug and play, no driver needed on the compatible devices. Portable Kit: with slim and sleek design, this tiny usb card reader is a great kit for travel.','UGREEN SD Card Reader USB 3.0 Dual Slot Flash Memory Card Reader TF, SD, Micro SD, SDXC, SDHC, MMC, RS-MMC, Micro SDXC, Micro SDHC, UHS-I for Mac, Windows, Linux, Chrome, Read 2 Cards Simultaneously
',16,'item',3.5,3.5,2.3,2.3,48,'https://images-na.ssl-images-amazon.com/images/I/515IkovDrsL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61mMYm1gIdL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/613jWL16SGL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61qydO1pJLL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61XPLtzwvdL._SL1001_.jpg',5,4,1,'06/27/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO059','PTY007', 'uyenle','BRN016','USB Card Reader, UNITEK Aluminum 3-Slot USB 3.0','USB 3.0 Multiple Card Reader: Fast Data/Files Access and Transfer Rate Super-Speed (5Gps) / High-Speed (480Mbps) / Full-Speed (12 Mbps). Backward compatible with USB 2.0
Read 2 Cards Simultaneously: the compact flash card reader can use ANY TWO of card at a time, transfering data between SD card to CF card, SD card to micro SD card and micro SD card to CF card
3-Port Card Reader Slot: Support SDHC, SDXC, Micro SD, Micro SDHC (UHS-I), Micro SDXC (UHS-I) and CF Type I/MD/MMC,Ideal for transferring high-resolution images and video recordings. microSD, SD, SDHC/SDXC, CF cards up to 7 TB
LED on the flash memory card reader verifies USB bus power and active data file transfer. Plug & Play Installation. No external drivers to download
What We Offer: 1 x USB 3.0 USB Card Reader, Cable Length - 120CM ( 4 feet, 48 inches) , 1 x Users manual, 2-year warranty quality guarantee, 26h friendly customer service and email support','USB Card Reader, UNITEK Aluminum 3-Slot USB 3.0 Flash Memory Card Reader, Supports SanDisk Compact Flash Memory Card & Lexar Professional CompactFlash Card, 24 Months Warranty-4ft(Black)
',23,'item',3.5,3.5,2.3,2.3,49,'https://images-na.ssl-images-amazon.com/images/I/515IkovDrsL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61mMYm1gIdL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/613jWL16SGL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61qydO1pJLL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61XPLtzwvdL._SL1001_.jpg',5,4,1,'07/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO060','PTY007', 'uyenle','BRN016','Geekgo SD Card Reader,Micro SD USB Memory Card Reader Adapter','This Card Reader compatible with all your devices with 3 interfaces: Lightning adapter for iOS devices,Micro USB adapter for Android devices,USB adapter for computers/Macs.Compatible for Apple, iPhone/iPad/Android phones/Mac/PC/Camera. Compact design, portable to bring, easy to use.','Geekgo SD Card Reader,Micro SD USB Memory Card Reader Adapter Viewer for iPhone iPad Android Mac - Supports Lightning Micro USB OTG 3 in 1 (Black)
',9,'item',3.5,3.5,2.3,2.3,50,'https://images-na.ssl-images-amazon.com/images/I/515IkovDrsL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61mMYm1gIdL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/613jWL16SGL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61qydO1pJLL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61XPLtzwvdL._SL1001_.jpg',5,4,1,'07/07/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO061','PTY007', 'uyenle','BRN016','Trail Game Camera Card Viewer Reader for iPhone iPad, SD Card Reader','The best way to transfer photos & videos from digital camera card to iPhone/iPad in a short time
Support standard photo formats: JPEG and RAW,Support SD and HD video formats: H.264 and MPEG-4
14MB/S~16MB/S High speed data transfer save your time than WiFi transfer
Support Phone 5/5c/5s/6/6 Plus /6s / 6s Plus/SE /7/ 7 Plus,iPad with Retina display: iPad Mini/ Mini 2/ Mini 3/ Mini 4/Air/ Air 2 /Pro 9.7/12.9-Inch
Release the space of your SD Card and backup you memory card','Trail Game Camera Card Viewer Reader for iPhone iPad, SD Card Reader for iPhone 6 /6S/6S Plus/5/5S/7/7 Plus/8/X, Lightning SD Card Camera Reader Adapter, No App Required
',9,'item',3.5,3.5,2.3,2.3,51,'https://images-na.ssl-images-amazon.com/images/I/6154R4OneqL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61EUpN6lSjL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81%2B0rpguChL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Q7XXdrbvL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Y1EgeP-1L._SL1500_.jpg',5,4,1,'07/10/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO062','PTY007', 'uyenle','BRN016','SD and Micro SD Card Reader - Jelly Comb PC, OTG Tablets, Android Smartphones','USB 3.0 card reader for direct data exchange between PC / tablet / smartphones and SD / SDXC / SDHC / Micro SD / Micro SDXC / Micro SDHC memory cards
2-in-1 USB-A / Micro-USB adapter enables a universal compatibility with PC, tablets and Android smartphones that support OTG function
A additional USB 3.0 Hub is offered to connect a mouse, keyboard or other small USB gadget to your PC, tablets or smartphones, in case they have limited USB port
Works with Windows 7 / 8 / 8.1 / 10 (32/64-bit), Mac OS X 10.x, Android version 4.0 and above
Plug and play, no driver required (exclude LG phone series)','SD and Micro SD Card Reader - Jelly Comb PC, OTG Tablets, Android Smartphones USB 3.0 Card Reader, with USB-A and Micro-USB Adapter, USB 3.0 Hub Offered, Silver
',9,'item',3.5,3.5,2.3,2.3,52,'https://images-na.ssl-images-amazon.com/images/I/71yndIWpd7L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/615ykjShvIL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Eja2MzkoL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61Lq76V1l3L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/714oPB90BEL._SL1500_.jpg',5,4,1,'07/14/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO063','PTY008', 'lylienkiet','BRN005','Anker PowerCore+ mini, 3350mAh Lipstick-Sized Portable Charger','The Anker Advantage: Join the 10 million+ powered by our leading technology.
High-speed Charging Technology: PowerIQ detects your device to deliver its fastest possible charge speed up to 1 amp.
Ultra Compact: Our original lipstick-shaped aluminum design (3.7 × 0.9 × 0.9in, 3oz). Recharges in 3-4 hours with a 1 amp adapter (not included) and the included Micro USB cable.
Capacity: One of the most powerful mini chargers on the market. Adds over one charge (6 hours talktime) to an iPhone 6, almost one charge to a Galaxy S6 or around one charge to most other phones.
What You Get: Anker PowerCore+ mini (3350mAh Premium Aluminum Portable Charger), Micro USB cable, travel pouch, welcome guide, our fan-favorite 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately.','Anker PowerCore+ mini, 3350mAh Lipstick-Sized Portable Charger (3rd Generation, Premium Aluminum Power Bank), One of the Most Compact External Batteries
',16,'item',3.5,3.5,2.3,2.3,53,'https://images-na.ssl-images-amazon.com/images/I/31Nc5rgux8L.jpg,https://images-na.ssl-images-amazon.com/images/I/41%2BxmtXZg6L.jpg,https://images-na.ssl-images-amazon.com/images/I/412p0tDJS7L.jpg,https://images-na.ssl-images-amazon.com/images/I/41hc2xsi4YL.jpg,https://images-na.ssl-images-amazon.com/images/I/51qX80fzfuL.jpg',5,4,1,'07/18/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO064','PTY008', 'lylienkiet','BRN005','[Upgraded to 6700mAh] Anker Astro E1 Candy-Bar Sized Ultra Compact','The Anker Advantage: Join the 10 million+ powered by our leading technology.
Exclusive PowerIQ Technology: Detects your device to deliver its fastest possible charge speed up to 2 amps. Does not support Qualcomm Quick Charge.
Upgraded Capacity: Add over two full charges to an iPhone 7 or 6s or at least one full charge to a 7 Plus, Galaxy S8, Nexus 5 or other smartphone(use your devices original cable).
Incredibly Compact: The size of a small candy bar (3.8 × 1.7 × 0.9in, 4.4oz) it fits perfectly in your pocket. Recharges in 5.5 hours with a 1A adapter (not included) and the included Micro USB cable.
What You Get: Anker Astro E1 Portable Charger, Micro USB Cable, travel pouch, welcome guide, our fan-favorite 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately.','[Upgraded to 6700mAh] Anker Astro E1 Candy-Bar Sized Ultra Compact Portable Charger, External Battery Power Bank, with High-Speed Charging PowerIQ Technology (Black)
',19,'item',3.5,3.5,2.3,2.3,54,'https://images-na.ssl-images-amazon.com/images/I/31Nc5rgux8L.jpg,https://images-na.ssl-images-amazon.com/images/I/41%2BxmtXZg6L.jpg,https://images-na.ssl-images-amazon.com/images/I/412p0tDJS7L.jpg,https://images-na.ssl-images-amazon.com/images/I/41hc2xsi4YL.jpg,https://images-na.ssl-images-amazon.com/images/I/51qX80fzfuL.jpg',5,4,1,'07/11/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO065','PTY008', 'lylienkiet','BRN005','Anker PowerCore 10000, One of the Smallest','The Anker Advantage: Join the 10 million+ powered by our leading technology.
Remarkably Compact: One of the smallest and lightest 10000mAh portable charger. Provides almost three-and-a-half iPhone 6s charges or two-and-a-half Galaxy S6 charges.
High-speed-Charging Technology: Ankers exclusive PowerIQ and VoltageBoost combine to deliver the fastest possible charge for any device. Qualcomm Quick Charge not supported.
Certified Safe: Ankers MultiProtect safety system ensures complete protection for you and your devices.
What You Get: Anker PowerCore 10000 portable charger, Micro USB cable, travel pouch, welcome guide, our worry-free 18-month warranty and friendly customer service. Lightning cable for iPhone / iPad sold separately','Anker PowerCore 10000, One of the Smallest and Lightest 10000mAh External Batteries, Ultra-Compact, High-speed Charging Technology Power Bank for iPhone, Samsung Galaxy and More
',26,'item',3.5,3.5,2.3,2.3,55,'https://images-na.ssl-images-amazon.com/images/I/71wmX7linOL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81IYmsVarDL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/51eelPi3NmL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71s2lwCDgJL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/714MHHjJI%2BL._SL1500_.jpg',5,4,1,'07/26/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO066','PTY008', 'lylienkiet','BRN005','OEM Original Home Wall Travel AC DC Battery Charger for Verizon LG smartphones and Cell Phones','MicroUSB, Factory original 100-240 Volt AC DC Battery Home Charger. Keep an extra charger handy at home or in the office.
Safely charge your phone from your car using the original authentic brand! Enhanced internal circuitry to manage charging status and prevent over- and under-charging. Compact size make it easier to store or pack for traveling.
Using the authentic OEM brand will ensure your phones warranty is never voided!
Use of this official charger will prolong your batteries life compare to others! It also works with any other brand cell phones that use the same plug.
Compatible with: Verizon LG Octane - LG Revolution - LG Versa VX9600 - NEW','OEM Original Home Wall Travel AC DC Battery Charger for Verizon LG smartphones and Cell Phones
',7,'item',3.5,3.5,2.3,2.3,56,'https://images-na.ssl-images-amazon.com/images/I/51sUw%2BXlLeL.jpg,https://images-na.ssl-images-amazon.com/images/I/51sUw%2BXlLeL.jpg',5,4,1,'08/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO067','PTY008', 'lylienkiet','BRN005','OEM Original Home Wall Travel','MicroUSB, Factory original 100-240 Volt AC DC Battery Home Charger. Keep an extra charger handy at home or in the office.
Safely charge your phone from your car using the original authentic brand! Enhanced internal circuitry to manage charging status and prevent over- and under-charging. Compact size make it easier to store or pack for traveling.
Using the authentic OEM brand will ensure your phones warranty is never voided!
Use of this official charger will prolong your batteries life compare to others! It also works with any other brand cell phones that use the same plug.
Compatible with: Verizon LG Octane - LG Revolution - LG Versa VX9600 - NEW','OEM Original Home Wall Travel AC DC Battery Charger for Verizon LG smartphones and Cell Phones
',7,'item',3.5,3.5,2.3,2.3,57,'https://images-na.ssl-images-amazon.com/images/I/51sUw%2BXlLeL.jpg,https://images-na.ssl-images-amazon.com/images/I/51sUw%2BXlLeL.jpg',5,4,1,'08/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO068','PTY009', 'quocanh','BRN017','Jiyaru Women Embroidered Bag Cellphone Wallet Crossbody Bag Mini Shoulder Bag
','Upper: Canvas, Lining: Polyester cotton
Size( L x W x H ): 5.51 x 1.97 x 7.48 inch / 14 x 5 x 19 cm, Strap Length: 51.18 inch / 130 cm, adjustable
Closure Type: zipper, suction button
Internal Capacity: phone, wallet, tissue, etc. multilayer design, neat and convenient
Canvas shoulder bag, suitable for daily life
Package Contains: 1 Piece x Women Bag','Jiyaru Women Embroidered Bag Cellphone Wallet Crossbody Bag Mini Shoulder Bag
',13,'item',3.5,3.5,2.3,2.3,58,'https://images-na.ssl-images-amazon.com/images/I/713tfuNKQTL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Mkb4PT3eL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81LJC89PYrL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71fKD9zrR7L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71hf1IUenML._SX522_.jpg',5,4,1,'08/09/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO069','PTY009', 'quocanh','BRN017','Yookat Set of 4 Vintage Canvas Student Pen Pencil Case Stationery','SOFT DURABLE CANCAS MATERIAL: Each bag is constructed well with lightweight canvas material, inside with nylon liner. Soft touching feeling and wear resistance. The bags are washable, durable for long time. They are unique with different prints with a Paris theme, vintage design make them more chic and classic.
MULTIFUNCTIONAL STORAGE BAG: The bags size 7.5"x3.5"(19 x 9cm), large capacity can hold many items. It can storage many pens,pencils,pencil sharpener, eraser that a student needs. It also can help you store keys, cards, cell phone,coins,cash etc. And it can be used as makeup pouch that contains your dialy essential cosmetics.
SMOOTH ZIPPER: Each pouch has a zipper that is a really nice quality and glides effortlessly. Open and close smoothly, protect your pencils, cards, cosmetics from dropping and dust. Pencils or pens cannot poke through the canvas, everything is held securely and neatly inside, keep your belongings organized.
PORTABLE FOR TRAVEL: These pouches are small and lightweight while contains many stuffs. Portable and convenient to carry with you. You do not need to take a big bag for outing and travel, just a simple pouch solve your storage problem.
UNISEX PRACTICAL POUCH: These vintage pencil bags are gender neutral and could be used by either males or females. The neutral color scheme and design is classy and elegant in a way, which are appropriate for anyone. It is a nice gift for children as stationery case, or storage pouch for your friends. Package include 4 pieces of different colors and patterns bags that durable and resuable, you can change according to your needs.','Yookat Set of 4 Vintage Canvas Student Pen Pencil Case Stationery Pencil Holder Coin Purse Key Pouch Cell Phone Cases Cosmetic Makeup Bag School Office Travel Multifunction...  
',6,'item',3.5,3.5,2.3,2.3,59,'https://images-na.ssl-images-amazon.com/images/I/713tfuNKQTL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Mkb4PT3eL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81LJC89PYrL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71fKD9zrR7L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71hf1IUenML._SX522_.jpg',5,4,1,'08/13/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO070','PTY009', 'quocanh','BRN017','Augbunny 100% Cotton 16oz Canvas','Made from 100% cotton 16oz super strong quality canvas.
Zipper closure keep contents clean and secure
Size: 7.5" by 4.5" with 2 zipper pockets, Color: Black
Great for storing and organizing cellphone, coin, cosmetics, stationery and all other small things.
Each pack contains 5 bags','Augbunny 100% Cotton 16oz Canvas Zipper Makeup Pouch, Coin Purse, Cellphone Purse, Pen / Pencil Case 5-pack
',9,'item',3.5,3.5,2.3,2.3,60,'https://images-na.ssl-images-amazon.com/images/I/61Yq%2BegT0VL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/51LFp7uLjzL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/51LFp7uLjzL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71YW6DGit%2BL._SL1000_.jpg',5,4,1,'08/17/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO071','PTY009', 'quocanh','BRN017','Cell Phone Case iPhone Samsung PU Leather Cross body Purse with Shoulder Strap Wallet Cosmetic Bag
','STRONG MATERIAL: High Quality PU Lizard Leather (smooth, soft feel) Envelope flap with Gold Hardware on opening/closing clasp to secure your items.
CLASSIC SIZE: 4.1" (L) x 6.7" (H) x 1.4" (D) - versatile for any day/occasion, formal or casual, indoor or outdoor, fashionable, excellent gift or present idea to girlfriends and family.
ADJUSTABLE STURDY STRAPS: Drop 22.5" - Chain attached to leather strap - wear cross body or single shoulder strap
ULTIMATE PROTECTION: Thick, reliable material, durable against rain/scratches. Whole purse reinforced to withstand accidental drops or mishaps protecting everything inside.
PRACTICAL ACCESSORY: Providing the perfect size to contain all the smart phones of today such as Apple iPhone 6 6S Plus, iPhone 7 7S Plus, iPhone 8 8S Plus, iPhone X, Samsung Galaxy Note 8, Note 7, Note 6, Note 5, Note 4, Note 3, Galaxy S8, S7, S6, S5, S4, Edge making it one of the most versatile women crossbody handbags available today,with plenty of additional space to store credit cards, IDs, money or other small items in the one additional pocket.','Cell Phone Case iPhone Samsung PU Leather Cross body Purse with Shoulder Strap Wallet Cosmetic Bag
',14,'item',3.5,3.5,2.3,2.3,61,'https://images-na.ssl-images-amazon.com/images/I/61Yq%2BegT0VL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/51LFp7uLjzL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/51LFp7uLjzL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71YW6DGit%2BL._SL1000_.jpg',5,4,1,'08/21/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO072','PTY009', 'quocanh','BRN017','Veriya Lightweight Casual Travel School Backpack Rucksack Daypack for Teenager Ladies
','STRONG MATERIAL: High Quality PU Lizard Leather (smooth, soft feel) Envelope flap with Gold Hardware on opening/closing clasp to secure your items.
CLASSIC SIZE: 4.1" (L) x 6.7" (H) x 1.4" (D) - versatile for any day/occasion, formal or casual, indoor or outdoor, fashionable, excellent gift or present idea to girlfriends and family.
ADJUSTABLE STURDY STRAPS: Drop 22.5" - Chain attached to leather strap - wear cross body or single shoulder strap
ULTIMATE PROTECTION: Thick, reliable material, durable against rain/scratches. Whole purse reinforced to withstand accidental drops or mishaps protecting everything inside.
PRACTICAL ACCESSORY: Providing the perfect size to contain all the smart phones of today such as Apple iPhone 6 6S Plus, iPhone 7 7S Plus, iPhone 8 8S Plus, iPhone X, Samsung Galaxy Note 8, Note 7, Note 6, Note 5, Note 4, Note 3, Galaxy S8, S7, S6, S5, S4, Edge making it one of the most versatile women crossbody handbags available today,with plenty of additional space to store credit cards, IDs, money or other small items in the one additional pocket.','Veriya Lightweight Casual Travel School Backpack Rucksack Daypack for Teenager Ladies
',9,'item',3.5,3.5,2.3,2.3,62,'https://images-na.ssl-images-amazon.com/images/I/713tfuNKQTL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Mkb4PT3eL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81LJC89PYrL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71fKD9zrR7L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71hf1IUenML._SX522_.jpg',5,4,1,'08/25/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO073','PTY010', 'tienminh','BRN036','Edifier H650 Hi-Fi On-Ear Headphones','LARGE DRIVERS FOR PROFESSIONAL AUDIO - 40mm high quality neodymium magnet driver for superb, clear sound
FOLDS IN HALF - Portable folding design and lightweight- perfect for travel
COMFORT ALL-DAY WEARING - Soft leather ear-cup and adjustable headband for a comfortable listening experience
BUILT TO LAST - Extremely durable and flexible with reinforced stainless steel headband
ONE YEAR WARRANTY - 12 month manufacturer warranty in USA and Canada','Edifier H650 Hi-Fi On-Ear Headphones - Noise-isolating Foldable and Lightweight Headphone - Fit Adults and Kids - Black
',27,'item',3.5,3.5,2.3,2.3,63,'https://images-na.ssl-images-amazon.com/images/I/71C%2Bv7lhWSL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/51wCtlkYrlL.jpg,https://images-na.ssl-images-amazon.com/images/I/51v8vEwAdeL.jpg,https://images-na.ssl-images-amazon.com/images/I/41S3nEUo5tL.jpg',5,4,1,'08/29/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO074','PTY010', 'tienminh','BRN036','Gorsun Lightweight Sport Workout Headphones with Volume Control and Microphone-Black/Red','BEST WORKOUT HEADPHONE with 3.5mm connection perfect for iPhone, iPod, and Android plus many others. These are ready to go right out of the box. Simply plug these gym headphones in and immediately enjoy fantastic sound. Your head will be immersed in your favorite music while you workout, run, or enjoy sports
OUTSTANDING DYNAMIC CRYSTAL CLEAR SOUND these headphones use the finest wiring and speaker technology. They offer very full sound and thunderous, deep bass. So realistic its like being in the studio with the artist. Your favorite tunes come to life with these exceptional on ear headphones
LIGHT WEIGHT, FOLD FOR TRANSPORT & STORAGE. See the photos of how these exercise headphones easily fold to take up very little space. Carry them in your backpack, purse, stash them in your desk at work, keep them in your car, or your sports locker. They even fit in a coat or jacket pocket','Gorsun Lightweight Sport Workout Headphones with Volume Control and Microphone-Black/Red
',20,'item',3.5,3.5,2.3,2.3,64,'https://images-na.ssl-images-amazon.com/images/I/71XA-bxbIkL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61wZLjnXwIL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Pp%2BSi92eL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81aD2CzvYtL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61-98chQ3OL._SL1500_.jpg',5,4,1,'09/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO075','PTY010', 'tienminh','BRN036','Mpow 059 Bluetooth Headphones','IMPRESSIVE SOUND QUALITY IS THE ULTIMATE GOAL & PLEASE NOTE: 1. This item is passive noise isolating, NOT active noise cancellation(ANC), it cant cancel the noise completely but it wont drain the battery and damage the sound. As an additional factor of sound quality, it is better than ANC. 2. The closed-back design provides immersive Hi-Fi sound with CSR chip and 40mm driver together. If you care more about Noise Cancellation than Sound Quality, you may consider other alternatives.
BUILT TO STAY COMFORTABLE: The Memory-protein ear cushion simulate human skin texture, ensuring lasting comfort. The stainless steel slider and softly padded headband allows you to find the perfect fit without constraint and provide excellent durability.
NEVER POWER OFF, BOTH WIRELESS & WIRED: 1. The wireless mode: A built-in 420mAh battery provides up to 13-hr music time/15-hr talking time in a single charge,2. The Wired mode: you can also use it as a wired headphone with the provided audio cable so the headphones will never power off.','Mpow 059 Bluetooth Headphones Over Ear, Hi-Fi Stereo Wireless Headset, Foldable, Soft Memory-Protein Earmuffs, w/ Built-in Mic and Wired Mode for PC/ Cell Phones/ TV
',41,'item',3.5,3.5,2.3,2.3,65,'https://images-na.ssl-images-amazon.com/images/I/71C%2Bv7lhWSL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/51wCtlkYrlL.jpg,https://images-na.ssl-images-amazon.com/images/I/51v8vEwAdeL.jpg,https://images-na.ssl-images-amazon.com/images/I/41S3nEUo5tL.jpg',5,4,1,'09/04/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO076','PTY010', 'tienminh','BRN036','Panasonic RP-HJE120-PPK In-Ear Stereo Earphones, Black

','Connectivity technology is wired. Maximum input 200 milli watt
Black ultra-soft ErgoFit in-ear earbud headphones conform instantly to your ears
Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)
Wider frequency response for fuller listening enjoyment
Long 3.6-ft cord threads comfortably through clothing and bags','Panasonic RP-HJE120-PPK In-Ear Stereo Earphones, Black
',20,'item',3.5,3.5,2.3,2.3,66,'https://images-na.ssl-images-amazon.com/images/I/71XA-bxbIkL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61wZLjnXwIL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Pp%2BSi92eL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81aD2CzvYtL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61-98chQ3OL._SL1500_.jpg',5,4,1,'09/07/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO077','PTY010', 'tienminh','BRN036','AILIHEN C8 Headphones with Microphone and Volume Control Folding Lightweight Headset','COLLAPSIBLE FEATURE: Take your headphones wherever you go. Just fold them up, twist up the cord, and be on your merry way
Hands-free Talking And Volume Control: The built-in mic,remote and volume control lets you pick up calls and skip between tracks without missing a beat.
ADJUSTABLE HINGE: The adjustable headband gives your headphones some impressive flexibility so they can adapt to the shape of your head for a perfect fit.
NOISE ISOLATION: full-sized, on-ear construction isolates from outside noise so you can hear the deep bass, and crisp mids and highs of your upcoming track.
WIDELY COMPATIBLE: With a flexible and durable 47 inches braided cord and sturdy 3.5 mm stereo plug. Will not kink, twist or break under normal use. Use with all your favorite devices like iPhone, iPad, iPod, Android, Laptop,Computer,Galaxy,MP3, MP4 and other audio devices. AILIHEN products come with 1 year warranty and 100% money back guarantee.','AILIHEN C8 Headphones with Microphone and Volume Control Folding Lightweight Headset for iPad iPhone iPod Tablets Smartphones Laptop Computer PC Mp3/4 (Grey/Mint)
',16,'item',3.5,3.5,2.3,2.3,67,'https://images-na.ssl-images-amazon.com/images/I/71XA-bxbIkL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61wZLjnXwIL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Pp%2BSi92eL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81aD2CzvYtL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61-98chQ3OL._SL1500_.jpg',5,4,1,'09/10/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO078','PTY011', 'thanhlong','BRN009','Bluetooth Speaker,XPLUS Portable Travel Wireless','TAKE YOUR JAMS ANYWHERE!LOSS-LESS MUSIC FORMAT APE/FLAC SUPPORTED! QUICK & EASY PAIR WITH 99% BLUETOOTH DEVICES UP TO 33FT / 10 METERS: are you ready for loss-less music? Our speaker is! APE/FLAC/MP3/WMA/WAV format supported through USB/Micro TF SD card input. Want your tunes and Radio with you anywhere? Bluetooth 4.0 make it super easy to pair, just search DY21L and connect. With the powerful dual 5W audio driver and high quality crystal clear sound, this is the right one to get.','Bluetooth Speaker,XPLUS Portable Travel Wireless Bluetooth Speakers All-in-1,HIFI V4.0,Calling Built-In Mic, Support TF Card for Smartphones and All Audio Enabled Devices,Black
',37,'item',3.5,3.5,2.3,2.3,68,'https://images-na.ssl-images-amazon.com/images/I/613gWCBNbUL._SL1181_.jpg,https://images-na.ssl-images-amazon.com/images/I/61vN2NipcfL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61DBNbXRx7L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/614tHQ5aC5L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71c0LZOKgTL._SL1001_.jpg',5,4,1,'09/13/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO079','PTY011', 'thanhlong','BRN009','Mothca Bluetooth FM Transmitter, Wireless Bluetooth Radio Transmitter','HIGH QUALITY WITH STRONG FM RECEPTION: Pair in seconds with stable FM signal, easy to set and use, just plug the FM transmitter into your cars cigarette lighter, make your phone/audio connect it via bluetooth or USB flash driver, switch your car radio to the same channel with the transmitter(from 87.5 to 108 MHz). Adopting unique red LED display instead of blue, allow you to read clearly during the day and night.
HI-FI MUSIC WITH MULTIPLE PLAYING MODES: Adopted with advanced interference and noise cancellation(CVC) technology, it can create full duplex sound quality, no matter where and when you can immerse yourself in crystal clear music and call(Pls refer to the description for right operation method ). Supporting playing music from Bluetooth,TF card or USB flash disk(contains MP3 files) grant you to enjoy music with your most favorite and convenient way.
AUTO-CONNECTION AND CONVENIENT BACK CONNECTION: After you successfully connect to your phones Bluetooth by manual operation at the first time,there is no need to reconnect it every time, with the memory function it will auto-connect to the last paired phone when power on.By pressing any button of the bluetooth radio transmitter for back connection after more than 3 minutes of disconnection (Car isn’t turned off) without reopening the bluetooth or re-plugging the FM radio transmitter.','Mothca Bluetooth FM Transmitter, Wireless Bluetooth Radio Transmitter with Dual USB Ports Music Player Support USB Flash Drive/TF Card Hands Free Calling Car Kit for All Bluetooth Enabled Devices
',15,'item',3.5,3.5,2.3,2.3,69,'https://images-na.ssl-images-amazon.com/images/I/61B69kSu2tL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/616OcT%2BVHkL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71ofSud7LbL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Ze7ZRE3YL._SL1200_.jpg, https://images-na.ssl-images-amazon.com/images/I/61yn2c29%2BqL._SL1200_.jpg',5,4,1,'09/17/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO080','PTY011', 'thanhlong','BRN009','Avantree Oasis LONG RANGE Bluetooth Transmitter','LONG RANGE: Utilizing Class 1 Bluetooth technology and an optimized antenna design, the Avantree Oasis can achieve a range of up to 150ft (50m) line-of-sight in open air and up to 50-70ft (20-30m) indoors. Use TWO Oasis as a Transmitter and Receiver Set EXTEND the range even further.
AUDIO HUB FOR HOME ENTERTAINMENT: Use the Avantree Oasis as a Bluetooth TRANSMITTER to Bluetooth-enable your TV，AV Receiver，Radio and other home audio source devices to stream music to your Bluetooth headphones or speakers. Or use it as a Bluetooth RECEIVER, to Bluetooth-enable your home stereo or AV Receiver and wirelessly stream music from your cellphone/PC. You can also use it as a pass-through HUB when you prefer to use your conventional wired connections.
AUX & OPTICAL: Supports both analog (RCA/3.5mm aux audio) and digital (optical) input and output!','Avantree Oasis LONG RANGE Bluetooth Transmitter for TV Audio, Wireless Transmitter and Receiver, Certified aptX Low Latency, Support Digital Optical, RCA AUX, for Any Audio Devices [2-Year Warranty]',59,'item',3.5,3.5,2.3,2.3,70,'https://images-na.ssl-images-amazon.com/images/I/613gWCBNbUL._SL1181_.jpg,https://images-na.ssl-images-amazon.com/images/I/61vN2NipcfL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61DBNbXRx7L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/614tHQ5aC5L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71c0LZOKgTL._SL1001_.jpg',5,4,1,'09/20/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO081','PTY011', 'thanhlong','BRN009','Baile Bluetooth 4.0 Wireless Audio Transmitter','Turn your non-bluetooth devices to a bluetooth-enabled thru 3.5mm audio-out jack,transmit audio signal from tv,CD player to bluetooth headset, receivers
Simultaneously Pair with Two bluetooth Headsets/bluetooth receivers,you can hear audio from both headsets
Compact mini size;easy to use ,just attach the bluetooth transmitter to 3.5mm jack and turn on ,no drive is needed
Both of the blue lights on after two speakers connect successfully and the red light’s on when charging and off with full charge.
3.5mm audio jack connects to TV, DVD or MP3 player (includes 3.5mm audio cable)','Baile Bluetooth 4.0 Wireless Audio Transmitter Multi-Point H-366T Support Two Bluetooth Headphones or Speaker Simultaneously for TV PC CD Player iPod MP3 MP4 (3.5mm Jack)
',60,'item',3.5,3.5,2.3,2.3,71,'https://images-na.ssl-images-amazon.com/images/I/61B69kSu2tL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/616OcT%2BVHkL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71ofSud7LbL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Ze7ZRE3YL._SL1200_.jpg, https://images-na.ssl-images-amazon.com/images/I/61yn2c29%2BqL._SL1200_.jpg',5,4,1,'09/23/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO082','PTY011', 'thanhlong','BRN009','NewRice Wireless Bluetooth 4.0 Audio Transmitter','(Unit size：45mm*11mm). Small, lightweight and durable . High performance Bluetooth 4.0 (High-Fidelity) with A2DP for enhanced audio quality, allows you to enjoy the stereo music without wire restriction or watch TV quietly (not for answering calls).
Work with any type and brand of device such as TV, PC, CD player, iPod, Kindle Fire, MP3/MP4 etc. up to 30 feet working range. Easy pairing with Bluetooth stereo headset, headphones, speakers and other Bluetooth stereo audio enabled system.
This one A wireless transmitter with excellent battery life, to 5 hours of play time. with dual mode, you can use it plugged with AC adapter without worrying about the battery.
Standard 3.5mm audio socket and cable enable this Bluetooth transmitter to connect to for audio devices
NOTE: This is a transmitter not a receiver ： Buy 2 in 1 Transmitter and Receiver pls search"B01FO890VC" Please read the product manual before you use it for the first time
','NewRice Wireless Bluetooth 4.0 Audio Transmitter, Support Two Bluetooth Headphones Or Speakers Simultaneously for TV/MP3/MP4
',17,'item',3.5,3.5,2.3,2.3,72,'https://images-na.ssl-images-amazon.com/images/I/613gWCBNbUL._SL1181_.jpg,https://images-na.ssl-images-amazon.com/images/I/61vN2NipcfL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61DBNbXRx7L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/614tHQ5aC5L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71c0LZOKgTL._SL1001_.jpg',5,4,1,'09/26/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO083','PTY012', 'andy','BRN013','Samsung SmartThings Smart Home Hub','Your smart home needs a brain, so get started with a SmartThings Hub. It connects wirelessly with a wide range of smart devices and makes them work together.
Add smart devices and put your home to work. Choose from a wide range of compatible devices, including lights, speakers, locks, thermostats, sensors, and more.
Use the SmartThings app or Amazon Alexa to control your smart home. Teach your house new tricks by telling it what to do when you’re asleep, awake, away, and back home.
Power: In-wall power adapter with about 10 hours of backup power from 4 AA batteries (included) Communication. Protocol: ZigBee, Z-Wave, IP. Range: 50-130 feet Operating Temperature: 41 to 95°F. Compatible Brands: Honeywell, Philips Hue, Kwikset
Requires an Internet-connected router with an available Ethernet port Requires the free SmartThings app for iOS (8.1 or later), Android (4.0 or later), or Windows Phone (8.1 or later)
Compatible Brands: Honeywell, Philips Hue, Kwikset
A more powerful processor and local app engine means faster performance and enabled offline processing','Samsung SmartThings Smart Home Hub',60,'item',3.5,3.5,2.3,2.3,73,'https://images-na.ssl-images-amazon.com/images/I/418j88EieRL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/41CrWRUaE0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/61Rl9TWR-hL._SL1125_.jpg',5,4,1,'09/29/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO084','PTY012', 'andy','BRN013','Philips Hue White Smart Bulb Starter Kit','Automate your lighting experience with Philips Hue and control your lights from home or away. Create light schedules from the Philips Hue App and never come home to a dark house.
Connect the Hue Bridge with three bulbs that fit standard-size table lamps. Grow your system with support for up to 50 lights.
Install the LED lights as you would install ordinary bulbs and pair them with the Hue Bridge, which allows you to control smart-bulb-equipped lamps and overhead lights via the Philips Hue App.
Easily expand your lighting system with up to 12 accessories per system (sold separately), such as a Hue Tap or Hue Motion Sensor. Pair it for automation with your existing Nest or SmartThings system.','Philips Hue White Smart Bulb Starter Kit (4 A19 Bulbs and 1 Bridge, Compatible with Amazon Alexa, Apple HomeKit and Google Assistant)',16,'item',3.5,3.5,2.3,2.3,74,'https://images-na.ssl-images-amazon.com/images/I/71IL4aYSulL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kTiXarEjL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81gOvv0WvxL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61IYMLpM1ML._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kBO1lyxQL._SL1000_.jpg',5,4,1,'10/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO085','PTY012', 'andy','BRN013','Apollo Tools 39 Piece General Tool Set','Man-Made Materials
Imported
HOME HOUSEHOLD TOOL KIT: The original 39 piece general tool kit with over 1 Million units sold worldwide. Great gift idea.
ESSENTIAL DIY TOOLS: This compact tool kit contains the most useful tools for basic DIY household repairs. Picture hanging, box opening, screw tightening, this is the perfect starter kit for home repairs.
MOST REACHED FOR DIY HAND TOOLS: Includes 8oz. claw hammer, slip joint pliers used for grasping and turning, tape measure, utility knife, bit driver with 2” bit extension and 20 most popular bit sizes, precision screwdrivers for small screws, 8 hex keys and a pair of scissors.
APOLLO HAND TOOL LIFETIME QUALITY GUARANTEE: Tools are manufactured from high-grade steel alloy, chrome plated to resist corrosion, with non-slip comfort grip handles for extra torque, and will last a lifetime under normal use.
STURDY COMPACT STORAGE CASE: Tools are neatly stored in a sturdy case to keep them secure, clean, organized and easy to find.','Apollo Tools 39 Piece General Tool Set',16,'item',3.5,3.5,2.3,2.3,75,'https://images-na.ssl-images-amazon.com/images/I/51vf1UQq67L._UX425_.jpg,https://images-na.ssl-images-amazon.com/images/I/81LFggWNh0L._UX522_.jpg,',5,4,1,'10/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO086','PTY012', 'andy','BRN013','Luxe Bidet Neo 120 - Self Cleaning Nozzle','Sleek Design - Upgrade your bathroom with Luxe Bidets beautifully designed bidet attachments, featuring chrome-plated water pressure control knobs for a more elegant look.
High Quality Parts - We use high quality parts that are built to last making Luxe Bidet an excellent value for the price. Neo 120 is constructed with high-pressure faucet quality valves with metal/ceramic core and braided steel hoses instead of traditional plastic.
Quick and Easy Installation - Includes everything you need including tools to get your bidet up and running in minutes. Easily attaches to and detaches from any standard two-piece toilet.
Sanitary Protection - Self-cleaning feature sanitizes the nozzle and retracts when not in use for maximum protection. The bidet also features a convenient movable nozzle guard gate for extra protection and easy maintenance.
Customer Service - Bidet includes an 18 month full customer support when you register your bidet online. We provide full customer support anytime you have questions or concerns.','Luxe Bidet Neo 120 - Self Cleaning Nozzle - Fresh Water Non-Electric Mechanical Bidet Toilet Attachment (blue and white)
',16,'item',3.5,3.5,2.3,2.3,76,'https://images-na.ssl-images-amazon.com/images/I/418j88EieRL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/41CrWRUaE0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/61Rl9TWR-hL._SL1125_.jpg',5,4,1,'10/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO087','PTY012', 'andy','BRN013','Etekcity 2 Pack WiFi Smart Plug Mini Outlet with Energy Monitoring, Works with Amazon Alexa','Works with Amazon Alexa for voice control. Power your devices without lifting a finger. Does not currently support SmartThings, homekit, or IFTTT
Track power usage for connected devices and figure out which devices use the most energy. You can effectively cut your usage so that you can save money on your next electric bill
Easy to install and stable connection. Controlled from different devices and manage your home on your smartphone or tablet from anywhere
Get ready to have a smart home and create customized schedule to automatically turn on and off any home Electronics or appliances such as lamps, Christmas Lighting, coffee maker, etc
30-Day money back, 2-year warranty and lifetime support. *Only support 2.4Ghz wifi','Etekcity 2 Pack WiFi Smart Plug Mini Outlet with Energy Monitoring, Works with Amazon Alexa Echo and Google Assistant, No Hub Required, White
',12,'item',3.5,3.5,2.3,2.3,77,'https://images-na.ssl-images-amazon.com/images/I/71IL4aYSulL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kTiXarEjL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81gOvv0WvxL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61IYMLpM1ML._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kBO1lyxQL._SL1000_.jpg',5,4,1,'10/07/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO088','PTY013', 'andy','BRN014','Wifi Smart Led Light bulb,Compatible With Alexa Google Home','SIMPLE QUICK SETUP AND EASY INSTALLATION : Installation couldn’t be simpler . twist in the bulb, turn it on, and sync with the smart app . Easy to setup . this bulb does not need a Hub, install free App which can download via APP store or Google play by search"lombex" . to control this Smart Bulb. During the setup, you are greeted with the option to create a account . that can work with all of our smart things such as plug etc and make sure safe for the internet and Name them .
CONTROL YOUR LIGHT FROM ANYTIME ANYWHERE : connects to your Wi-Fi and lets you control every aspect of your lighting from your smartphone or tablet. Whether home or away, you can always make sure your lighting is set the way you want it. Turn the lights on from your car when you arrive home at night, and make sure all your lights are switched off even when you’re already at work.
VOICE CONTROL : Compatible with your a lexa and Google Home , Control your home just your voice.Work with IFTTT,Personalize your lighting through a color palette of over 16 million hues of color to control its brightness and tones. You can dim any color from dark to bright . You can choose color modes for different scenes, such as reading mode, dinner mode, etc., just at your fingertips or your voice.','Wifi Smart Led Light bulb,Compatible With Alexa Google Home IFTTT Smart Home Automation Dimmable Warm White E26/E27 light bulb 9W(60W Equivalent)A19 RGBW Color Changing Mood Light
',60,'item',3.5,3.5,2.3,2.3,78,'https://images-na.ssl-images-amazon.com/images/I/61jcgoVQaUL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/716HH2QOtgL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71L-iVMxG%2BL._SL1100_.jpg,https://images-na.ssl-images-amazon.com/images/I/619Gp1OqeKL._SL1002_.jpg,https://images-na.ssl-images-amazon.com/images/I/81T%2BQ1rkSKL._SL1500_.jpg',5,4,1,'10/09/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO089','PTY013', 'andy','BRN014','Samsung SmartThings Smart Home Hub
','"Your smart home needs a brain, so get started with a SmartThings Hub. It connects wirelessly with a wide range of smart devices and makes them work together.
Add smart devices and put your home to work. Choose from a wide range of compatible devices, including lights, speakers, locks, thermostats, sensors, and more.
Use the SmartThings app or Amazon Alexa to control your smart home. Teach your house new tricks by telling it what to do when you’re asleep, awake, away, and back home.
Power: In-wall power adapter with about 10 hours of backup power from 4 AA batteries (included) Communication. Protocol: ZigBee, Z-Wave, IP. Range: 50-130 feet Operating Temperature: 41 to 95°F. Compatible Brands: Honeywell, Philips Hue, Kwikset
Requires an Internet-connected router with an available Ethernet port Requires the free SmartThings app for iOS (8.1 or later), Android (4.0 or later), or Windows Phone (8.1 or later)
Compatible Brands: Honeywell, Philips Hue, Kwikset
A more powerful processor and local app engine means faster performance and enabled offline processing"
','Samsung SmartThings Smart Home Hub
',17,'item',3.5,3.5,2.3,2.3,79,'https://images-na.ssl-images-amazon.com/images/I/418j88EieRL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/41CrWRUaE0L._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/510oSPfsKiL._SL1024_.jpg,https://images-na.ssl-images-amazon.com/images/I/61Rl9TWR-hL._SL1125_.jpg',5,4,1,'10/11/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO090','PTY013', 'quocanh','BRN014','Philips Hue White Smart Bulb Starter Kit','"Automate your lighting experience with Philips Hue and control your lights from home or away. Create light schedules from the Philips Hue App and never come home to a dark house.
Connect the Hue Bridge with three bulbs that fit standard-size table lamps. Grow your system with support for up to 50 lights.
Install the LED lights as you would install ordinary bulbs and pair them with the Hue Bridge, which allows you to control smart-bulb-equipped lamps and overhead lights via the Philips Hue App.
Easily expand your lighting system with up to 12 accessories per system (sold separately), such as a Hue Tap or Hue Motion Sensor. Pair it for automation with your existing Nest or SmartThings system."
','Philips Hue White Smart Bulb Starter Kit (4 A19 Bulbs and 1 Bridge, Compatible with Amazon Alexa, Apple HomeKit and Google Assistant)
',17,'item',3.5,3.5,2.3,2.3,80,'https://images-na.ssl-images-amazon.com/images/I/71IL4aYSulL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kTiXarEjL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81gOvv0WvxL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61IYMLpM1ML._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71kBO1lyxQL._SL1000_.jpg
',5,4,1,'10/13/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO091','PTY013', 'quocanh','BRN014','ISELECTOR Mini Smart Plug 2-Pack, Wi-Fi','ISELECTOR smart plug supports Android and IOS operating system and activates by simply connecting it to your phone without complicated installation process.
Plug in this smart plug, download the free app. You can control devices connected to the Smart Plug wherever you are using the free Jinvoo app.
Turn on/off the light automatically after setting the specific time by this smart plug.
Work perfectly with Alexa and Google Assistant which can be controlled by your voice after connected.
The Mini Smart Plug protects your home better than a mechanical timer. Away-mode will help to control your lights on and off just like you are home.','ISELECTOR Mini Smart Plug 2-Pack, Wi-Fi, Control Your Electric Devices from Anywhere, Timing Function, No Hub Required, Works with Alexa and Google Assistant
',60,'item',3.5,3.5,2.3,2.3,81,'https://images-na.ssl-images-amazon.com/images/I/51g7hEf38rL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/51W%2BasbMarL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/61iudwW%2BMNL._SL1001_.jpg,https://images-na.ssl-images-amazon.com/images/I/71RljmqCmXL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71V2gJPoC-L._SL1200_.jpg',5,4,1,'10/15/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO092','PTY013', 'quocanh','BRN014','Sensi Smart Thermostat, Wi-Fi, P500W, Works with Amazon Alexa','Connect Sensi thermostat to your home Wi-Fi network and control from anywhere via free mobile app (compatible with Android and iOS).
Integrates with Amazon Alexa for voice control and Wink smart home platforms, and works with Google Assistant and Google Home using the free Wink app.
Works with HVAC systems in most homes – a c-wire is required for heat-only, cool-only and heat pump systems without aux. Refer to Sensis online compatibility resources to verify compatibility in your home.
Features geofencing for location-based temperature control and 7-day flexible scheduling to help reduce wasteful heating and cooling when no one is home.
Quick and easy DIY installation - the Sensi app includes a step-by-step installation guide and video tutorial.','Sensi Smart Thermostat, Wi-Fi, UP500W, Works with Amazon Alexa
',60,'item',3.5,3.5,2.3,2.3,82,'https://images-na.ssl-images-amazon.com/images/I/51SJccPczoL._SL1133_.jpg,https://images-na.ssl-images-amazon.com/images/I/81Bkb8cgGGL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/61o2WsaJBzL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/71KHV08ymkL._SL1140_.jpg,https://images-na.ssl-images-amazon.com/images/I/81EdI5My89L._SL1500_.jpg',5,4,1,'10/17/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO093','PTY014', 'quocanh','BRN014','CUH Cordless Power Scrubber with Rechargeable Battery for Bathroom Kitchen 6 Brushes 1 Scouring Pad ','All soft high-quality waterproof seal design and easy manipulation, ideal tool for all bathroom, kitchen and outdoor scrubbing needs. Good for wet use in showers, tubs and sinks, etc
Lightweight and low noise, makes user to work effectively and comfortably.
High capacity rechargeable battery, automatic rapidly charger for charging faster and easier.
Comes with 3 metal brushes for free, suitable for various cleaning jobs
Easy to assemble and use!','CUH Cordless Power Scrubber with Rechargeable Battery for Bathroom Kitchen 6 Brushes 1 Scouring Pad 
',60,'item',3.5,3.5,2.3,2.3,83,'https://images-na.ssl-images-amazon.com/images/I/81s6AMkr0fL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81ahFRw4v2L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/814-ZpNHhGL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81sLFliStEL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/816KzYPC67L._SX522_.jpg',5,4,1,'10/20/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO094','PTY014', 'quocanh','BRN015','Automatic Hand Push Sweeper, LuckyFine 360 Rotary Automatic Broom','Material: ABS resin stainless steel. Size: 12.99x43.31" / 33x110cm
Wide Angle Sweep: Dust range throughout every corner of the home, clear the dead ends do not hurt the ground.
Adjustable : It has the handle with adjustable length.Cleaning is very convenient.
Without power supply, energy conservation and environmental protection.
Wide Applicability: It can be used for flat floor such as wood, ceramic tile, marble, concrete blanket and so on, it is very easy to clean.','Automatic Hand Push Sweeper, LuckyFine 360 Rotary Automatic Broom Floor Dust Cleaning Sweeper Household Cleaner Mop Tool Green 
',17,'item',3.5,3.5,2.3,2.3,84,'https://images-na.ssl-images-amazon.com/images/I/714UTzyocNL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61UcudiNu5L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/615prvk3z1L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71VGZBCJz8L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/713x-VdoC2L._SX522_.jpg',5,4,1,'10/23/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO095','PTY014', 'quocanh','BRN015','Elvoes Window Squeegee, Extendable Microfiber Sponge Window Squeegee Cleaner','CONFIGURATIONS: Our professional window cleaning kit includes-glass window cleaning head, window cleaning cloth, alloy connecting rod, alloy telescopic rod. This telescopic window wiper is made of rubber, sponge, microfiber, steel and high strength plastic.
RUBBER SCRAPING SUPER ADDITION TO WATER: 2-in-1 all-purpose cleaning tool with heavy duty squeegee and a microfiber cloth for cleaning windows, mirrors, glass, shower doors, smooth walls, tiling, and other smooth surfaces. Wide soft rubber blade and microfiber scrubbing pads let wipe and clean in one simple swipe.
PATENTED DESIGN TO BEND: Patented stainless steel spring joint design, curved mirror does not stoop fit. What’s more, 90° scraping with pole design, more uniform force, the cleaning effect is more obvious.','Elvoes Window Squeegee, Extendable Microfiber Sponge Window Squeegee Cleaner, Telescopic Window Wiper with Pole, Window Cleaning Tools for House/Car/Glass',17,'item',3.5,3.5,2.3,2.3,85,'https://images-na.ssl-images-amazon.com/images/I/81s6AMkr0fL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81ahFRw4v2L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/814-ZpNHhGL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/81sLFliStEL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/816KzYPC67L._SX522_.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO096','PTY014', 'kenny','BRN015','Melissa & Doug Lets Play House Dust! Sweep! Mop! 6-Piece Pretend Play Set
','6-piece cleaning set for hours of pretend play housekeeping
Includes broom, mop, duster, dust pan, brush, and storage stand
All pieces durably made and sized for kids
Dust pan snaps onto all handles
Sturdy wooden construction','Melissa & Doug Lets Play House Dust! Sweep! Mop! 6-Piece Pretend Play Set
',17,'item',3.5,3.5,2.3,2.3,86,'https://images-na.ssl-images-amazon.com/images/I/714UTzyocNL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61UcudiNu5L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/615prvk3z1L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71VGZBCJz8L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/713x-VdoC2L._SX522_.jpg',5,4,1,'10/28/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO097','PTY014', 'kenny','BRN015','Kichwit 4 Inch Drill Power Scrubber Scouring Pads Cleaning Kit','6-piece cleaning set for hours of pretend play housekeeping
Includes broom, mop, duster, dust pan, brush, and storage stand
All pieces durably made and sized for kids
Dust pan snaps onto all handles
Sturdy wooden construction','Kichwit 4 Inch Drill Power Scrubber Scouring Pads Cleaning Kit, Includes Velcro Attachment, 3 Non-Scratch Red Pads and 3 Stiff Green Pads, Heavy Duty Household Cleaning Tool
',60,'item',3.5,3.5,2.3,2.3,87,'https://images-na.ssl-images-amazon.com/images/I/714UTzyocNL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61UcudiNu5L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/615prvk3z1L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/71VGZBCJz8L._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/713x-VdoC2L._SX522_.jpg',5,4,1,'11/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO098','PTY015', 'kenny','BRN015','DIMY LED Colorful Flashing Finger Lighting Rave Gloves - Best Gifts','GIFTS FOR KIDS: Kids love all things that light up. Our multi-color glowing flashing light up gloves are perfect for kids birthday gifts, stocking stuffers, toys for boys and girls, costume accessories, Halloween lights, Christmas gifts, dance costumes, ice skating costumes, roller skating lights, hockey lights, kids games, school events, and even Thanksgiving gifts for kids. Grab something different gifts for kids today!','DIMY LED Colorful Flashing Finger Lighting Rave Gloves - Best Gifts',60,'item',3.5,3.5,2.3,2.3,88,'https://images-na.ssl-images-amazon.com/images/I/61pWWz4poGL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71E-DOYGcXL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/714wQ6CvivL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/714aEc59EXL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Tbo0VOobL._SL1201_.jpg',5,4,1,'11/01/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO099','PTY015', 'kenny','BRN016','Crayola Sidewalk Chalk, Washable, Outdoor, Gifts for Kids, 64 Count','64 assorted bold, bright colors.
Includes 2 neon chalk sticks, 2 glitter neon chalk sticks, 2 tie-dye chalk sticks, and 2 glitter chalk sticks
Crayola Washable Sidewalk Chalk - Cleans up with water or rainfall
Create the best sidewalk chalk art with a great variety of colors
Great birthday gifts for kids!','Crayola Sidewalk Chalk, Washable, Outdoor, Gifts for Kids, 64 Count',60,'item',3.5,3.5,2.3,2.3,89,'https://images-na.ssl-images-amazon.com/images/I/91UZPciW9cL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/91reUzAAP4L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/914neV4MkWL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81w0UE9w2QL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81pnzZ3uWnL._SL1500_.jpg',5,4,1,'11/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO100','PTY015', 'kenny','BRN016','Bamboo Cheese Board with Cutlery Set, Wood Charcuterie Platter','THE EXCLUSIVE CHOICE FOR SERVING CHEESE - The key to enjoy slices of Italian Ricotta, English Cheddar, or French Vacherin with a glass of wine for holiday entertaining is to have our modern bamboo cheese board. Bordered by grooves that hold crackers, nuts, or olives and designed with a hidden drawer with four utensils, this bamboo-crafted tray will make a perfect serving board for entertaining guest','Bamboo Cheese Board with Cutlery Set, Wood Charcuterie Platter and Serving Meat Board with Slide-Out Drawer with 4 Stainless Steel Knife and Server Set - Personalized Gifts. Designed By: Bambusi',60,'item',3.5,3.5,2.3,2.3,90,'https://images-na.ssl-images-amazon.com/images/I/61pWWz4poGL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71E-DOYGcXL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/714wQ6CvivL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/714aEc59EXL._SL1200_.jpg,https://images-na.ssl-images-amazon.com/images/I/71Tbo0VOobL._SL1201_.jpg',5,4,1,'11/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO101','PTY015', 'kenny','BRN016','Automatic Motion Sensor Toilet Night Light by LIGHTBOWL','64 assorted bold, bright colors.
Includes 2 neon chalk sticks, 2 glitter neon chalk sticks, 2 tie-dye chalk sticks, and 2 glitter chalk sticks
Crayola Washable Sidewalk Chalk - Cleans up with water or rainfall
Create the best sidewalk chalk art with a great variety of colors
Great birthday gifts for kids!','Automatic Motion Sensor Toilet Night Light by LIGHTBOWL, Modern Elegant Design With Relaxing 8-Color LED Light, For Gift, Party, Housewarming, Graduation, Wedding, Retirement, Potty Training',17,'item',3.5,3.5,2.3,2.3,91,'https://images-na.ssl-images-amazon.com/images/I/91UZPciW9cL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/91reUzAAP4L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/914neV4MkWL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81w0UE9w2QL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81pnzZ3uWnL._SL1500_.jpg',5,4,1,'11/05/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO102','PTY015', 'uyenle','BRN016','Duck Money Soap: Each Bar Contains a Real US Bill - Up to $50 
','Duck money soap
Containing real money
Pearberry scented
When the soap is gone, money is revealed in either a $1, $5, $10, or a $50 bill','Duck Money Soap: Each Bar Contains a Real US Bill - Up to $50 
',60,'item',3.5,3.5,2.3,2.3,92,'https://images-na.ssl-images-amazon.com/images/I/91UZPciW9cL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/91reUzAAP4L._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/914neV4MkWL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81w0UE9w2QL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81pnzZ3uWnL._SL1500_.jpg',5,4,1,'11/07/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO103','PTY016', 'uyenle','BRN016','GuDoQi Money bank password piggy bank digital electronic bank','The goods guards your personal stuff. Use the bank to store things like your paper money, play jewelry, baseball cards or playing card. The coins slot at the top lets you use the product as a piggy bank
Automatic Paper Money Scroll: Put the paper money on the Scroll, it can be rolled into the machine automatically(But it doesnt work if the paper is too old or too soft)
Rotary Switch: Enter the correct password then the light turns green, the ATM can be opened.(You can not rotate the switch if the password is wrong)
Password Key: The default password is 0000, you can change to another 4 digits password. If you forget the password, just take out the batteries and restart, the password returns to 0000','GuDoQi Money bank password piggy bank digital electronic bank for kids mini ATM coin saving banks toys gifts birthday gifts for kids Silver Black
',17,'item',3.5,3.5,2.3,2.3,93,'https://images-na.ssl-images-amazon.com/images/I/617eMGgDILL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61ZgLeopjXL._SL1100_.jpg,https://images-na.ssl-images-amazon.com/images/I/71liq5K0cvL._SL1180_.jpg,https://images-na.ssl-images-amazon.com/images/I/71HypyqadRL._SL1180_.jpg,https://images-na.ssl-images-amazon.com/images/I/718ISTJYj-L._SL1180_.jpg',5,4,1,'11/09/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO104','PTY016', 'uyenle','BRN017','USB Lighters Metal Rechargeable Windproof Flameless','Fingerprint sensor ignition design:You can light the cigarette from either side of it.Touch of your finger tip turns it on(Note* Please Touch of your finger tip SLIGHTLY HARD on the home button) - you dont have to keep holding it down like traditional electronic lighter.
These are great for anything that can fit the circular hole like cigarettes,rolled up paper, and such.Coil gets really hot quickly and as a safety precaution it goes off in several seconds so you dont have to worry about burning anything if the top pops up.','USB Lighters Metal Rechargeable Windproof Flameless Electronic Coil Cigar Cigarette Lighter No Gas Lighter,Oiikury Fingerprint ID lighter (Black Ice) 
',17,'item',3.5,3.5,2.3,2.3,94,'https://images-na.ssl-images-amazon.com/images/I/51H8vNyMUlL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61VnSbaDYhL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/61zAIKflIjL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/616Qm4TTfdL._SX522_.jpg,https://images-na.ssl-images-amazon.com/images/I/51irbweQ0PL._SX522_.jpg',5,4,1,'11/11/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO105','PTY016', 'uyenle','BRN017','Luwint Colorful LED Flashing Scarf - Lights Up Rave Clothing Accessories Toys for Christmas Birthday Party','Your Safety is our optimum concern - Our Priority-made of High quality Electronic devices and soft cotton material keeps you comfortable and warm
3 COLORS 6 MODES - Variable blink colors ( blue green red ) can be changed depending on your mood, the lights can change from fast to slow to patterned
WIDELY USE - Perfect for Christmas Halloween Cosplay birthday dance bar party rave lightshow, also an ideal gift
More Fun - Set of 2 Batteries MORE BONUS ( products included batteries inside and replaceable)','Luwint Colorful LED Flashing Scarf - Lights Up Rave Clothing Accessories Toys for Christmas Birthday Party',16,'item',3.5,3.5,2.3,2.3,95,'https://images-na.ssl-images-amazon.com/images/I/617eMGgDILL._SL1000_.jpg,https://images-na.ssl-images-amazon.com/images/I/61ZgLeopjXL._SL1100_.jpg,https://images-na.ssl-images-amazon.com/images/I/71liq5K0cvL._SL1180_.jpg,https://images-na.ssl-images-amazon.com/images/I/71HypyqadRL._SL1180_.jpg,https://images-na.ssl-images-amazon.com/images/I/718ISTJYj-L._SL1180_.jpg',5,4,1,'11/15/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO106','PTY016', 'uyenle','BRN017','The Comic Book Story of Video Games: The Incredible History of the Electronic Gaming Revolution','Author Jonathan Hennessey and illustrator Jack McGowan present the first full-color, chronological origin story for this hugely successful, omnipresent artform and business. Hennessey provides readers with everything they need to know about video games--from their early beginnings during World War II to the emergence of arcade games in the 1970s to the rise of Nintendo to todays app-based games like Angry Birds and Pokemon Go. Hennessey and McGowan also analyze the evolution of gaming as an artform and its impact on society. Each chapter features spotlights on major players in the development of games and gaming that contains everything that gamers and non-gamers alike need to understand and appreciate this incredible phenomenon.','The Comic Book Story of Video Games: The Incredible History of the Electronic Gaming Revolution',16,'item',3.5,3.5,2.3,2.3,96,'https://images-na.ssl-images-amazon.com/images/I/9114C7%2Bs4sL.jpg,https://images-na.ssl-images-amazon.com/images/I/71wFP4dL2xL.jpg,https://images-na.ssl-images-amazon.com/images/I/7154T0vZ-FL.jpg,https://images-na.ssl-images-amazon.com/images/I/71AlKfeYBAL.jpg,https://images-na.ssl-images-amazon.com/images/I/71HSl6JXWBL.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO107','PTY016', 'uyenle','BRN017','Universal Cable Organizer, Double Layer Travel Electronics Accessories Organizer','An All in One Travel Organizer: With a unique design of handle strap, it’s very cool to put your hand inside and hold it sturdy and comfort, could carry it everywhere
Universal Cable Organizer: Made of water resistance and durable nylon fiber, this case helps to keep your cables safe and organized in a safe zone and prevent the scratch for metal connectors, suitable for HDMI, RJ45, Apple charging cables, Coax cables and other audio/video cables
Electronics Accessories Case: Built-in 3 mesh pocket inside, the bigger one with zipper could hold Any notebook/any electronics within 7 inches,2 smaller easy access mesh pocket keep your smart phone(within 5.5inch), charges and other electronic accessories safe and very convenient for using','Universal Cable Organizer, Double Layer Travel Electronics Accessories Organizer Case for Various USB, Phone, Charger, Gear Organizer Storage Bag',15,'item',3.5,3.5,2.3,2.3,97,'https://images-na.ssl-images-amazon.com/images/I/81j6OLPhCjL._SL1300_.jpg,https://images-na.ssl-images-amazon.com/images/I/81DGqw9YgRL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/71e-EWKPrJL._SL1229_.jpg,https://images-na.ssl-images-amazon.com/images/I/71vyVDs%2B4gL._SL1300_.jpg,https://images-na.ssl-images-amazon.com/images/I/71YGWBFCljL._SL1218_.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO108','PTY017', 'sonmai','BRN017','The Shape of Me and Other Stuff: Dr. Seusss','"The shape of you, the shape of me, the shape of everything I see.." In this board book featuring bright new colors and the original whimsical text, Dr. Seuss introduces the concept of shapes to babies and toddlers.  ','The Shape of Me and Other Stuff: Dr. Seusss Surprising Word Book Board book – July 8, 1997
',15,'item',3.5,3.5,2.3,2.3,98,'https://images-na.ssl-images-amazon.com/images/I/51CIimWBB0L.jpg,https://images-na.ssl-images-amazon.com/images/I/51uWpsoT6wL.jpg,https://images-na.ssl-images-amazon.com/images/I/41JuPAjtavL.jpg',5,4,1,'01/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO109','PTY017', 'sonmai','BRN018','Techion Braided 550 Paracord Adjustable Camera','Made from extremely durable 550 Type III Paracord
Securely hold your cameras, binoculars and other stuff from dropping
Easily adjust to fit all wrist sizes
Measures approximately 16 inches in total length
Retail package also includes 1xTechion 4x4" Microfiber cleaning cloth to keep your lens clean','Techion Braided 550 Paracord Adjustable Camera Wrist Strap / Bracelet for Cameras, Binoculars, and other Stuff
',15,'item',3.5,3.5,2.3,2.3,99,'https://images-na.ssl-images-amazon.com/images/I/91cliDPTCuL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/8160Jm8%2BEmL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/918k2YNoaQL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/91As3HoQGdL._SL1500_.jpg,https://images-na.ssl-images-amazon.com/images/I/81YaVFfYCqL._SL1500_.jpg',5,4,1,'11/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO110','PTY017', 'sonmai','BRN018','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]
','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]
',15,'item',3.5,3.5,2.3,2.3,100,'https://images-na.ssl-images-amazon.com/images/I/714Njlc0oOL._SL1280_.jpg',5,4,1,'11/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO111','PTY017', 'sonmai','BRN018','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]
','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]','Greatest Hits Vol.2 And Some Other Stuff[2 CD set]
',15,'item',3.5,3.5,2.3,2.3,101,'https://images-na.ssl-images-amazon.com/images/I/714Njlc0oOL._SL1280_.jpg',5,4,1,'11/03/2017  21:44:04','tuyetbich',1);
insert into Products(productId,typeId,userId,brandId,productName,productDesc,productSummary,productPrice,productUnit,productWeight,productWidth,productHeigth,productLength,productQuantity,productImage,productDiscount,productRating,isApproved,datePosted,votedUsers,productStatus)VALUES ('PRO112','PTY017', 'sonmai','BRN018','Saving Stuff: How to Care for and Preserve Your Collectibles','The most comprehensive book on preserving every type of collectible -- from the sentimental to the valuable -- from the Smithsonians Senior Conservator. 
For both the serious collector and the sometimes sentimentalist, Saving Stuff explains -- in plain language -- how you can use the techniques of museum professionals to keep your prized possessions in mint condition. ','Saving Stuff: How to Care for and Preserve Your Collectibles, Heirlooms, and Other Prized Possessions Paperback – June 2, 2005
',15,'item',3.5,3.5,2.3,2.3,101,'https://images-na.ssl-images-amazon.com/images/I/51JwKTc08wL.jpg',5,4,1,'12/03/2017  21:44:04','tuyetbich',1);

-- Product Rating
insert into ProductRating VALUES('PRO001',4,1);
insert into ProductRating VALUES('PRO002',4,1);
insert into ProductRating VALUES('PRO003',4,1);
insert into ProductRating VALUES('PRO004',4,1);
insert into ProductRating VALUES('PRO005',4,1);
insert into ProductRating VALUES('PRO006',4,1);
insert into ProductRating VALUES('PRO007',4,1);
insert into ProductRating VALUES('PRO008',4,1);
insert into ProductRating VALUES('PRO009',4,1);
insert into ProductRating VALUES('PRO010',4,1);
insert into ProductRating VALUES('PRO011',4,1);
insert into ProductRating VALUES('PRO012',4,1);
insert into ProductRating VALUES('PRO013',4,1);
insert into ProductRating VALUES('PRO014',4,1);
insert into ProductRating VALUES('PRO015',4,1);
insert into ProductRating VALUES('PRO016',4,1);
insert into ProductRating VALUES('PRO017',4,1);
insert into ProductRating VALUES('PRO018',4,1);
insert into ProductRating VALUES('PRO019',4,1);
insert into ProductRating VALUES('PRO020',4,1);
insert into ProductRating VALUES('PRO021',4,1);
insert into ProductRating VALUES('PRO022',4,1);
insert into ProductRating VALUES('PRO023',4,1);
insert into ProductRating VALUES('PRO024',4,1);
insert into ProductRating VALUES('PRO025',4,1);
insert into ProductRating VALUES('PRO026',4,1);
insert into ProductRating VALUES('PRO027',4,1);
insert into ProductRating VALUES('PRO028',4,1);
insert into ProductRating VALUES('PRO029',4,1);
insert into ProductRating VALUES('PRO030',4,1);
insert into ProductRating VALUES('PRO031',4,1);
insert into ProductRating VALUES('PRO032',4,1);
insert into ProductRating VALUES('PRO033',4,1);
insert into ProductRating VALUES('PRO034',4,1);
insert into ProductRating VALUES('PRO035',4,1);
insert into ProductRating VALUES('PRO036',4,1);
insert into ProductRating VALUES('PRO037',4,1);
insert into ProductRating VALUES('PRO038',4,1);
insert into ProductRating VALUES('PRO039',4,1);
insert into ProductRating VALUES('PRO040',4,1);
insert into ProductRating VALUES('PRO041',4,1);
insert into ProductRating VALUES('PRO042',4,1);
insert into ProductRating VALUES('PRO043',4,1);
insert into ProductRating VALUES('PRO044',4,1);
insert into ProductRating VALUES('PRO045',4,1);
insert into ProductRating VALUES('PRO046',4,1);
insert into ProductRating VALUES('PRO047',4,1);
insert into ProductRating VALUES('PRO048',4,1);
insert into ProductRating VALUES('PRO049',4,1);
insert into ProductRating VALUES('PRO050',4,1);
insert into ProductRating VALUES('PRO051',4,1);
insert into ProductRating VALUES('PRO052',4,1);
insert into ProductRating VALUES('PRO053',4,1);
insert into ProductRating VALUES('PRO054',4,1);
insert into ProductRating VALUES('PRO055',4,1);
insert into ProductRating VALUES('PRO056',4,1);
insert into ProductRating VALUES('PRO057',4,1);
insert into ProductRating VALUES('PRO058',4,1);
insert into ProductRating VALUES('PRO059',4,1);
insert into ProductRating VALUES('PRO060',4,1);
insert into ProductRating VALUES('PRO061',4,1);
insert into ProductRating VALUES('PRO062',4,1);
insert into ProductRating VALUES('PRO063',4,1);
insert into ProductRating VALUES('PRO064',4,1);
insert into ProductRating VALUES('PRO065',4,1);
insert into ProductRating VALUES('PRO066',4,1);
insert into ProductRating VALUES('PRO067',4,1);
insert into ProductRating VALUES('PRO068',4,1);
insert into ProductRating VALUES('PRO069',4,1);
insert into ProductRating VALUES('PRO070',4,1);
insert into ProductRating VALUES('PRO071',4,1);
insert into ProductRating VALUES('PRO072',4,1);
insert into ProductRating VALUES('PRO073',4,1);
insert into ProductRating VALUES('PRO074',4,1);
insert into ProductRating VALUES('PRO075',4,1);
insert into ProductRating VALUES('PRO076',4,1);
insert into ProductRating VALUES('PRO077',4,1);
insert into ProductRating VALUES('PRO078',4,1);
insert into ProductRating VALUES('PRO079',4,1);
insert into ProductRating VALUES('PRO080',4,1);
insert into ProductRating VALUES('PRO081',4,1);
insert into ProductRating VALUES('PRO082',4,1);
insert into ProductRating VALUES('PRO083',4,1);
insert into ProductRating VALUES('PRO084',4,1);
insert into ProductRating VALUES('PRO085',4,1);
insert into ProductRating VALUES('PRO086',4,1);
insert into ProductRating VALUES('PRO087',4,1);
insert into ProductRating VALUES('PRO088',4,1);
insert into ProductRating VALUES('PRO089',4,1);
insert into ProductRating VALUES('PRO090',4,1);
insert into ProductRating VALUES('PRO091',4,1);
insert into ProductRating VALUES('PRO092',4,1);
insert into ProductRating VALUES('PRO093',4,1);
insert into ProductRating VALUES('PRO094',4,1);
insert into ProductRating VALUES('PRO095',4,1);
insert into ProductRating VALUES('PRO096',4,1);
insert into ProductRating VALUES('PRO097',4,1);
insert into ProductRating VALUES('PRO098',4,1);
insert into ProductRating VALUES('PRO099',4,1);
insert into ProductRating VALUES('PRO100',4,1);
insert into ProductRating VALUES('PRO101',4,1);
insert into ProductRating VALUES('PRO102',4,1);
insert into ProductRating VALUES('PRO103',4,1);
insert into ProductRating VALUES('PRO104',4,1);
insert into ProductRating VALUES('PRO105',4,1);
insert into ProductRating VALUES('PRO106',4,1);
insert into ProductRating VALUES('PRO107',4,1);
insert into ProductRating VALUES('PRO108',4,1);
insert into ProductRating VALUES('PRO109',4,1);
insert into ProductRating VALUES('PRO110',4,1);
insert into ProductRating VALUES('PRO111',4,1);
insert into ProductRating VALUES('PRO112',4,1);

-- Product Comment
insert into ProductsComment VALUES('CMT001','tuyetbich','PRO001','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT002','tungchaien','PRO002','I like it so much',1);
insert into ProductsComment VALUES('CMT003','ducchau','PRO003','I really love it',1);
insert into ProductsComment VALUES('CMT004','dieunhi','PRO004','This is ok, fine',1);
insert into ProductsComment VALUES('CMT005','thixuka','PRO005','This work',1);
insert into ProductsComment VALUES('CMT006','rainyday','PRO028','I really love it',1);
insert into ProductsComment VALUES('CMT007','linhnhi','PRO029','This is ok, fine',1);
insert into ProductsComment VALUES('CMT008','tuanka','PRO030','This work',1);
insert into ProductsComment VALUES('CMT009','HungDung','PRO031','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT010','Thanh','PRO032','I like it so much',1);
insert into ProductsComment VALUES('CMT011','Giangnhi','PRO033','I really love it',1);
insert into ProductsComment VALUES('CMT012','dave','PRO034','This is ok, fine',1);
insert into ProductsComment VALUES('CMT013','josh','PRO035','This work',1);
insert into ProductsComment VALUES('CMT014','Thanh','PRO006','I really love it',1);
insert into ProductsComment VALUES('CMT015','Giangnhi','PRO007','This is ok, fine',1);
insert into ProductsComment VALUES('CMT016','tungchaien','PRO008','This work',1);
insert into ProductsComment VALUES('CMT017','ducchau','PRO009','This is ok, fine',1);
insert into ProductsComment VALUES('CMT018','linhnhi','PRO010','This work',1);
insert into ProductsComment VALUES('CMT019','thixuka','PRO001','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT020','rainyday','PRO002','I like it so much',1);
insert into ProductsComment VALUES('CMT021','linhnhi','PRO003','I really love it',1);
insert into ProductsComment VALUES('CMT022','tuanka','PRO004','This is ok, fine',1);
insert into ProductsComment VALUES('CMT023','ducchau','PRO005','This work',1);
insert into ProductsComment VALUES('CMT024','dieunhi','PRO108','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT025','thixuka','PRO109','I like it so much',1);
insert into ProductsComment VALUES('CMT026','dieunhi','PRO110','I really love it',1);
insert into ProductsComment VALUES('CMT027','thixuka','PRO111','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT028','tuanka','PRO112','I really love it',1);
insert into ProductsComment VALUES('CMT029','ducchau','PRO009','This is ok, fine',1);
insert into ProductsComment VALUES('CMT030','thixuka','PRO010','This work',1);
insert into ProductsComment VALUES('CMT031','rainyday','PRO001','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT032','linhnhi','PRO002','I like it so much',1);
insert into ProductsComment VALUES('CMT033','tuanka','PRO108','I really love it',1);
insert into ProductsComment VALUES('CMT034','rainyday','PRO109','This is ok, fine',1);
insert into ProductsComment VALUES('CMT035','dieunhi','PRO110','This work',1);
insert into ProductsComment VALUES('CMT036','thixuka','PRO111','This is ok, fine',1);
insert into ProductsComment VALUES('CMT037','tuyetbich','PRO112','This work',1);
insert into ProductsComment VALUES('CMT038','dieunhi','PRO010','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT039','HungDung','PRO001','I like it so much',1);
insert into ProductsComment VALUES('CMT040','Thanh','PRO002','I really love it',1);
insert into ProductsComment VALUES('CMT041','Giangnhi','PRO001','This work',1);
insert into ProductsComment VALUES('CMT042','rainyday','PRO002','I really love it',1);
insert into ProductsComment VALUES('CMT043','tuyetbich','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT044','Giangnhi','PRO001','This work',1);
insert into ProductsComment VALUES('CMT045','HungDung','PRO002','This work',1);
insert into ProductsComment VALUES('CMT046','Giangnhi','PRO003','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT047','rainyday','PRO004','I like it so much',1);
insert into ProductsComment VALUES('CMT048','tuyetbich','PRO005','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT049','Thanh','PRO108','I like it so much',1);
insert into ProductsComment VALUES('CMT050','Giangnhi','PRO109','I really love it',1);
insert into ProductsComment VALUES('CMT051','rainyday','PRO110','This is ok, fine',1);
insert into ProductsComment VALUES('CMT052','tuyetbich','PRO111','This work',1);
insert into ProductsComment VALUES('CMT053','Giangnhi','PRO112','This work',1);
insert into ProductsComment VALUES('CMT054','HungDung','PRO037','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT055','tuanka','PRO008','I like it so much',1);
insert into ProductsComment VALUES('CMT056','ducchau','PRO009','I really love it',1);
insert into ProductsComment VALUES('CMT057','dieunhi','PRO010','This is ok, fine',1);
insert into ProductsComment VALUES('CMT058','thixuka','PRO001','This work',1);
insert into ProductsComment VALUES('CMT059','rainyday','PRO002','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT060','linhnhi','PRO001','I like it so much',1);
insert into ProductsComment VALUES('CMT061','tuanka','PRO002','I really love it',1);
insert into ProductsComment VALUES('CMT062','HungDung','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT063','Thanh','PRO004','This work',1);
insert into ProductsComment VALUES('CMT064','Giangnhi','PRO005','This work',1);
insert into ProductsComment VALUES('CMT065','rainyday','PRO109','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT066','tuyetbich','PRO110','I like it so much',1);
insert into ProductsComment VALUES('CMT067','dieunhi','PRO111','I really love it',1);
insert into ProductsComment VALUES('CMT068','HungDung','PRO112','This is ok, fine',1);
insert into ProductsComment VALUES('CMT069','Thanh','PRO112','This work',1);
insert into ProductsComment VALUES('CMT070','Giangnhi','PRO037','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT071','Giangnhi','PRO008','I like it so much',1);
insert into ProductsComment VALUES('CMT072','rainyday','PRO002','I really love it',1);
insert into ProductsComment VALUES('CMT073','tuyetbich','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT074','HungDung','PRO004','This work',1);
insert into ProductsComment VALUES('CMT075','thixuka','PRO005','This is ok, fine',1);
insert into ProductsComment VALUES('CMT076','rainyday','PRO108','This work',1);
insert into ProductsComment VALUES('CMT077','linhnhi','PRO109','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT078','tuanka','PRO110','I like it so much',1);
insert into ProductsComment VALUES('CMT079','rainyday','PRO111','I really love it',1);
insert into ProductsComment VALUES('CMT080','tuyetbich','PRO112','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT081','HungDung','PRO112','I like it so much',1);
insert into ProductsComment VALUES('CMT082','Thanh','PRO037','I really love it',1);
insert into ProductsComment VALUES('CMT083','Giangnhi','PRO008','This is ok, fine',1);
insert into ProductsComment VALUES('CMT084','rainyday','PRO002','This work',1);
insert into ProductsComment VALUES('CMT085','tuyetbich','PRO003','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT086','HungDung','PRO004','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT087','Thanh','PRO005','I really love it',1);
insert into ProductsComment VALUES('CMT088','Giangnhi','PRO108','This is ok, fine',1);
insert into ProductsComment VALUES('CMT089','thixuka','PRO109','This work',1);
insert into ProductsComment VALUES('CMT090','rainyday','PRO110','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT091','linhnhi','PRO111','I really love it',1);
insert into ProductsComment VALUES('CMT092','tuanka','PRO112','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT093','Thanh','PRO001','I like it so much',1);
insert into ProductsComment VALUES('CMT094','HungDung','PRO002','I really love it',1);
insert into ProductsComment VALUES('CMT095','Giangnhi','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT096','rainyday','PRO004','This work',1);
insert into ProductsComment VALUES('CMT097','tuyetbich','PRO005','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT098','thixuka','PRO112','This is ok, fine',1);
insert into ProductsComment VALUES('CMT099','rainyday','PRO037','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT100','linhnhi','PRO008','I really love it',1);
insert into ProductsComment VALUES('CMT101','tuanka','PRO112','This is ok, fine',1);
insert into ProductsComment VALUES('CMT102','rainyday','PRO037','This work',1);
insert into ProductsComment VALUES('CMT103','linhnhi','PRO055','I really love it',1);
insert into ProductsComment VALUES('CMT104','HungDung','PRO004','This is ok, fine',1);
insert into ProductsComment VALUES('CMT105','Thanh','PRO008','I really love it',1);
insert into ProductsComment VALUES('CMT106','Giangnhi','PRO008','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT107','Thanh','PRO037','I like it so much',1);
insert into ProductsComment VALUES('CMT108','HungDung','PRO112','I really love it',1);
insert into ProductsComment VALUES('CMT109','Giangnhi','PRO037','This is ok, fine',1);
insert into ProductsComment VALUES('CMT110','Giangnhi','PRO055','This work',1);
insert into ProductsComment VALUES('CMT111','rainyday','PRO004','This is ok, fine',1);
insert into ProductsComment VALUES('CMT112','tuyetbich','PRO002','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT113','rainyday','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT114','linhnhi','PRO004','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT115','tuanka','PRO005','This is ok, fine',1);
insert into ProductsComment VALUES('CMT116','HungDung','PRO003','This work',1);
insert into ProductsComment VALUES('CMT117','Thanh','PRO004','This is not as good as I expected',1);
insert into ProductsComment VALUES('CMT118','Giangnhi','PRO005','This is ok, fine',1);
insert into ProductsComment VALUES('CMT119','Thanh','PRO108','This work',1);
insert into ProductsComment VALUES('CMT120','Giangnhi','PRO017','I really love it',1);
insert into ProductsComment VALUES('CMT121','rainyday','PRO001','This is ok, fine',1);
insert into ProductsComment VALUES('CMT122','tuyetbich','PRO002','This work',1);
insert into ProductsComment VALUES('CMT123','thixuka','PRO003','This product really really good. I love it',1);
insert into ProductsComment VALUES('CMT124','rainyday','PRO004','I like it so much',1);
insert into ProductsComment VALUES('CMT125','linhnhi','PRO005','I really love it',1);
insert into ProductsComment VALUES('CMT126','tuanka','PRO003','This is ok, fine',1);
insert into ProductsComment VALUES('CMT127','rainyday','PRO004','This work',1);
insert into ProductsComment VALUES('CMT128','HungDung','PRO005','I really love it',1);
insert into ProductsComment VALUES('CMT129','Thanh','PRO108','This is ok, fine',1);
insert into ProductsComment VALUES('CMT130','Giangnhi','PRO109','This work',1);

-- OrderMaster
insert into OrderMaster VALUES('ORD001','tuyetbich',432,25,'Deliever at weekend','Done','01/03/2017  21:44:04');
insert into OrderMaster VALUES('ORD011','tuyetbich',187,25,'','Done','02/14/2017  21:44:05');
insert into OrderMaster VALUES('ORD021','tuyetbich',432,25,'Deliever at weekend','Done','03/03/2017  21:44:10');
insert into OrderMaster VALUES('ORD027','tuyetbich',153,25,'','Done','04/18/2017  21:44:11');
insert into OrderMaster VALUES('ORD030','tuyetbich',149,25,'Deliever at weekend','Done','05/21/2017  21:44:12');
insert into OrderMaster VALUES('ORD002','tungchaien',149,25,'Deliever at weekend','Done','07/04/2017  21:44:05');
insert into OrderMaster VALUES('ORD015','tungchaien',149,25,'Deliever at weekend','Done','08/18/2017  21:44:06');
insert into OrderMaster VALUES('ORD003','ducchau',161,25,'Deliever immediately','Done','09/05/2017  21:44:07');
insert into OrderMaster VALUES('ORD016','ducchau',432,25,'','Done','10/19/2017  21:44:08');
insert into OrderMaster VALUES('ORD018','ducchau',187,25,'Deliever at weekend','Done','11/20/2017  21:44:09');
insert into OrderMaster VALUES('ORD004','dieunhi',160,25,'','Done','12/07/2017  21:44:10');
insert into OrderMaster VALUES('ORD022','dieunhi',119,30,'Deliever at weekend','Done','02/05/2017  21:44:12');
insert into OrderMaster VALUES('ORD005','thixuka',153,25,'Deliever at weekend','Done','04/08/2017  21:44:10');
insert into OrderMaster VALUES('ORD017','thixuka',119,25,'Deliever at weekend','Done','05/19/2017  21:44:59');
insert into OrderMaster VALUES('ORD028','thixuka',432,25,'','Done','06/19/2017  21:44:12');
insert into OrderMaster VALUES('ORD006','rainyday',360,25,'Deliever at weekend','Done','07/19/2017  21:44:10');
insert into OrderMaster VALUES('ORD026','rainyday',187,25,'','Done','09/17/2017  21:44:12');
insert into OrderMaster VALUES('ORD007','linhnhi',119,30,'Deliever at weekend','Done','10/11/2017  21:44:10');
insert into OrderMaster VALUES('ORD019','linhnhi',432,25,'','Done','11/21/2017  21:44:10');
insert into OrderMaster VALUES('ORD008','tuanka',149,25,'Deliever at weekend','Done','12/11/2017  21:44:50');
insert into OrderMaster VALUES('ORD031','tuanka',119,25,'Deliever at weekend','Done','01/22/2017  21:44:12');
insert into OrderMaster VALUES('ORD033','tuanka',187,25,'','Done','03/25/2017  21:44:12');
insert into OrderMaster VALUES('ORD009','HungDung',187,25,'Deliever at weekend','Delivery','05/13/2017  21:44:10');
insert into OrderMaster VALUES('ORD020','HungDung',153,25,'','Done','07/22/2017  21:44:10');
insert into OrderMaster VALUES('ORD010','Thanh',432,25,'Deliever at weekend','Cancel','09/14/2017  21:44:10');
insert into OrderMaster VALUES('ORD023','Thanh',149,25,'Deliever at weekend','Done','11/07/2017  21:44:12');
insert into OrderMaster VALUES('ORD012','Giangnhi',119,25,'Deliever at weekend','Done','12/14/2017  21:44:50');
insert into OrderMaster VALUES('ORD013','dave',120,25,'Deliever immediately','Done','02/15/2017  21:44:10');
insert into OrderMaster VALUES('ORD025','dave',432,25,'','Done','04/13/2017  21:44:12');
insert into OrderMaster VALUES('ORD029','dave',119,25,'Deliever at weekend','Done','05/20/2017  21:44:12');
insert into OrderMaster VALUES('ORD032','dave',432,25,'','Done','07/24/2017  21:44:12');
insert into OrderMaster VALUES('ORD014','josh',360,30,'Deliever at weekend','Processing','01/12/2018  21:44:10');
insert into OrderMaster VALUES('ORD024','josh',360,25,'Deliever at weekend','Done','12/10/2017  21:44:12');

-- OrderDetails
insert into OrderDetails VALUES('ORD001','PRO013',1);
insert into OrderDetails VALUES('ORD001','PRO020',1);
insert into OrderDetails VALUES('ORD001','PRO027',20);
insert into OrderDetails VALUES('ORD002','PRO094',3);
insert into OrderDetails VALUES('ORD002','PRO101',4);
insert into OrderDetails VALUES('ORD002','PRO107',2);
insert into OrderDetails VALUES('ORD003','PRO068',2);
insert into OrderDetails VALUES('ORD003','PRO070',15);
insert into OrderDetails VALUES('ORD004','PRO083',2);
insert into OrderDetails VALUES('ORD004','PRO086',1);
insert into OrderDetails VALUES('ORD004','PRO087',2);
insert into OrderDetails VALUES('ORD005','PRO105',3);
insert into OrderDetails VALUES('ORD005','PRO107',5);
insert into OrderDetails VALUES('ORD005','PRO112',2);
insert into OrderDetails VALUES('ORD006','PRO006',1);
insert into OrderDetails VALUES('ORD006','PRO010',5);
insert into OrderDetails VALUES('ORD007','PRO055',10);
insert into OrderDetails VALUES('ORD007','PRO058',2);
insert into OrderDetails VALUES('ORD007','PRO060',3);
insert into OrderDetails VALUES('ORD008','PRO094',3);
insert into OrderDetails VALUES('ORD008','PRO101',4);
insert into OrderDetails VALUES('ORD008','PRO107',2);
insert into OrderDetails VALUES('ORD009','PRO038',1);
insert into OrderDetails VALUES('ORD009','PRO039',1);
insert into OrderDetails VALUES('ORD009','PRO042',2);
insert into OrderDetails VALUES('ORD009','PRO046',1);
insert into OrderDetails VALUES('ORD010','PRO013',1);
insert into OrderDetails VALUES('ORD010','PRO020',1);
insert into OrderDetails VALUES('ORD010','PRO027',20);
insert into OrderDetails VALUES('ORD011','PRO038',1);
insert into OrderDetails VALUES('ORD011','PRO039',1);
insert into OrderDetails VALUES('ORD011','PRO042',2);
insert into OrderDetails VALUES('ORD011','PRO046',1);
insert into OrderDetails VALUES('ORD012','PRO055',10);
insert into OrderDetails VALUES('ORD012','PRO058',2);
insert into OrderDetails VALUES('ORD012','PRO060',3);
insert into OrderDetails VALUES('ORD013','PRO097',1);
insert into OrderDetails VALUES('ORD013','PRO099',1);
insert into OrderDetails VALUES('ORD014','PRO006',1);
insert into OrderDetails VALUES('ORD014','PRO010',5);
insert into OrderDetails VALUES('ORD015','PRO094',3);
insert into OrderDetails VALUES('ORD015','PRO101',4);
insert into OrderDetails VALUES('ORD015','PRO107',2);
insert into OrderDetails VALUES('ORD016','PRO013',1);
insert into OrderDetails VALUES('ORD016','PRO020',1);
insert into OrderDetails VALUES('ORD016','PRO027',20);
insert into OrderDetails VALUES('ORD017','PRO055',10);
insert into OrderDetails VALUES('ORD017','PRO058',2);
insert into OrderDetails VALUES('ORD017','PRO060',3);
insert into OrderDetails VALUES('ORD018','PRO038',1);
insert into OrderDetails VALUES('ORD018','PRO039',1);
insert into OrderDetails VALUES('ORD018','PRO042',2);
insert into OrderDetails VALUES('ORD019','PRO013',1);
insert into OrderDetails VALUES('ORD019','PRO020',1);
insert into OrderDetails VALUES('ORD019','PRO027',20);
insert into OrderDetails VALUES('ORD020','PRO105',3);
insert into OrderDetails VALUES('ORD020','PRO107',5);
insert into OrderDetails VALUES('ORD020','PRO112',2);
insert into OrderDetails VALUES('ORD021','PRO013',1);
insert into OrderDetails VALUES('ORD021','PRO020',1);
insert into OrderDetails VALUES('ORD021','PRO027',20);
insert into OrderDetails VALUES('ORD022','PRO055',10);
insert into OrderDetails VALUES('ORD022','PRO058',2);
insert into OrderDetails VALUES('ORD022','PRO060',3);
insert into OrderDetails VALUES('ORD023','PRO094',3);
insert into OrderDetails VALUES('ORD023','PRO101',4);
insert into OrderDetails VALUES('ORD023','PRO107',2);
insert into OrderDetails VALUES('ORD024','PRO006',1);
insert into OrderDetails VALUES('ORD024','PRO010',5);
insert into OrderDetails VALUES('ORD025','PRO013',1);
insert into OrderDetails VALUES('ORD025','PRO020',1);
insert into OrderDetails VALUES('ORD025','PRO027',20);
insert into OrderDetails VALUES('ORD026','PRO038',1);
insert into OrderDetails VALUES('ORD026','PRO039',1);
insert into OrderDetails VALUES('ORD026','PRO042',2);
insert into OrderDetails VALUES('ORD026','PRO046',1);
insert into OrderDetails VALUES('ORD027','PRO105',3);
insert into OrderDetails VALUES('ORD027','PRO107',5);
insert into OrderDetails VALUES('ORD027','PRO112',2);
insert into OrderDetails VALUES('ORD028','PRO013',1);
insert into OrderDetails VALUES('ORD028','PRO020',1);
insert into OrderDetails VALUES('ORD028','PRO027',20);
insert into OrderDetails VALUES('ORD029','PRO055',10);
insert into OrderDetails VALUES('ORD029','PRO058',2);
insert into OrderDetails VALUES('ORD029','PRO060',3);
insert into OrderDetails VALUES('ORD030','PRO094',3);
insert into OrderDetails VALUES('ORD030','PRO101',4);
insert into OrderDetails VALUES('ORD030','PRO107',2);
insert into OrderDetails VALUES('ORD031','PRO055',10);
insert into OrderDetails VALUES('ORD031','PRO058',2);
insert into OrderDetails VALUES('ORD031','PRO060',3);
insert into OrderDetails VALUES('ORD032','PRO013',1);
insert into OrderDetails VALUES('ORD032','PRO020',1);
insert into OrderDetails VALUES('ORD032','PRO027',20);
insert into OrderDetails VALUES('ORD033','PRO038',1);
insert into OrderDetails VALUES('ORD033','PRO039',1);
insert into OrderDetails VALUES('ORD033','PRO042',2);

-- OrderAddress
insert into OrderAddress VALUES('ORD001','tuyetbich',10.7263446,106.7212909,'197 Bach Dang','0937751239');
insert into OrderAddress VALUES('ORD011','tuyetbich',10.836783,106.6623593,'250 Nguyen Van Dau','0937751240');
insert into OrderAddress VALUES('ORD021','tuyetbich',10.7263446,106.7212909,'300 Thanh Thai','0937751241');
insert into OrderAddress VALUES('ORD027','tuyetbich',10.769722,106.68379,'12 Ngo Duc Ke','0937751242');
insert into OrderAddress VALUES('ORD030','tuyetbich',10.773626,106.611699,'35 Tran Quang Khai','0937751243');
insert into OrderAddress VALUES('ORD002','tungchaien',10.7770499,106.6287643,'197 Bach Dang','0937751244');
insert into OrderAddress VALUES('ORD015','tungchaien',10.836783,106.6623593,'250 Nguyen Van Dau','0937751245');
insert into OrderAddress VALUES('ORD003','ducchau',10.773626,106.611699,'300 Thanh Thai','0937751246');
insert into OrderAddress VALUES('ORD016','ducchau',10.7770499,106.6287643,'12 Ngo Duc Ke','0937751247');
insert into OrderAddress VALUES('ORD018','ducchau',10.773626,106.611699,'35 Tran Quang Khai','0937751248');
insert into OrderAddress VALUES('ORD004','dieunhi',10.7770499,106.6287643,'197 Bach Dang','0937751249');
insert into OrderAddress VALUES('ORD022','dieunhi',10.7263446,106.7212909,'250 Nguyen Van Dau','0937751250');
insert into OrderAddress VALUES('ORD005','thixuka',10.836783,106.6623593,'300 Thanh Thai','0937751251');
insert into OrderAddress VALUES('ORD017','thixuka',10.7770499,106.6287643,'12 Ngo Duc Ke','0937751252');
insert into OrderAddress VALUES('ORD028','thixuka',10.7263446,106.7212909,'35 Tran Quang Khai','0937751253');
insert into OrderAddress VALUES('ORD006','rainyday',10.7770499,106.6287643,'197 Bach Dang','0937751254');
insert into OrderAddress VALUES('ORD026','rainyday',10.7770499,106.6287643,'250 Nguyen Van Dau','0937751255');
insert into OrderAddress VALUES('ORD007','linhnhi',10.773626,106.611699,'300 Thanh Thai','0937751256');
insert into OrderAddress VALUES('ORD019','linhnhi',10.7263446,106.7212909,'12 Ngo Duc Ke','0937751257');
insert into OrderAddress VALUES('ORD008','tuanka',10.773626,106.611699,'35 Tran Quang Khai','0937751258');
insert into OrderAddress VALUES('ORD031','tuanka',10.7654452805263,106.638790826842,'198 Bach Dang','0937751259');
insert into OrderAddress VALUES('ORD033','tuanka',10.7648104339098,106.637207080827,'251 Nguyen Van Dau','0937751260');
insert into OrderAddress VALUES('ORD009','HungDung',10.7641755872932,106.635623334812,'301 Thanh Thai','0937751261');
insert into OrderAddress VALUES('ORD020','HungDung',10.7635407406767,106.634039588797,'13 Ngo Duc Ke','0937751262');
insert into OrderAddress VALUES('ORD010','Thanh',10.7629058940602,106.632455842782,'36 Tran Quang Khai','0937751263');
insert into OrderAddress VALUES('ORD023','Thanh',10.7622710474436,106.630872096767,'198 Bach Dang','0937751264');
insert into OrderAddress VALUES('ORD012','Giangnhi',10.7616362008271,106.629288350752,'251 Nguyen Van Dau','0937751265');
insert into OrderAddress VALUES('ORD013','dave',10.7610013542105,106.627704604737,'301 Thanh Thai','0937751266');
insert into OrderAddress VALUES('ORD025','dave',10.760366507594,106.626120858722,'13 Ngo Duc Ke','0937751267');
insert into OrderAddress VALUES('ORD029','dave',10.7597316609774,106.624537112707,'36 Tran Quang Khai','0937751268');
insert into OrderAddress VALUES('ORD032','dave',10.7590968143609,106.622953366692,'198 Bach Dang','0937751269');
insert into OrderAddress VALUES('ORD014','josh',10.7584619677444,106.621369620677,'251 Nguyen Van Dau','0937751270');
insert into OrderAddress VALUES('ORD024','josh',10.7578271211278,106.619785874662,'301 Thanh Thai','0937751271');