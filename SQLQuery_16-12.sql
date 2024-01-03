create database fahasaa;
use fahasaa;

use master;

drop database fahasaa
delete from  Categories

create table Users(
	Id int identity(1,1) not null primary key,
	Email varchar(255) not null unique,
	Password varchar(100) not null,
	Role nvarchar(50) not null,
	Phone varchar(11) null unique,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Gender nvarchar(20),
	Birthday date
)

CREATE TABLE OtpDetails(
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) NOT NULL,
    otp NVARCHAR(10) NOT NULL,
    expiry_time DATETIME NOT NULL
);

CREATE TABLE TypeNotify (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(50) NOT NULL
);

INSERT INTO TypeNotify (type) VALUES ('noti'), ('order');

CREATE TABLE Notification (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
	user_email NVARCHAR(255) NOT NULL,
	id_users INT NOT NULL,
	type_notify_id INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    notification_date DATETIME NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (type_notify_id) REFERENCES TypeNotify(id)
);

create table Categories(
	Id int identity(1,1) primary key,
	CategoryName nvarchar(100) not null,
	Level int not null,
	ParentId int null,
	Images varchar(500) null,
	foreign key(ParentId) references Categories(Id)
)

create table Voucher(
	Id int identity(1,1) primary key,
	Code char(5) not null,
	ExpDate date,
	ValueV money,
	Condition money,
	Active bit,
	Quantity int
)

create table Myvoucher (
    Id int identity(1,1) primary key,
    title nvarchar(50) not null,
	Code char(15) not null,
	ExpDate date,
	ValueV money,
	Condition money,
	Active bit,
    Quantity int,
    UserId int not null,
    foreign key (UserId) references Users(Id)
);

create table Statuss(
	Id int primary key,
	Statuss nvarchar(50)
)

create table Product(
	Id int primary key,
	Name nvarchar(100)
)


create table Books(
	Id int identity(1,1) primary key,
	Title nvarchar(255) not null,
	Author nvarchar(255) not null,
	Images varchar(500) not null,
	Price money not null,
	Discount int,
	Description ntext,
	ProductId int not null,
	foreign key(ProductId) references Product(Id)
)

create table SchoolTools (
	Id int identity(1,1) primary key,
	Title nvarchar(100) not null,
	Brand nvarchar(100) not null,
	Images varchar(500) not null,
	Price money not null,
	Discount int,
	Description ntext,
	ProductId int not null,
	CategoryId int not null,
	foreign key(ProductId) references Product(Id),
	foreign key(CategoryId) references Categories(Id)
)

create table Cat(
	Id int identity(1,1) primary key,
	CategoryId int not null,
	BookId int not null,
	foreign key(CategoryId) references Categories(Id),
	foreign key(BookId) references Books(Id)
)

create table Address(
	id int identity(1,1) primary key,
	FirstName nvarchar(255) not null, 
	LastName nvarchar(255) not null,
	Phone varchar(10) not null,
	District nvarchar(255) not null,
	City nvarchar(255) not null,
	Ward nvarchar(255) not null,
	Address nvarchar(255) not null,
	IsActive bit not null,
	UserId int not null,
	foreign key(UserId) references Users(Id)
)

create table Orders(
	Id int identity(1,1) primary key,
	OrderDate datetime not null,
	TotalAmount money null,
	UserId int not null,
	StatussId int not null,
	VoucherId int null,
	Ship money null,
	receiver nvarchar(255) null,
	AddressId int null,
     MyvoucherId int null,
	 CodeOrder varchar(16) null,
	foreign key (AddressId) references Address(Id),
	foreign key(UserId) references Users(Id),
	foreign key(StatussId) references Statuss(Id),
	foreign key(VoucherId) references Voucher(Id),
    foreign key(MyvoucherId) references Myvoucher(Id)
)

create table OrderDetails(
	Id int identity(1,1) primary key,
	Quantity int not null,
	Price money not null,
	OrderId int not null,
	Bookid int null,
	Schooltoolid int null,
	foreign key(OrderId) references Orders(Id),
	foreign key(Bookid) references Books(Id),
	foreign key(Schooltoolid) references SchoolTools(Id)
)

create table Reviews(
	Id int identity(1,1) primary key,
	Rating int,
	Comment nvarchar(max) not null,
	CreateDate date not null,
	UserName nvarchar(255) not null,
	UserId int null,
	BookId int null,
	SchoolToolId int null,
	foreign key(UserId) references Users(Id),
	foreign key(BookId) references Books(Id),
	foreign key(SchoolToolId) references SchoolTools(Id)
)

create table Favorite(
    id int identity(1,1) PRIMARY key,
    UserId int not null,
    BookId int null,
    SchooltoolId int null,
    foreign key(UserId) references Users(Id),
    foreign key(BookId) references Books(Id),
	foreign key(Schooltoolid) references SchoolTools(Id)
)

select * from Address;



--insert sản phẩm product
INSERT INTO Product
VALUES  (1,'Books'),
		(2,'SchoolTools')

--insert cate lớn nhất
insert into Categories
values	(N'Sách trong nước', 1, null,null),
		(N'Sách nước ngoài', 1, null,null),
		(N'Dụng cụ học sinh', 1, null,null)

--insert cate cấp 2
insert into Categories
values	(N'Văn Học', 2, 1,null),
		(N'Kinh tế', 2, 1,null),
		(N'Tâm lí và Kỹ năng sống', 2, 1,null),
		(N'Nuôi dạy con', 2, 1,null),
		(N'Sách thiếu nhi',2,1,null),
		(N'Tiểu sử - hồi ký',2,1,null),
		(N'Giáo khoa - tham khảo',2,1,null),
		(N'Sách học ngoại ngữ',2,1,null),
		('Fiction', 2, 2,null),
		('Business & Management', 2, 2,null),
		('Personal Development', 2, 2,null),
		('Children''s Books', 2, 2,null),
		('Dictionaries & Languages', 2, 2,null),
		('Other Languages', 2, 2,null),
		('Other Categories', 2, 2,null),
		(N'Bút - Viết', 2, 3,null),
		(N'Dụng cụ học sinh',2,3,null),
		(N'Dụng cụ văn phòng',2,3,null),
		(N'Dụng cụ vẽ',2,3,null),
		(N'Sản phẩm về giấy',2,3,null),
		(N'Sản phẩm khác',2,3,null),
		(N'Sản phẩm điện tử',2,3,null)

-- insert cate cấp 3
insert into Categories
values	(N'Tiểu thuyết', 3, 4,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2FTi_u_Thuy_t.jpg?alt=media&token=6a486cee-215c-4170-88f4-b308c710a68a&_gl=1*vl41mx*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcxMC40MS4wLjA.'), --26
		(N'Truyện ngắn - Tản văn', 3, 4,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2Ftpkds1.jpg?alt=media&token=27a4beb6-9251-4bae-9ad0-406350e14680&_gl=1*1ajnmys*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzY5Mi41OS4wLjA.'), --27
		(N'Light novel', 3, 4,null), --28
		(N'Ngôn tình', 3, 4,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2F_am_m_.jpg?alt=media&token=52a6546a-2477-424e-8ccb-bbba0454babf&_gl=1*qph6h*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcwNy40NC4wLjA.'), --29
		(N'Nhân vật - Bài học kinh doanh', 3, 5,null), --30
		(N'	Quản trị - Lãnh đạo', 3, 5,null), --31
		(N'Marketing - Bán hàng', 3, 5,null), --32
		(N'Phân tích kinh tế', 3, 5,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2F9786043654370.jpg?alt=media&token=d52862d1-b09e-4dd2-8f4d-a4a5fadae8e9&_gl=1*1sd92l1*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcyMC4zMS4wLjA.'), --33
		(N'Kỹ năng sống', 3, 6,null), --34
		(N'Rèn luyện nhân cách', 3, 6,null), --35
		(N'Tâm lý', 3, 6,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2FThao_t_ng.jpg?alt=media&token=1259c13c-e7d6-4bd6-b020-dfcf3aa8777d&_gl=1*1n6wuez*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcxMy4zOC4wLjA.'), --36
		(N'Sách cho tuổi mới lớn', 3, 6,null), --37
		(N'Cẩm nang làm cha mẹ', 3, 7,null), --38
		(N'Phương pháp giáo dục trẻ các nước', 3, 7,null), --39
		(N'Phát triển trí tuệ cho trẻ', 3, 7,null), --40
		(N'Phát triển kỹ năng cho trẻ', 3, 7,null), --41
		(N'Manga - Comic',3,8,null), --42
		(N'Kiến thức bách khoa',3,8,null), --43
		(N'Sách tranh kỹ năng sống cho trẻ',3,8,null), --44
		(N'Vừa học vừa chơi cho trẻ',3,8,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2Fthieunhis2.jpg?alt=media&token=2ca0f8ea-8e22-4892-8b2a-4c9faac2e848&_gl=1*1oiwoa6*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzY5NS41Ni4wLjA.'), --45
		(N'Câu chuyện cuộc đời',3,9,null), --46
		(N'Chính trị',3,9,null), --47
		(N'Kinh tế',3,9,null), --48
		(N'Nghệ thuât - giải trí',3,9,null), --49
		(N'Sách giáo khoa',3,10,null), --50 
		(N'Sách tham khảo',3,10,null), --51
		(N'Luyện thi THPT Quốc Gia',3,10,null), --52
		(N'Mẫu giáo',3,10,null), --53
		(N'Tiếng Anh',3,11,null), --54
		(N'Tiếng Nhật',3,11,null), --55
		(N'Tiếng Hoa',3,11,null), --56
		(N'Tiếng Hàn',3,11,null), --57
		('Classic', 3, 12,null), --58
		('Romance', 3, 12,null), --59
		('Fantasy', 3, 12,null), --60
		('Thriller', 3, 12,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2FT_m_linh.jpg?alt=media&token=e74f95fe-cd51-4f56-bd70-b3e2916bbff8&_gl=1*umid91*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcxNy4zNC4wLjA.'), --61
		('Business & Management', 3, 13,null), --62
		('Economics', 3, 13,null), --63
		('Finance & Accounting', 3, 13,null), --64
		('Law', 3, 13,null), --65
		('Popular Psychology', 3, 14,null), --66
		('Personal Finance', 3, 14,null), --67
		('Consumer Advice', 3, 14,null), --68
		('Education', 3, 15,null), --69
		('Fiction For Teen', 3, 15,null), --70
		('Picture & Activity Books', 3, 15,null), --71
		('Reference', 3, 15,null), --72
		('ELT: Learning Material & Coursework', 3, 16,null), --73
		('ELT: English For Specific Purposes', 3, 16,null), --74
		('Dictionaries', 3, 16,null), --75
		('Japanese Books', 3, 17,null), --76
		('German Books', 3, 17,null), --77
		('French books', 3, 17,null), --78
		('Biography', 3, 18,null), --79
		('Society & Social Sciences', 3, 18,null), --80
		('Science & Geography', 3, 18,null), --81
		('Food & Drink', 3, 18,null), --82
		(N'Bút Bi - Ruột Bút Bi', 3, 19,null), --83
		(N'Bút Gel - Bút Nước - Ruột Bút Gel', 3, 19,null), --84
		(N'Bút Mực - Bút Máy', 3, 19,null), --85
		(N'Bút Dạ Quang', 3, 19,null), --86
		(N'Bút Chì - Ruột Bút Chì', 3, 19,null), --87
		(N'Gôm - Tẩy',3,20,null), --88 
		(N'Gọt bút chì',3,20,null), --89
		(N'Thước',3,20,null), --90
		(N'Bóp viết- Họp bút',3,20,null), --91
		(N'Bìa file - hồ sơ',3,21,null), --92
		(N'Kẹp giấy - kẹp bướm',3,21,null), --93
		(N'Đồ bấm kim',3,21,null), --94
		(N'Cấm bút - bảng tên',3,21,null), --95
		(N'Bút vẽ',3,22,null), --96
		(N'Màu vẽ',3,22,null), --97
		(N'Khay - cọ vẽ',3,22,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2Fdo-choi-s2-23.jpg?alt=media&token=0a66b6a6-1d58-40b0-a8d5-b5ee6fadabe5&_gl=1*1fhvcrb*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzcwMy40OC4wLjA.'), --98
		(N'Tập vẽ - giáy vẽ',3,22,null), --99
		(N'Tập vở',3,23,null), --100
		(N'Sổ tay',3,23,null), --101
		(N'Giấy photo',3,23,'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fcategories%2Fgiay-photo-t10.jpg?alt=media&token=76825789-461d-4a8c-b9a7-f6d5135a15ad&_gl=1*1p81nr*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODY4MzM2OC43LjEuMTY5ODY4MzY5OC41My4wLjA.'), --102
		(N'Giấy note',3,23,null), --103
		(N'Dao gọc giấy - kéo',3,24,null), --104
		(N'Băng keo',3,24,null), --105
		(N'Bút xóa',3,24,null), --106
		(N'Hồ dán',3,24,null), --107
		(N'Máy tính điện tử',3,25,null) --108

--insert book

--thịnh
insert into Books
values	(N'Mùa Hè Không Tên - Tặng Kèm Bookmark 2 Mặt + Poster Tranh + Chữ Ký Tác Giả Ngẫu Nhiên', N'Nguyễn Nhật Ánh', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftieuthuyet1.jpg?alt=media&token=d87f8dff-ef01-4f5e-a50f-b8261fadeb9e&_gl=1*1nzulba*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxNzIyNy40NC4wLjA.', 130000, 20, N'“Mùa hè không tên” là truyện dài mới nhất của nhà văn Nguyễn Nhật Ánh, với những câu chuyện tuổi thơ với vô số trò tinh nghịch, những thoáng thinh thích hồi hộp cùng vô vàn kỷ niệm. Để rồi khi những tháng ngày trong sáng của tình bạn dần qua, bọn nhỏ trong mỗi gia đình bình dị lớn lên cùng chứng kiến những giây phút cảm động của câu chuyện tình thân, nỗi khát khao hạnh phúc êm đềm, cùng bỡ ngỡ bước vào tuổi lớn nhiều yêu thương mang cả màu va vấp.', 1),
		(N'Cây Cam Ngọt Của Tôi', N'José Mauro de Vasconcelos', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftieuthuyet2.jpg?alt=media&token=bc42b94c-be74-45f4-b6c0-fd4e9b9c5bf0&_gl=1*13kgcuv*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxNzc0NS4yOS4wLjA.', 108000, 30, N'“Vị chua chát của cái nghèo hòa trộn với vị ngọt ngào khi khám phá ra những điều khiến cuộc đời này đáng sống... một tác phẩm kinh điển của Brazil.” - Booklist', 1),
		(N'Nhà Giả Kim (Tái Bản 2020)', N'Paulo Coelho', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftieuthuyet3.jpg?alt=media&token=389a351f-8dc1-4c0d-9e87-7be28fe05e7a&_gl=1*vsc1cd*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxNzc3Mi4yLjAuMA..', 79000, 20, N'Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. ', 1),
		(N'Ghi Chép Pháp Y - Những Cái Chết Bí Ẩn', N'Lưu Hiểu Huy', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftieuthuyet4.jpg?alt=media&token=d0b912b5-21a1-41fd-be83-c9186598dc7d&_gl=1*a6vyde*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxNzc4MS42MC4wLjA.', 150000, 20, N'“Ghi chép pháp y - Những cái chết bí ẩn” là cuốn sách nằm trong hệ liệt với “Pháp y Tần Minh” - bộ tiểu thuyết nổi đình đám của xứ Trung đã được chuyển thể thành series phim. Cuốn sách tổng hợp những vụ án có thật, được viết bởi bác sĩ pháp y Lưu Hiểu Huy - người có 15 năm kinh nghiệm và từng mổ xẻ hơn 800 tử thi. ', 1),
		(N'Chưa Kịp Lớn Đã Trưởng Thành (Tái Bản 2023)', N'Tớ Là Mây', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftieuthuyet5.jpg?alt=media&token=17954aa0-ce7f-421f-8c00-5b6620cbbc1b&_gl=1*5gbvay*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxNzgwMS40MC4wLjA.', 79000, 20, N'Nếu bạn đang trải qua giai đoạn lạc lõng và cô đơn như vậy, hãy để “Chưa kịp lớn đã phải trưởng thành” làm một người bạn ở bên, xoa dịu tổn thương và gửi tặng bạn đôi điều khích lệ. Mỗi trang sách đều là một lá thư nhắn nhủ bạn về sự đặc biệt của bản thân, về những nỗ lực hoàn thiện không ngừng nghỉ trong thế giới của người trưởng thành.', 1)

insert into Cat
values	(26, 1),
		(27, 1),
		(27, 2),
		(26, 2),
		(26, 3),
		(26, 4),
		(26, 5)

insert into Books 
values	(N'Trôi - Nguyễn Ngọc Tư', N'Nguyễn Ngọc Tư', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftruyenngan1.jpg?alt=media&token=f2876e4a-fb75-4c90-814a-55e3eaee9b36&_gl=1*109ifnr*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxODU3NS41MC4wLjA.', 95000, 20, N'“Em thà trôi một mình. Nhưng những gì còn sót lại của một cù lao phân rã chẳng là bao. Vài ba mái nhà lấp ló trên mặt nước, một vài cái lu, những rẻo đất đủ rộng cho một người ngồi thì cũng có, lại trôi đờ đẫn đằng xa. Mãi mới có mảnh đất trôi gần, đúng lúc nó rùng mình nứt làm hai.', 1),
		(N'Cảm Ơn Vì Đã Vượt Qua', N'Minh Phúc', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftruyenngan2.jpg?alt=media&token=2fb3922e-e97a-4966-96bf-9240db62da28&_gl=1*vtpjvi*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxODYzMi42MC4wLjA.', 75000, 20, N'Tản văn của Minh Phúc nâng niu ký ức, cảm xúc và đầy niềm tin vào tương lai với lòng biết ơn, trân trọng từng khoảnh khắc sống. Như nhà báoTrương Gia Hòa đã từng nhận xét: "Không có một cốt truyện để gây tò mò, tản văn của Minh Phúc bám vào một ký ức, một lát cắt cảm xúc hoặc một tình huống nào đó rồi mọc ra những chiếc lá chữ. Người phụ nữ thích trồng cây từ thời tấm bé này cứ khiến tôi nghĩ chữ của cô là lá. Chữ nào cũng đẹp, tươi xanh, chữ trước hắt ánh sáng cho chữ sau. Lôi kéo, quyến dụ mình phải đọc cho hết bài, cho hết sách. Để rồi, một vùng ký ức hiện ra, một cơn mơ xưa cũ tái hiện chập chờn."', 1),
		(N'Ngày Một Người Rời Xa Một Người', N'Heidi Priebe', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftruyenngan3.jpg?alt=media&token=e7695579-7b21-45ed-a0a4-50d664262a33&_gl=1*g9m6hh*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxODY4OC40LjAuMA..', 86000, 20, N'“Chúng ta phải cố ý rời khỏi những người mình từng yêu và đánh mất, nếu không ta sẽ mãi lạc lối cùng họ. Rằng việc rời đi một mình có lẽ không phải phương án tốt nhất, nhưng là lựa chọn duy nhất ta có. Và chúng ta không có quyền trao đổi lấy lựa chọn khác.”', 1),
		(N'Gió Còn Thổi Mãi - Bản Đặc Biệt - Tặng Kèm Bookmark + Truyện Ngắn: Chân Thành Vĩnh Cửu', N'Thủy Vũ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Ftruyenngan4.jpg?alt=media&token=bf97c440-093a-422f-87e7-faaafc4477ba&_gl=1*4j4x33*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxODc0OC42MC4wLjA.', 92000, 20, N'Trong những năm tháng tuổi niên thiếu, chúng ta không biết cách yêu nhưng lại đầy nhiệt huyết. Tới khi trưởng thành, chúng ta đã hiểu rõ thế nào là tình yêu nhưng đã đánh mất đi sự nồng nhiệt thuở ban đầu…', 1)

insert into Cat
values	(27, 6),
		(27, 7),
		(27, 8),
		(27, 9),
		(26, 9)

insert into Books
values	(N'Thiên Sứ Nhà Bên - Tập 7 - Bản Giới Hạn - Tặng Kèm Bookmark + Bìa Áo Đặc Biệt + Standee Pop-Up', N'Saekisan, Hanekoto', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Flight1.jpg?alt=media&token=5172bb83-7018-44cc-96df-a065b3db4d37&_gl=1*owwy6o*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxOTMzNC4yOC4wLjA.', 100000, 20, N'Kết thúc kì nghỉ hè, khắp trường bắt đầu nhộn nhịp chuẩn bị cho lễ hội văn hóa. Các bạn cùng lớp dường như đã quen với sự thân mật của cặp đôi Amane và Mahiru, mỗi ngày họ đều dõi theo cả hai bằng ánh mắt thích thú.', 1),
		(N'Phá Đảo Dị Giới Cùng Nữ Thần Không Tín Đồ - Tập 1: Pháp Sư Yếu Nhất Lớp - Tặng Kèm Bookmark', N'Osaki Isle, Tam-U', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Flight2.jpg?alt=media&token=a8292205-3416-4c78-9cf8-e09ddd058e2b&_gl=1*miq9jm*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxOTM4OS42MC4wLjA.', 100000, 20, N'Makoto Takatsuki là một học sinh trung học bình thường và một game thủ thuộc hàng lão luyện ở thể loại game nhập vai (RPG). Tuy nhiên, "sự bình thường" đó bỗng nhiên biến mất khi cả lớp của cậu gặp tai nạn trên đường trở về từ một chuyến dã ngoại và đã bị dịch chuyển đến thế giới khác!', 1),
		(N'Phá Đảo Dị Giới Cùng Nữ Thần Không Tín Đồ - Tập 1: Pháp Sư Yếu Nhất Lớp - Tặng Kèm Bookmark + Postcard + Poster A3', N'Osaki Isle, Tam-U', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Flight3.jpg?alt=media&token=ab47ea8e-2883-4e9f-a60f-63d5208bfc2f&_gl=1*414u2q*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxOTQ1Ny42MC4wLjA.', 130000, 20, N'Makoto Takatsuki là một học sinh trung học bình thường và một game thủ thuộc hàng lão luyện ở thể loại game nhập vai (RPG). Tuy nhiên, "sự bình thường" đó bỗng nhiên biến mất khi cả lớp của cậu gặp tai nạn trên đường trở về từ một chuyến dã ngoại và đã bị dịch chuyển đến thế giới khác!', 1),
		(N'Arya Bàn Bên Thỉnh Thoảng Lại Trêu Ghẹo Tôi Bằng Tiếng Nga - Tập 4 - Bản Boxset - Tặng Kèm Boxset + Lót ly + Clear Card Có Chân Đế', N'Sunsunsun, Momoco', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Flight4.jpg?alt=media&token=fe0c04f4-c387-4a50-956e-4e6f04c5644e&_gl=1*frsrz6*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxOTUyNS42MC4wLjA.', 130000, 20, N'Sau lễ bế giảng, Masachika và Arya bắt đầu gọi nhau bằng tên. Trong lúc cả hai vẫn đang lúng túng và xấu hổ khi đối diện với nhau, chuyến tập huấn của Hội học sinh mà cả nhóm hằng mong đợi đã bắt đầu! Giờ đây, các thành viên Hội học sinh đang hết mình tận hưởng thanh xuân rực rỡ dưới pháo hoa của đêm hội mùa hè, bãi biển tư nhân và căn biệt thự sang trọng. Trước khung cảnh lãng mạn ở khu nghỉ dưỡng cùng cảm giác hưng phấn khác hẳn ngày thường, Arya nở nụ cười khiêu khích.', 1)

insert into Cat
values	(28, 10),
		(29, 10),
		(28, 11),
		(28, 12),
		(28, 13)

insert into Books
values	(N'Khó Dỗ Dành - Tập 1 - Tặng Kèm Bookmark Bồi Cứng', N'Trúc Dĩ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Fngontinh1.jpg?alt=media&token=f17a0cf2-11f0-4e33-acf8-203d318a2280&_gl=1*1qi1dx9*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQxOTg3MC4xLjAuMA..', 2050000, 20, N'Ôn Dĩ Phàm và Tang Diên từng là bạn học, hai người tình cờ gặp lại nhau trong một quán bar, sau đó lại tình cờ trở thành bạn thuê trọ chung. Chuyện cũng chẳng có gì nếu như hồi còn đi học Ôn Dĩ Phàm chưa từng... từ chối tình cảm của Tang Diên.', 1),
		(N'Khó Dỗ Dành - Tập 2 - Tặng Kèm Bookmark Bồi Cứng', N'Trúc Dĩ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Fngontinh2.jpg?alt=media&token=42761db9-eccd-4b9f-8de4-6c6423f94d30&_gl=1*1jn5e9k*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDAxMC42MC4wLjA.', 2050000, 20, N'Ôn Dĩ Phàm và Tang Diên từng là bạn học, hai người tình cờ gặp lại nhau trong một quán bar, sau đó lại tình cờ trở thành bạn thuê trọ chung. Chuyện cũng chẳng có gì nếu như hồi còn đi học Ôn Dĩ Phàm chưa từng... từ chối tình cảm của Tang Diên.', 1),
		(N'Combo Sách Khó Dỗ Dành - Tập 1 + Tập 2 (Bộ 2 Tập)', N'Trúc Dĩ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fvanhoc%2Fngontinh3.jpg?alt=media&token=55471511-f3fa-4be0-9ed2-91d84f2d2852&_gl=1*adzpdl*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDA4MS42MC4wLjA.', 410000, 20, N'Ôn Dĩ Phàm và Tang Diên từng là bạn học, hai người tình cờ gặp lại nhau trong một quán bar, sau đó lại tình cờ trở thành bạn thuê trọ chung. Chuyện cũng chẳng có gì nếu như hồi còn đi học Ôn Dĩ Phàm chưa từng... từ chối tình cảm của Tang Diên.', 1)
		

insert into Cat
values	(29, 14),
		(29, 15),
		(29, 16)
		

insert into Books
values	(N'Nghệ Thuật Tư Duy Chiến Lược', N'Avinash K Dixit, Barry J Nalebuff', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhdoanh1.jpg?alt=media&token=9321077c-1d94-4bf7-a23c-adb56b0c3f03&_gl=1*14m6i5p*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDMzNy40MC4wLjA.', 240000, 20, N'Có phải những người chiến thắng các chương trình truyền hình thực tế được trời phú cho trí thông minh và kỹ năng hơn người? Có phải các nhà đầu tư vĩ đại có thể nhìn thấy những điều mà hầu hết mọi người bỏ lỡ?', 1),
		(N'Tính Trước 5 Bước', N'Greg Dinkin, Patrick Bet-David', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhdoanh2.jpg?alt=media&token=e5b88426-2de6-4869-b41d-6e9c7162fa13&_gl=1*htj2fz*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDU1NS4zNy4wLjA.', 220000, 20, N'Mặc dù việc kinh doanh cũng yêu cầu chúng ta suy tính trước nhiều nước đi giống như khi chơi cờ ván, cuốn sách này sẽ không đi sâu phân tích môn cờ vua mà chỉ bàn về việc áp dụng tầm nhìn và tầm nhìn. cách tư duy của một tướng cờ vua vào kinh doanh.', 1),
		(N'Nghĩ Giàu & Làm Giàu (Tái Bản 2020)', N'Napoleon Hill', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhdoanh3.jpg?alt=media&token=53ffdd0a-a577-4344-b77a-faf46c55ad9a&_gl=1*1locg7s*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDYwNi42MC4wLjA.', 110000, 20, N'Think and Grow Rich - Nghĩ giàu và làm giàu là một trong những cuốn sách bán chạy nhất mọi thời đại. Đã hơn 60 triệu bản được phát hành với gần trăm ngôn ngữ trên toàn thế giới và được công nhận là cuốn sách tạo ra nhiều triệu phú, một cuốn sách truyền cảm hứng thành công nhiều hơn bất cứ cuốn sách kinh doanh nào trong lịch sử.', 1),
		(N'Từ Tốt Đến Vĩ Đại - Jim Collins (Tái Bản 2021)', N'Jim Collins', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhdoanh4.jpg?alt=media&token=687ca52d-28f9-4a52-b7cf-f9cd60e8b6fe&_gl=1*1xktftc*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDY4OS42MC4wLjA.', 130000, 20, N'Jim Collins cùng nhóm nghiên cứu đã miệt mài nghiên cứu những công ty có bước nhảy vọt và bền vững để rút ra những kết luận sát sườn, những yếu tố cần kíp để đưa công ty từ tốt đến vĩ đại. Đó là những yếu tố khả năng lãnh đạo, con người, văn hóa, kỷ luật, công nghệ… Những yếu tố này được nhóm nghiên cứu xem xét tỉ mỉ và kiểm chứng cụ thể qua 11 công ty nhảy vọt lên vĩ đại. Mỗi kết luận của nhóm nghiên cứu đều hữu ích, vượt thời gian, ý nghĩa vô cùng to lớn đối với mọi lãnh đạo và quản lý ở mọi loại hình công ty (từ công ty có nền tảng và xuất phát tốt đến những công ty mới khởi nghiệp), và mọi lĩnh vực ngành nghề. Đây là cuốn sách nên đọc đối với bất kỳ lãnh đạo hay quản lý nào!', 1)

insert into Cat
values	(30, 17),
		(30, 18),
		(30, 19),
		(30, 20)

insert into Books
values	(N'Bí Mật Tư Duy Triệu Phú (Tái Bản 2021)', N'T Harv Eker', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fquantri1.jpg?alt=media&token=72a3f966-40f8-4c38-bbdd-222f43c2f433&_gl=1*1ykad7x*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDg1My4yNy4wLjA.', 100000, 20, N'Trong cuốn sách này T. Harv Eker sẽ tiết lộ những bí mật tại sao một số người lại đạt được những thành công vượt bậc, được số phận ban cho cuộc sống sung túc, giàu có, trong khi một số người khác phải chật vật, vất vả mới có một cuộc sống qua ngày. Bạn sẽ hiểu được nguồn gốc sự thật và những yếu tố quyết định thành công, thất bại để rồi áp dụng, thay đổi cách suy nghĩ, lên kế hoạch rồi tìm ra cách làm việc, đầu tư, sử dụng nguồn tài chính của bạn theo hướng hiệu quả nhất', 1),
		(N'Cơn Lốc Quản Trị - Ba Trụ Cột Của Văn Hóa Doanh Nghiệp', N'Phan Văn Trường', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fquantri2.jpg?alt=media&token=132caea1-192d-4e8f-a961-41e12419c1c3&_gl=1*1gb71bv*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDkzOS42MC4wLjA.', 120000, 20, N'Doanh nghiệp nào cũng có lúc gặp phải những vấn đề không nhất thiết mang tính kỹ thuật, như sự thiếu vắng động lực, hoặc tinh thần tương tác và làm việc nhóm thấp, thậm chí là mâu thuẫn giữa các thành viên, trong đó có cả các lãnh đạo cấp trung và cấp cao. Chẳng công cụ quản lý nào cho phép giải quyết được những vấn đề bắt nguồn từ sự ganh tị, đố kị, thiên vị, hoặc tệ hơn nữa là nạn bè đảng hay tham nhũng nội bộ.', 1),
		(N'Nhà Lãnh Đạo Tương Lai (Tái Bản 2023)', N'Jacob Morgan', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fquantri3.jpg?alt=media&token=de71a95e-e856-445d-a33d-e179a4e42a8c&_gl=1*7kymwh*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMDk3My4yNi4wLjA.', 130000, 20, N'Trong tiểu thuyết The Sun Also Rises (Mặt trời vẫn mọc) của Ernest Hemingway, có đoạn thoại thế này: “‘Thế làm sao mà anh phá sản?’, Bill hỏi. ‘Bằng hai cách thôi. Nó đến từ từ; và rồi đùng một cái, tôi trắng tay!’, Mike đáp.”', 1),
		(N'Combo Sách Sức Mạnh Tiềm Thức + Bí Mật Tư Duy Triệu Phú + Người Giàu Có Nhất Thành Babylon (Bộ 3 Cuốn)', N'Joseph Murphyc, George S Cla', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fquantri4.jpg?alt=media&token=a27ab612-d5e7-4ab3-87d2-6258226667e2&_gl=1*16n8lec*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTA1MS42MC4wLjA.', 330000, 20, N'Là một trong những quyển sách về nghệ thuật sống nhận được nhiều lời ngợi khen và bán chạy nhất mọi thời đại, Sức Mạnh Tiềm Thức đã giúp hàng triệu độc giả trên thế giới đạt được những mục tiêu quan trọng trong đời chỉ bằng một cách đơn giản là thay đổi tư duy.',1)

insert into Cat
values	(31, 21),
		(31, 22),
		(31, 23),
		(31, 24)

insert into Books
values	(N'Trải Nghiệm Khách Hàng Xuất Sắc', N'Nguyễn Dương', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fqc1.jpg?alt=media&token=23982a39-db34-4a53-89d8-3da0e0ab0692&_gl=1*1yitux1*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTE2OS4yMS4wLjA.', 250000, 20, N'Bạn đang cầm trên tay cuốn sách Trải nghiệm khách hàng xuất sắc được viết từ hơn 22 năm kinh nghiệm, qua nhiều vị trí, môi trường khác nhau của ông Nguyễn Dương, một chuyên gia cấp quốc tế, một trong những người nhiệt huyết và chuyên sâu nhất về trải nghiệm khách hàng.', 1),
		(N'Cưa Đổ CRM - Nhắm Trúng Đích, Tương Tác Ngay, Bán Hàng Hay, Chăm Sóc Giỏi', N'Nam Nguyễn', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fqc2.jpg?alt=media&token=ad5ce4b5-c182-4ed6-8107-a15e8a9a9056&_gl=1*5bewwi*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTIzMC42MC4wLjA.', 200000, 20, N'10 năm ăn ngủ thức và làm việc cùng CRM của tác giả Nam Nguyễn đã được đúc kết trong một cuốn sách với 4 chủ đề chính', 1)
	
insert into Cat
values	(32, 25),
		(32, 26),
		(32, 26)
		

insert into Books
values	(N'Chiến Tranh Tiền Tệ - Phần 1 - Ai Thực Sự Là Người Giàu Nhất Thế Giới? (Tái bản 2022)', N'Song Hong Bing', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhte1.jpg?alt=media&token=2ef2a4ac-9872-4c74-8dc5-85d96d525306&_gl=1*1094o9q*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTU3Mi42MC4wLjA.', 160000, 20, N'Một khi đọc “Chiến tranh tiền tệ - Ai thật sự là người giàu nhất thế giới” bạn sẽ phải giật mình nhận ra một điều kinh khủng rằng, đằng sau những tờ giấy bạc chúng ta chi tiêu hàng ngày', 1),
		(N'Chiến Tranh Tiền Tệ - Phần V (Phần Cuối)', N'Song Hong Bing', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhte2.jpg?alt=media&token=ac68b7d8-185a-4c6b-8db8-3633e7f2d37a&_gl=1*1odixv2*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTU3OC41NC4wLjA.', 10000, 20, N'Chiến tranh tiền tệ tập 5 – “Tương lai của tiền tệ thế giới – Bình yêu trước giông bão” là phần cuối cùng trong series đình đám “Chiến tranh tiền tệ” được rất nhiều độc giả yêu thích và đánh giá cao.
Năm năm sau khi cuộc khủng hoảng tài chính năm 2008 kết thúc, các ý kiến về định hướng tương lai của nền kinh tế thế giới vẫn bị chia rẽ rất nhiều. Chính sách QE – nơi lỏng định lượng ở Mỹ có hiệu quả không? Tiền tệ toàn cầu phát hành quá mức rốt cuộc là phúc hay họa? Thị trường tài chính đang dần trở nên an toàn hay ngày càng nguy hiểm? Đà phục hồi kinh tế đang diễn ra ổn định hay chỉ là ánh chớp lóe lên rồi vụt tắt?', 1),
		(N'Làm Chủ Business Analytics - Phân Tích Dữ Liệu Để Đi Đến Quyết Định Thông Minh', N'Trần Hùng Thiện, Tăng Thúy Nga', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fkinhte%2Fkinhte3.jpg?alt=media&token=01d99d78-1436-4d4f-90d3-59ddabb446d6&_gl=1*1lnk1r2*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMTcwNi42MC4wLjA.', 270000, 20, N'Trần Hùng Thiện - Với 20 năm kinh nghiệm trong lĩnh vực nghiên cứu thị trường, tư vấn và phân tích dữ liệu, tác giả là 1 trong những người hiếm hoi tại Việt Nam có cơ hội được phân tích các loại dữ liệu khác nhau.', 1)
	

insert into Cat
values	(33, 27),
		(33, 28),
		(33, 29)

insert into Books
values	(N'Thay Đổi Cuộc Sống Với Nhân Số Học', N'Lê Đỗ Quỳnh Hương', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fkynangsong1.jpg?alt=media&token=59991675-83be-4709-acf5-abfababac66c&_gl=1*2ocu6n*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjE2Ni42MC4wLjA.', 130000, 12, N'', 1),
		(N'Hiểu Về Trái Tim (Tái Bản 2023)', N'Minh Niệm', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fkynangsong2.jpg?alt=media&token=f65ac136-cba8-48cc-8a79-f5fe48bc00f2&_gl=1*xq3pad*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjIzMy42MC4wLjA.', 160000, 12, N'“Hiểu về trái tim” là một cuốn sách đặc biệt được viết bởi thiền sư Minh Niệm. Với phong thái và lối hành văn gần gũi với những sinh hoạt của người Việt, thầy Minh Niệm đã thật sự thổi hồn Việt vào cuốn sách nhỏ này.
Xuất bản lần đầu tiên vào năm 2011, Hiểu Về Trái Tim trình làng cũng lúc với kỷ lục: cuốn sách có số lượng in lần đầu lớn nhất: 100.000 bản. Trung tâm sách kỷ lục Việt Nam công nhận kỳ tích ấy nhưng đến nay, con số phát hành của Hiểu về trái tim vẫn chưa có dấu hiệu chậm lại.', 1),
		(N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ (Tái Bản 2022)', N'Trác Nhã', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fkynangsong3.jpg?alt=media&token=c5eccb69-6f2a-4b65-b33c-64e06e3c4416&_gl=1*1ige3na*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjI2OS4yNC4wLjA.', 130000, 12, N'', 1)

insert into Cat
values	(34, 30),
		(34, 31),
		(34, 32)

insert into Books
values	(N'Đắc Nhân Tâm (Tái Bản 2021)', N'Dale Carnegie', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Frenluyen1.jpg?alt=media&token=544fd7fe-9afa-4bee-9de3-588f66aa75aa&_gl=1*1pd79x8*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjYwOC42MC4wLjA.', 90000, 12, N'Đắc nhân tâm của Dale Carnegie là quyển sách của mọi thời đại và một hiện tượng đáng kinh ngạc trong ngành xuất bản Hoa Kỳ. Trong suốt nhiều thập kỷ tiếp theo và cho đến tận bây giờ, tác phẩm này vẫn chiếm vị trí số một trong danh mục sách bán chạy nhất và trở thành một sự kiện có một không hai trong lịch sử ngành xuất bản thế giới và được đánh giá là một quyển sách có tầm ảnh hưởng nhất mọi thời đại.', 1),
		(N'Tự Tin - Nghệ Thuật Giúp Bạn Đạt Được Mọi Mong Muốn', N'Bob Yeung', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Frenluyen2.jpg?alt=media&token=e62b1b46-8297-491e-b7fb-9736ff8ae097&_gl=1*1a9sd5e*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjY0OC4yMC4wLjA.', 200000, 12, N'Tự Tin - Nghệ Thuật Giúp Bạn Đạt Được Mọi Mong Muốn', 1),
		(N'Gian Truân Chỉ Là Thử Thách', N'Hồ Văn Trung', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Frenluyen3.jpg?alt=media&token=4533920d-d984-41cf-8b22-62973ebda9a3&_gl=1*1memgvz*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjY5NS42MC4wLjA.', 100000, 12, N'Qua những trang viết của mình, Hồ Văn Trung đưa người đọc về những ngày gian khó và đầy nhọc nhằn nơi vùng quê La Khê mênh mông ruộng đồng, sông nước. Ở đó, anh cùng người mẹ và người chị gái lớn hơn anh 5 tuổi sống cùng nhau trong một túp lều dựng tạm, không có bất kỳ một tài sản nào, kể cả ruộng vườn và trâu bò. Điều quý giá nhất mà anh có, là tấm lòng bao la của người mẹ nghèo. Vì muốn các con có chữ nghĩa bằng bạn bằng bè, có cuộc sống tốt đẹp hơn, người mẹ đó đã không nề hà việc gì, từ dãi nắng dầm sương ngoài đồng ruộng đến làm thuê, ở đợ cho người ta.', 1)

insert into Cat
values	(35, 33),
		(35, 34),
		(35, 35),
		(35, 35)

insert into Books
values (N'Thuật Thao Túng - Góc Tối Ẩn Sau Mỗi Câu Nói', N'Wladislaw Jachtchenko', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Ftamly1.jpg?alt=media&token=37d6dba1-8bc6-4cee-9025-51962f624a3a&_gl=1*3z7m1p*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjg4Mi42MC4wLjA.', 140000, 12, N'Bạn có muốn giành phần thắng cuối cùng trong các cuộc tranh luận? Bạn có muốn dẹp đi bộ mặt kiêu ngạo của các đồng nghiệp xung quanh mình? Bạn có muốn chứng minh rằng bạn đã đúng về mọi thứ?', 1),
		(N'Tâm Lý Học Tội Phạm - Phác Họa Chân Dung Kẻ Phạm Tội', N'Diệp Hồng Vũ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Ftamly2.jpg?alt=media&token=58b7b238-6df5-41a5-a41c-fe553abc65d4&_gl=1*b83xf6*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjkzMi4xMC4wLjA.', 150000, 12, N'Tội phạm, nhất là những vụ án mạng, luôn là một chủ đề thu hút sự quan tâm của công chúng, khơi gợi sự hiếu kỳ của bất cứ ai. Một khi đã bắt đầu theo dõi vụ án, hẳn bạn không thể', 1),
		(N'Vẻ Đẹp Của Sự Cô Đơn - Tặng Kèm Bookmark', N'Giác Minh Luật', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Ftamly3.jpg?alt=media&token=35a102f7-a86c-416b-a34e-3b8c637db4db&_gl=1*oxhcwx*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMjk3MC42MC4wLjA.', 120000, 12, N'Mọi lời nói, việc làm đều được chi phối bởi định luật nhân quả, nó là một quy luật rất tự nhiên. Trong tình yêu cũng vậy, nếu chúng ta chỉ vì tham vọng bản thân mà nói, mà làm cho thỏa mãn những ảo mộng ở hiện tại, thì kết quả nhận lại chỉ là sự ca tụng, niềm hoan lạc và cả sự hạnh phúc tạm thời. Và rồi ngay cả khi bạn ngỡ rằng mình đang sống một đời bình yên với những thứ hiện có, sự cô đơn vẫn xâm chiếm và khiến trái tim bạn khổ đau.', 1)

insert into Cat
values	(36, 36),
		(36, 37),
		(38, 38)
		
insert into Books
values	(N'Học Cho Ai? Học Để Làm Gì? Tập 1 (Tái Bản 2019)', N'Tiêu Vệ, Lê Tâm', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fsachchomoinhu1.jpg?alt=media&token=ed0b8c89-cd28-4885-84cf-ddf8546a4cf4&_gl=1*2em5zh*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzEyMC4xNy4wLjA.', 40000, 12, N'Chúng ta không thể lựa chọn được xuất thân của mình, nhưng bằng sự cần cù chăm chỉ, cùng với nghị lực kiên định và tinh thần không khuất phục trước khó khăn, chúng ta có thể lựa chọn việc không ngừng học tập, dùng tri thức và năng lực để thay đổi cuộc đời. Cuộc sống phía trước đầy thử thách và cơ hội. Một người nếu có tài năng và sở trường mà xã hội cần đến thì dù anh ta ở bất kì hoàn cảnh nào trong xã hội, sớm muộn sẽ có một ngày được thi thố tài năng, giúp ích cho đời.', 1),
		(N'Cẩm Nang Bé Gái Tuổi Dậy Thì - Quyển 1: 160 Câu Hỏi-Đáp Về Sinh Lí Bạn Gái Tuổi Dậy Thì (Tái Bản 2019)', N'Nhiều Tác Giả', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fsachchomoinhu2.jpg?alt=media&token=c9189d4c-866d-4663-97fb-09a4ef8d9578&_gl=1*1hcsfhx*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzE5OS42MC4wLjA.', 50000, 12, N'Tất tần tật những thắc mắc về tâm sinh lí các bé gái tuổi dậy thì (9-18 tuổi) đều được giải đáp trong 2 cuốn sách này. Những câu hỏi của các bé gái, đang bỡ ngỡ trước ngưỡng tuổi dậy thì, được chuyên gia trả lời vừa khoa học mà dễ hiểu, dễ nhớ.', 1),
		(N'Học Cho Ai? Học Để Làm Gì? Tập 2 (Tái Bản 2019)', N'Tiêu Vệ, Lê Tâm', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Ftamli-kynangsong%2Fsachchomoinhu3.jpg?alt=media&token=714bdf18-deaa-4a19-bbe9-a24d0a6eb19a&_gl=1*i8dra5*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzI3MS42MC4wLjA.', 40000, 10, N'Chúng ta không thể lựa chọn được xuất thân của mình, nhưng bằng sự cần cù chăm chỉ, cùng với nghị lực kiên định và tinh thần không khuất phục trước khó khăn, chúng ta có thể lựa chọn việc không ngừng học tập, dùng tri thức và năng lực để thay đổi cuộc đời. Cuộc sống phía trước đầy thử thách và cơ hội. Một người nếu có tài năng và sở trường mà xã hội cần đến thì dù anh ta ở bất kì hoàn cảnh nào trong xã hội, sớm muộn sẽ có một ngày được thi thố tài năng, giúp ích cho đời.', 1)

insert into Cat
values	(37, 39),
		(37, 40),
		(37, 41)

insert into Books
values (N'90% Trẻ Thông Minh Nhờ Cách Trò Chuyện Đúng Đắn Của Cha Mẹ (Tái Bản 2019)', N'Urako Kanamori', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fnuoicon1.jpg?alt=media&token=332de242-7f4b-4e3d-ac14-da991cace5d0&_gl=1*29tgkh*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzU3My42LjAuMA..', 40000, 12, N'Bạn có bao giờ thốt ra những câu dù biết là không nên nói như  “Còn lề mề đến bao giờ nữa hả?” hay “Chẳng được cái trò trống gì, đưa đây xem nào!”… nhưng vẫn lỡ lời không?
Trong quá trình trẻ trưởng thành, những lời lẽ kiểu “Mày chẳng được cái tích sự gì!” trẻ phải nghe ngày ngày sẽ thẩm thấu qua vô thức, rồi sau đó trở thành ý thức coi mình chỉ là loại “vô dụng”. Không biết từ lúc nào, trẻ sẽ bắt đầu thực hiện những hành vi, lối sống không tốt.', 1),
		(N'Happy Children - Hiểu Về Sự Phát Triển Của Trẻ Để Nuôi Dạy Con An Lạc Và Hạnh Phúc', N'GS Hà Vĩnh Thọ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fnuoicon2.jpg?alt=media&token=9fa29a57-5410-408b-9dd3-7a84fad76fd2&_gl=1*f411g1*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzYyNS42MC4wLjA.', 180000, 12, N'Sự chào đời là một sự kiện bí ẩn và đầy nghịch lý. Một mặt, sinh tử là trải nghiệm phổ quát nhất được chia sẻ bởi tất cả chúng sinh. Mặt khác, mỗi sự chào đời lại là một điều kỳ diệu, một sự kiện duy nhất thay đổi mãi mãi cuộc đời của rất nhiều người. Đó cũng là một sự kiện cuộc đời mà chúng ta chỉ biết qua lời kể của mọi người vì thường thì không ai có thể nhớ được gì về thời điểm quan trọng này, khi bản thân lần đầu tiên có mặt trên đời, trong hình hài của một con người.', 1),
		(N'Nuôi Dạy Bé Trai Từ 0 - 6 Tuổi (Tái Bản 2021)', N'Erika Takeuchi', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fnuoicon3.jpg?alt=media&token=78c243f3-1702-47de-a434-8499a9265e97&_gl=1*1ua0fas*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzY5OS42MC4wLjA.', 70000, 12, N'Tác giả của cuốn sách Nuôi dạy bé trai từ 0 – 6 tuổi là người đã có 20 năm nghiên cứu về sự trưởng thành của trẻ em, quan sát 12.000 trẻ ở nhiều độ tuổi khác nhau, từ em bé sơ sinh cho đến sinh viên đại học. Từ kinh nghiệm thực tiễn và nghiên cứu tác giả đã đúc kết được những điều quan trọng đối với sự phát triển của trẻ rằng:
Ngay từ khi sinh ra, giữa bé trai và bé gái đã có những đặc trưng khác nhau cả về não bộ cũng như hệ thần kinh vận động. Do vậy cách giáo dục cũng sẽ khác nhau. Nếu nắm được điểm mấu chốt trong cách nuôi dạy cho từng bé thì bố mẹ có thể phát triển năng lực của trẻ một cách toàn diện.',  1)

insert into Cat
values	(38, 42),
		(38, 43),
		(38, 44)

insert into Books
values	(N'Kinh Nghiệm Từ Nước Nhật - Giúp Con Tự Lập Từ 0-6 Tuổi', N'Masaaki Yatagai', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaycon1.jpg?alt=media&token=25112cc7-9a08-4e0e-9066-391c6c48e25e&_gl=1*3onqln*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzk0Ny42MC4wLjA.', 60000, 12, N'Điều quan trọng nhất trong nuôi  dạy  trẻ  trước  6  tuổi  là làm cho trẻ có thói quen sinh hoạt cơ bản. Cha mẹ thường có  xu  hướng  so  sánh  con mình với những đứa trẻ khác ở mặt này mặt kia. Tuy nhiên, việc đó sẽ chỉ làm cho cha mẹ và con cái thêm căng thẳng.', 1),
		(N'Nuôi Dạy Bé Gái Từ 0 Đến 6 Tuổi (Tái Bản 2020', N'Erika Takeuchi', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaycon2.jpg?alt=media&token=bae2193f-2d10-4f03-a64a-9f05a8798e4b&_gl=1*q8uhxq*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyMzk4OC4xOS4wLjA.', 70000, 12, N'Tác giả của cuốn sách Nuôi dạy bé gái từ 0 – 6 tuổi là người đã có 20 năm nghiên cứu về sự trưởng thành của trẻ em, quan sát 12.000 trẻ ở nhiều độ tuổi khác nhau, từ em bé sơ sinh cho đến sinh viên đại học. Từ kinh nghiệm thực tiễn và nghiên cứu tác giả đã đúc kết được những điều quan trọng đối với sự phát triển của trẻ rằng:', 1),
		(N'Phương Pháp Giáo Dục Con Của Người Do Thái - Giúp Trẻ Tự Tin Bước Vào Cuộc Sống', N'Hà Minh', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaycon3.jpg?alt=media&token=b25a8bca-67de-444a-80fd-c0fd9d74079e&_gl=1*1q07odd*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDA4MC42MC4wLjA.', 90000, 12, N'Xem trọng giáo dục của cha mẹ với con cái là truyền thống tốt đẹp nổi bật nhất của dân tộc Do Thái. Mặc dù phải trải qua rất nhiều khó khăn và luôn phải phiêu bạt khắp nơi nhưng người Do Thái vẫn không quên dành cho con nền giáo dục tốt nhất', 1)

insert into Cat
values	(39, 45),
		(39, 46),
		(39, 47)

insert into Books
values	(N'Mẹ Dạy Con Trai Không La Mắng (Tái Bản)', N'Lỗ Bằng Trình', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaytritue1.jpg?alt=media&token=69875c0e-08df-482a-9d31-de5dc790900f&_gl=1*ra9yeu*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDE0MC42MC4wLjA.', 120000, 12, N'Để dạy con trai không la mắng, các bậc phụ huynh phải hiểu được tâm tư của con trai, từ đó rèn cho con tính tự lập, tinh thần trách nhiệm, quản lý cảm xúc, chi tiêu hợp lý, kỹ năng giao tiếp, cách vượt qua tuổi dậy thì,... Nếu có thể áp dụng thành công cách dạy này, các bậc cha mẹ sẽ không cần la mắng mà trẻ vẫn ngoan ngoãn vâng lời, tâm sinh lý phát triển lành mạnh, chín chắn và có trách nhiệm hơn với bản thân, gia đình và xã hội.', 1),
		(N'Những Trò Chơi Giúp Trẻ 0-2 Tuổi Phát Triển Toàn Diện Thể Chất Và Tâm Hồn', N'Nana Hatano', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaytritue2.jpg?alt=media&token=a99afaea-e63d-4b1d-8657-5ad0d797ed31&_gl=1*ya8b7c*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDE4NC4xNi4wLjA.', 90000, 12, N'Con đang ở trong tâm trạng không tốt và quấy khóc từ sáng. Bạn đã bao giờ muốn bật khóc vì không biết phải làm thế nào cho con cười chưa? Cuốn sách này là một bài hát cổ vũ những người lần đầu làm cha mẹ. Không có những trò ảo thuật. Cũng không có những trò chơi hiếm đến mức không ai biết. Trong cuốn sách này có những trò chơi chứa đầy khám phá khiến bạn tự hỏi “Cái này, có thể trở thành trò chơi được hay sao?”. Cảm giác nặng nề “phải chơi với con” cũng trở nên nhẹ nhàng hơn. Tôi chủ đích viết một cuốn sách như thế. Những điều tôi gợi ý trong cuốn sách này là “thay đổi quan điểm của bạn”. Nếu bạn có thể tìm thấy “niềm vui” trong những việc hết sức bình thường hàng ngày, chăm sóc con hay đi dạo cùng con mà không phải bận lòng, thì đó chính là những trò chơi tuyệt vời nhất. Bạn không cần phải thúc ép bản thân hay làm điều gì thật đặc biệt.', 1),
		(N'Kích Thích Não Bộ Cho Trẻ Bằng Tính Nhẩm (Tái Bản Từ Sách: 15 Cách Giúp Trẻ Tư Duy Số Học)', N'Kisou Kubota, Kayoko Kubota', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaytritue3.jpg?alt=media&token=4650f1fc-f745-4f4d-930f-b935689c509d&_gl=1*18ij944*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDIwNy42MC4wLjA.', 90000, 12, N'Mọi người thường có xu hướng nghĩ rằng, việc trau dồi năng lực tính toán và bồi dưỡng tính nhạy cảm với những con số sẽ giúp rèn giũa khả năng tư duy logic, nhưng đâu chỉ có vậy.
Nhờ rèn luyện năng lực tính toán, mà phần vỏ não trước trán của não bộ hoạt động, khiến tính tương tác xã hội, xúc cảm và lòng quan tâm cùng lớn lên. Nói cách khác, tâm hồn người Nhật Bản cũng được nuôi dưỡng.
Những năm gần đây, kết quả của cuộc nghiên cứu đi đầu trong ngành Khoa học Não bộ đã được công bố.', 1)

insert into Cat
values	(40, 48),
		(40, 49),
		(40, 50)

insert into Books
values	(N'Chào Con! Ba Mẹ Đã Sẵn Sàng (Tái Bản 2020)', N'BS Trần Thị Huyên Thảo', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaykinang1.jpg?alt=media&token=d365c7d5-71bc-4c30-882a-b9c3b090fd35&_gl=1*1ru57mq*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDI5OS42MC4wLjA.', 100000, 12, N'"Chào con! Ba mẹ đã sẵn sàng!" - Cuốn sách không chỉ được viết trên nền tảng khoa học của một bác sĩ mà còn chứa chan tình yêu của một người mẹ.
Chắc chắn bạn cũng sẽ cảm nhận được những điểm hay và thực tế trong quyển sách này, từ nền tảng khoa học vững chắc cho đến kiến thức chăm sóc trẻ mới nhất, và nhất là phù hợp với hoàn cảnh của Việt Nam.', 1),
		(N'Bác Sĩ Riêng Của Bé Yêu - Bước Đệm Vững Chắc Vào Đời (Tái Bản 2020)', N'Trần Thị Huyên Thảo', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaykinang2.jpg?alt=media&token=4d204ade-347a-4dde-b033-cd5af2d3c54a&_gl=1*glmlgx*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDMzMS4yOC4wLjA.', 100000, 12, N'Bước đệm vững chắc vào đời là cuốn tiếp theo Chào con! Ba mẹ đã sẵn sàng trong bộ BÁC SĨ RIÊNG CỦA BÉ YÊU. Trong cuốn sách này Bác sĩ – thạc sĩ nhi khoa Trần thị Huyên Thảo gửi tới các bậc phụ huynh những lời khuyên thực tế và khoa học dành cho việc chăm sóc trẻ.', 1),
		(N'Phương Pháp Ăn Dặm Bé Chỉ Huy (Baby Led-Weaning) (Tái Bản 2021)', N'Gill Rapley, Tracey Murkett', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc%2Fnuoidaycon%2Fdaykinang3.jpg?alt=media&token=52fe02ff-7599-42d7-b61f-09121ef28f5c&_gl=1*y5rb0m*_ga*MTQzODgyNzU0OS4xNjg5NjY0MDY1*_ga_CW55HF8NVT*MTY5ODQxNjgyMy44LjEuMTY5ODQyNDM3My42MC4wLjA.', 100000, 12, N'Nếu bạn đã quen với hình ảnh các bé được mẹ dùng muỗng đút thức ăn nghiền nhuyễn vào miệng, bé nhè ra và mẹ lại vét vào cho đến khi nào bé nuốt thì thôi, thì BLW sẽ là một hình ảnh hoàn toàn khác. Với phương pháp này, sẽ không có chuyện đút muỗng hay nghiền nhuyễn, mà ba mẹ sẽ cung cấp cho bé những thức ăn có hình dạng và kích cỡ phù hợp để bé có thể cầm lấy và tự đút cho mình bằng các ngón tay, tự chọn thức ăn, tự quyết định ăn bao nhiêu và ăn với tốc độ như thế nào. Rất có thể nhiều mẹ sẽ lo lắng bé ăn như thế nhỡ bị hóc thì sao.', 1)

insert into Cat
values	(41, 51),
		(41, 52),
		(41, 53)

--trí
INSERT INTO Books
VALUES  (N'Moriaty The Patriot',N'Ryosuke Takeuchi, Hikaru Miyoshi','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fmanga1.jpg?alt=media&token=4585b2dc-785f-43ae-bb8c-9ca6a9c0dde6&_gl=1*1wll1u*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTUzNi42MC4wLjA.',42.750,5,null,1),
		(N'KINGDOM - Tập 59 - Tặng Kèm Thẻ Hình Nhân Vật',N'Yasuhisa Hara','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fmanga2.jpg?alt=media&token=f66d33cb-63a8-450f-95b4-5ad2d384829b&_gl=1*10mnpq8*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTYxNi42MC4wLjA.',42.750,5,null,1),
		(N'Black Clover - Tập 30: Phúc Âm - Tặng Kèm Postcard',N'Yūki Tabata','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fmanga3.jpg?alt=media&token=2275a78c-c34e-412b-8323-7231bc630800&_gl=1*m4vt8v*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTY1NS4yMS4wLjA.',23.750,5,null,1),
		(N'Hắc Quản Gia - Tập 1 - Tặng Kèm Black Card',N'Toboso Yana','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fmanga4.jpg?alt=media&token=805a09eb-e908-4a0c-869c-1e50a9531ff7&_gl=1*1yyn5ka*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTY3OS42MC4wLjA.',52.200,10,null,1),
		(N'Nhiệm Vụ Tối Thượng Nhà Yozakura - Tập 11: Kì Thi Thăng Hạng Điệp Viên - Tặng Kèm Bìa Áo',N'Hitsuji Gondaira','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fmanga5.jpg?alt=media&token=270348fd-ec0d-40a6-868c-33dc1d924fb3&_gl=1*1q3im37*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTY5MS40OC4wLjA.',28.500,5,null,1)

insert into Cat
values	(42, 54),
		(42, 55),
		(42, 56),
		(42, 57),
		(42, 58)

INSERT INTO Books
VALUES	(N'Geography Encyclopedia - Bách Khoa Toàn Thư Về Địa Lý',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fbachkhoa1.jpg?alt=media&token=e8e9909e-46d9-434d-88c0-2f19d6ed9705&_gl=1*zowf13*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTcxOS4yMC4wLjA.',173.400,40,null,1),
		(N'Science Encyclopedia - Bách Khoa Thư Về Khoa Học- Trái Đất Và Vũ Trụ',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fbachkhoa2.jpg?alt=media&token=84c53237-e388-4fcd-87f1-701d3c2f8429&_gl=1*1xhwyu4*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTczMS44LjAuMA..',47.600,30,null,1),
		(N'100 Kỹ Năng Sinh Tồn',N'Clint Emerson','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fbachkhoa3.jpg?alt=media&token=4eeea76a-1b08-41f6-a957-4258eba6ce61&_gl=1*unm2tn*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ2OTc1MS42MC4wLjA.',69.300,30,null,1),
		(N'Who? Chuyện Kể Về Danh Nhân Thế Giới: Louis Pasteur (Tái Bản 2020)',N'Lee, Heejung, Team kids','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fbachkhoa4.jpg?alt=media&token=e3d86c83-e4f8-446c-981f-cd47a6c5cd7f&_gl=1*1wbkkix*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDE2OC42MC4wLjA.',46.750,15,null,1),
		(N'Who? Chuyện Kể Về Danh Nhân Thế Giới: Charles Darwin (Tái Bản 2019)',N'ChungBe Studios, Ahn, Hyungmo','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fbachkhoa5.jpg?alt=media&token=e7ec9b6e-01a0-44bd-92cb-595f46422bb9&_gl=1*lss8sr*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDE4Ny40MS4wLjA.',46.750,15,null,1)

insert into Cat
values	(43, 59),
		(43, 60),
		(43, 61),
		(43, 62),
		(43, 63)

INSERT INTO Books
VALUES	(N'Những Câu Chuyện Truyền Cảm Hứng - I Will Be Better: Nguồn Năng Lượng Tích Cực',N'Yunan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fknsct1.jpg?alt=media&token=2d50d329-1963-4534-b5e4-0f2218fced94&_gl=1*llsf5e*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDIxNS4xMy4wLjA.',49.300,15,null,1),
		(N'Những Câu Chuyện Truyền Cảm Hứng - I Will Be Better: Con Cảm Ơn Mẹ',N'Yunan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fknsct2.jpg?alt=media&token=8856d79e-6421-484b-98e9-630d54d6125a&_gl=1*ilmxq2*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDI0NC42MC4wLjA.',49.300,15,null,1),
		(N'Những Câu Chuyện Truyền Cảm Hứng - I Will Be Better: Con Sẽ Không Dựa Dẫm',N'Yunan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fknsct3.jpg?alt=media&token=01750256-6e8f-4781-92bb-44c60124b8bd&_gl=1*wo7i4m*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDI2Mi40Mi4wLjA.',49.300,15,null,1),
		(N'Những Câu Chuyện Truyền Cảm Hứng - I Will Be Better: Dũng Cảm Thử Lại Lần Nữa',N'Yunan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fknsct4.jpg?alt=media&token=15efd2ab-2bdc-4d85-9e84-1a02208a9461&_gl=1*whkekl*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDI4My4yMS4wLjA.',46.300,15,null,1),
		(N'Những Câu Chuyện Truyền Cảm Hứng - I Will Be Better: Khoản Tiết Kiệm Của Mẹ',N'Yunan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fknsct5.jpg?alt=media&token=4aba0577-3da8-4de3-9c3e-b101fdfe6284&_gl=1*1iq0gzd*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDMwMy4xLjAuMA..',46.300,15,null,1)

insert into Cat
values	(44, 64),
		(44, 65),
		(44, 66),
		(44, 67),
		(44, 68)

INSERT INTO Books
VALUES	(N'Rèn Luyện Tư Duy, Nâng Cao IQ: Tìm Điểm Khác Nhau',N'Hồ Viện Viện','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fvhvc1.jpg?alt=media&token=72680aad-1d04-409a-8ac6-c126f581c17a&_gl=1*1vte3jd*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDMyNy40MC4wLjA.',38.250,15,null,1),
		(N'Rèn Luyện Tư Duy, Nâng Cao IQ: Khám Phá Quy Luật',N'Hồ Viện Viện','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fvhvc2.jpg?alt=media&token=52e042ba-6d3b-4f44-8e0c-b64150aeb570&_gl=1*1bp6ih7*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDQzOS42MC4wLjA.',38.250,15,null,1),
		(N'Big Book - Cuốn Sách Khổng Lồ Về Các Ngôi Sao Và Các Hành Tinh (Tái Bản)',N'Minna Lacey','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fvhvc3.png?alt=media&token=cfab04a5-c499-44de-9c89-0aef8ef793a8&_gl=1*1fzoggv*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDQ1OS40MC4wLjA.',117.600,30,null,1),
		(N'Big Book - Cuốn Sách Khổng Lồ Về Các Loài Động Vật Biển (Tái Bản)',N'Minna Lacey','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fvhvc4.png?alt=media&token=a21dad67-b013-454a-acb3-5bc8cce7ddb6&_gl=1*1mpt7fk*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDUwMC42MC4wLjA.',117.600,30,null,1),
		(N'Mê Cung Phát Triển Tư Duy - Khám Phá Thế Giới (2022)',N'Sam Smith','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fsachthieunhi%2Fvhvc5.jpg?alt=media&token=354908aa-8298-4d01-aebc-a2b93f6b6eff&_gl=1*n3rjqf*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDUxOS40MS4wLjA.',46.300,15,null,1)

insert into Cat
values	(45, 69),
		(45, 70),
		(45, 71),
		(45, 72),
		(45, 73)

INSERT INTO Books
VALUES	(N'Bác Hồ Với Thiếu Niên Nhi Đồng',N'Tuệ Minh','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fcuocdoi1.jpg?alt=media&token=e12fae00-ae53-4d2f-b7fa-09beb745e642&_gl=1*w830he*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDU2NC41Ni4wLjA.',48.600,10,null,1),
		(N'Kể Chuyện Cuộc Đời Các Thiên Tài: Albert Einstein - Tuổi Thơ Gian Khó Và Cuộc Đời Khoa Học Vĩ Đại',N'Rasmus Hoài Nam','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fcuocdoi2.jpg?alt=media&token=d820c049-b15b-41c7-b937-c72305676639&_gl=1*c4kmqi*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDU5Ny4yMy4wLjA.',46.750,15,null,1),
		(N'Kể Chuyện Cuộc Đời Các Thiên Tài: Isaac Newton - Nhà Khoa Học Vĩ Đại',N'Rasmus Hoài Nam','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fcuocdoi3.jpg?alt=media&token=9c4d5340-6641-4685-ba39-4210d0a7cec5&_gl=1*gi75ri*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDYxNC42LjAuMA..',34.000,15,null,1),
		(N'Cuộc Đời Kỳ Lạ Của Nikola Tesla (Tái Bản 2023)',N'Nikola Tesla','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fcuocdoi4.jpg?alt=media&token=b249433a-1b74-43ab-9159-4db4971856d3&_gl=1*gnls6m*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDczNC40NS4wLjA.',76.500,10,null,1),
		(N'Người Thầy (Tái Bản 2023)',N'Nguyễn Chí Vịnh','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fcuocdoi5.jpg?alt=media&token=44af3922-e485-46b4-8dae-1245dcd2838b&_gl=1*vdinkh*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDc1NS4yNC4wLjA.',240.300,10,null,1)

insert into Cat
values	(46, 74),
		(46, 75),
		(46, 76),
		(46, 77),
		(46, 78)

INSERT INTO Books
VALUES	(N'Putin - Logic Của Quyền Lực - Putin: Innenansichten Der Macht',N'Hubert Seipel','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fchinhtri1.jpg?alt=media&token=8c3eecb6-b5e3-4d70-a8d7-83b6a0d12dcc&_gl=1*1wvqhw1*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDc5OS42MC4wLjA.',142.800,15,null,1),
		(N'Chính Trị Đảng Phái Tại Hoa Kỳ - Parties Politics In America',N'Marjorie Randon Hershey','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fchinhtri2.jpg?alt=media&token=a6cde0fc-50ce-464c-9a5d-268014f3c00f&_gl=1*1iwaest*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDgxNy40Mi4wLjA.',269.000,15,null,1),
		(N'Cái Chết Của Nền Dân Chủ: Những Bước Tiến Quyền Lực Của Hitler',N'Benjamin Carter Hett','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fchinhtri3.jpg?alt=media&token=d0bf6822-f2ff-46e0-b481-ddbaa9aab173&_gl=1*18divx9*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDgzNC4yNS4wLjA.',278.000,15,null,1),
		(N'Donald Trump - Không Bao Giờ Là Đủ',N'Michael Antonio','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fchinhtri4.jpg?alt=media&token=801cac66-9efc-4214-b3cd-b3372e8c82a7&_gl=1*146iup4*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDg1NC41LjAuMA..',178.000,15,null,1),
		(N'Gia Tộc Morgan',N'Ron Chernow','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fchinhtri5.jpg?alt=media&token=53ebdc01-859e-4b1e-a938-6adcd879dbf0&_gl=1*suro0p*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDg3MC42MC4wLjA.',499.000,15,null,1)

insert into Cat
values	(47, 79),
		(47, 80),
		(47, 81),
		(47, 82),
		(47, 83)

INSERT INTO Books
VALUES	 (N'Kinh Tế Nhật Bản: Giai Đoạn Phát Triển Thần Kỳ 1955-1973',N'Trần Văn Thọ','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fkinhte1.jpg?alt=media&token=582cf86c-6899-4526-b810-82f5de16c50c&_gl=1*r2i13c*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDg4OS40MS4wLjA.',228.000,15,null,1),
		(N'Bill Gates: Tham Vọng Lớn Lao Và Quá Trình Hình Thành Đế Chế Microsoft (Tái Bản 2017)',N'James Wallace, Jim Erickson','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fkinhte2.jpg?alt=media&token=3c4e982b-7925-48bd-9a0f-7d68eb2cc83c&_gl=1*13m1cnb*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDkwNC4yNi4wLjA.',229.000,15,null,1),
		(N'Con Rồng Trong Bể Kính - Câu Chuyện Thật Về Quyền Lực, Nỗi Ám Ảnh Và Loài Cá Đáng Thèm Muốn Nhất',N'Emily Voigt','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fkinhte3.jpg?alt=media&token=6724e819-98b5-428a-88cf-f9336d59b8f6&_gl=1*tgluy6*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDkyOS4xLjAuMA..',130.000,15,null,1),
		(N'Elon Musk - Đặt Cả Thế Giới Lên Bốn Bánh Xe Điện',N'Hamish McKenzie','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fkinhte4.jpg?alt=media&token=c9b86458-d269-4706-a945-f9b59f0333d9&_gl=1*1dxxdj8*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDk1My4zOS4wLjA.',199.000,15,null,1),
		(N'Sói Già Phố Wall - Phần 3',N'Jordan Belfort','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fkinhte5.jpg?alt=media&token=49e21d2a-6d23-414b-8a36-5756b4f81d17&_gl=1*1yafxmx*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDk3My4xOS4wLjA.',165.000,10,null,1)

insert into Cat
values	(48, 84),
		(48, 85),
		(48, 86),
		(48, 87),
		(48, 88)

INSERT INTO Books
VALUES	 (N'Michelangelo - Sáu Kiệt Tác Cuộc Đời',N'Miles J Unger','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fgiaitri1.jpg?alt=media&token=184d80b8-33ad-4ab6-9240-8724959e2756&_gl=1*1e9y1yx*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MDk5NS42MC4wLjA.',299.000,15,null,1),
		(N'Dòng Đời',N'Elvis Phương','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fgiaitri2.jpg?alt=media&token=223499e3-4f75-4085-b394-e77c9cfeb2fa&_gl=1*46fy01*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTAxOS4zNi4wLjA.',279.000,10,null,1),
		(N'Châu Nhuận Phát - Đại Hiệp Hồng Kông',N'Lin Feng','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fgiaitri3.jpg?alt=media&token=557bd00f-a3ad-40ca-a0a7-15b0c256a849&_gl=1*710z8c*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTAzNy4xOC4wLjA.',168.000,15,null,1),
		(N'Bí Mật Phía Sau Đế Chế Marvel Studios',N'Charlie Wetzel, Staphanie Wetzel','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fgiaitri4.jpg?alt=media&token=e0fc7a42-c61d-4258-9b05-cfe8aa41570b&_gl=1*1reer97*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTA1Ni42MC4wLjA.',88.000,15,null,1),
		(N'Mozart',N'Maynard Solomon','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Ftieusu-hoiky%2Fgiaitri5.jpg?alt=media&token=c8bf38d6-4efb-425b-9bb4-c504b19a7b2a&_gl=1*b75n28*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTQ3NC40MS4wLjA.',459.000,15,null,1)

insert into Cat
values	(49, 89),
		(49, 90),
		(49, 91),
		(49, 92),
		(49, 93)

INSERT INTO Books
VALUES	(N'Tập Bản Đồ Địa Lí 11 (Theo Chương Trình Giáo Dục Phổ Thông 2018) (2023)',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fsgk1.jpg?alt=media&token=601783d5-afd5-47b2-8623-6badc94a953f&_gl=1*x9554h*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTU0Ny40OC4wLjA.',39.000,0,null,1),
		(N'Sinh Học 11 (Chân Trời Sáng Tạo) (2023)',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fsgk2.jpg?alt=media&token=f486fab1-8349-47e5-b8be-9cb13bfc8b8a&_gl=1*xwhbyl*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTU2NS4zMC4wLjA.',27.000,0,null,1),
		(N'Tiếng Anh 7 I-Learn Smart World - Workbook',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fsgk3.jpg?alt=media&token=a3e92825-b0de-4c6d-9a2a-9f1406201097&_gl=1*1wps2vk*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTU3OS4xNi4wLjA.',70.000,0,null,1),
		(N'Sách Giáo Khoa Bộ Lớp 12 - Sách Bài Học (Bộ 14 Cuốn) (2023)',N'Bộ Giáo Dục Và Đào Tạo','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fsgk4.jpg?alt=media&token=d81f4656-0860-4d3d-b268-de239c5a683d&_gl=1*63fh8g*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTYwMC42MC4wLjA.',180.000,0,null,1),
		(N'Toán 1 (Chân Trời Sáng Tạo) (2023)',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fsgk5.jpg?alt=media&token=d0ac8fa2-fc09-4fa8-8757-0b46ef3a22cc&_gl=1*1hsvd4m*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTYyMC40MC4wLjA.',28.000,0,null,1)

insert into Cat
values	(50, 94),
		(50, 95),
		(50, 96),
		(50, 97),
		(50, 98)

INSERT INTO Books
VALUES	(N'Atlat Địa lí Việt Nam (Theo Chương Trình Giáo Dục Phổ Thông 2018) (2023)',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fstk1.jpg?alt=media&token=5ff341cb-6746-4286-af16-9a904287e7bb&_gl=1*by4zlq*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTYzOS4yMS4wLjA.',31.000,10,null,1),
		(N'Bảng Tuần Hoàn Các Nguyên Tố Hóa Học (Dành Cho Học Sinh THCS - Theo Dương Trình Giáo Dục Mới)',N'Phạm Đức Bình','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fstk2.jpg?alt=media&token=a2ced452-9384-484a-9945-ff2a85a5627b&_gl=1*1g5v6u*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTY1OC4yLjAuMA..',10.000,10,null,1),
		(N'500 Bài Tập Vật Lí Trung Học Cơ Sở',N'ThS Phan Hoàng Văn','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fstk3.jpg?alt=media&token=11cba5db-5ac7-4c21-b625-05414e4fa1d0&_gl=1*8d3syz*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTY3NS40Ni4wLjA.',145.000,15,null,1),
		(N'Những Bài Làm Văn Mẫu Lớp 4 - Tập 1 (Bộ Sách Kết Nối Tri Thức)',N'ThS Lê Xuân Soan, Trần Thìn','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fstk4.jpg?alt=media&token=226d4ed2-daea-4e46-8127-c2ee58073c40&_gl=1*sr473i*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTY5MS4zMC4wLjA.',55.000,10,null,1),
		(N'Luyện Viết Chữ Đẹp Lớp 4',N'Đăng Khoa, Đình Chương','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fstk5.jpg?alt=media&token=f6384506-ded0-4cd2-b560-5ebeae86b319&_gl=1*tkg0dm*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTcwOS4xMi4wLjA.',25.000,15,null,1)

insert into Cat
values	(51, 99),
		(51, 100),
		(51, 101),
		(51, 102),
		(51, 103)

INSERT INTO Books
VALUES	(N'Tổng Ôn Ngữ Pháp Tiếng Anh (Tái Bản 2023)',N'Trang Anh','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Ftailieu1.jpg?alt=media&token=637bbbc9-8809-47d7-b5a2-3d4a5d450a4b&_gl=1*uqqaxk*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTgxNC42MC4wLjA.',200.000,5,null,1),
		(N'50 Đề Minh Họa 2023 Môn Toán Học',N'Lê Văn Tuấn, Nguyễn Thế Duy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Ftailieu2.jpg?alt=media&token=f07a69d0-1617-4a64-8a85-311a703b5c2c&_gl=1*p2ctgr*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTg4Mi42MC4wLjA.',200.000,15,null,1),
		(N'Bí Quyết Chinh Phục Điểm Cao Kì Thi THPT Quốc Gia Môn Sinh Học',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Ftailieu3.jpg?alt=media&token=c57eed19-d07f-467f-b4bf-8e137a6914f0&_gl=1*1xx53ut*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MTkxMS4zMS4wLjA.',168.000,15,null,1),
		(N'50 Đề Minh Họa 2023 - Môn Vật Lý (Tái Bản)',N'Lại Đắc Hợp','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Ftailieu4.jpg?alt=media&token=a3869ee3-e174-4756-9742-f3bfb933bb80&_gl=1*19s7lw4*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjAzMi42MC4wLjA.',200.000,10,null,1),
		(N'Bộ Đề Luyện Thi THPT Môn Tiếng Anh (2022)',N'Mai Lan Hương, Phạm văn Luận','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Ftailieu5.jpg?alt=media&token=489dfae0-ea52-4fc4-8335-a0080ca5bb0d&_gl=1*2y7ws0*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjA0OC40NC4wLjA.',98.000,33,null,1)

insert into Cat
values	(52, 104),
		(52, 105),
		(52, 106),
		(52, 107),
		(52, 108)

INSERT INTO Books
VALUES	(N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Chữ Cái Viết Thường',N'Chính An','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fmaugiao1.jpg?alt=media&token=e4426df9-b551-4aa1-bd25-1b126a9dbf83&_gl=1*1qng0am*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjA4NS43LjAuMA..',12.000,15,null,1),
		(N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Chữ Số',N'Chính An','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fmaugiao2.jpg?alt=media&token=4a9d5b4c-fd66-492b-a5dc-ed090150b04f&_gl=1*12of5k4*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjEwMi42MC4wLjA.',12.000,15,null,1),
		(N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Nét Cơ Bản',N'Chính An','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fmaugiao3.jpg?alt=media&token=ad3ce64f-27a2-492d-888b-5459b7cbe30f&_gl=1*10qjud4*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjExOC40NC4wLjA.',12.000,15,null,1),
		(N'Tập Tô Mẫu Giáo: Chữ Số (Dành Cho 4 - 5 Tuổi) - Tập 4',N'Minh Châu, Thiện Lộc','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fmaugiao4.jpg?alt=media&token=ad34095b-810d-4c7a-953b-1cbee9ab0a5b&_gl=1*150yj7*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjEzMS4zMS4wLjA.',12.000,15,null,1),
		(N'Pomath - Toán Tư Duy Cho Trẻ Em 4-6 Tuổi - Tập 3',N'PGS TS Chu Cẩm Thơ','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fgiaokhoa-thamkhao%2Fmaugiao5.jpg?alt=media&token=82561ff0-16c8-4102-9a12-69d04e8c8788&_gl=1*1wgty8l*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjE0Ni4xNi4wLjA.',99.000,15,null,1)

insert into Cat
values	(53, 109),
		(53, 110),
		(53, 111),
		(53, 112),
		(53, 113)

INSERT INTO Books
VALUES	(N'Giải Thích Ngữ Pháp Tiếng Anh (Tái Bản 2022)',N'Mai Lan Hương, Hà Thanh Uyên','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienganh1.jpg?alt=media&token=c7d114da-3a20-49ed-bbd9-55d0da274cad&_gl=1*vc9ch8*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjE2OC41NC4wLjA.',220.000,40,null,1),
		(N'Mind Map English Vocabulary - Từ Vựng Tiếng Anh Qua Sơ Đồ Tư Duy',N'Hoàng Ngân, Linh Chi','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienganh2.jpg?alt=media&token=72d3aa14-ff7f-4ceb-a306-de500d41f200&_gl=1*1ydkzdb*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjE5OC4yNC4wLjA.',198.000,40,null,1),
		(N'Tự Học 2000 Từ Vựng Tiếng Anh Theo Chủ Đề (Tái Bản)',N'The Windy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienganh3.jpg?alt=media&token=959933bc-6318-48ae-a241-4db47e70da3f&_gl=1*1fhcz6s*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjIyNC42MC4wLjA.',65.000,40,null,1),
		(N'Động Từ Bất Quy Tắc Và Ngữ Pháp Tiếng Anh Căn Bản (Tái Bản 2022)',N'Mai Lan Hương','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienganh4.jpg?alt=media&token=0de68d60-432c-4229-92f4-f55fa46d468a&_gl=1*nfm7zm*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjI0MC40NC4wLjA.',18.000,33,null,1),
		(N'Tiếng Anh Cho NgườI Bắt Đầu (Tái Bản 2023)',N'Trang Anh, Minh Anh','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienganh5.jpg?alt=media&token=36f35adb-0c30-4394-ab73-7be499fca050&_gl=1*cui8z7*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjU1Mi42MC4wLjA.',200.000,10,null,1)

insert into Cat
values	(54, 114),
		(54, 115),
		(54, 116),
		(54, 117),
		(54, 118)

INSERT INTO Books
VALUES	(N'N3 - 2000 Từ Vựng Cần Thiết Cho Kỳ Thi Năng Lực Nhật Ngữ',N'Arc Academy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftiengnhat1.jpg?alt=media&token=97b28a94-7e90-4cbc-bf37-d035962005cb&_gl=1*1fa4bby*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjU3NS4zNy4wLjA.',110.000,15,null,1),
		(N'N1 - 3000 Từ Vựng Cần Thiết Cho Kỳ Thi Năng Lực Nhật Ngữ',N'Arc Academy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftiengnhat2.jpg?alt=media&token=1f5faa5b-9ff4-46cf-a0a0-b7858ad53119&_gl=1*1drz2x3*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjU5MS4yMS4wLjA.',125.000,15,null,1),
		(N'N2 - 2500 Từ Vựng Cần Thiết Cho Kỳ Thi Năng Lực Nhật Ngữ',N'Arc Academy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftiengnhat3.jpg?alt=media&token=42da4e30-2d59-4f30-83ba-dec83c76256a&_gl=1*14rn9ir*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjYxMi42MC4wLjA.',115.000,15,null,1),
		(N'Keep It Up - Tập Viết Tiếng Nhật Theo Bảng Chữ Cái Hiragana',N'Jeong Eui Sang','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftiengnhat4.jpg?alt=media&token=64e2fea2-e95a-4ba5-9419-d4ca8ac4e062&_gl=1*160cusr*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjYyNi40Ni4wLjA.',59.000,15,null,1),
		(N'Ngữ Pháp Tiếng Nhật Căn Bản',N'Masahiro Tanimori, Eriko Sato','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftiengnhat5.jpg?alt=media&token=7ce13c37-3a20-4994-b9e8-16edf8c6d0f4&_gl=1*1o7ziqu*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjY0MS4zMS4wLjA.',229.000,27,null,1)

insert into Cat
values	(55, 119),
		(55, 120),
		(55, 121),
		(55, 122),
		(55, 123)

INSERT INTO Books
VALUES	(N'Giáo Trình Chuẩn HSK 1 (Tái Bản 2022)',N'Khương lệ Bình','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghoa1.jpg?alt=media&token=d01ddf51-639a-4063-ba23-f8e28b360d0f&_gl=1*1h28p6q*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjY3NC42MC4wLjA.',198.000,40,null,1),
		(N'Giáo Trình Chuẩn HSK 2 (Tái Bản)',N'Khương Lệ Bình, Vương Phong','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghoa2.jpg?alt=media&token=061ef768-4469-487b-9d0e-376c832c858d&_gl=1*1fad3of*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjY5MC40NC4wLjA.',198.000,28,null,1),
		(N'Giáo Trình Chuẩn HSK 3',N'Khương lệ Bình','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghoa3.jpg?alt=media&token=84bde716-79b1-4a02-8bc7-f2aee34f17c7&_gl=1*1q15tfc*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjcwNy4yNy4wLjA.',288.000,25,null,1),
		(N'Giáo Trình Chuẩn HSK 4 - Tập 1',N'Khương lệ Bình','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghoa4.jpg?alt=media&token=368b59e3-c4ab-4a30-a149-ba811039c6c9&_gl=1*1clu4jv*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjcyMS4xMy4wLjA.',288.000,25,null,1),
		(N'Giáo Trình Chuẩn HSK 5 - Tập 2',N'Khương lệ Bình','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghoa5.jpg?alt=media&token=2de017bc-6aa2-4953-be84-75578ea90a8b&_gl=1*9nyblc*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjczNS42MC4wLjA.',268.000,25,null,1)

insert into Cat
values	(56, 124),
		(56, 125),
		(56, 126),
		(56, 127),
		(56, 128)

INSERT INTO Books
VALUES	(N'Tiếng Hàn Tổng Hợp Dành Cho Người Việt Nam - Sơ Cấp 1 - Sách Bài Tập (Tái Bản 2023)',N'Nhiều Tác Giả','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghan1.jpg?alt=media&token=ca2b79c7-724e-4151-9576-ad64f8aa1f1f&_gl=1*nw1o2*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3Mjc1MC40NS4wLjA.',98.000,40,null,1),
		(N'Giáo Trình Luyện Dịch Trung Cao Cấp Tiếng Hàn Quốc',N'Trường Hàn Ngữ Việt Hàn Kanata','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghan2.jpg?alt=media&token=af10ca30-6c90-49e5-b643-c55026a0b5be&_gl=1*55r1zx*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3Mjc2Ni4yOS4wLjA.',75.000,0,null,1),
		(N'Visual Korean Vietnamese English Trilingual Dictionary',N'DK','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghan3.jpg?alt=media&token=3f1461e0-71cf-4aed-b8c4-ab14abf4f0bb&_gl=1*10d5zl9*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3Mjc4NC4xMS4wLjA.',320.000,25,null,1),
		(N'6000 Từ Vựng Y Học Song Ngữ Hàn - Việt',N'Trường Hàn Ngữ Việt Hàn Kanata','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghan4.jpg?alt=media&token=86fd9390-84c9-4127-b4f1-e4aa5ed7ffa6&_gl=1*x9oon3*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3Mjc5OC42MC4wLjA.',100.000,15,null,1),
		(N'Tự Học Tiếng Hàn Dành Cho Người Mới Bắt Đầu (Tái Bản 2023)',N'The Changmi','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FTrong_nuoc_2%2Fngoaingu%2Ftienghan5.jpg?alt=media&token=ae12043a-247f-4c59-8f1d-7075f9d091ff&_gl=1*5jvh91*_ga*MTg1NDIyOTUyNy4xNjkwMTIxMTQ2*_ga_CW55HF8NVT*MTY5ODQ2ODQ1My42LjEuMTY5ODQ3MjgxMC40OC4wLjA.',98.000,15,null,1)

insert into Cat
values	(57, 129),
		(57, 130),
		(57, 131),
		(57, 132),
		(57, 133)

--vix
INSERT INTO Books
VALUES	('To Kill a Mockingbird', 'Harper Lee', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fclassic1.jpg?alt=media&token=d5b404d2-743d-4b70-a3ff-e1f6b1bb5ef2&_gl=1*1wipo2e*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxMzk4MC42MC4wLjA.', 180000, 5, '''Shoot all the bluejays you want, if you can hit ''em, but remember it''s a sin to kill a mockingbird''. A lawyer''s advice to his children as he defends the real mockingbird of Harper Lee''s classic novel - a black man charged with the rape of a white girl. ', 1),
		('Jane Eyre (Alma Classics Evergreens)', 'Charlotte Brontë', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fclassic2.jpg?alt=media&token=c118765f-2dfa-4efb-b7e2-cc5512ca21c7&_gl=1*5dkoxb*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDA5My42MC4wLjA.', 124200, 10, 'A novel of high romance and great intensity, Jane Eyre has enjoyed popular success and critical acclaim ever since its publication in 1847. Jane''s journey from a troubled childhood to independence - and her turbulent love affair with the enigmatic Mr Rochester - electrified Victorian readers with its narrative power.', 1),
		('Jane Eyre (Collins Classics)', 'Charlotte Brontë', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fclassic3.jpg?alt=media&token=f66142b2-ce03-4d71-8cc5-84b09ee7cb48&_gl=1*1ydofmd*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDI4MS42MC4wLjA.', 54000, 10, 'Bronte''s infamous Gothic novel tells the story of orphan Jane, a child of unfortunate circumstances. Raised and treated badly by her aunt and cousins and eventually sent away to a cruel boarding school, it is not until Jane becomes a governess at Thornfield that she finds happiness. ', 1),
		('The Adventures of Tom Sawyer (Collins Classics)', 'Mark Twain', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fclassic4.jpg?alt=media&token=3dd2d752-f71c-4e16-bb6f-db1cfc391805&_gl=1*b8m878*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDM5NC42MC4wLjA.', 54000, 0, 'HarperCollins is proud to present its new range of best-loved, essential classics. ''Now he found out a new thing - namely, that to promise not to do a thing is the surest way in the world to make a body want to go and do that very thing.'' An idyllic snapshot of a boy''s childhood along the banks of the Mississippi River, Twain''s The Adventures of Tom Sawyer is the author''s work that comes closest to his boyhood experiences of growing up in Hannibal in the 1840s. Mischievous and full of energy, Tom enjoys childish pranks and pastimes with his friends, Huck Finn, the town outcast and Joe Harper, his best friend.', 1),
		('Moby Dick (Alma Classics Evergreens)', 'Herman Melville', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fclassic5.jpg?alt=media&token=2739c649-a6ad-44c0-807c-6db3b1fffc8c&_gl=1*1k785na*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDUzNS42MC4wLjA.', 143000, 0, 'When the young Ishmael gets on board Captain Ahab''s whaling ship, little does he suspect that the mission on which he is about to embark is the fulfilment of his master''s obsessive desire for revenge on Moby Dick, a white whale who has already claimed countless human victims and destroyed many fleets. ', 1)

insert into Cat
values	(58, 134),
		(58, 135),
		(58, 136),
		(58, 137),
		(58, 138)

INSERT INTO Books
VALUES	('Flipped', 'Van Draanen Wendelin', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fromance1.jpg?alt=media&token=73579ed5-b563-4e31-ad49-023c4afacf06&_gl=1*1eue54d*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODQ5MTM1MS40LjEuMTY5ODQ5MjA5My41NC4wLjA.', 178000, 10, 'The first time she saw him, she flipped. The first time he saw her, he ran. That was the second grade, but not much has changed by the seventh. She says: My Bryce. Still walking around with my first kiss. He says: It s been six years of strategic avoidance and social discomfort. But in the eighth grade everything gets turned upside down. And just as he s thinking there s more to her than meets the eye, she s thinking that he s not quite all he seemed. This is a classic romantic comedy of errors told in alternating chapters by two fresh, funny voices. Wendelin Van Draanen is at her best here with a knockout cast of quirky characters and a hilarious series of misunderstandings and missed opportunities. But underlying the humor are two teens in transition. ', 1),
		('The Sun Is Also A Star', 'Nicola Yoon', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fromance2.jpg?alt=media&token=c01c0f4d-c4a0-4078-a5a3-8cc58cb66929&_gl=1*wovgpd*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxMzI1Mi41NS4wLjA.', 160800, 20, 'The New York Times and internationally bestselling love story from Nicola Yoon, author of Everything, Everything - now a film starring Amandla Stenberg and Nick Robinson, in cinemas this summer', 1),
		('Love, Rosie', 'Best Romance Authors', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fromance3.jpg?alt=media&token=0c7b7766-7c59-43f4-8133-42742d01700e&_gl=1*bj5qqk*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxMzU0NC4yNC4wLjA.', 172800, 10, 'Like two ships always passing in the night, Rosie and Alex stay friends, and though years pass, the two remain firmly attached via emails and letters. Heartbroken, they learn to live without each other. But destiny is a funny thing, and in this novel o f several missed opportunities, Rosie and Alex learn that fate isn''t quite done with them yet.', 1),
		(N'Love & Gelato', 'Jenna Evans Welch', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fromance4.jpg?alt=media&token=4281291b-0ada-44f2-bb63-6b09035ac6e9&_gl=1*1xsjag7*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxMzc2MS41OC4wLjA.', 189000, 10, 'A summer in Italy turns into a road trip across Tuscany in this sweeping debut novel filled with romance, mystery, and adventure.', 1),
		('Believe Me: TikTok Made Me Buy It! (Shatter Me Series)', 'Tahereh Mafi', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fromance5.jpg?alt=media&token=728016de-58c4-49b3-bcb0-dece1f04e2b0&_gl=1*8c7k3l*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxMzg0My42MC4wLjA.', 136800, 5, 'The breath-taking and heart-pounding final instalment in the New York Times bestselling fantasy series SHATTER ME.Perfect for fans of Sarah J. Maas, Victoria Aveyard and Leigh Bardugo.', 1)

insert into Cat
values	(59, 139),
		(59, 140),
		(59, 141),
		(59, 142),
		(59, 143)

INSERT INTO Books
VALUES	('A Clash Of Kings', 'George R. R. Martin', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Ffantasy1.jpg?alt=media&token=27f53f80-c9d0-4a0d-b726-3d24a0d47a40&_gl=1*1tb16a3*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDcyMS42MC4wLjA.', 126000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('The Silmarillion', 'J. R. R. Tolkien', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Ffantasy2.jpg?alt=media&token=b75a0f4a-f14d-4454-881b-f6dc576eaa3f&_gl=1*f01egn*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNDg2MS42MC4wLjA.', 183000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Magnus Chase And The Gods Of Asgard Book 3: The Ship Of The Dead', 'Rick Riordan', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Ffantasy3.jpg?alt=media&token=31b0b7d3-c5d9-48c8-9ec7-ae793a104a70&_gl=1*3d0h2v*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTAzMy42MC4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Six Of Crows Book 2: Crooked Kingdom', 'Leigh Bardugo', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Ffantasy4.jpg?alt=media&token=529edef2-b79e-4610-b777-d6e73200a313&_gl=1*1rq4mc9*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTExNS42MC4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(60, 144),
		(60, 145),
		(60, 146),
		(60, 147)

INSERT INTO Books
VALUES	('The Da Vinci Code', 'Dan Brown', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fthriller1.jpg?alt=media&token=b7a69d55-b630-448d-b97d-614dd3435da8&_gl=1*7ygyw5*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTM4My41NC4wLjA.', 170000, 10, 'An eminent man is brutally murdered in the world’s most famous museum. Around his body are a ring of codes, hastily drawn in blood. He died to protect a long-kept secret which Professor Robert Langdon must now uncover. It will be a race against time to decipher this final message. Can he get there before the killers do?', 1),
		('The Shining', 'Stephen King', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fthriller2.jpg?alt=media&token=fa020b99-cbb6-4304-b369-a87cc8682f8e&_gl=1*l74eax*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTYxNS42MC4wLjA.', 183000, 0, 'World-renowned Harvard symbologist Robert Langdon is summoned to a Swiss research facility to analyze a cryptic symbol seared into the chest of a murdered physicist. What he discovers is unimaginable: a deadly vendetta against the Catholic Church by a centuries-old underground organization -- the Illuminati. Desperate to save the Vatican from a powerful time bomb, Langdon joins forces in Rome with the beautiful and mysterious scientist Vittoria Vetra. Together they embark on a frantic hunt through sealed crypts, dangerous catacombs, deserted cathedrals, and the most secretive vault on earth...the long-forgotten Illuminati lair.', 1),
		('Angels and Demons (Robert Langdon)', 'Dan Brown', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fthriller3.jpg?alt=media&token=a95ee7af-aee1-4f2c-a090-cac142b34c54&_gl=1*1ls9l44*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTYzOS4zNi4wLjA.', 245000, 5, 'He greatest haunted house story ever written and the inspiration for a 10-part Netflix series directed by Mike Flanagan and starring Michiel Huisman, Carla Gugino, and Timothy Hutton. First published in 1959, Shirley Jackson''s The Haunting of Hill House has been hailed as a perfect work of unnerving terror. It is the story of four seekers who arrive at a notoriously unfriendly pile called Hill.', 1),
		('The Haunting of Hill House (Movie Tie-In)', 'Shirley Jackson', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fthriller4.jpg?alt=media&token=e79b0f6f-a6f8-40c3-9eba-191e064df93f&_gl=1*mhzts6*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTY0My4zMi4wLjA.', 250000, 5, 'Jess needs a fresh start. She’s broke and alone, and she’s just left her job under less than ideal circumstances. Her half-brother Ben didn’t sound thrilled when she asked if she could crash with him for a bit, but he didn’t say no, and surely everything will look better from Paris. Only when she shows up – to find a very nice apartment, could Ben really have afforded this? – he’s not there.', 1),
		('The Paris Apartment', 'Lucy Foley', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Ffiction%2Fthriller5.jpg?alt=media&token=1a265d3c-4063-4bd3-84e3-299d3b988bc3&_gl=1*f8mnmk*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNTY0Ny4yOC4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)


insert into Cat
values	(61, 148),
		(61, 149),
		(61, 150),
		(61, 151),
		(61, 152)

INSERT INTO Books
VALUES	('Think and Grow Rich', 'Napoleon Hill', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Fbusiness%26M1.jpg?alt=media&token=75a4a761-1e54-4bdc-89cc-ad541369703c&_gl=1*6v37mb*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NjYyMC4xOC4wLjA.', 140000, 10, 'The most famous of all teachers of success spent "a fortune and the better part of a lifetime of effort" to produce the "Law of Success" philosophy that forms the basis of his books and that is so powerfully summarized in this one.', 1),
		('The Personal MBA 10th Anniversary Edition', 'Josh Kaufman', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Fbusiness%26M2.jpg?alt=media&token=93aa5749-cb8d-4791-8fe2-f717d17794c7&_gl=1*9pd17j*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NjYyNi4xMi4wLjA.', 183000, 0, 'World-renowned Harvard symbologist Robert Langdon is summoned to a Swiss research facility to analyze a cryptic symbol seared into the chest of a murdered physicist. What he discovers is unimaginable: a deadly vendetta against the Catholic Church by a centuries-old underground organization -- the Illuminati. Desperate to save the Vatican from a powerful time bomb, Langdon joins forces in Rome with the beautiful and mysterious scientist Vittoria Vetra. Together they embark on a frantic hunt through sealed crypts, dangerous catacombs, deserted cathedrals, and the most secretive vault on earth...the long-forgotten Illuminati lair.', 1),
		('Zero to One : Notes on Start Ups, or How to Build the Future', 'Peter Thiel,Blake Masters', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Fbusiness%26M3.jpg?alt=media&token=27a38e73-dc6e-4701-b265-807295459a04&_gl=1*zjoqdk*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NjYyNy4xMS4wLjA.', 245000, 5, 'He greatest haunted house story ever written and the inspiration for a 10-part Netflix series directed by Mike Flanagan and starring Michiel Huisman, Carla Gugino, and Timothy Hutton. First published in 1959, Shirley Jackson''s The Haunting of Hill House has been hailed as a perfect work of unnerving terror. It is the story of four seekers who arrive at a notoriously unfriendly pile called Hill.', 1),
		('Originals: How Non-Conformists Move the World', 'Adam Grant', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Fbusiness%26M4.jpg?alt=media&token=b08a83e4-f2a2-4666-b2fa-0ee532f1bfad&_gl=1*1uadcrp*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NjYyOS45LjAuMA..', 250000, 5, 'Jess needs a fresh start. She’s broke and alone, and she’s just left her job under less than ideal circumstances. Her half-brother Ben didn’t sound thrilled when she asked if she could crash with him for a bit, but he didn’t say no, and surely everything will look better from Paris. Only when she shows up – to find a very nice apartment, could Ben really have afforded this? – he’s not there.', 1),
		('Start With Why', 'Lucy Foley', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Fbusiness%26M5.jpg?alt=media&token=70c80325-612c-4925-888a-2eaa0a97f70c&_gl=1*1klu7um*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NjYzMS43LjAuMA..', 250000, 20, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(61, 153),
		(61, 154),
		(61, 155),
		(61, 156),
		(61, 157)

INSERT INTO Books
VALUES	('Principles For Dealing With The Changing World Order: Why Nations Succeed And Fail', 'Ray Dalio', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Feconomics1.jpg?alt=media&token=3d76eed1-fdaa-4247-a23b-cfbb27be97db&_gl=1*ougz6f*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzAxNS41My4wLjA.', 672000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Why Nations Fail : The Origins of Power, Prosperity, and Poverty', 'Professor Daron Acemoglu', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Feconomics2.jpg?alt=media&token=14f55e39-cbfc-4014-a6c2-dfeab123dbae&_gl=1*quvs8f*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzAxOC41MC4wLjA.', 383000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('The Big Short', 'Michael Lewis', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Feconomics3.jpg?alt=media&token=14b8767b-aa95-46ab-b78d-16749c662249&_gl=1*16ba53i*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzAxOS40OS4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Predictably Irrational: The Hidden Forces That Shape Our Decisions', 'Dan Ariely', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Feconomics4.jpg?alt=media&token=92f061e5-5cae-441f-93a7-7b75853b193a&_gl=1*19bci1a*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzAyMi40Ni4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(63, 158),
		(63, 159),
		(63, 160),
		(63, 161)

INSERT INTO Books
VALUES	('Warren Buffett''s Ground Rules: Words of Wisdom from the Partnership Letters of the World''s Greatest Investor', 'Jeremy C. Miller', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Ffinance4.jpg?alt=media&token=265f76d2-857a-483d-bd6e-b9a90fcf360f&_gl=1*1jtlsp8*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzM0OC4zLjAuMA..', 226000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Tap Dancing to Work: Warren Buffett on Practically Everything, 1966-2013', 'Carol Loomis', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Ffinance3.jpg?alt=media&token=977695a5-72c8-4549-b00d-8529286b2c17&_gl=1*92xpdr*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzM0NC43LjAuMA..', 283000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Collusion: How Central Bankers Rigged The World', 'Nomi Prins', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Ffinance2.jpg?alt=media&token=c60fbe06-29f6-4b5a-87d6-614b1bf12e21&_gl=1*yj6qa9*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzM0MS4xMC4wLjA.', 375000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('The Intelligent Investor: The Definitive Book on Value Investing. A Book of Practical Counsel', 'Benjamin Graham', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Ffinance1.jpg?alt=media&token=cd031cb5-e82b-43d8-b1d6-8a344a3ad07d&_gl=1*1yzj0b7*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzMwMy40OC4wLjA.', 450000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(64, 162),
		(64, 163),
		(64, 164),
		(64, 165)

INSERT INTO Books
VALUES	('Narconomics: How To Run A Drug Cartel', 'Tom Wainwright', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Flaw1.jpg?alt=media&token=63514982-2fe7-4192-9d19-7c5d1a2416e7&_gl=1*8aqbcu*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzE5OS40Ni4wLjA.', 336000, 10, 'How does a budding cartel boss succeed (and survive) in the 300 billion illegal drug business? By learning from the best, of course. From creating brand value to fine-tuning customer service, the folks running cartels have been attentive students of the strategy and tactics used by corporations such as Walmart, McDonald''s, and Coca-Cola.', 1),
		('Negotiating The Impossible: How To Break Deadlocks And Resolve Ugly Conflicts (Without Money Or Muscle)', 'Deepak Malhotra', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Flaw2.jpg?alt=media&token=b102ed23-00a5-41f2-901e-da69e1488d60&_gl=1*11b1usa*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzIzMC4xNS4wLjA.', 283000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('The New Jim Crow', 'Michelle Alexander', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Flaw3.jpg?alt=media&token=68525d95-f509-42fd-9077-24811147a46c&_gl=1*1y4kmw*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzIzMi4xMy4wLjA.', 375000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Jews Don’t Count', 'David Baddiel', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fbusiness%2Flaw4.jpg?alt=media&token=4ec89ee8-3077-4c03-b05e-90b6a21b7585&_gl=1*1ekyxvw*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzIzNS4xMC4wLjA.', 143000, 20, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(65, 166),
		(65, 167),
		(65, 168),
		(65, 169)

INSERT INTO Books
VALUES	('How To Begin: Start Doing Something That Matters', 'Michael Bungay Stanier', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpopular-psychology1.jpg?alt=media&token=dcc42cac-a268-4fa3-911d-2f175a64b0d1&_gl=1*k5k4zb*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzYwMi44LjAuMA..', 262000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('The Good Life: Lessons From The World''s Longest Study On Happiness', 'Robert Waldinger, Marc Schulz', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpopular-psychology2.jpg?alt=media&token=a4b00fa4-c7c1-4aec-ad80-7a2e204baf46&_gl=1*rf2vuz*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzYwNi40LjAuMA..', 83000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Ikigai: Simple Secrets To A Long And Happy Life', 'Héctor García', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpopular-psychology4.jpg?alt=media&token=f9432416-c2f8-4718-8d46-d651a21f5e6e&_gl=1*4pf5f8*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzYxMy41OC4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('The Happiness Cure: Why You’re Not Built For Constant Happiness, And How To Find A Way Through', 'Dr Anders Hansen', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpopular-psychology5.jpg?alt=media&token=0f50bff9-b2df-43ca-a84d-a44ce2d471eb&_gl=1*19kibbv*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3NzYxNS41Ni4wLjA.', 50000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(66, 170),
		(66, 171),
		(66, 172)

INSERT INTO Books
VALUES	('Wealth Secrets', 'Sam Wilkin', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpersonal-finance1.jpg?alt=media&token=64f914b4-c2e2-43dc-bc4b-559a429834a1&_gl=1*1lgbp9m*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzU5NS4zNS4wLjA.', 332000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Money Magic: An Economist''s Secrets To More Money, Less Risk, And A Better Life', 'Laurence Kotlikoff', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpersonal-finance2.jpg?alt=media&token=91abb69b-67d9-4f8a-9f7e-f0f173f9cca2&_gl=1*xjddrl*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzU5OC4zMi4wLjA.', 353000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Swiped: How to Protect Yourself in a World Full of Scammers, Phishers, and Identity Thieves', 'Adam Levin, Beau Friedlander', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpersonal-finance3.jpg?alt=media&token=bc47ae2e-effc-4185-b465-8bb6c0bed052&_gl=1*1frfirw*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzYwMS4yOS4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('The Anxious Investor: Mastering The Mental Game Of Investing', 'Scott Nations', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fpersonal-finance4.jpg?alt=media&token=ba7c5108-39c2-4fc3-acea-ebda19672549&_gl=1*19brkhh*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzYwNC4yNi4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(67, 173),
		(67, 174),
		(67, 175),
		(67, 176)


INSERT INTO Books
VALUES	('A Life Less Throwaway: The Lost Art Of Buying For Life', 'Tara Button', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fconsumer-advice1.jpg?alt=media&token=ee665b8f-71cd-4372-8485-e044308a4eb8&_gl=1*1o0hq6s*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzU4Ny40My4wLjA.', 672000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('The Art of Loving', 'Erich Fromm', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fconsumer-advice2.jpg?alt=media&token=9e09133e-18f7-483e-850c-ec0751b0600d&_gl=1*1e3ti5h*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzU5MC40MC4wLjA.', 383000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Chicken Soup For The Soul At Work: Stories Of Courage, Compassion And Creativity In The Workplace', 'Jack Canfield, Mark Victor', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2FpersionDev%2Fconsumer-advice3.jpg?alt=media&token=1e8f7d63-7b97-4e3e-b59c-550d3037d7b5&_gl=1*1ewbs9n*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNzU5My4zNy4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1)

insert into Cat
values	(68, 172),
		(68, 173),
		(68, 174)

INSERT INTO Books
VALUES	('Super Simple Biology: The Ultimate Bitesize Study Guide', 'Smithsonian', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Feducation2.jpg?alt=media&token=ab9db155-c084-4be9-af7a-487caf03fa07&_gl=1*18nxf83*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjIyMi4xLjAuMA..', 296000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Step Into Reading: Cooking With The Grinch (Dr. Seuss)', 'Tish Rabe,Tom Brannon', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Feducation3.jpg?alt=media&token=d2f3a51b-d16b-4979-aab7-e2ae93c35853&_gl=1*1vxmzth*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjIyNS41OC4wLjA.', 83000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Disney Kids Readers Level 4: Inside Out', 'Mo Sanders', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Feducation4.jpg?alt=media&token=a63ffac8-1b2f-44a0-a8be-67fd10fc2361&_gl=1*to690h*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjIyOC41NS4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Usborne Workbooks Spelling 8-9', 'Jane Bingham', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Feducation1.jpg?alt=media&token=3685bf02-7e0f-4600-b8ca-ea5bdf44f29f&_gl=1*13ffdnu*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjE2Ni41Ny4wLjA.', 125000, 5, 'Minions: The Rise of Gru, released in UK cinemas in July 2022. The official retelling of the highly anticipated movie Minions: The Rise of Gru brings the magic home so fans can experience the Minions adventures again and again.', 1)

insert into Cat
values	(69, 177),
		(69, 178),
		(69, 179),
		(69, 180)

INSERT INTO Books
VALUES	('Gravity Falls Once Upon a Swine (Gravity Falls Chapter Book)', 'Disney Book Group', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Ffiction-teen1.jpg?alt=media&token=0e7d274f-b7f8-42c7-bc7a-99800216749c&_gl=1*1x3ss7e*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODI5NS41LjAuMA..', 86000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Explorer Academy 5: The Tiger''s Nest', 'Trudi Trueit', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Ffiction-teen2.jpg?alt=media&token=8331744a-0af6-4f80-8776-25874281550e&_gl=1*1awzbld*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODI5OC4yLjAuMA..', 283000, 10, 'On an island nation in the Indian Ocean, the explorers venture through a vast underwater world and take part in a friendly robotics competition. But the tides of good fortune change quickly. Suddenly, Team Cousteau jumps into action to rescue a faculty member from the brink of death. ', 1),
		('5-Minute Spiderman Stories', 'Marvel Press Book Group', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Ffiction-teen3.jpg?alt=media&token=d76017fd-5f36-4aae-a650-0be315697841&_gl=1*1b646h7*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODMwMS42MC4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Minions 2: The Rise Of Gru Official Story Of The Movie', 'Minions', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Ffiction-teen4.jpg?alt=media&token=10608c3b-81b0-436d-9037-fa201fbbc1a3&_gl=1*1ee0j6o*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODMwMy41OC4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1),
		('Harry Potter And The Deathly Hallows', 'J K Rowling', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Ffiction-teen5.jpg?alt=media&token=8ddfd108-ff27-449b-acdc-ad38b07164b2&_gl=1*42pe1a*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODMwNy41NC4wLjA.', 175000, 5, 'As he climbs into the sidecar of Hagrid''s motorbike and takes to the skies, leaving Privet Drive for the last time, Harry Potter knows that Lord Voldemort and the Death Eaters are not far behind.', 1)

insert into Cat
values	(70, 181),
		(70, 182),
		(70, 183),
		(70, 184),
		(70, 185)

INSERT INTO Books
VALUES	('Little Friends: Trick Or Treat : A Lift-The-Flap Book', 'Roger Priddy', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Fpicture-activity-books2.jpg?alt=media&token=2eb15e20-6b74-472b-9a1b-f8798be73369&_gl=1*1r4i4wj*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjc2OC4yOC4wLjA.', 126000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('Lift-the-Flap First Questions & Answers How do I see?', 'Katie Daynes', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Fpicture-activity-books3.jpg?alt=media&token=44927991-6a3b-49f8-8ccc-9755598684fb&_gl=1*1nueaj6*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjc3MS4yNS4wLjA.', 183000, 0, 'The Silmarillion is an account of the Elder Days, of the First Age of Tolkien''s world. It is the ancient drama to which the characters in The Lord of the Rings look back, and in whose events some of them such as Elrond and Galadriel took part. The tales of The Silmarillion are set in an age when Morgoth, the first Dark Lord, dwelt in Middle-Earth, and the High Elves made war upon him for the recovery of the Silmarils, the jewels containing the pure light of Valinor.', 1),
		('Baby''s Very First Lift-the-flap Peek-a-boo At The Zoo', 'Fiona Watt', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Fpicture-activity-books4.jpg?alt=media&token=6f33f3c0-844a-4dad-97f4-062e8a5101f6&_gl=1*cyxmtd*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjc3NS4yMS4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Glow In The Dark Puffy Stickers Happy Halloween!', 'Amy Boxshall', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Fpicture-activity-books1.jpg?alt=media&token=c2f8fcff-a3bf-4d46-ad24-7f199ee5c797&_gl=1*1ro8jri*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODUxMjQyOS42LjEuMTY5ODUxNjczNi42MC4wLjA.', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(71, 186),
		(71, 187),
		(71, 188),
		(71, 189)

INSERT INTO Books
VALUES	('Countries Of The World: Our World In Pictures', 'DK', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Freference1.jpg?alt=media&token=9ed2fdb5-8885-4036-bf1d-8ba47659bc02&_gl=1*1djct2g*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODk1NC4zMC4wLjA.', 378000, 10, 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising.', 1),
		('What If? 2 Additional Serious Scientific Answers To Absurd Hypothetical Questions', 'Randall Munroe', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Freference2.jpg?alt=media&token=05090839-75ae-4afe-bacd-c3c25d0e5b91&_gl=1*1i7gdje*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODk1Ny4yNy4wLjA.', 283000, 10, 'On an island nation in the Indian Ocean, the explorers venture through a vast underwater world and take part in a friendly robotics competition. But the tides of good fortune change quickly. Suddenly, Team Cousteau jumps into action to rescue a faculty member from the brink of death. ', 1),
		('Trees, Leaves, Flowers And Seeds: A Visual Encyclopedia Of The Plant Kingdom', 'DK, Smithsonian Institution', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Freference3.jpg?alt=media&token=48df40bb-9788-424e-aeb0-d0f0e217293a&_gl=1*1r6j6dg*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODk2MS4yMy4wLjA.', 175000, 5, 'Loki the trickster god is free from his chains. Now he''s readying Naglfar, the Ship of the Dead, armed with a host of giants and zombies, to sail against the Norse gods and begin the final battle of Ragnarok.', 1),
		('Cars, Trains, Ships, And Planes: A Visual Encyclopedia Of Every Vehicle (DK Our World In Pictures)', 'DK, Smithsonian Institution', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FforeignBook%2Fchildren%2Freference4.jpg?alt=media&token=1e9a172c-979a-4ea6-b633-2f72eb677198&_gl=1*19m9yup*_ga*Nzk2MDYwMDc5LjE2OTgzMzUyMjE.*_ga_CW55HF8NVT*MTY5ODU3NTkxNy43LjEuMTY5ODU3ODk3NS45LjAuMA..', 250000, 5, 'Welcome to the world of the Grisha. Kaz Brekker and his crew of deadly outcasts have just pulled off a heist so daring even they didn''t think they''d survive. But instead of divvying up a fat reward, they''re right back to fighting for their lives.', 1)

insert into Cat
values	(72, 190),
		(72, 191),
		(72, 192),
		(72, 193)

--phương
INSERT INTO Books
VALUES	('English Grammar in Use Book w Ans', 'Raymond Murphy', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-learning%2Fetl1.jpg?alt=media&token=7eeb8a10-71f9-4c55-9069-94c33a719236&_gl=1*k4t27j*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTU5ODguNjAuMC4w', 178000, 10, 'The world''s best-selling grammar series for learners of English. English Grammar in Use Fourth edition is an updated version of the world''s best-selling grammar title. It has a fresh, appealing new design and clear layout, with revised and updated examples, but retains all the key features of clarity and accessibility that have made the book popular with millions of learners and teachers around the world. This with answers version is ideal for self-study.', 1),
		('Pippa And Pop Level 2 Student''s Book With Digital Pack American English', 'Caroline Nixon, Michael Tomlinson', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-learning%2Fetl2.jpg?alt=media&token=602b6b0a-ace1-4b83-b88f-eddbf27d0fb1&_gl=1*3dymaw*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTYwMDMuNDUuMC4w', 310000, 5, 'Peep inside Dan and Kim''s family bookshop and discover the marvelous miniature world of their toy mice, Pippa and Pop! This three-level pre-primary English course will stimulate the imagination and foster a love of stories, songs and rhymes, helping very young learners to acquire early life competencies. The course develops early literacy skills, builds the foundations for independence through Learning to Learn activities, underpinned by the Cambridge Life Competencies Framework, and develops early creative, critical and communication skills through guided play.With a gradual introduction to numeracy, letters and sounds, exciting projects, cross-curricular lessons and a focus on values, Pippa and Pop is the perfect start to the adventure of learning English!', 1),
		('The Official Cambridge Guide to IELTS Student''s Book with Answers with DVD-ROM', 'Pauline Cullen, Amanda French, Vanessa Jakeman', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-learning%2Fetl3.jpg?alt=media&token=48f23dc4-9f6b-4a20-ab07-8bbece6eb291&_gl=1*119pktz*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTYwMTcuMzEuMC4w', 388000, 5, 'The world''s best-selling grammar series for learners of English. English Grammar in Use Fourth edition is an updated version of the world''s best-selling grammar title. It has a fresh, appealing new design and clear layout, with revised and updated examples, but retains all the key features of clarity and accessibility that have made the book popular with millions of learners and teachers around the world. This with answers version is ideal for self-study.', 1),
		(N'Combo Essential Grammar in Use + English Grammar in Use (Bộ 2 cuốn)', 'Raymond Murphy', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-learning%2Fetl4.jpg?alt=media&token=50370748-addf-4d84-833d-7295af821243&_gl=1*1kvaqgn*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTYwMzAuMTguMC4w', 356000, 10, 'The world''s best-selling grammar series for learners of English. English Grammar in Use Fourth edition is an updated version of the world''s best-selling grammar title. It has a fresh, appealing new design and clear layout, with revised and updated examples, but retains all the key features of clarity and accessibility that have made the book popular with millions of learners and teachers around the world. This with answers version is ideal for self-study.', 1),
		('Mindset For IELTS - Foundation Student''s Book With Testbank And Online Modules', 'Greg Archer, Joanna Kosta, Lucy Pasmore, Jishan Uddin', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-learning%2Fetl5.jpg?alt=media&token=ac428b68-b4e2-4368-a2e0-bc867be87c8a&_gl=1*di25sf*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTYwNDEuNy4wLjA.', 395000, 5, 'The world''s best-selling grammar series for learners of English. English Grammar in Use Fourth edition is an updated version of the world''s best-selling grammar title. It has a fresh, appealing new design and clear layout, with revised and updated examples, but retains all the key features of clarity and accessibility that have made the book popular with millions of learners and teachers around the world. This with answers version is ideal for self-study.', 1)

insert into Cat
values	(73, 194),
		(73, 195),
		(73, 196),
		(73, 197),
		(73, 198)

INSERT INTO Books
VALUES	('Business Result: Intermediate: Student''s Book with Online Practice', 'Oxford University Press', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-material%2Fetl6.jpg?alt=media&token=e6f08e58-28fc-43f6-9f42-f27f3ca6661a&_gl=1*15w4u9n*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTY4MzkuMzYuMC4w', 530000, 5, 'For business professionals looking to advance their careers through improving their English, Business Result Second Edition is a practical Business English course that focuses on real, relevant communication skills they can immediately use in the workplace.', 1),
		('Market Leader 3Rd Edition Intermediate Practice File Cd Pack', 'John Rogers', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-material%2Fetl7.jpg?alt=media&token=b318db7a-d414-4f0e-aa5e-083d52964341&_gl=1*61vuse*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTY4NTguMTcuMC4w', 184000, 5, 'The 3rd edition Course Book includes: * All new reading texts from the Financial Times * All new case studies with opinions from successful consultants who work in the real world of business * All new listening texts reflecting the global nature of business * New ''Business Across Cultures'' spreads * New Vocabulary Trainer www.marketleader.vocabtrainer.net', 1),
		('International Express Intermediate: Student''S Book Pack', 'Oxford University Press', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-material%2Fetl8.jpg?alt=media&token=bfbda0b5-a5a0-4a68-b21d-0ebcdc59858f&_gl=1*15q15ml*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTY4NjkuNi4wLjA.', 260000, 5, 'For business professionals looking to advance their careers through improving their English, Business Result Second Edition is a practical Business English course that focuses on real, relevant communication skills they can immediately use in the workplace.', 1),
		('Oxford Eap A Course In English For Academic Purposes: Advanced C1 (Oxford Eap Series)', 'Edward De Chazal', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-material%2Fetl9.jpg?alt=media&token=821fc8b3-3a03-4fab-b38d-561cb734e045&_gl=1*h049el*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTY4ODIuNjAuMC4w', 315000, 5, 'A brand new EAP course from Oxford offering an integrated approach to teaching English for Academic Purposes and authentic texts from Oxford textbooks. Oxford EAP develops the essential skills and academic language for learners who are preparing to study in English at university level, from foundation courses to postgraduate research. With authentic content from Oxford textbooks and videos of lecture extracts, Oxford EAP is an ideal course for learners from a wide range of disciplines. Its clear structure and user-friendly approach make it an ideal resource for experienced EAP tutors as well as teachers who are starting out in the field.', 1),
		('Business Benchmark Upper Intermediate BULATS Student''s Book', 'Guy Brook Hart', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fetl-material%2Fetl10.jpg?alt=media&token=5a353083-392e-4b30-9ed6-fb6ca9b9e0e6&_gl=1*1suu3z4*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTY4OTQuNDguMC4w', 573000, 5, 'Business Benchmark Second edition is the official Cambridge English preparation course for Cambridge English: Business Preliminary, Vantage and Higher (also known as BEC), and BULATS. A pacy, topic-based course with comprehensive coverage of language and skills for business, it motivates and engages both professionals and students preparing for working life. The Upper Intermediate BULATS Student''s Book contains authentic listening and reading materials, including interviews with business people, providing models for up-to-date business language. Grammar and vocabulary exercises train students to avoid common mistakes, identified using Cambridge''s unique collection of real exam candidates'' answers. ''Grammar workshops'' practise grammar in relevant business contexts. A Cambridge English: Business Vantage version of this Student''s Book is also available.', 1)

insert into Cat
values	(74, 199),
		(74, 200),
		(74, 201),
		(74, 202),
		(74, 203)

INSERT INTO Books
VALUES	('Oxford Learner’s Pocket Dictionary 4Ed', 'Oxford', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fdictionary%2Fdic1.jpg?alt=media&token=2013453f-0c8d-4a8d-b86b-068d48049a1b&_gl=1*4hnjei*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTgzNjAuMzcuMC4w', 85000, 5, 'For business professionals looking to advance their careers through improving their English, Business Result Second Edition is a practical Business English course that focuses on real, relevant communication skills they can immediately use in the workplace.', 1),
		('Oxford Advanced Learner''s Dictionary With Vietnamese Translation (Paperback)', 'Joanna Turnbull', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fdictionary%2Fdic2.jpg?alt=media&token=beed8e64-0f36-4e4b-b1fc-154de0636fbb&_gl=1*1i4exxt*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTgzNzQuMjMuMC4w', 625000, 5, 'The 3rd edition Course Book includes: * All new reading texts from the Financial Times * All new case studies with opinions from successful consultants who work in the real world of business * All new listening texts reflecting the global nature of business * New ''Business Across Cultures'' spreads * New Vocabulary Trainer www.marketleader.vocabtrainer.net', 1),
		('Italian-English Bilingual Visual Dictionary (DK Bilingual Visual Dictionary)', 'DK', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fdictionary%2Fdic3.jpg?alt=media&token=84f56823-b99c-427b-a5d0-83c202a8a5f2&_gl=1*ce617h*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTgzODUuMTIuMC4w', 223000, 5, 'For business professionals looking to advance their careers through improving their English, Business Result Second Edition is a practical Business English course that focuses on real, relevant communication skills they can immediately use in the workplace.', 1),
		('Oxford Advanced Learner''s Dictionary with Vietnamese Translation (Hardback)', 'Joanna Turnbull', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fdictionary%2Fdic4.jpg?alt=media&token=d064d7d3-a4ed-4d5d-96b1-bace1f62395c&_gl=1*1sumz9u*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTg0MDMuNjAuMC4w', 730000, 5, 'A brand new EAP course from Oxford offering an integrated approach to teaching English for Academic Purposes and authentic texts from Oxford textbooks. Oxford EAP develops the essential skills and academic language for learners who are preparing to study in English at university level, from foundation courses to postgraduate research. With authentic content from Oxford textbooks and videos of lecture extracts, Oxford EAP is an ideal course for learners from a wide range of disciplines. Its clear structure and user-friendly approach make it an ideal resource for experienced EAP tutors as well as teachers who are starting out in the field.', 1),
		('Oxford Learner’s Pocket Word Skills', 'Oxford University Press', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fdictionary%2Fdic5.jpg?alt=media&token=3b336d23-7214-43d4-981a-4570e80e6e1a&_gl=1*y4ah45*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTg0MzMuMzAuMC4w', 239000, 5, 'Business Benchmark Second edition is the official Cambridge English preparation course for Cambridge English: Business Preliminary, Vantage and Higher (also known as BEC), and BULATS. A pacy, topic-based course with comprehensive coverage of language and skills for business, it motivates and engages both professionals and students preparing for working life. The Upper Intermediate BULATS Student''s Book contains authentic listening and reading materials, including interviews with business people, providing models for up-to-date business language. Grammar and vocabulary exercises train students to avoid common mistakes, identified using Cambridge''s unique collection of real exam candidates'' answers. ''Grammar workshops'' practise grammar in relevant business contexts. A Cambridge English: Business Vantage version of this Student''s Book is also available.', 1)

insert into Cat
values	(75, 204),
		(75, 205),
		(75, 206),
		(75, 207),
		(75, 208)

INSERT INTO Books
VALUES	(N'文豪ストレイドッグス 太宰、中也、十五歳 2 - Bungo Stray Dogs - Dazai & Chuya - 15 Years Old - Vol. 2', N'星河 シワス, 朝霧 カフカ, 春河35', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2FjapanBook%2Fnhat1.jpg?alt=media&token=eed444e3-3f39-4b26-9643-df04c1df3a9c&_gl=1*1bhm7px*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTkwNDUuMjYuMC4w', 220000, 5, null, 1),
		(N'SPY x FAMILY 5', N'遠藤 達哉', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2FjapanBook%2Fnhat2.jpg?alt=media&token=627f8723-3fe4-40bc-9972-a3425af5f89e&_gl=1*1p3o5gf*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTkwNzguNjAuMC4w', 166000, 10, null, 1),
		(N'ホリミヤ 17 A Piece Of Memories 特装版 メモリアルブック Bonus Track 付き- Horimiya 17 (Special Edition)', N'HERO, 萩原ダイスケ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2FjapanBook%2Fnhat3.jpg?alt=media&token=55d3269e-d57c-4bc3-87f7-511b8bb72bff&_gl=1*15s2k1y*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTkwOTYuNDIuMC4w', 421000, 10, null, 1),
		(N'ドラゴンボール超 19 - Dragon Ball Super 19', N'とよたろう, 鳥山 明', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2FjapanBook%2Fnhat4.jpg?alt=media&token=9296956d-0dfc-4004-a51f-1e369f8f1dcf&_gl=1*1n0zjo6*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTkxMTQuMjQuMC4w', 152000, 5, null, 1),
		(N'1stイラスト集 Glare x Sparkle - Oshi No Ko 1st Illustration Collection: Glare x Sparkle', N'赤坂 アカ, 横槍 メンゴ', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2FjapanBook%2Fnhat5.jpg?alt=media&token=79086a24-1f69-4fab-8413-73e7771646d7&_gl=1*dj73jb*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTkxMjguMTAuMC4w', 713000, 5, null, 1)

insert into Cat
values	(76, 209),
		(76, 210),
		(76, 211),
		(76, 212),
		(76, 213)

INSERT INTO Books
VALUES	('Langenscheidts Wörterbuch Italienisch - Sonderausgabe', 'Langenscheidt Grund- und Aufbauwortschatz, Langenscheidt Praktische Wörterbücher', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fgermany%2Fduc1.jpg?alt=media&token=80aa613b-1460-4503-9aff-f00e72b05b47&_gl=1*i3jq5t*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTk1OTYuMzguMC4w', 251000, 5, null, 1),
		('Langenscheidts Wörterbuch Spanisch - Sonderausgabe: Spanisch-Deutsch/Deutsch-Spanisch', 'Langenscheidt Grund- und Aufbauwortschatz, Langenscheidt Praktische Wörterbücher', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fgermany%2Fduc2.jpg?alt=media&token=3ceb9d44-95f5-4c5e-b19c-814a08fd4b43&_gl=1*14bgfeq*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTk2MTAuMjQuMC4w', 251000, 10, null, 1),
		('Langenscheidt Ab in den Urlaub - Französisch', 'Langenscheidt Grund- und Aufbauwortschatz, Langenscheidt Ab in den Urlaub', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fgermany%2Fduc3.jpg?alt=media&token=d6179f52-df3c-4d00-88f9-75bdddcc4851&_gl=1*1uexyj9*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTk2MjIuMTIuMC4w', 168000, 10, null, 1),
		('Menschen A2', 'Charlotte Habersack,Angela Pude,Franz Specht', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fgermany%2Fduc4.jpg?alt=media&token=56b6f094-c93d-4d58-9ccc-c467dbac4630&_gl=1*1ueiatf*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTk2MzQuNjAuMC4w', 500000, 5, null, 1),
		('Langenscheidt Lilliput Französisch-Deutsch - im Mini-Format (Lilliput-Wörterbücher Fremdsprachen)', 'Redaktion Langenscheidt', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fgermany%2Fduc5.jpg?alt=media&token=ec653381-f0ca-4734-9b09-cc3e9b1e0699&_gl=1*esulmt*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTk2NDUuNDkuMC4w', 76000, 5, null, 1)

insert into Cat
values	(77, 214),
		(77, 215),
		(77, 216),
		(77, 217),
		(77, 218)

INSERT INTO Books
VALUES	('Les Autodafeurs 1: Mon frère est un gardien', 'Marine Carteron', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffrench%2Fphap1.jpg?alt=media&token=22b76e94-6cdd-49f8-83db-5712179f65c9&_gl=1*18ki6p8*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAwMzUuNDIuMC4w', 370000, 5, null, 1),
		('L''atelier + niv .A2 (édition 2022) - Cahier + cahier numérique + didierfle.app', 'Marie-Noëlle Cocton, Emilie Pommier, Delphine Ripaud, Marie Rabin', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffrench%2Fphap2.jpg?alt=media&token=d812a39f-2255-48b7-bdbd-14ba35ce1fd8&_gl=1*16wwzal*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAwNTAuMjcuMC4w', 234000, 10, null, 1),
		('Emilie, Vol. 5. Emilie n''a pas sommeil', 'Domitille de Pressense', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffrench%2Fphap3.jpg?alt=media&token=9c39057a-bad6-45ab-9ab2-f553d33ed80a&_gl=1*sjb1l8*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAwNjQuMTMuMC4w', 162000, 10, null, 1),
		('Grenadine 1 - Livre de l''élève', 'Paccagnino, Poletti', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffrench%2Fphap4.jpg?alt=media&token=6f037182-1b1f-44c3-aa55-caf086dd5359&_gl=1*11kpj3x*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAwNzYuMS4wLjA.', 255000, 5, null, 1),
		('Patrouille Des Oies(la)', 'Faudi Khourdifi Viviane', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffrench%2Fphap5.jpg?alt=media&token=fed1c04a-85d1-471e-b37c-75aeb777a04f&_gl=1*1uhxb1o*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAwOTAuNDguMC4w', 185000, 5, null, 1)

insert into Cat
values	(78, 219),
		(78, 220),
		(78, 221),
		(78, 222),
		(78, 223)

INSERT INTO Books
VALUES	('Anne Frank''s Story', 'Carol Ann Lee', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fbio%2Fbio1.jpg?alt=media&token=4c9cf873-9978-46cd-aa3f-3eb50582facb&_gl=1*1douo24*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAzMDIuMzkuMC4w', 131000, 10, null, 1),
		('Waging Heavy Peace: A Hippie Dream', 'Neil Young', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fbio%2Fbio2.jpg?alt=media&token=d844aecd-4272-4375-83ee-2649a2b2a3e4&_gl=1*3x1l6x*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAzMTUuMjYuMC4w', 136000, 10, null, 1),
		('Hard Pushed: A Midwife’s Story', 'Leah Hazard', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fbio%2Fbio3.jpg?alt=media&token=2e958378-ffec-46bc-91bb-93d0b0cdb0dc&_gl=1*1qlptux*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAzMjYuMTUuMC4w', 149000, 10, null, 1),
		('Eat, Pray, Love: One Woman''s Search for Everything Across Italy, India and Indonesia (International Export Edition)', 'Elizabeth Gilbert', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fbio%2Fbio4.jpg?alt=media&token=01fc2225-ca01-4509-9eb0-a1225fb7439c&_gl=1*1qme1vn*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjAzMzguMy4wLjA.', 150000, 10, null, 1)

insert into Cat
values	(79, 224),
		(79, 225),
		(79, 226),
		(79, 227)

INSERT INTO Books
VALUES	('The Art of Thinking Clearly', 'Rolf Dobelli', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsocial%2Fsocial1.jpg?alt=media&token=9b906159-2d7e-4cec-8684-ae0664cb5170&_gl=1*1bhkr9q*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA1NzQuNDMuMC4w', 143000, 10, null, 1),
		('Leaders Eat Last', 'Simon Sinek', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsocial%2Fsocial2.jpg?alt=media&token=72b200e8-94e2-4fcb-9a20-45e209a7c5af&_gl=1*1ibmnf2*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA1ODYuMzEuMC4w', 281000, 10, null, 1),
		('Why We Sleep: The New Science of Sleep and Dreams', 'Matthew Walker', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsocial%2Fsocial3.jpg?alt=media&token=20d21b86-39c0-4cf9-9352-2da8cf6552d3&_gl=1*i8ffvc*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA1OTkuMTguMC4w', 281000, 10, null, 1),
		('Emotional Intelligence (Exp)', 'Daniel Goleman', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsocial%2Fsocial4.jpg?alt=media&token=23dbf7e7-a1df-45a4-b6cd-a52296bcb808&_gl=1*d93vvd*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA2MTIuNS4wLjA.', 162000, 5, null, 1)

insert into Cat
values	(80, 228),
		(80, 229),
		(80, 230),
		(80, 231)

INSERT INTO Books
VALUES	('What If?: Serious Scientific Answers to Absurd Hypothetical Questions', 'Randall Munroe', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsiciene%2Fsiciene1.jpg?alt=media&token=40646a09-d509-4d28-8cf9-cdb51d594d6f&_gl=1*1a2zorc*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA4MzguNS4wLjA.', 281000, 5, null, 1),
		('Freakonomics', 'Steven D. Levitt, Stephen J. Dubner', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsiciene%2Fsiciene2.jpg?alt=media&token=dbe27c85-1c2c-4c9e-81b9-973e8f30d24e&_gl=1*qolf8n*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA4NTIuNjAuMC4w', 143000, 5, null, 1),
		('How To Avoid A Climate Disaster: The Solutions We Have And The Breakthroughs We Need', 'Bill Gates', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsiciene%2Fsiciene3.jpg?alt=media&token=f941be63-bf2d-47ac-afc5-9a78c360c025&_gl=1*brnc7q*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA4NjMuNDkuMC4w', 238000, 10, null, 1),
		('How Science Works', 'DK', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Fsiciene%2Fsiciene4.jpg?alt=media&token=941676a4-efa4-4dfd-8d93-57ae59221c00&_gl=1*15jmikl*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MjA4NzYuMzYuMC4w', 471000, 5, null, 1)

insert into Cat
values	(81, 232),
		(81, 233),
		(81, 234),
		(81, 235)

INSERT INTO Books
VALUES	('Homemade Presents', 'Marlies Busch', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffood%2Ffood1.jpg?alt=media&token=6af0240c-95ad-49db-addf-ea1bd20465d1&_gl=1*121dpk9*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQyNDEzMi4zNC4xLjE2OTg0MjQxNTMuMzkuMC4w', 456000, 5, null, 1),
		('Japan! - Japanese Cuisine for Beginners', 'Laure Kié', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffood%2Ffood2.jpg?alt=media&token=55578683-4eb3-42ef-884c-af270b227ebf&_gl=1*1vgm5ah*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQyNDEzMi4zNC4xLjE2OTg0MjQxNjYuMjYuMC4w', 420000, 5, null, 1),
		('Green Juices for Beginners', 'Carla Zaplana', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffood%2Ffood3.jpg?alt=media&token=52086f83-84c5-42ec-a434-09461bec74e8&_gl=1*3t08se*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQyNDEzMi4zNC4xLjE2OTg0MjQxODEuMTEuMC4w', 420000, 10, null, 1),
		('Global Spices for Everyday Cooking', 'Sarah Golbaz, Hellmut Wagner', 'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fbook%2Ffood%2Ffood4.jpg?alt=media&token=72e2ea68-1b72-4ec3-9225-2cee1460b1f1&_gl=1*ndjoap*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQyNDEzMi4zNC4xLjE2OTg0MjQxOTIuNjAuMC4w', 480000, 5, null, 1)

insert into Cat
values	(82, 236),
		(82, 237),
		(82, 238),
		(82, 239)

--insert tools

--Phương
insert into SchoolTools
values	(N'Bút Gel EnerGel Kawaii Pixel Art 0.5 mm - Pentel BLN75KW39-C - Neko - Mực Xanh',N'Pentel','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutbi1.jpg?alt=media&token=8b6d7665-9fd3-4afc-8152-9e8e33ca550a&_gl=1*v4rdvb*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTMwOTcuNjAuMC4w',60000,10,N'Bút Bi Gel EnerGel Kawaii Pixel Art 0.5mm được thiết kế vừa tay, dễ cầm, dễ viết dù trên mặt phẳng ngang hay thẳng đứng. Bút viết êm với mực gel mau khô, ra mực đều và đẹp giúp bạn không gặp vấn đề như gai, tắc mực và lem ngoài ý muốn. Ngòi 0.5mm cho nét chữ rõ ràng, lướt rất êm trên giấy, tiện lợi khi phải viết nhiều. Với miếng lót mềm cách đầu viết khoảng 1cm để tay cầm thêm êm ái và thoải mái hơn.',2,83),
		(N'Bút Gel EnerGel Kawaii Pixel Art 0.5 mm - Pentel BLN75KW40-C - Daruma - Mực Xanh',N'Pentel','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutbi2.jpg?alt=media&token=feeaee9e-4bec-4d9e-8a3b-1fccbe3d3f5d&_gl=1*hysojq*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTMxMTcuNDAuMC4w',60000,10,N'Bút Bi Gel EnerGel Kawaii Pixel Art 0.5mm được thiết kế vừa tay, dễ cầm, dễ viết dù trên mặt phẳng ngang hay thẳng đứng. Bút viết êm với mực gel mau khô, ra mực đều và đẹp giúp bạn không gặp vấn đề như gai, tắc mực và lem ngoài ý muốn. Ngòi 0.5mm cho nét chữ rõ ràng, lướt rất êm trên giấy, tiện lợi khi phải viết nhiều. Với miếng lót mềm cách đầu viết khoảng 1cm để tay cầm thêm êm ái và thoải mái hơn.',2,83),
		(N'Bộ 6 Bút EnerGel Kawaii Pixel Art 0.5 mm - Pentel BLN75KW6-6S2 - Mực Xanh',N'Pentel','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutbi3.jpg?alt=media&token=6065052f-9a4b-4122-8c25-ae7a2533e118&_gl=1*10y17zp*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTMxMzcuMjAuMC4w',358000,10,N'Bút Bi Gel EnerGel Kawaii Pixel Art 0.5mm được thiết kế vừa tay, dễ cầm, dễ viết dù trên mặt phẳng ngang hay thẳng đứng. Bút viết êm với mực gel mau khô, ra mực đều và đẹp giúp bạn không gặp vấn đề như gai, tắc mực và lem ngoài ý muốn. Ngòi 0.5mm cho nét chữ rõ ràng, lướt rất êm trên giấy, tiện lợi khi phải viết nhiều. Với miếng lót mềm cách đầu viết khoảng 1cm để tay cầm thêm êm ái và thoải mái hơn.',2,83),
		(N'Hộp 20 Bút Bi Pro 027 0.5 mm - Thiên Long TL-105 - Mực Đen',N'Thiên Long','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutbi4.jpg?alt=media&token=50b5bd1d-6b9b-4caa-a705-b3301ef7e970&_gl=1*9w70no*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTMxNTIuNS4wLjA.',130000,5	,N'Mực êm trơn, đều, mượt, không chảy mực. Lực kẹp giắt chắc chắn, có thể cài được sổ bìa dày 3 mm. Ngòi 0.5mm cho nét chữ rõ ràng, lướt rất êm trên giấy, tiện lợi khi phải viết nhiều. Cơ cấu bấm sáng tạo, tự thu ngòi khi cài bút vào tập - túi áo - sổ.',2,83),
		(N'Bút Bic 10 Màu Bear Cheese 0.7 mm - Kuki KK-7493-MD-TK - Thân Bút Màu Vàng',N'KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutbi5.jpg?alt=media&token=a9627805-e0ba-4168-b9cb-ac1579280755&_gl=1*14ko3tr*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTMxNzEuNjAuMC4w',26000,5	,N'Bút gồm 10 màu mực nguyên chất không pha loãng, không độc hại, an toàn cho người sử dụng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,83),

		(N'Hộp 10 Bút Gel Màu FlexOffice FO-GELB056',N'Flexoffice','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutgel1.jpg?alt=media&token=c5edf36d-a26c-4140-b6f5-d7b1fba80e6e&_gl=1*18x518o*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTM2NDMuNDIuMC4w',109000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,84),
		(N'Bút Gel Bium 0.38 mm - Glory Morning 32301-89411 - Mực Đen - Thân Bút Màu Đen',N'Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutgel2.jpg?alt=media&token=c237817d-c2c2-40b5-8d5d-759893cfa12e&_gl=1*63159t*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTM3MDIuNjAuMC4w',21000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,84),
		(N'Bút Gel Bium 0.38 mm - Glory Morning 32301-89411 - Mực Đen - Thân Bút Màu Trắng',N'Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutgel3.jpg?alt=media&token=67000f38-f1f7-4d44-a104-a7ee813a48cb&_gl=1*5m52u3*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTM3MjkuMzMuMC4w',21000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,84),
		(N'Bút Gel Lắc Halloween Kawaii Shaker 0.5 mm - Kuki KK-7483-HLW-23 - Mực Xanh - Con Dơi Đen',N'KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutgel4.jpg?alt=media&token=f1210efe-ebea-4a61-b515-6edba2ec9c2f&_gl=1*7g3x6m*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTM3NjIuNjAuMC4w',29000,15,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,84),
		(N'Bút Gel Massage Hình Thú 0.5 mm - Kuki KK-7491-MD-TK - Mực Xanh - Chó Shiba Vàng',N'KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutgel5.jpg?alt=media&token=11c1700f-651b-4aa0-94f0-b31162dd4e96&_gl=1*evkrbs*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTM3ODAuNDIuMC4w',27000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,84),

		(N'Viết Máy Kim Thành 39 - Thân Bút Màu Đỏ',N'Kim Thành','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutmay1.jpg?alt=media&token=789ebcf6-9b33-4b16-b630-83e6e6387857&_gl=1*1igjov1*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQwNDguNDcuMC4w',48000,10,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,85),
		(N'Bút Mài Ánh Dương AD 040 - Nắp Màu Xanh Lá',N'Ánh Dương','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutmay2.jpg?alt=media&token=d9ff253c-280f-4ce3-a545-d93bf68c23f2&_gl=1*1xxny9f*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQwNjMuMzIuMC4w',130000,10,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,85),
		(N'Bút Máy Xóa Được M060 - Màu Trắng',N'OEM','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutmay3.jpg?alt=media&token=3c1f5173-8d4a-4836-9228-c478d8213cd9&_gl=1*1trwz7r*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQwNzUuMjAuMC4w',48500,10,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,85),
		(N'Bút Máy Xóa Được 169-187 - Màu Xanh Dương - Mực Tím',N'OEM','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutmay4.jpg?alt=media&token=af7ed56d-1198-4ff6-8462-a91209f04a45&_gl=1*bykpbw*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQwODkuNi4wLjA.',47000,10,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,85),
		(N'Bút Máy Xóa Được L016-292 - Màu Hồng - Mực Xanh (Mẫu Họa Tiết Giao Ngẫu Nhiên)',N'OEM','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutmay5.jpg?alt=media&token=92f81e66-5dbb-4695-95bd-53ba48a40a03&_gl=1*ae45mm*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQxMDguNjAuMC4w',47000,10,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,85),

		(N'Bút Dạ Quang - Thiên Long HL-03 - Màu Hồng',N'Thiên Long','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutquang1.jpg?alt=media&token=a57d045a-a22d-4aaf-9b57-4dad9836133f&_gl=1*on08bi*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQzODMuNDguMC4w',10000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,86),
		(N'Bộ 6 Bút Đánh Dấu Ghi Chú Nhiều Họa Tiết - DM-7008-6',N'Megatoys','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutquang2.jpg?alt=media&token=0513cc34-8330-44ec-a1b5-82e9615fa4df&_gl=1*z4uik0*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQzOTguMzMuMC4w',44000,20,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,86),
		(N'Vỉ 2 Bút Dạ Quang - Marvy HL50 - Fluorescent Violet',N'Marvy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutquang3.jpg?alt=media&token=f949394a-e11f-479d-a8ff-3b68aa50bac2&_gl=1*2yj7qj*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ0MTIuMTkuMC4w',31000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,86),
		(N'Vỉ 2 Bút Dạ Quang - Marvy HL55 - Pastel Blue',N'Marvy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutquang4.jpg?alt=media&token=7b933d24-3417-407e-9535-efb66c095364&_gl=1*asekrb*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ0MjUuNi4wLjA.',21500,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,86),
		(N'Bút Dạ Kim Luxor 15310 - Màu Hồng',N'Luxor','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutquang5.jpg?alt=media&token=4c9a6f18-febe-4ec0-977d-1e7a87534a07&_gl=1*wemvr6*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ0NDAuNjAuMC4w',6500,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,86),

		(N'Bút Chì Bấm Jedo 0.5 mm - Morning Glory 32060-44802 - Màu Đen',N'Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutchi1.jpg?alt=media&token=f861c800-0cd8-4a23-88be-8a25a0f8e60a&_gl=1*1jyovn5*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ2OTEuNDEuMC4w',20000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,87),
		(N'Bút Chì Bấm Halloween Kawaii 0.5 mm - Kuki KK-7484-HLW-23 - Con Ma Trắng',N'KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutchi2.jpg?alt=media&token=df637868-cd85-4056-b42b-f613935358d9&_gl=1*1xejumk*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ3MDkuMjMuMC4w',28000,15,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,87),
		(N'Bút Chì Bấm Bear Cheese - Kuki KK-7489-MD-TK - Màu Nâu',N'KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutchi3.jpg?alt=media&token=0e93524f-f511-45dd-9270-395229ec382a&_gl=1*1j8uwdu*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ3MjEuMTEuMC4w',26000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,87),
		(N'Vỉ 2 Bút Chì Bấm 0.5 mm - Marvy MS205 - Màu Xanh',N'Marvy','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutchi4.jpg?alt=media&token=c2e4469c-22bf-4285-b6e4-f1a73bc7def2&_gl=1*198f3xn*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ3MzUuNjAuMC4w',36000,5,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,87),
		(N'Bút Chì Bấm Liner 0.5 mm - Radius',N'RADIUS','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fbutviet%2Fbutchi5.jpg?alt=media&token=ab14aea8-6e25-4817-857f-97ea38ace15e&_gl=1*1atc6bh*_ga*MjkwMjk5NzA4LjE2OTU5NzU1NjA.*_ga_CW55HF8NVT*MTY5ODQxMjk2My4zMy4xLjE2OTg0MTQ3NDkuNDYuMC4w',7500,20,N'Thiết kế với thân 10 tone màu pastel bắt mắt, với thiết kế đơn giản, hợp thời trang, hợp xu hướng. Màu mực đậm, tươi, thích hợp sử dụng trên nhiều chất liệu giấy khác nhau. Ngòi bút 0.7mm cho nét viết đều, thanh mảnh và liên tục.',2,87)

--Tuấn
insert into SchoolTools
values	(N'Gôm Tẩy Iwako Hình Động Vật Biển - Lươn Vườn','iwako',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2F6941288745815-mau3.jpeg?alt=media&token=0307dfbf-6be9-4b56-94b4-a7cbabd484db&_gl=1*1hfpagz*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUwOTcyMC4zMi4wLjA.',13.500,5,null,2,88),
		(N'Gôm 3D Bear Cheese - Kuki KK-7714-MD-TK - Gấu Vàng','iwako',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgom2.jpeg?alt=media&token=8be02d25-71ee-4c00-9575-142a7a8b8658&_gl=1*1oofio8*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDEzOS42MC4wLjA.',24.700,5,null,2,88),
		(N'Gôm 3D Bear Cheese - Kuki KK-7714-MD-TK - Gấu Nâu Phô Mai','iwako',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgom3.jpeg?alt=media&token=21ca062d-2b47-42dc-be2e-6259adb9d7d8&_gl=1*11tnivc*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDI2OS41OS4wLjA.',24.700,5,null,2,88),
		(N'Bộ 3 Gôm Mini Bear Cheese - Kuki KK-7531-MD-TK','iwako',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgom3.jpeg?alt=media&token=21ca062d-2b47-42dc-be2e-6259adb9d7d8&_gl=1*11tnivc*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDI2OS41OS4wLjA.',16.150,5,null,2,88),

		(N'Hộp Chuốt Chì Bear Cheese - Kuki KK-7920-MD-TK - Màu Nâu','KUKI',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgotbutchi.jpeg?alt=media&token=44d6f51f-48bd-4e00-9c40-e6dd81cb9492&_gl=1*156eg9j*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDU2Ny40OS4wLjA.',24.700,5,null,2,89),
		(N'Hộp Chuốt Chì Bear Cheese - Kuki KK-7920-MD-TK - Màu Vàng','KUKI',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgotbutchi2.jpeg?alt=media&token=e4f1838b-1c94-4455-8299-84da667a9848&_gl=1*1cyp6yj*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDYyNC42MC4wLjA.',24.700,5,null,2,89),
		(N'Chuốt Chì Bear Cheese - Kuki KK-7488-MD-TK - Màu Vàng','KUKI',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgotbutchi3.jpeg?alt=media&token=41097775-20ec-47eb-accc-d52653b08973&_gl=1*8u4awa*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDU5NC4yMi4wLjA.',24.700,5,null,2,89),
		(N'Chuốt Chì Bear Cheese - Kuki KK-7488-MD-TK - Màu Nâu','KUKI',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fgotbutchi4.jpeg?alt=media&token=4700c112-7811-4cb3-abb1-5b9263017c7e&_gl=1*1u8kseu*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDYzMy41MS4wLjA.',24.700,5,null,2,89),

		(N'Thước Kẻ 20 cm Radius - Màu Hồng','RADIUS',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fthuoc.jpeg?alt=media&token=5d1de3f1-8704-479b-8bb5-014634125f30&_gl=1*10cscwu*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTEyNC40Ny4wLjA.',6.175,5,null,2,90),
		(N'Thước Kẻ 20 cm Radius - Màu Xanh ','RADIUS',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fthuoc2.jpeg?alt=media&token=27fbf7b8-e5b5-43c3-a1f7-5d6fc7db16b1&_gl=1*y06rgo*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTEzNi4zNS4wLjA.',6.175,5,null,2,90),
		(N'Thước Kẻ 20 cm Radius - Trong Suốt','RADIUS',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fthuoc3.jpeg?alt=media&token=9d45d8e2-540d-4c77-83f8-2fac75d0fa10&_gl=1*vxmfwy*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTE0OS4yMi4wLjA.',6.175,5,null,2,90),
		(N'Thước Thẳng 20 cm Disney Winnie The Pooh - Thiên Long',N'Thiên long',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fthuoc4.jpeg?alt=media&token=bcb24cae-ebad-4cd5-9959-a7861250aab5&_gl=1*1h7b0pc*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTE2Mi45LjAuMA..',8.175,5,null,2,90),

		(N'Bóp Viết Nylon - Morning Glory 36010-89076 - Màu Xám','Morning Glory',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbopviet.jpeg?alt=media&token=bcbc643f-bb5b-443c-8938-a0252d6a5d1d&_gl=1*nbaz01*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDg2NS4yMS4wLjA.',85.500,5,null,2,91),
		(N'Bóp Viết Nylon - Morning Glory 36010-89076 - Màu Đen','Morning Glory',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbopviet2.jpeg?alt=media&token=1503abaf-1ec9-4172-9dca-2ae08ad1fa8f&_gl=1*tw1zlh*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDg3Ny45LjAuMA.',65.500,5,null,2,91),
		(N'Bộ Dụng Cụ Học Tập Kèm Hộp Bút Bẻ Đôi 5 Món - Disney','Morning Glory',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbopviet3.jpeg?alt=media&token=35914d39-08ca-4f79-b12b-8779ac35b6d9&_gl=1*1bnxlpn*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDg4Ny42MC4wLjA.',137.750,5,null,2,91),
		(N'Hộp Bút Kèm Dụng Cụ Học Tập 10 Món - Disney Frozen ','Morning Glory',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbopviet4.jpeg?alt=media&token=ac150aa9-f158-452d-bcda-82db9c2dfcda&_gl=1*h0r5pp*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMDkwMS40Ni4wLjA.',280.250,5,null,2,91),

		(N'Bìa Nút Pazto Màu Pastel F4 Flexoffice FO-CBF010 - Hồng','HooHooHaHa',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbiafile.jpeg?alt=media&token=632d63b0-d6f2-41c4-9e9c-909cba04467f&_gl=1*1h9uqo5*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTMwMi40OC4wLjA.',6.175,5,null,2,92),
		(N'Bìa Nút Pazto Màu Pastel F4 Flexoffice FO-CBF010','HooHooHaHa',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbiafile1.jpeg?alt=media&token=f123d025-9293-4036-86fd-afccf520f184&_gl=1*6nz1dy*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTMxNC4zNi4wLjA.',6.175,5,null,2,92),
		(N'TBìa Nút Pazto Màu Pastel A4 Flexoffice FO-CBF009','HooHooHaHa',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbiafile2.jpeg?alt=media&token=34805d05-ab64-4275-bf60-ff1801842f22&_gl=1*12it0su*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTMyMy4yNy4wLjA.',5.175,5,null,2,92),
		(N'Bìa Nút Pazto Màu Pastel F4 Flexoffice FO-CBF010','HooHooHaHa',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fbiafile3.jpeg?alt=media&token=d871b742-f3d1-46b0-9c6b-fa6b00505ed5&_gl=1*1xm0let*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTMzNC4xNi4wLjA.',11.175,5,null,2,92),

		(N'Túi 12 Kim Kẹp Giấy 38 mm - languo LG-70784 - Màu Đồng','languo',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fkepgiay.jpeg?alt=media&token=74b0caeb-0e21-40a6-a75c-b3942f5351d0&_gl=1*xrri9y*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTQ3Mi40Ni4wLjA.',28.500,5,null,2,93),
		(N'Túi 12 Kim Kẹp Giấy 38 mm - languo LG-70784 - Màu Vàng','languo',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fkepgiay1.jpeg?alt=media&token=e92055d7-5bc2-4eb2-be79-ec568de96c11&_gl=1*5pb2v7*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTQ4Ny4zMS4wLjA.',28.500,5,null,2,93),
		(N'Túi 12 Kim Kẹp Giấy 38 mm - languo LG-70784 - Màu Bạc','languo',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fkepgiay3.jpeg?alt=media&token=5a9e97c7-65a3-46be-86c8-d71f7dfee286&_gl=1*18ywau8*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTQ5OC4yMC4wLjA.',28.500,5,null,2,93),

		(N'Bấm Ghim Lớn Số 12 Xoay 360° - Deli E0434 - Màu Trắng','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fdobamkim.jpeg?alt=media&token=eb6ac8a7-56c2-4a3f-8f43-a536be1edf29&_gl=1*1f8q2fi*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTY0OC40NC4wLjA.',89.300,5,null,2,94),
		(N'Bấm Kim Số 3 - Officetex OT-SL03003 - Màu Đen','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fdobamkim1.jpeg?alt=media&token=959c638a-029a-41ff-8c56-4dde79197642&_gl=1*frlahx*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTY2MS4zMS4wLjA.',45.900,5,null,2,94),
		(N'Hộp Kim Bấm Số 10 - Plus 30-122VN','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fdobamkim2.jpeg?alt=media&token=a78338a6-f0a7-4bcb-876c-91dda19f80ec&_gl=1*1p9di5h*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTY3MS4yMS4wLjA.',8.500,5,null,2,94),

		(N'Khay Cắm Bút Deli 9154 - Màu Xanh Lá','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fcambut.jpeg?alt=media&token=ec35b8db-c35a-43b2-91de-a6d7ce5c0b07&_gl=1*ash659*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTg4NC41LjAuMA.',143.450,5,null,2,95),
		(N'Khay Cắm Bút Deli 9154 - Màu Cam','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fcambut1.jpeg?alt=media&token=8ccf2c29-3335-44f0-9263-44fbc903ae90&_gl=1*mpw2nr*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTkwMy42MC4wLjA.',143.450 ,5,null,2,95),
		(N'Cắm Bút Deli 3 Ngăn - Phiên Bản Sơn Tùng M-TP ','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20hoc%20sinh%2Fcambut2.jpeg?alt=media&token=9753fb3d-a219-4755-a670-bec4e6e6cbe8&_gl=1*1hhlkpr*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMTkxNC40OS4wLjA.',53.600,5,null,2,95),

		(N'Hộp 12 Bút Lông Màu Super Wings - Deli EC150-12','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fbutve.jpeg?alt=media&token=e26c17d0-8d2e-4b40-83c6-6f6c86cb00a3&_gl=1*16hx7eb*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjE3Ni40Ny4wLjA.',42.750,5,null,2,96),
		(N'Hộp 24 Bút Chì Màu Tropical Jungle - Clever Hippo','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fbutve2.jpeg?alt=media&token=d4348c9e-968f-4a5c-843d-7874e783ed39&_gl=1*1vb4k9l*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjE4OS4zNC4wLjA.',89.100 ,5,null,2,96),
		(N'Bộ 6 Bút Lông Màu Nước 2 Đầu - Brush Sign Pen Twin ','Deli',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fbutve3.jpeg?alt=media&token=254cae6d-196d-45d1-bfe2-71cd15e60696&_gl=1*1slizlm*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjIwMS4yMi4wLjA.',94.500,7,null,2,96),

		(N'Bộ 12 Màu Nước 20 ml Kèm Cọ Vẽ - Stacom POS2012C','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fmauve.jpeg?alt=media&token=45d47a6a-8e1d-4037-a122-829aabd7a030&_gl=1*ucg3x8*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjMxMi41Mi4wLjA.',57.600,8,null,2,97),
		(N'Tuýp Màu Acrylic 75 ml - Keyroad KR972219 - Màu Đỏ','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fmauve1.jpeg?alt=media&token=85ffa571-b6cb-4dac-a0ea-1ec582e84c33&_gl=1*1q3qnor*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjMyNC40MC4wLjA.',26.600 ,5,null,2,97),
		(N'Tuýp Màu Acrylic 75 ml - Keyroad KR972218 ','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fmauve2.jpeg?alt=media&token=4e6d79f7-2448-49d1-a19e-3fe4c7f8ebee&_gl=1*ojfvz2*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjMzNy4yNy4wLjA.',26.600,5,null,2,97),

		(N'Bộ 4 Cọ Vẽ Grip Màu Pastel - Faber-Castell 481620','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fkhaycove.jpeg?alt=media&token=b333faa4-a0f2-4987-ba1a-721b95e59931&_gl=1*gii24n*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjQ4OS41Mi4wLjA.',91.200,5,null,2,98),
		(N'Bộ 4 Cọ Vẽ Grip Màu Light - Faber-Castell 481600','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fkhaycove1.jpeg?alt=media&token=22e2ed38-f454-4de0-b30e-c6377b185741&_gl=1*1dmuiif*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjUwMS40MC4wLjA.',90.250,5,null,2,98),
		(N'Bộ 10 Cây Cọ Vẽ Màu Nước - Colormate 113004','Faber-Castell',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Fkhaycove2.jpeg?alt=media&token=566a37d1-e436-4044-a646-02de8df87f34&_gl=1*6e0g4e*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjUxMC4zMS4wLjA.',157.500,6,null,2,98),

		(N'Bộ 4 Cọ Vẽ Grip Màu Pastel - Faber-Castell 481620','DREAMNIE',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Ftapve.jpeg?alt=media&token=52113cb9-72c0-48ee-94da-beb0517383bb&_gl=1*o96l6b*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjYxMC40NC4wLjA.',33.250,7,null,2,99),
		(N'Bộ 4 Cọ Vẽ Grip Màu Light - Faber-Castell 481600','DREAMNIE',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Ftapve1.jpeg?alt=media&token=3675212c-d861-4d58-b6cc-0d2d388cca1e&_gl=1*1qxqk2i*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjYyMy4zMS4wLjA.',33.250,5,null,2,99),
		(N'Bộ 10 Cây Cọ Vẽ Màu Nước - Colormate 113004','DREAMNIE',N'https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2Fdungcu%2Fdung%20cu%20ve%2Ftapve2.jpeg?alt=media&token=194b637d-30d6-4a6f-a76f-3f8d67f3984b&_gl=1*1r1hp5f*_ga*MTE0OTcwMzU2MC4xNjk2MjYwMTE1*_ga_CW55HF8NVT*MTY5ODUwODMxNi44LjEuMTY5ODUxMjYzNy4xNy4wLjA.',33.250,7,null,2,99)

--trọng
insert into SchoolTools
values	(N'Lốc 5 Tập Kẻ Ngang 80 Trang 70 gsm','Hải Tiến','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Ftap1.jpg?alt=media&token=9f022d29-bbba-4b77-a52c-32219b1908f6&_gl=1*1uluyi6*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMDA3Mi4yLjEuMTY5ODQwMTQwOS4xMi4wLjA.',65500,7,null,2,100),
		(N'Vở B5 Kẻ Ngang 200 Trang 70gsm + Kèm Sticker Composition Collection','Crabit Notebuck','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Ftap2.jpg?alt=media&token=cfe97220-733e-43b3-9bdf-5a2bc1933a6e&_gl=1*u875g1*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMDA3Mi4yLjEuMTY5ODQwMTQxMi45LjAuMA..',53200,7,null,2,100),
		(N'Combo 5 Tập Học Sinh 96 Trang 100gsm Măng Non - Thành Đạt','Thành Đạt','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Ftap3.jpg?alt=media&token=5310e4ac-d080-444e-9151-3b7be5349774&_gl=1*3fx39u*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMDA3Mi4yLjEuMTY5ODQwMTQyMi42MC4wLjA.',58500,7,null,2,100),
		(N'Combo 5 Tập Hopeful Ô Ly 48 Trang ĐL 100g/m2','Campus','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Ftap4.jpg?alt=media&token=939bca73-a922-4324-bdbe-d702f439664b&_gl=1*1m6u4h*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMDA3Mi4yLjEuMTY5ODQwMTQyNy41NS4wLjA.',45500,7,null,2,100),
		(N'Combo 5 Tập Kẻ Ngang 80 Trang ĐL 70g/m2 - Crabit Notebuck','Crabit Notebuck','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Ftap5.jpg?alt=media&token=b8749c1e-5f2f-40db-be8f-252d672bccee&_gl=1*11rqqxl*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMDA3Mi4yLjEuMTY5ODQwMTQzMi41MC4wLjA.',70500,7,null,2,100),
		
		(N'Sổ Bìa Da A5 Cyber Punk The Sun 04 + Bút Bi E886','The Sun','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fsaotay1.jpg?alt=media&token=d83b3708-4fff-4100-8a73-fd6a95a7a5a8&_gl=1*18mvo3e*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwMzgxOC4zNS4wLjA.',345500,7,null,2,101),
		(N'Sổ Kế Hoạch 52 Tuần SDstationery - Treasure The Journey - Pink','SDstationery','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fsaotay2.jpg?alt=media&token=1f8fded4-d595-491e-9046-85fdb20405aa&_gl=1*hh1bgu*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwMzgxNS4zOC4wLjA.',123500,7,null,2,101),
		(N'Sổ Kế Hoạch 52 Tuần SDstationery - Treasure The Journey - Blue','SDstationery','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fsaotay3.jpg?alt=media&token=42c872ca-8b1d-4d77-a57f-62e863452305&_gl=1*bzj894*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwMzgxMS40Mi4wLjA.',123500,7,null,2,101),
		(N'Sổ Kế Hoạch 52 Tuần SDstationery - Treasure The Journey - Mint','SDstationery','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fsaotay4.jpg?alt=media&token=f9e9c10e-3ce5-427d-97a0-662f923f05a6&_gl=1*14c5ybh*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwMzgwNy40Ni4wLjA.',123500,7,null,2,101),
		(N'Sổ Bìa Da Kẻ Ngang 288-25 - Màu Đen','OEM','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fsaotay5.jpg?alt=media&token=9576ab1b-5b13-4751-b49f-2f773d7a0a89&_gl=1*7jwe7y*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwMzgwMS41Mi4wLjA.',85500,7,null,2,101),

		(N'Giấy Photo A4 IK Yellow 70 gsm (500 Tờ)','IK','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fphoto1.jpg?alt=media&token=e79cd694-f55d-4a30-966c-177da7383dcc&_gl=1*lj99ou*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDA2NC40OS4wLjA.',405500,7,null,2,102),
		(N'Giấy Photo Paper One A5 70gsm (500 Tờ) (Mẫu Bao Bì Giao Ngẫu Nhiên)','Paper One','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fphoto2.jpg?alt=media&token=e683a354-64a6-4b42-8566-0c7b5d380de2&_gl=1*1l2wmdz*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDA2MS41Mi4wLjA.',40550,7,null,2,102),
		(N'Giấy Photo A4 80gsm - Paper One (500 Tờ)','Paper One','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fphoto3.jpg?alt=media&token=3a3c22e8-0dfe-41b0-ad72-44b7bc41b346&_gl=1*1cvdzjm*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDA1OC41NS4wLjA.',105500,7,null,2,102),
		(N'Giấy photo Double A A4/80 gsm','Double A','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fphoto4.jpg?alt=media&token=d7114583-3fdc-4633-9243-87029deb5cb9&_gl=1*crn4cm*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDA1NS41OC4wLjA.',105500,7,null,2,102),
		(N'Giấy Photo Double A A4 70 gsm','Double A','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fphoto5.jpg?alt=media&token=bd02f1bc-1273-43d5-8da6-9a3188465e26&_gl=1*jf95gd*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDA1My42MC4wLjA.',85500,7,null,2,102),

		(N'Giấy Note 70 x 70 mm - Motto CYSSC70-BL - Màu Xanh Biển (40 Tờ)','Motto','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fnote1.jpg?alt=media&token=ea7925d8-dcb0-43dc-8129-ef5553ea958b&_gl=1*klin9f*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDM3Ni4zOC4wLjA.',25500,7,null,2,103),
		(N'Giấy Note 3 Màu 70 x 20 mm - Motto CYSS20-AS (40 Tờ)','Motto','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fnote2.jpg?alt=media&token=68cb52c2-daae-47d9-a486-b15a27a4ad1a&_gl=1*1y7weaa*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDM3My40MS4wLjA.',24500,7,null,2,103),
		(N'Giấy Note Motto 70 x 70 mm - Motto CYSSC70-YE - Màu Vàng (40 Tờ)','Motto','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fnote3.jpg?alt=media&token=4a4c92c7-cae2-471e-898b-4b0ded73948f&_gl=1*1pqsl47*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDM3MC40NC4wLjA.',25600,7,null,2,103),
		(N'Giấy Note 70 x 70 mm - Motto CYSSC70-PK - Màu Hồng (40 Tờ)','Motto','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fnote4.jpg?alt=media&token=4e119fe7-168e-409e-b179-2ed0531d8edf&_gl=1*1p2dq3j*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDM2Ni40OC4wLjA.',25500,7,null,2,103),
		(N'Giấy Ghi Chú Amuro 70 x 70 mm - Tagger','TAGGER','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fsanphamveigay%2Fnote5.jpg?alt=media&token=f344bbc0-965f-4087-a5a3-51d6e9c44ff6&_gl=1*t76fjt*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDM1NC42MC4wLjA.',31500,7,null,2,103),

		(N'Dao Rọc Giấy Mini - Besta DRG-001 - Màu Hồng','BESTA','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fcatgiay1.jpg?alt=media&token=ac3a3041-d7dd-4b2e-9c47-ac118fc731c2&_gl=1*101aubg*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDcyMi40MC4wLjA.',11500,7,null,2,104),
		(N'Dao Rọc Giấy Mini - Besta DRG-001 - Màu Trắng','BESTA','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fcatgiay2.jpg?alt=media&token=b0a6c56c-2e7d-4363-8b22-8bea1937afbd&_gl=1*13flocd*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDcyMC40Mi4wLjA.',11400,7,null,2,104),
		(N'Vỉ Kéo Keyroad KR972561 - Màu Xanh','KEYROAD','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fcatgiay3.jpg?alt=media&token=d89920fc-30b8-4141-906e-7b405ab49b14&_gl=1*u1vg4v*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDcxNy40NS4wLjA.',38500,7,null,2,104),
		(N'Vỉ Kéo Keyroad KR972561 - Màu Tím','KEYROAD','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fcatgiay4.jpg?alt=media&token=5b7c5b05-739c-45f4-b46d-8f7413ee8204&_gl=1*1nses5d*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDcxMy40OS4wLjA.',38500,7,null,2,104),
		(N'Vỉ Kéo Keyroad KR972539 - Màu Tím','KEYROAD','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fcatgiay5.jpg?alt=media&token=f58b9ed5-e1ab-4ec1-9d5f-fd842b63f92f&_gl=1*j4pu4b*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNDcxMC41Mi4wLjA.',36500,7,null,2,104),

		(N'Bộ 2 Băng Keo Trong Suốt OPP 20 * 80 Yards - Song Lan','Song Lan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fkeo1.jpg?alt=media&token=6c0f403f-094f-4483-98f8-a9b93d85670c&_gl=1*na4jo3*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTA3Ny4zNy4wLjA.',19500,7,null,2,105),
		(N'Bộ 2 Băng Keo 2 Mặt 10 mm x 24 Yards - Song Lan - Màu Trắng','Song Lan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fkeo2.jpg?alt=media&token=a305d016-53c9-4236-a645-3a7c8dd350fa&_gl=1*b7t924*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTA3Mi40Mi4wLjA.',12500,7,null,2,105),
		(N'Băng Keo Vàng 48 mm x 80 Yards - Song Lan','Song Lan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fkeo3.jpg?alt=media&token=9c92476f-68f1-465c-a576-f74ac7ff8a04&_gl=1*1ivcm8f*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTA2Ny40Ny4wLjA.',21500,7,null,2,105),
		(N'Băng Keo Màu Simili 70 mm x 12 Yards - Song Lan - Màu Đỏ','Song Lan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fkeo4.jpg?alt=media&token=73e44f19-c3bf-4890-9979-62c505848b42&_gl=1*m35o5o*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTA2MS41My4wLjA.',27500,7,null,2,105),
		(N'Băng Keo Màu Simili 70 mm x 12 Yards - Song Lan - Màu Vàng','Song Lan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fkeo5.jpg?alt=media&token=b729425c-2952-4269-88e4-04303c5a6570&_gl=1*y0s7sq*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTA1NC42MC4wLjA.',27500,7,null,2,105),

		('Bút Xóa Kéo Kitty 5 mm x 6 m - Glory Morning 40212-88550 - Màu Trắng','Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fxoa1.jpg?alt=media&token=38a23f46-c704-45bc-ae15-9cefec0821b1&_gl=1*1ti31bp*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTI5NC40MC4wLjA.',32500,7,null,2,106),
		('Bút Xóa Kéo Kitty 5 mm x 6 m - Glory Morning 40212-88550 - Màu Đen','Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fxoa2.jpg?alt=media&token=1005a8e0-c29d-4994-857a-ea81a27603ca&_gl=1*m0yvfy*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTI4OC40Ni4wLjA.',32500,7,null,2,106),
		('Bút Xóa Kéo Kitty 5 mm x 6 m - Glory Morning 40212-88550 - Màu Hồng','Morning Glory','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fxoa3.jpg?alt=media&token=e0385df3-5d4f-4ba4-ba02-6d9cf8eb718c&_gl=1*1y1z8k5*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTI4My41MS4wLjA.',32500,7,null,2,106),
		('Bút Xóa 12 ml - Gstar 028 - Thân Bút Màu Xanh Ngọc','Gstar','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fxoa4.jpg?alt=media&token=8eb86cc1-fa79-43ca-a7c9-df317d289f9b&_gl=1*11m359e*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTI3OS41NS4wLjA.',13500,7,null,2,106),
		('Xóa Kéo Dạng Bút Whiper WH-1905 - Plus 100-V019 - Màu Xanh Soda','Plus','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fxoa5.jpg?alt=media&token=e7cb954b-c9cc-44af-bae5-9fb2462d0ca5&_gl=1*r6xhda*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTI3NC42MC4wLjA.',27500,7,null,2,106),


		(N'Hồ Khô Bear Cheese Kuki KK-7514 - Màu Nâu','KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fho1.jpg?alt=media&token=dc2ddcc8-18e3-4025-88d7-02975279dc0f&_gl=1*1itl3dw*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTUzNy40NS4wLjA.',24500,7,null,2,107),
		(N'Hồ Khô Bear Cheese Kuki KK-7514 - Màu Vàng','KUKI','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fho2.jpg?alt=media&token=a8f9ea7c-4499-4c3d-ab9f-d97cf4c798c2&_gl=1*19jluwc*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTUzNC40OC4wLjA.',24500,7,null,2,107),
		(N'Hồ Khô Glue Stick 36g - Keyroad KR971293','KEYROAD','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fho3.jpg?alt=media&token=87637a54-91d6-4ec1-a206-9e23c7ab7081&_gl=1*1tsxa5s*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTUzMC41Mi4wLjA.',22500,7,null,2,107),
		(N'Hồ Khô One Piece - Deli A248','Deli','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fho4.jpg?alt=media&token=7b360f44-f731-4685-8151-031c726e7c65&_gl=1*1l37by6*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTUyNi41Ni4wLjA.',8500,7,null,2,107),
		(N'Keo Khô 21g The Yeti - Milan 4415912YT','Milan','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspkhac%2Fho5.jpg?alt=media&token=4c29afb8-350a-405d-8729-12470915ea10&_gl=1*sgicl6*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTUyMi42MC4wLjA.',18500,7,null,2,107),

		(N'Máy Tính Khoa Học Thiên Long Flexio Fx680VN Plus - Màu Trắng','Flexio','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspdientu%2Fmaytinh1.jpg?alt=media&token=a0fd491a-93c7-47ce-be54-8eecfb5c9e7d&_gl=1*wlojad*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTc0MS40Mi4wLjA.',603500,7,null,2,108),
		(N'Máy Tính Khoa Học Thiên Long Flexio Fx680VN Plus - Màu Xanh','Flexio','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspdientu%2Fmaytinh2.jpg?alt=media&token=e809b79e-b0a4-41ac-b50a-1a630e9659ed&_gl=1*dvklfn*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTczOC40NS4wLjA.',603500,7,null,2,108),
		(N'Máy Tính Khoa Học Thiên Long Flexio Fx680VN Plus - Màu Đen','Flexio','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspdientu%2Fmaytinh3.jpg?alt=media&token=65279c0f-9db4-4f34-837a-edc581185392&_gl=1*1brhawn*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTczNS40OC4wLjA.',603500,7,null,2,108),
		(N'Máy Tính Khoa Học Flexio - Thiên Long Fx799VN - Màu Trắng','Thiên Long','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspdientu%2Fmaytinh4.jpg?alt=media&token=a9eb019a-473e-4b28-abb0-6c2c450b03fb&_gl=1*9zk6wf*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTczMi41MS4wLjA.',653500,7,null,2,108),
		(N'Máy Tính Khoa Học Flexio - Thiên Long Fx799VN - Màu Tím','Thiên Long','https://firebasestorage.googleapis.com/v0/b/poly-java-6-5ef9e.appspot.com/o/imagesFahasa%2FVanphongpham%2Fspdientu%2Fmaytinh5.jpg?alt=media&token=f67d3133-d3f4-45b0-9456-2aac4fac58d3&_gl=1*1ivbzz9*_ga*ODU0MjQ2NjM1LjE2OTgzMzUxMjQ.*_ga_CW55HF8NVT*MTY5ODQwMzY2NS4zLjEuMTY5ODQwNTcyNy41Ni4wLjA.',653500,7,null,2,108)

		insert into Voucher
values
('10150', '2023-12-30', 10000, 150000, 1, 100),
('25300', '2023-12-30', 25000, 300000, 1, 50),
('30400', '2023-12-30', 30000, 400000, 1, 20),
('50500', '2023-12-30', 50000, 500000, 1, 100),
('80100', '2023-12-30', 80000, 1000000, 1, 200)

insert into Statuss
values
(1, N'Đang xử lý'),
(2, N'Đã thanh toán'),
(3, N'Chưa thanh toán'),
(4, N'Đã hủy')


		--select sach cap 1
		select b.Id, b.Title from Books as b inner join Cat as c on b.Id = c.BookId inner join Categories as ca on ca.Id = c.CategoryId
		where ParentId in (select id from Categories where ParentId=1)
		group by b.Id, b.Title
		--select sach cap 2
		--nếu category name 'sách' và lv==2 
		select b.Title from  Books as b inner join Cat as c on b.Id = c.BookId inner join Categories as ca on ca.Id = c.CategoryId
		where ParentId = 16
		--select sach cap 3
		--nếu category name 'sách' lv=3
		select b.Title from  Books as b inner join Cat as c on b.Id = c.BookId inner join Categories as ca on ca.Id = c.CategoryId
		where ca.Id=1

		--select tat ca dung cu
		select * from SchoolTools

		--select dung cu cap 2
		--nếu categorynanme 'dụng cụ' và lv =2
		select * from SchoolTools as s inner join Categories as c on s.CategoryId=c.Id
		where ParentId=20

		--select dung cu cap 3
		--nếu categorynanme 'dụng cụ' và lv =3
		select * from SchoolTools where CategoryId=108
		 