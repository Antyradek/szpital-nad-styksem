-- Tworzenie struktury bazy oraz pozniejsze nakladanie kluczy obcych

CREATE TABLE Osoby (
Numer integer,
Imie varchar(50) NOT NULL,
Nazwisko varchar(50) NOT NULL,
Adres varchar(150),
Telefon integer,
CONSTRAINT Osoba_PK PRIMARY KEY(Numer)
);

CREATE TABLE Pokrewienstwa (
Typ_pokrewienstwa_Typ varchar(20) NOT NULL,
Pacjent_Numer integer NOT NULL,
Osoba_Numer integer NOT NULL,
CONSTRAINT Pokrewienstwo_PK PRIMARY KEY(Typ_pokrewienstwa_Typ, Pacjent_Numer, Osoba_Numer)
);

CREATE TABLE Typy_pokrewienstwa (
Typ varchar(20) NOT NULL,
CONSTRAINT Typy_pokrewienstwa_PK PRIMARY KEY (Typ)
);

CREATE TABLE Lekarze_rodzinni (
Numer integer NOT NULL,
Nr_praktyki integer NOT NULL,
CONSTRAINT Lekarz_rodzinny_PK PRIMARY KEY (Numer)
);

CREATE TABLE Pacjenci (
Numer integer NOT NULL,
Data_urodzenia date NOT NULL,
Plec char NOT NULL,
Data_rejestracji date,
Stan_cywilny_Typ varchar(10) NOT NULL,    
Lekarz_rodzinny_Numer integer NOT NULL,
CONSTRAINT Pacjent_PK PRIMARY KEY (Numer)
);

CREATE TABLE Stany_cywilne (
Typ varchar(15) NOT NULL,
CONSTRAINT Stan_cywilny_PK PRIMARY KEY (Typ)
);

CREATE TABLE Pacjenci_oczekujacy (
Pacjent_Numer integer NOT NULL,
Data_umieszczenia date NOT NULL,
Oddzial_Numer integer NOT NULL,
CONSTRAINT Pacjent_oczekujacy_PK PRIMARY KEY (Pacjent_Numer)
);

CREATE TABLE Dozowania_leku (
Liczba_jednostek_na_dobe integer NOT NULL,
Data_poczatkowa date NOT NULL,
Data_koncowa date NOT NULL,
Lek_Numer integer NOT NULL,
Pacjent_Numer integer NOT NULL,
Czas_podania integer NOT NULL,
CONSTRAINT Dozowanie_leku_PK PRIMARY KEY (Lek_Numer, Pacjent_Numer)
);

CREATE TABLE Leki (
Numer integer NOT NULL,
Dawkowanie varchar(1000) NOT NULL,
Sposob_podawania varchar(2000) NOT NULL,
CONSTRAINT Lek_PK PRIMARY KEY (Numer)
);

CREATE TABLE Materialy (
Numer integer NOT NULL,
Nazwa varchar(400) NOT NULL,
Opis varchar(3000) NOT NULL,
Ilosc_w_magazynie integer NOT NULL,
CONSTRAINT Material_PK PRIMARY KEY (Numer)
);

CREATE TABLE Dostawy (
Ilosc integer NOT NULL,
Koszt_jednostkowy numeric(6,2) NOT NULL,
Material_Numer integer NOT NULL,
Dostawca_Numer integer NOT NULL,
CONSTRAINT Dostawa_PK PRIMARY KEY (Material_Numer, Dostawca_Numer)
);

CREATE TABLE Dostawcy (
Numer integer NOT NULL,
Nazwa varchar(300) NOT NULL,
Adres varchar(200) NOT NULL,
Telefon integer NOT NULL,
Email varchar(100) NOT NULL,
Faks integer,
CONSTRAINT Dostawca_PK PRIMARY KEY (Numer)
);

CREATE TABLE Wizyty (
Numer integer NOT NULL,
Data_i_godzina_wizyty date NOT NULL,
Numer_gabinetu integer NOT NULL,
Pacjent_Numer integer NOT NULL,
Pracownik_Numer integer NOT NULL,
CONSTRAINT Wizyta_PK PRIMARY KEY (Numer)
);

CREATE TABLE Hospitalizacje (
Numer integer NOT NULL,
Data_umieszczenia_na_oddziale date NOT NULL,
Przewidywany_czas_pobytu integer NOT NULL,
Faktyczna_data_wypisania date,
Pacjent_Numer integer NOT NULL,
Lozko_Numer integer NOT NULL,
CONSTRAINT Hospitalizacja_PK PRIMARY KEY (Numer)
);

CREATE TABLE Hospitalizacje_ambulatoryjne (
Numer integer NOT NULL, 
Godzina_wizyty time NOT NULL,
CONSTRAINT Hospitalizacja_ambulatoryjna_PK PRIMARY KEY (Numer)
);

CREATE TABLE Lozka (
Numer integer NOT NULL, 
Oddzial_Numer integer NOT NULL,
CONSTRAINT Lozko_PK PRIMARY KEY (Numer)
);

CREATE TABLE Oddzialy (
Numer integer NOT NULL, 
Nazwa varchar(200) NOT NULL,
Polozenie varchar(200) NOT NULL,
Numer_wewnetrzny integer NOT NULL,
CONSTRAINT Oddzial_PK PRIMARY KEY (Numer)
);

CREATE TABLE Formularze_zapotrzebowania (
Numer integer NOT NULL, 
Data_zgloszenia date NOT NULL,
Data_otrzymania date,
Pracownik_Numer integer NOT NULL,
Oddzial_Numer integer,
CONSTRAINT Formularz_zapotrzebowania_PK PRIMARY KEY (Numer)
);

CREATE TABLE Pozycje_zamowienia (
Liczba integer NOT NULL,
Material_Numer integer NOT NULL,
Formularz integer NOT NULL,
CONSTRAINT Pozycja_zamowienia_PK PRIMARY KEY (Material_Numer,Formularz)
);

CREATE TABLE Pracownicy (
Numer integer NOT NULL,
Data_urodzenia date NOT NULL,
Plec char NOT NULL,
PESEL integer,
Rodzaj_pracownika_Typ varchar(50) NOT NULL,    
CONSTRAINT Pracownik_PK PRIMARY KEY (Numer)
);

CREATE TABLE Rodzaje_pracownikow (
Typ varchar(50),
CONSTRAINT Rodzaje_pracownikow_PK PRIMARY KEY (Typ)    
);

CREATE TABLE Zatrudnienia (
Id integer NOT NULL,
Godziny_tygodniowo integer NOT NULL,
Okres_umowy integer NOT NULL,
Tryb_rozliczenia_wynagrodzenia varchar(100) NOT NULL,
Rodzaj_umowy_Typ varchar(100) NOT NULL,
Pracownik_Numer integer NOT NULL,
CONSTRAINT Zatrudnienia_PK PRIMARY KEY (Id)
);

CREATE TABLE Pracownicy_na_oddziale (
Pracownik_Numer integer NOT NULL,
Oddzial_Numer integer NOT NULL,
CONSTRAINT Pracownicy_na_oddziale_PK PRIMARY KEY (Pracownik_Numer, Oddzial_Numer)
);

CREATE TABLE Rodzaje_umowy (
Typ varchar(50),
CONSTRAINT Rodzaje_umowy_PK PRIMARY KEY (Typ)    
);

CREATE TABLE Kwalifikacje (
Id integer NOT NULL,
Nazwa varchar(200) NOT NULL,
Data_zdobycia date NOT NULL,
Typ varchar(100) NOT NULL,
Nazwa_instytucji varchar(100) NOT NULL,
Pracownik_Numer integer NOT NULL,
CONSTRAINT Kwalifikacje_PK PRIMARY KEY (Id)
);

CREATE TABLE Doswiadczenia_zawodowe (
Id integer,
Stanowisko varchar(200) NOT NULL,
Nazwa_placowki varchar(400),
Data_od date,
Data_do date,
Pracownik_Numer integer NOT NULL,
CONSTRAINT Doswiadczenia_zawodowe_PK PRIMARY KEY (Id)
);


-- nakladanie wszystkich kluczy obcych

-- 3 Pokrewienstwa
ALTER TABLE Pokrewienstwa
	ADD CONSTRAINT Pokrewienstwo_Typ_Pokrewienstwa_FK
	FOREIGN KEY (Typ_Pokrewienstwa_Typ)
	REFERENCES Typy_pokrewienstwa(Typ);

ALTER TABLE Pokrewienstwa
	ADD CONSTRAINT Pokrewienstwo_Pacjent_FK
	FOREIGN KEY (Pacjent_Numer)
	REFERENCES Pacjenci(Numer);

ALTER TABLE Pokrewienstwa
	ADD CONSTRAINT Pokrewienstwo_Osoba_FK
	FOREIGN KEY (Osoba_Numer)
	REFERENCES Osoby(Numer);

-- 4 Lekarze_rodzinni
ALTER TABLE Lekarze_rodzinni
	ADD CONSTRAINT Lekarz_rodzinny_Osoba_FK
	FOREIGN KEY (Numer)
	REFERENCES Osoby(Numer);

-- 6 Dostawy
ALTER TABLE Dostawy
	ADD CONSTRAINT Dostawa_Dostawca_FK
	FOREIGN KEY (Dostawca_Numer)
	REFERENCES Dostawcy(Numer);

ALTER TABLE Dostawy
	ADD CONSTRAINT Material_Dostawca_FK
	FOREIGN KEY (Material_Numer)
	REFERENCES Materialy(Numer);

-- 8 Dozowania_leku
ALTER TABLE Dozowania_leku
	ADD CONSTRAINT Dozowanie_leku_Pacjent_FK
	FOREIGN KEY (Pacjent_Numer)
	REFERENCES Pacjenci(Numer);

ALTER TABLE Dozowania_leku
	ADD CONSTRAINT Dozowanie_leku_Lek_FK
	FOREIGN KEY (Lek_Numer)
	REFERENCES Leki(Numer);

-- 11 Pacjenci
ALTER TABLE Pacjenci
	ADD CONSTRAINT Pacjent_Osoba_FK
	FOREIGN KEY (Numer)
	REFERENCES Osoby(Numer);

ALTER TABLE Pacjenci
	ADD CONSTRAINT Pacjent_Lekarz_rodzinny_FK
	FOREIGN KEY (Lekarz_rodzinny_Numer)
	REFERENCES Lekarze_rodzinni(Numer);

ALTER TABLE Pacjenci
	ADD CONSTRAINT Pacjent_Stan_cywilny_FK
	FOREIGN KEY (Stan_cywilny_Typ)
	REFERENCES Stany_cywilne(Typ);

-- 12 Hospitalizacje_ambulatoryjne
ALTER TABLE Hospitalizacje_ambulatoryjne
	ADD CONSTRAINT Hospitalizacja_ambulatoryjna_Hospitalizacja_FK
	FOREIGN KEY (Numer)
	REFERENCES Hospitalizacje(Numer);

-- 14 Hospitalizacje
ALTER TABLE Hospitalizacje
	ADD CONSTRAINT Hospitalizacja_Pacjent_FK
	FOREIGN KEY (Pacjent_Numer)
	REFERENCES Pacjenci(Numer);

ALTER TABLE Hospitalizacje
	ADD CONSTRAINT Hospitalizacja_Lozko_FK
	FOREIGN KEY (Lozko_Numer)
	REFERENCES Lozka(Numer);

-- 16 Pacjenci_oczekujacy
ALTER TABLE Pacjenci_oczekujacy
	ADD CONSTRAINT Pacjent_oczekujacy_Odzial_FK
	FOREIGN KEY (Oddzial_Numer)
	REFERENCES Oddzialy(Numer);

ALTER TABLE Pacjenci_oczekujacy
	ADD CONSTRAINT Pacjent_oczekujacy_Pacjent_FK
	FOREIGN KEY (Pacjent_Numer)
	REFERENCES Pacjenci(Numer);

-- 18 Wizyty
ALTER TABLE Wizyty
	ADD CONSTRAINT Wizyta_Pacjent_FK
	FOREIGN KEY (Pacjent_Numer)
	REFERENCES Pacjenci(Numer);

ALTER TABLE Wizyty
	ADD CONSTRAINT Wizyta_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);

-- 19 Lozka
ALTER TABLE Lozka
	ADD CONSTRAINT Lozko_Oddzial_FK
	FOREIGN KEY (Oddzial_Numer)
	REFERENCES Oddzialy(Numer);


-- 21 Pracownicy_na_oddziale
ALTER TABLE Pracownicy_na_oddziale
	ADD CONSTRAINT Pracownicy_na_oddziale_Oddzial_FK
	FOREIGN KEY (Oddzial_Numer)
	REFERENCES Oddzialy(Numer);

ALTER TABLE Pracownicy_na_oddziale
	ADD CONSTRAINT Pracownicy_na_oddziale_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);

-- 23 Pracownicy
ALTER TABLE Pracownicy
	ADD CONSTRAINT Pracownik_Osoba_FK
	FOREIGN KEY (Numer)
	REFERENCES Osoby(Numer);

ALTER TABLE Pracownicy
	ADD CONSTRAINT Pracownik_Rodzaj_pracownika_FK
	FOREIGN KEY (Rodzaj_pracownika_Typ)
	REFERENCES Rodzaje_pracownikow(Typ);

-- 25 Zatrudnienia
ALTER TABLE Zatrudnienia
	ADD CONSTRAINT Zatrudnienie_Rodzaj_umowy_FK
	FOREIGN KEY (Rodzaj_umowy_Typ)
	REFERENCES Rodzaje_umowy(Typ);

ALTER TABLE Zatrudnienia
	ADD CONSTRAINT Zatrudnienie_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);

-- 26 Kwalifikacje
ALTER TABLE Kwalifikacje
	ADD CONSTRAINT Kwalifikacja_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);

-- 27 Doswiadczenia_zawodowe
ALTER TABLE Doswiadczenia_zawodowe
	ADD CONSTRAINT Doswiadczenie_zawodowe_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);

-- 29 Formularze_zapotrzebowania
ALTER TABLE Formularze_zapotrzebowania
	ADD CONSTRAINT Formularz_zapotrzebowania_Oddzial_FK
	FOREIGN KEY (Oddzial_Numer)
	REFERENCES Oddzialy(Numer);

ALTER TABLE Formularze_zapotrzebowania
	ADD CONSTRAINT Formularz_zapotrzebowania_Pracownik_FK
	FOREIGN KEY (Pracownik_Numer)
	REFERENCES Pracownicy(Numer);


-- 31 Pozycje_zamowienia
ALTER TABLE Pozycje_zamowienia
	ADD CONSTRAINT Pozycja_zamowienia_Material_FK
	FOREIGN KEY (Material_Numer)
	REFERENCES Materialy(Numer);

ALTER TABLE Pozycje_zamowienia
	ADD CONSTRAINT Pozycja_zamowienia_Formularze_Zapotrzebowania_FK
	FOREIGN KEY (Formularz)
	REFERENCES Formularze_Zapotrzebowania(Numer);

-- 32 Leki
ALTER TABLE Leki
	ADD CONSTRAINT Lek_Material_FK
	FOREIGN KEY (Numer)
	REFERENCES Materialy(Numer);









