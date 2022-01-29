SELECT ut.dept_no, cast(sum(s.salary) as money)
INTO dept_budget
FROM unique_title_dept as ut
JOIN salaries as s
on ut.emp_no = s.emp_no
GROUP BY ut.dept_no
ORDER BY dept_no ;

SELECT --db.dept_no,
		d.dept_name,
		db.sum as Total_Salary
FROM dept_budget as db
JOIN departments as d
ON db.dept_no=d.dept_no;

SELECT ut.dept_no, COUNT(emp_no) as Total_employee
INTO dept_num_retirees
FROM unique_title_dept as ut
GROUP BY ut.dept_no
ORDER BY dept_no ;

SELECT dm.dept_no, d.dept_name, dm.total_employee, db.sum as total_salaries
INTO dept_wise_retirees
FROM dept_num_retirees as dm
JOIN departments as d
ON dm.dept_no = d.dept_no
JOIN dept_budget as db
ON d.dept_no = db.dept_no ;

