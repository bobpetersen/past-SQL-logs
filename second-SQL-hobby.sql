CREATE TABLE "person"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50)
);

INSERT INTO "person" ("name")
VALUES ('Luke');

SELECT "id", "name" FROM "person";

INSERT INTO "person" ("name")
VALUES ('Jason');

CREATE TABLE "hobby"(
	"id" SERIAL PRIMARY KEY,
	"description" VARCHAR(100)
);

INSERT INTO "hobby" ("description")
VALUES ('Racquetball'), ('Space Travel'), ('Kayaking'),
('Volleyball'), ('Twins Games'), ('Pinball'),
('Deep Sea Rocket Racing'), ('Karaoke');

SELECT * FROM "hobby"
ORDER BY "id";

SELECT * FROM "person";

UPDATE "hobby" 
SET "person_id"=4 
WHERE "id"=3;

-- only hobbies 
SELECT * FROM "hobby"
JOIN "person" 
ON "hobby"."person_id" = "person"."id"
ORDER BY "hobby"."id";

--all hobbies and all people
SELECT * FROM "hobby"
FULL OUTER JOIN "person" 
ON "hobby"."person_id" = "person"."id"
ORDER BY "hobby"."id";

--all hobbies and people who have hobbies
SELECT * FROM "hobby"
LEFT JOIN "person" 
ON "hobby"."person_id" = "person"."id"
ORDER BY "hobby"."id";

--all people and their hobbies
SELECT * FROM "hobby"
RIGHT JOIN "person" 
ON "hobby"."person_id" = "person"."id"
ORDER BY "hobby"."id";

CREATE TABLE "person_hobby"(
	"id" SERIAL PRIMARY KEY,
	"person_id" INT REFERENCES "person",
	"hobby_id" INT REFERENCES "hobby",
	"skill" INT
);

UPDATE "skill" 
SET "person_id"=1 
WHERE "id"=3;


INSERT INTO "person_hobby" ("person_id", "hobby_id", "skill")
VALUES (1, 2, 5),
(5, 1, 2);

SELECT "person"."name", "person"."id", "person_hobby"."person_id",
"person_hobby"."hobby_id","hobby"."id", "hobby"."description"
FROM "person"
JOIN "person_hobby" ON "person"."id"="person_hobby"."person_id"
JOIN "hobby" ON "person_hobby"."hobby_id"="hobby"."id";

INSERT INTO "person_hobby" ("person_id", "hobby_id", "skill")
VALUES (1, 7, 5),
(2, 7, 5),
(3, 7, 5),
(4, 7, 5),
(5, 7, 5);

SELECT "person"."name", "person"."id", "person_hobby"."person_id",
"person_hobby"."skill","hobby"."id", "hobby"."description"
FROM "person"
JOIN "person_hobby" ON "person"."id"="person_hobby"."person_id"
JOIN "hobby" ON "person_hobby"."hobby_id"="hobby"."id";

SELECT "person"."name", "person"."id", "person_hobby"."person_id", "person_hobby"."skill", "person_hobby"."hobby_id", "hobby"."id", "hobby"."description"
FROM "person"
JOIN "person_hobby" ON "person"."id"="person_hobby"."person_id"
JOIN "hobby" ON "person_hobby"."hobby_id"="hobby"."id";

SELECT COUNT (*) FROM "person";

SELECT COUNT (*) FROM "hobby";

SELECT MIN ("id") FROM "person_hobby";

SELECT MIN ("skill") from "person_hobby";

SELECT MAX ("skill") from "person_hobby";

SELECT AVG ("skill") from "person_hobby";

SELECT SUM ("skill") from "person_hobby";

SELECT MIN ("skill"), MAX("skill"), AVG("skill"), SUM("skill") FROM "person_hobby";


SELECT COUNT ("hobby_id") FROM "person_hobby";

SELECT "hobby"."description","person_hobby"."hobby_id", 
COUNT ("hobby_id") FROM "person_hobby"
JOIN "hobby" ON "hobby"."id"="person_hobby"."hobby_id"
GROUP BY "person_hobby"."hobby_id";


--Types of table relationships--
--one to one
--one to many (above)
--many to many


