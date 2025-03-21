SELECT
	ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) 'Customer',
	cus.city,
	cus.state,	
	ord.order_date,
	SUM(ite.quantity) 'Units',
	SUM(ite.quantity * ite.list_price) 'Revenue',
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(stf.first_name, ' ', stf.last_name) 'Sales Rep'

FROM sales.customers cus
JOIN sales.orders ord
	ON cus.customer_id = ord.customer_id
JOIN sales.order_items ite
	ON ord.order_id = ite.order_id
JOIN production.products pro
	ON ite.product_id = pro.product_id
JOIN production.categories cat
	ON pro.category_id = cat.category_id
JOIN sales.stores sto
	ON ord.store_id = sto.store_id
JOIN sales.staffs stf
	ON	ord.staff_id = stf.staff_id
GROUP BY
	ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(stf.first_name, ' ', stf.last_name)