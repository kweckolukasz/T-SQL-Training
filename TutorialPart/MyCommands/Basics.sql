/*Najpierw podstawy*/
/*
SELECT
    nazwa_kolumny
FROM
    folder_tabeli.nazwa_tabeli
WHERE
    wartosci_w_kolumnie = 'to czego szukasz'
GROUP BY
    argument
HAVING
    COUNT (*) > 10 wyœwietli tylko te wyniki które maj¹ minimum 10 wyst¹pieñ w tabeli
ORDER BY
    city;

----przedzia³ danych----
offset x rows
fetch next/first y rows


----przedzia³ startowy danych----
select * top x with ties
! Tylko z order by

----eliminacja powturzeñ----
select distinct column
from ..
! podobne dzia³anie do group by którego generalnie lepiej u¿ywaæ bo pozwala na u¿ywanie funkcji

----filtrowanie where----
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition; / condition1 and condition2 / condition1 or condition2
	/ condition in (value1, value2, value3...) - zwraca tylko te które maj¹ jedn¹ z podanych wartoœci
	/ condition like value - zwraca tylko te które maj¹ w sobie ci¹g '%value%'

----Grupowanie wyników----
SELECT
    select_list
FROM
    table_name
GROUP BY
    column_name1,
    column_name2 ,...;

-----£¹czenie wyników-----
#£¹czenie wspólnych wyników z dwóch tabel
SELECT
	select_list
FROM
	source
	INNER JOIN other_source
		ON condition
*/

--najwiêcej modeli jest z roku:
--select top 1 model_year, count (*) count
--from production.products
--group by model_year
--order by count desc


--10 najdro¿szych modeli:
--select product_name, model_year, list_price price
--from production.products
--order by price desc
--offset 0 rows
--fetch first 10 rows only

--prawie to samo tylko w inny sposób - with ties powoduje zwrócenie równie¿ tych rekordów które zremisowa³y
--select top 10 with ties 
--product_name product, model_year year, list_price price
--from production.products
--order by list_price desc

--w jakim sklepie jest najwiêcej zamówieñ (id)
--select top 1 store_id 'store ID', count(store_id)
--from sales.orders
--group by store_id
--order by count('store ID') desc

--5 najdro¿szych modeli roku 2016
--select top 5 product_name + ' - ' + convert(varchar, list_price) As 'Model - price'
--from production.products
--where model_year = 2016
--order by list_price desc

--rowery ze s³owem 'Amsterdam' w nazwie
--select product_name
--from production.products
--where product_name like '%amsterdam%'

--rowery z nazw¹ 'Amsterdam'
--select product_name
--from production.products
--where product_name = 'amsterdam'

--wyœwietl id 1,2 klientów sk³adaj¹cych zamówienia w poszczegulnych latach
--select customer_id ID, year(order_date) year
--from sales.orders
--where customer_id in (1,2)
--order by customer_id


--zsumuj iloœæ zamówieñ klientów id 1,2 w poszczegulnych latach																	?????????????
--select o.customer_id ID, YEAR(o.order_date) year, count(o.customer_id) count
--from sales.orders o
--where customer_id in (1,2)
--group by o.customer_id, YEAR(o.order_date)
--order by year(o.order_date)

--zsumuj klientów w poszczegulnych miastach
--select c.city, COUNT(c.customer_id) clients
--from sales.customers c
--group by c.city
--order by clients desc


--##########JOINS############
--create schema hr
--go
--create table hr.candidates(
--id int primary Key identity,
--fullname varchar(100) not null
--)
--create table hr.employees(
--id int primary key identity,
--fullname varchar(100) not null
--)
--insert into 
--hr.candidates(fullname)
--values
--('John Doe'),
--('Lily Bush'),
--('Peter Drucker'),
--('Jane Doe');
--insert into 
--hr.employees(fullname)
--values
--('John Doe'),
--('Jane Doe'),
--('Michael Scott'),
--('Jack Sparrow');

--ZnajdŸ kandydatów i pracowników 
--o takich samych danych osobowych					INNER JOIN

--select
--c.id, c.fullname, e.id, e.fullname
--from
--hr.candidates c
--inner join hr.employees e
--on e.fullname = c.fullname;

--poka¿ listê kandydatów i pracowników tak ¿eby 
--powtarzaj¹ce siê dane by³y w tym samym wierszu	LEFT JOIN | LEFT OUTER JOIN
--w tym przypadku dzia³a podobnie do INNER JOIN

--SELECT 
--	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
--from 
--	hr.candidates c
--	left join hr.employees e
--		on e.fullname = c.fullname

--to samo co wy¿ej tylko bez powtórzeñ
--SELECT 
--	c.id, c.fullname, e.id, e.fullname
--from 
--	hr.candidates c
--	left join hr.employees e
--		on e.fullname = c.fullname
--where
--	e.fullname is null

--teraz w dróg¹ stronê
select 
	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
from 
	hr.candidates c
	right join hr.employees e
		on e.fullname = c.fullname

--select
--	c.id, c.fullname
--from hr.candidates c

select 
	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
from 
	hr.candidates c
	FULL JOIN hr.employees e
	on e.fullname = c.fullname
