CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY Identity, 
    [EmpName] NVARCHAR(50) NOT NULL, 
    [EmpID] INT NOT NULL, 
    [EmpContacts] NVARCHAR(50) NOT NULL, 
    [EmpAge] INT NOT NULL, 
    [EmpDept] INT NOT NULL FOREIGN KEY REFERENCES Department(Id)
)
