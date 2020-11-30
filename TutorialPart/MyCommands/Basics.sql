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
	source.select_list, other_source.select_list
FROM
	source
	INNER JOIN other_source
		ON condition

Left join - zostanie pobrana ca³a zawartoœæ lewej tabelki i taka sama iloœæ prawej
Cross Join - do ka¿dego elementu z T1 zostanie do³¹czony element z T2
SELECT
	select_list
FROM
	T1
CROSS JOIN T2;
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
--select customer_id, YEAR(order_date) year, count(*) orders
--from sales.orders
--where customer_id in (1,2) 
--group by YEAR(order_date), customer_id

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
--select 
--	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
--from 
--	hr.candidates c
--	right join hr.employees e
--		on e.fullname = c.fullname

--select
--	c.id, c.fullname
--from hr.candidates c

--select 
--	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
--from 
--	hr.candidates c
--	FULL JOIN hr.employees e
--	on e.fullname = c.fullname

--jakie rodzaje rowerów najlepiej siê sprzedaj¹
--select count(oi.quantity) quantity, cat.category_name
--from sales.order_items oi

--inner join production.products prod
--	on oi.product_id = prod.product_id

--inner join  production.categories cat
--	on prod.category_id = cat.category_id

--inner join sales.orders o
--	on oi.order_id = o.order_id

--where o.order_status = 4
--group by cat.category_name
--order by quantity desc

--10 pracowników którzy obs³u¿yli najwiêcej klientów

--select top 10 with ties o.staff_id, count(*) count
--from sales.orders o
--group by o.staff_id
--order by count desc

--znajdŸ produkty(ID) które nie maj¹ sprzeda¿y w sklepach
--SELECT
--    s.store_id,
--    p.product_id,
--    ISNULL(sales, 0) sales
--FROM
--    sales.stores s
--CROSS JOIN production.products p
--LEFT JOIN (
--    SELECT
--        s.store_id,
--        p.product_id,
--        SUM (quantity * i.list_price) sales
--    FROM
--        sales.orders o
--    INNER JOIN sales.order_items i ON i.order_id = o.order_id
--    INNER JOIN sales.stores s ON s.store_id = o.store_id
--    INNER JOIN production.products p ON p.product_id = i.product_id
--    GROUP BY
--        s.store_id,
--        p.product_id
--) c ON c.store_id = s.store_id
--AND c.product_id = p.product_id
--WHERE
--    sales IS NULL
--ORDER BY
--    product_id,
--    store_id;
--															SELF JOIN
--pair staff with their manager
--select 
--	e.first_name + ' ' + e.last_name as employee,
--	m.first_name + ' ' + m.last_name as manager
--from sales.staffs e
--left join sales.staffs m
--on e.manager_id = m.staff_id
--order by m.manager_id

--locate customers that live in the same city
--SELECT 
--c.city, c.first_name + ' ' + c.last_name customer, c1.first_name + ' ' + c1.last_name customer
--from sales.customers c
--inner join sales.customers c1 on c1.city = c.city and c1.customer_id < c.customer_id

-- find customers who placed at least two orders per year
--select c.customer_id, YEAR(o.order_date) order_year, count(o.order_id)
--from sales.customers c
--inner join sales.orders o on o.customer_id = c.customer_id
--group by c.customer_id, YEAR(o.order_date)
--having count(o.order_id) >= 2

--find sales orders whose net values are greater than 20 000
--select order_id, SUM(quantity * list_price * (1 - discount)) net_value
--from sales.order_items
--group by order_id
--having SUM(quantity * list_price * (1 - discount)) > 20000
--order by net_value

--find max and min price in each product category if max price > 4000 and min price < 500
--select
--category_id, MAX(list_price) maximum_price, MIN(list_price) minimum_price
--from production.products
--group by category_id
--having max(list_price) > 4000 and min(list_price) < 500
