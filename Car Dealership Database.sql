CREATE TABLE service_ticket_mechanic(
  service_mechanic_id SERIAL PRIMARY KEY,
  service_id INTEGER,
  mechanic_id INTEGER,
  FOREIGN KEY ("mechanic_id") REFERENCES mechanic(mechanic_id)
);

CREATE TABLE salesperson (
  sales_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INTEGER,
  address VARCHAR(150),
  email VARCHAR(50)
);

CREATE TABLE invoice (
  invoice_id SERIAL PRIMARY KEY,
  customer_id INTEGER,
  sales_id INTEGER,
  car_id INTEGER,
  invoice_amount NUMERIC(8,2),
  invoice_date DATE,
  FOREIGN KEY ("car_id") REFERENCES salesperson(sales_id),
  FOREIGN KEY ("invoice_id") REFERENCES Customer(customer_id)
);

CREATE TABLE car (
  car_id SERIAL PRIMARY KEY,
  car_make VARCHAR(50),
  car_model VARCHAR(50),
  car_year INTEGER,
  license_plate VARCHAR(6)
);

CREATE TABLE service_ticket (
  service_id SERIAL PRIMARY KEY,
  customer_id INTEGER,
  car_id INTEGER,
  parts VARCHAR(50),
  service_amount NUMERIC(6,2),
  service_type VARCHAR(50),
  FOREIGN KEY ("car_id") REFERENCES car(car_id),
  FOREIGN KEY ("service_id") REFERENCES service_ticket_mechanic(service_id)
);

CREATE TABLE mechanic (
  mechanic_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

---inserting data----
insert into salesperson(sales_id, first_name, last_name)
values 
	('1234', 'John', 'Leach'),
	('6380', 'Marty', 'Jones'),
	('1654', 'Terri', 'Copper'),
	('0015', 'Amy', 'Halpert'),
	('7874', 'Mike', 'Dennis');
	
insert into mechanic(mechanic_id, first_name, last_name)
values 
	('3546', 'Joseph', 'Dane'),
	('4785', 'Dustin', 'Cook'),
	('2135', 'Cindy', 'Stoker'),
	('0021', 'Val', 'Draper');
	
insert into car(car_id, car_make,car_model,car_year,license_plate)
values 
	('4502', 'Toyota', 'Camry', '2013', 'AT4RZ8'),
	('7712', 'Honda', 'Accord', '2022', 'REP987'),
	('0035', 'Hyundai', 'Sonata', '2017', 'T11K9L');

--creating stored procedure --
	
create or replace FUNCTION car_add (car_id integer, car_make varchar(50), car_model varchar(50), car_year integer, license_plate varchar(6))
RETURNS void
AS $MAIN$
begin 
	insert into car(car_id, car_make, car_model, car_year, license_plate)
	values(car.car_id, car.car_make, car.car_model, car.car_year, car.license_plate);
END;
$MAIN$
LANGUAGE plpgsql;

---using stored procedure---

select car_add('4238', 'Toyota', 'Highlander', '2006', 'API500');

select car_add('0032', 'Honda', 'Civic', '2022', 'CPRTR4');

