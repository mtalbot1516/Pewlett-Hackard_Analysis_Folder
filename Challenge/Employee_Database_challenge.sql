-- retirement titles
Select
	e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
	Into retirement_titles
	from employees as e
	Inner Join titles as ti
	On e.emp_no = ti.emp_no
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	Order By e.emp_no;
	
Select * from retirement_titles limit 1000;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

Select * from unique_titles limit 1000;


-- Retiring titles
Select count(ut.title), ut.title
Into retiring_titles1
from unique_titles as ut
Group By ut.title
Order By count Desc;
select * from retiring_titles1;

Select Distinct on (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
Into mentorship_eligibility
from employees as e
Inner Join dept_emp as de
ON e.emp_no = de.emp_no
Inner Join titles as ti
On e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, ti.to_date DESC;

select * from mentorship_eligibility;