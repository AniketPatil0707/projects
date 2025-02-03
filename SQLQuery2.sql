




                         --Queries based on 'NORTHWIND' database



--1- Find the number of orders sent by each shipper.
select (S.CompanyName) Shippername,(o.OrderID) Numberoforders
from Orders O
join Shippers S on O.ShipVia = S.ShipperID
group by S.CompanyName,o.OrderID

--2- Find the number of orders sent by each shipper, sent by each employee
select (S.CompanyName) shippername,E.FirstName+' '+E.LastName Employeename,COUNT(O.OrderID) Numberoforder
from Orders O
join Shippers S on o.ShipVia = S.ShipperID
join Employees E on o.EmployeeID = E.EmployeeID
group by S.CompanyName,E.FirstName+' '+E.LastName
order by 2,3 desc

--3- Find  name  of  employees who has registered more than 100 orders.
select E.FirstName+' '+E.LastName EmployeeName,count(o.OrderID) numberoforders
from Employees E
join Orders O on E.EmployeeID = O.EmployeeID
group by E.FirstName+' '+E.LastName
Having count(O.OrderID)>100

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
select E.FirstName EmployeeName,COUNT(o.OrderID) NumberofOrder
from Orders O
join Employees E on o.EmployeeID = E.EmployeeID
where o.OrderID>25
group by E.FirstName
having E.FirstName = 'Davolio' or E.FirstName = 'Fuller'

--5-Find the customer_id and name of customers who had placed orders more than one time and how many times they have placed the order
select c.CustomerID customer_Id,c.CompanyName customerName,COUNT(o.OrderID) numberoforder
from Customers C
join Orders O on c.CustomerID = o.CustomerID
group by c.CustomerID,c.CompanyName
having COUNT(o.OrderID)>1
order by 3 desc

--6-Select all the orders where the employee’s city and order’s ship city are same.
select o.OrderID,o.ShipCity,e.City
from Orders O
join Employees E on O.EmployeeID = E.EmployeeID
where E.City = o.ShipCity

--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
select o.OrderID, E.FirstName+' '+E.LastName Employeename
from Orders O
join Employees E on o.EmployeeID = e.EmployeeID
where o.ShippedDate > o.RequiredDate

--8-Create a report that shows the total quantity of products ordered fewer than 200.
select ProductID,sum(Quantity) totalquntity
from [Order Details]
group by ProductID
having sum(Quantity) >200
order by 2 desc

--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15.
select c.CustomerID,c.CompanyName, count(o.OrderID) totalnumberoforder
from Orders O
 join Customers C on O.CustomerID = c.CustomerID
 where o.OrderDate > 1996-12-31
 group by c.CustomerID,c.CompanyName
 having count(o.OrderID) > 15
 order by 2

--10-Create a report that shows the company name, order id, and total price of all products of which Northwind
-- has sold more than $10,000 worth.
select c.CompanyName,o.OrderID,sum(od.UnitPrice*od.Quantity*(1-od.Discount)) totalprice
from Orders O
join [Order Details] OD on o.OrderID = OD.OrderID
join Customers C on o.CustomerID = c.CustomerID
group by c.CompanyName,o.OrderID
having sum(od.UnitPrice*od.Quantity*(1-od.Discount)) >10000

--11-Create a report showing the Order ID, the name of the company that placed the order,
--and the first and last name of the associated employee. Only show orders placed after January 1, 1998 
--that shipped after they were required. Sort by Company Name
select O.OrderID,c.CompanyName,e.FirstName+' '+e.LastName Employeename
from Orders O
join Customers C on o.CustomerID = c.CustomerID
join Employees E on o.EmployeeID = E.EmployeeID
where o.OrderDate>1998-01-01 and o.ShippedDate>o.RequiredDate
order by c.CompanyName desc

--12-Get the phone numbers of all shippers, customers, and suppliers
select s.ShipperID,.Phone shipperphonenumber
from Shippers S
select c.CustomerID, C.Phone customerphonenumber
from Customers C
select su.SupplierID,.Phone suppliersphonenumber
from Suppliers SU

--13-Create a report showing the contact name and phone numbers for all employees,customers, and suppliers.


--14-Fetch all the orders for a given customer’s phone number 030-0074321.
select*
from Orders O
join Customers C on o.CustomerID = c.CustomerID
where c.Phone = '030-0074321'

--15-Fetch all the products which are available under Category ‘Seafood’
select*
from Products P
join Categories C on p.CategoryID = c.CategoryID
where c.CategoryName = 'seafood'

--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’
select*
from Products P
join Suppliers S on p.SupplierID = s.SupplierID
where s.CompanyName='Pavlova, Ltd.'

--17-All orders placed by the customers belong to London city.
select*
from Orders O 
join Customers C on o.CustomerID = c.CustomerID
where c.City='london'

--18-All orders placed by the customers not belong to London city.
select*
from Orders O
join Customers C on o.CustomerID = c.CustomerID
where c.City <> 'london'

--19-All the orders placed for the product Chai.
select*
from Orders O
join [Order Details] OD on o.OrderID = OD.OrderID 
join Products P on od.ProductID = P.ProductID
where p.ProductName = 'chai'

--20-Find the name of the company that placed order 10290.
select c.CompanyName
from Orders O
join Customers C on o.CustomerID = c.CustomerID
where o.OrderID = '10290'

--21-Find the Companies that placed orders in 1997
select c.CompanyName,o.OrderDate
from Orders O
join Customers C on o.CustomerID = O.CustomerID
where o.OrderDate = '1997'

--22-Get the product name , count of orders processed 
select p.ProductName,count(O.OrderID) countoforders
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
group by p.ProductName
order by 2 desc

--23-Get the top 3 products which has more orders
with productlist as(
select p.ProductName productname,count(O.OrderID) countoforders
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
group by p.ProductName),
 sortlist as (
select pl.productname ,pl.countoforders,ROW_NUMBER() over (order by PL.countoforders desc) serialnumber
from productlist PL
)
select sl.serialnumber,sl.productname,sl.countoforders
from sortlist SL
where serialnumber <= 3

--24-Get the list of employees who processed the order “chai”
select e.EmployeeID,e.FirstName+' '+e.LastName Employeename,p.ProductName
from Orders O
join [Order Details] OD on o.OrderID = OD.OrderID
join Products P on od.ProductID = p.ProductID
join Employees E on o.EmployeeID = E.EmployeeID
group by e.EmployeeID,e.FirstName+' '+e.LastName,p.ProductName
having p.ProductName = 'chai'

--25-Get the shipper company who processed the order categories “Seafood”
select distinct s.CompanyName shippercompany
from Orders O
join Shippers S on o.ShipVia = s.ShipperID
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
join Categories C on c.CategoryID = p.CategoryID
where c.CategoryName = 'seafood'
 
--26-Get category name , count of orders processed by the USA employees 
select c.CategoryName,count(od.OrderID) countoforders
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
join Categories C on c.CategoryID = p.CategoryID
join Employees E on o.EmployeeID = e.EmployeeID
where e.Country = 'usa'
group by c.CategoryName

--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
select c.CategoryName,c.Description
from Categories c
order by c.CategoryName

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
select c.ContactName,c.ContactName,c.ContactTitle,c.Phone
from Customers c
order by c.Phone

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
select e.FirstName,e.LastName,e.HireDate
from Employees E
order by e.HireDate desc

--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
--OrderDate, ShippedDate, CustomerID, and Freight
select o.OrderID,o.OrderDate,o.ShippedDate,o.CustomerID,o.Freight
from Orders O
order by o.Freight desc

--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
--order and then by CompanyName in ascending order
select s.CompanyName,s.Fax,s.Phone,s.HomePage,s.Country
from Suppliers s
order by s.Country desc, s.CompanyName 

--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
select c.CompanyName,c.ContactName
from Customers C
where c.City = 'buenos aires'

--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
select p.ProductName,p.UnitPrice,p.QuantityPerUnit
from Products P
where p.UnitsInStock = '0'

--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
select o.OrderDate, o.ShippedDate,o.CustomerID,o.Freight
from Orders O
where o.OrderDate = '1997-05-19'

--35-Create a report showing the first name, last name, and country of all employees not in the United States.
select e.FirstName,e.LastName,e.Country
from Employees E
where e.Country <> 'usa'

--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
select c.City,c.CompanyName,c.ContactName
from Customers c
where c.City like 'a%' or c.City like 'b%'
order by c.City

--37-Create a report that shows all orders that have a freight cost of more than $500.00.
select *
from Orders O
where o.Freight > 500
order by o.Freight

--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
-- products that are up for reorder
select p.ProductName,p.UnitsInStock,p.UnitsOnOrder,p.ReorderLevel
from Products P
where p.UnitsInStock < p.ReorderLevel
order by 2,4

--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
select c.CompanyName, c.ContactName, c.Fax
from Customers C
where c.Fax is not null

--40-Create a report that shows the first and last name of all employees who do not report to anybody
select e.FirstName ,e.LastName
from Employees E 
where e.ReportsTo is null

--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
--Sort by company name.
select c.CompanyName, c.ContactName,c.Fax
from Customers C
where c.Fax is not null

--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
--that begin with "A" or "B." Sort by contact name in descending order 
select c.City, c.CompanyName, c.ContactName
from Customers C
where c.City like 'a%' or c.City like 'b%' 
order by c.ContactName desc

--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
select e.FirstName, e.LastName, e.BirthDate
from Employees E
where e.BirthDate between '1950-01-01' and '1950-12-31'

--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
--beginning with "02389".
select o.ShipPostalCode, o.OrderID,o.OrderDate 
from Orders O 
where o.ShipPostalCode like '02389%'
order by 1 

--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
-- does not contain the word "Sales".
select c.ContactName, c.ContactTitle,c.CompanyName
from Customers C
where c.ContactTitle not like '%sales%'

--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
-- in the state of Washington.
select e.FirstName,e.LastName,e.City
from Employees E
where e.City <> 'seattle' and e.Region = 'wa'

--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
--or in any city in Spain except Madrid.
select c.CompanyName,c.ContactTitle,c.City,c.Country
from Customers C
where c.Country ='mexico' or (c.Country='spain' and c.City <> 'Madrid')

--48-List of Employees along with the Manager
select e.FirstName+' '+e.LastName 
from Employees E

--49-List of Employees along with the Manager and his/her title

--50-Provide Agerage Sales per order
select AVG(od.UnitPrice*od.Quantity) Averagesales
from [Order Details] OD

--51-Employee wise Agerage Freight
select e.FirstName+' '+e.LastName EmployeeName,AVG(o.Freight) AverageFreight
from Orders O
join Employees E on o.EmployeeID = e.EmployeeID
group by e.FirstName+' '+e.LastName

--52-Agerage Freight per employee
select e.EmployeeID,AVG(o.Freight) AverageFreight
from Orders O
join Employees E on o.EmployeeID = e.EmployeeID
group by e.EmployeeID
order by 1 

--53-Average no. of orders per customer
with countoforder as(
select count(o.OrderID) nooforder
from Orders O
)
select c.CustomerID,avg(nooforder) avgnooforder
from countoforder NFO, Orders Temp
join Customers C on temp.CustomerID = c.CustomerID 
group by c.CustomerID

--54-AverageSales per product within Category
select p.ProductName,c.CategoryName,AVG(od.UnitPrice*od.Quantity) Averagesales
from [Order Details] OD
join Products P on od.ProductID = p.ProductID
join Categories C on p.CategoryID = c.CategoryID
group by p.ProductName,c.CategoryName

--55-PoductName which have more than 100 no.of UnitsinStock
select p.ProductName
from Products P 
where p.UnitsInStock > 100

--56-Query to Provide Product Name and Sales Amount for Category Beverages
select p.ProductName,sum(od.UnitPrice*od.Quantity) salesamount,C.CategoryName
from [Order Details] OD
join Products P on od.ProductID = p.ProductID
join Categories C on p.CategoryID = c.CategoryID
where c.CategoryName = 'beverages'
group by p.ProductName,C.CategoryName

--57-Query That Will Give  CategoryWise Yearwise number of Orders
select c.CategoryID,YEAR(o.OrderDate),COUNT(distinct o.OrderID) numberoforders
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
join Categories C on p.CategoryID = c.CategoryID
group by c.CategoryID,YEAR(o.OrderDate)
order by 1

--58-Query to Get ShipperWise employeewise Total Freight for shipped year 1997
select s.ShipperID,e.EmployeeID,sum(o.Freight) totalfreight
from Orders O
join Employees E on o.EmployeeID = e.EmployeeID
join Shippers S on o.ShipVia = s.ShipperID
where o.ShippedDate = '1997'
group by s.ShipperID,e.EmployeeID

--59-Query That Gives Employee Full Name, Territory Description and Region Description
select E.FirstName+' '+e.LastName Employeename,t.TerritoryDescription,r.RegionDescription
from Employees E
join EmployeeTerritories ET on e.EmployeeID = et.EmployeeID
join Territories T on et.TerritoryID = t.TerritoryID
join Region R on t.RegionID = r.RegionID
group by t.TerritoryDescription,r.RegionDescription,E.FirstName+' '+e.LastName
order by 1,3

--60-Query That Will Give Managerwise Total Sales for each year 
select e.FirstName+' '+e.LastName Manager,YEAR(o.OrderDate),SUM(od.UnitPrice*od.Quantity) Totalsales
from Orders O 
join [Order Details] OD on o.OrderID = od.OrderID
join Employees E on o.EmployeeID = e.EmployeeID


--61-Names of customers to whom we are sellinng less than average sales per cusotmer
with customersale as(
select o.CustomerID,sum(od.UnitPrice*od.Quantity) Totalsales
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
group by o.CustomerID
),
Averagesale as (
select AVG(Totalsales) as Avgsale
from customersale
)
select c.CustomerID, c.CompanyName
from Customers C,Averagesale AVS,customersale cs
where cs.Totalsales < avs.Avgsale

--62-Query That Gives Average Freight Per Employee and Average Freight Per Customer
select e.EmployeeID,e.FirstName+' '+ e.LastName EmployeeName, AVG(o.Freight) AvgfreightperEmployee
from Orders O
join Employees E on o.EmployeeID = E.EmployeeID
group by e.EmployeeID,e.FirstName+' '+ e.LastName 

select c.CustomerID,c.CompanyName, AVG(o.Freight) Avgfreightpercustomer
from Orders O
join Customers C on o.CustomerID = c.CustomerID
group by  c.CustomerID,c.CompanyName
order by 1
--63-Query That Gives Category Wise Total Sale Where Category Total Sale < the Average Sale Per Category
with categorysale as(
select c.CategoryID, c.CategoryName, sum(od.Quantity*od.UnitPrice) Totalsale
from [Order Details] OD
join Products P on od.ProductID = p.ProductID
join Categories C on p.CategoryID = c.CategoryID
group by c.CategoryID, c.CategoryName
),
averagesale as (
select AVG(Totalsale) Averagepercategory
from categorysale CS
)
select cs.CategoryName,cs.Totalsale
from categorysale CS, averagesale AVS
where cs.Totalsale < avs.Averagepercategory
order by 2

--64-Query That Provides Month No and Month OF Total Sales < Average Sale for Month for Year 1997
with Monthlysale as(
select MONTH(o.OrderDate) monthno, sum(od.Quantity*od.UnitPrice) Totalsale
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
where YEAR(o.OrderDate) = '1997'
group by MONTH(o.OrderDate)
 ),
 Averagesale as (
 select AVG(Totalsale) Avgsalepermonth
 from Monthlysale MS
 )
 select ms.monthno, ms.Totalsale
 from Monthlysale MS, Averagesale AVS
 where ms.Totalsale < avs.Avgsalepermonth
 order by 1

--65-Find out the contribution of each employee towards the total sales done by Northwind for selected year
with Employeesale as(
select e.EmployeeID , e.FirstName+' '+e.LastName EmployeeName,SUM(od.Quantity*od.UnitPrice) EmployeeTotalsale
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Employees E on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1996
group by e.EmployeeID , e.FirstName+' '+e.LastName
),
Totalsale as(
select sum(EmployeeTotalsale) Totalsale
from Employeesale ES
)
select es.EmployeeName, (es.EmployeeTotalsale/ts.Totalsale)*100 contriemployesale
from Employeesale ES, Totalsale TS
order by 1

--66-Give the Customer names that contribute 80% of the total sale done by Northwind for given year
with customersale as(
select c.CustomerID, c.CompanyName,sum(od.Quantity*od.UnitPrice) Totalsale
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Customers C on o.CustomerID = c.CustomerID
where year(o.OrderDate) = 1998
group by c.CustomerID, c.CompanyName
),
Totalsale as (
select sum(Totalsale) Allsale
from customersale CS
)
select CustomerID, CompanyName
from customersale CS, Totalsale TS
where (Totalsale/Allsale) <= 0.80
order by 

--67-Top 3 performing employees by freight cost for given year
select Top 3 e.EmployeeID, e.FirstName+' '+e.LastName EmployeeName, SUM(o.Freight) Totalfreight
from Orders O 
join Employees E on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1997
group by e.EmployeeID,e.FirstName+' '+e.LastName
order by 3 desc

--68-Find the bottom 5 customers per product based on Sales Amount
select p.ProductName,c.CustomerID,c.CompanyName,SUM(od.Quantity*od.UnitPrice) Saleamount
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Products P on od.ProductID = p.ProductID
join Customers C on o.CustomerID = c.CustomerID
group by p.ProductName,c.CustomerID,c.CompanyName
order by 1

--69-Display first and the last row of the table
-- First row
SELECT TOP 1 *
FROM Orders
ORDER BY OrderID ASC

-- Last row
SELECT TOP 1 *
FROM Orders
ORDER BY OrderID DESC

--70-Display employee doing highest sale and lowest sale in each year
with EmployeeYearlysale as(
select e.EmployeeID,e.FirstName+' '+e.LastName EmployeeName,YEAR(o.OrderDate) orderyear ,sum(od.Quantity*od.UnitPrice) Totalsale
from Orders O
join [Order Details] OD on o.OrderID = od.OrderID
join Employees E on o.EmployeeID = e.EmployeeID
group by e.EmployeeID,e.FirstName+' '+e.LastName,year(o.OrderDate)
),
shortedlistdesc as(
select eys.EmployeeID,eys.EmployeeName,eys.orderyear,eys.Totalsale, ROW_NUMBER() over( partition by eys.employeename  order by eys.totalsale desc) serialnumber
from EmployeeYearlysale EYS
),
highestsellingemployee as(
select sld.serialnumber,sld.EmployeeID,sld.EmployeeName,sld.orderyear,sld.Totalsale
from shortedlistdesc Sld
where sld.serialnumber = 1
),
sortlistasc as(
select eys.EmployeeID,eys.EmployeeName,eys.orderyear,eys.Totalsale ,ROW_NUMBER() over( partition by eys.employeename order by eys.totalsale) serialnumber
from EmployeeYearlysale EYS
),
lowestsellingemployee as(
select sla.serialnumber,sla.EmployeeID,sla.EmployeeName,sla.orderyear,sla.Totalsale
from sortlistasc sla
where sla.serialnumber = 1
)
select hse.serialnumber,hse.EmployeeID,HSE.EmployeeName,hse.orderyear,hse.Totalsale
from highestsellingemployee HSE
join lowestsellingemployee LSE on hse.EmployeeName = lse.EmployeeName


--71-Top 3 products of each employee by sales for given year
WITH productlist AS (
SELECT e.EmployeeID, p.ProductName AS productname,COUNT(o.OrderID) AS countoforders
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, p.ProductName
),
sortlist AS (
SELECT pl.EmployeeID, pl.productname, pl.countoforders,ROW_NUMBER() OVER (PARTITION BY pl.EmployeeID ORDER BY pl.countoforders DESC) AS serialnumber
FROM productlist pl
)
SELECT sl.EmployeeID,sl.serialnumber,sl.productname,sl.countoforders
FROM sortlist sl
WHERE sl.serialnumber <= 3


--72-Query That Will Give territorywise number of Orders for given region for given year
SELECT t.TerritoryID, COUNT(o.OrderID) AS numberoforders
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
JOIN Territories t ON et.TerritoryID = t.TerritoryID
JOIN Region r ON t.RegionID = r.RegionID 
WHERE YEAR(o.OrderDate) = 1996 AND r.RegionDescription = 'Eastern'                                        
GROUP BY t.TerritoryID


--73-Display sales amount by category for given year
SELECT c.CategoryID,SUM(od.Quantity * od.UnitPrice) AS TotalSalesAmount
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.CategoryID
ORDER BY 1

--74-Find  name  of customers who has registered orders less than 10 times.
SELECT c.CompanyName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) < 10

--75-Regions with the Sale in the range of +/- 30% of average sale per Region for year 1997...
WITH AvgSalesPerRegion AS (
SELECT e.Region,SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.Region
),
RegionSalesRange AS (
SELECT Region,TotalSales,(SELECT AVG(TotalSales) FROM AvgSalesPerRegion) AS AvgSales
FROM AvgSalesPerRegion
)
SELECT Region,TotalSales
FROM RegionSalesRange
WHERE TotalSales BETWEEN AvgSales * 0.7 AND AvgSales * 1.3


--76-Top 5 countries based on Order Count for year 1998...
SELECT TOP 5 c.Country,COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1998
GROUP BY c.Country
ORDER BY OrderCount DESC;


--77-Category-wise Sale along with deviation % wrt average sale per category for year 1996...
WITH SalesPerCategory AS (
SELECT c.CategoryID,SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CategoryID
),
AvgSalesPerCategory  AS (
SELECT spc.CategoryID,TotalSales,(SELECT AVG(TotalSales) FROM SalesPerCategory) AS AvgSales
FROM SalesPerCategory spc
)
SELECT AvgSalesPerCategory.CategoryID,TotalSales,AvgSales,((TotalSales - AvgSales) / AvgSales) * 100 AS DeviationPercentage
FROM AvgSalesPerCategory


--78-Count of orders by Customers which are shipped in the same month as ordered...
SELECT c.CompanyName,COUNT(o.OrderID) AS OrdersShippedInSameMonth
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = YEAR(o.ShippedDate) AND MONTH(o.OrderDate) = MONTH(o.ShippedDate)
GROUP BY c.CompanyName

--79-Average Demand Days per Order per country for year 1997...
SELECT c.Country,AVG(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS AvgDemandDays
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.Country;

--80-Create the report as Country, Classification, Product Count, Average Sale per Product, Threshold... 
--Classification will be based on Sales and as follows -
--Top if the sale is 1.5 times the average sale per product...
--Excellent if the sale is between 1.2 and 1.5 times the average sale per product...
--Acceptable if the sale is between 0.8 to 1.2 time the average sale per product...
--Need Improvement if the sale is 0.5 to 0.8 times the average sale per product...
--Discontinue for remaining products...
--Produce this report for year 1998..

--81-Top 30% products in each Category by their Sale for year 1997..
WITH ProductSales AS (
SELECT c.CategoryName,p.ProductName,SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.CategoryName, p.ProductName
),
RankedProducts AS (
SELECT ps.CategoryName,ps.ProductName,ps.TotalSales,RANK() OVER (PARTITION BY ps.CategoryName ORDER BY ps.TotalSales DESC) AS SalesRank,COUNT(*) OVER (PARTITION BY ps.CategoryName) AS TotalProducts
FROM ProductSales ps
)
SELECT rp.CategoryName,rp.ProductName,rp.TotalSales
FROM RankedProducts rp
WHERE rp.SalesRank <= CEILING(0.3 * rp.TotalProducts)
ORDER BY rp.CategoryName, rp.SalesRank;

--82-Bottom 40% countries by the Freight for year 1997 along with the Freight to Sale ratio in %...
WITH CountryFreightSales AS (
SELECT c.Country,SUM(o.Freight) AS TotalFreight,SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.Country
),
RankedCountries AS (
SELECT cfs.Country,cfs.TotalFreight,cfs.TotalSales,(cfs.TotalFreight / NULLIF(cfs.TotalSales, 0)) * 100 AS FreightToSaleRatio,RANK() OVER (ORDER BY cfs.TotalFreight ASC) AS FreightRank,COUNT(*) OVER () AS TotalCountries
FROM CountryFreightSales cfs
)
SELECT rc.Country,rc.TotalFreight,rc.TotalSales,rc.FreightToSaleRatio,rc.FreightRank
FROM RankedCountries rc
WHERE rc.FreightRank <= CEILING(0.4 * rc.TotalCountries)
ORDER BY rc.FreightRank;

--83-Countries contributing to 50% of the total sale for the year 1997...
WITH CountrySales AS (
SELECT c.Country,SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.Country
),
SortedSales AS (
SELECT cs.Country,cs.TotalSales,SUM(cs.TotalSales) OVER (ORDER BY cs.TotalSales DESC) AS RunningTotal,SUM(cs.TotalSales) OVER () AS GrandTotal
FROM CountrySales cs
)
SELECT ss.Country,ss.TotalSales,ss.RunningTotal,ss.GrandTotal
FROM SortedSales ss
WHERE ss.RunningTotal <= 0.5 * ss.GrandTotal
ORDER BY ss.RunningTotal ASC;


--84-Top 5 repeat customers for each country in year 1997...
WITH CustomerOrderCounts AS (
SELECT c.Country,c.CustomerID,c.CompanyName,COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.Country, c.CustomerID, c.CompanyName
),
RankedCustomers AS (
SELECT coc.Country,coc.CustomerID,coc.CompanyName,coc.OrderCount,RANK() OVER (PARTITION BY coc.Country ORDER BY coc.OrderCount DESC, coc.CustomerID) AS CustomerRank
FROM CustomerOrderCounts coc
)
SELECT rc.Country,rc.CompanyName AS CustomerName,rc.OrderCount
FROM RankedCustomers rc
WHERE rc.CustomerRank <= 5
ORDER BY rc.Country, rc.CustomerRank;


--85- Week over Week Order Count and change % over previous week for year 1997 as Week Number,
-- Week Start Date, Week End Date, Order Count, Change %
WITH WeeklyOrders AS (
SELECT DATEPART(WEEK, o.OrderDate) AS WeekNumber,DATEADD(DAY, -DATEPART(WEEKDAY, o.OrderDate) + 1, CAST(o.OrderDate AS DATE)) AS WeekStartDate,DATEADD(DAY, 7 - DATEPART(WEEKDAY, o.OrderDate), CAST(o.OrderDate AS DATE)) AS WeekEndDate,COUNT(o.OrderID) AS OrderCount
FROM Orders o
WHERE YEAR(o.OrderDate) = 1997
GROUP BY DATEPART(WEEK, o.OrderDate),DATEADD(DAY, -DATEPART(WEEKDAY, o.OrderDate) + 1, CAST(o.OrderDate AS DATE)),DATEADD(DAY, 7 - DATEPART(WEEKDAY, o.OrderDate), CAST(o.OrderDate AS DATE))
),
WeeklyChange AS (
SELECT wo.WeekNumber,wo.WeekStartDate,wo.WeekEndDate,wo.OrderCount,LAG(wo.OrderCount) OVER (ORDER BY wo.WeekNumber) AS PreviousWeekCount,
CASE WHEN LAG(wo.OrderCount) OVER (ORDER BY wo.WeekNumber) IS NULL THEN NULL ELSE (CAST(wo.OrderCount AS FLOAT) - LAG(wo.OrderCount) OVER (ORDER BY wo.WeekNumber)) * 100.0 / LAG(wo.OrderCount) 
OVER (ORDER BY wo.WeekNumber)END AS ChangePercentage
FROM WeeklyOrders wo
)
SELECT WeekNumber,WeekStartDate,WeekEndDate,OrderCount,ChangePercentage
FROM WeeklyChange
ORDER BY WeekNumber;
