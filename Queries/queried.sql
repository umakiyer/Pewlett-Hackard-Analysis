SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
	   dm.emp_no,
	   dm.from_date,
	   dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;

--Joing retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
		dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
on retirement_info.emp_no =  dept_emp.emp_no;
		
--Joing retirement_info and dept_emp tables & Creating Current employee going to retire
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
		de.to_date
INTO current_emp		
FROM retirement_info as ri
LEFT JOIN dept_emp as de
on ri.emp_no =  de.emp_no
WHERE de.to_date=('9999-01-01');

SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no,
	first_name,
	last_name,
	gender
INTO emp_info
FROM employees as e
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

-- List 1: Employee Information
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.gender,
	   s.salary,
	   de.to_date
INTO emp_info	   
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date='9999-01-01');

SELECT COUNT(emp_no) FROM emp_info;

-- List 2: Management
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments d
	ON dm.dept_no = d.dept_no
INNER JOIN current_emp as ce
    ON dm.emp_no = ce.emp_no;
	
SELECT COUNT(dept_no) FROM manager_info;
	
-- Department Retirees
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as dm
  ON (ce.emp_no = dm.emp_no)
INNER JOIN departments as d
  ON (dm.dept_no = d.dept_no);

SELECT COUNT(emp_no) FROM dept_info;

-- Only Sales Department
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name

FROM current_emp as ce
INNER JOIN dept_emp as dm
  ON (ce.emp_no = dm.emp_no)
INNER JOIN departments as d
  ON (dm.dept_no = d.dept_no)
 WHERE d.dept_name='Sales' ;

-- Only Sales & Development Department
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name

FROM current_emp as ce
INNER JOIN dept_emp as dm
  ON (ce.emp_no = dm.emp_no)
INNER JOIN departments as d
  ON (dm.dept_no = d.dept_no)
 WHERE d.dept_name IN ('Sales','Development');
 
 -- ABOVE CODES FROM CLASS MODULE 