#part one : list all countries in south america 
SELECT Name FROM Country WHERE Continent = 'South America';
#find th epopulation of germany 
SELECT Population FROM Country WHERE Name = 'Germany';
#Retrieve all cities in the country 'Japan':
SELECT Name FROM City WHERE CountryCode = (SELECT Code FROM Country WHERE Name = 'Japan');
#Find the 3 most populated countries in the 'Africa' region:
SELECT Name, Population FROM Country WHERE Region = 'Africa' ORDER BY Population DESC LIMIT 3;
Retrieve the country and its life expectancy where the population is between 1 and 5 million:
SELECT Name, LifeExpectancy FROM Country WHERE Population BETWEEN 1000000 AND 5000000;
#List countries with an official language of 'French':
SELECT c.Name FROM Country c JOIN CountryLanguage cl ON c.Code = cl.CountryCode WHERE cl.Language = 'French' AND cl.IsOfficial = 'T';
#Retrieve all album titles by the artist 'AC/DC':
SELECT a.Title FROM Album a JOIN Artist ar ON a.ArtistId = ar.ArtistId WHERE ar.Name = 'AC/DC';
#Find the name and email of customers located in 'Brazil':
SELECT FirstName, LastName, Email FROM Customer WHERE Country = 'Brazil';
#List all playlists in the database:
SELECT Name FROM Playlist;
#Find the total number of tracks in the 'Rock' genre:
SELECT COUNT(*) FROM Track WHERE GenreId = (SELECT GenreId FROM Genre WHERE Name = 'Rock');
#List all employees who report to 'Nancy Edwards':
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');
#Calculate the total sales per customer by summing the total amount in invoices:
SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS TotalSales
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;



#part 2 Create Your Own Database - 
#Books: Stores information about books (BookID, Title, Author, Price, Genre).
#Customers: Stores customer information (CustomerID, FirstName, LastName, Email, Address).
#Sales: Stores sales data (SaleID, BookID, CustomerID, Date, Quantity).
#tables 
##Create the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Price DECIMAL(5, 2),
    Genre VARCHAR(50)
);

##Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

##Create the Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    Date DATE,
    Quantity INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

#data 
##Insert into Books
INSERT INTO Books (BookID, Title, Author, Price, Genre) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 10.99, 'Fiction'),
(2, 'Water Fire Saga', 'Jennifer Donnelly', 14.99, 'Fantasy'),
(3, 'Hatchet', 'Gary Paulsen', 11.99, 'Fiction'),
(4, 'Hannah', 'Kathrin Lasky', 15.99, 'Fantasy');

##Insert into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address) VALUES
(1, 'Natasjh', 'Stone', 'natasjh.stone@example.com', '123 Ocean Ave'),
(2, 'Mihret', 'Sisay', 'mihret.sisay@example.com', '456 River Rd'),
(3, 'Oyshi', 'Karim', 'oyshi.karim@example.com', '789 Mountain St'),
(4, 'Sitina', 'Mesfin', 'sitina.mesfin@example.com', '101 Sky Blvd');

##Insert into Sales
INSERT INTO Sales (SaleID, BookID, CustomerID, Date, Quantity) VALUES
(1, 1, 1, '2023-09-01', 2),
(2, 2, 2, '2023-09-02', 1),
(3, 3, 3, '2023-09-03', 3),
(4, 4, 4, '2023-09-04', 1);

#Retrieve the name of all customers who purchased 'To Kill a Mockingbird':
SELECT c.FirstName, c.LastName 
FROM Customers c 
JOIN Sales s ON c.CustomerID = s.CustomerID 
JOIN Books b ON s.BookID = b.BookID 
WHERE b.Title = 'To Kill a Mockingbird';

#Find the total sales for each customer:
SELECT c.FirstName, c.LastName, SUM(s.Quantity) AS TotalBooksBought
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID;

##List all books sold on a specific date (e.g., '2023-09-03'):
ELECT b.Title, s.Quantity 
FROM Books b
JOIN Sales s ON b.BookID = s.BookID
WHERE s.Date = '2023-09-03';






