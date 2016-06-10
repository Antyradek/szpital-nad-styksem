CREATE OR REPLACE FUNCTION listaWizytPracownika() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW lista_wizyt_pracownika AS
  SELECT Pracownicy.Numer, Osoby.Imie, Osoby.Nazwisko, Wizyty.Data_i_godzina_wizyty
  FROM Pracownicy, Wizyty, Pacjenci, Osoby
  WHERE Wizyty.Pracownik_Numer = Pracownicy.Numer
  AND Wizyty.Pacjent_Numer = Pacjenci.Numer
  AND Osoby.Numer = Pacjenci.Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
