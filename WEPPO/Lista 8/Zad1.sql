CREATE table person (
  id PRIMARY KEY,
  personname varchar(100), ...
)
CREATE SEQUENCE seq;
select(NEXTVAL('seq'));
INSERT into OSOBA (id, name, surname, gender) VALUES (nextval('seq'), "Foo", "Bar", false);
DROP SEQUENCE seq;
SELECT * FROM OSOBA WHERE name = 'Foo'
CREATE TABLE books (
  id              SERIAL PRIMARY KEY,
  title           VARCHAR(100) NOT NULL,
  primary_author  VARCHAR(100) NULL
);

INSERT INTO public."books" (title, primary_author)
VALUES ('Foo2', 'Bar2');
INSERT INTO public."books" (title, primary_author)
VALUES ('Foo', 'Bar');
SELECT * FROM books WHERE name='foo' ...;
