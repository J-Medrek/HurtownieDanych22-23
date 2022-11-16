--zad 1

with order_count_per_date as 
(select [OrderDateKey],count(SalesOrderNumber) as order_count
from FactInternetSales
group by orderdatekey)

select *,avg(order_count) over (order by OrderDateKey rows between 2 preceding and current row) as rolling_avg
from order_count_per_date;

--zad 2
select MonthNumberOfYear, [1],IsNull([2],0) as '2',IsNull([3],0) as '3',[4],IsNull([5],0) as '5',[6],[7],[8],[9],[10]
from
(select SalesAmount,SalesTerritoryKey,MonthNumberOfYear
from FactInternetSales 
inner join DimDate
on FactInternetSales.OrderDateKey = DimDate.DateKey
where CalendarYear=2011) s
pivot
(sum(SalesAmount) for SalesTerritoryKey in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10])) as pvt
order by pvt.MonthNumberOfYear;


--zad3
select OrganizationKey,DepartmentGroupKey,sum(Amount) as amount
from FactFinance
group by rollup(OrganizationKey,DepartmentGroupKey)
order by OrganizationKey;

--zad4
select OrganizationKey,DepartmentGroupKey,sum(Amount) as amount
from FactFinance
group by cube(OrganizationKey,DepartmentGroupKey)
order by OrganizationKey;

--zad5
with amount_per_organization as (select OrganizationKey,sum(Amount) as amount
from FactFinance
where YEAR(date) = 2012
group by OrganizationKey)

select apo.OrganizationKey,do.OrganizationName,apo.amount,
percent_rank() over (order by amount) as percentile
from amount_per_organization apo
inner join DimOrganization do on apo.OrganizationKey=do.OrganizationKey
order by percentile desc;

--zad6
with amount_per_organization as (select OrganizationKey,sum(Amount) as amount
from FactFinance
where YEAR(date) = 2012
group by OrganizationKey)

select apo.OrganizationKey,do.OrganizationName,apo.amount,
percent_rank() over (order by amount) as percentile,
stdev(amount) over (order by amount) as stdev
from amount_per_organization apo
inner join DimOrganization do on apo.OrganizationKey=do.OrganizationKey
order by apo.OrganizationKey;