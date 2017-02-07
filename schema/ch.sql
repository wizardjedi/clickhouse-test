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
