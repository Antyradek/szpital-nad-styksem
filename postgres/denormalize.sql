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

-- PRE-JOIN Informacja o Pacjencie i Oddziale do Wizyt Oczekujących
ALTER TABLE Pacjenci_Oczekujacy
	ADD COLUMN Pacjent_Imie varchar(50),
	ADD COLUMN Pacjent_Nazwisko varchar(50),
	ADD COLUMN Oddzial_Nazwa varchar(200),
	ADD COLUMN Oddzial_Polozenie varchar(200);

CREATE OR REPLACE FUNCTION denorm_pacjenci_oczekujacy() RETURNS TRIGGER AS
$denorm_pacjenci_oczekujacy$
BEGIN
	SELECT Osoby.Imie,Osoby.Nazwisko INTO NEW.Pacjent_Imie,NEW.Pacjent_Nazwisko
		FROM Osoby WHERE NEW.Pacjent_numer = Osoby.Numer;
	SELECT Oddzialy.Nazwa,Oddzialy.Polozenie INTO NEW.Oddzial_Nazwa,NEW.Oddzial_Polozenie
		FROM Oddzialy WHERE NEW.Oddzial_Numer = Oddzialy.Numer;
	RETURN NEW;
END;
$denorm_pacjenci_oczekujacy$
LANGUAGE plpgsql;

CREATE TRIGGER denorm_pacjenci_oczekujacy_trig
BEFORE INSERT OR UPDATE ON Pacjenci_Oczekujacy
FOR EACH ROW
EXECUTE PROCEDURE denorm_pacjenci_oczekujacy();

-- PRE-JOIN Informacje o pacjencie i nazwa leku do dawkowania
ALTER TABLE Dozowania_Leku
	ADD COLUMN Pacjent_Imie varchar(50),
	ADD COLUMN Pacjent_Nazwisko varchar(50),
	ADD COLUMN Materialy_Nazwa varchar(400),
	ADD COLUMN Materialy_Opis varchar(3000);

CREATE OR REPLACE FUNCTION denorm_dozowania_leku() RETURNS TRIGGER AS
$denorm_dozowania_leku$
BEGIN
	SELECT Osoby.Imie,Osoby.Nazwisko INTO NEW.Pacjent_Imie,NEW.Pacjent_Nazwisko
		FROM Osoby WHERE NEW.Pacjent_numer = Osoby.Numer;
	SELECT Materialy.Nazwa,Materialy.Opis INTO NEW.Materialy_Nazwa,NEW.Materialy_Opis
		FROM Materialy WHERE NEW.Lek_Numer = Materialy.Numer;
	RETURN NEW;
END;
$denorm_dozowania_leku$
LANGUAGE plpgsql;

CREATE TRIGGER denorm_dozowania_leku_trig
BEFORE INSERT OR UPDATE ON Dozowania_Leku
FOR EACH ROW
EXECUTE PROCEDURE denorm_dozowania_leku();

-- Kolumna agregująca ceny formularzy
ALTER TABLE Formularze_Zapotrzebowania
	ADD COLUMN Suma_zamowienia numeric(12,2) DEFAULT 0 NOT NULL;

CREATE OR REPLACE FUNCTION agreguj_formularze_zapotrzebowania() RETURNS TRIGGER AS
$agreguj_formularze_zapotrzebowania$
DECLARE
	koszt_jedn_stary numeric(12,2);
	koszt_jedn numeric(12,2);
BEGIN
	IF (TG_OP = 'DELETE') THEN
		SELECT Dostawy.Koszt_jednostkowy INTO koszt_jedn_stary
			FROM Dostawy WHERE OLD.Material_Numer = Dostawy.Material_Numer;
		UPDATE Formularze_Zapotrzebowania SET Suma_zamowienia = Suma_zamowienia - koszt_jedn_stary * OLD.Liczba
			WHERE OLD.Formularz = Formularze_Zapotrzebowania.Numer;
		RETURN NULL;
	END IF;
	IF (TG_OP = 'UPDATE') THEN
		SELECT Dostawy.Koszt_jednostkowy INTO koszt_jedn_stary
			FROM Dostawy WHERE OLD.Material_Numer = Dostawy.Material_Numer;
		UPDATE Formularze_Zapotrzebowania SET Suma_zamowienia = Suma_zamowienia - koszt_jedn_stary * OLD.Liczba
			WHERE OLD.Formularz = Formularze_Zapotrzebowania.Numer;
	END IF;
	SELECT Dostawy.Koszt_jednostkowy INTO koszt_jedn
		FROM Dostawy WHERE NEW.Material_Numer = Dostawy.Material_Numer;
	UPDATE Formularze_Zapotrzebowania SET Suma_zamowienia = Suma_zamowienia + koszt_jedn * NEW.Liczba
		WHERE NEW.Formularz = Formularze_Zapotrzebowania.Numer;
	RETURN NEW;
END;
$agreguj_formularze_zapotrzebowania$
LANGUAGE plpgsql;

CREATE TRIGGER agreguj_formularze_zapotrzebowania_trig
AFTER INSERT OR UPDATE OR DELETE ON Pozycje_zamowienia
FOR EACH ROW
EXECUTE PROCEDURE agreguj_formularze_zapotrzebowania();

-- Dekodowanie godziny z liczby minut na dwa pola godziny i minuty
ALTER TABLE Dozowania_Leku
	ADD COLUMN Godzina_podania integer,
	ADD COLUMN Minuta_podania integer;

CREATE OR REPLACE FUNCTION dekoduj_dozowania_leku() RETURNS TRIGGER AS
$dekoduj_dozowania_leku$
BEGIN
	NEW.Godzina_podania = NEW.Czas_podania / 60 % 12;
	NEW.Minuta_podania = NEW.Czas_podania % 60;
	RETURN NEW;
END;
$dekoduj_dozowania_leku$
LANGUAGE plpgsql;

CREATE TRIGGER dekoduj_dozowania_leku_trig
BEFORE INSERT OR UPDATE ON Dozowania_Leku
FOR EACH ROW
EXECUTE PROCEDURE dekoduj_dozowania_leku();
