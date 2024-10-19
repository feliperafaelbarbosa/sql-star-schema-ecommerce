CREATE SCHEMA star_schema_ecommerce;

USE star_schema_ecommerce;

CREATE TABLE products_dimension (
	i_product_id INT AUTO_INCREMENT PRIMARY KEY,
    s_product_name VARCHAR(50) NOT NULL,
    s_product_category VARCHAR(50) NOT NULL,
    d_product_price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products_dimension(s_product_name, s_product_category, d_product_price) VALUES
("televisão", "eletrodoméstico", 3000.00),
("ventilador", "eletrodoméstico", 390.00),
("sabão", "limpeza", 3000.00),
("bicicleta", "mobilidade", 1560.00);

CREATE TABLE dates_dimension (
	i_date_id INT AUTO_INCREMENT PRIMARY KEY,
    d_date_day DATE NOT NULL,
    i_date_month INT NOT NULL,
    y_date_year YEAR NOT NULL
);

INSERT INTO dates_dimension (d_date_day, i_date_month, y_date_year) VALUES
("2022-10-10", 10, 2022),
("2021-05-03", 03, 2021),
("2024-12-22", 12, 2024),
("2022-06-20", 06, 2022);

CREATE TABLE customers_dimension (
	i_customer_id INT AUTO_INCREMENT PRIMARY KEY,
    s_customer_name VARCHAR(50) NOT NULL,
    s_customer_email VARCHAR(50) NOT NULL,
    s_customer_address VARCHAR(50) NOT NULL,
    s_customer_city VARCHAR(50) NOT NULL
);

INSERT INTO customers_dimension (s_customer_name, s_customer_email, s_customer_address, s_customer_city) VALUES
("Maria", "maria@email.com", "rua 1", "belém"),
("João", "joao@email.com", "rua 2", "ananindeua"),
("José", "jose@email.com", "rua 3", "acará"),
("Raimundo", "raimundo@email.com", "rua 4", "marituba");

CREATE TABLE order_facts (
	i_order_id INT AUTO_INCREMENT PRIMARY KEY,
    i_order_quantity INT NOT NULL,
    i_customer_id INT NOT NULL,
    i_date_id INT NOT NULL,
    i_product_id INT NOT NULL,
    d_order_total_amount DECIMAL(10, 2),
    FOREIGN KEY (i_customer_id) REFERENCES customers_dimension (i_customer_id),
    FOREIGN KEY (i_date_id) REFERENCES dates_dimension (i_date_id),
    FOREIGN KEY (i_product_id) REFERENCES products_dimension (i_product_id)
);

INSERT INTO order_facts(i_product_id, i_customer_id, i_date_id, i_order_quantity, d_order_total_amount)
SELECT pd.i_product_id, 1 , 1, 2, (2 * pd.d_product_price)
FROM products_dimension AS pd
WHERE pd.i_product_id = 1;

INSERT INTO order_facts(i_order_quantity, i_customer_id, i_date_id, i_product_id, d_order_total_amount)
SELECT 2, 3, 2, pd.i_product_id, (2 * pd.d_product_price)
FROM products_dimension AS pd
WHERE pd.i_product_id = 2;

SELECT * FROM order_facts;

