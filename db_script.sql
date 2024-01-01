drop database bugtrackerdb;

create database bugtrackerdb with owner bugtrackeradmin;

\c bugtrackerdb

-- Create the 'user' table
CREATE TABLE user_account (
    id SERIAL PRIMARY KEY,
    login VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    surname VARCHAR(255)
);

-- Insert sample data
-- Passwords are 123456
INSERT INTO user_account (login, password, name, surname)
VALUES 
    ('oleg_ilinets', '8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 'Oleg', 'Ilinets'),
    ('jane_smith', '8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 'Jane', 'Smith'),
    ('bob_jones', '8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 'Bob', 'Jones');
    

-- Create enumerated types
CREATE TYPE bug_status AS ENUM ('new', 'open', 'solved', 'checked', 'closed');
CREATE TYPE bug_urgency AS ENUM ('very_urgent', 'urgent', 'non_urgent', 'not_at_all_urgent');
CREATE TYPE bug_severity AS ENUM ('blocker', 'critical', 'non_critical', 'request_for_change');

-- Create Bug table using the enumerated types
CREATE TABLE bug (
    id SERIAL PRIMARY KEY,
    date DATE,
    short_description VARCHAR(255),
    long_description TEXT,
    user_id INT,
    status bug_status,
    urgency bug_urgency,
    severity bug_severity,
    FOREIGN KEY (user_id) REFERENCES user_account(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TYPE bug_action AS ENUM ('input', 'assigning', 'solving', 'reopening', 'checking', 'closing');

CREATE TABLE bug_history (
    id SERIAL PRIMARY KEY,
    date_time TIMESTAMP,
    action bug_action,
    comment VARCHAR(255),
    user_id INT,
    bug_id INT,
    FOREIGN KEY (user_id) REFERENCES user_account(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (bug_id) REFERENCES bug(id) ON UPDATE CASCADE ON DELETE CASCADE
);


GRANT INSERT ON TABLE user_account to bugtrackeradmin;
GRANT UPDATE ON TABLE user_account to bugtrackeradmin;
GRANT DELETE ON TABLE user_account to bugtrackeradmin;
GRANT SELECT ON TABLE user_account to bugtrackeradmin;
GRANT USAGE, SELECT ON SEQUENCE user_account_id_seq TO bugtrackeradmin;


GRANT INSERT ON TABLE bug to bugtrackeradmin;
GRANT UPDATE ON TABLE bug to bugtrackeradmin;
GRANT DELETE ON TABLE bug to bugtrackeradmin;
GRANT SELECT ON TABLE bug to bugtrackeradmin;
GRANT USAGE, SELECT ON SEQUENCE bug_id_seq TO bugtrackeradmin;


GRANT INSERT ON TABLE bug_history to bugtrackeradmin;
GRANT UPDATE ON TABLE bug_history to bugtrackeradmin;
GRANT DELETE ON TABLE bug_history to bugtrackeradmin;
GRANT SELECT ON TABLE bug_history to bugtrackeradmin;
GRANT USAGE, SELECT ON SEQUENCE bug_history_id_seq TO bugtrackeradmin;

