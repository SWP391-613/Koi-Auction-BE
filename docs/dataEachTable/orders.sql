insert into koi_company.orders (id, active, address, email, first_name, last_name, note, order_date, payment_method, phone_number, shipping_address, shipping_date, shipping_method, status, total_money, tracking_number, user_id)
values  (1, false, 'Quang Binh, Viet Nam', 'son@gmail.com', 'Son', 'Cong Duong', '12345', '2024-10-18', 'Cash', '0562278326', 'Á', null, 'Standard', 'CANCELLED', 500000, null, 2),
        (2, true, 'Da Nang, Viet Nam', 'duongnmse181515@fpt.edu.vn', 'Duong', 'Duong', null, '2024-10-18', 'Cash', '', 'Da Nang, Viet Nam', '2024-10-30', 'Standard', 'COMPLETED', 500000, null, 19),
        (3, false, 'Da Nang, Viet Nam', 'duongnmse181515@fpt.edu.vn', 'Duong', 'Duong', '123123', '2024-10-18', 'Payment', '031241233', 'Da Nang, Viet Nam', null, 'Standard', 'CANCELLED', 500000, null, 19),
        (4, false, 'Quang Binh, Viet Nam', 'son@gmail.com', 'Son', 'Cong Duong', null, '2024-10-18', 'Cash', '', 'Quang Binh, Viet Nam', '2024-10-18', 'Standard', 'CANCELLED', 500000, null, 2),
        (5, true, 'Quang Binh, Viet Nam', 'son@gmail.com', 'Son', 'Cong Duong', 'anh bay den roiiiiiii', '2024-10-25', 'Payment', '0348018758', 'Quang Binh, Viet Nam', '2024-10-26', 'Standard', 'COMPLETED', 10000, null, 2);