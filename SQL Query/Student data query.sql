show tables;
select * from fima_data_base;
select count(gender) from fima_data_base;
select student_id, student_name,gender,dob,place_of_birth into student_info from fima_data_base;

CREATE TABLE student_info -- Create new table student info from existing data
SELECT student_id, student_name,gender,dob,place_of_birth
FROM fima_data_base;

CREATE TABLE parent_info -- Create new table student info from existing data
SELECT student_id, Fathers_Name, Fathers_Occupation
FROM fima_data_base;

CREATE TABLE tuition_info -- Create new table student info from existing data
SELECT student_id, "Tuition Due", "Tuition Paid"
FROM fima_data_base;

CREATE TABLE class_info -- Create new table student info from existing data
SELECT student_id, gender, class
FROM fima_data_base;