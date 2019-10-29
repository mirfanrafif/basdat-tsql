-- CREATE VIEW Sales.CategoryQtyYear
-- AS
-- SELECT
--   c.categoryname as Category,
--   od.qty as qty,
--   YEAR(o.orderdate) as orderyear
-- FROM
-- Production.Categories as c
-- INNER JOIN Production.Products as p on c.categoryid = p.categoryid
-- INNER JOIN Sales.OrderDetails as od on p.productid = od.productid
-- INNER JOIN Sales.Orders as o on od.orderid = o.orderid;

SELECT *
FROM (
  SELECT Category, qty, orderyear FROM Sales.CategoryQtyYear
) as d
PIVOT (
  SUM(qty) FOR orderyear IN ([2006], [2007], [2008])
) as pvt
ORDER BY Category

-- CREATE TABLE [Sales].[PivotedCategorySales](
--   [Category] [nvarchar](15) NOT NULL,
--   [2006] [int] NULL,
--   [2007] [int] NULL,
--   [2008] [int] NULL
-- );
-- GO

INSERT INTO Sales.PivotedCategorySales (Category, [2006], [2007], [2008])
SELECT *
FROM (
  SELECT Category, qty, orderyear FROM Sales.CategoryQtyYear
) as d
PIVOT (
  SUM(qty) FOR orderyear IN ([2006], [2007], [2008])
) as pvt
ORDER BY Category

SELECT * FROM Sales.PivotedCategorySales

SELECT Category, qty, orderyear FROM Sales.PivotedCategorySales
UNPIVOT(qty FOR orderyear in ([2006], [2007], [2008])) as unpvt

