--ranking po iloœci zamówieñ pogrupowanych od carrierów

with transactions_per_carrier(carrier,count)
AS (
select s.carrierKey,count(salesKey) from FactSales s
inner join DIMCarriers c on s.carrierKey = c.carrierKey
group by s.carrierKey)

SELECT car.carrier_name,t.count,
rank() over(order by t.count desc) as ranking
FROM transactions_per_carrier t inner join DIMCarriers car
on car.carrierKey = t.carrier;


--ranking po iloœci zamówieñ pogrupowanych po godzinie
with transactions_per_Hour(hour,count)
AS (
select d.Hour,count(s.salesKey) from FactSales s
inner join DIMDate d on s.dateKey = d.id
group by d.Hour)

SELECT t.hour,t.count,
rank() over(order by t.count desc) as ranking
from transactions_per_Hour t;

--ranking procentowy sprzedazy w ciagu roku

with amount_per_carrier_and_date(year,carrier,sum)
AS (
select d.Year,c.carrierKey,sum(CAST( ds.amount as float)) as sales
from FactSales s
inner join DIMDate d on s.dateKey = d.id
inner join DIMCarriers c on s.carrierKey = c.carrierKey
inner join DIMSales ds on s.salesKey = ds.id
group by d.Year,c.carrierKey)

SELECT t.year,t.carrier,t.sum,
percent_rank() over (order by t.sum) as percent_rank
from amount_per_carrier_and_date t
inner join DIMCarriers c on t.carrier = c.carrierKey
order by percent_rank desc;

--srednia kroczaca z sprzedazy dla 3 ostatnich miesiecy dla kazdego dostawcy

with amount_per_month_and_carrier(month,carrier_id,amount)
AS (
select d.Month,c.carrier_id,sum(cast( ds.amount as float)) as amount from FactSales s
inner join DIMDate d on s.dateKey = d.id
inner join DIMSales ds on ds.id = s.salesKey
inner join DIMCarriers c on s.carrierKey = c.carrierKey
group by d.Month,c.carrier_id)

SELECT t.month,t.amount,
AVG(t.amount) OVER (PARTITION BY t.carrier_id ORDER BY t.month ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS kroczaca
from amount_per_month_and_carrier t;