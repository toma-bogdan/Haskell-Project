//Toma Bogdan-Nicolae
//323CB

/*
		Task1:
	Prima data luam fiecare linie din tabel, fara numele acestora si calculam media pasilor
prin functiile:
	-sum_steps (care converteste din elementele listei din Strinng in float si calculeaza
suma acestora)
	-len (care intoarce lungimea listei) 
	-average care returneaza impartirea in forma de string
 	Apoi, prin functia zipWith unim numele perosanelor cu numarul mediu de pasi al
acestora.

		Task2:
	-get_passed_people_num = foloseste functia sum_steps descrisa mai sus si un foldr pentru a determina 
numarul persoanelor care au efectuat peste 1000 de pasi
	-get_passed_people_percentge = imparte numarul de persoane obtinut mai sus la totalul acestora
	-get_steps_avg = utilizand functia get_steps (calculeaza numarul de pasi al unei persoane) si foldr
se calculeaza nr mediu de pasi

		Task3:
	Calculam numarul mediu de pasi al unei ore folosind functia get_steps_per_h, apoi ne utilizam de
functia get_avg pentru a apela recursiv si a returna o lista cu pasii medii in pentru fiecare ora. In final,
concatenam lista obtinuta cu [H10, ... , H17]

		Task4:
	Avem functia get_active_minutes care calculeaza pasii unei persoane in una din cele 3 categorii
(Very, fairly si lightly active minutes) si o in incadreaza in range-ul corespunzator( 0-50, 50-100, 100-500).
	Pentru simplitate, functia de mai sus va fi apelata astfel incat primul element de pe fiecare linie
sa reprezinte categoria dorita.

		Task5:
	Sortam matricea phsysical_activity cu ajutorul functiei sortBy care primeste ca parametru functia
creata my_compare care compara doua persoane dupa numarul de pasi, respectiv dupa numele persoanelor.

		Task6:
	Avem urmatoarele functii:
-get_first/last_4h = returneaza o lista cu pasii pentru primele/ultimele 4 ore
-get_avg_hours = intoarce media aritmetica a pasilor pentru primele/ultimele ore pentru fiecare persoana
-get_diff = intoarce o lista cu diferenta pasilor persoanelor folosind un zipWith intre mediile aritmetice
            obtinute prin functiile de mai sus
-get_unsprted_diff_table = intoarce tabelul cu numele, media primelor/ultimelor 4 ore si diferanta acestora
                           nesortat
-compare_diff = functie de sortat
-get_steps_diff_table = Sorteaza tabelul cu ajutorul sortBy si a functiei compare_diff dupa diferenta,
                        respectiv dupa nume

		Task7:
	O functie care aplica o alta functie pe fiecare element al unui tabel reprezinta un map (map f)
		
		Task8:
	Calculam numarul de minute dormite si concatenam cu numele persoanei
*/

/*

		Task 2.1:
	Prima data verificam daca coloana dupa care vrem sa sortam contine valori numerice sau stringuri
prin functia check_number (cu ajutorul functiei readMaybe, care intoarce Just valoare sau nothing).
	Pentru sortare, vom transforma tabela primita intr-o tabela de tuple-uri (Row, indicele coloanei
dupa care dorim sortarea), unde indicele este obtinut din functia get_index. Sortarea va fi efectuata
folosind sortBy si 2 functii de comparare pentru stringuri si valori numerice. In caz de egalitate se
va verifica ce tip de date se afla pe prima coloana si se va compara dupa aceasta (nu se va lua in
considerare cazul in care 2 randuri au aceleasi valori atat pe prima cat si pe coloana initiala).
	In final, se trece de la tabela de tuple-uri sortata la tabela initiala sortata si se adauga
header-ul sau.

		Task 2.2:
	Comparam header-ele celor 2 tabele folosind functia check_columns ( compara pe rand elementele
din header, iar daca 2 elemente nu sunt egale functia intoarce false) si concatenam tabela t2 la t1
daca cele 2 tabele au aceleasi coloane.

		Task 2.3 :
	Pentru a concatena 2 tabele rand cu rand se poate folosi un zipwith costumizat cu operatia ++,
care primeste ca parametru si numarul de coloane a tabelelor, iar atunci cand lungimea unei tabele s-a
terminat, se concateneaza liniile ramase cu un sir de ["", ..., ""] de lungimea liniilor precedente din
tabela care s-a terminat.

		Task 2.4:
	Pentru fiecare linie din t1 se cauta elementul de la indicele dat de coloana si se verifica
daca elemuntul exista si in cealalta tabela. Daca exista, linia de pe primul tabel se concateneaza
cu linia unde a fost gasit elementul(fara acesta). In implementare s-au 
	In caz contrar se trece la urmatoarea linie din primul tabel fara a se concatena nimic la
rezultat. 
search_elem -> Cauta valoarea intr-un sir si returneaza sirul fara aceasta
search_table -> Cauta prin toata tabela daca exista valoare, iar daca da se apeleaza functia de mai
		sus si se concateneaza rezultatul cu linia din primul tabel
join -> Verfifica daca s-a gasit valoarea indexului primit in celalt tabel si formeaza tabela finala
tjoin -> apeleaza functia de mai sus cu indicele coloanei dorite

		Task 2.5:
	Pentru a efectua un produs cartezian intre doua matrici , folosim un map pentru a efectua
functia data pe primul element din t1 cu toate elemente din t2, apoi apelam recursiv fara primul
element si concatenam rezultatul.

		Task 2.6:
	Pentru a determina indicii coloanelor dorite folosim functia get_projection_index care
apeleaza recursiv functia get_index de la task1 si intoarce o lista de indici. Apoi parcurgem
fiecare row cu un index (initial 0), iar daca acesta se afla in lista de mai sus concatenam
elementul curent la rezultat.

		Task 2.7:
	Pentru a filtra randurile dupa o conditie de pe o anumita coloana folosim functia filter
cu functia _op (care parcurge lista pana ajunge la elementul de pe coloana care se doreste filtrarea,
verifica conditia si returneaza un bool) 
	
*/
