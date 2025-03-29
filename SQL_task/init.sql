CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    domain_id INT,
    language_id INT
);

INSERT INTO users (id, email, first_name, last_name, phone, domain_id, language_id) VALUES
(35, 'jsmith@example.com', 'John', 'Smith', '(123) 456-7890', 1, 1),
(47, 'ldoe@example.com', 'Laura', 'Doe', '(987) 654-3210', 1, 1),
(51, 'mbrown@example.com', 'Michael', 'Brown', '(555) 123-4567', 4, 5),
(36, 'mbrown@example.com', 'Michael', 'Brown', '(555) 123-4567', 1, 5),
(70, 'mbrown@example.com', 'Michael', 'Brown', '(555) 123-4567', 3, 5),
(71, 'mbrown@example.com', 'Michael', 'Brown', '(555) 123-4567', 3, 5);

CREATE TABLE leads (
    id INT PRIMARY KEY,
    user_id INT,
    course_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('NEW', 'WON', 'LOST') NOT NULL,
    lost_reason VARCHAR(50) NULL
    
);

INSERT INTO leads (id, user_id, course_id, created_at, updated_at, status, lost_reason) VALUES
(10, 35, 28, '2024-01-14 11:17:29', '2024-02-26 17:28:13', 'LOST', 'NO_CONTACT'),
(11, 36, 27, '2024-01-15 11:17:29', '2024-02-26 17:28:13', 'LOST', 'NO_CONTACT'),
(4, 70, 27, '2024-01-06 11:17:29', '2024-02-26 17:28:13', 'LOST', 'NOT_INTERESTING'),
(15, 71, 27, '2024-01-15 11:17:29', '2024-02-26 17:28:13', 'LOST', 'NOT_INTERESTING'),
(16, 35, 27, '2024-01-13 18:42:38', '2024-01-30 12:01:44', 'WON', NULL),
(45, 62, 27, '2024-01-12 16:49:15', '2024-02-13 09:13:07', 'NEW', NULL),
(48, 64, 28, '2024-01-12 16:49:15', '2024-02-13 09:13:07', 'WON', NULL),
(49, 70, 28, '2024-01-12 16:49:15', '2024-02-13 09:13:07', 'WON', NULL),
(50, 71, 28, '2023-11-12 16:49:15', '2024-02-13 09:13:07', 'WON', NULL),
(47, 63, 28, '2024-01-11 16:49:15', '2024-02-16 09:12:07', 'NEW', NULL);

CREATE TABLE domains (
    id INT PRIMARY KEY,
    slug VARCHAR(10) NOT NULL UNIQUE,
    country_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL
);

INSERT INTO domains (id, slug, country_name, created_at, updated_at, active) VALUES
(1, 'ua', 'Ukraine', '2023-07-27 09:31:22', '2024-02-26 10:21:53', TRUE),
(3, 'pl', 'Poland', '2023-12-21 09:14:32', '2024-02-15 11:24:51', FALSE);



CREATE TABLE courses (
    id INT PRIMARY KEY,
    slug VARCHAR(255) NOT NULL,
    type ENUM('MODULE', 'FULL_TIME', 'FLEX') NOT NULL,
    language_id INT NOT NULL,
    sort INT NOT NULL
);

INSERT INTO courses (id, slug, type, language_id, sort) VALUES
(12, 'python_basics', 'MODULE', 1, 3),
(25, 'frontend', 'FULL_TIME', 1, 5),
(27, 'devops', 'FLEX', 1, 1),
(28, 'devops', 'FLEX', 1, 3);