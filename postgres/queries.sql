-- 3. Pobranie listy pracowników ze szczegółowymi danymi dla danego oddziału.
CREATE VIEW lista_pracownikow_oddzialu AS
	SELECT Pracownicy.Numer AS NrPracownika, Osoby.Imie, Osoby.Nazwisko, Oddzialy.Numer, Oddzialy.Nazwa, Oddzialy.Polozenie, Oddzialy.Numer_wewnetrzny
	FROM Pracownicy, Osoby, Oddzialy, Pracownicy_na_oddziale
	WHERE Pracownicy.Numer = Pracownicy_na_oddziale.Pracownik_Numer
AND Pracownicy_na_oddziale.Oddzial_Numer = Oddzialy.Numer
AND Osoby.Numer = Pracownicy.Numer;

-- 5. Tworzenie i przechowywanie szczegółowych informacji o pacjentach ambulatoryjnych.
CREATE VIEW pacjenci_ambulatoryjni AS
	SELECT Osoby.Imie, Osoby.Nazwisko, Osoby.Adres, Osoby.Telefon,
Pacjenci.Numer,Pacjenci.Data_urodzenia,Pacjenci.Plec,Pacjenci.Data_rejestracji,
Stan_cywilny_Typ,Lekarz_rodzinny_Numer, Hospitalizacje.Numer AS NrHospitalizacji, Hospitalizacje.Data_umieszczenia_na_oddziale, Hospitalizacje.Przewidywany_czas_pobytu, Hospitalizacje.Lozko_Numer AS NrLozka, Hospitalizacje_ambulatoryjne.Godzina_wizyty
	FROM Osoby, Pacjenci, Hospitalizacje, Hospitalizacje_ambulatoryjne
	WHERE Osoby.Numer = Pacjenci.Numer AND Pacjenci.Numer = Hospitalizacje.Pacjent_Numer AND Hospitalizacje_ambulatoryjne.Numer = Hospitalizacje.Numer;
