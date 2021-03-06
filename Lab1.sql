--1. Consider the following COMPANY relational database schema. 
--Create EMPLOYEE, DEPARTMENT, DEPT_LOCATIONS, PROJECT, WORKS_ON, and DEPENDENT tables .

DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE dept_locations CASCADE CONSTRAINTS;
DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE works_on CASCADE CONSTRAINTS;
DROP TABLE dependent CASCADE CONSTRAINTS;





CREATE TABLE employee (
  fname    varchar2(15) not null, 
  minit    varchar2(1),
  lname    varchar2(15) not null,
  ssn      char(9),
  bdate    date,
  address  varchar2(30),
  sex      char,
  salary   number(10,2),
  superssn char(9),
  dno      number(4),
  primary key (ssn),
  foreign key (superssn) references employee(ssn)
--  foreign key (dno) references department(dno)
);


CREATE TABLE department (
  dname        varchar2(15) not null,
  dnumber      number(4),
  mgrssn       char(9) not null, 
  mgrstartdate date,
  primary key (dnumber),
  unique (dname),
  foreign key (mgrssn) references employee(ssn)
);

alter table employee add (
  foreign key (dno) references department(dnumber)
);


CREATE TABLE dept_locations (
  dnumber   number(4),
  dlocation varchar2(15), 
  primary key (dnumber,dlocation),
  foreign key (dnumber) references department(dnumber)
);


CREATE TABLE project (
  pname      varchar2(15) not null,
  pnumber    number(4),
  plocation  varchar2(15),
  dnum       number(4) not null,
  primary key (pnumber),
  unique (pname),
  foreign key (dnum) references department(dnumber)
);


CREATE TABLE works_on (
  essn   char(9),
  pno    number(4),
  hours  number(4,1),
  primary key (essn,pno),
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
);


CREATE TABLE dependent (
  essn           char(9),
  dependent_name varchar2(15),
  sex            char,
  bdate          date,
  relationship   varchar2(8),
  primary key (essn,dependent_name),
  foreign key (essn) references employee(ssn)
);

--use this to write in observation
--INSERT INTO EMPLOYEE VALUES('&Fname','&minit', '&Lname', '&Ssn', TO_DATE('&Bdate','DD-MM-YYYY'), '&Address', '&Sex', &SALARY, '&SUPER_SSN', &DNO);





DELETE FROM employee;
DELETE FROM department;
DELETE FROM project;
DELETE FROM dept_locations;
DELETE from dependent;
DELETE FROM works_on;




INSERT INTO employee VALUES ('James', 'E', 'Borg','888665555', '10-NOV-37', 'Houston,TX', 'M', 55000, null, null);        
INSERT INTO employee VALUES ('Franklin', 'T', 'Wong','333445555', '08-DEC-55', 'Houston,TX', 'M', 40000, '888665555', null);
INSERT INTO employee VALUES ('Jennifer', 'S', 'Wallace','987654321', '20-JUN-41', 'Bellaire,TX', 'F', 43000, '888665555', null);
        

INSERT INTO department VALUES ('Research', 5, '333445555', '22-MAY-78');
INSERT INTO department VALUES ('Administration', 4, '987654321', '01-JAN-85');
INSERT INTO department VALUES ('Headquarters', 1, '888665555', '19-JUN-71');

UPDATE employee SET DNO = 5 WHERE ssn = '333445555';
UPDATE employee SET DNO = 4 WHERE ssn = '987654321';
UPDATE employee SET DNO = 1 WHERE ssn = '888665555';


INSERT INTO employee VALUES ('John', 'B', 'Smith','123456789', '09-Jan-65', 'Houston,TX', 'M', 30000, '333445555', 5);
INSERT INTO employee VALUES ('Alicia', 'J', 'Zelaya','999887777', '19-JUL-68', 'Spring,TX', 'F', 25000, '987654321', 4);
INSERT INTO employee VALUES ('Ramesh', 'K', 'Narayan','666884444', '15-SEP-62', 'Humble,TX', 'M', 38000, '333445555', 5);
INSERT INTO employee VALUES ('Joyce', 'A', 'English','453453453', '31-JUL-72', 'Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO employee VALUES ('Ahmad', 'V', 'Jabbar','987987987', '29-MAR-69', 'Houston,TX', 'M', 25000, '987654321', 4);




INSERT INTO project VALUES ('ProductX', 1, 'Bellaire',  5);
INSERT INTO project VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO project VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO project VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO project VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO project VALUES ('Newbenefits', 30,  'Stafford', 4);


INSERT INTO dept_locations VALUES (1, 'Houston');
INSERT INTO dept_locations VALUES (4, 'Stafford');
INSERT INTO dept_locations VALUES (5, 'Bellaire');
INSERT INTO dept_locations VALUES (5, 'Sugarland');
INSERT INTO dept_locations VALUES (5, 'Houston');


INSERT INTO dependent VALUES ('333445555','Alice','F','05-APR-86','Daughter');
INSERT INTO dependent VALUES ('333445555','Theodore','M','25-OCT-83','Son');
INSERT INTO dependent VALUES ('333445555','Joy','F','03-MAY-58','Spouse');
INSERT INTO dependent VALUES ('987654321','Abner','M','28-FEB-42','Spouse');
INSERT INTO dependent VALUES ('123456789','Michael','M','01-JAN-88','Son');
INSERT INTO dependent VALUES ('123456789','Alice','F', '31-DEC-88','Daughter');
INSERT INTO dependent VALUES ('123456789','Elizabeth','F','05-MAY-67','Spouse');


INSERT INTO works_on VALUES ('123456789', 1,  32.5);
INSERT INTO works_on VALUES ('123456789', 2,  7.5);
INSERT INTO works_on VALUES ('666884444', 3,  40.0);
INSERT INTO works_on VALUES ('453453453', 1,  20.0);
INSERT INTO works_on VALUES ('453453453', 2,  20.0);
INSERT INTO works_on VALUES ('333445555', 2,  10.0);
INSERT INTO works_on VALUES ('333445555', 3,  10.0);
INSERT INTO works_on VALUES ('333445555', 10, 10.0);
INSERT INTO works_on VALUES ('333445555', 20, 10.0);
INSERT INTO works_on VALUES ('999887777', 30, 30.0);
INSERT INTO works_on VALUES ('999887777', 10, 10.0);
INSERT INTO works_on VALUES ('987987987', 10, 35.0);
INSERT INTO works_on VALUES ('987987987', 30, 5.0);
INSERT INTO works_on VALUES ('987654321', 30, 20.0);
INSERT INTO works_on VALUES ('987654321', 20, 15.0);
INSERT INTO works_on VALUES ('888665555', 20, null);


--2. Display names of all employees.
select fname,minit,lname from   employee;

  --------------- - ---------------
FNAME           M LNAME
--------------- - ---------------
James           E Borg
Franklin        T Wong
Jennifer        S Wallace
John            B Smith
Alicia          J Zelaya
Ramesh          K Narayan
Joyce           A English
Ahmad           V Jabbar




  
--3. Display all the employees from ‘HOUSTON’.


SELECT * FROM employee where address like '%Houston%';
FNAME           M LNAME           SSN       BDATE
--------------- - --------------- --------- ----------
ADDRESS                        S     SALARY SUPERSSN         DNO
------------------------------ - ---------- --------- ----------
James           E Borg            888665555 1937-11-10
Houston,TX                     M      55000                    1

Franklin        T Wong            333445555 1965-12-08
Houston,TX                     M      40000 888665555          5

John            B Smith           123456789 1965-01-09
Houston,TX                     M      30000 333445555          5


FNAME           M LNAME           SSN       BDATE
--------------- - --------------- --------- ----------
ADDRESS                        S     SALARY SUPERSSN         DNO
------------------------------ - ---------- --------- ----------
Joyce           A English         453453453 1972-07-31
Houston, TX                    F      25000 333445555          5

Ahmad           V Jabbar          987987987 1969-03-29
Houston,TX                     M      25000 987654321          4






--4. Add a column named Phone_no to employee table.

ALTER TABLE employee ADD Phone_no INT;
Table altered.





--5. Assign the Phone_no for all employees.
UPDATE employee SET Phone_no = 1235688 WHERE Ssn = 123456789;
    UPDATE employee SET Phone_no = 7335688 WHERE Ssn = 333445555;
    UPDATE employee SET Phone_no = 9535688 WHERE Ssn = 999887777;
    UPDATE employee SET Phone_no = 74935688 WHERE Ssn = 987654321;
    UPDATE employee SET Phone_no = 9405688 WHERE Ssn = 666884444;
    UPDATE employee SET Phone_no = 8885688 WHERE Ssn = 453453453;
    UPDATE employee SET Phone_no = 8085688 WHERE Ssn = 987987987;
    UPDATE employee SET Phone_no = 9935688 WHERE Ssn = 888665555;
1 row updated.




--6. View the structure of the table employee using describe.

DESC employee;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 FNAME                                     NOT NULL VARCHAR2(15)
 MINIT                                              VARCHAR2(1)
 LNAME                                     NOT NULL VARCHAR2(15)
 SSN                                       NOT NULL CHAR(9)
 BDATE                                              DATE
 ADDRESS                                            VARCHAR2(30)
 SEX                                                CHAR(1)
 SALARY                                             NUMBER(10,2)
 SUPERSSN                                           CHAR(9)
 DNO                                                NUMBER(4)
 PHONE_NO                                           NUMBER(38)




--7. Delete all the employees from ‘HUMBLE’

DELETE FROM works_on WHERE Essn IN(SELECT Ssn FROM employee WHERE Address LIKE '%Humble%');
1 row deleted.
DELETE FROM employee WHERE address LIKE '%Humble%';
1 row deleted.




--8. Rename employee as employee1.


ALTER TABLE employee RENAME TO employee1;
SELECT * FROM employee1;
FNAME           M LNAME           SSN       BDATE
--------------- - --------------- --------- ----------
ADDRESS                        S     SALARY SUPERSSN         DNO   PHONE_NO
------------------------------ - ---------- --------- ---------- ----------
James           E Borg            888665555 1937-11-10
Houston,TX                     M      55000                    1    9935688

Franklin        T Wong            333445555 1965-12-08
Houston,TX                     M      40000 888665555          5    7335688

Jennifer        S Wallace         987654321 1941-06-20
Bellaire,TX                    F      43000 888665555          4   74935688


FNAME           M LNAME           SSN       BDATE
--------------- - --------------- --------- ----------
ADDRESS                        S     SALARY SUPERSSN         DNO   PHONE_NO
------------------------------ - ---------- --------- ---------- ----------
John            B Smith           123456789 1965-01-09
Houston,TX                     M      30000 333445555          5    1235688

Alicia          J Zelaya          999887777 1968-01-19
Spring,TX                      F      25000 987654321          4    9535688

Joyce           A English         453453453 1972-07-31
Houston, TX                    F      25000 333445555          5    8885688


FNAME           M LNAME           SSN       BDATE
--------------- - --------------- --------- ----------
ADDRESS                        S     SALARY SUPERSSN         DNO   PHONE_NO
------------------------------ - ---------- --------- ---------- ----------
Ahmad           V Jabbar          987987987 1969-03-29
Houston,TX                     M      25000 987654321          4    8085688


7 rows selected.





--9. Drop the table employee1.


Drop table employee CASCADE CONSTRAINTS;
Table dropped.
































set echo on
-- 7.19 (a) Retrieve the names of all employees in department
--          5 who work more than 10 hours per week on the
--          'ProductX' project.
select   fname,minit,lname
from     employee,works_on,project
where    ssn = essn and
         pno = pnumber and
         dno = 5 and
         hours > 10 and
         pname = 'ProductX';
--
-- 7.19 (b) List the names of all employees who have a dependent
--          with the same first name as themselves.
select fname,minit,lname
from   employee,dependent
where  ssn = essn and
       dependent_name = fname;
--
-- 7.19 (c) Find the names of all employees who are directly supervised
--          by 'Franklin Wong'.
select e.fname,e.minit,e.lname
from   employee e, employee m
where  e.superssn = m.ssn and
       m.fname = 'Franklin' and
       m.lname = 'Wong';
--
-- 7.19 (d) For each project, list the project name and the total hours
--          per week (by all employees) spent on that project.
select pname,sum(hours) TOTAL_HOURS
from   works_on,project
where  pno = pnumber
group by pname;
--
-- 7.19 (e) Retrieve the names of all employees who work every
--          project.
select fname,minit,lname
from   employee
where  not exists 
         (select pnumber
          from   project
          where  not exists 
                   (select 7
                    from   works_on
                    where  works_on.essn = employee.ssn and
                           works_on.pno =  project.pnumber));
--
-- 7.19 (f) Retrieve the names of all employees who do not work
--          on any project.
select fname,minit,lname
from employee
where not exists ( select 7
                   from works_on
                   where essn = ssn);               
--
-- 7.19 (g) For each department, retrieve the department name
--          and the average salary of all employees working in
--          that department.
select dname,avg(salary) AVERAGE_SALARY
from   employee,department
where  dno = dnumber
group by dname;
--
-- 7.19 (h) Retrieve the average salary of all female employees.
select avg(salary) AVG_FEMALE_SALARY
from   employee
where  sex = 'F';
--
-- 7.19 (i) Find the names and addresses of all employees who
--          work on at least one project located in Houston
--          but whose department has no location in Houston.
select fname,minit,lname,address
from employee
where ssn in (select essn
              from works_on,project
              where pno = pnumber and
                    plocation = 'Houston') and
      dno not in (select dnumber
                  from   dept_locations
                  where  dlocation = 'Houston');
--
-- 7.19 (j) List the last names of all department managers who
--          have no dependents.
select lname
from   employee
where  ssn in (select mgrssn
               from department) and
       ssn not in (select essn
                   from dependent);
--
set echo on
-- 8.14 (a) For each department whose average employee salary
--          is more than 30000, retrieve the department name and
--          the number of employees working for that department.
select dname, count(*) NUM_EMPS
from   employee,department
where  dno = dnumber
group by  dname
having avg(salary) > 30000;
--
--
-- 8.14 (b) Suppose that we want the number of male employees in
--          each department rather than all employees (as in 7.14a)
--          Can we specify this query in SQL? Why or Why not?
select dname,count(*) NUM_MALE_EMPS
from   employee,department
where  dno = dnumber and sex = 'M'
group by  dname
having dname in (
        select dname
        from   employee,department
        where  dno = dnumber
        group by  dname
        having avg(salary) > 30000);
