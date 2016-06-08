Tutaj jest kilka plików SQL do zabawy z bazą.
Zainstaluj bazę PostgreSQL i skonfiguruj siebie jako administratora.
Następnie idź do wiersza poleceń i podaj odpowiedni plik.
$ psql szpital-nad-styksem -f create.sql
$ psql szpital-nad-styksem -f drop.sql

Jeśli nazwa twojego użytkownika jest inna od administratora bazy, to dodaj jeszcze
-U <użytkownik>
do powyższych komend.


- JAK ZROBIĆ, ŻEBY DZIAŁAŁO:

psql -U postgres
\c szpital-nad-styksem
ALTER DATABASE "szpital-nad-styksem" SET datestyle TO "ISO, MDY";
\i create.sql
./fill.sh


- Skrypty:

1) Tworzenie tabeli, kluczy glownych, kluczy obcych:
\i create.sql

2) Usuwanie tabeli wraz z widokami (Opcja CASCADE)
\i drop.sql

3) Dodawanie przykladowych transakcji z zadania:
\i queries.sql

4) Wypełnianie tabeli (z shella):
./fill.sh


- USTAWIANIE FORMATU DATY W POSTGRESIE (dane wygenerowalem w formacie MDY):

tymczasowe (nie dziala, jak chcemy wklepytac z shella skrypty):
SET datestyle TO "ISO, MDY";
SHOW datestyle;
pelne (skrypty z shella dzialaja)
ALTER DATABASE "szpital-nad-styksem" SET datestyle TO "ISO, MDY";



