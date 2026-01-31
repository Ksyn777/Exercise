CREATE DATABASE Sklep_Internetowy;
USE  Sklep_Internetowy;
SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

CREATE TABLE Products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    names VARCHAR(255) NOT NULL,
    descriptions TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    product_code VARCHAR(50) NOT NULL,
    weights DECIMAL(10, 2),
    dimensions VARCHAR(100)
);


CREATE TABLE Categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL,
    parent_category INT DEFAULT NULL,
    descriptions TEXT,
    FOREIGN KEY (parent_category) REFERENCES Categories(id)
);

CREATE TABLE Product_Categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

CREATE TABLE Customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    registration_date DATETIME NOT NULL,
    last_login DATETIME
);

CREATE TABLE Addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    address_type VARCHAR(50) NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME NOT NULL,
    statuss VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    shipping_address_id INT,
    billing_address_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (shipping_address_id) REFERENCES Addresses(id),
    FOREIGN KEY (billing_address_id) REFERENCES Addresses(id)
);

CREATE TABLE Order_Items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);


CREATE TABLE Shipments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    courier_company VARCHAR(100),
    tracking_number VARCHAR(100),
    shipping_cost DECIMAL(10, 2),
    ship_date DATETIME,
    estimated_delivery_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(id)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT NOT NULL,
    comment TEXT,
    dates DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

INSERT INTO Products (names, descriptions, price, stock_quantity, product_code, weights, dimensions) VALUES
('Laptop Lenovo IdeaPad 3', 'Laptop 15,6" z procesorem Intel i5', 2399.00, 12, 'LAP001', 1.9, '36x25x2'),
('Smartfon Samsung Galaxy S22', 'Smartfon z ekranem AMOLED 6,1"', 3999.00, 8, 'PHN001', 0.2, '15x7x0.8'),
('Słuchawki Sony WH-1000XM5', 'Słuchawki z aktywną redukcją szumów', 1399.00, 20, 'HDP001', 0.3, '18x17x8'),
('Tablet Apple iPad 10.9', 'Nowy iPad z procesorem M1', 2999.00, 15, 'TAB001', 0.5, '25x17x0.7'),
('Monitor LG 27UL500-W', 'Monitor 27" 4K UHD', 1299.00, 10, 'MON001', 4.5, '61x36x6'),
('Drukarka HP Ink Tank 315', 'Drukarka atramentowa z Wi-Fi', 599.00, 9, 'PRN001', 3.2, '45x32x16'),
('Mysz Logitech MX Master 3', 'Bezprzewodowa mysz do pracy biurowej', 399.00, 25, 'MSE001', 0.1, '12x8x4'),
('Krzesło biurowe Ergolux', 'Ergonomiczne krzesło z podparciem lędźwiowym', 699.00, 5, 'CHR001', 12.0, '70x70x120'),
('Biurko gamingowe X-RAY', 'Biurko LED z organizerem kabli', 999.00, 6, 'DSK001', 20.0, '140x60x75'),
('Głośnik JBL Flip 6', 'Przenośny głośnik Bluetooth', 549.00, 18, 'SPK001', 0.6, '18x7x7'),
('Odkurzacz Xiaomi Mi Robot', 'Odkurzacz automatyczny z mopowaniem', 1499.00, 7, 'VAC001', 4.2, '35x35x10'),
('Lodówka Samsung RB36T605', 'Lodówka z dolnym zamrażalnikiem No Frost', 2999.00, 3, 'FRD001', 70.0, '60x67x185'),
('Kuchenka mikrofalowa Amica', 'Mikrofalówka z grillem', 399.00, 10, 'MIC001', 12.0, '44x34x26'),
('Czajnik elektryczny Zelmer', 'Szybko gotujący czajnik 1.7L', 149.00, 30, 'KET001', 1.0, '20x15x24'),
('Ekspres ciśnieniowy DeLonghi', 'Ekspres z młynkiem i spieniaczem', 1899.00, 4, 'COF001', 8.0, '30x25x35'),
('Zmywarka Bosch Serie 4', 'Zmywarka 12 kompletów, klasa A++', 1799.00, 2, 'DWS001', 35.0, '60x60x85'),
('Telewizor LG OLED55', 'Telewizor 55" OLED 4K z webOS', 4499.00, 5, 'TVS001', 18.0, '123x71x5'),
('Kamera sportowa GoPro HERO11', 'Wodoodporna kamera 5.3K z Wi-Fi', 2299.00, 14, 'CAM001', 0.2, '6x4x3'),
('Smartwatch Garmin Venu 2', 'Zegarek sportowy z GPS i pomiarem snu', 1499.00, 10, 'SMW001', 0.1, '5x5x1.5'),
('Opaska Xiaomi Mi Band 7', 'Opaska fitness z pulsometrem', 199.00, 40, 'FIT001', 0.05, '4x2x1'),
('Zestaw garnków Tefal', 'Komplet 10-elementowy, stal nierdzewna', 499.00, 12, 'POT001', 6.0, '50x30x30'),
('Patelnia ceramiczna 28cm', 'Nieprzywierająca, indukcyjna', 129.00, 20, 'PAN001', 1.2, '30x28x6'),
('Toster Philips HD2581', 'Toster na 2 kromki z regulacją stopnia', 149.00, 22, 'TST001', 1.5, '30x20x18'),
('Żelazko Philips Steam', 'Żelazko parowe z funkcją automatyki', 199.00, 10, 'IRN001', 1.3, '28x14x15'),
('Powerbank Baseus 20000mAh', 'Powerbank z szybkim ładowaniem PD', 149.00, 25, 'PBK001', 0.4, '15x7x2'),
('Router TP-Link Archer AX55', 'Router WiFi 6 z Beamforming', 399.00, 11, 'RTR001', 0.8, '25x20x6'),
('Kabel HDMI 2.1 2m', 'Kabel UHD 8K 60Hz HDR', 49.00, 60, 'CBL001', 0.2, '20x10x2'),
('Mikrofon Razer Seiren Mini', 'Mikrofon USB do streamingu', 299.00, 8, 'MIC002', 0.6, '15x10x5'),
('Czytnik Kindle Paperwhite', 'E-book z podświetleniem i 8GB pamięci', 749.00, 7, 'EBK001', 0.3, '17x12x1'),
('Karta pamięci SanDisk 128GB', 'MicroSDXC do smartfona', 89.00, 35, 'SDC001', 0.01, '1.5x1x0.1'),
('Kamera IP Xiaomi 360', 'Kamera Wi-Fi z trybem nocnym', 179.00, 13, 'CCTV001', 0.5, '10x10x12'),
('Projektor Epson EB-E10', 'Projektor 3600 lumenów z HDMI', 1799.00, 3, 'PRJ001', 2.8, '30x24x10'),
('Gimbal DJI Osmo Mobile 6', 'Stabilizator smartfona z Bluetooth', 699.00, 9, 'GMB001', 0.4, '18x10x5'),
('Torba na laptopa 15"', 'Torba wodoodporna z kieszenią na akcesoria', 99.00, 20, 'BAG001', 0.7, '40x30x5'),
('Zasilacz UPS APC 600VA', 'Zasilacz awaryjny dla komputerów', 399.00, 4, 'UPS001', 6.0, '30x15x20'),
('Listwa zasilająca Orno', '5 gniazd + USB, zabezpieczenie przepięciowe', 79.00, 25, 'PWR001', 1.2, '45x10x4'),
('Wentylator biurkowy Blaupunkt', 'Wentylator z oscylacją i 3 prędkościami', 149.00, 15, 'FAN001', 2.5, '30x30x45'),
('Grill elektryczny Tefal', 'Grill kontaktowy do mięsa i warzyw', 349.00, 6, 'GRL001', 3.0, '35x30x15'),
('Mop parowy Vileda Steam', 'Mop z funkcją czyszczenia gorącą parą', 399.00, 9, 'MOP001', 4.0, '25x15x120'),
('Zestaw śrubokrętów Yato', '25-elementowy zestaw z uchwytem magnetycznym', 79.00, 18, 'TOOL001', 1.0, '20x10x6'),
('Kosiarka spalinowa NAC', 'Kosiarka 4.5KM z napędem', 1299.00, 2, 'GRD001', 25.0, '80x60x50'),
('Wiertarko-wkrętarka Bosch', 'Akumulatorowa, z walizką i bitami', 499.00, 6, 'DRV001', 2.2, '30x25x10'),
('Oczyszczacz powietrza Philips', 'Filtr HEPA, do 60m²', 899.00, 5, 'AIR001', 6.0, '35x25x55'),
('Stacja pogodowa Bresser', 'Z termometrem i prognozą pogody', 199.00, 12, 'WTH001', 0.8, '20x10x4'),
('Podgrzewacz wody Ariston 50L', 'Elektryczny bojler do łazienki', 699.00, 3, 'BOIL001', 15.0, '45x45x60');

INSERT INTO Categories (id, category_name, parent_category, descriptions) VALUES
(1, 'Elektronika', NULL, 'Urządzenia elektroniczne'),
(2, 'Komputery i laptopy', 1, 'Laptopy, notebooki, komputery stacjonarne'),
(3, 'Telefony', 1, 'Smartfony i telefony komórkowe'),
(4, 'Akcesoria', 1, 'Akcesoria do elektroniki'),
(5, 'AGD', NULL, 'Sprzęt AGD'),
(6, 'Kuchnia', 5, 'Urządzenia kuchenne'),
(7, 'Pranie', 5, 'Pralki i suszarki'),
(8, 'Meble', NULL, 'Meble do domu'),
(9, 'Biuro', 8, 'Meble biurowe'),
(10, 'Sypialnia', 8, 'Łóżka i szafy do sypialni');



INSERT INTO Customers (id, first_name, last_name, email, password_hash, registration_date, last_login) VALUES
(1, 'Tola', 'Raźniak', 'tola.raźniak1@example.com', 'a8dcd05ed7b60714986fbabc15a2f253a2338389e73e43a7416de99c67b5d66d', '2025-02-24 04:38:44', '2025-04-23 10:15:00'),
(2, 'Sonia', 'Adrian', 'sonia.adrian2@example.com', 'a304189ffdef046ac5e11b6c84f263efc99d053c28c46cd8e7f717669b87196a', '2022-05-17 23:35:20', '2024-05-20 12:06:38'),
(3, 'Kinga', 'Ulatowska', 'kinga.ulatowska3@example.com', '6b2f17990c99df2a8b8233f7856c03eb9d5dd2f8bcfc3c5d18e162464169ec7f', '2024-02-06 10:34:25', '2025-02-04 15:12:09'),
(4, 'Adrian', 'Wąsik', 'adrian.wąsik4@example.com', 'ea3c0a1e9ae9c2f1d4e849a1cd9c1862dd18b78bb1e37f5f3f1f134c77ec3bc4', '2024-03-06 11:38:31', '2024-10-06 18:23:55'),
(5, 'Klaudia', 'Tomala', 'klaudia.tomala5@example.com', '0f71c7a0c4c9c422ea8eb7eb0ddbdcd92cc3b16a25d08bc0c1e23f65d106ab71', '2025-02-11 21:44:19', '2025-03-15 13:34:11'),
(6, 'Karolina', 'Paszek', 'karolina.paszek6@example.com', '6e682c4d6eae2ae8eb05faac4a217d8d3d4c875bd9a457409bc697c4efb7fc40', '2023-06-06 16:20:33', '2024-11-02 15:00:33'),
(7, 'Konrad', 'Kołodziejczyk', 'konrad.kołodziejczyk7@example.com', '593e87e33dffb0b49d089338d9a7dc949d8f0ac29234c9269c89ac8d5cf03a68', '2023-11-24 17:59:29', '2024-10-25 16:00:01'),
(8, 'Aleksandra', 'Bartczak', 'aleksandra.bartczak8@example.com', 'fb99115f3d6891d5a11709a8b2ae2e34d5b86c27c7d87c5e5bbfbb3f623f85a3', '2025-03-03 06:23:21', '2025-03-05 19:59:30'),
(9, 'Krzysztof', 'Pawlak', 'krzysztof.pawlak9@example.com', '63e1a5c4357608f66c429cb1323171328d6aa3641ef01916304f13d51e8729e7', '2024-08-04 07:56:15', '2024-10-01 10:11:44'),
(10, 'Izabela', 'Piech', 'izabela.piech10@example.com', 'ba6d183cd9318db98b83b948cdfc54fa509e6b222768379b719ec47e50de62a0', '2023-04-12 10:17:23', '2023-10-03 17:07:44'),
(11, 'Julia', 'Miros', 'julia.miros11@example.com', '8c0e26d83ffb1e0101dc81cc6d4fa4a9be7b5eaeec9422083267f2a5c71d74bb', '2024-01-25 23:06:42', '2024-10-10 19:00:21'),
(12, 'Tymoteusz', 'Paluch', 'tymoteusz.paluch12@example.com', 'aa5ec35879b2ea57b02f1d189f1a9b51d19992b6601c0080d10e9cfb9a6e50aa', '2025-02-25 11:09:21', '2025-04-27 18:25:30'),
(13, 'Mikołaj', 'Sobański', 'mikołaj.sobański13@example.com', '6213cc990b740a9383cc8ef191ca45ed3f63f6d3e38789d25c47e09894dc5bcd', '2024-06-20 12:02:20', '2025-01-19 12:39:13'),
(14, 'Marcin', 'Ławniczak', 'marcin.ławniczak14@example.com', '325b4f43b254f5867778c1843a72f27c3e26aa7b3e024f9e1b61c1295f7c8f69', '2022-11-18 13:30:02', '2024-11-10 16:18:15'),
(15, 'Piotr', 'Chmielewski', 'piotr.chmielewski15@example.com', '8719bc68a7df6f8595f5df6a3387e5c6fc1b055d9c15282e8d50e9cf084b9b64', '2024-04-01 08:09:18', '2025-03-02 13:01:55'),
(16, 'Patrycja', 'Andrzejewska', 'patrycja.andrzejewska16@example.com', 'dcd24caa11c574b64e32120f1e5e82be5bcfd57ec63183f70e4f0d67d5402fd5', '2024-01-28 01:33:24', '2025-02-16 09:18:38'),
(17, 'Natalia', 'Bojanowska', 'natalia.bojanowska17@example.com', '2345e83c35e1a0648f747e46d6f2270e4232eaa07f616f04a2368b27d9c0b5b2', '2022-10-10 21:29:56', '2024-04-20 18:34:57'),
(18, 'Damian', 'Piekarski', 'damian.piekarski18@example.com', '144c9f61620f0735cc478ae6e48d199f74e11d65e5db7a67b60e98329e4a229d', '2023-07-13 18:56:07', '2025-02-01 15:11:14'),
(19, 'Agnieszka', 'Oleś', 'agnieszka.oleś19@example.com', 'e0e934ecf6a2291e39edcb426e06350413b990ef0f9a1efbf52ab21df6460c6f', '2023-02-17 21:01:25', '2024-03-05 11:49:20'),
(20, 'Tomasz', 'Szewczyk', 'tomasz.szewczyk20@example.com', '89df05309b9c1f56df6f6638d544e8f35bbd0d8cf2fa5cbb61f73981e2de1934', '2024-03-19 00:01:45', '2024-10-17 22:34:56'),
(21, 'Olga', 'Woźniak', 'olga.woźniak21@example.com', '21989f989e2c274e6ea3dcd43c01e0ce982688e50b8310d4a4ff94996be35a50', '2024-12-07 17:17:32', '2025-02-21 10:45:23'),
(22, 'Maciej', 'Mazur', 'maciej.mazur22@example.com', '70238e02b18a9730e33a1463a51000971dcadd5cb780e6fe7f66b3efdc3a43d1', '2022-06-14 22:28:03', '2023-11-22 12:12:43'),
(23, 'Lena', 'Płonka', 'lena.płonka23@example.com', '8e95d487b1ecba7a5fc4fc30ed41f8f01e9f90e0e5474c658c5ecbca68c5b62e', '2023-09-04 12:02:44', '2024-05-13 09:02:58'),
(24, 'Bartosz', 'Cisek', 'bartosz.cisek24@example.com', 'f9a01259a6cbb9b657f3295a9ff8a54c8b7f29bcb226fe8022b31cfeabf2ae30', '2024-11-25 21:55:09', '2025-01-19 08:25:49'),
(25, 'Weronika', 'Drabik', 'weronika.drabik25@example.com', 'f2929177c4bfb6d398c3d84cc2f7b3692de768eb52d29f4f4c5824c5560a09e6', '2025-01-11 14:10:38', '2025-02-15 10:42:30'),
(26, 'Jakub', 'Nowicki', 'jakub.nowicki26@example.com', '3de31989b34019a63313e3e1eaf524dba3d2261f0e8b0c98d04b1614f5c164ab', '2023-12-10 11:11:22', '2024-12-18 17:14:09'),
(27, 'Ewa', 'Kubicka', 'ewa.kubicka27@example.com', 'ecdf3466b1616e0e9e9d24598a1526e733f3d8c0576d0e4e32fa537b72ae1dcd', '2024-10-10 07:03:25', '2024-11-01 13:35:40'),
(28, 'Marek', 'Koza', 'marek.koza28@example.com', '8db1ed1e94db66501165e51ae97cbde38564f02c98d4c408b9c3f7b7b222f92a', '2023-03-01 14:42:14', '2023-09-19 20:00:11'),
(29, 'Zofia', 'Wrona', 'zofia.wrona29@example.com', '65c3c8fefc73d1576a78a2ea8c90932b2fcf5d09c62c2f76f1b8918236cfc98c', '2024-09-14 15:49:51', '2025-02-05 13:04:32'),
(30, 'Blanka', 'Fura', 'blanka.fura30@example.com', '7562642edfe1180c78be9bc9a34bdfa529b67130f39a4cfb50f6760ad473f82b', '2025-01-21 23:22:49', '2025-01-25 10:16:19');

-- Tabela Addresses
INSERT INTO Addresses (id, customer_id, address_type, street, city, postal_code, country, is_default) VALUES
(1, 1, 'shipping', 'ul. Kwiatowa 12', 'Warszawa', '00-175', 'Polska', TRUE),
(2, 2, 'billing', 'ul. Leśna 8', 'Kraków', '30-001', 'Polska', TRUE),
(3, 3, 'shipping', 'ul. Ogrodowa 21A', 'Gdańsk', '80-001', 'Polska', TRUE),
(4, 4, 'billing', 'ul. Wiosenna 3', 'Poznań', '60-101', 'Polska', TRUE),
(5, 5, 'shipping', 'ul. Polna 7', 'Wrocław', '50-123', 'Polska', TRUE),
(6, 6, 'shipping', 'ul. Słoneczna 45', 'Szczecin', '70-100', 'Polska', TRUE),
(7, 7, 'billing', 'ul. Lipowa 14', 'Lublin', '20-300', 'Polska', TRUE),
(8, 8, 'shipping', 'ul. Akacjowa 99', 'Katowice', '40-200', 'Polska', TRUE),
(9, 9, 'billing', 'ul. Jesionowa 22', 'Bydgoszcz', '85-001', 'Polska', TRUE),
(10, 10, 'shipping', 'ul. Topolowa 3B', 'Białystok', '15-111', 'Polska', TRUE),
(11, 11, 'billing', 'ul. Zielona 15', 'Rzeszów', '35-002', 'Polska', TRUE),
(12, 12, 'shipping', 'ul. Dębowa 6', 'Opole', '45-678', 'Polska', TRUE),
(13, 13, 'billing', 'ul. Wierzbowa 11', 'Toruń', '87-100', 'Polska', TRUE),
(14, 14, 'shipping', 'ul. Klonowa 8', 'Radom', '26-600', 'Polska', TRUE),
(15, 15, 'billing', 'ul. Brzozowa 5', 'Gorzów Wlkp.', '66-400', 'Polska', TRUE),
(16, 16, 'shipping', 'ul. Malinowa 10', 'Kielce', '25-001', 'Polska', TRUE),
(17, 17, 'billing', 'ul. Borowa 2A', 'Zielona Góra', '65-001', 'Polska', TRUE),
(18, 18, 'shipping', 'ul. Modrzewiowa 12', 'Koszalin', '75-001', 'Polska', TRUE),
(19, 19, 'billing', 'ul. Grabowa 20', 'Elbląg', '82-300', 'Polska', TRUE),
(20, 20, 'shipping', 'ul. Cisowa 7', 'Płock', '09-400', 'Polska', TRUE),
(21, 21, 'billing', 'ul. Bukowa 3C', 'Legnica', '59-220', 'Polska', TRUE),
(22, 22, 'shipping', 'ul. Wiśniowa 4', 'Gliwice', '44-100', 'Polska', TRUE),
(23, 23, 'billing', 'ul. Orzechowa 17', 'Siedlce', '08-100', 'Polska', TRUE),
(24, 24, 'shipping', 'ul. Morelowa 19A', 'Nowy Sącz', '33-300', 'Polska', TRUE),
(25, 25, 'billing', 'ul. Jarzębinowa 6', 'Olsztyn', '10-001', 'Polska', TRUE),
(26, 26, 'shipping', 'ul. Czereśniowa 14', 'Tarnów', '33-100', 'Polska', TRUE),
(27, 27, 'billing', 'ul. Świerkowa 18', 'Piła', '64-920', 'Polska', TRUE),
(28, 28, 'shipping', 'ul. Kalinowa 9', 'Przemyśl', '37-700', 'Polska', TRUE),
(29, 29, 'billing', 'ul. Różana 23', 'Łomża', '18-400', 'Polska', TRUE),
(30, 30, 'shipping', 'ul. Magnoliowa 1', 'Zamość', '22-400', 'Polska', TRUE);



INSERT INTO Orders (id, customer_id, order_date, statuss, payment_method, shipping_address_id, billing_address_id) VALUES
(1, 1, '2025-03-01 10:00:00', 'pending', 'credit_card', 1, 1),
(2, 2, '2025-03-02 11:15:00', 'shipped', 'paypal', 2, 2),
(3, 3, '2025-03-03 12:30:00', 'pending', 'bank_transfer', 3, 3),
(4, 4, '2025-03-04 13:45:00', 'delivered', 'credit_card', 4, 4),
(5, 5, '2025-03-05 14:00:00', 'shipped', 'paypal', 5, 5),
(6, 6, '2025-03-06 15:30:00', 'pending', 'credit_card', 6, 6),
(7, 7, '2025-03-07 16:00:00', 'delivered', 'bank_transfer', 7, 7),
(8, 8, '2025-03-08 17:30:00', 'pending', 'paypal', 8, 8),
(9, 9, '2025-03-09 18:00:00', 'shipped', 'credit_card', 9, 9),
(10, 10, '2025-03-10 19:00:00', 'delivered', 'bank_transfer', 10, 10),
(11, 11, '2025-03-11 10:30:00', 'pending', 'credit_card', 11, 11),
(12, 12, '2025-03-12 11:00:00', 'shipped', 'paypal', 12, 12),
(13, 13, '2025-03-13 12:30:00', 'delivered', 'credit_card', 13, 13),
(14, 14, '2025-03-14 13:00:00', 'pending', 'bank_transfer', 14, 14),
(15, 15, '2025-03-15 14:00:00', 'shipped', 'paypal', 15, 15),
(16, 16, '2025-03-16 15:00:00', 'pending', 'credit_card', 16, 16),
(17, 17, '2025-03-17 16:30:00', 'delivered', 'bank_transfer', 17, 17),
(18, 18, '2025-03-18 17:30:00', 'shipped', 'credit_card', 18, 18),
(19, 19, '2025-03-19 18:00:00', 'pending', 'paypal', 19, 19),
(20, 20, '2025-03-20 19:30:00', 'delivered', 'credit_card', 20, 20),
(21, 21, '2025-03-21 10:00:00', 'pending', 'bank_transfer', 21, 21),
(22, 22, '2025-03-22 11:00:00', 'shipped', 'paypal', 22, 22),
(23, 23, '2025-03-23 12:00:00', 'delivered', 'credit_card', 23, 23),
(24, 24, '2025-03-24 13:00:00', 'pending', 'bank_transfer', 24, 24),
(25, 25, '2025-03-25 14:30:00', 'shipped', 'paypal', 25, 25),
(26, 26, '2025-03-26 15:00:00', 'pending', 'credit_card', 26, 26),
(27, 27, '2025-03-27 16:30:00', 'delivered', 'bank_transfer', 27, 27),
(28, 28, '2025-03-28 17:00:00', 'shipped', 'paypal', 28, 28),
(29, 29, '2025-03-29 18:00:00', 'pending', 'credit_card', 29, 29),
(30, 30, '2025-03-30 19:30:00', 'delivered', 'bank_transfer', 30, 30),
(31, 1, '2025-04-01 10:00:00', 'shipped', 'credit_card', 1, 1),
(32, 2, '2025-04-02 11:15:00', 'pending', 'paypal', 2, 2),
(33, 3, '2025-04-03 12:30:00', 'delivered', 'bank_transfer', 3, 3),
(34, 4, '2025-04-04 13:45:00', 'pending', 'credit_card', 4, 4),
(35, 5, '2025-04-05 14:00:00', 'shipped', 'paypal', 5, 5),
(36, 6, '2025-04-06 15:30:00', 'delivered', 'credit_card', 6, 6),
(37, 7, '2025-04-07 16:00:00', 'pending', 'bank_transfer', 7, 7),
(38, 8, '2025-04-08 17:30:00', 'shipped', 'paypal', 8, 8),
(39, 9, '2025-04-09 18:00:00', 'delivered', 'credit_card', 9, 9),
(40, 10, '2025-04-10 19:00:00', 'pending', 'bank_transfer', 10, 10);


INSERT INTO Order_Items (id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2, 19.99),
(2, 1, 2, 1, 99.99),
(3, 2, 3, 3, 29.99),
(4, 2, 4, 2, 15.99),
(5, 3, 5, 1, 49.99),
(6, 3, 6, 2, 35.99),
(7, 4, 7, 1, 59.99),
(8, 4, 8, 3, 25.99),
(9, 5, 9, 1, 79.99),
(10, 5, 10, 2, 10.99),
(11, 6, 11, 3, 89.99),
(12, 6, 12, 1, 19.99),
(13, 7, 13, 2, 59.99),
(14, 7, 14, 1, 49.99),
(15, 8, 15, 1, 39.99),
(16, 8, 16, 2, 29.99),
(17, 9, 17, 1, 15.99),
(18, 9, 18, 3, 19.99),
(19, 10, 19, 1, 69.99),
(20, 10, 20, 2, 5.99),
(21, 11, 21, 1, 79.99),
(22, 11, 22, 2, 9.99),
(23, 12, 23, 1, 49.99),
(24, 12, 24, 3, 11.99),
(25, 13, 25, 1, 99.99),
(26, 13, 26, 2, 12.99),
(27, 14, 27, 1, 39.99),
(28, 14, 28, 3, 25.99),
(29, 15, 29, 1, 19.99),
(30, 15, 30, 2, 49.99),
(31, 16, 31, 1, 69.99),
(32, 16, 32, 2, 7.99),
(33, 17, 33, 3, 89.99),
(34, 17, 34, 1, 99.99),
(35, 18, 35, 2, 59.99),
(36, 18, 36, 1, 29.99),
(37, 19, 37, 1, 59.99),
(38, 19, 38, 2, 19.99),
(39, 20, 39, 1, 15.99),
(40, 20, 40, 2, 25.99);


INSERT INTO Shipments (id, order_id, courier_company, tracking_number, shipping_cost, ship_date, estimated_delivery_date) VALUES
(1, 1, 'DHL', 'DHL123456789', 15.00, '2025-03-01', '2025-03-05'),
(2, 2, 'FedEx', 'FEDEX987654321', 20.00, '2025-03-02', '2025-03-06'),
(3, 3, 'UPS', 'UPS246810121', 18.50, '2025-03-03', '2025-03-07'),
(4, 4, 'DHL', 'DHL135792468', 12.00, '2025-03-04', '2025-03-08'),
(5, 5, 'Poczta Polska', 'PP12345678', 8.00, '2025-03-05', '2025-03-09'),
(6, 6, 'FedEx', 'FEDEX11223344', 25.00, '2025-03-06', '2025-03-10'),
(7, 7, 'UPS', 'UPS135791113', 14.50, '2025-03-07', '2025-03-11'),
(8, 8, 'DHL', 'DHL222233344', 17.00, '2025-03-08', '2025-03-12'),
(9, 9, 'Poczta Polska', 'PP98765432', 9.00, '2025-03-09', '2025-03-13'),
(10, 10, 'FedEx', 'FEDEX55667788', 20.50, '2025-03-10', '2025-03-14'),
(11, 11, 'DHL', 'DHL667788990', 16.00, '2025-03-11', '2025-03-15'),
(12, 12, 'UPS', 'UPS223344556', 19.00, '2025-03-12', '2025-03-16'),
(13, 13, 'Poczta Polska', 'PP11223344', 7.50, '2025-03-13', '2025-03-17'),
(14, 14, 'FedEx', 'FEDEX99887766', 22.00, '2025-03-14', '2025-03-18'),
(15, 15, 'DHL', 'DHL556677889', 13.00, '2025-03-15', '2025-03-19'),
(16, 16, 'UPS', 'UPS667788990', 18.00, '2025-03-16', '2025-03-20'),
(17, 17, 'FedEx', 'FEDEX33445566', 23.00, '2025-03-17', '2025-03-21'),
(18, 18, 'Poczta Polska', 'PP44556677', 10.50, '2025-03-18', '2025-03-22'),
(19, 19, 'DHL', 'DHL884422668', 16.50, '2025-03-19', '2025-03-23'),
(20, 20, 'UPS', 'UPS998877665', 19.50, '2025-03-20', '2025-03-24');

-- Tabela Reviews
INSERT INTO Reviews (id, product_id, customer_id, rating, comment, dates) VALUES
(1, 1, 1, 5, 'Świetny produkt! Bardzo polecam.', '2025-03-01'),
(2, 2, 2, 4, 'Dobry jakościowo, ale cena mogłaby być niższa.', '2025-03-02'),
(3, 3, 3, 5, 'Bardzo zadowolony z zakupu, doskonała jakość!', '2025-03-03'),
(4, 4, 4, 3, 'Produkt OK, ale spodziewałem się lepszego wykonania.', '2025-03-04'),
(5, 5, 5, 4, 'Bardzo fajna, solidna rzecz, ale trochę za duża.', '2025-03-05'),
(6, 6, 6, 5, 'Zdecydowanie warto! Przesyłka dotarła na czas, produkt rewelacja.', '2025-03-06'),
(7, 7, 7, 2, 'Produkt nie spełnia moich oczekiwań, niestety nie pasuje.', '2025-03-07'),
(8, 8, 8, 5, 'Jestem bardzo zadowolony, świetna jakość i szybka dostawa.', '2025-03-08'),
(9, 9, 9, 4, 'Fajny produkt, ale mógłby być tańszy.', '2025-03-09'),
(10, 10, 10, 5, 'Bardzo wygodny i funkcjonalny, polecam!', '2025-03-10'),
(11, 11, 11, 4, 'Dobrej jakości, spełnia moje oczekiwania, ale czasami się zacina.', '2025-03-11'),
(12, 12, 12, 3, 'Jest OK, ale ma kilka drobnych wad.', '2025-03-12'),
(13, 13, 13, 5, 'Produkt wyśmienity! Na pewno kupię jeszcze raz.', '2025-03-13'),
(14, 14, 14, 5, 'Rewelacyjna jakość! Bardzo polecam.', '2025-03-14'),
(15, 15, 15, 4, 'Dobra jakość, ale nieco ciężka.', '2025-03-15'),
(16, 16, 16, 5, 'Produkt zgodny z opisem, szybka dostawa. Polecam!', '2025-03-16'),
(17, 17, 17, 4, 'Całkiem dobry produkt, spełnia moje oczekiwania.', '2025-03-17'),
(18, 18, 18, 2, 'Niestety, produkt nie spełnił moich oczekiwań.', '2025-03-18'),
(19, 19, 19, 3, 'Produkt całkiem niezły, ale mogłyby być lepsze materiały.', '2025-03-19'),
(20, 20, 20, 4, 'Dobry produkt, chociaż jest trochę za drogi.', '2025-03-20'),
(21, 21, 21, 5, 'Super! Dokładnie to, czego szukałem.', '2025-03-21'),
(22, 22, 22, 5, 'Świetna jakość, bardzo zadowolony z zakupu.', '2025-03-22'),
(23, 23, 23, 4, 'Produkt dobry, ale mógłby być bardziej funkcjonalny.', '2025-03-23'),
(24, 24, 24, 5, 'Niesamowita jakość, gorąco polecam.', '2025-03-24'),
(25, 25, 25, 3, 'Dobrze wykonany, ale nie do końca odpowiada moim wymaganiom.', '2025-03-25');
