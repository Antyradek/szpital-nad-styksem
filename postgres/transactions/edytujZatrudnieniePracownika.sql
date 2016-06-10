CREATE OR REPLACE FUNCTION wyswietlZatrudnieniePracownika(nr_prac integer) RETURNS 
TABLE(imie character varying, nazwisko character varying, numer integer, data_ur date, rodz_umowy character varying, godz_tyg integer, okr_umowy integer, rozlicz_wynagr character varying)
AS
$body$

BEGIN

RETURN QUERY
  SELECT Osoby.Imie, Osoby.Nazwisko, Pracownicy.Numer, Pracownicy.Data_urodzenia, Zatrudnienia.Rodzaj_umowy_Typ, Zatrudnienia.Godziny_tygodniowo, Zatrudnienia.Okres_umowy, Zatrudnienia.Tryb_rozliczenia_wynagrodzenia 
  FROM Osoby, Pracownicy, Zatrudnienia
  WHERE Pracownicy.Numer = nr_prac
  AND Osoby.Numer = Pracownicy.Numer
  AND Pracownicy.Numer = Zatrudnienia.Pracownik_Numer;


END
$body$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION edytujZatrudnieniePracownika(nr_prac integer, godz_tyg integer, okr_umowy integer) RETURNS integer AS
$body$

BEGIN

  UPDATE Zatrudnienia
  SET Godziny_tygodniowo = godz_tyg
  WHERE Zatrudnienia.Pracownik_Numer = nr_prac;

  UPDATE Zatrudnienia
  SET Okres_umowy = okr_umowy
  WHERE Zatrudnienia.Pracownik_Numer = nr_prac;

  RETURN 0;

END
$body$ LANGUAGE plpgsql;
