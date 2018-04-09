CREATE TABLE actor (
  actor_id    SMALLINT     NOT NULL AUTO_INCREMENT,
  first_name  VARCHAR(45)  NOT NULL,
  last_name   VARCHAR(45)  NOT NULL,
  last_update TIMESTAMP    NOT NULL,
  PRIMARY KEY (actor_id)
);

CREATE TABLE language (
  language_id  TINYINT    NOT NULL AUTO_INCREMENT,
  name         CHAR(20)   NOT NULL,
  last_update  TIMESTAMP  NOT NULL,
  PRIMARY KEY (language_id)
);

CREATE TABLE film (
  film_id              SMALLINT(5)  NOT NULL AUTO_INCREMENT,
  title                VARCHAR(255) NOT NULL,
  description          TEXT         DEFAULT NULL,
  release_year         YEAR         DEFAULT NULL,
  language_id          TINYINT(3)   NOT NULL,
  original_language_id TINYINT(3)   DEFAULT NULL,
  rental_duration      TINYINT(3)   NOT NULL,
  rental_rate          DECIMAL(4,2) NOT NULL,  
  length               SMALLINT(5)  DEFAULT NULL,
  replacement_cost     DECIMAL(5,2) NOT NULL,
  rating               ENUM('U','UA','A')  DEFAULT NULL, 
  special_features     SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  last_update          TIMESTAMP    NOT NULL,
  PRIMARY KEY (film_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  FOREIGN KEY (original_language_id) REFERENCES language (language_id)
);

CREATE TABLE film_actor(
  actor_id SMALLINT(5) NOT NULL ,
  film_id SMALLINT(5) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY(actor_id,film_id),
  FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
  FOREIGN KEY (film_id) REFERENCES film(film_id)
); 

CREATE TABLE category(
  category_id TINYINT(3) NOT NULL AUTO_INCREMENT,
  name VARCHAR(25) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY(category_id)
);

CREATE TABLE film_category(
  film_id SMALLINT(5) NOT NULL,
  category_id TINYINT(3) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY(film_id,category_id),
  FOREIGN KEY(film_id) REFERENCES film(film_id),
  FOREIGN KEY(category_id) REFERENCES category(category_id)
  );
  
CREATE TABLE film_text(
  film_id SMALLINT(6) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  PRIMARY KEY(film_id) 
  );  
  
CREATE TABLE country (
  country_id   SMALLINT(5) NOT NULL AUTO_INCREMENT,
  country      VARCHAR(50) NOT NULL,
  last_update  TIMESTAMP   NOT NULL,
  PRIMARY KEY  (country_id)
);

CREATE TABLE city (
  city_id      SMALLINT(5) NOT NULL AUTO_INCREMENT,
  city         VARCHAR(50) NOT NULL,
  country_id   SMALLINT(5) NOT NULL,
  last_update  TIMESTAMP   NOT NULL,
  PRIMARY KEY  (city_id),
  FOREIGN KEY (country_id) REFERENCES country (country_id)
);

CREATE TABLE address (
  address_id   SMALLINT(5) NOT NULL AUTO_INCREMENT,
  address      VARCHAR(50) NOT NULL,
  address2     VARCHAR(50) DEFAULT NULL,
  district     VARCHAR(20) NOT NULL,
  city_id      SMALLINT(5) NOT NULL,
  postal_code  VARCHAR(10) DEFAULT NULL,
  phone        VARCHAR(20) NOT NULL,
  last_update  TIMESTAMP   NOT NULL,
  PRIMARY KEY  (address_id),
  FOREIGN KEY (city_id) REFERENCES city (city_id)
);

CREATE TABLE store (
  store_id          TINYINT(3)    NOT NULL AUTO_INCREMENT,
  manager_staff_id  TINYINT(3)    NOT NULL,
  address_id        SMALLINT(5)   NOT NULL,
  last_update       TIMESTAMP     NOT NULL,
  PRIMARY KEY (store_id)
  #FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id),
  #FOREIGN KEY (address_id) REFERENCES address (address_id)
);
 
CREATE TABLE staff (  
  staff_id     TINYINT(3)  NOT NULL AUTO_INCREMENT,
  first_name   VARCHAR(45) NOT NULL,
  last_name    VARCHAR(45) NOT NULL,
  address_id   SMALLINT(5) NOT NULL,
  picture      BLOB        DEFAULT NULL,
  email        VARCHAR(50) DEFAULT NULL,
  store_id     TINYINT(3)  NOT NULL,
  active       TINYINT(1)  NOT NULL,
  username     VARCHAR(16) NOT NULL,
  password     VARCHAR(40) DEFAULT NULL,
  last_update  TIMESTAMP   NOT NULL,
  PRIMARY KEY  (staff_id)
  #FOREIGN KEY (store_id) REFERENCES store (store_id),
  #FOREIGN KEY (address_id) REFERENCES address (address_id)
);

ALTER TABLE store ADD FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id);
ALTER TABLE store ADD FOREIGN KEY (address_id) REFERENCES address (address_id);
ALTER TABLE staff ADD FOREIGN KEY (store_id) REFERENCES store (store_id);
ALTER TABLE staff ADD FOREIGN KEY (address_id) REFERENCES address (address_id);

CREATE TABLE inventory (
  inventory_id  MEDIUMINT(8)  NOT NULL AUTO_INCREMENT,
  film_id       SMALLINT(5)   NOT NULL,
  store_id      TINYINT(3)    NOT NULL,
  last_update   TIMESTAMP     NOT NULL,
  PRIMARY KEY  (inventory_id),
  FOREIGN KEY (store_id) REFERENCES store (store_id), 
  FOREIGN KEY (film_id) REFERENCES film (film_id) 
);

CREATE TABLE customer (
  customer_id  SMALLINT(5) NOT NULL AUTO_INCREMENT,
  store_id     TINYINT(3)  NOT NULL,
  first_name   VARCHAR(45) NOT NULL,
  last_name    VARCHAR(45) NOT NULL,
  email        VARCHAR(50) DEFAULT NULL,
  address_id   SMALLINT(5) NOT NULL,
  active       TINYINT(1)  NOT NULL DEFAULT TRUE,
  create_date  DATETIME    NOT NULL,
  last_update  TIMESTAMP   NOT NULL,
  PRIMARY KEY  (customer_id),
  FOREIGN KEY (address_id) REFERENCES address (address_id),
  FOREIGN KEY (store_id) REFERENCES store (store_id)
);

CREATE TABLE rental (
  rental_id     INT(11)     NOT NULL AUTO_INCREMENT,
  rental_date   DATETIME    NOT NULL,
  inventory_id  MEDIUMINT(8)NOT NULL,
  customer_id   SMALLINT(5) NOT NULL,
  return_date   DATETIME    DEFAULT NULL,
  staff_id      TINYINT(3)  NOT NULL,
  last_update   TIMESTAMP   NOT NULL,
  PRIMARY KEY (rental_id),
  FOREIGN KEY (staff_id) REFERENCES staff (staff_id),
  FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE payment (
  payment_id    SMALLINT(5)     NOT NULL AUTO_INCREMENT,
  customer_id   SMALLINT(5)     NOT NULL,
  staff_id      TINYINT(3)      NOT NULL,
  rental_id     INT(11)          DEFAULT NULL,
  amount        DECIMAL(5,2) NOT NULL,
  payment_date  DATETIME     NOT NULL,
  last_update   TIMESTAMP    NOT NULL,
  PRIMARY KEY  (payment_id),
  KEY idx_fk_staff_id (staff_id),
  KEY idx_fk_customer_id (customer_id),
  FOREIGN KEY (rental_id) REFERENCES rental (rental_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);
