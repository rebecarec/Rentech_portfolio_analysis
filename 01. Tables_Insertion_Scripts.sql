
####-> CREATE SCHEMA medievaltrust; <- ############ after we create the schema once, we cannot run the code over the same thing again
USE medievaltrust;

#### creating a table :)
#### CREATE TABLE customer_details(
#	customer_id INT,
#    full_name VARCHAR(250),
#    first_name VARCHAR(150),
#    last_name VARCHAR(250),
#    email VARCHAR(250),
#    customer_location VARCHAR(250),
#    rel_manager_name VARCHAR(250),
#PRIMARY KEY(customer_id)
# ); ### closing the customer_details

## Template for inserting data -> INSERT INTO customer_details(customer_id, full_name, first_name, last_name, email, customer_location, rel_manager_name)VALUES('','','','','','',''); ###########
# INSERT INTO customer_details(customer_id, full_name, first_name, last_name, email, customer_location, rel_manager_name)VALUES(1,'Berkshire Hathway','Warren','Buffet','info@berkshire.com','Omaha','Daniel Rey');
REPLACE customer_details(customer_id, full_name, first_name, last_name, email, customer_location, rel_manager_name)VALUES(2,'Rennaisance Technologies','Jim','Simmons','info@rentec.com','New York','Momoko Furukawa');
REPLACE customer_details(customer_id, full_name, first_name, last_name, email, customer_location, rel_manager_name)VALUES(3,'Bridge Water','Ray','Dalio','info@bridgewater.com','Westport','Ana Caldana');
REPLACE customer_details(customer_id, full_name, first_name, last_name, email, customer_location, rel_manager_name)VALUES(4,'Fisher Investments','Ken','Fisher','info@fisherinvestments.com','Cambridge','Fabiola Esturau');

SELECT *
FROM customer_details;

DROP TABLE account_dim;
CREATE TABLE account_dim(
	account_id INT,
    customer_id INT, #### Foreign Key from customer_details table <- This is where we will connect shtufff
    main_account INT,
    opt38 INT, ####
    opt38_desc VARCHAR(10),
    acct_open_date DATE,
PRIMARY KEY(account_id)
); ######## closing the table details

INSERT INTO account_dim(account_id, customer_id, main_account, opt38, opt38_desc, acct_open_date)VALUES('1','2','1','1','main','2025-02-28'); 
INSERT INTO account_dim(account_id, customer_id, main_account, opt38, opt38_desc, acct_open_date)VALUES('101','2','1','2','sub','2025-06-15'); 
INSERT INTO account_dim(account_id, customer_id, main_account, opt38, opt38_desc, acct_open_date)VALUES('102','2','1','2','sub','2026-06-15'); 

SELECT *
FROM account_dim;

DROP TABLE holdings_table;
CREATE TABLE holdings_table(
	identifier VARCHAR(20),
	account_id INT,
    ticker VARCHAR(20),
	sector VARCHAR(30),
	avg_buy_price DOUBLE,
    current_price DOUBLE,
    quantity INT,
PRIMARY KEY(identifier)
); ######## closing the table details

############ Inserting 101 account (current portfolio data)
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-01', '101','UTHR', 'Healthcare','129.79','549.57','1787019');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-02', '101','PLTR','Technology','18.96','134.71','6985926');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-03', '101','AAPL','Technology','262.83','296.42','3075638');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-04', '101','KGC','Basic Materials','5.42','27.34','25546413');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-05', '101','MU','Technology','194.07','1087.99','2162986');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-06', '101','VRSN','Technology','119.24','272.96','2818151');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-07', '101','EXEL','Healthcare','21.5','53.00','13726993');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-08', '101','FNV','Basic Materials','119.24','222.35','2218918');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-09', '101','SNDK','Technology','100.72','2107.86','799568');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2025-10', '101','NVDA','Technology','160.11','212.45','2526948');


############ Inserting 102 account (new portfolio)
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-01', '102','MU','Technology','194.07','1087.99','2162986');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-02', '102','SNDK','Technology','100.72','2107.86','799568');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-03', '102','UTHR', 'Healthcare','129.79','549.57','1787019');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-04', '102','AAPL','Technology','262.83','296.42','3075638');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-05', '102','EXEL','Healthcare','21.5','53.00','13726993');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-06', '102','KGC','Basic Materials','5.42','27.34','25546413');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-07', '102','NVDA','Technology','160.11','212.45','2526948');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-08', '102','NEM','Basic Materials',null,'222.35','2218918');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-09', '102','FCX','Basic Materials',null,'70.13','3656269');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-10', '102','SLB','Energy',null,'53.71','4774048');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-11', '102','GE','Industrials',null,'342.26','749179');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-12', '102','INTC','Technology',null,'127.86','1840047');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-13', '102','JNJ','Healthcare',null,'235.66','998338');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-14', '102','BTU','Energy',null,'26.03','9038360');
INSERT INTO  holdings_table(identifier, account_id, ticker, sector, avg_buy_price, current_price, quantity)VALUES('2026-15', '102','MRK','Healthcare',null,'114.90','2047593');

SELECT *
FROM holdings_table;
