-- база для RFM по клиентам
with customer_revenue as
(select * from online_retail
 where Quantity > 0 and `Customer ID` is not null and Price > 0),
freq as
(select `Customer ID`, count(distinct Invoice) as F
 from customer_revenue
 group by `Customer ID`),
t as
(select `Customer ID`, InvoiceDate,
        max(InvoiceDate) over () as max_d,
        max(InvoiceDate) over (partition by `Customer ID`) as customer_m_d,
        sum(Quantity * Price) over (partition by `Customer ID`) as M
 from customer_revenue)
select distinct t.`Customer ID`,
       TIMESTAMPDIFF(DAY, t.customer_m_d, t.max_d) as R,
       freq.F,
       t.M
from t
join freq on t.`Customer ID` = freq.`Customer ID`


