



CREATE TABLE Klient (
    id_klienta INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    email VARCHAR(100),
    telefon VARCHAR(20)
);

CREATE TABLE Bilet (
    id_biletu INT AUTO_INCREMENT PRIMARY KEY,
    typ ENUM('normalny', 'ulgowy'),
    data_rezerwacji DATETIME,
    cena DECIMAL(10, 2),
    status ENUM('zarezerwowany', 'anulowany')
);

CREATE TABLE Rezerwacja (
    id_rezerwacji INT AUTO_INCREMENT PRIMARY KEY,
    id_klienta INT,
    id_biletu INT,
    data_wyjazdu DATETIME,
    miejsce_wyjazdu VARCHAR(100),
    miejsce_przyjazdu VARCHAR(100),
    FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta),
    FOREIGN KEY (id_biletu) REFERENCES Bilet(id_biletu)
);

CREATE TABLE Wydarzenie (
    id_wydarzenia INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(100),
    data_wydarzenia DATETIME,
    lokalizacja VARCHAR(200)
);

CREATE TABLE Platnosc (
    id_platnosci INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    kwota DECIMAL(10, 2),
    data_platnosci DATETIME,
    status_platnosci ENUM('opłacona', 'nieopłacona', 'odrzucona'),
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacja(id_rezerwacji)
);


INSERT INTO Klient (imie, nazwisko, email, telefon) VALUES
('Jan', 'Kowalski', 'jan.kowalski@example.com', '123456789'),
('Anna', 'Nowak', 'anna.nowak@example.com', '987654321');

INSERT INTO Bilet (typ, data_rezerwacji, cena, status) VALUES
('normalny', '2025-04-10 10:00:00', 100.00, 'zarezerwowany'),
('ulgowy', '2025-04-12 14:00:00', 50.00, 'zarezerwowany');

INSERT INTO Rezerwacja (id_klienta, id_biletu, data_wyjazdu, miejsce_wyjazdu, miejsce_przyjazdu) VALUES
(1, 1, '2025-04-15 08:00:00', 'Warszawa', 'Kraków'),
(2, 2, '2025-04-16 12:00:00', 'Poznań', 'Gdańsk');

INSERT INTO Wydarzenie (nazwa, data_wydarzenia, lokalizacja) VALUES
('Koncert Rockowy', '2025-04-20 18:00:00', 'Warszawa, Stadion Narodowy'),
('Spektakl Teatralny', '2025-04-22 20:00:00', 'Kraków, Teatr Stary');

INSERT INTO Platnosc (id_rezerwacji, kwota, data_platnosci, status_platnosci) VALUES
(1, 100.00, '2025-04-10 10:30:00', 'opłacona'),
(2, 50.00, '2025-04-12 14:30:00', 'opłacona');
