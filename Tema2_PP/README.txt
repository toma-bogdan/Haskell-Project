//Toma Bogdan-Nicolae
//323CB

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