create database paypal;
use paypal;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    is_fraudulent BOOLEAN DEFAULT FALSE
);
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    sender_id INT,
    receiver_id INT,
    transaction_type ENUM('deposit', 'withdrawal', 'transfer') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_fraud BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES Users(user_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO Users (user_name, email, is_fraudulent)
VALUES
('Amit Sharma', 'amit.sharma@example.com', FALSE),
('Priya Singh', 'priya.singh@example.com', FALSE),
('Rahul Verma', 'rahul.verma@example.com', FALSE),
('Sneha Mehta', 'sneha.mehta@example.com', FALSE),
('Vikram Rao', 'vikram.rao@example.com', TRUE),
('Neha Gupta', 'neha.gupta@example.com', FALSE),
('Arjun Patel', 'arjun.patel@example.com', FALSE),
('Meera Joshi', 'meera.joshi@example.com', FALSE),
('Karan Malhotra', 'karan.malhotra@example.com', FALSE),
('Ritu Sharma', 'ritu.sharma@example.com', FALSE),
('Sahil Khan', 'sahil.khan@example.com', FALSE),
('Divya Kapoor', 'divya.kapoor@example.com', FALSE),
('Ankit Mishra', 'ankit.mishra@example.com', TRUE),
('Isha Agarwal', 'isha.agarwal@example.com', FALSE),
('Manish Yadav', 'manish.yadav@example.com', FALSE);
INSERT INTO Transactions 
(account_id, sender_id, receiver_id, transaction_type, amount, transaction_date, is_fraud)
VALUES
(101, 1, NULL, 'deposit', 5000.00, '2025-08-15 10:00:00', FALSE),
(101, 1, NULL, 'withdrawal', 1500.00, '2025-08-16 12:00:00', FALSE),
(102, 2, 3, 'transfer', 2000.00, '2025-08-20 09:15:00', FALSE),
(102, 3, 2, 'transfer', 1500.00, '2025-08-21 14:30:00', FALSE),
(103, 4, NULL, 'deposit', 3000.00, '2025-08-22 16:45:00', FALSE),
(103, 4, NULL, 'withdrawal', 500.00, '2025-08-23 11:00:00', FALSE),
(104, 5, 6, 'transfer', 6000.00, '2025-08-25 10:10:00', TRUE),
(105, 6, NULL, 'deposit', 2500.00, '2025-08-26 13:20:00', FALSE),
(106, 7, 8, 'transfer', 1200.00, '2025-08-27 08:50:00', FALSE),
(106, 8, 7, 'transfer', 1800.00, '2025-08-27 09:00:00', FALSE),
(107, 9, NULL, 'deposit', 7000.00, '2025-08-28 15:00:00', FALSE),
(107, 9, NULL, 'withdrawal', 2000.00, '2025-08-29 12:30:00', FALSE),
(108, 10, 11, 'transfer', 5500.00, '2025-09-01 09:45:00', FALSE),
(109, 12, NULL, 'deposit', 4000.00, '2025-09-05 18:00:00', FALSE),
(109, 12, NULL, 'withdrawal', 1000.00, '2025-09-06 19:15:00', FALSE);
