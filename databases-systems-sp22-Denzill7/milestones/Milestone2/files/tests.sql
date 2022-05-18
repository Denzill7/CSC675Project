-- Script name: tests.sql
-- Author:      Denzill Loe
-- Purpose:     test the integrity of this database system
       
-- the database used to insert the data into.
USE CollegeDepartmentDB;
SET SQL_SAFE_UPDATES = 0;

-- 1. Testing University Table
DELETE FROM University WHERE name = 'SFSU';
UPDATE University SET u_id = 5 WHERE name = 'UCLA';

-- SELECT * FROM University;

-- 2. Testing Department Table
-- DELETE FROM Department WHERE department_id = 3;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`courseclass`, CONSTRAINT `course` FOREIGN KEY (`co_id`) REFERENCES `course` (`course_id`))
UPDATE Department SET name = 'test' WHERE department_id = 4;

-- SELECT * FROM Department;

-- 3. Testing LinkDepartment Table
DELETE FROM LinkDepartment WHERE u_id = 1;
UPDATE LinkDepartment SET d_id = 4 WHERE u_id = 2;

-- SELECT * FROM LinkDepartment;

-- 4. Testing Administrator Table
DELETE FROM Administrator WHERE admin_id = 1;
UPDATE Administrator SET name = 'test' WHERE salary = 100000;

-- 5. Testing Major Table
-- DELETE FROM Major WHERE department_id = 3;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`courseclass`, CONSTRAINT `course` FOREIGN KEY (`co_id`) REFERENCES `course` (`course_id`))
UPDATE Major SET name = 'test' WHERE (num_students > 250);

-- 6. Testing Course Table
-- DELETE FROM Course WHERE major_id = 3;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`courseclass`, CONSTRAINT `course` FOREIGN KEY (`co_id`) REFERENCES `course` (`course_id`))
UPDATE Course SET num_classes = 3 WHERE prerequisites = NULL;

-- 7. Testing Student Table
DELETE FROM Student WHERE student_id = 3456;
-- UPDATE Student SET name = 'test' WHERE dob = '1999-02-03';
-- Error Code: 1062. Duplicate entry 'test' for key 'student.name_UNIQUE'

-- 8. Testing ProcessTranscript Table   
DELETE FROM ProcessTranscript WHERE t_id = 3;
-- UPDATE ProcessTranscript SET s_id = 3333 WHERE  t_id = 2;   
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegedepartmentdb`.`processtranscript`, CONSTRAINT `s_id_pt` FOREIGN KEY (`s_id`) REFERENCES `student` (`student_id`) ON UPDATE CASCADE)

-- 9. Testing Transcript Table
DELETE FROM Transcript WHERE gpa = 2.8;
UPDATE Transcript set student_name = 'test' WHERE gpa > 3.0;

-- 10. Testing Enrollment Table
DELETE FROM Enrollment WHERE c_id = 123;
-- UPDATE Enrollment SET s_id = 5555 WHERE c_id = 111;
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegedepartmentdb`.`enrollment`, CONSTRAINT `s_id` FOREIGN KEY (`s_id`) REFERENCES `student` (`student_id`) ON UPDATE CASCADE)

-- 11. Testing Account Table
-- DELETE FROM Account WHERE account_id = 1;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`billinginfo`, CONSTRAINT `account_b` FOREIGN KEY (`account`) REFERENCES `account` (`account_id`))
-- UPDATE Account SET pm_id = 'test' WHERE name = 'Ilmi';
-- Error Code: 1366. Incorrect integer value: 'test' for column 'pm_id' at row 5

-- 12. Testing StudentAccount Table
DELETE FROM StudentAccount WHERE s_id = 5678;
UPDATE StudentAccount SET a_id = 6 WHERE s_id = 1357;

-- 13. Testing FacultyAccount Table
DELETE FROM FacultyAccount WHERE f_id = 3;
UPDATE FacultyAccount SET f_id = 7 WHERE a_id = 4;

-- 14. Testing Instructor Table
-- DELETE FROM Instructor WHERE name = 'Michael';
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`classestaught`, CONSTRAINT `i_id_ct` FOREIGN KEY (`i_id`) REFERENCES `instructor` (`instructor_id`))
UPDATE Instructor SET num_courses = 8 WHERE instructor_id = 2;

-- 15. Testing ClassesTaught Table
DELETE FROM ClassesTaught WHERE i_id = 1;
UPDATE ClassesTaught SET c_id = 8 WHERE i_id = 3;

-- 16. Testing InstructorCourse Table
DELETE FROM InstructorCourse WHERE i_id = 2;
-- UPDATE InstructorCourse SET i_id = 7 WHERE c_id = 2;
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegedepartmentdb`.`instructorcourse`, CONSTRAINT `instructor_ic` FOREIGN KEY (`i_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE ON UPDATE CASCADE)

-- 17. Testing Class Table
DELETE FROM Class WHERE section_id = 112;
UPDATE Class SET grade = 'A+' WHERE instructor_name = 'Jose';

-- 18. Testing CourseClass Table
DELETE FROM CourseClass WHERE cl_id = 111;
UPDATE CourseClass SET cl_id = 123 WHERE co_id = 4;

-- 19. Testing AddCode Table
-- DELETE FROM AddCode WHERE section = 123;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`addcodestudent`, CONSTRAINT `code` FOREIGN KEY (`c_id`) REFERENCES `addcode` (`code_id`) ON UPDATE CASCADE)
UPDATE AddCode SET expiration_date = '2024-01-01' WHERE code_id = 2;

-- 20. Testing AddCodeStudent Table
DELETE FROM AddCodeStudent WHERE c_id = 1;
-- UPDATE AddCodeStudent SET c_id = 3 WHERE s_id = 2468;  
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegedepartmentdb`.`addcodestudent`, CONSTRAINT `code` FOREIGN KEY (`c_id`) REFERENCES `addcode` (`code_id`) ON UPDATE CASCADE)

-- 21. Testing Researcher Table
-- DELETE FROM Researcher WHERE r_grant = 0;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`collegedepartmentdb`.`publish`, CONSTRAINT `researcher` FOREIGN KEY (`r_id`) REFERENCES `researcher` (`r_id`))
UPDATE Researcher SET r_grant = 50000 WHERE name = 'Gary';

-- 22. Testing Publish Table
DELETE FROM Publish WHERE p_id = 1;
-- UPDATE Publish SET r_id = 5 WHERE p_id = 2;
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegedepartmentdb`.`publish`, CONSTRAINT `researcher` FOREIGN KEY (`r_id`) REFERENCES `researcher` (`r_id`))

-- 23. Testing Paper Table
DELETE FROM Paper WHERE author = 'Katy';
UPDATE Paper SET conference = 'test' WHERE conference = NULL;

-- 24. Testing FacultyMember Table
DELETE FROM FacultyMember WHERE salary = 1000;
UPDATE FacultyMember SET name = 'test' WHERE faculty_id = 9;

-- 25. Testing Chancellor Table
DELETE FROM Chancellor WHERE name = 'Diana';
UPDATE Chancellor SET years_held_position = 69 WHERE chancellor_id = 3;

-- 26. Testing Grader Table
DELETE FROM Grader WHERE name = 'Jaden';
UPDATE Grader SET grader_id = 5 WHERE salary = 300;

-- 27. Testing PaymentMethod Table
DELETE FROM PaymentMethod WHERE pm_id = 1;
UPDATE PaymentMethod SET type = 'test' WHERE pm_id = 4;

-- 28. Testing CreditCard Table
DELETE FROM CreditCard WHERE pm_id = 3;
UPDATE CreditCard SET card_id = 5 WHERE name_on_card = 'Denzill Loe';

-- 29. Testing Check Table
DELETE FROM `Check` WHERE routing_number = 12345;
UPDATE `Check` SET check_id = 5 WHERE pm_id = 6;

-- 30. Testing BillingInfo Table
DELETE FROM BillingInfo WHERE billing_id = 1;
UPDATE BillingInfo SET account = 5 WHERE amount = 2500.00;