CREATE TABLE statistics (
	EventDate date,
	EventDateTime timestamp,
	abonent bigint,
	send_name_id integer,
	distribution_id integer,
	partner_id bigint,
	agregator_id bigint, -- = partner_id % 15
	operator_id integer, 
	region_id integer,
	message_id varchar(64),
	sms_send_count smallint,
	sms_delivered_count smallint,
	primary key(message_id)
);
