CREATE OR REPLACE FUNCTION wyswietlPracownikow() RETURNS 
TABLE(numer integer, imie character varying, nazwisko character varying, adres character varying, telefon integer, data_ur date, plec char, pesel integer, rodzaj_prac character varying)
AS
$body$

BEGIN

RETURN QUERY
  SELECT *
  FROM Osoby, Pracownicy
  WHERE Osoby.Numer = Pracownicy.Numer

END
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION wyswietlPracownika(nr_prac integer) RETURNS 
TABLE(numer integer, imie character varying, nazwisko character varying, adres character varying, telefon integer, data_ur date, plec char, pesel integer, rodzaj_prac character varying)
AS
$body$

BEGIN

RETURN QUERY
  SELECT *
  FROM Osoby, Pracownicy
  WHERE Pracownicy.Numer = nr_prac
  AND Pracownicy.Numer = Osoby.Numer;

END
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION utworzPracownika(nr_prac integer, imie character varying, nazwisko character varying, adres character varying, telefon integer, data_ur date, plec char, pesel integer, rodzaj_prac character varying) RETURNS integer
AS
$body$

BEGIN

  INSERT INTO Pracownicy
  VALUES (nr_prac, data_ur, plec, pesel, rodzaj_prac);

  INSERT INTO Osoby
  VALUES (nr_prac, imie, nazwisko, adres, telefon);

  RETURN 0;

END
$body$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION edytujPracownikaDaneOsobowe(nr_prac integer, in_imie character varying, in_nazwisko character varying, in_adres character varying, in_telefon integer, data_ur date, in_plec char, in_pesel integer) RETURNS integer
AS
$body$

BEGIN

  UPDATE Osoby
  SET Imie = in_imie
  WHERE Osoby.Numer = nr_prac;

  UPDATE Osoby
  SET Nazwisko = in_nazwisko
  WHERE Osoby.Numer = nr_prac;

  UPDATE Osoby
  SET Adres = in_adres
  WHERE Osoby.numer = nr_prac;

  UPDATE Osoby
  SET Telefon = in_telefon
  WHERE Osoby.numer = nr_prac;

  UPDATE Pracownicy
  SET Data_urodzenia = data_ur
  WHERE Pracownicy.numer = nr_prac;

  UPDATE Pracownicy
  SET Plec = in_plec
  WHERE Pracownicy.numer = nr_prac;

  UPDATE Pracownicy
  SET PESEL = in_pesel
  WHERE Pracownicy.numer = nr_prac;

  RETURN 0;

END
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION edytujRodzajPracownika(nr_prac integer, rodzaj_prac character varying) RETURNS integer
AS
$body$

BEGIN

  UPDATE Pracownicy
  SET Rodzaj_pracownika_Typ = rodzaj_prac
  WHERE Pracownicy.numer = nr_prac;

  RETURN 0;

END
$body$ LANGUAGE plpgsql;

