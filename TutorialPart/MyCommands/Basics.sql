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
    COUNT (*) > 10 wy�wietli tylko te wyniki kt�re maj� minimum 10 wyst�pie� w tabeli
ORDER BY
    city;

----przedzia� danych----
offset x rows
fetch next/first y rows


----przedzia� startowy danych----
select * top x with ties
! Tylko z order by

----eliminacja powturze�----
select distinct column
from ..
! podobne dzia�anie do group by kt�rego generalnie lepiej u�ywa� bo pozwala na u�ywanie funkcji

----filtrowanie where----
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition; / condition1 and condition2 / condition1 or condition2
	/ condition in (value1, value2, value3...) - zwraca tylko te kt�re maj� jedn� z podanych warto�ci
	/ condition like value - zwraca tylko te kt�re maj� w sobie ci�g '%value%'

----Grupowanie wynik�w----
SELECT
    select_list
FROM
    table_name
GROUP BY
    column_name1,
    column_name2 ,...;

-----��czenie wynik�w-----
#��czenie wsp�lnych wynik�w z dw�ch tabel
SELECT
	source.select_list, other_source.select_list
FROM
	source
	INNER JOIN other_source
		ON condition

Left join - zostanie pobrana ca�a zawarto�� lewej tabelki i taka sama ilo�� prawej
Cross Join - do ka�dego elementu z T1 zostanie do��czony element z T2
SELECT
	select_list
FROM
	T1
CROSS JOIN T2;
*/

--najwi�cej modeli jest z roku:
--select top 1 model_year, count (*) count
--from production.products
--group by model_year
--order by count desc


--10 najdro�szych modeli:
--select product_name, model_year, list_price price
--from production.products
--order by price desc
--offset 0 rows
--fetch first 10 rows only

--prawie to samo tylko w inny spos�b - with ties powoduje zwr�cenie r�wnie� tych rekord�w kt�re zremisowa�y
--select top 10 with ties 
--product_name product, model_year year, list_price price
--from production.products
--order by list_price desc

--w jakim sklepie jest najwi�cej zam�wie� (id)
--select top 1 store_id 'store ID', count(store_id)
--from sales.orders
--group by store_id
--order by count('store ID') desc

--5 najdro�szych modeli roku 2016
--select top 5 product_name + ' - ' + convert(varchar, list_price) As 'Model - price'
--from production.products
--where model_year = 2016
--order by list_price desc

--rowery ze s�owem 'Amsterdam' w nazwie
--select product_name
--from production.products
--where product_name like '%amsterdam%'

--rowery z nazw� 'Amsterdam'
--select product_name
--from production.products
--where product_name = 'amsterdam'

--wy�wietl id 1,2 klient�w sk�adaj�cych zam�wienia w poszczegulnych latach
--select customer_id ID, year(order_date) year
--from sales.orders
--where customer_id in (1,2)
--order by customer_id


--zsumuj ilo�� zam�wie� klient�w id 1,2 w poszczegulnych latach																	?????????????
--select o.customer_id ID, YEAR(o.order_date) year, count(o.customer_id) count
--from sales.orders o
--where customer_id in (1,2)
--group by o.customer_id, YEAR(o.order_date)
--order by year(o.order_date)

--zsumuj klient�w w poszczegulnych miastach
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

--Znajd� kandydat�w i pracownik�w 
--o takich samych danych osobowych					INNER JOIN

--select
--c.id, c.fullname, e.id, e.fullname
--from
--hr.candidates c
--inner join hr.employees e
--on e.fullname = c.fullname;

--poka� list� kandydat�w i pracownik�w tak �eby 
--powtarzaj�ce si� dane by�y w tym samym wierszu	LEFT JOIN | LEFT OUTER JOIN
--w tym przypadku dzia�a podobnie do INNER JOIN

--SELECT 
--	c.id cid, c.fullname cfn, e.id eid, e.fullname efn
--from 
--	hr.candidates c
--	left join hr.employees e
--		on e.fullname = c.fullname

--to samo co wy�ej tylko bez powt�rze�
--SELECT 
--	c.id, c.fullname, e.id, e.fullname
--from 
--	hr.candidates c
--	left join hr.employees e
--		on e.fullname = c.fullname
--where
--	e.fullname is null

--teraz w dr�g� stron�
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

--jakie rodzaje rower�w najlepiej si� sprzedaj�
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

--10 pracownik�w kt�rzy obs�u�yli najwi�cej klient�w

--select top 10 with ties o.staff_id, count(*) count
--from sales.orders o
--group by o.staff_id
--order by count desc

--znajd� produkty(ID) kt�re nie maj� sprzeda�y w sklepach
--select *
--from sales.orders o
--right join sales.order_items oi
--on oi.order_id = o.order_id
--where o.order_status = 3
--bra� pod uwag� ordery z order_status = 3 -> 'Rejected'? Tak, nie by�y nigdy zam�wione albo by�y ale zam�wienie wycofano

--poka� sprzeda� poszczegulnych artyku��w w poszczegulnych sklepach i ich stan magazynowy dla tych artyku��w
--articleId, shopId,  quantity(sales), quantity(warehouse)
select p.product_name, s.store_name, oi.quantity sold
from production.products p
inner join production.stocks st on st.product_id = p.product_id 
inner join sales.stores s on st.store_id = s.store_id
inner join sales.orders o on o.store_id = s.store_id
inner join sales.order_items oi on oi.order_id = o.order_id
group by p.product_name, s.store_name, oi.quantity


