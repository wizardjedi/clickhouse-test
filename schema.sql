-- Fields

EventDate Date,
EventDateTime DateTime,
abonent UInt32,
send_name_id UInt16,
distribution_id UInt32,
partner_id UInt32,
agregator_id UInt32, -- = partner_id % 15
operator_id UInt16, 
region_id UInt16,
message_id String,
sms_send_count UInt8,
sms_delivered_count UInt8


-- PostgreSQL
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

-- Click House
CREATE TABLE statistics (
	EventDate Date,
	EventDateTime DateTime,
	abonent UInt32,
	send_name_id UInt16,
	distribution_id UInt32,
	partner_id UInt32,
	agregator_id UInt32, -- = partner_id % 15
	operator_id UInt16, 
	region_id UInt16,
	message_id String,
	sms_send_count UInt8,
	sms_delivered_count UInt8
) ENGINE = MergeTree (EventDate, (EventDateTime,partner_id), 8192);

