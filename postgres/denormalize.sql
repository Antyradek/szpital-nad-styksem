-- Zmiana tabeli w celach denormalizacji
-- PRE-JOIN Informacja o oddziale i pacjencie do wizyt

ALTER TABLE Wizyty 
	ADD COLUMN Oddzialy_Nazwa varchar(200),
	ADD COLUMN Oddzialy_Polozenie varchar(200),
	ADD COLUMN Osoby_Imie varchar(50),
	ADD COLUMN Osoby_Nazwisko varchar(50);
	
CREATE TRIGGER denorm_wizyty_trig
	AFTER INSERT ON Wizyty
	FOR EACH STATEMENT
	EXECUTE PROCEDURE denorm_wizyty();
