CREATE OR REPLACE FUNCTION wyszukajPracownikaDoswiadczenie(nr_prac integer, id_dosw integer) RETURNS 
TABLE(numer integer, imie character varying, nazwisko character varying, plec char, rodzaj_prac character varying, stanowisko character varying, nazwa_plac character varying, data_od date, data_do date)
AS
$body$

BEGIN

RETURN QUERY
  SELECT Pracownicy.Numer, Osoby.Imie, Osoby.Nazwisko, Pracownicy.Plec, Pracownicy.Rodzaj_pracownika_Typ, Doswiadczenia_zawodowe.Stanowisko, Doswiadczenia_zawodowe.Nazwa_placowki, Doswiadczenia_zawodowe.Data_od, Doswiadczenia_zawodowe.Data_do
  FROM Osoby, Pracownicy, Doswiadczenia_zawodowe
  WHERE Pracownicy.Numer = nr_prac
  AND Doswiadczenia_zawodowe.Id = id_dosw
  AND Osoby.Numer = Pracownicy.Numer
  AND Doswiadczenia_zawodowe.Pracownik_Numer = Pracownicy.Numer;

END
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION wyszukajPracownikaKwalifikacje(nr_prac integer, id_kwalif integer) RETURNS 
TABLE(numer integer, imie character varying, nazwisko character varying, plec char, rodzaj_prac character varying, nazwa character varying, data_zdobycia date, typ character varying, nazwa_inst character varying)
AS
$body$

BEGIN

RETURN QUERY
  SELECT Pracownicy.Numer, Osoby.Imie, Osoby.Nazwisko, Kwalifikacje.Nazwa, Kwalifikacje.Data_zdobycia, Kwalifikacje.Typ, Kwalifikacje.Nazwa_Instytucji
  FROM Osoby, Pracownicy, Kwalifikacje
  WHERE Pracownicy.Numer = nr_prac
  AND Kwalifikacje.Id = id_kwalif
  AND Osoby.Numer = Pracownicy.Numer
  AND Kwalifikacje.Pracownik_Numer = Pracownicy.Numer;

END
$body$ LANGUAGE plpgsql;


