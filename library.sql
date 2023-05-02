/*

FACTS FOR A LIBRARY DATABASE;

A. The AREA being modelled is:
    a library;

B. The THINGS_OF_INTEREST include:
    B.1. Authors;
    B.2. Books;
    B.3. Publishers;
    B.4. Members;
    B.5. Loans;

C. THESE THINGS_OF_INTEREST are related as follows:
    C.1. An AUTHOR can write many BOOKS;
    C.2. A BOOK can have many AUTHORS;
    C.3. A BOOK must always have one and only one PUBLISHER;
    C.4. A PUBLISHER can has many BOOKS;
    C.5. A MEMBER can be associated with zero or many LOANS;
    C.6. A LOAN must always be associated with one and only one USER;
    C.7. A LOAN must always be associated with one or more BOOKS;
    C.8. A BOOK can be associated with zero or many LOANS;

D. Typical ENQUIRIES include:
    D.1. Do we have any books by Tolstoi?
    D.2. How many books are out on loan?
    D.3. Which company published O Primo Basílio?
    D.4. Which users have borrowed books published before 1974?

*/

DROP DATABASE IF EXISTS new_library;
CREATE DATABASE new_library;
USE new_library;

CREATE TABLE publisher(
publisher_id INTEGER (6) AUTO_INCREMENT,
publisher_name VARCHAR (128) NOT NULL,
PRIMARY KEY (publisher_id)
);

CREATE TABLE member(
  member_id INTEGER AUTO_INCREMENT,
  name VARCHAR (128),
  phone_number INTEGER (9),
  email VARCHAR (128),
  PRIMARY KEY (member_id)
);

CREATE TABLE author(
author_id INTEGER AUTO_INCREMENT,
first_name VARCHAR (64),
last_name VARCHAR (64),
country VARCHAR (64),
PRIMARY KEY (author_id)
);

CREATE TABLE book(
  isbn INTEGER NOT NULL,
  book_title VARCHAR (128) NOT NULL,
  year_of_publication DATE,
  publisher_id INTEGER (6),
  PRIMARY KEY (isbn),
  FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
  ON DELETE CASCADE
);

CREATE TABLE loan(
    loan_id INTEGER AUTO_INCREMENT,
    member_id INTEGER NOT NULL,
    date_issued DATE NOT NULL,
    date_due DATE NOT NULL,
    date_returned DATE,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE book_on_loan(
  loan_id INTEGER,
  isbn INTEGER,
  PRIMARY KEY (loan_id, isbn),
  FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
  ON DELETE CASCADE,
  FOREIGN KEY (isbn) REFERENCES book(isbn)
  ON DELETE CASCADE
);

CREATE TABLE book_by_author(
  author_id INTEGER NOT NULL,
  isbn INTEGER NOT NULL,
  PRIMARY KEY (author_id, isbn),
  FOREIGN KEY (author_id) REFERENCES author(author_id)
  ON DELETE CASCADE,
  FOREIGN KEY (isbn) REFERENCES book(isbn)
  ON DELETE CASCADE
);
