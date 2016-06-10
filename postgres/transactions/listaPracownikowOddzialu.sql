CREATE OR REPLACE FUNCTION listaPracownikowOddzialu(nr_oddzialu integer) RETURNS 
TABLE(oddz_nazw character varying, imie character varying, nazwisko character varying, adres character varying, plec char, data_ur date, PESEL integer, telefon integer, rodz_prac character varying, nr_prac integer)
AS
$body$

BEGIN

RETURN QUERY
  SELECT Oddzialy.Nazwa, Osoby.Imie, Osoby.Nazwisko, Osoby.Adres, Pracownicy.Plec, Pracownicy.Data_urodzenia, Pracownicy.PESEL, Osoby.Telefon, Pracownicy.Rodzaj_pracownika_Typ, Pracownicy.Numer
  FROM Osoby, Oddzialy, Pracownicy, Pracownicy_na_oddziale
  WHERE Oddzialy.Numer = nr_oddzialu
  AND Pracownicy_na_oddziale.Oddzial_Numer = Oddzialy.Numer
  AND Pracownicy_na_oddziale.Pracownik_Numer = Pracownicy.Numer
  AND Pracownicy.Numer = Osoby.Numer;

END
$body$ LANGUAGE plpgsql;

