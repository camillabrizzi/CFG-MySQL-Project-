USE year_7_project;

-- create trigger to create a message to the parents in a separate table for each new behaviour incident in behaviour_management table 

DELIMITER $$

CREATE TRIGGER after_incident_insert
AFTER INSERT
ON behaviour_management FOR EACH ROW
BEGIN
        INSERT IGNORE INTO behaviour_message(incident_ID, student_ID, message, date_time)
        SELECT bm.incident_ID, bm.student_ID, 
        CONCAT('Hi ', h.parental_contact,', ', s.first_name, ' has been given ', bm.behaviour_points, 
        ' behaviour points. We appreciate your support with ', student_pronoun(gender_at_birth), ' behaviour in school.'),
        NOW()
FROM home_contact h
INNER JOIN 
behaviour_management bm
ON h.student_ID = bm.student_ID
INNER JOIN 
students_names s
ON s.student_ID = bm.student_ID 
INNER JOIN students_gender g
ON g.student_ID = s.student_ID;

END$$

DELIMITER ;

DROP TRIGGER after_incident_insert;

-- Change settings to resolve error message about 'default' values

SET SQL_MODE = '';
SHOW GLOBAL VARIABLES LIKE 'FOREIGN_KEY_CHECKS';
SET FOREIGN_KEY_CHECKS=0;

-- Test trigger 

CREATE UNIQUE INDEX unique_incident_ID ON behaviour_management (incident_ID);
CREATE UNIQUE INDEX unique_messages_ID ON behaviour_message (incident_ID, message_ID);

USE year_7_project;

INSERT INTO behaviour_management (incident_date, student_ID, behaviour_points, incident_type)
VALUES (CURDATE(), 12, 1, 'Uniform');

INSERT IGNORE INTO behaviour_management (incident_date, student_ID, behaviour_points, incident_type)
VALUES (CURDATE(), 12, 2, 'Behaviour');

INSERT IGNORE INTO behaviour_management (incident_date, student_ID, behaviour_points, incident_type)
VALUES (CURDATE(), 3, 1, 'Low level disruption');

SELECT * FROM year_7_project.behaviour_management;

SELECT * FROM year_7_project.behaviour_message;

ALTER TABLE behaviour_message AUTO_INCREMENT = 1;



