CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

select COUNT(first_name)
from employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');

DROP Table retirement_info;
select emp_no, first_name, last_name
INTO retirement_info
from employees
where (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');
select * from retirement_info;


select d.dept_name,
	ma.emp_no,
	ma.from_date,
	ma.to_date
From departments as d
Inner Join managers as ma
on d.dept_no = ma.dept_no;

select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
From retirement_info
Left Join dept_emp
on  retirement_info.emp_no = dept_emp.emp_no;

select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
From retirement_info as ri
Left Join dept_emp as de
on  ri.emp_no = de.emp_no;

select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
Into current_emp
From retirement_info as ri
Left Join dept_emp as de
on  ri.emp_no = de.emp_no
Where de.to_date = ('9999-01-01');

-- employee count by department
select count(ce.emp_no), de.dept_no
From current_emp as ce
left Join dept_emp as de
On ce.emp_no = de.emp_no
group By de.dept_no;

-- include order by clause
select count(ce.emp_no), de.dept_no
From current_emp as ce
left Join dept_emp as de
On ce.emp_no = de.emp_no
group By de.dept_no
Order By de.dept_no;

-- save it as a new table
select count(ce.emp_no), de.dept_no
Into count_by_department
From current_emp as ce
left Join dept_emp as de
On ce.emp_no = de.emp_no

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary,
	de.to_date
	INTO emp_info
FROM employees as e
Inner Join salaries as s
ON (e.emp_no = s.emp_no)
Inner Join dept_emp as de
On (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary,
	de.to_date
	INTO emp_info
FROM employees as e
Inner Join salaries as s
ON (e.emp_no = s.emp_no)
Inner Join dept_emp as de
On (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

--- Manger retire list
Select ma.dept_no,
	ma.emp_no,
	ma.from_date,
	ma.to_date,
	d.dept_name,
	ce.first_name,
	ce.last_name
INTO manager_info
From managers As ma
	Inner Join departments As d
	On (ma.dept_no = d.dept_no)
	Inner Join current_emp as ce
	on (ma.emp_no = ce.emp_no);


SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)

--sales Employees retiring
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	de.dept_no
INTO sales_emp
FROM employees as e
Inner Join salaries as s
ON (e.emp_no = s.emp_no)
Inner Join dept_emp as de
On (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
AND (de.dept_no = 'd007');

--sales/dev Employees retiring
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	de.dept_no
--INTO sales_dev_emp
FROM employees as e
Inner Join salaries as s
ON (e.emp_no = s.emp_no)
Inner Join dept_emp as de
On (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
AND de.dept_no in ('d007','d005');