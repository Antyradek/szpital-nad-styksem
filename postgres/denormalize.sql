-- Zmiana tabeli w celach denormalizacji
-- PRE-JOIN Informacja o Imieniu pacjenta i Pracownika do wizyt.

ALTER TABLE Wizyty
	ADD COLUMN Pacjent_Imie varchar(50),
	ADD COLUMN Pacjent_Nazwisko varchar(50),
	ADD COLUMN Pracownik_Imie varchar(50),
	ADD COLUMN Pracownik_Nazwisko varchar(50);
	
CREATE OR REPLACE FUNCTION denorm_wizyty() RETURNS TRIGGER AS
$denorm_wizyty$
BEGIN
	SELECT Osoby.Imie,Osoby.Nazwisko INTO NEW.Pacjent_Imie,NEW.Pacjent_Nazwisko 
		FROM Osoby WHERE NEW.Pacjent_numer = Osoby.Numer;
	SELECT Osoby.Imie,Osoby.Nazwisko INTO NEW.Pracownik_Imie,NEW.Pracownik_Nazwisko
		FROM Osoby WHERE NEW.Pracownik_Numer = Osoby.Numer;
	RETURN NEW;
END;
$denorm_wizyty$
LANGUAGE plpgsql;
	
CREATE TRIGGER denorm_wizyty_trig
	BEFORE INSERT OR UPDATE ON Wizyty
	FOR EACH ROW
	EXECUTE PROCEDURE denorm_wizyty();
