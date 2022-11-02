
SELECT TOP 1 date FROM cwiczenia4_staging.dbo.Orders ORDER BY date

DECLARE @StartDate  date = '20150101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 10, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    Date         = CONVERT(date, d),
    Day          = DATEPART(DAY,       d),
    Week         = DATEPART(WEEK,      d),
    Month        = DATEPART(MONTH,     d),
    Quarter      = DATEPART(Quarter,   d),
    Year         = DATEPART(YEAR,      d)
  FROM d
)
SELECT * INTO DIMDate FROM src
  ORDER BY Date
  OPTION (MAXRECURSION 0);