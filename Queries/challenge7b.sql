SELECT de.dept_no, d.dept_name,COUNT(me.emp_no) as mentors
INTO mentors_employee
FROM mentorship_eligibilty as me
JOIN  dept_emp as de
ON de.emp_no = me.emp_no
JOIN departments as d
ON de.dept_no = d.dept_no
GROUP BY de.dept_no,d.dept_name
ORDER BY dept_no ;
