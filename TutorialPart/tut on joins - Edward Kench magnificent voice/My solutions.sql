--All customers who had sales in march 2013
--OrderDate, FirstName
--select OrderDate, c.CustomerId, c.FirstName
--From Sale s
--Inner join Customer c on c.CustomerId = s.CustomerId
--where Month(OrderDate) = 3

--How much customers spend per product in the montch of march
--select c.FirstName, c.lastname, p.productName, SUM(sd.quantity * p.ProductPrice) Total 
--from Customer c
--join Sale s on s.CustomerId = c.CustomerId
--join SaleDetail sd on sd.SaleId= s.SaleId
--join Product p on sd.ProductId = p.ProductId
--where MONTH(s.OrderDate) = 3
--group by c.FirstName, c.LastName, p.ProductName
--order by Total desc

--check 
--select c.firstname, c.lastname, p.productname, sd.quantity, p.ProductPrice
--from Customer c
--join Sale s on s.CustomerId = c.CustomerId
--join SaleDetail sd on sd.SaleId= s.SaleId
--join Product p on sd.ProductId = p.ProductId
--where MONTH(s.OrderDate) = 3
--order by ProductName, FirstName

-- on what product customers spend the most in the montch of march
--select p.productName, SUM(sd.quantity * ProductPrice) sum from product p
--join SaleDetail sd on sd.ProductId = p.ProductId
--join Sale s on s.SaleId = sd.saleId
--where MONTH(s.OrderDate) = 3
--group by p.ProductName
--order by sum desc


--Who bought products
--select ProductName, FirstName 
--from product
--inner join SaleDetail on product.ProductId = SaleDetail.ProductId
--inner join Sale on SaleDetail.SaleId = Sale.SaleId
--inner join Customer on Sale.CustomerId = Customer.CustomerId

--Who didn't buy products
--select c.firstname, c.lastname, sd.SaledetailId from customer c
--join  Sale s on s.CustomerId = c.CustomerId
--right join saledetail sd on sd.saleid = s.saleid
 