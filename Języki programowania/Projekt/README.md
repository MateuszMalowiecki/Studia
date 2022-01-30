# Nazwa projektu: 
Wyjątki

# Struktura projektu:
Struktura projektu jest wzorowana na strukturze oprogramowania TAPL. Składnia termów oraz typów jest zdefiniowana w pliku syntax.ml. Plik core.ml zawiera inferencję typów oraz ewaluator call-by-value, zaś plik main.ml odpowiada za odczytanie termów z pliku, obliczenie ich wartości i typów oraz wypisanie obliczonych informacji na konsoli. Oprócz tego projekt składa się z pliku Makefile służącego do kompilacji kodu oraz pliku test.f, zawierającego przykładowe testy projektu. Implementacja korzysta z parsera, pretty-printera oraz kodu administracyjnego oprogramowania TAPL.

# Kompilacja i uruchomienie kodu:
Do kompilacji kodu służy plik Makefile. Po rozpakowaniu projektu, kod można skompilować wykonując polecenie "make". Utworzy ono plik wykonywalny f. W celu wykonania testów należy podczas uruchamiania programu f podać mu jako argument plik z testami (np. plik test.f). Testy w pliku testowym powinny być termami. Poszczególne testy powinny być oddzielone średnikiem. Program po odczytaniu danego testu wypisze jego wynik w formacie: "<term> evals to: <term_evaluation_result> and has type: <term_type>", jeśli dany term da się otypować, lub "Expression does not have a type: <reason_why_term_does_not_have_type>" w przeciwnym przypadku.

# Zakres wykonania zadania:
Zaimplementowany został rachunek lambda wraz z liczbami naturalnymi, wyrażeniami boolowskimi, operatorem Fix, typem Unit oraz wyjątkami. Zaimplementowane zostały reguły ewaluacji oraz typowania dla tego rachunku.
