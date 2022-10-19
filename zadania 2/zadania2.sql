CREATE TABLE Zadanie3.DIMDate(DateID int PRIMARY KEY,Year int,Day int, Month int, Hour int);
CREATE TABLE Zadanie3.DIMClient(NIP char(10) PRIMARY KEY,ClientAddress varchar(30), ClientName varchar(20));
CREATE TABLE Zadanie3.DIMFruit(FruitID int PRIMARY KEY,FruitName varchar(20), FruitPrice int, FruitCategory varchar(20));
CREATE TABLE Zadanie3.FactSales(ID int PRIMARY KEY,FruitID int, ClientID char(10), DateID int, Quantity int, Amount decimal(10,2),Location varchar(30),
FOREIGN KEY (FruitID) REFERENCES Zadanie3.DIMFruit(FruitID),
FOREIGN KEY (ClientID) REFERENCES Zadanie3.DIMClient(NIP),
FOREIGN KEY (DateID) REFERENCES Zadanie3.DIMDate(DateID));

CREATE TABLE Zadanie4.DIMDate(DateID int PRIMARY KEY,Year int,Day int, Month int, Hour int);
CREATE TABLE Zadanie4.DIMCategory(CategoryID int PRIMARY KEY,CategoryName varchar(20));
CREATE TABLE Zadanie4.DIMClient(NIP char(10) PRIMARY KEY,ClientAddress varchar(30), ClientName varchar(20));
CREATE TABLE Zadanie4.DIMFruit(FruitID int PRIMARY KEY,CategoryID int,FruitName varchar(20), FruitPrice int, FruitCategory varchar(20),
FOREIGN KEY (CategoryID) REFERENCES Zadanie4.DIMCategory(CategoryID));
CREATE TABLE Zadanie4.FactSales(ID int PRIMARY KEY,FruitID int, ClientID char(10), DateID int, Quantity int, Amount decimal(10,2),Location varchar(30),
FOREIGN KEY (FruitID) REFERENCES Zadanie4.DIMFruit(FruitID),
FOREIGN KEY (ClientID) REFERENCES Zadanie4.DIMClient(NIP),
FOREIGN KEY (DateID) REFERENCES Zadanie4.DIMDate(DateID));

CREATE TABLE Zadanie5.DIMEmployeeScoring(EmployeeScoringID int PRIMARY KEY,EmployeeScore int, EffectiveDate date);
CREATE TABLE Zadanie5.FactsEmployees(ID int PRIMARY KEY,EmployeeScoringID int,PESEL char(11), Salary decimal(10,2),EmployeeAddress varchar(30),
FOREIGN KEY (EmployeeScoringID) REFERENCES Zadanie5.DIMEmployeeScoring(EmployeeScoringID));

CREATE TABLE Zadanie6.DIMDate(DateID int PRIMARY KEY,Year int, Day int, Month int, Hour int,Quarter int);
CREATE TABLE Zadanie6.DIMWarehouse(WarehouseID int PRIMARY KEY,WarehouseAddress varchar(50),WarehouseCountry varchar(20));
CREATE TABLE Zadanie6.DIMBrand(BrandID int PRIMARY KEY,BrandName varchar(30));
CREATE TABLE Zadanie6.DIMProduct(ProductID int PRIMARY KEY,BrandID int,ProductName varchar(20), StartDate date, EndDate date,
FOREIGN KEY (BrandID) REFERENCES Zadanie6.DIMBrand(BrandID));
CREATE TABLE Zadanie6.FactStock(ID int PRIMARY KEY, DateID int, WarehouseID int, ProductID int,
FOREIGN KEY (ProductID) REFERENCES Zadanie6.DIMProduct(ProductID),
FOREIGN KEY (DateID) REFERENCES Zadanie6.DIMDate(DateID),
FOREIGN KEY (WarehouseID) REFERENCES Zadanie6.DIMWarehouse(WarehouseID));