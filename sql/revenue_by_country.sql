select * from online_retail

-- агрегация по странам, выручка
with t as
(select * from online_retail
where Quantity > 0)
select Country, Invoice, sum(Quantity * Price) as Revenue from t
group by Invoice, Country 
