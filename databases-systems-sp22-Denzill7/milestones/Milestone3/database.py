# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors
from prettytable import PrettyTable

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

def get_response(msg):
  db_response = None
  command_parts = msg.split()
  bot_command = command_parts[0]
  if "/find_num_enrolled" in bot_command:
    course_id = command_parts[1]
    db_response = num_enrolled(course_id)
  elif "/researcher_papers" in bot_command:
    db_response = researcher_papers()
  elif "/find_3_transcripts" in bot_command:
    db_response = find_transcripts()
  elif "/find_num_transcripts" in bot_command:
    student_id = command_parts[1]
    db_response = find_num_transcripts(student_id)
  elif "/find_avg_grade" in bot_command:
    # todo
    # student_id = command_parts[1]
    # semester = command_parts[2]
    # db_response = find_avg_grade(student_id, semester)
    db_response = "To be implemented"
  elif "/find_departments" in bot_command:
    uni_id = command_parts[1]
    db_response = find_departments(uni_id)
  elif "/find_num_departments" in bot_command:
    db_response = find_num_departments()
  elif "/find_avg_grant" in bot_command:
    db_response = find_avg_grant()
  elif "/find_ac_students" in bot_command:
    db_response = find_ac_students()
  elif "/account_amount" in bot_command:
    db_response = account_amount()
  elif "/find_major_courses" in bot_command:
    db_response = find_major_courses()
  elif "/find_num_add_codes" in bot_command:
    db_response = find_num_add_codes()
  elif "/avg_num_students" in bot_command:
    # todo
    db_response = "To be implemented"
  elif "/find_repeat_students" in bot_command:
    db_response = "To be implemented"
  elif "/enroll_ac_student" in bot_command:
    db_response = "To be implemented"
  elif "/find_graders" in bot_command:
    db_response = "To be implemented"
  return db_response

def num_enrolled(course_id):
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Students']
      rows = []
      query = """SELECT COUNT(s_id) AS "Students" FROM Enrollment WHERE c_id = %s;"""

      variable = course_id
      cursor.execute(query, variable)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Students']
          row.append(column1)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of students enrolled in the course'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
          
  except Exception as error:
    print(error)
    result = -1
  return result

def find_avg_grade(student_id, semester):
  result = None

def find_departments(uni_id):
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['University Name', 'Department ID', 'Department Name']
      rows = []
      query = """SELECT University.name AS 'University Name', LinkDepartment.d_id AS 'Department ID', Department.name AS 'Department Name' FROM University
INNER JOIN LinkDepartment ON LinkDepartment.u_id = University.u_id
INNER JOIN Department ON Department.department_id = LinkDepartment.d_id
WHERE University.u_id = %s
GROUP BY LinkDepartment.d_id;
 """

      variable = uni_id
      cursor.execute(query, variable)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['University Name']
          column2 = data['Department ID']
          column3 = data['Department Name']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Department linked to university with ID ' + uni_id
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_num_departments():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Name', '# of Faculty Members']
      rows = []
      query = """SELECT Department.name AS 'Name', Department.num_instructors AS '# of Faculty Members'
FROM Department WHERE Department.num_instructors > 4;
 """
      
      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Name']
          column2 = data['# of Faculty Members']
          row.append(column1)
          row.append(column2)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Departments with >= 5 faculty members'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_avg_grant():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Average Grant Amount']
      rows = []
      query = """SELECT AVG(r_grant) AS 'Average Grant Amount'
FROM Researcher;
 """
      
      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Average Grant Amount']
          row.append(column1)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Average Grant of Engineering Department Researchers'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_major_courses():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Major Name', '# of Courses']
      rows = []
      query = """SELECT Major.name AS 'Major Name', COUNT(Course.title) AS '# of Courses' FROM Major
INNER JOIN Course ON Course.major_id = Major.major_id
GROUP BY Major.name;
 """
      
      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Major Name']
          column2 = data['# of Courses']
          row.append(column1)
          row.append(column2)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of Courses Taught For Each Major'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_transcripts():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      rows = []
      headers = ['Transcript ID', 'Name', 'GPA']
      query = """SELECT Transcript.transcript_id AS "Transcript ID", Transcript.student_name AS "Name", Transcript.gpa AS "GPA" FROM Transcript WHERE gpa > 2.9;
 """

      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Transcript ID']
          column2 = data['Name']
          column3 = data['GPA']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Transcripts with >= 3.0 GPA'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def account_amount():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      rows = []
      headers = ['Total Amount', 'Account Name', '# of Payments']
      query = """SELECT SUM(BillingInfo.amount) AS 'Total Amount', Account.name AS 'Account Name', COUNT(BillingInfo.amount) AS '# of Payments' FROM BillingInfo
INNER JOIN Account ON Account.account_id = BillingInfo.account
GROUP BY Account.name;
 """

      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Total Amount']
          column2 = data['Account Name']
          column3 = data['# of Payments']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of Payments For Each Account'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_ac_students():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      rows = []
      headers = ['Add Code ID', 'Student ID', 'Name', 'Expiration Date']
      query = """SELECT AddCode.code_id AS 'Add Code ID', AddCodeStudent.s_id AS 'Student ID', Student.name AS 'Name', AddCode.expiration_date AS 'Expiration Date' FROM AddCode 
INNER JOIN AddCodeStudent ON AddCodeStudent.c_id = AddCode.code_id
INNER JOIN Student ON Student.student_id = AddCodeStudent.s_id
WHERE AddCode.expiration_date < '2022-05-17';
 """

      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Add Code ID']
          column2 = data['Student ID']
          column3 = data['Name']
          column4 = data['Expiration Date']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          row.append(column4)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Expired Add Codes'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_num_transcripts(student_id):
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      rows = []
      headers = ['Name', '# of Transcripts Processed']
      query = """SELECT Student.name AS 'Name', COUNT(ProcessTranscript.t_id) AS '# of Transcripts Processed' FROM Student
INNER JOIN ProcessTranscript ON ProcessTranscript.s_id = Student.student_id
WHERE Student.student_id = %s
GROUP BY Student.name;
 """

      variable = student_id
      cursor.execute(query, variable)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Name']
          column2 = data['# of Transcripts Processed']
          row.append(column1)
          row.append(column2)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'NumTranscripts for Student with ID ' + student_id
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def format_data(headers, rows):
  table = PrettyTable()
  table.field_names = headers
  for header in headers:
    table.align[header] = "c"
  table.add_rows(rows)
  return table

def researcher_papers():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Name', '# of Papers Published']
      rows = []
      query = """SELECT Researcher.name AS 'Name', COUNT(Publish.r_id) AS "# of Papers Published" FROM Researcher
INNER JOIN Publish ON Publish.r_id = Researcher.r_id
GROUP BY Researcher.name;
 """

      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Name']
          column2 = data['# of Papers Published']
          row.append(column1)
          row.append(column2)
          # row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Name and # of Papers For Each Researcher'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result

def find_num_add_codes():
  result = None
  try:
    connection = connect()
    if connection:
      cursor = connection.cursor()
      headers = ['Section ID', '# of Add Codes']
      rows = []
      query = """SELECT Class.section_id AS 'Section ID', COUNT(AddCode.section) AS '# of Add Codes' FROM Class
INNER JOIN AddCode ON AddCode.section = Class.section_id
GROUP BY Class.section_id;
 """

      cursor.execute(query)
      # cursor.commit();
      connection.commit()
      results = cursor.fetchall()
      if results:
        for data in results:
          row = []
          column1 = data['Section ID']
          column2 = data['# of Add Codes']
          row.append(column1)
          row.append(column2)
          # row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of Add Codes Given Out For Each Class Section'
        connection.close()
        formatted = "`" + output.get_string() + "`"
        return formatted

  except Exception as error:
    print(error)
    result = -1
  return result
