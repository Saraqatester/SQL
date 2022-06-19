------------ Cities Table ------------
Create table Cities(
 CityID int PRIMARY key IDENTITY (1,1),
 CityName VARCHAR (20) not null);

insert into Cities 
values ('Ashdod'),
       ('Beersheva'),
       ('Givatayim'),
       ('Haifa'),
       ('Jerusalem'),
       ('Petah Tikva'),
       ('Rishon Letzion'),
       ('Tel Aviv');

-- SELECT * FROM Cities
-- DROP TABLE Cities

------------ Neighborhoods Table ------------
Create table Neighborhoods (
NeighborhoodID int PRIMARY KEY IDENTITY(1,1),
NName varchar (20) not null,
CityID int REFERENCES Cities (CityID));

insert into Neighborhoods
VALUES ('Kiryat Abramski',1),
       ('Ventura', 1),
       ('Marina Zone', 1),
       ('Ramot', 2),
       ('Sheinkin', 3),
       ('Arlozorov', 3),
       ('Givat Rambam',3),
       ('Kfar Ganim',6),
       ('Neve Oz',6),
       ('Ramat Verber',6),
       ('Rishonim',7),
       ('Ramat Hahayal',8),
       ('Neve tzedek', 8),
       ('Ramat Aviv',8),
       ('Florentin',8)

--SELECT * FROM Neighborhoods
 --DROP TABLE Neighborhoods

------------ Customers Table ------------
Create table Customers (
CustomerID int PRIMARY key IDENTITY (100,1),
FirstName varchar(20) not null,
LastName varchar(15) not null,
ID char(9) unique not null,
City VARCHAR (15) not null,
PhoneNumber char(12) not null,
BirthDate DATETIME CHECK (year(birthdate) between 1930 and year(GETDATE())) not null);


insert into Customers
VALUES 
('Alice','Collins',278794242,'Tel Aviv','050-5392416','1970-01-07'), 
('Beth','Lohan',247784892,'Petah Tikva','052-9383471','1983-03-12'),
('Richard','Cliff',289327237,'Givatayim','053-2819292','1978-07-07'),
('Luciana','Reed',387979434,'Petah Tikva','050-3184652','1990-02-18'),
('Linda','Grossman',248567789,'Tel Aviv','055-6788556','1964-04-21'),
('Peter','Graham',346784456,'Jerusalem','054-58227926','1950-12-01'),
('Shawn','Lisha',241724652,'Rishon Letzion','058-2955714','1978-07-19'),
('Nina','Horovitz',269374137,'Ashdod','056-8394613','1969-11-24'),
('Dan','Smit',315820504,'Ashdod','058-5933281','1953-08-04'),
('Mark','Moss',381919436,'Beer Sheva','057-4688461','1998-05-02'),
('Kim','Baldwin',368013645,'Givatayim','054-8100935','1969-05-07'),
('Tom','Fox',201058372,'Rishon Letzion','052-3950773','1987-09-10'),
('David','Barker',251533914,'Tel Aviv','054-58227926','1993-07-02'),
('Gabriel','Walker',303047418,' Tel Aviv','050-5493412','1986-03-22'),
('Martha', 'Bach', 322742579,'Tel Aviv','050-5288252', '1991-08-09'),
('John', 'Lennon', 247782812, 'Petah Tikva', '052-3182646','1987-12-27'),
('Rita', 'Wilson', 238567890, 'Givatayim', '053-4855926', '1982-11-16'),
('Noa', 'Pitt', 358576758, 'Jerusalem', '055-5933853', '1990-12-22'),
('Simon', 'Geere', 256678392, 'Haifa', '050-2199343', '1982-04-04'),
('Lara','Nelson',269374136,'Ashdod','052-8396613','1963-12-24'),
('Daniel','Torres',315200504,'Ashdod','054-6933281','1954-09-04'),
('Mariah','Baker',381459436,'Beer Sheva','056-4688461','1992-07-02'),
('Kendra','Scott',368783645,'Givatayim','054-8105735','1991-05-06'),
('Daia','Carter',203858372,'Rishon Letzion','051-3949773','1986-08-10'),
('Douglas','Hall',251545914,'Tel Aviv','055-5888726','1994-06-02');



--SELECT * FROM Customers
 --DROP TABLE Customers

------------ HouseTypes Table ------------
Create table HouseTypes (
HouseTypeID int primary key IDENTITY (1,1),
TypeName VARCHAR (20) not null);

insert into HouseTypes values
('Apartment'), 
('Cottage'),
('Co-Op'),
('Single-Family'),
('Tiny Home'),
('Townhome'),
('Bungalow'),
('Cabin'),
('Cave House'),
('Carriage'),
('Castle');


--SELECT * FROM HouseTypes
--DROP TABLE HouseTypes

------------ Houses Table ------------
Create table Houses (
HouseID int PRIMARY KEY IDENTITY (1,1),
HouseTypeID int REFERENCES HouseTypes (HouseTypeID),
CustomerID int REFERENCES Customers (CustomerID),
FloorN  char(2) check (FloorN >=0 and FloorN <=50),
Rooms char (2)check (Rooms >=1 and Rooms <=15),
Parking  VARCHAR (3)check (Parking IN ('Yes','No')),
Elevator VARCHAR (3)check (Elevator IN ('Yes','No')),
Balcony VARCHAR (3)check (Balcony IN ('Yes','No')),
SquareMeters int check (SquareMeters >=20 and SquareMeters <=1000),
BuiltDate DATETIME check(year(BuiltDate) between 1950 and year(GETDATE())) not null,
NeighborhoodID int REFERENCES Neighborhoods (NeighborhoodID));



insert into Houses values 
(1, 114, 2, 4, 'Yes', 'Yes', 'Yes', 125, '1978-10-11', 9 ), 
(1, 121, 3, 5, 'Yes', 'No' , 'Yes', 160, '2000-03-21', 5),
(2, 109, 0, 3, 'Yes', 'No', 'No', 170, '2005-01-01', 10 ), --------
(1, 110, 4, 4, 'Yes', 'Yes', 'Yes',150, '2021-07-01', 8),
(4, 108, 0, 4, 'Yes', 'No' , 'No', 200, '2010-10-10', 12),
(1, 112, 2, 5, 'Yes', 'No' , 'Yes', 190, '1995-09-09', 5),
(1, 102, 3, 4, 'Yes', 'Yes', 'Yes', 150,'2011-02-10', 7),
(4, 107, 0, 3, 'No' , 'No' , 'No', 175, '2005-07-08', 14),
(4, 113, 0, 4, 'Yes', 'No' , 'No', 210, '1999-10-20', 12),
(1, 100 ,7, 4, 'Yes', 'No' , 'Yes', 180, '2007-09-15', 13),
(1, 102, 2, 5, 'No' , 'No' , 'Yes', 160, '2003-10-21', 12 ),
(4, 117, 0, 4, 'No' , 'No' , 'No', 180, '2015-10-20', 6 ),
(1, 111, 4, 3, 'Yes', 'Yes', 'Yes', 135, '2011-04-27', 15),
(1, 116, 12,5, 'Yes', 'Yes', 'Yes', 160, '2008-06-01', 14 ),
(4, 117, 0, 3, 'No' , 'No' , 'No', 140, '2009-09-10', 12),
(1, 118, 1, 3, 'Yes', 'Yes' , 'Yes', 160, '2001-10-01',10),
(4, 103, 0, 4, 'Yes', 'No' , 'No', 185, '2016-12-01', 13 ),
(4, 114, 0, 5, 'Yes', 'No' , 'No', 190, '2015-08-15', 6),
(1, 105, 1, 4, 'Yes', 'Yes', 'Yes', 130, '2008-09-10', 9),
(2, 101, 0, 3, 'Yes', 'No' , 'No', 125, '1999-12-13', 3 ),
(4, 104, 0, 4, 'Yes', 'No' , 'No', 205, '2004-09-10', 5),
(1, 106, 5, 5, 'Yes', 'Yes', 'Yes', 170,'2016-08-14', 1),
(4, 115, 0, 4, 'Yes', 'No' , 'No', 150,'2021-10-09', 8),
(1, 120, 2, 3, 'Yes', 'No' , 'No', 120,'1980-11-07', 10)

--SELECT * FROM Houses
--DROP TABLE Houses

------------ Salesmen Table ------------
Create table Salesmen (
SalesmanID int PRIMARY KEY IDENTITY (1,1),
FirstNameS varchar(20) not null,
LastNameS varchar(15) not null,
Title VARCHAR (25) not NULL,
HireDate DATETIME CHECK (year(hiredate) between 2000 and year(GETDATE())) not null,
BirthDate DATETIME CHECK (year(birthdate) between 1950 and year(GETDATE())) not null,
SCity VARCHAR (15));


insert into  Salesmen values 
('Sarah', 'Jackson', 'Sales Representative', '2001-05-21','1978-01-01','Tel-Aviv'),
('Ryan', 'Clark', 'Sales Representative', '2003-09-18','1980-04-05','Yavne'),
('Chris', 'Young', 'Sales Representative', '2002-09-09','1976-02-27','Givatayim'),
('Kira', 'Green', 'Sales Representative', '2002-08-19','1982-03-14','Holon'),
('Janie', 'Wright', 'Sales Representative', '2003-07-01','1983-01-07','Bat-Yam')


 --DROP TABLE Salesmen

------------ Sales Table ------------
Create table Sales (
SaleID int PRIMARY KEY IDENTITY(1,1),
SalesmanID int REFERENCES Salesmen (SalesmanID), 
CustomerID int REFERENCES Customers(customerID),
HouseID int REFERENCES Houses (HouseID),
SoldPrice DECIMAL (12,2) not null,
DesiredPrice decimal (12,2) not null,
SaleDate DATETIME check (year(saledate) between 2000 and year(GETDATE())) not null);

INSERT INTO Sales VALUES
(1,100,10,4340000.00, 4300000.00,'2021-01-25'), 
(4,101,20,2032000.00,2000000.00,'2020-05-21'),
(2,102,7,3020000.00, 3020000.00,'2019-05-21'),
(1,104,21,3340000.00, 3000000.00, '2017-05-21'),
(1,118,16,1732000.00,1700000.00,'2021-05-21'), 
(1,105,19,19300000.00,1900000.00,'2016-05-21'),
(1,113,9,4940000.00, 4900000.00,'2015-05-21'),                    
(1,103,17,6200000.00,6100000,'2021-02-07'),
(3,106,22,1930000.00,1900000.00,'2014-05-21'),
(1,117,15,4430000.00,4400000.00,'2013-05-21'),
(4,107,8,3790000.00,3770000.00,'2017-05-21'),
(1,111,13,2921000.00,2900000.00,'2019-05-21'),
(1,112,6,2420000.00,2400000.00,'2015-04-11'),
(1,108,5,5810000.00,5780000.00,'2021-05-17'),
(3,115,23,2120000.00,2100000.00,'2011-05-21'),
(2,116,14,2815000.00,2800000.00,'2019-05-21'),
(2,120,24,1425000.00,1410000,'2020-05-21');


--SELECT * FROM Sales
--DROP TABLE Sales

------------ Housetype_Salesman Table ------------
Create table Housetype_Salesman(
SalesmanID int REFERENCES Salesmen (SalesmanID), 
HouseTypeID int REFERENCES HouseTypes (HouseTypeID));
-- SELECT * FROM Housetype_Salesman



--Queries--
--1.A. Calculate company profits from all brokerages made this year by house type. Profit is calculated by the difference between the price
-- of the sale of the company and the price the client requested to sell his house. Each type of home should be presented 
--(e.g. Apartment in the building, penthouse, etc.) the total profits this year.

select Typename,  sum(soldprice- desiredprice) 'Profits'
From  Sales s, housetypes ht, houses h
where h.houseid= s.houseid and ht.HouseTypeID=h.housetypeid
and year(saledate)= 2021
group by Typename

--2. Show customers who sold through company services and buy another house at a higher price of sale.

Select firstname, salesmanid, MAX(soldprice)'Highest Price'
from customers c , sales s
where c.customerid= s.customerid
group by firstname, salesmanid

--3 What's the most prestigious neighborhood? Name of the neighborhood and name of the city, which average house prices
--The most expensive ones.

Select top 1 Nname, cityname, avg(desiredprice)'Highest avg price'
from neighborhoods n, cities c, sales s, houses h
where  n.cityid=c.cityid and n.NeighborhoodID=h.neighborhoodid  and h.houseid=s.houseid
group by nname, cityname 
order by [Highest avg price] desc

--4. Show employee of the year. A top employee is a employee whose total profits are his most sales

with A as (select sl.SalesmanID, FirstNameS, year (saledate) 'year', SUM (soldprice ) 'SUMprice'
from  Salesmen sl, Sales s
where sl.SalesmanID = s.SalesmanID
group by sl.SalesmanID, FirstNames, year (saledate)),

B AS(select YEAR(SALEDATE) 'YEAR', MAX(SUMprice)'MAXPRICE'
from A, Sales S
WHERE A.SalesmanID = s.SalesmanID
GROUP BY YEAR(SALEDATE))

SELECT A.FirstNames, B.[YEAR], MAXPRICE
FROM A,B
WHERE A. SUMprice = B.MAXPRICE


--5 They offered a new, more spacious home to a customer who purchased a home through company services two years ago or
--More like the same city he lives in. (More spacious means more rooms or more space) note that the proposed house must be a house for 
--sale right now and not a house that has already been sold.


--Houses for sale--
go
create view "Available Houses" as
select h.houseid, typename, Nname, squaremeters, cityname, saledate
from sales s right join houses h on  s.houseid=h.houseid join housetypes ht on ht.housetypeid=h.housetypeid join  Neighborhoods n  on h.NeighborhoodID=n.NeighborhoodID 
join cities ci on n.Cityid=ci.CityID 
where saledate is null
go

--Customers who bought a house 2 years ago or more
go
create view "Customers2yrsago" as
select c.Customerid, Firstname, Lastname, City, h.houseid, Squaremeters, saledate, cityname
from sales s, customers c,houses h, Neighborhoods n, cities ci
where s.customerid=c.customerid and 
c.customerid=h.customerid and
h.NeighborhoodID=N.NeighborhoodID and
n.Cityid=ci.CityID 
and year(getdate()) - year(saledate)>=2 
go

--- Newest house Offer for clients who live in the same city as the house offer
select [Available houses].Houseid, [Available houses].typename, [Available houses].squaremeters, Customers2yrsago.Cityname, Customers2yrsago.Firstname, Customers2yrsago.Lastname
from [Available houses], Customers2yrsago
where [Available houses].HouseID=Customers2yrsago.HouseID


;with task4 as
(select s.houseid, FirstnameS, LastnameS, desiredprice, year(saledate) 'Year'
from salesmen sm , sales  s
where sm.salesmanid=s.salesmanid
group by s.houseid, firstnames, lastnames, desiredprice, year(saledate))

select *
from Task4
where desiredprice= (select MAX(desiredprice) from Task4 where Year=2018) or
desiredprice = (select MAX(desiredprice) from Task4 where Year=2019) or
desiredprice = (select MAX(desiredprice) from Task4 where Year=2020) or
desiredprice = (select MAX(desiredprice) from Task4 where Year=2021)
order by 'Year'
