USE year_7_project;

-- AIM = able, interested and motivated - old 'gifted and talented'
-- procedure that returns students' names whose CAT score is above 120 or the sum of SAS reading and maths is equal to or above 240 

DELIMITER $$

CREATE PROCEDURE get_AIM_students()
BEGIN
SELECT CONCAT (first_name, " ", last_name) AS AIM_candidate, CAT_score, sas_maths, sas_reading
FROM students_names s
INNER JOIN previous_school_data p
ON s.student_ID = p.student_ID
INNER JOIN sas_data sas
ON p.student_ID = sas.student_ID
WHERE CAT_score > 120 OR (sas_maths + sas_reading) >=240
ORDER BY CAT_score DESC;

END$$
DELIMITER;

CALL get_AIM_students();

-- Function to determine student's reading level based on SAS reading score

DELIMITER $$

CREATE FUNCTION reading_level (sas_reading INT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE reading_level VARCHAR(20);

    IF sas_reading >= 120 THEN
		SET reading_level = 'GOLD';
    ELSEIF (sas_reading < 120 AND 
			sas_reading >= 100) THEN
        SET reading_level = 'SILVER';
    ELSEIF sas_reading < 100 THEN
        SET reading_level = 'BRONZE';
    END IF;
	RETURN (reading_level);
END$$
DELIMITER ;

SHOW FUNCTION STATUS 
WHERE db = 'Year7Class';

-- Function to declare student in foster care (LAC) and /or having an EHCP (funding for diagnosed special educational need) as vulnerable

DELIMITER $$

CREATE FUNCTION is_vulnerable (LAC VARCHAR (1), SEND VARCHAR(1)) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE is_vulnerable VARCHAR(20);
    IF LAC = 'Y' 
    OR SEND = 'Y' THEN
        SET is_vulnerable = 'Y';
	ELSE 
    SET is_vulnerable = 'N';
    END IF;
    RETURN (is_vulnerable);
END$$
DELIMITER ;

-- Query to find names of vulnerable students 

SELECT CONCAT (first_name, " ", last_name) AS vulnerable_students
FROM students_names s
INNER JOIN lac_status lac
ON s.student_ID = lac.student_ID
INNER JOIN send_status send
ON send.student_ID = lac.student_ID
WHERE is_vulnerable(LAC, SEND) = 'Y'
ORDER BY vulnerable_students ASC;


-- Show student names and reading level based on SAS reading score 

SELECT CONCAT (first_name, " ", last_name) AS student_name, reading_level(sas_reading)
FROM students_names s
INNER JOIN sas_data sas
ON s.student_ID = sas.student_ID
ORDER BY sas_reading DESC;

-- EXTRA: show EAL student names and reading level based on SAS reading score 

SELECT CONCAT (first_name, " ", last_name) AS student_name, reading_level(sas_reading)
FROM students_names s
INNER JOIN sas_data sas
ON s.student_ID = sas.student_ID
WHERE s.student_ID IN (SELECT student_ID 
FROM eal_status
WHERE eal = 'Y')
ORDER BY sas_reading DESC;

-- Show number of pupil premium per reading level 
 
SELECT COUNT(sas.student_ID) AS total_pp_students, reading_level(sas_reading)
FROM sas_data sas
INNER JOIN pp_status pp
ON sas.student_ID = pp.student_ID
WHERE pp = 'Y'
GROUP BY reading_level(sas_reading);

-- Example query with 'group by and having' to find out total number of students with SEND 

SELECT COUNT(student_ID) AS total_students, 
    send
FROM
send_status
GROUP BY 
   SEND
HAVING 
   SEND <> 'N';
   
-- Example query with subquery to find out carer's contact for looked-after children

SELECT CONCAT (first_name, " ", last_name) AS lac_student_name, parental_contact, home_email, home_phone
FROM home_contact h
INNER JOIN students_names s
ON s.student_ID = h.student_ID
WHERE
    h.student_ID IN (SELECT 
            student_ID
        FROM
            lac_status
        WHERE
            lac = 'Y');
            
            
-- Stored function for pronoun to use in message home after behaviour incident

DELIMITER $$

CREATE FUNCTION student_pronoun (gender_at_birth VARCHAR (1)) 
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE pronoun VARCHAR(10);

    IF gender_at_birth = 'M' THEN
		SET pronoun = 'his';
    ELSEIF gender_at_birth = 'F' THEN
        SET pronoun = 'her';
    ELSE 
        SET pronoun = 'their';
    END IF;
	RETURN (pronoun);
END$$
DELIMITER ;




