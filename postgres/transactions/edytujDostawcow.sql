CREATE OR REPLACE FUNCTION wyswietlDostawcow() RETURNS 
TABLE(numer integer, nazwa character varying, adres character varying, telefon integer, email character varying, faks, integer)
AS
$body$

BEGIN

RETURN QUERY
  SELECT *
  FROM Dostawcy;


END
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION wyswietlDostawce(nr_dost integer) RETURNS 
TABLE(numer integer, nazwa character varying, adres character varying, telefon integer, email character varying, faks, integer)
AS
$body$

BEGIN

RETURN QUERY
  SELECT *
  FROM Dostawcy
  WHERE Dostawcy.numer = nr_dost;

END
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION edytujDostawce(nr_dost integer, nazwa character varying, adres character varying, telefon integer, email character varying, faks, integer) RETURNS integer
AS
$body$

BEGIN

  UPDATE Dostawcy
  SET Nazwa = nazwa
  WHERE Dostawcy.numer = nr_dost;

  UPDATE Dostawcy
  SET Adres = adres
  WHERE Dostawcy.numer = nr_dost;

  UPDATE Dostawcy
  SET Telefon = telefon
  WHERE Dostawcy.numer = nr_dost;

  UPDATE Dostawcy
  SET Email = email
  WHERE Dostawcy.numer = nr_dost;

  UPDATE Dostawcy
  SET Faks = faks
  WHERE Dostawcy.numer = nr_dost;

  RETURN 0;

END
$body$ LANGUAGE plpgsql;
