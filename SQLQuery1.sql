--1-Display all data from DimCustomer
select *
from DimCustomer

--2-Display customers first name ,birthdate ,marrital status And gender from DimCustomer
select FirstName,BirthDate,MaritalStatus,Gender
from DimCustomer

--3-Get customers whose yearly income is more than 60000
select FirstName,LastName,YearlyIncome
from DimCustomer
where YearlyIncome > 60000
order by YearlyIncome desc

--4-Get all customers who have totalchildern <= 3
select *
from DimCustomer
where TotalChildren <= 3

--5-List of customers who are married and have yearly income > one lakh
select FirstName,LastName, MaritalStatus,YearlyIncome
from DimCustomer
where MaritalStatus = 'M' and YearlyIncome > 100000


6-List all male customers whose birthdate is greater than 1st jan 1970
select FirstName,LastName,BirthDate,Gender
from DimCustomer
where Gender = 'M' and BirthDate > '1970-01-01'

--7-Get customers whose occupation is either professional or management
select *
from DimCustomer
where EnglishOccupation = 'professional' or EnglishOccupation = 'management'

--8- Display accountkey , parentaccountkey  and account Discription from DimAccount 
--where parentaccountkey is not null
select AccountKey,ParentAccountKey,AccountDescription
from DimAccount
where ParentAccountKey is not null

--9HA- Display product key and product name from DimProduct whose reorder point > 300 and color is black
select ProductKey,EnglishProductName,ReorderPoint
from DimProduct
where ReorderPoint > 300 and Color = 'black'

--10HA- Display all products who are silver in colour
select *
from DimProduct
where Color = 'Silver'

--11HA- Employees working in departments HumanResources And Sales.
select *
from DimEmployee
where DepartmentName in ('Human Resources' , 'sales')

--12-All departments from DimEmployee
select distinct DepartmentName
from DimEmployee

--13- Display SalesOrderNumber , Productkey and Freight From FactResellerSales 
--Whose Freight > 15 and <100
select SalesOrderNumber, ProductKey, Freight
from FactResellerSales
where Freight between 15 and 100
order by Freight desc

--14-All employees working in HR ,SALES, PURCHASING AND MARKETING
select *
from DimEmployee
where DepartmentName in ('Human Resources','sales','purchasing','marketing')

--15-Display employeekey,parentEmployeeKey And DepartmentName of employees whose employee key is 
--1,19,276,105,73\
select EmployeeKey,ParentEmployeeKey,DepartmentName
from DimEmployee
where EmployeeKey in (1,19,276,105,73)
--16-All employees who are married and whose base rate is >10 and <25
select *
from DimEmployee
where MaritalStatus = 'M' and (BaseRate >10 and BaseRate < 25)

--17-All Married Male employees whose base rate is between 10 and 25
select *
from DimEmployee
where MaritalStatus = 'M' and Gender = 'M' and BaseRate between 10 and 25
--18-Display all customers whose FirstName starts with J
select FirstName, LastName
from DimCustomer
where FirstName like 'J%'
--19-Display all customers whose FirstName starts with J , E, C
select FirstName, LastName
from DimCustomer
where FirstName like '[JEC]%'

--20-Display customersName ,birthdate ,gender from DimCustomer
select FirstName+' ' +LastName Customername,BirthDate,Gender
from DimCustomer

--21--Display all products with their 'SubcategoryName'
select DP.EnglishProductName, DPS.EnglishProductSubcategoryName
from DimProduct DP
join DimProductSubcategory DPS on DP.ProductSubcategoryKey =  DPS.ProductSubcategoryKey
order by 2

--22- Display all products along with their categoryname and subcategoryname
select DP.EnglishProductName,DPS.EnglishProductSubcategoryName,DPC.EnglishProductCategoryName
from DimProduct DP
join DimProductSubcategory DPS on DP.ProductSubcategoryKey =  DPS.ProductSubcategoryKey
join DimProductCategory DPC on DPC.ProductCategoryKey = DP.ProductSubcategoryKey
order by 3,2

--23- Display Departmentwise employee count
select COUNT (EmployeeKey)employeecount, DepartmentName
from DimEmployee
group by DepartmentName
order by employeecount desc

--24-ProductSubcategoryWise number of products from table DimProduct
select DPS.EnglishProductSubcategoryName, COUNT(DP.ProductKey) productcount
from DimProduct DP
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
group by DPS.EnglishProductSubcategoryName
order by 2 desc

--25HA-ProductSubcategoryWise number of products from table DimProduct whose SubcategoryKey Is Not null
select DPS.EnglishProductSubcategoryName, COUNT(DP.ProductKey)
from DimProduct DP
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
where DP.ProductSubcategoryKey is not null
group by DPS.EnglishProductSubcategoryName

--26HA-Display count of married female employees
select COUNT (EmployeeKey) marriedfemale 
from DimEmployee
where Gender = 'f' and MaritalStatus = 'M'

--27HA-Display Departmentwise count of married female employees
select DepartmentName, COUNT(EmployeeKey) Employeecount
from DimEmployee
where Gender = 'F' and MaritalStatus = 'M'
group by DepartmentName

--28-CustomersNameWise TotalSale And TotalFreight From FactInternetsales
select DC.FirstName+' ' + DC.LastName customername ,SUM(FIS.SalesAmount) Totalsale, SUM (FIS.Freight) Totalfreight
from FactInternetSales FIS
join DimCustomer DC on FIS.CustomerKey = DC.CustomerKey
group by DC.FirstName+' ' + DC.LastName
order by 2 desc

--29HA-ProductWise TotalSales From FactInternetSales
select DP.EnglishProductName, SUM(FIS.SalesAmount) Totalsales
from FactInternetSales FIS
join DimProduct DP on FIS.ProductKey = DP.ProductKey
group by DP.EnglishProductName

--30HA-ProductSubcategoryWise AverageSale From FactInternetSales
select DPS.EnglishProductSubcategoryName, AVG(FIS.SalesAmount) Totalsale
from FactInternetSales FIS
join DimProduct DP on DP.ProductKey = FIS.ProductKey
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
group by DPS.EnglishProductSubcategoryName

--31- CountryWise TotalSale In Descending  From FactResellerSales
select DG.EnglishCountryRegionName, sum(FRS.SalesAmount) totalsale
from FactResellerSales FRS
join DimReseller DR on DR.ResellerKey = FRS.ResellerKey
join DimGeography DG on DG.GeographyKey = DR.GeographyKey
group by DG.EnglishCountryRegionName
order by 2 desc

--32HA-CountryWise StateWise TotalSale From FactResellerSales (Hint Use Order by caluse)
select DG.EnglishCountryRegionName, DG.StateProvinceName, sum(SalesAmount) Totalsale
from FactResellerSales FRS
join DimReseller DR on DR.ResellerKey = FRS.ResellerKey
join DimGeography DG on DG.GeographyKey = DR.GeographyKey
group by DG.EnglishCountryRegionName, DG.StateProvinceName
order by 1,3 desc

--33HA-CountryWise Resellerwise TotalSale From FactResellerSales (Hint Use Order by caluse)
select DG.EnglishCountryRegionName, DR.ResellerName, sum(SalesAmount) Totalsale
from FactResellerSales FRS
join DimReseller DR on DR.ResellerKey = FRS.ResellerKey
join DimGeography DG on DG.GeographyKey = DR.GeographyKey
group by DG.EnglishCountryRegionName, DR.ResellerName
order by 1,3 desc
--34-FiscalYearWise EmployeesNameWise AverageSale From FactResellerSales
select DD.FiscalYear, DE.FirstName+' '+DE.LastName, avg(FRS.SalesAmount) avgsale
from FactResellerSales FRS
join DimEmployee DE on FRS.EmployeeKey = DE.EmployeeKey
join DimDate DD on DD.DateKey = FRS.OrderDateKey
group by DD.FiscalYear,  DE.FirstName+' '+DE.LastName
order by 1,3 desc

--35HA-SalesTerritoryGroupWise EmployeeWise CategoryWise Minimum And Maximum Sale From FactInternetSales
select DST.SalesTerritoryGroup, DE.FirstName+' ' + DE.LastName Employeename, DPC.EnglishProductCategoryName, min(FIS.SalesAmount) Minimumsale, MAX(FIS.SalesAmount)Maximumsale
from FactInternetSales FIS
join DimSalesTerritory DST on DST.SalesTerritoryKey = FIS.SalesTerritoryKey
join DimEmployee DE on DE.SalesTerritoryKey = DST.SalesTerritoryKey
join DimProduct DP on DP.ProductKey = FIS.ProductKey
join DimProductSubcategory DPS on DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey
join DimProductCategory DPC on DPC.ProductCategoryKey = DPS.ProductCategoryKey
group by DST.SalesTerritoryGroup, DE.FirstName+' '+DE.LastName, DPC.EnglishProductCategoryName
order by 1,2 

--36HA-Categorywise SubcategoryWise TotalSale for selected calender year From FIS
select DPC.EnglishProductCategoryName, DPS.EnglishProductSubcategoryName, SUM(FIS.SalesAmount) Totalsale
from FactInternetSales FIS
join DimProduct DP on FIS.ProductKey = DP.ProductKey
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
join DimProductCategory DPC on DPS.ProductCategoryKey = DPC.ProductCategoryKey
join DimDate DD on FIS.OrderDateKey = DD.DateKey
where DD.CalendarYear = 2008
group by DPC.EnglishProductCategoryName,DPS.EnglishProductSubcategoryName
order by 1,3 desc

--37-Display  SalesOrderNumber, SalesOrderLineNumber , AmountDue From FIS
select SalesOrderNumber, SalesOrderLineNumber, (SalesAmount+ TaxAmt+Freight) Amountdue
from FactInternetSales

--38-Display EmployeeKey, Employee's FullName , DepartmentName and ManagerName From DimEmployee
select DE.EmployeeKey,DE.FirstName+' '+DE.LastName EmployeeName, DE.DepartmentName,  TEMP.FirstName+' ' + TEMP.LastName
from DimEmployee DE
join DimEmployee TEMP on DE.ParentEmployeeKey = TEMP.EmployeeKey 

--39-Display ManagerName and TotalEmployees Reporting To That Manager 
select TEMP.FirstName+' '+TEMP.LastName ManagerName, COUNT(DE.EmployeeKey) TotalEmployee
from DimEmployee DE
join DimEmployee TEMP on DE.ParentEmployeeKey = TEMP.EmployeeKey
group by TEMP.FirstName+' '+TEMP.LastName

--40-Find the name  of  customers who has registered more than 60 orders From FIS
select DC.FirstName+' '+DC.LastName Customername , COUNT(*) ordercount
from FactInternetSales FIS
join DimCustomer DC on FIS.CustomerKey = DC.CustomerKey
group by DC.FirstName+' '+DC.LastName
having COUNT(*)>60
order by 2 desc

--41HA-Find name of customers who had placed orders more than one time From FIS
select DC.FirstName+' '+DC.LastName Customername, COUNT(SalesOrderNumber) Nooforder
from FactInternetSales FIS
join DimCustomer DC on FIS.CustomerKey = DC.CustomerKey
group by DC.FirstName+' '+DC.LastName
having COUNT(SalesOrderNumber) > 1
order by 2 desc

--42HA- Display categorywise Employeewise Total Sales Having Totalsales > 200000 From FIS
select DPC.EnglishProductCategoryName, DE.FirstName+' '+DE.LastName Employeename, sum(FIS.SalesAmount) Totalsale
from FactInternetSales FIS
join DimProduct DP on FIS.ProductKey = DP.ProductKey
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
join DimProductCategory DPC on DPS.ProductCategoryKey = DPC.ProductCategoryKey
join DimSalesTerritory DST on FIS.SalesTerritoryKey = DST.SalesTerritoryKey
join DimEmployee DE on DST.SalesTerritoryKey = DE.SalesTerritoryKey
group by DPC.EnglishProductCategoryName, DE.FirstName+' '+DE.LastName
having sum(FIS.SalesAmount) > 200000
order by 1,3 desc


--43- Which are the top 10 selling products from FactInternetSales
with productlist as(
select DP.EnglishProductName Productname, SUM(FIS.SalesAmount) Totalsales
from FactInternetSales FIS
join DimProduct DP on FIS.ProductKey = DP.ProductKey
group by DP.EnglishProductName
),
Sortedlist as (
select pl.Productname, pl.Totalsales, ROW_NUMBER() over ( order by pl.totalsales desc) serialnumber
from productlist pl 
)
select sl.serialnumber, sl.Productname,sl.totalsales
from Sortedlist sl
where serialnumber <= 10

--44HA-Which are the top 25 selling products in FactResellarSales
with productlist as(
select DP.EnglishProductName, SUM(FRS.SalesAmount) Totalsales
from FactResellerSales FRS
join DimProduct DP on FRS.ProductKey = DP.ProductKey
group by DP.EnglishProductName
), 
sortlist as (
select pl.EnglishProductName, PL.Totalsales, ROW_NUMBER () over (order by pl.totalsales desc) serialnumber
from productlist PL
)
select sl.EnglishProductName, sl.Totalsales, sl.serialnumber
from sortlist sl
where serialnumber <= 25

--45-Create the output which will give me top 3 products by EmployeeFullName from
--FactResellerSales for fiscal year 2007
with Employeeproductlist as (
select DE.FirstName+' '+DE.LastName Employeename,DP.EnglishProductName, sum(FRS.SalesAmount) totalsales
from FactResellerSales FRS
join DimProduct DP on FRS.ProductKey = DP.ProductKey
join DimEmployee DE on FRS.EmployeeKey = DE.EmployeeKey
join DimDate DD on FRS.OrderDateKey = DD.DateKey
where FiscalYear = 2007
group by DE.FirstName+' '+DE.LastName,DP.EnglishProductName
),
sortedlist as(
select EPL.Employeename,EPL.EnglishProductName,EPL.totalsales, DENSE_RANK() over(partition by epl.employeename order by epl.totalsales desc) serialnumber
from Employeeproductlist EPL
)
select sl.serialnumber,sl.Employeename,sl.EnglishProductName,sl.totalsales
from sortedlist SL
where serialnumber <= 3

--46HA-Subcategorywise top 2 Selling  products from FactInternetSales
with subproductlsit as(
select DPS.EnglishProductSubcategoryName, dp.EnglishProductName ,sum(fis.SalesAmount) totalsales
from FactInternetSales FIS
join DimProduct DP on fis.ProductKey = DP.ProductKey
join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
group by DPS.EnglishProductSubcategoryName,dp.EnglishProductName
),
sortedlist as (
select spl.EnglishProductSubcategoryName,spl.EnglishProductName,spl.totalsales, DENSE_RANK() over (partition by spl.EnglishProductSubcategoryName order by totalsales desc)serialnumber
from subproductlsit SPL
)
select sl.serialnumber,sl.EnglishProductName,sl.EnglishProductSubcategoryName,sl.totalsales
from sortedlist sl
where serialnumber <= 2

--47-create output from FRS to list the Products where Products TotalSale < average sale per product
with avgproduct as(
select sum(FRS.SalesAmount)/COUNT(distinct frs.ProductKey) averagesaleproduct
from FactResellerSales FRS
)
select EnglishProductName, sum(TEMP.SalesAmount) Totalsales, averagesaleproduct
from avgproduct,FactResellerSales TEMP
join DimProduct DP on  TEMP.ProductKey = DP.ProductKey
group by EnglishProductName,averagesaleproduct
having SUM(temp.salesamount) < averagesaleproduct
order by 2 desc

--49- From FactInternetSales Each Employees highest and lowest selling Product For Given Year
with productlist as(
select de.FirstName+' '+de.LastName Employeename,dp.EnglishProductName, sum(fis.SalesAmount) totalsales
from FactInternetSales FIS
join DimSalesTerritory DST on fis.SalesTerritoryKey = dst.SalesTerritoryKey
join DimEmployee DE ON dst.SalesTerritoryKey = de.SalesTerritoryKey
join DimProduct DP on fis.ProductKey = dp.ProductKey
join DimDate dd on fis.OrderDateKey = dd.DateKey
where dd.FiscalYear = 2008
group by de.FirstName+' '+de.LastName,dp.EnglishProductName
),
shortedlistdesc as(
select pl.Employeename,pl.EnglishProductName,pl.totalsales, ROW_NUMBER() over( partition by pl.employeename order by pl.totalsales desc) serialnumber
from productlist pl
),
highestsellingproduct as(
select sld.Employeename,sld.EnglishProductName,sld.totalsales
from shortedlistdesc Sld
where sld.serialnumber = 1
),
sortlistasc as(
select pl.Employeename,pl.EnglishProductName,pl.totalsales, ROW_NUMBER() over( partition by pl.employeename order by pl.totalsales) serialnumber
from productlist pl),
lowestsellingproduct as(
select sla.Employeename,sla.EnglishProductName,sla.totalsales
from sortlistasc sla
where sla.serialnumber = 1
)
select hsp.Employeename,hsp.EnglishProductName,hsp.totalsales,lsp.EnglishProductName,lsp.totalsales
from highestsellingproduct hsp
join lowestsellingproduct lsp on hsp.Employeename = lsp.Employeename


--48HA-Give me the list of  countries whose sales is greater AverageSalepercountry from FactResellerSales

--50HA- From FactInternetSales display only those employees selling highest and lowest  Product for a selected year
--51HA-Display yearwise highest and lowest selling product along with the employeename From FIS