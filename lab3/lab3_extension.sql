-- ============================================================
-- Lab 03: Dataset Extension — User Sessions
-- Author: Mistral Vibe
-- Date: 2024-02-20
-- ============================================================

DROP TABLE IF EXISTS user_sessions;

CREATE TABLE user_sessions (
    session_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    session_date DATE NOT NULL,
    pages_viewed INTEGER NOT NULL DEFAULT 1,
    duration_mins DECIMAL(6,2) NOT NULL,
    device VARCHAR(20) NOT NULL,
    converted BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO user_sessions
(customer_id, session_date, pages_viewed, duration_mins, device, converted)
VALUES
-- Ali Hassan (customer 1)
(1, '2024-10-05', 8, 14.5, 'mobile', FALSE),
(1, '2024-10-18', 12, 22.3, 'desktop', TRUE),
(1, '2025-01-15', 5, 8.1, 'mobile', FALSE),
(1, '2025-04-01', 15, 31.0, 'desktop', TRUE),
-- Sara Khan (customer 2)
(2, '2024-09-10', 3, 4.2, 'mobile', FALSE),
(2, '2024-09-11', 10, 18.7, 'desktop', TRUE),
(2, '2025-06-15', 6, 9.5, 'tablet', FALSE),
(2, '2025-06-17', 14, 25.4, 'desktop', TRUE),
-- Usman Tariq (customer 3)
(3, '2024-09-28', 7, 12.0, 'mobile', FALSE),
(3, '2024-10-05', 9, 16.8, 'desktop', TRUE),
(3, '2025-02-14', 4, 6.3, 'mobile', FALSE),
(3, '2025-05-20', 11, 20.5, 'desktop', TRUE),
-- Ayesha Malik (customer 4)
(4, '2024-11-01', 5, 8.7, 'mobile', FALSE),
(4, '2024-11-03', 8, 15.2, 'desktop', TRUE),
(4, '2025-03-10', 7, 13.1, 'tablet', FALSE),
(4, '2025-07-15', 10, 18.9, 'desktop', TRUE),
-- Hassan Raza (customer 5)
(5, '2024-12-12', 6, 10.4, 'mobile', FALSE),
(5, '2024-12-15', 13, 24.1, 'desktop', TRUE),
(5, '2025-04-05', 8, 14.7, 'mobile', FALSE),
(5, '2025-08-20', 16, 29.3, 'desktop', TRUE),
-- Maria Ahmed (customer 6)
(6, '2024-08-18', 4, 7.2, 'mobile', FALSE),
(6, '2024-08-20', 7, 13.5, 'desktop', TRUE),
(6, '2025-01-05', 5, 9.8, 'mobile', FALSE),
(6, '2025-05-10', 9, 17.6, 'desktop', TRUE),
-- Ahmed Khan (customer 7)
(7, '2024-07-05', 3, 5.1, 'mobile', FALSE),
(7, '2024-07-08', 6, 11.3, 'desktop', TRUE),
(7, '2025-02-15', 4, 7.9, 'mobile', FALSE),
(7, '2025-06-25', 8, 15.7, 'desktop', TRUE),
-- Fatima Ali (customer 8)
(8, '2024-10-20', 5, 9.2, 'mobile', FALSE),
(8, '2024-10-22', 9, 17.4, 'desktop', TRUE),
(8, '2025-03-05', 6, 11.8, 'tablet', FALSE),
(8, '2025-07-10', 12, 22.5, 'desktop', TRUE),
-- Zainab Iqbal (customer 9)
(9, '2024-11-15', 4, 7.6, 'mobile', FALSE),
(9, '2024-11-18', 8, 15.9, 'desktop', TRUE),
(9, '2025-04-10', 5, 9.4, 'mobile', FALSE),
(9, '2025-08-15', 10, 19.2, 'desktop', TRUE),
-- Bilal Shahid (customer 10)
(10, '2024-09-05', 6, 11.0, 'mobile', FALSE),
(10, '2024-09-08', 11, 20.8, 'desktop', TRUE),
(10, '2025-01-20', 7, 13.3, 'mobile', FALSE),
(10, '2025-05-25', 13, 24.6, 'desktop', TRUE);