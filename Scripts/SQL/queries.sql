-- Find a list of order IDs where gloss_qty or poster_qty is greater than 4000
SELECT id FROM orders WHERE gloss_qty > 4000 OR poster_qty > 4000;

-- List of orders where standard_qty is zero and either gloss_qty or poster_qty is over 1000
SELECT * FROM orders WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

-- Company names that start with 'C' or 'W', primary contact contains 'ana'/'Ana', but not 'eana'
SELECT company_name FROM companies 
WHERE (company_name LIKE 'C%' OR company_name LIKE 'W%')
AND (primary_contact ILIKE '%ana%' AND primary_contact NOT ILIKE '%eana%');

-- Region, sales rep, and account name table sorted by account name
SELECT regions.region_name, sales_reps.rep_name, accounts.account_name 
FROM regions
JOIN sales_reps ON regions.region_id = sales_reps.region_id
JOIN accounts ON sales_reps.rep_id = accounts.rep_id
ORDER BY accounts.account_name;
