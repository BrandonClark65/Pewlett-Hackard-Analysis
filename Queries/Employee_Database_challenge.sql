-- Join employees tabe and titles table to get title for employees of retiring age
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS title
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
    r.first_name,
    r.last_name,
    r.title
INTO unique_titles
FROM retirement_titles AS r
WHERE (r.to_date = '9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;

-- Retrieve the number of employees by most recent job title about to retire
SELECT COUNT(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Create a mentorship eligibility table 
SELECT DISTINCT ON (e.emp_no) 
    e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    d.from_date,
    d.to_date,
    t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS d
ON (e.emp_no = d.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (d.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;