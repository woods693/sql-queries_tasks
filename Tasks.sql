/* Question a */
ALTER TABLE TechStaff
add constraint age_constraint check (10<=age and 125>=age);

AlTER TABLE  Soundtrack
add constraint song_constraint check ([duration(sec)] > 0);


/* Question b */

ALTER TABLE Actors
ADD fname varchar(255);

ALTER TABLE Actors
ADD lname varchar(255);

Update Actors
Set fname = CASE
 WHEN charindex(',', name) > 0
 THEN ltrim(right(name, len(name) - charindex(',', name)))
 ELSE name END,
 lname = CASE
 WHEN charindex(',', name) > 0
 THEN left(name, charindex(',', name)-1)
 ELSE ' ' END

/* Question c*/

select * from Studio
select * from TechStaff

SELECT studioID,   
COUNT(*)as "employees"
FROM TechStaff  
GROUP BY studioID; 

UPDATE Studio
SET employees = A.employees
FROM (SELECT studioID,   
COUNT(*) "employees"
FROM TechStaff  
GROUP BY studioID) A
WHERE
	A.studioID = Studio.studioID

/* Question d */
CREATE TRIGGER d_techstaff
ON Techstaff
After INSERT, DELETE
AS
begin
	UPDATE Studio
	SET employees = A.employees
	FROM (SELECT studioID,   
	COUNT(*) "employees"
	FROM TechStaff  
	GROUP BY studioID) A
	WHERE
		A.studioID = Studio.studioID
end

/* Question e */

CREATE TRIGGER del_studio
ON Studio
FOR DELETE
AS
begin
	IF object_id('FoldedStudios','U') is not null
		PRINT 'Present!'
	ELSE
		begin
			CREATE TABLE FoldedStudios
			(
				studioName varchar(50),
				fired int
				PRIMARY KEY(studioName)
			)
		end
		INSERT INTO FoldedStudios (studioName, fired)
		Select studioName, employees
		FROM DELETED
end
/* Question f */

CREATE PROCEDURE spSearchString @st	varchar(20)
AS
SELECT title
FROM Keywords
WHERE keyword LIKE '%' + @st + '%'
GO



