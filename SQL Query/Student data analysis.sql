select max from student_info;
show tables;

select * from student_info;
select count(student_id) from student_info; -- Total number of students in school

select count(student_id) as num_of_male_students, round((count(student_id) / 10000)*100) as percent_boys from student_info -- Percentage of male students
where gender = "Male"; -- Number of boys in school

select count(student_id) as num_female_students, round((count(student_id) / 10000)*100) as percent_girls from student_info -- Percentage of female students
where gender = "Female"; -- Number of girls in school

select dob, day(dob) from student_info;  -- View current format of dob

Select STR_TO_DATE(dob, '%m/%d/%Y') from student_info; -- Change the current dob format to the preferred sql format

update student_info -- Update the dob table with the new data
set dob = STR_TO_DATE(dob, '%m/%d/%Y');

select dob from student_info; -- Checking if the update was effective

select student_id, student_name, dob, (year(now()) - year(dob)) as age from student_info; -- The ages of all students in our db

select distinct (year(now()) - year(dob)) as age from student_info; -- Distinct ages of our students

select distinct (year(now()) - year(dob)) as age, count(student_id) -- Number of students for each age
from student_info group by (year(now()) - year(dob)) order by (year(now()) - year(dob));

select distinct (year(now()) - year(dob)) as age, count(student_id) as num_of_students, -- Number of students for each age, percentage
round((count(student_id)/10000)*100) as percentage_of_students
from student_info group by (year(now()) - year(dob)) order by (year(now()) - year(dob));

select distinct place_of_birth from student_info; -- Disitinct place of birth for all students
select count( distinct place_of_birth) from student_info; -- Number of distinct place of birth for students

select distinct place_of_birth, count(student_id) as number_of_students from student_info -- Number of students per place of birth
group by place_of_birth order by count(student_id);

select distinct place_of_birth, count(student_id) as number_of_students,-- Number of stiudents per place of birth and their percentages
round(((count(student_id) / 10000)*100),2)  from student_info
group by place_of_birth order by count(student_id);

-- Cleaning the student_id column

select * from student_info;

select student_name, count(student_id) -- Checking for duplicates among the names of the students
from student_info group by student_name order by student_name;


SELECT *, (year(now()) - year(dob)) as age -- Query has an error ecause of one missing bracket
FROM student_info
WHERE CAST((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1)) AS UNSIGNED) != 14;
-- cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) is the correct syntax to use


SELECT SUBSTRING_INDEX('ID-13-9308-14-2024', '-', 3);  -- Returns 'ID-13-9308'  Testing the substring fnx
SELECT SUBSTRING_INDEX('ID-13-9308-14-2024', '-', -2);  -- Returns '2024'     Testing the substring fnx

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('ID-13-9308-14-2024', '-', 4), '-', -1) AS extracted_value;  -- Testing the substring fnx

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1) AS extracted_value, -- Testing the substring fnx. It outputs a string
(year(now()) - year(dob)) as age
from student_info
where SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1) != '14';

select cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned), -- Testing the cast function
(cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) + 2)
from student_info;

select cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) as id_age, -- Checks for student id entries where age is different
(year(now()) - year(dob)) as age
from student_info
where cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) != (year(now()) - year(dob));

select student_id, 
cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) as id_age, -- Checks for student id entries where age is different
(year(now()) - year(dob)) as age
from student_info
where cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) != (year(now()) - year(dob));



select student_id, (year(now()) - year(dob)),
CONCAT('ID-', (year(now()) - year(dob)), SUBSTRING(student_id, LOCATE('-', student_id, 1), LENGTH(student_id) - LOCATE('-', student_id, 1) + 1))
from student_info;
-- WHERE CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(id_column, '-', 3), '-', -1) AS UNSIGNED) <> age_column;

select student_id, (year(now()) - year(dob)),
CONCAT('ID-', SUBSTRING(student_id, LOCATE('-', student_id, 1), LENGTH(student_id) - LOCATE('-', student_id, 1) + 1))
from student_info;
-- WHERE CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(id_column, '-', 3), '-', -1) AS UNSIGNED) <> age_column;


select student_id, CONCAT(
    SUBSTRING_INDEX(student_id, '-', 3),  -- Get the part before '14'
    '-5-',                               -- Replace '14' with '5'
    SUBSTRING_INDEX(student_id, '-', -1)  -- Get the part after '14'
) as new_id
from student_info;


-- select CONCAT(
-- 'ID-', (year(now()) - year(dob)), SUBSTRING(student_id, 
-- LOCATE('-', student_id, 1), 
-- LENGTH(student_id) - LOCATE('-', student_id, 1) + 1)
-- )
-- from student_info



-- This code update the student id table to the correct format. I made
-- update student_info
-- set student_id = CONCAT(
--     SUBSTRING_INDEX(student_id, '-', 3), '-', -- Get the part before '14'
--     (year(now()) - year(dob)), '-',                             -- Replace '14' with '5'
--     SUBSTRING_INDEX(student_id, '-', -1)  -- Get the part after '14'
-- )
-- where cast((SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 4), '-', -1)) as unsigned) != (year(now()) - year(dob));

select student_id from student_info;

SELECT SUBSTRING('ID-13-9308152024', 11, 2) AS extracted_value;
select * from fima_data_base;

SELECT student_id
FROM student_info
WHERE student_id REGEXP '^ID-[0-9]{2}-[0-9]{8}$';

SELECT student_id
FROM student_info
WHERE student_id REGEXP '^ID-[0-9]{2}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{7}$';



-- UPDATE your_table
-- SET id_column = CONCAT(
--     SUBSTRING(id_column, 1, LENGTH(id_column) - 6),  -- Keep everything before '15-2024'
--     'NEW_VALUE',                                      -- Replace '15' with your new value
--     SUBSTRING(id_column, LENGTH(id_column) - 4)      -- Keep the '2024' part
-- )
-- WHERE id_column = 'ID-13-9308152024';  -- Adjust condition as necessary


-- SUBSTRING(id_column, 1, LENGTH(id_column) - 6): This extracts everything before the last 15-2024. 
-- The -6 accounts for the length of 15-2024 (which is 6 characters).
-- 'NEW_VALUE': Replace this with the actual value you want to insert instead of 15.
-- SUBSTRING(id_column, LENGTH(id_column) - 4): This extracts the last four characters of the ID (which is 2024).

select student_id, concat( -- Test the update query to evaluate it's effectiveness.
	substring(student_id, 1, length(student_id) - 6),
    '-',(year(now()) - year(dob)),'-',
    substring(student_id, length(student_id) - 3)
    )
    from student_info
    WHERE student_id REGEXP '^ID-[0-9]{2}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{7}$';

update student_info -- Update student id column to fix the issues
set student_id = concat(
	substring(student_id, 1, length(student_id) - 6),
    '-',(year(now()) - year(dob)),'-',
    substring(student_id, length(student_id) - 3)
    )
    WHERE student_id REGEXP '^ID-[0-9]{2}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{2}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{2}-[0-9]{7}$';

select student_id, substring(student_id, 7, length(student_id) - 9)
from student_info;
SELECT student_id from student_info
where student_id = 'ID-7-8164142024';

select min(class), max(class)
from class_info;

select student_id
from student_info
where student_id REGEXP '^ID-[0-9]{1}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{7}$';

select student_id, concat( -- Test the update query to evaluate it's effectiveness.
	substring(student_id, 1, length(student_id) - 6),
    '-',(year(now()) - year(dob)),'-',
    substring(student_id, length(student_id) - 3)
    ) as new_id, dob
    from student_info
    where student_id REGEXP '^ID-[0-9]{1}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{7}$';

update student_info
set student_id = concat( -- Update student_id to the correct format
	substring(student_id, 1, length(student_id) - 6),
    '-',(year(now()) - year(dob)),'-',
    substring(student_id, length(student_id) - 3)
    )
    where student_id REGEXP '^ID-[0-9]{1}-[0-9]{8}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{9}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{10}$' or student_id REGEXP '^ID-[0-9]{1}-[0-9]{11}$'
or student_id REGEXP '^ID-[0-9]{1}-[0-9]{7}$';

select substring(student_id, 1, length(student_id) - 0) as reg_num,
student_id, dob, student_name
from student_info
order by substring(student_id, 6, length(student_id) - 12);

SELECT  -- Select registration numb from student id
    cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) AS reg_num, student_id, dob,
    student_name
FROM 
    student_info
WHERE 
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) AS UNSIGNED) BETWEEN 0 AND 10000
    order by cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned);
    
select substring_index(student_id, '-',3), substring_index(student_id, '-', -1),student_id -- Testing the substring_index fnx
from student_info;

-- Explaining the query above.

-- SUBSTRING_INDEX(id, '-', 3):

-- This function takes three arguments: the string id, the delimiter '-', and the count 3.
-- It returns the substring of id up to the third occurrence of the delimiter '-'.
-- For your example ('ID-11-1000-11-2024'), this would return 'ID-11-1000'.
-- SUBSTRING_INDEX(..., '-', -1):

-- The outer SUBSTRING_INDEX takes the result from the first part.
-- By passing '-' as the delimiter and -1 as the count, it retrieves the part after the last '-'.
-- So, from 'ID-11-1000', this will extract '1000'.
-- AS middle_value:

-- This gives a name (alias) to the extracted value, making it easier to reference in the result set.
-- WHERE CAST(... AS UNSIGNED) BETWEEN 1 AND 10000:

-- This filters the results based on the middle value extracted.
-- CAST(... AS UNSIGNED) converts the extracted string ('1000' in this case) into an integer.
-- The BETWEEN 1 AND 10000 clause checks if this integer falls within the specified range.


SELECT  -- Select registration numb from student id
    cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) AS reg_num, 
    lag(cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned)) 
    over (order by cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) ) as new_reg_num, student_id, dob,
    student_name
FROM 
    student_info;
    
select substring_index(student_id, '-',3), substring_index(student_id, '-', -1),student_id -- Testing the substring_index fnx
from student_info;


-- Change student reg num to start from 1 and not 0
select cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) AS reg_num,
(cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) + 1) as new_reg_num,
student_id, dob, student_name
from student_info
order by cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned);


select 
cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) AS reg_num,
(cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) + 1) as new_reg_num,

concat(substring_index(student_id, '-', 2), '-',
(cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned) + 1), '-', -- assigned new value to student id eliminating 0 from reg_num
substring_index(student_id,'-', -2)) as new_id,
student_id, dob, student_name
from student_info
order by cast(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) as unsigned);

update student_info

set student_id = concat(substring_index(student_id, '-', 2), '-',
(cast(substring_index(substring_index(student_id, '-', 3), '-', -1) as unsigned) + 1), '-',
substring_index(student_id, '-', -2))
WHERE 
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) AS UNSIGNED) BETWEEN 0 AND 10000;
    
select student_id, student_name, dob
from student_info
WHERE 
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) AS UNSIGNED) BETWEEN 0 AND 10000
    order by CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) AS UNSIGNED);

-- Add a new column to student_info
alter table student_info
add column reg_num int;

select reg_num from student_info;

update student_info
set reg_num = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(student_id, '-', 3), '-', -1) AS UNSIGNED);

select * from student_info
order by reg_num;

-- Analysis on class info
select * from class_info;

select min(class) as lowest_grade, -- Lowest and highest grade in the school
max(class) as highest_grade from class_info; 

select class, count(student_id) as num_per_class, 
round(count(student_id)/50) as num_of_classes, -- Number of classes per grade. Each class has a max of 50 students
round(((count(student_id) / 10000)*100),2)  as percentage_per_class
from class_info
group by class order by count(student_id);

select gender,count(student_id) as num,round((count(student_id)/10000)*100,2) as percentage
from class_info
group by gender;

select class, count(student_id) as males_per_class, 
round(((count(student_id) / 5402)*100),2)  as percentage_males_per_class
from class_info
where gender = 'male'
group by class order by count(student_id);

select class, count(student_id) as females_per_class, 
round(((count(student_id) / 5402)*100),2)  as percentage_females_per_class
from class_info
where gender = 'female'
group by class order by count(student_id);

select count(student_id), -- Number of students in middle school
round((count(student_id)/10000*100),2) as percentage from class_info
where class <= 9;

select count(student_id), -- Number of students in high school
round((count(student_id)/10000*100),2) as percentage from class_info
where class > 9;

-- Analysis on the tuition column

select * from tuition_info;

select * from  fima_data_base;

create table tuition_info
select student_id, `tuition due`, `tuition paid` -- use slanted inverted commas ``` to reference column names which contain a space in it.
from fima_data_base;

ALTER TABLE fima_data_base -- Changing the name of the colunmn to one without spaces
CHANGE `tuition due` tuition_due VARCHAR(50);

ALTER TABLE fima_data_base -- Changing the name of the colunmn to one without spaces
CHANGE `tuition paid` tuition_paid VARCHAR(50);

-- Tuition analysis proper
select * from tuition_info;
select * from tuition_info
where `tuition due` = 17500;

select count(student_id) as num_17500, -- Number of students paying 17500 and their percentage
round(((count(student_id)/10000)*100),2) as percentage
from tuition_info
where `tuition due` = 17500;

select count(student_id) as num_25000, -- Number of students paying 25000 and their percentage
round(((count(student_id)/10000)*100),2) as percentage
from tuition_info
where `tuition due` = 25000;

select sum(`tuition due`) as total_tuition_expt
from tuition_info;

select sum(`tuition due`) as tuition_epxt_middle_school,
round((sum(`tuition due`)/218897500)*100,2) as percentage
from tuition_info
where `tuition due` = 17500;

select sum(`tuition due`) as tuition_expt_high_school,
round((sum(`tuition due`)/218897500)*100,2) as percentage
from tuition_info
where `tuition due` = 25000;


-- subjective analysis
select sum(`tuition paid`) as tuition_paid,
round(sum(`tuition paid`)/218897500*100,2) as percent_paid
from tuition_info;


select count(student_id) as num -- Number of students who have paid complete tuition
from tuition_info
where `tuition paid` = 17500 or `tuition paid` = 25000;

select count(student_id) as num, -- Amt of students who have paid 75% and above of tuition
count(student_id)/10000*100 as percentage
from tuition_info
where `tuition due` * 0.75 <= `tuition paid`;

select count(student_id) as num, -- Amt of students in mdl school who have paid 75% and above of tuition
count(student_id)/10000*100 as percent_overall,
round(count(student_id)/4147*100,2) as percent_mdl_school
from tuition_info
where `tuition due` * 0.75 <= `tuition paid` and `tuition due` = 17500;

select count(student_id) as num, -- Amt of students in high school who have paid 75% and above of tuition
count(student_id)/10000*100 as percent_overall,
round(count(student_id)/5853*100,2) as percent_high_school
from tuition_info
where `tuition due` * 0.75 <= `tuition paid` and `tuition due` = 25000;

select count(student_id) as num, -- Amt of students who have paid 50% and above of tuition
count(student_id)/10000*100 as percentage
from tuition_info
where `tuition paid` >= `tuition due` * 0.5 and 
`tuition due` * 0.75 > `tuition paid`;

select count(student_id) as num, -- Amt of students in middle school who have paid 50% and above of tuition
count(student_id)/10000*100 as percentage,
round(count(student_id)/4147*100,2) as percent_middle_school
from tuition_info
where `tuition paid` >= `tuition due` * 0.5 and 
`tuition due` * 0.75 > `tuition paid` and `tuition due` = 17500;

select count(student_id) as num, -- Amt of students in high school who have paid 50% and above of tuition
count(student_id)/10000*100 as percentage,
round(count(student_id)/5853*100,2) as percent_high_school
from tuition_info
where `tuition paid` >= `tuition due` * 0.5 and 
`tuition due` * 0.75 > `tuition paid` and `tuition due` = 25000;

select count(student_id) as num, -- Amt of students who have paid 25% and above of tuition
count(student_id)/10000*100 as percentage
from tuition_info
where `tuition paid` >= `tuition due` * 0.25 and 
`tuition due` * 0.5 > `tuition paid`;

select count(student_id) as num, -- Amt of students in middle school who have paid 50% and above of tuition
count(student_id)/10000*100 as percentage,
round(count(student_id)/4147*100,2) as percent_middle_school
from tuition_info
where `tuition paid` >= `tuition due` * 0.25 and 
`tuition due` * 0.5 > `tuition paid` and `tuition due` = 17500;

select count(student_id) as num, -- Amt of students in high school who have paid 50% and above of tuition
count(student_id)/10000*100 as percentage,
round(count(student_id)/5853*100,2) as percent_high_school
from tuition_info
where `tuition paid` >= `tuition due` * 0.25 and 
`tuition due` * 0.5 > `tuition paid` and `tuition due` = 25000;

select count(student_id) as num, -- Amt of students who have paid less than 25% tuition but not nothing
count(student_id)/10000*100 as percentage
from tuition_info
where `tuition paid` < `tuition due` * 0.25 and 
`tuition paid` != 0;

select count(student_id) as num, -- Amt of students in middle school who have paid less than 25% tuition but not nothing
count(student_id)/10000*100 as percentage,
round(count(student_id)/4147*100,2) as percent_middle_school
from tuition_info
where `tuition paid` < `tuition due` * 0.25 and 
`tuition paid` != 0 and `tuition due` = 17500;

select count(student_id) as num, -- Amt of students in high school who have paid less than 25% tuition but not nothing
count(student_id)/10000*100 as percentage,
round(count(student_id)/5853*100,2) as percent_high_school
from tuition_info
where `tuition paid` < `tuition due` * 0.25 and 
`tuition paid` != 0 and `tuition due` = 25000;

select count(student_id) as num, -- Amt of students who have paid nothing for tuition
count(student_id)/10000*100 as percentage
from tuition_info
where `tuition paid` = 0;

select count(student_id) as num, -- Amt of students in middle school who have paid nothing
count(student_id)/10000*100 as percentage,
round(count(student_id)/4147*100,2) as percent_middle_school
from tuition_info
where `tuition paid` = 0 and `tuition due` = 17500;


select count(student_id) as num, -- Amt of students in high school who have paid nothing
count(student_id)/10000*100 as percentage,
round(count(student_id)/5853*100,2) as percent_high_school
from tuition_info
where `tuition paid` = 0 and `tuition due` = 25000;

select min(`tuition paid`), max(`tuition paid`)
from tuition_info
where `tuition paid` != 0;

select min(`tuition paid`), max(`tuition paid`) -- min and max payment by middle school students
from tuition_info
where `tuition due` = 17500;

select min(`tuition paid`), max(`tuition paid`) -- min and max tuition payment by high schoolers
from tuition_info
where `tuition due` = 25000;

select round(avg(`tuition paid`)) -- average tuition paid
from tuition_info;

select round(avg(`tuition paid`))-- average tuition paid by middle schoolelrs
from tuition_info
where `tuition due` = 17500;

select round(avg(`tuition paid`)) -- average tuition payment by high schoolers
from tuition_info
where `tuition due` = 25000;

select sum(`tuition paid`) as tuition_paid, -- total tuition paid so far
round(sum(`tuition paid`)/218897500*100,2) as percentage
from tuition_info;

select sum(`tuition paid`) as tuition_paid, -- total tuition paid so farby mdl schoolers
round(sum(`tuition paid`)/218897500*100,2) as percentage_ovrall,
round(sum(`tuition paid`)/72572500*100,2) as percentage_mdl_School
from tuition_info
where `tuition due` = 17500;

select sum(`tuition paid`) as tuition_paid, -- total tuition paid so farby high schoolers
round(sum(`tuition paid`)/218897500*100,2) as percentage_ovrall,
round(sum(`tuition paid`)/72572500*100,2) as percentage_mdl_School
from tuition_info
where `tuition due` = 25000;


select count(student_id), -- Number of students who have paid part of their tuition
round(count(student_id)/10000*100,2)as percentage  
from tuition_info
where`tuition paid` != 0;

select count(student_id), -- Number of students who have nto paid their tutiton so far
round(count(student_id)/10000*100,2)as percentage  
from tuition_info
where`tuition paid` = 0;

select count(student_id), -- Number of students in middle school who have paid part of their tuition
round(count(student_id)/10000*100,2)as percentage,
round(count(student_id)/4147*100,2) as percentage_mdl_school
from tuition_info
where`tuition paid` != 0 and `tuition due` = 17500;

select count(student_id), -- Number of students in middle school who have paid part of their tuition
round(count(student_id)/10000*100,2)as percentage,
round(count(student_id)/5853*100,2)as percentage_high_school
from tuition_info
where`tuition paid` != 0 and `tuition due` = 25000;

select *
from tuition_info as fees
	join class_info as grade
    on fees.student_id = grade.student_id;
    
select min(`tuition paid`), max(`tuition paid`), class -- Min and max tuition per class
from tuition_info as fees
	join class_info as grade
    on fees.student_id = grade.student_id
    where `tuition paid` != 0
    group by class order by class;
    
select round(avg(`tuiton paid`),2) as avg_payment, class -- average payment per class
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
group by class order by class;

select sum(`tuition due`), class,
round(sum(`tuition due`)/218897500*100,2) as overall_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
group by class order by class;

select sum(`tuition due`), class,
round(sum(`tuition due`)/218897500*100,2) as overall_percent,
round(sum(`tuition due`)/72572500*100,2) as mdl_school_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where `tuition due` = 17500
group by class order by class;

select sum(`tuition due`), class,
round(sum(`tuition due`)/218897500*100,2) as overall_percent,
round(sum(`tuition due`)/146325000*100,2) as high_school_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where `tuition due` = 25000
group by class order by class;


select sum(`tuition paid`), class, -- total tuition paid per class and overall percentage
round(sum(`tuition paid`)/218897500*100,2) as overall_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
group by class order by class;

select class, sum(`tuition paid`),  -- sectional and class percentage for grade 7
round(sum(`tuition paid`)/24115000*100,2) as class_percent,
round(sum(`tuition paid`)/72572500*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 7;


select class, sum(`tuition paid`),  -- sectional and class percentage for grade 8
round(sum(`tuition paid`)/24255000*100,2) as class_percent,
round(sum(`tuition paid`)/72572500*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 8;

select class, sum(`tuition paid`),  -- sectional and class percentage for grade 9
round(sum(`tuition paid`)/24202500*100,2) as class_percent,
round(sum(`tuition paid`)/72572500*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 9;


select class, sum(`tuition paid`),  -- sectional and class percentage for grade 10
round(sum(`tuition paid`)/36850000*100,2) as class_percent,
round(sum(`tuition paid`)/146325000*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 10;


select class, sum(`tuition paid`),  -- sectional and class percentage for grade 11
round(sum(`tuition paid`)/36800000*100,2) as class_percent,
round(sum(`tuition paid`)/146325000*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 11;

select class, sum(`tuition paid`),  -- sectional and class percentage for grade 12
round(sum(`tuition paid`)/35900000*100,2) as class_percent,
round(sum(`tuition paid`)/146325000*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 12;


select class, sum(`tuition paid`),  -- sectional and class percentage for grade 13
round(sum(`tuition paid`)/36775000*100,2) as class_percent,
round(sum(`tuition paid`)/146325000*100,2) as sect_percent
from tuition_info as fee
join class_info as grade
on fee.student_id = grade.student_id
where class = 13;

-- TUition paid per father's occupation
select * from parent_info;

select fathers_occupation, sum(`tuition paid`) as tuition_paid,
 round(avg(`tuition paid`),2) as avg_paymt
 from tuition_info as fee
 join parent_info as parent
 on fee.student_id = parent.student_id
 group by Fathers_Occupation order by round(avg(`tuition paid`),2);
 
 -- Tuition paid per Father's occupation
 
 select fathers_occupation, sum(`tuition due`) as tuition_due, round(avg(`tuition paid`),2) as avg_pay,
 sum(`tuition paid`) as tuition_paid, 
 round(sum(`tuition paid`)/sum(`tuition due`)*100,2) as percent_paid
 from tuition_info as fees
 join parent_info as parent
 on fees.student_id = parent.student_id
 where `tuition paid` <= 1000
 and `tuition due` = 17500
 group by Fathers_Occupation order by  round(sum(`tuition paid`)/sum(`tuition due`)*100,2);
 
  select year(now()) - year(dob),
  sum(`tuition due`) as tuition_due, round(avg(`tuition paid`),2) as avg_pay,
 sum(`tuition paid`) as tuition_paid, 
 round(sum(`tuition paid`)/sum(`tuition due`)*100,2) as percent_paid
 from tuition_info as fees
 join student_info as stu
 on stu.student_id = fees.student_id
 group by year(now()) - year(dob) 
 order by round(sum(`tuition paid`)/sum(`tuition due`)*100,2);
 
 