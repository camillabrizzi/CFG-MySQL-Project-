SET GLOBAL event_scheduler = ON;

CREATE EVENT delete_message_records
ON SCHEDULE EVERY 1 DAY
ON COMPLETION PRESERVE
DO 
DELETE FROM Year7Class.behaviour_message WHERE start_time < DATE_SUB(NOW(), 
INTERVAL 1 DAY);

DROP EVENT delete_message_records;