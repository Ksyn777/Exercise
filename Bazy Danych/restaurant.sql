CREATE DATABASE restaurant; 
USE restaurant;

SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    opening_hours VARCHAR(100)
);

CREATE TABLE Tables (
    id INT PRIMARY KEY,
    table_number INT,
    capacity INT,
    description VARCHAR(255),
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(id)
);

CREATE TABLE Customers (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    registration_date DATE
);

CREATE TABLE Reservations (
    id INT PRIMARY KEY,
    customer_id INT,
    table_id INT,
    date DATE,
    time TIME,
    party_size INT,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (table_id) REFERENCES Tables(id)
);

CREATE TABLE Menu (
    id INT PRIMARY KEY,
    dish_name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50),
    description VARCHAR(255),
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(id)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    reservation_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(id)
);

CREATE TABLE Order_Items (
    id INT PRIMARY KEY,
    order_id INT,
    menu_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (menu_id) REFERENCES Menu(id)
);


-- Restauracje
INSERT INTO Restaurants VALUES
(1, 'La Piazza', 'ul. Włoska 5, Warszawa', '123-456-789', '10:00-22:00'),
(2, 'Sushi World', 'ul. Japońska 10, Kraków', '987-654-321', '12:00-23:00');

-- Stoliki
INSERT INTO Tables VALUES
(1, 1, 2, 'Stolik przy oknie', 1),
(2, 2, 4, 'Stolik centralny', 1),
(3, 3, 6, 'Stolik rodzinny', 1),
(4, 4, 2, 'Stolik w kącie', 1),
(5, 5, 4, 'Stolik VIP', 1),
(6, 1, 2, 'Stolik przy barze', 2),
(7, 2, 4, 'Stolik na zewnątrz', 2),
(8, 3, 6, 'Stolik tatami', 2),
(9, 4, 4, 'Stolik na piętrze', 2),
(10, 5, 2, 'Stolik romantyczny', 2);

-- Klienci
INSERT INTO Customers VALUES
(1, 'Anna', 'Kowalska', 'anna@example.com', '555-111-222', '2024-01-10'),
(2, 'Piotr', 'Nowak', 'piotr@example.com', '555-222-333', '2024-02-15'),
(3, 'Julia', 'Wiśniewska', 'julia@example.com', '555-333-444', '2024-03-01'),
(4, 'Tomasz', 'Zieliński', 'tomasz@example.com', '555-444-555', '2024-01-22'),
(5, 'Katarzyna', 'Wójcik', 'kasia@example.com', '555-555-666', '2024-04-18'),
(6, 'Marek', 'Kamiński', 'marek@example.com', '555-666-777', '2024-05-03'),
(7, 'Ewa', 'Lewandowska', 'ewa@example.com', '555-777-888', '2024-02-10'),
(8, 'Paweł', 'Dąbrowski', 'pawel@example.com', '555-888-999', '2024-02-28'),
(9, 'Magdalena', 'Szymańska', 'magda@example.com', '555-999-000', '2024-03-12'),
(10, 'Rafał', 'Woźniak', 'rafal@example.com', '555-000-111', '2024-04-01'),
(11, 'Joanna', 'Mazur', 'joanna@example.com', '555-111-333', '2024-03-15'),
(12, 'Krzysztof', 'Krawczyk', 'kris@example.com', '555-222-444', '2024-02-25'),
(13, 'Dorota', 'Kaczmarek', 'dorota@example.com', '555-333-555', '2024-01-30'),
(14, 'Grzegorz', 'Piotrowski', 'grzegorz@example.com', '555-444-666', '2024-03-20'),
(15, 'Natalia', 'Grabowska', 'natalia@example.com', '555-555-777', '2024-04-05');

-- Rezerwacje (przeszłe i przyszłe)
INSERT INTO Reservations VALUES
(1, 1, 1, '2024-12-01', '18:00', 2, 'confirmed'),
(2, 2, 2, '2024-12-02', '19:00', 4, 'confirmed'),
(3, 3, 3, '2024-12-03', '20:00', 5, 'pending'),
(4, 4, 4, '2024-11-25', '18:30', 2, 'cancelled'),
(5, 5, 5, '2024-11-26', '21:00', 3, 'confirmed'),
(6, 6, 6, '2024-10-15', '18:00', 2, 'confirmed'),
(7, 7, 7, '2024-09-10', '19:30', 4, 'confirmed'),
(8, 8, 8, '2024-09-11', '20:00', 6, 'completed'),
(9, 9, 9, '2024-08-20', '18:00', 4, 'completed'),
(10, 10, 10, '2024-08-21', '19:00', 2, 'completed'),
(11, 11, 1, '2024-07-01', '20:30', 2, 'completed'),
(12, 12, 2, '2024-07-05', '19:00', 3, 'completed'),
(13, 13, 3, '2024-07-06', '18:30', 6, 'cancelled'),
(14, 14, 4, '2024-06-01', '17:00', 2, 'completed'),
(15, 15, 5, '2024-06-05', '21:00', 4, 'confirmed'),
(16, 1, 6, '2024-05-20', '20:00', 2, 'confirmed'),
(17, 2, 7, '2024-05-22', '19:00', 3, 'confirmed'),
(18, 3, 8, '2024-05-23', '20:30', 4, 'pending'),
(19, 4, 9, '2024-05-24', '18:00', 4, 'pending'),
(20, 5, 10, '2024-05-25', '19:30', 2, 'confirmed');

-- Menu (30 dań, różne kategorie)
INSERT INTO Menu VALUES
(1, 'Pizza Margherita', 30.00, 'Pizza', 'Klasyczna włoska pizza', 1),
(2, 'Pizza Pepperoni', 35.00, 'Pizza', 'Z pikantną kiełbasą', 1),
(3, 'Lasagna', 28.00, 'Makarony', 'Warstwowy makaron z mięsem', 1),
(4, 'Spaghetti Carbonara', 27.00, 'Makarony', 'Z boczkiem i jajkiem', 1),
(5, 'Tiramisu', 18.00, 'Desery', 'Klasyczny włoski deser', 1),
(6, 'Risotto z grzybami', 32.00, 'Dania główne', 'Kremowe risotto', 1),
(7, 'Sake Nigiri', 10.00, 'Sushi', 'Łosoś na ryżu', 2),
(8, 'Tuna Maki', 12.00, 'Sushi', 'Z tuńczykiem', 2),
(9, 'California Roll', 14.00, 'Sushi', 'Z awokado i krabem', 2),
(10, 'Miso Soup', 8.00, 'Zupy', 'Japońska zupa z pastą miso', 2),
(11, 'Tempura', 25.00, 'Przystawki', 'Smażone warzywa i owoce morza', 2),
(12, 'Gyoza', 18.00, 'Przystawki', 'Pierogi japońskie', 2),
(13, 'Zielona herbata', 6.00, 'Napoje', 'Tradycyjna herbata', 2),
(14, 'Cola', 7.00, 'Napoje', 'Napój gazowany', 1),
(15, 'Woda mineralna', 5.00, 'Napoje', 'Niegazowana', 1),
(16, 'Czekoladowy fondant', 20.00, 'Desery', 'Z płynną czekoladą', 1),
(17, 'Futomaki', 15.00, 'Sushi', 'Duże rolki', 2),
(18, 'Sashimi Mix', 40.00, 'Sushi', 'Różne rodzaje ryb', 2),
(19, 'Udon', 22.00, 'Makarony', 'Gruby makaron w bulionie', 2),
(20, 'Katsu Curry', 30.00, 'Dania główne', 'Wieprzowina w panierce', 2),
(21, 'Makaron Alfredo', 29.00, 'Makarony', 'Z kremowym sosem', 1),
(22, 'Caprese', 16.00, 'Przystawki', 'Z pomidorami i mozzarellą', 1),
(23, 'Sushi Set Deluxe', 60.00, 'Sushi', 'Zestaw premium', 2),
(24, 'Ramen', 26.00, 'Zupy', 'Japoński rosół', 2),
(25, 'Lemoniada', 9.00, 'Napoje', 'Domowa lemoniada', 1),
(26, 'Sałatka Cezar', 22.00, 'Sałatki', 'Z kurczakiem', 1),
(27, 'Edamame', 12.00, 'Przystawki', 'Zielona soja', 2),
(28, 'Matcha Ice Cream', 15.00, 'Desery', 'Lody z matchy', 2),
(29, 'Bruschetta', 14.00, 'Przystawki', 'Z pomidorami i czosnkiem', 1),
(30, 'Onigiri', 10.00, 'Przekąski', 'Ryżowe kulki z nadzieniem', 2);

-- Zamówienia
INSERT INTO Orders VALUES
(1, 6, '2024-10-15', 60.00),
(2, 7, '2024-09-10', 80.00),
(3, 8, '2024-09-11', 110.00),
(4, 9, '2024-08-20', 95.00),
(5, 10, '2024-08-21', 40.00),
(6, 11, '2024-07-01', 35.00),
(7, 12, '2024-07-05', 75.00),
(8, 14, '2024-06-01', 45.00),
(9, 15, '2024-06-05', 60.00),
(10, 16, '2024-05-20', 30.00),
(11, 17, '2024-05-22', 90.00),
(12, 18, '2024-05-23', 55.00),
(13, 19, '2024-05-24', 65.00),
(14, 20, '2024-05-25', 85.00),
(15, 5,  '2024-11-26', 50.00);

-- Pozycje zamówień
INSERT INTO Order_Items VALUES
(1, 1, 1, 1, 30.00),
(2, 1, 5, 1, 18.00),
(3, 2, 7, 4, 10.00),
(4, 2, 11, 2, 25.00),
(5, 3, 9, 3, 14.00),
(6, 3, 12, 2, 18.00),
(7, 4, 13, 3, 6.00),
(8, 4, 18, 1, 40.00),
(9, 5, 2, 1, 35.00),
(10, 5, 15, 1, 5.00),
(11, 6, 3, 1, 28.00),
(12, 6, 14, 1, 7.00),
(13, 7, 17, 2, 15.00),
(14, 8, 6, 1, 32.00),
(15, 8, 25, 2, 9.00),
(16, 9, 4, 2, 27.00),
(17, 10, 26, 1, 22.00),
(18, 10, 14, 1, 7.00),
(19, 11, 7, 2, 10.00),
(20, 12, 8, 3, 12.00),
(21, 13, 10, 2, 8.00),
(22, 14, 23, 1, 60.00),
(23, 15, 22, 2, 16.00);
