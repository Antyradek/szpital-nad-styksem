CREATE OR REPLACE FUNCTION wyszukajWizytePacjenta(in int) RETURNS integer AS 
$body$
BEGIN

CREATE VIEW wizyty_pacjenta AS
  SELECT Pajenci.Numer, Pacjenci.Data_urodzenia, Pacjenci.Plec, Wizyty.Numer, Wizyty.Data_i_godzina_wizyty, Wizyty.Numer_gabinetu, Osoby.Numer, Osoby.Imie, Osoby.Nazwisko, Osoby.Telefon
  FROM Osoby, Wizyty, Pracownicy, Pacjenci
  WHERE Pacjenci.Numer = $1
  AND Wizyty.Pacjent_Numer = Pacjenci.Numer
  AND Wizyty.Pracownik_Numer = Pracownicy.Numer
  AND Pracownicy.Numer = Osoby.Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
