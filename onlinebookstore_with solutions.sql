create database BookStore
use BookStore
--Retrieve all books in the "Fiction" genre

SELECT * FROM Books
WHERE Genre='FICTION'


----Find books published after the year 1950

select * from books
where published_year>1950
order by Published_Year asc

--List all customers from the Canada

select * from Customers
where country='canada'

---Show orders placed in November 2023

select * from Orders
where Order_Date between '2023-11-01' and '2023-11-30'
order by Order_Date asc

--Retrieve the total stock of books available

select sum(stock) as TotalStock
from Books

--Find the details of the most expensive book

select top 1 * from Books
order by Price desc

--Show all customers who ordered more than 1 quantity of a book

select * from Orders
where Quantity>1
order by Quantity asc

--Retrieve all orders where the total amount exceeds $20

select * from Orders
where Total_Amount>$20
order by Total_Amount asc

--List all genres available in the Books table
 
 select genre
 from Books


--Find the book with the lowest stock

SELECT TOP 1 * FROM BOOKS
ORDER BY Stock ASC

--Retrieve the total number of books sold for each genre

SELECT BOOKS.Genre, SUM(ORDERS.Quantity)AS TOTAL_BOOKS_SOLD
FROM Orders
JOIN BOOKS ON BOOKS.BOOK_id = ORDERS.BOOK_id
GROUP BY BOOKS.Genre;

--Find the average price of books in the "Fantasy" genre

SELECT ROUND(AVG(PRICE),2) as Avg_PRice
from Books
where Genre='fantasy';

--List customers who have placed at least 2 orders

SELECT Customers.Name, COUNT(Orders.Order_Date) AS ORDER_QTY
FROM ORDERS
JOIN CUSTOMERS ON Customers.Customer_ID =ORDERS.Customer_ID
GROUP BY Customers.NAME
HAVING  COUNT(Orders.Order_Date)>2
ORDER BY ORDER_QTY ASC

--Find the most frequently ordered book

SELECT BOOKS.TITLE, COUNT(Orders.Order_Date) AS BOOKS_QTY
FROM ORDERS
JOIN BOOKS ON BOOKS.Book_ID=Orders.Book_ID
GROUP BY BOOKS.Title
ORDER BY BOOKS_QTY DESC

use BookStore
--Show the top 3 most expensive books of 'Fantasy' Genre

select title, genre, price from books

select top 3 * from books
where Genre='fantasy'
order by Price desc

SELECT TOP 3 
    Book_ID, 
    Title, 
    Genre, 
    ROUND(Price, 2) AS Price
FROM Books
WHERE Genre = 'fantasy'
ORDER BY Price DESC;

--Retrieve the total quantity of books sold by each author

select books.Author, sum(Orders.Quantity) as total_quantity
from orders
join Books on Books.Book_ID=Orders.Book_ID
group by books.Author
order by total_quantity desc

--List the cities where customers who spent over $30 are located

select Customers.City, round(orders.Total_Amount, 2) as TotalAmt
from Orders
join Customers on Customers.Customer_ID=Orders.Customer_ID
where orders.Total_Amount>30
order by Total_Amount asc

--Find the customer who spent the most on orders

select top 1 customers.name, Round(sum(orders.Total_Amount),2) as totalamt_spent
from orders
join Customers on Customers.Customer_ID=Orders.Customer_ID
group by customers.Name
order by totalamt_spent desc

use BookStore

--Calculate the stock remaining after fulfilling all orders


select books.Book_ID, books.Title, books.Stock, 
coalesce(sum(Orders.Quantity),0) as Order_Quantity,
books.Stock-coalesce(sum(Orders.Quantity),0) as Remaining_Quantity
from books
left join orders on books.Book_ID=Orders.Book_ID
group by books.Book_ID, Books.Title, Books.Stock



 


SELECT 
    books.Book_ID, 
    books.Title, 
    books.Stock, 
    COALESCE(SUM(orders.Quantity), 0) AS Order_Quantity,
    books.Stock - COALESCE(SUM(orders.Quantity), 0) AS Remaining_Quantity
FROM 
    books
LEFT JOIN 
    orders ON books.Book_ID = orders.Book_ID
GROUP BY 
    books.Book_ID, books.Title, books.Stock;

