CREATE OR REPLACE FUNCTION raportPacjenciHospitalizowani() RETURNS integer AS 
$body$
BEGIN

CREATE VIEW pacjenci_ambulatoryjni AS
SELECT Osoby.Imie, Osoby.Nazwisko, Osoby.Adres, Osoby.Telefon,
Pacjenci.Numer,Pacjenci.Data_urodzenia,Pacjenci.Plec,Pacjenci.Data_rejestracji,
Stan_cywilny_Typ,Lekarz_rodzinny_Numer, Hospitalizacje.Numer AS NrHospitalizacji, Hospitalizacje.Data_umieszczenia_na_oddziale, Hospitalizacje.Przewidywany_czas_pobytu, Hospitalizacje.Lozko_Numer AS NrLozka, Hospitalizacje_ambulatoryjne.Godzina_wizyty
FROM Osoby, Pacjenci, Hospitalizacje, Hospitalizacje_ambulatoryjne
WHERE Osoby.Numer = Pacjenci.Numer AND Pacjenci.Numer = Hospitalizacje.Pacjent_Numer AND Hospitalizacje_ambulatoryjne.Numer = Hospitalizacje.Numer;

RETURN 0;

END
$body$ LANGUAGE plpgsql;
