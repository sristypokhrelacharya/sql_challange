--create a table of departments
drop table department;
	CREATE TABLE department (
	dept_no VARCHAR(255) NOT NULL PRIMARY KEY, 
	dept_name VARCHAR(255)
	);
--create a table of departments employees numbers
drop table dept_employee;
  CREATE TABLE dept_employee (
	emp_no INT NOT NULL, 
	dept_no VARCHAR(255)
	);
--create a table of departments manager
DROP TABLE dept_manager
  CREATE TABLE dept_manager (
  dept_no VARCHAR(255) NOT NULL,
  emp_no INT NOT NULL,
  PRIMARY KEY (dept_no, emp_no),
  FOREIGN KEY (dept_no) REFERENCES department(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--create a table of departments employees and their info
	CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY, 
	emp_title_id VARCHAR(255),
	birth_date DATE NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	sex VARCHAR(255) NOT NULL,
	hire_date DATE
	);

--creating the junction table 
CREATE TABLE departments_employee_junction (
	dept_no VARCHAR(255) NOT NULL,
	emp_title_id VARCHAR(255) NOT NULL,
	employee_title VARCHAR(255) NOT NULL,
	PRIMARY KEY (dept_no, emp_title_id),
	FOREIGN KEY (dept_no) REFERENCES department (dept_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);
--insert into the table departments_employee_junction
INSERT INTO departments_employee_junction (dept_no, emp_title_id, employee_title)
VALUES
	('d001', 'T001', 'Sales Representative'),
	('d002', 'T002', 'Marketing Coordinator'),
	('d001', 'T003', 'Sales Manager');
	
--create a table of department salaries
drop table dept_salaries
	CREATE TABLE dept_salaries (
	emp_no INT NOT NULL PRIMARY KEY, 
	salary VARCHAR(255)
	);
	
--create a table of department title
drop table titles
	CREATE TABLE titles (
	title_id VARCHAR(255) NOT NULL PRIMARY KEY, 
	title VARCHAR(255)
	);
	
--list the employee number, last name, first name, sex, and salary of each employee
	SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
	FROM employees AS e
	JOIN dept_salaries AS s ON e.emp_no = s.emp_no;
	
--the List the first name, last name, and hire date for the employees who were hired in 1986
	SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
	
	or 
	
	WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';
	
--list of the manager of each department along with their department number, department name, employee number, last name, and first name 
	SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
	FROM department AS d
	JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
	JOIN employees AS e ON dm.emp_no = e.emp_no;
	
--List of the department number for each employee along with that employee’s employee number, last name, first name, and department name 
--table aliases "e" and "d" are defined using the "AS" keyword
	SELECT e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name
	FROM employees AS e
	JOIN dept_employee AS de ON e.emp_no = de.emp_no
	JOIN department AS d ON de.dept_no = d.dept_no;
	
--List of first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
	SELECT first_name, last_name, sex
	FROM employees
	WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
	
--query to list each employee in the Sales department, including their employee number, last name, and first name
	SELECT e.emp_no, e.last_name, e.first_name
	FROM employees AS e
	JOIN dept_employee AS de ON e.emp_no = de.emp_no
	JOIN department AS d ON de.dept_no = d.dept_no
	WHERE d.dept_name = 'Sales';
	
--List of each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
	SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM employees AS e
	JOIN dept_employee AS de ON e.emp_no = de.emp_no
	JOIN department AS d ON de.dept_no = d.dept_no
	WHERE d.dept_name IN ('Sales', 'Development');
	
	SELECT * FROM dept_employee;
	
--list the frequency counts of employee last names in descending order, indicating how many employees share each last name
	SELECT last_name, COUNT(*) AS frequency
	FROM employees
	GROUP BY last_name
	ORDER BY frequency DESC;
	