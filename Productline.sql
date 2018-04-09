CREATE TABLE Productline(
productline INT NOT NULL AUTO_INCREMENT,
   textdescription VARCHAR(100) NOT NULL,
   htmldescription VARCHAR(60) NOT NULL,
   image BLOB,
  primarykey (productline)
  
);
CREATE TABLE Products(
productcode INT NOT NULL ,
   productname VARCHAR(50) NOT NULL,
   productline INT NOT NULL,
   productscale INT NOT NULL,
   productvendor VARCHAR (50) NOT NULL,
   productdescription VARCHAR(50) NOT NULL,
   quantityinstock INT NOT NULL,
   Buyprice FLOAT NOT NULL,
   MSRP INT NOT NULL,
   PRIMARY KEY (productcode)
);
CREATE TABLE orderdetails (
	productcode	INT NOT NULL,
	ordernumber	INT NOT NULL,
	quantityordered	INT NOT NULL,
	priceeach	INT NOT NULL,
	orderlinenumber	INT NOT NULL,
	FOREIGN KEY(ordernumber) REFERENCES orders(ordernumber),
	FOREIGN KEY(productcode) REFERENCES Products(productcode),
	PRIMARY KEY(productcode,ordernumber)
);

CREATE TABLE orders(
  ordernumber INT NOT NULL,
  orderdate date not NULL ,
  requiredate date NOT NULL,
  shippeddate date NOT NULL ,
   status varchar(20) not NULL,
   comments varchar(50),
   customernumber INT not null ,
   PRIMARY KEY (ordernumber),
   FOREIGN KEY (customernumber) REFERENCES customer (customernumber)
);
CREATE TABLE customers(
   customernumber INT not null ,
  customername varchar(50) not NULL,
  contactfirstname varchar(20) not NULL,
  contactlastname varchar (20) not NULL,
  phone int not NULL,
  addressline1 varchar(50) not NULL,
  addressline2 varchar (60) not NULL,
    city varchar(20) not NULL,
   comments varchar(50) not NULL,
   state_name varchar(30) not NULL,
   country varchar(30) not null,
   postalcode INT not null,
   creditlimit int not NULL,
   salesrepemployeenumber int not null,
   PRIMARY KEY (customernumber),
   FOREIGN KEY (salesrepemployeenumber) REFERENCES employee (employeenumber)
);
CREATE TABLE employee(
  employeenumber INT NOT NULL,
   firstname varchar(20) not NULL,
   lastname varchar(50) not NULL,
   extension varchar(20) not NULL,
   email varchar (25) not NULL,
   officecode int not null,
   reportsto int ,
   job title varchar (50) not NULL,
   PRIMARY KEY (employeenumber),
   FOREIGN KEY (officecode) REFERENCES offices (officecode),
   FOREIGN KEY (reportsto) REFERENCES empolyee (employeenumber)
);
CREATE TABLE offices(
	officecode int not null,
 phone INT NOT NULL,
   city varchar(20) not NULL, 
   adressline1 varchar(50) not NULL,
   adressline2 varchar(50) not null,
   state_name varchar(20) not NULL,
   country varchar (25) not NULL,
   postalcode int not null,
   territory int not null,
   PRIMARY KEY (officecode)
   
);
CREATE table payments (
customernumber int not null,
checknumber int not null,
paymentdate date not null,
amount int not null,
PRIMARY key (customernumber,checknumber),
FOREIGN key (customernumber) REFERENCES customers (customernumber)
);