-- агрегация по месяцам, выручка
with t as
(select * from online_retail
where Quantity > 0)
select DATE_FORMAT(InvoiceDate, "%Y-%m") as Date, sum(Quantity * Price) as Revenue from t
group by Date
