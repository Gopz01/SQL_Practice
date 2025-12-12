with cte as(
select 
  name as Employee, 
  salary as Salary, 
  departmentId, 
  dense_rank() over (partition by departmentId order by salary desc) as d_rnk
FROM Employee 
)
SELECT d.name as Department, Employee, Salary 
FROM 
  cte c 
  JOIN Department d ON c.departmentId = d.id 
where d_rnk <=3
