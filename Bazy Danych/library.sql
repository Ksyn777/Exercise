CREATE DATABASE Library;
USE Library; 

SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;


CREATE TABLE Books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    isbn VARCHAR(20) UNIQUE,
    publication_year INT,
    publisher VARCHAR(100),
    page_count INT,
    copies_available INT
);


CREATE TABLE Authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    nationality VARCHAR(50),
    biography TEXT
);

CREATE TABLE Book_Authors (
    book_id INT REFERENCES Books(id),
    author_id INT REFERENCES Authors(id),
    PRIMARY KEY (book_id, author_id)
);


CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(50),
    descriptions TEXT
);


CREATE TABLE Book_Categories (
    book_id INT REFERENCES Books(id),
    category_id INT REFERENCES Categories(id),
    PRIMARY KEY (book_id, category_id)
);


CREATE TABLE Readers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    addres TEXT,
    phone VARCHAR(20),
    registration_date DATE
);


CREATE TABLE Loans (
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(id),
    reader_id INT REFERENCES Readers(id),
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    statuss VARCHAR(20) 
);


CREATE TABLE Fines (
    id SERIAL PRIMARY KEY,
    loan_id INT REFERENCES Loans(id),
    amount DECIMAL(6, 2),
    reason TEXT,
    fine_date DATE,
    payment_status VARCHAR(20) 
);

-- Dodanie książek
INSERT INTO Books (title, isbn, publication_year, publisher, page_count, copies_available) VALUES
('1984', '9780451524935', 1949, 'Secker & Warburg', 328, 5),
('Pride and Prejudice', '9780141439518', 1813, 'T. Egerton', 432, 3),
('The Adventures of Huckleberry Finn', '9780486280615', 1884, 'Chatto & Windus', 366, 4),
('To Kill a Mockingbird', '9780061120084', 1960, 'J.B. Lippincott & Co.', 281, 6),
('Harry Potter and the Sorcerer’s Stone', '9780747532743', 1997, 'Bloomsbury', 309, 10),
('The Fellowship of the Ring', '9780261103573', 1954, 'Allen & Unwin', 423, 5),
('The Great Gatsby', '9780743273565', 1925, 'Scribner', 180, 3),
('One Hundred Years of Solitude', '9780060883287', 1967, 'Harper & Row', 417, 4),
('The Old Man and the Sea', '9780684830490', 1952, 'Charles Scribner’s Sons', 128, 2),
('Murder on the Orient Express', '9780062693662', 1934, 'Collins Crime Club', 256, 4),
('Fahrenheit 451', '9781451673319', 1953, 'Ballantine Books', 158, 6),
('Foundation', '9780553293357', 1951, 'Gnome Press', 255, 3),
('2001: A Space Odyssey', '9780345346297', 1968, 'New American Library', 296, 5),
('The Chronicles of Narnia', '9780066238500', 1950, 'HarperCollins', 767, 7),
('The Hobbit', '9780345339687', 1937, 'George Allen & Unwin', 310, 3),
('Brave New World', '9780060850527', 1932, 'Chatto & Windus', 311, 4),
('The Catcher in the Rye', '9780316769488', 1951, 'Little, Brown and Company', 277, 5),
('Dracula', '9780141439846', 1897, 'Archibald Constable & Co', 418, 2),
('Frankenstein', '9780486282114', 1818, 'Lackington, Hughes, Harding, Mavor & Jones', 280, 6),
('The Picture of Dorian Gray', '9780141439570', 1890, 'Lippincott’s Monthly Magazine', 254, 4),
('The Shining', '9780307743657', 1977, 'Doubleday', 659, 5),
('The Lord of the Flies', '9780399501487', 1954, 'Faber and Faber', 202, 3),
('The Secret Garden', '9780064401883', 1911, 'Frederick A. Stokes Company', 331, 6),
('Wuthering Heights', '9780141439556', 1847, 'Thomas Cautley Newby', 416, 4),
('Crime and Punishment', '9780140449136', 1866, 'The Russian Messenger', 430, 3),
('Jane Eyre', '9780141441146', 1847, 'Smith, Elder & Co.', 500, 5),
('The Road', '9780307387899', 2006, 'Alfred A. Knopf', 287, 3),
('The Grapes of Wrath', '9780143039433', 1939, 'Viking Press', 464, 6),
('The Handmaid’s Tale', '9780385490818', 1985, 'Houghton Mifflin', 311, 2),
('The Bell Jar', '9780060512650', 1963, 'Harper & Row', 288, 4);


INSERT INTO Authors (first_name, last_name, birth_date, nationality, biography) VALUES
('George', 'Orwell', '1903-06-25', 'British', 'Autor powieści dystopijnych.'),
('Jane', 'Austen', '1775-12-16', 'British', 'Znana z klasyki literatury romantycznej.'),
('Mark', 'Twain', '1835-11-30', 'American', 'Pionier literatury amerykańskiej.'),
('Harper', 'Lee', '1926-04-28', 'American', 'Autorka To Kill a Mockingbird.'),
('J.K.', 'Rowling', '1965-07-31', 'British', 'Autorka serii Harry Potter.'),
('J.R.R.', 'Tolkien', '1892-01-03', 'British', 'Twórca Śródziemia.'),
('F. Scott', 'Fitzgerald', '1896-09-24', 'American', "Autor Wielkiego Gatsby\'ego."),
('Gabriel', 'Garcia Marquez', '1927-03-06', 'Colombian', 'Autor realizmu magicznego.'),
('Ernest', 'Hemingway', '1899-07-21', 'American', 'Laureat Nagrody Nobla.'),
('Agatha', 'Christie', '1890-09-15', 'British', 'Królowa kryminału.'),
('Ray', 'Bradbury', '1920-08-22', 'American', 'Autor SF i fantasy.'),
('Isaac', 'Asimov', '1920-01-02', 'American', 'Pisarz science fiction.'),
('Arthur C.', 'Clarke', '1917-12-16', 'British', 'Autor 2001: Odysei kosmicznej.'),
('Aldous', 'Huxley', '1894-07-26', 'British', 'Autor Nowego wspaniałego świata.'),
('Mary', 'Shelley', '1797-08-30', 'British', 'Autorka Frankensteina.');



INSERT INTO Book_Authors (book_id, author_id) VALUES
(1, 1),     -- 1984 - George Orwell
(2, 2),     -- Pride and Prejudice - Jane Austen
(3, 3),     -- Huck Finn - Mark Twain
(4, 4),     -- Mockingbird - Harper Lee
(5, 5),     -- HP - Rowling
(6, 6),     -- LOTR - Tolkien
(7, 7),     -- Gatsby - Fitzgerald
(8, 8),     -- Solitude - Marquez
(9, 9),     -- Old Man and the Sea - Hemingway
(10, 10),   -- Orient Express - Christie
(11, 11),   -- Fahrenheit 451 - Bradbury
(12, 12),   -- Foundation - Asimov
(13, 13),   -- 2001 - Clarke
(14, 6),    -- Narnia - Tolkien
(15, 6),    -- Hobbit - Tolkien
(16, 14),   -- Brave New World - Huxley
(17, 7),    -- Catcher in the Rye - Fitzgerald
(18, 10),   -- Dracula - Christie (fikt.)
(19, 15),   -- Frankenstein - Mary Shelley
(20, 7),    -- Dorian Gray - Fitzgerald (fikt.)
(21, 11),   -- Shining - Bradbury (fikt.)
(22, 4),    -- Lord of the Flies - Harper Lee (fikt.)
(23, 2),    -- Secret Garden - Jane Austen (fikt.)
(24, 2),    -- Wuthering Heights - Jane Austen (fikt.)
(25, 1),    -- Crime and Punishment - Orwell (fikt.)
(26, 2),    -- Jane Eyre - Jane Austen (fikt.)
(27, 9),    -- The Road - Hemingway (fikt.)
(28, 7),    -- Grapes of Wrath - Fitzgerald (fikt.)
(29, 14),   -- Handmaid’s Tale - Huxley (fikt.)
(30, 15);   -- Bell Jar - Mary Shelley (fikt.)




INSERT INTO Readers (first_name, last_name, email, addres, phone, registration_date) VALUES
('Anna', 'Kowalska', 'anna.kowalska@example.com', 'ul. Lipowa 5, Kraków', '600123456', '2023-01-15'),
('Jan', 'Nowak', 'jan.nowak@example.com', 'ul. Długa 12, Warszawa', '601234567', '2023-02-10'),
('Katarzyna', 'Wiśniewska', 'kasia.wisniewska@example.com', 'ul. Słoneczna 3, Gdańsk', '602345678', '2023-03-05'),
('Piotr', 'Wójcik', 'piotr.wojcik@example.com', 'ul. Leśna 7, Poznań', '603456789', '2023-03-20'),
('Magdalena', 'Kamińska', 'magda.kaminska@example.com', 'ul. Zielona 10, Wrocław', '604567890', '2023-04-12'),
('Tomasz', 'Lewandowski', 't.lewandowski@example.com', 'ul. Krótka 8, Łódź', '605678901', '2023-04-25'),
('Agnieszka', 'Dąbrowska', 'ag.dabrowska@example.com', 'ul. Polna 9, Szczecin', '606789012', '2023-05-03'),
('Marek', 'Zieliński', 'marek.zielinski@example.com', 'ul. Wiosenna 11, Lublin', '607890123', '2023-05-20'),
('Ewa', 'Szymańska', 'ewa.szymanska@example.com', 'ul. Jesienna 2, Katowice', '608901234', '2023-06-01'),
('Rafał', 'Woźniak', 'rafal.wozniak@example.com', 'ul. Spacerowa 14, Bydgoszcz', '609012345', '2023-06-15'),
('Aleksandra', 'Krawczyk', 'ola.krawczyk@example.com', 'ul. Górska 16, Rzeszów', '610123456', '2023-07-05'),
('Michał', 'Kaczmarek', 'm.kaczmarek@example.com', 'ul. Nadbrzeżna 18, Toruń', '611234567', '2023-07-22'),
('Paulina', 'Mazur', 'paulina.mazur@example.com', 'ul. Zaciszna 6, Opole', '612345678', '2023-08-10'),
('Krzysztof', 'Kozłowski', 'krzysztof.kozlowski@example.com', 'ul. Parkowa 20, Olsztyn', '613456789', '2023-08-25'),
('Natalia', 'Jankowska', 'natalia.jankowska@example.com', 'ul. Miodowa 13, Kielce', '614567890', '2023-09-08'),
('Grzegorz', 'Witkowski', 'grzegorz.witkowski@example.com', 'ul. Radosna 22, Gorzów', '615678901', '2023-09-22'),
('Dorota', 'Baran', 'dorota.baran@example.com', 'ul. Malinowa 25, Zamość', '616789012', '2023-10-01'),
('Patryk', 'Sikora', 'patryk.sikora@example.com', 'ul. Piaskowa 30, Koszalin', '617890123', '2023-10-15'),
('Izabela', 'Górska', 'izabela.gorska@example.com', 'ul. Orzechowa 4, Legnica', '618901234', '2023-11-02'),
('Damian', 'Walczak', 'damian.walczak@example.com', 'ul. Sadowa 28, Elbląg', '619012345', '2023-11-20');

INSERT INTO Categories (category_name, descriptions) VALUES
('Science Fiction', 'Książki o przyszłości, technologii i kosmosie.'),
('Fantasy', 'Światy magiczne, mityczne stworzenia, bohaterowie.'),
('Classics', 'Uznane dzieła literatury światowej.'),
('Mystery', 'Kryminały, zagadki, detektywistyczne opowieści.'),
('Romance', 'Historie miłosne, emocjonalne relacje.');

INSERT INTO Book_Categories (book_id, category_id) VALUES
(1, 2),
(1, 3),
(2, 2),
(2, 3),
(3, 5),
(4, 5),
(5, 2),
(6, 4),
(6, 3),
(7, 3),
(8, 2),
(9, 3),
(10, 3),
(10, 1),
(11, 5),
(12, 2),
(12, 4),
(13, 4),
(13, 2),
(14, 2),
(14, 5),
(15, 5),
(15, 4),
(16, 3),
(16, 2),
(17, 5),
(18, 1),
(18, 5),
(19, 2),
(20, 4),
(21, 4),
(22, 5),
(22, 4),
(23, 5),
(23, 1),
(24, 5),
(25, 3),
(25, 1),
(26, 4),
(26, 2),
(27, 1),
(27, 3),
(28, 5),
(29, 3),
(30, 2);

INSERT INTO Loans (book_id, reader_id, loan_date, due_date, return_date, statuss) VALUES
(12, 6, 2025-05-01, 2025-05-15, 2025-05-25, 'spóźniona'),
(30, 17, 2024-08-11, 2024-08-25, NULL, 'wypożyczona'),
(20, 11, 2025-03-02, 2025-03-16, 2025-03-15, 'zwrócona'),
(30, 12, 2024-08-21, 2024-09-04, NULL, 'wypożyczona'),
(27, 10, 2024-12-26, 2025-01-09, 2025-01-10, 'spóźniona'),
(29, 19, 2024-07-19, 2024-08-02, NULL, 'wypożyczona'),
(3, 16, 2024-08-23, 2024-09-06, NULL, 'wypożyczona'),
(25, 18, 2024-11-28, 2024-12-12, NULL, 'wypożyczona'),
(5, 16, 2024-09-07, 2024-09-21, NULL, 'wypożyczona'),
(6, 9, 2025-03-14, 2025-03-28, 2025-04-04, 'spóźniona'),
(14, 7, 2024-12-24, 2025-01-07, NULL, 'wypożyczona'),
(25, 7, 2024-11-19, 2024-12-03, NULL, 'wypożyczona'),
(13, 12, 2024-08-26, 2024-09-09, 2024-09-15, 'spóźniona'),
(15, 4, 2025-03-28, 2025-04-11, 2025-04-10, 'zwrócona'),
(11, 1, 2024-12-31, 2025-01-14, 2025-01-15, 'spóźniona'),
(19, 8, 2025-04-03, 2025-04-17, 2025-04-26, 'spóźniona'),
(21, 2, 2024-10-27, 2024-11-10, 2024-11-08, 'zwrócona'),
(28, 11, 2024-05-17, 2024-05-31, 2024-06-01, 'spóźniona'),
(9, 16, 2025-03-29, 2025-04-12, 2025-04-12, 'zwrócona'),
(24, 19, 2024-09-20, 2024-10-04, 2024-10-05, 'spóźniona'),
(26, 16, 2025-01-16, 2025-01-30, NULL, 'wypożyczona'),
(7, 4, 2024-12-06, 2024-12-20, 2024-12-24, 'spóźniona'),
(12, 14, 2024-09-01, 2024-09-15, 2024-09-24, 'spóźniona'),
(2, 4, 2025-03-05, 2025-03-19, 2025-03-28, 'spóźniona'),
(11, 4, 2024-11-23, 2024-12-07, 2024-12-08, 'spóźniona'),
(18, 15, 2024-05-14, 2024-05-28, 2024-05-28, 'zwrócona'),
(9, 15, 2024-10-20, 2024-11-03, 2024-11-02, 'zwrócona'),
(15, 18, 2024-06-22, 2024-07-06, 2024-07-14, 'spóźniona'),
(18, 1, 2025-03-27, 2025-04-10, NULL, 'wypożyczona'),
(30, 8, 2024-08-10, 2024-08-24, 2024-08-29, 'spóźniona'),
(16, 7, 2025-03-19, 2025-04-02, NULL, 'wypożyczona'),
(29, 2, 2024-12-04, 2024-12-18, 2024-12-16, 'zwrócona'),
(13, 9, 2025-03-13, 2025-03-27, NULL, 'wypożyczona'),
(26, 15, 2025-04-26, 2025-05-10, 2025-05-19, 'spóźniona'),
(24, 18, 2025-02-10, 2025-02-24, NULL, 'wypożyczona'),
(16, 5, 2025-03-25, 2025-04-08, 2025-04-09, 'spóźniona'),
(2, 19, 2024-10-24, 2024-11-07, NULL, 'wypożyczona'),
(2, 11, 2024-07-27, 2024-08-10, 2024-08-17, 'spóźniona'),
(16, 17, 2024-09-15, 2024-09-29, NULL, 'wypożyczona'),
(17, 6, 2025-01-14, 2025-01-28, 2025-02-03, 'spóźniona');

INSERT INTO Fines (loan_id, amount, reason, fine_date, payment_status) VALUES
(1, 6.2, 'Przetrzymanie książki', 2025-05-25, 'zapłacona'),
(5, 6.03, 'Przetrzymanie książki', 2025-01-10, 'zapłacona'),
(10, 15.13, 'Przetrzymanie książki', 2025-04-04, 'zapłacona'),
(13, 11.06, 'Przetrzymanie książki', 2024-09-15, 'zapłacona'),
(15, 13.68, 'Przetrzymanie książki', 2025-01-15, 'zapłacona'),
(16, 14.29, 'Przetrzymanie książki', 2025-04-26, 'niezapłacona'),
(18, 14.86, 'Przetrzymanie książki', 2024-06-01, 'niezapłacona'),
(20, 19.02, 'Przetrzymanie książki', 2024-10-05, 'zapłacona'),
(22, 15.05, 'Przetrzymanie książki', 2024-12-24, 'niezapłacona'),
(23, 8.58, 'Przetrzymanie książki', 2024-09-24, 'niezapłacona'),
(24, 6.96, 'Przetrzymanie książki', 2025-03-28, 'niezapłacona'),
(25, 11.86, 'Przetrzymanie książki', 2024-12-08, 'zapłacona'),
(28, 5.14, 'Przetrzymanie książki', 2024-07-14, 'zapłacona'),
(30, 6.1, 'Przetrzymanie książki', 2024-08-29, 'zapłacona'),
(34, 12.59, 'Przetrzymanie książki', 2025-05-19, 'zapłacona'),
(36, 19.0, 'Przetrzymanie książki', 2025-04-09, 'zapłacona'),
(38, 18.19, 'Przetrzymanie książki', 2024-08-17, 'niezapłacona'),
(40, 9.27, 'Przetrzymanie książki', 2025-02-03, 'niezapłacona');