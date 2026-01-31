-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2025 at 07:44 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `księgarnia`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `authors`
--

CREATE TABLE `authors` (
  `author_id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `biography` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `first_name`, `last_name`, `birth_date`, `death_date`, `biography`) VALUES
(1, 'J.K.', 'Rowling', '1965-07-31', NULL, 'Brytyjska autorka, znana z serii książek o Harrym Potterze.'),
(2, 'George', 'Orwell', '1903-06-25', '1950-01-21', 'Angielski pisarz i dziennikarz, znany z książek \"1984\" i \"Folwark zwierzęcy.\"'),
(3, 'J.R.R.', 'Tolkien', '1892-01-03', '1973-09-02', 'Brytyjski profesor, pisarz, autor \"Władcy Pierścieni\".');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `books`
--

CREATE TABLE `books` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `publication_year` year(4) DEFAULT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `total_copies` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `available_copies` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `isbn`, `publication_year`, `publisher`, `total_copies`, `available_copies`) VALUES
(1, 'Harry Potter i Kamień Filozoficzny', '9780747532743', '1997', 'Bloomsbury', 100, 79),
(2, '1984', '9780451524935', '1949', 'Secker & Warburg', 50, 44),
(3, 'Władca Pierścieni: Drużyna Pierścienia', '9780261103573', '1954', 'Allen & Unwin', 30, 19);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `book_authors`
--

CREATE TABLE `book_authors` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `book_authors`
--

INSERT INTO `book_authors` (`book_id`, `author_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `book_categories`
--

CREATE TABLE `book_categories` (
  `category_id` smallint(5) UNSIGNED NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `book_categories`
--

INSERT INTO `book_categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Fantasy', 'Książki, które zawierają elementy fantastyczne i nadprzyrodzone, jak magię, elfy, smoki.'),
(2, 'Science Fiction', 'Książki związane z nauką i technologią w przyszłości, często w kontekście fikcyjnych światów.'),
(3, 'Literatura klasyczna', 'Klasyczne utwory literackie, które miały duży wpływ na rozwój literatury.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `book_categories_relation`
--

CREATE TABLE `book_categories_relation` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `book_categories_relation`
--

INSERT INTO `book_categories_relation` (`book_id`, `category_id`) VALUES
(1, 1),
(2, 2),
(3, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `fines`
--

CREATE TABLE `fines` (
  `fine_id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(10) UNSIGNED NOT NULL,
  `fine_amount` decimal(8,2) NOT NULL,
  `fine_date` date NOT NULL DEFAULT curdate(),
  `payment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`fine_id`, `loan_id`, `fine_amount`, `fine_date`, `payment_date`) VALUES
(1, 1, 10.00, '2023-04-20', NULL),
(2, 2, 5.00, '2023-04-22', '2023-04-23');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `loans`
--

CREATE TABLE `loans` (
  `loan_id` int(10) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `reader_id` int(10) UNSIGNED NOT NULL,
  `loan_date` date NOT NULL DEFAULT curdate(),
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL
) ;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`loan_id`, `book_id`, `reader_id`, `loan_date`, `due_date`, `return_date`) VALUES
(1, 1, 1, '2023-04-01', '2023-04-15', NULL),
(2, 2, 2, '2023-04-05', '2023-04-19', NULL),
(3, 3, 3, '2023-04-07', '2023-04-21', '2023-04-15');

--
-- Wyzwalacze `loans`
--
DELIMITER $$
CREATE TRIGGER `after_loan_insert` AFTER INSERT ON `loans` FOR EACH ROW BEGIN
 UPDATE books
 SET available_copies = available_copies - 1
 WHERE book_id = NEW.book_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_loan_update` AFTER UPDATE ON `loans` FOR EACH ROW BEGIN
 IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
 UPDATE books
 SET available_copies = available_copies + 1
 WHERE book_id = NEW.book_id;
 END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `readers`
--

CREATE TABLE `readers` (
  `reader_id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `registration_date` date NOT NULL DEFAULT curdate(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `readers`
--

INSERT INTO `readers` (`reader_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `registration_date`, `is_active`) VALUES
(1, 'Jan', 'Kowalski', 'jan.kowalski@email.com', '123456789', 'Warszawa, ul. Krakowskie Przedmieście 5', '2023-03-01', 1),
(2, 'Anna', 'Nowak', 'anna.nowak@email.com', '987654321', 'Kraków, ul. Długa 12', '2023-03-05', 1),
(3, 'Marek', 'Zieliński', 'marek.zielinski@email.com', '567890123', 'Wrocław, ul. Wrocławska 3', '2023-03-10', 1);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indeksy dla tabeli `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`);

--
-- Indeksy dla tabeli `book_authors`
--
ALTER TABLE `book_authors`
  ADD PRIMARY KEY (`book_id`,`author_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indeksy dla tabeli `book_categories`
--
ALTER TABLE `book_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indeksy dla tabeli `book_categories_relation`
--
ALTER TABLE `book_categories_relation`
  ADD PRIMARY KEY (`book_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indeksy dla tabeli `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fine_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indeksy dla tabeli `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `reader_id` (`reader_id`);

--
-- Indeksy dla tabeli `readers`
--
ALTER TABLE `readers`
  ADD PRIMARY KEY (`reader_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_categories`
--
ALTER TABLE `book_categories`
  MODIFY `category_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fine_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `loan_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `readers`
--
ALTER TABLE `readers`
  MODIFY `reader_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE;

--
-- Constraints for table `book_categories_relation`
--
ALTER TABLE `book_categories_relation`
  ADD CONSTRAINT `book_categories_relation_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_categories_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `book_categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`);

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `readers` (`reader_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
