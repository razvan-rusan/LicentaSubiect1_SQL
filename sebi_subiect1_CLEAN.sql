CREATE SCHEMA marti_cu_david;

drop table if exists marti_cu_david.Roles;

-- b) crearea tabelelor
CREATE TABLE marti_cu_david.Roles (
                                  id int not null primary key identity,
                                  rol NVARCHAR(20)
)

INSERT INTO marti_cu_david.Roles VALUES ('autor'), ('cititor');

drop table if exists marti_cu_david.Users;

CREATE TABLE marti_cu_david.Users (
                                  id int not null primary key identity,
                                  nume NVARCHAR(20),
                                  parola NVARCHAR(20),
                                  id_rol int not null foreign key references marti_cu_david.Roles(id)
)

DELETE FROM marti_cu_david.Users;
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Mihai Criste', N'xohoaho', 1);
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Matei Labo', N'oaugwuohn', 2);
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Cristian Bălănean', N'wibibqopmwr', 1);
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Daria Pușcaș', N'qpiihwiron', 2);
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Alexandra Iovan', N'qoi0hwiurh', 1);
INSERT INTO pregatire_licenta.marti_cu_david.Users (nume, parola, id_rol) VALUES (N'Antonia Căprar', N'pqinuwrbqipjroșwț', 2);


drop table if exists marti_cu_david.Articole;

CREATE TABLE marti_cu_david.Articole (
                                     id int not null primary key identity,
                                     id_autor int not null foreign key references marti_cu_david.Users(id),
                                     titlu NVARCHAR(40),
                                     continut nvarchar(max)
)

DROP TABLE marti_cu_david.Articole;
DELETE FROM marti_cu_david.Articole;
INSERT INTO pregatire_licenta.marti_cu_david.Articole (id_autor, titlu, continut) VALUES (1, N'Despre Viața Câinilor', N'Orice câine e bine să aibă și un stăpân.');
INSERT INTO pregatire_licenta.marti_cu_david.Articole (id_autor, titlu, continut) VALUES (3, N'Primul Meu Joc Video', N'Am făcut șah cu reguli schimbate');
INSERT INTO pregatire_licenta.marti_cu_david.Articole (id_autor, titlu, continut) VALUES (5, N'Fenomenul Affogato: Ce Trebuie Să Știi', N'Affogato e un glob de înghețată care plutește într-o cană de espresso. Nu poți să îi reziști.');
INSERT INTO pregatire_licenta.marti_cu_david.Articole (id_autor, titlu, continut) VALUES (3, N'Al Doilea Meu Joc Video', N'Mi-am luat țeapă că am pus un joc cu mașini pe Android App Store și nu l-a jucat nimeni.');
INSERT INTO pregatire_licenta.marti_cu_david.Articole (id_autor, titlu, continut) VALUES (3, N'Casa Mea De La Țară', N'Brebi este un sat foarte frumos și verde.');

drop table if exists marti_cu_david.Comentarii;

CREATE TABLE marti_cu_david.Comentarii (
                                       id int not null primary key identity,
                                       id_autor int not null foreign key references marti_cu_david.Users(id),
                                       id_articol int not null foreign key references marti_cu_david.Articole(id),
                                       continut nvarchar(600)
)

DELETE * FROM marti_cu_david.Comentarii;
INSERT INTO pregatire_licenta.marti_cu_david.Comentarii (id_autor, id_articol, continut) VALUES (1, 2, N'Nu îmi place!');
INSERT INTO pregatire_licenta.marti_cu_david.Comentarii (id_autor, id_articol, continut) VALUES (2, 3, N'Merge.');
INSERT INTO pregatire_licenta.marti_cu_david.Comentarii (id_autor, id_articol, continut) VALUES (3, 4, N'Am citit unul mai bun');


CREATE TABLE marti_cu_david.Note (
                                 id int not null primary key identity,
                                 id_articol int not null references marti_cu_david.Articole(id),
                                 nota int not null,
                                 --nota float
)

DELETE FROM marti_cu_david.Note;
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 5);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 4);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 3);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 3);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 5);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (1, 2);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (2, 1);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (2, 1);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (2, 3);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (3, 4);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (3, 5);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (4, 2);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (4, 5);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (4, 3);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (4, 2);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (5, 1);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (5, 2);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (5, 4);
INSERT INTO pregatire_licenta.marti_cu_david.Note (id_articol, nota) VALUES (5, 3);

-- c) media notelor unui articol
select titlu, cast(avg(cast(nota as float)) as decimal(3,2)) as nota
from marti_cu_david.Articole INNER JOIN marti_cu_david.Note
                                    ON Articole.id = Note.id_articol
GROUP BY titlu
ORDER BY avg(nota) DESC

-- select avg(Note.nota), Articole.titlu from marti_cu_david.Note
-- JOIN marti_cu_david.Articole ON Note.id_articol = Articole.id
-- GROUP BY titlu
-- ORDER BY avg(nota) DESC


-- d) autorii in ordine descrescatoare a nr de articole publicate
select nume, count(distinct Articole.id) as articole_publicate from marti_cu_david.Users INNER JOIN marti_cu_david.Articole
                                                                                                ON Users.id = Articole.id_autor
GROUP BY nume
ORDER BY articole_publicate DESC

select Users.id, Users.nume, count(Articole.id) from marti_cu_david.Users JOIN marti_cu_david.Articole
ON Users.id = Articole.id_autor
group by Users.id, Users.nume
order by count(Articole.id) DESC

-- e) articolele fara comentarii
select * from marti_cu_david.Articole left join marti_cu_david.Comentarii
                                            on Comentarii.id_articol = Articole.id
where Comentarii.id is null

select Articole.id, Articole.titlu from marti_cu_david.Articole left join marti_cu_david.Comentarii
on Articole.id = Comentarii.id_articol
group by Articole.id, Articole.titlu
having count(Comentarii.id_articol) = 0