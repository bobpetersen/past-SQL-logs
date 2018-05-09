CREATE TABLE "customers" (
    "id" SERIAL PRIMARY KEY,
    "first_name" VARCHAR(60),
    "last_name" VARCHAR(80)
);
CREATE TABLE "addresses" (
    "id" SERIAL PRIMARY KEY,
    "street" VARCHAR(255),
    "city" VARCHAR(60),
    "state" VARCHAR(2),
    "zip" VARCHAR(12),
    "address_type" VARCHAR(8),
    "customer_id" INT REFERENCES "customers"
);

CREATE TABLE "orders" (
    "id" SERIAL PRIMARY KEY,
    "order_date" date,
    "total" NUMERIC(4,2),
    "address_id" INT REFERENCES "addresses"
);

CREATE TABLE "products" (
    "id" SERIAL PRIMARY KEY,
    "description" VARCHAR(255),
    "unit_price" NUMERIC(3,2)
);

CREATE TABLE "line_items" (
    "id" SERIAL PRIMARY KEY,
    "unit_price" NUMERIC(3,2),
    "quantity" INT,
    "order_id" INT REFERENCES "orders",
    "product_id" INT REFERENCES "products"
);

CREATE TABLE "warehouse" (
    "id" SERIAL PRIMARY KEY,
    "warehouse" VARCHAR(55),
    "fulfillment_days" INT
);

CREATE TABLE "warehouse_product" (
    "product_id" INT NOT NULL REFERENCES "products",
    "warehouse_id" INT NOT NULL REFERENCES "warehouse",
    "on_hand" INT,
    PRIMARY KEY (product_id, warehouse_id)
);

INSERT INTO "customers" 
VALUES (1, 'Lisa', 'Bonet'),
(2, 'Charles', 'Darwin'),
(3, 'George', 'Foreman'),
(4, 'Lucy', 'Liu');

INSERT INTO "addresses" 
VALUES (1, '1 Main St', 'Detroit', 'MI', '31111', 'home', 1), 
(2, '555 Some Pl', 'Chicago', 'IL', '60611', 'business', 1),
(3, '8900 Linova Ave', 'Minneapolis', 'MN', '55444', 'home', 2),
(4, 'PO Box 999', 'Minneapolis', 'MN', '55334', 'business', 3),
(5, '3 Charles Dr', 'Los Angeles', 'CA', '00000', 'home', 4),
(6, '934 Superstar Ave', 'Portland', 'OR', '99999', 'business', 4);

INSERT INTO "orders" 
VALUES (1, '2010-03-05', 88.00, 1),
(2, '2012-02-08', 23.50, 2),
(3, '2016-02-07', 4.09, 2),
(4, '2011-03-04', 4.00, 3),
(5, '2012-09-22', 12.99, 5),
(6, '2012-09-23', 23.00, 6),
(7, '2013-05-25', 39.12, 5);

INSERT INTO "products" 
VALUES (1, 'toothbrush', 3.00),
(2, 'nail polish - blue', 4.25),
(3, 'generic beer can', 2.50),
(4, 'lysol', 6.00),
(5, 'cheetos', 0.99),
(6, 'diet pepsi', 1.20),
(7, 'wet ones baby wipes', 8.99);

INSERT INTO "line_items" 
VALUES (1, 5.00, 16, 1, 1),
(2, 3.12, 4, 1, 2),
(3, 4.00, 2, 2, 3),
(4, 7.25, 3, 4, 4),
(5, 6.00, 1, 5, 7),
(6, 2.34, 6, 6, 5),
(7, 1.05, 9, 7, 5);

INSERT INTO "warehouse" VALUES (1, 'alpha', 2),
(2, 'beta', 3),
(3, 'delta', 4),
(4, 'gamma', 4),
(5, 'epsilon', 5);

INSERT INTO "warehouse_product" 
VALUES (1, 3, 0),
(1, 1, 5),
(2, 4, 20),
(3, 5, 3),
(4, 2, 9),
(4, 3, 12),
(5, 3, 7),
(6, 1, 1),
(7, 2, 4),
(6, 3, 88),
(6, 4, 3);

--Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses"
ON "addresses"."customer_id" = "customers"."id"
ORDER BY "addresses"."id";

--Get all orders and their line items.
SELECT * FROM "orders"
JOIN "line_items"
ON "line_items"."order_id"="orders"."id" 
ORDER BY "line_items"."id";

--Which warehouses have cheetos?
SELECT * FROM "warehouse_product"
WHERE "product_id"= 5;

--Which warehouses have diet pepsi?
SELECT * FROM "warehouse_product"
WHERE "product_id"= 6;

--Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "addresses"."street","orders"."address_id",
COUNT ("address_id") FROM "orders"
JOIN "addresses" ON "addresses"."id"="orders"."address_id"
GROUP BY "addresses"."street","orders"."address_id";

--How many customers do we have?
SELECT COUNT(*) FROM "customers";

--How many products do we carry?
SELECT COUNT(*) FROM "products";

--What is the total available on-hand quantity of diet pepsi?
SELECT SUM ("on_hand") FROM "warehouse_product"
WHERE "product_id"=6;


SELECT "addresses"."street", "orders"."address_id", "customers"."last_name",
COUNT ("address_id")
FROM "orders"
JOIN "addresses" ON "addresses"."id"="orders"."address_id", 
JOIN "customers" ON "addresses"."customer_id"="customers"."id",
GROUP BY "addresses"."street","orders"."address_id";


















