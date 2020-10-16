/*
ALTER TABLE dbo.[Employee]
ADD CONSTRAINT UC_Emp UNIQUE (EmpID);
*/
/*
Drop PROCEDURE SetManager 
*/
/*
CREATE PROCEDURE SetManager 
@PublicEmployeeID int,
@DepartmentName nvarchar(50)
AS
	declare @DepartmentID int;
	declare @EmployeeID int;
	
	set @DepartmentID = (select id from dbo.Department where DepName = @DepartmentName);
	set @EmployeeID = (select id from dbo.Employee where EmpID = @PublicEmployeeID);

	if exists (select * from dbo.DepartmentManager with (updlock,serializable) where DepId = @DepartmentID)
	begin
	   update dbo.DepartmentManager 
	   set EmpId = @EmployeeID
	   where DepId = @DepartmentID
	end
	else
	begin
	   insert into dbo.DepartmentManager  (DepId,EmpId)
	   values (@DepartmentID,@EmployeeID)
	end
GO
*/
/*
Exec SetManager 1003,'Accounting'
*/