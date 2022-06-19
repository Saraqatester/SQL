use northwind

--1  Show the first name, last name and telephone number for all the employees, except those who live in UK.

select FirstName, LastName, HomePhone, Country
from Employees
where country <> 'uk'

--2  Show all product details for products whose unit price is greater than $10 and quantity in stock greater than 2. Sort by product price.

SELECT ProductID, ProductName, SupplierID, CategoryID UnitPrice, UnitsInStock, UnitsOnOrder,QuantityPerUnit, ReorderLevel, Discontinued
from Products
where UnitsInStock > 2

-- 3 Show the first name, last name and telephone number for the employees who started working in the company in 1992-1993.

select FirstName, LastName, HomePhone, HireDate
from Employees
where year(HireDate) between 1992 and 1993 

-- 4 Show the product name, Company name of the supplier and stock quantity of the products that have 15 or more 
--items in stock and the Product name starts with B or C or M.

SELECT CompanyName 'supplier Name', productname, UnitsInStock
from Products, Suppliers 
where suppliers.SupplierID= products.SupplierID
and UnitsInStock>= 15 
and (ProductName like 'B%' or ProductName like 'C%'  or ProductName like 'M%') 


 or ProductName like 'M%'
--5 Show all details for products whose Category Name is ' Meat/Poultry ' Or 'Dairy Products '. Sort them by product name

SELECT *
from Products inner join Categories 
on  products.CategoryID= categories.CategoryID
where CategoryName = 'Meat/Poultry' or CategoryName= 'Dairy Products'
  Order by ProductName

  --6 Show Category name, Product name and profit for each product (how much money the company will earn if they sell all the units in stock). 
  --Sort by the profit.

SELECT CategoryName, ProductName, (UnitsInStock* unitprice) 'Profit'
from Categories, Products
where Categories.CategoryID= Products.ProductID
order by profit

--7 Show the Employees' first name, last name and Category Name of the products which they have sold (show each category once).

select firstname, LastName, Categoryname, count ([Order Details].ProductID) 'Sold Items'
from Employees ,Categories,Orders, [Order details], Products
where Employees.EmployeeID = Orders.EmployeeID
and Categories.CategoryID= Products.CategoryID
and orders.OrderID= [Order details].OrderID
and Products.ProductID= [Order Details].ProductID
group by firstname, lastname, CategoryName


--8 Show the first name, last name, telephone number and date of birth for the employees who are aged older than 35.
-- Order them by last name in descending order.

SELECT firstname, LastName, HomePhone, BirthDate, DATEDIFF(year, BirthDate, GETDATE())'Age'
from Employees
where DATEDIFF(year, BirthDate, GETDATE()) >35
order by LastName desc

--9 Show each employee’s name, the product name for the products that he has sold and quantity that he has sold.

SELECT FirstName, ProductName, sum (Quantity)'Quantity total'
From  Employees, products, [Order Details], Orders 
where Employees.EmployeeID=  Orders.EmployeeID 
and Orders.OrderID= [Order Details].OrderID
and Products.ProductID= [Order Details].ProductID
group by FirstName, ProductName

--10 Show for each order item – the customer name and order id, product name, ordered quantity, product price and total price 
--(Ordered quantity * product price) and gap between ordered date and shipped date (the gap in days). Order by order id.

SELECT ContactName' customer name', [Order Details].OrderID, ProductName, Quantity' Ordered Quantity', [Order Details].UnitPrice 'product price',
Quantity * [Order Details].UnitPrice 'Total price', DATEDIFF(day,OrderDate, ShippedDate)'Days gap order-ship'
from Products, Customers, Orders, [Order Details]
where Products.ProductID= [Order Details].ProductID
and [Order Details].orderid= Orders.OrderID
and Customers.CustomerID= Orders.CustomerID
Order by [order details].OrderID



11--How much each customer paid for all the orders he had committed together?

SELECT ContactName,  sum(UnitPrice* Quantity *(1- Discount))'Total paid'
From Customers, orders, [Order Details]
where Customers.CustomerID= Orders.CustomerID
and orders.OrderID= [Order Details].OrderID
group by ContactName



--12 In which order numbers was the ordered quantity greater than 10% of the quantity in stock?

select  Orderid 'order Numbers', Quantity, UnitsInStock , UnitsInStock* .1 'Ten perc stock'
from Products, [Order Details]
where Products.ProductID= [Order Details].ProductID
and Quantity> UnitsInStock* .1

--13 Show how many Employees live in each country and their average age.

select country,count (EmployeeID)' emp',avg(year(BirthDate))'avg'
from Employees
group by country

--14 What would be the discount for all the London customers (together), if after 5 days of gap
--between the order date and shipping date they get a 5% discount per item they bought?



--15  Show the product id, name, stock quantity, price and total value (product price * stock
--quantity) for products whose total bought quantity is greater than 500 items.

SELECT Products.ProductID, ProductName, UnitsInStock, products.UnitPrice, (products.UnitPrice* UnitsInStock)' total price', sum(Quantity)'Total bought quantity'
From Products, [Order Details]
where products.ProductID= [Order Details].ProductID
group by products.ProductID, ProductName, UnitsInStock, products.UnitPrice
having sum (Quantity)>500 



--16 . For each employee display the total price paid on all of his orders that hasn’t shipped yet.


SELECT FirstName, sum(unitprice* Quantity* (1- Discount)) 'Total price paid', ShippedDate
from Employees, [Order Details], Orders
where Employees.EmployeeID= Orders.EmployeeID and orders.orderid= [order details].Orderid
and ShippedDate is null
group by FirstName, ShippedDate


--17 For each category display the total sales revenue, every year.

SELECT  year(OrderDate)'Year', CategoryName, sum([Order Details].unitprice* Quantity* (1- Discount))'Total Revenue'
From Categories, [Order Details], Products, orders
where Categories.CategoryID= [Products].CategoryID and Products.ProductID= [Order Details].ProductID and orders.OrderID=[Order Details].OrderID
group by CategoryName, year(OrderDate)

--18 Which Product is the most popular? (number of items)

    Select top 1 productname , count([Order Details].ProductID) 'Popular in Items'
    from [Order details], products
    where products.ProductID = [Order Details].ProductID
    group by ProductName
    order by 'popular in items' desc     

-- Or

    Select productname , count([Order Details].ProductID) 'pop'
    from [Order details], products
    where products.ProductID = [Order Details].ProductID
    group by  ProductName
    having count ([Order Details].productid) >= ALL
                  (Select count([Order Details].ProductID) 'pop'
                   from [Order details], products
                    where products.ProductID = [Order Details].ProductID
                     group by ProductName)


--19 Which Product is the most profitable? (income)


SELECT  top 1 productname, sum ([order details].UnitPrice * Quantity) 'Most profitable item'
from [Order Details], products
where [Order Details].ProductID= Products.ProductID
group by ProductName
order by [Most profitable item] desc


--20 Display products that their price is higher than the average price of their Category.


SELECT ProductName,CategoryName, UnitPrice' higher than avg'
from Products, Categories
where Products.CategoryID=Categories.CategoryID
and UnitPrice>
(select avg (unitprice) from products p1 where p1.CategoryID=Products.CategoryID)




--21 For each city (in which our customers live), display the yearly income average.


select city,count(year(orderdate)), avg([Order Details].unitprice* Quantity* (1- Discount))'Yearly income avg '
From  [Order Details], orders, Customers
where customers.CustomerID= Orders.CustomerID and orders.OrderID=[Order Details].OrderID
group by city


--22 For each month display the average sales in the same month all over the years.


select year (orderdate)'year', month(orderdate)'Month ', avg(Quantity)'Avg Sales'
from orders,[Order Details]
where [Order Details].OrderID= orders.OrderID
group by month(orderdate), year(orderdate)
Order by  Month


--23 Display a list of products and OrderID of the largest order ever placed for each product

SELECT [Order Details].OrderID,Products.ProductID, ProductName,Quantity
FROM Products , [Order Details] 
WHERE Products.ProductID = [Order Details].ProductID
AND Quantity =
(select max(quantity) from [Order Details] od1 where od1.ProductID = [Order Details].ProductID)
order by ProductID

 
 