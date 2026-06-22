USE medievaltrust;

SELECT *
FROM account_dim;

SELECT *
FROM customer_details;

SELECT *
FROM holdings_table;

#CREATE TABLE security_masterlist(
#	ticker VARCHAR(20),
#	security_name VARCHAR(100),
#    sec_type VARCHAR(20),
#	 major_asset_class VARCHAR(100),
#    minor_asset_class VARCHAR(100),
#    industry VARCHAR(100),
#PRIMARY KEY(ticker)
#); ######## closing the table details

#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('UTHR','United Therapeutics Corporation','common_share','equity','Healthcare','Drug Manufacturers - Specialty & Generic');
#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('PLTR','Palantir Technologies Inc','common_share','equity','Technology','Software - Infrastructure');
#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('APPL','Apple Inc','common_share','equity','Technology','Consumer Electronics');
#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('KGC','Kinross Gold Corp','common_share','equity','Basic Materials','Gold');
#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('MU','Micron Technologies Inc','common_share','equity','Technology','Semiconductors');
#INSERT INTO  security_masterlist(ticker, security_name, sec_type, major_asset_class, minor_asset_class, industry)
#			VALUES('VRSN','Verisign Inc','common_share','equity','Technology','Software - Infrastructure');


SELECT *
FROM rt_current;

SELECT y.ticker, y.name, y.sector, y.industry, 
    AVG(y.ror_daily)                                    AS average_ror,
    STD(y.ror_daily)                                    AS risk,
    AVG(y.ror_daily) / STD(y.ror_daily)                 AS sharpe_simplified,
    AVG(y.ror_daily) / STD(y.ror_daily) * 15.8744                AS annualized_sharpe_simplified,
    (AVG(y.ror_daily) - 0.000152) / STD(y.ror_daily)   AS sharpe_adjusted,
    (AVG(y.ror_daily) - 0.000152) / STD(y.ror_daily) * 15.8744   AS annualized_sharpe_adjusted
FROM (
    SELECT z.*, (z.p1 - z.p0) / z.p0 AS ror_daily
    FROM (
        SELECT ticker, name, sector, industry, date, close_value AS p1,
               LAG(close_value, 1) OVER (PARTITION BY ticker
										 ORDER BY date) AS p0
        FROM medievaltrust.rt_current
        WHERE date > '2025-06-14' AND
			  date < '2026-06-15' AND
			  ticker IN ('UTHR', 'PLTR','AAPL','KGC','MU','VRSN','EXEL','FNV', 'SNDK','NVDA')
    ) z
) y
GROUP BY y.ticker;

SELECT y.ticker, y.name, y.sector, y.industry, 
    AVG(y.ror_daily)                                    AS expect_ror,
    STD(y.ror_daily)                                    AS risk,
    AVG(y.ror_daily) / STD(y.ror_daily)                 AS sharpe_simplified,
    AVG(y.ror_daily) / STD(y.ror_daily) * 15.8744                AS annualized_sharpe_simplified,
    (AVG(y.ror_daily) - 0.000152) / STD(y.ror_daily)   AS sharpe_adjusted,
    (AVG(y.ror_daily) - 0.000152) / STD(y.ror_daily) * 15.8744   AS annualized_sharpe_adjusted
FROM (
    SELECT z.*, (z.p1 - z.p0) / z.p0 AS ror_daily
    FROM (
        SELECT ticker, name, sector, industry, date, close_value AS p1,
               LAG(close_value, 1) OVER (PARTITION BY ticker
										 ORDER BY date) AS p0
        FROM medievaltrust.rt_possible10
        WHERE date > '2025-06-14' AND
			  date < '2026-06-15' AND
			  ticker IN ('PLTR', 'AAPL', 'MU', 'NVDA', 'VRSN', 'INTC', 'WDC', 'AVGO', 'MSFT', 
           'NFLX', 'UTHR', 'UNH', 'EXEL', 'NVS', 'ABBV', 'LLY', 'JNJ', 'MRK', 
           'AMGN', 'PFE', 'XOM', 'CVX', 'COP', 'EOG', 'OXY', 'SHEL', 'BP', 'NEE', 
           'BTU', 'SLB', 'SCHW', 'JPM', 'BAC', 'GS', 'MS', 'BRK.B', 'C', 'MA', 
           'V', 'BLK', 'CVNA', 'COST', 'AMZN', 'NKE', 'HD', 'WMT', 'PG', 'KO', 
           'PEP', 'SBUX', 'KGC', 'FNV', 'FCX', 'CAT', 'DE', 'HON', 'GE', 'MMM', 'NEM')
    ) z
) y
GROUP BY y.ticker;

####################################### PORTFOLIO WEIGHT CALCULATION
SELECT account_id, ticker, sector, avg_buy_price, current_price, quantity,
	SUM(current_price * quantity) AS under_management_current,
    SUM(current_price * quantity) / SUM(SUM(current_price * quantity)) OVER () AS weight
FROM     medievaltrust.holdings_table
WHERE    account_id IN ('101')
GROUP BY ticker, account_id;

####################################### NEW PORTFOLIO WEIGHT CALCULATION
SELECT account_id, ticker, sector, avg_buy_price, current_price, quantity,
	SUM(current_price * quantity) AS under_management_current,
    SUM(current_price * quantity) / SUM(SUM(current_price * quantity)) OVER () AS weight
FROM     medievaltrust.holdings_table
WHERE    account_id IN ('102')
GROUP BY ticker, account_id;

