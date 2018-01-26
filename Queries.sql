
/* Question a */
SELECT   name,
         COUNT(name) AS counts
FROM ActedIn
GROUP BY name
ORDER BY COUNT(name) DESC;

/* Question b */
SELECT   name,
         COUNT(name) AS counts
FROM ActedIn
GROUP BY name
HAVING COUNT(name) > 1
ORDER BY COUNT(name) DESC;

/* Question c */
SELECT name, COUNT(name) AS movies FROM ActedIn
GROUP BY name HAVING COUNT(name) = (
    SELECT MAX(y.x) FROM (SELECT COUNT(name) AS x 
	FROM ActedIn GROUP BY name) AS y
);

/* Question d */
SELECT Movie.title FROM Movie 
WHERE Movie.title IN (SELECT title 
from Keywords where Keywords.title NOT IN (SELECT Keywords.title WHERE Keywords.title LIKE '%' + 'star' + '%')
AND Keywords.keyword LIKE '%' + 'war' + '%') AND Movie.genre = 'Action';

/* Question e */
select Soundtrack.songID, Soundtrack.rank, Keywords.keyword 
from Movie join Soundtrack on Movie.title = Soundtrack.title join Keywords on Keywords.title = Movie.title
WHERE Keywords.keyword LIKE '%' + 'computer' + '%'
ORDER BY rank;

/* Question f */
select T.sin, T.fname, T.lname, T.age, T.salary, T.studioID
from Techstaff T, Actors A
WHERE T.fname LIKE A.fname AND T.lname = A.lname

/* Question g */
select studioName, AVG(Actors.salary) as actorsAvg, AVG(TechStaff.salary) as techstaffAvg
FROM Studio JOIN Movie on Studio.studioID = Movie.studioID
JOIN ActedIn on ActedIn.title = Movie.title
Join Actors on Actors.name = ActedIn.name
JOIN TechStaff 
on Studio.studioID = TechStaff.studioID
GROUP BY Studio.studioName;
