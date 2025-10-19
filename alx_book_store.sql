CREATE DATABASE IF NOT EXISTS alx_book_store;
USE alx_book_store;

CREATE TABLE Authors (
  author_id INT AUTO_INCREMENT,
  author_name VARCHAR(215) NOT NULL,
  PRIMARY KEY (author_id)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT,
  customer_name VARCHAR(215) NOT NULL,
  email VARCHAR(215) NOT NULL,
  address TEXT,
  PRIMARY KEY (customer_id)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE books (
  book_id INT AUTO_INCREMENT,
  title VARCHAR(130) NOT NULL,
  author_id INT NOT NULL,
  price DOUBLE NOT NULL,
  publication_date DATE,
  PRIMARY KEY (book_id),
  FOREIGN KEY (author_id) REFERENCES Authors (author_id)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE order_details (
  order_detail_id INT AUTO_INCREMENT,
  order_id INT NOT NULL,
  book_id INT NOT NULL,
  quantity DOUBLE NOT NULL,
  PRIMARY KEY (order_detail_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (book_id) REFERENCES books (book_id)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;