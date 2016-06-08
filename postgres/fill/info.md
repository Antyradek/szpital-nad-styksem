WAŻNE!
Daty są w formacie: 1/18/1999 (m/d/y)

- Osoby = 15000
	- Lekarze_rodzinni = 2500 (1:2500)
	- Pracownicy = 2500 (2501:5000)
	- Pacjenci = 10000 (5001:15000)


- Doswiadczenia_zawodowe = 4500

- Kwalifikacje = 3500 (niektory pracownik moze miec wiecej)

- Zatrudnienia = 2500 (1:1 dla każdego pracownika)

- Pokrewienstwa = 220 (pomiedzy pacjentami, a pracownikami szpitala)


- Wizyty = 17000
	- Data_i_godzina_wizyty (od 05:00:00 do 23:00:00)
	- Numer_gabinetu (od 1 do 500)

- Pacjenci_oczekujacy = 3000

- Oddzialy = 40
	- Numer_wewnetrzny (od 100 do 999)

- Lozka = 4000
	- (docelowo 100 lozek na jeden oddzial, ale funkcja random to inaczej rozdystrybuuje)

- Pracownicy na oddziale = 1600

- Dostawcy = 100

- Materialy = 6500

- Dostawy = 2000

- Leki = 3500

- Dozowania leku = 7000
	- (czas podania jako liczba milisekund od polnocy)

- Formularze zapotrzebowania = 320

- Pozycje zamowienia = 5000

- Hospitalizacje = 1300

- Hospitalizacje ambulatoryjne = 550




Aplikacja Process - służy to przetwarzania danych tak, aby pasowały do bazy danych.

Poniższa komenda (opcja 4 w moim programie) przetwarza pierwszą (indeks 0) kolumnę pliku fillPacjenciOczekujacy.sql, 
generuje plik wyjściowy fillPacjenciOczekujacy2.sql. Wartości z pierwszej kolumny są zastąpione
wartościami UNIKALNYMI w zasięgu od 5000 do 15000 w liczbie 3000.

java Process fillPacjenciOczekujacy.sql 4 fillPacjenciOczekujacy2.sql 3000 5000 15000 0 


Poniższa komenda robi to samo, co powyżej, tylko generuje unikalne wartości w liczbie 2000 od 1 do 6500 dla trzeciej (indeks 2)
kolumny w pliku.

java Process fillDostawy.sql 4 fillDostawy2.sql 2000 1 6500 2


