-- Script name: inserts.sql
-- Author:      Denzill Loe
-- Purpose:     insert sample data to test the integrity of this database system

USE CollegeDepartmentDB;
SET SQL_SAFE_UPDATES = 0;

-- University Table Inserts
INSERT INTO University (u_id, name, address, founding_year, num_students) VALUES 
(1, 'SFSU', '1600 Holloway Ave, San Francisco, CA 94132', 1899, 30000),
(2, 'UCSD', '9500 Gilman Dr, La Jolla, CA 92093', 1960, 50000),
(3, 'UCLA', '405 Hilgard Ave, Los Angeles, CA 90095', 1919, 60000);

-- LinkDepartment Table Inserts

INSERT INTO LinkDepartment (u_id, d_id) VALUES 
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(1, 4),
(2, 3),
(2, 4);

-- Department Table Inserts

INSERT INTO Department (department_id, name, num_instructors, budget) VALUES 
(1, 'Computer Science', 6, 60000),
(2, 'Criminal Justice Studies', 3 ,30000),
(3, 'Sociology', 4 , 40000),
(4, 'Engineering', 5, 50000);

-- Administrator Table Inserts

INSERT INTO Administrator (admin_id, name, salary, uni_id) VALUES 
(1, 'Craig', 100000, 1),
(2, 'Brian', 100000, 2),
(3, 'David', 100000, 3);

-- Major Table Inserts

INSERT INTO Major (major_id, num_students, name, department_id) VALUES 
(1, 300, 'Computer Science', 1),
(2, 250, 'Criminal Justice', 2),
(3, 100, 'Sociology', 3),
(4, 300, 'Engineering', 4);

-- Course Table Inserts

INSERT INTO Course (course_id, num_classes, prerequisites, title, units, major_id) VALUES 
(1, 2, NULL, 'CSC 210', 3, 1),
(2, 1, 'CSC 210', 'CSC 220', 3, 1),
(3, 1, 'CSC 220', 'CSC 230', 3, 1),
(4, 1, NULL, 'SOC 300', 3, 3),
(5, 1, NULL, 'ENG 210', 3, 4),
(6, 1, 'ENG 210', 'ENG 220', 3, 4),
(7, 1, NULL, 'CJS 110', 3, 2);

-- Student Table Inserts

INSERT INTO Student (student_id, name, dob, student_email) VALUES 
(1234, 'Denzill', '1999-02-03', 'denz@mail.com');

INSERT INTO Student (student_id, name, dob, student_email) VALUES 
(5678, 'Dylan', '1999-02-03', 'dyl@mail.com');

INSERT INTO Student (student_id, name, dob, student_email) VALUES 
(1357, 'Alexis', '1999-02-03', 'lexi@mail.com');

INSERT INTO Student (student_id, name, dob, student_email) VALUES 
(2468, 'Nicole', '1999-02-03', 'nikki@mail.com');

INSERT INTO Student (student_id, name, dob, student_email) VALUES 
(3456, 'Jaden', '2000-08-21', 'jaden@mail.com');

-- ProcessTranscript Table Inserts

INSERT INTO ProcessTranscript (t_id, s_id) VALUES 
(1, 1234),
(2, 5678),
(3, 2468),
(4, 1234),
(5, 1357);

-- Transcript Table Inserts

INSERT INTO Transcript (transcript_id, num_courses, student_name, gpa) VALUES 
(1, 5, 'Denzill Loe', 4.0),
(2, 7, 'Dylan Loe', 4.2),
(3, 10, 'Nicole Leon', 2.8),
(4, 11, 'Denzill Loe', 3.6),
(5, 6, 'Alexis Loe', 3.4);

-- Enrollment Table Inserts

INSERT INTO Enrollment (c_id, s_id) VALUES 
(123, 1234),
(123, 5678),
(111, 2468);

-- Account Table Inserts

INSERT INTO Account (account_id, email, name, pm_id) VALUES 
(1, 'denz@mail.com', 'Denzill', NULL),
(2, 'dyl@mail.com', 'Dylan', NULL),
(3, 'lexi@mail.com', 'Alexis', NULL),
(4, 'jose@mail.com', 'Jose', NULL),
(5, 'ilmi@mail.com', 'Ilmi', NULL),
(6, 'mike@mail.com', 'Mike', NULL);

-- StudentAccount Table Inserts

INSERT INTO StudentAccount (s_id, a_id) VALUES 
(1234, 1),
(5678, 2),
(1357, 3);

-- FacultyAccount Table Inserts

INSERT INTO FacultyAccount (f_id, a_id) VALUES 
(1, 4),
(2, 5),
(3, 6);

-- Instructor Table Inserts

INSERT INTO Instructor (instructor_id, name, num_courses, years_teaching, email) VALUES 
(1, 'Jose', 2, 4, 'jose@mail.com'),
(2, 'Ilmi', 2, 15, 'ilmi@mail.com'),
(3, 'Michael', 1, 5, 'mike@mail.com');

-- ClassesTaught Table Inserts

INSERT INTO ClassesTaught (c_id, i_id) VALUES 
(123, 1),
(124, 1),
(111, 2),
(112, 2),
(131, 3);

-- InstructorCourse Table Inserts

INSERT INTO InstructorCourse (i_id, c_id) VALUES 
(2, 1),
(1, 2),
(1, 3),
(3, 4);

-- Class Table Inserts

INSERT INTO Class (section_id, semester, num_add_codes, instructor_name, grade) VALUES 
(123, 'Fall 2021-22', 1, 'Jose', NULL),
(124, 'Fall 2021-22', 1, 'Jose', NULL),
(111, 'Fall 2021-22', 0, 'Ilmi', NULL),
(112, 'Fall 2021-22', 1, 'Ilmi', NULL),
(131, 'Fall 2021-22', 0, 'Michael', NULL);

-- CourseClass Table Inserts
INSERT INTO CourseClass (co_id, cl_id) VALUES 
(1, 123), (1, 124), (2, 111), (3, 112), (4, 131);

-- AddCode Table Inserts

INSERT INTO AddCode (code_id, section, expiration_date) VALUES 
(1, 123, '2022-03-19'),
(2, 124, '2022-03-12'),
(3, 112, '2022-02-24');

-- AddCodeStudent Table Inserts

INSERT INTO AddCodeStudent (c_id, s_id) VALUES 
(1, 1234),
(2, 5678),
(2, 2468);

-- Researcher Table Inserts

INSERT INTO Researcher (r_id, name, field_of_research, r_grant) VALUES 
(1, 'Sam', 'AI', 10000),
(2, 'Katy', 'Socializing', 0),
(3, 'Gary', 'Mechanics', 20000),
(4, 'Dylan', 'Engineering', 25000),
(5, 'Alexis', 'Psychology', 5000);

-- Publish Table Inserts

INSERT INTO Publish (p_id, r_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 1);

-- Paper Table Inserts

INSERT INTO Paper (paper_id, title, conference, publish_date, author) VALUES 
(1, 'Going into the code', NULL, '2022-03-20', 'Sam'),
(2, 'How to talk to someone', 'Scared People Conference', '2022-02-26', 'Katy'),
(3, 'How to build things fast', NULL, '2022-03-04', 'Gary'),
(4, 'Coding with style', NULL, '2022-04-25', 'Sam'),
(5, 'Programming methodology', NULL, '2022-04-29', 'Sam');

-- FacultyMember Table Inserts

INSERT INTO FacultyMember(faculty_id, name, salary) VALUES 
(1, 'Jose', 9999.99),
(2, 'Ilmi', 9999.99),
(3, 'Michael', 5000.00),
(4, 'Sam', 1000.00),
(5, 'Katy', 1000.00),
(6, 'Gary', 1000.00),
(7, 'Diana', 6000.00),
(8, 'George', 7000.00),
(9, 'Steve', 8000.00);

-- Chancellor Table Inserts

INSERT INTO Chancellor (chancellor_id, name, years_held_position) VALUES 
(1, 'Diana', 1),
(2, 'George', 2),
(3, 'Steve', 3);

-- Grader Table Inserts

INSERT INTO Grader (grader_id, name, instructor, salary) VALUES 
(1, 'Denzill', 'Jose', 300),
(2, 'Nicole', 'Ilmi', 400),
(3, 'Jaden', 'Michael', 400);

-- PaymentMethod Table Inserts

INSERT INTO PaymentMethod (pm_id, type) VALUES 
(1, 'credit_card_type'),
(2, 'check_type'),
(3, 'credit_card_type'),
(4, 'check_type'),
(5, 'credit_card_type'),
(6, 'check_type');

-- CreditCard Table Inserts

INSERT INTO CreditCard (card_id, expiration_date, name_on_card, card_number, pm_id) VALUES 
(1, '2025-08-15', 'Denzill Loe', 1234, 1),
(2, '2023-04-04', 'Dylan Loe', 2345, 3),
(3, '2024-05-05', 'Alexis Loe', 3456, 5);

-- Check Table Inserts

INSERT INTO `Check` (check_id, pm_id, routing_number) VALUES 
(1, 2, 12345),
(2, 4, 23456),
(3, 6, 34567);

-- BillingInfo Table Inserts

INSERT INTO BillingInfo (billing_id, account, payment_type, amount) VALUES 
(1, 1, 1, 2000.00),
(2, 2, 3, 2000.00),
(3, 3, 6, 2500.00),
(4, 1, 1, 3000.00),
(5, 2, 3, 1500.00);

