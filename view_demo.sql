USE year_7_project;

-- Show fundamental students details 

CREATE VIEW student_details AS
    SELECT 
        CONCAT (first_name, " ", last_name) AS student_name, gender_at_birth, eal, lac, pp, send 
    FROM
       students_names s
    INNER JOIN students_gender g
    ON g.student_ID = s.student_ID
    INNER JOIN eal_status e
    ON e.student_ID = g.student_ID
    INNER JOIN pp_status pp
    ON pp.student_ID = e.student_ID
    INNER JOIN send_status send
    ON send.student_ID = e.student_ID
    INNER JOIN lac_status lac
    ON lac.student_ID = send.student_ID
    ORDER BY student_name ASC;
    
    DROP VIEW student_details;
    
    -- See student details 
    
    SELECT * FROM student_details;
    
    -- View to show students' names, behaviour points and if they deemed to be vulnerable 
    
    CREATE VIEW behaviour_profile AS
    SELECT CONCAT (first_name, " ", last_name) AS student_name,
    SUM(behaviour_points) AS total_behaviour_points, is_vulnerable(LAC,SEND) AS is_vulnerable, COUNT(incident_type) AS number_of_incidents
    FROM students_names s
    INNER JOIN behaviour_management bm
    ON s.student_ID = bm.student_ID
    INNER JOIN send_status send
    ON send.student_ID = bm.student_ID
    INNER JOIN lac_status lac
    ON lac.student_ID = send.student_ID
    GROUP BY bm.student_ID
    ORDER BY student_name ASC;
    
    DROP VIEW year_7_project.behaviour_profile;
    
    SELECT * FROM behaviour_profile;
    
    -- Query to check a specific student's total behaviour points and if they are vulnerable 
    
    SELECT *
    FROM behaviour_profile 
    WHERE student_name = 'Cerys New'; 
    
	-- Query to find out names of students who 'offended more than 4 or more times' 
    
    SELECT student_name FROM behaviour_profile 
    WHERE number_of_incidents >=4;