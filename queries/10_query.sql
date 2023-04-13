select
	category_name,
	concat(first_name, ' ', last_name) employee_full_name,
	title employee_title,
	to_char(sum(
		quantity * od.unit_price * (1-discount)),'999999.99')
		as total_sale_amount_excluding_discount,
	count(distinct order_id) total_number_unique_orders,
	count(order_id) total_number_orders,
	to_char(avg(
		quantity * od.unit_price * (1-discount) ) ,'999999.99')
		as average_product_amount_excluding_discount,
	to_char(sum(
		quantity * od.unit_price * (1-discount) ) / count(distinct order_id),'999999.99')
		as average_order_amount_exclusing_discount,
	to_char(sum(quantity * od.unit_price * discount),'999999.99') as total_discount_amount,
	to_char(sum(
		quantity * od.unit_price),'999999.99')
		as total_sale_amount_including_discount,
	to_char(
		sum(quantity * od.unit_price * (discount)) / 
		sum(quantity * od.unit_price) * 100,'99.99')
		as total_discount_percentage
from
	northwind.orders 
	join northwind.employees using (employee_id)
	join northwind.order_details od using (order_id)
	join northwind.products using (product_id)
	join northwind.categories using (category_id)
group by
	category_name, employee_full_name, employee_title
order by
	total_sale_amount_including_discount desc
;
