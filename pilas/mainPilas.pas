PROGRAM mainPilas;
USES
	uListaDinamica, uPilaDinamica, uElem;

PROCEDURE ejercicio1(lista: TLista; VAR pila: TPila); (*invertir orden*)
VAR
	elem: TElem;
BEGIN
	WHILE NOT (EsVacia(lista)) DO
	BEGIN
		Primero(lista, elem);
		Resto(lista, lista);
		Apilar(elem, pila);
	END;
END;

PROCEDURE ejercicio2(VAR pila: TPila); (*duplicar*)
VAR
	pilaAux: TPila;
	e: TElem;
BEGIN
	CrearPilaVacia(pilaAux);
	WHILE NOT (EsPilaVacia(pila)) DO
	BEGIN
		Cima(e,pila);
		Desapilar(pila);
		Apilar(e,pilaAux)
	END;

	WHILE NOT (EsPilaVacia(pilaAux)) DO
	BEGIN
		Cima(e,pilaAux);
		Desapilar(pilaAux);
		Apilar(e,pila);
		Apilar(e,pila);
	END;

END;

PROCEDURE ejercicio3(VAR pila: TPila; e1, e2: TElem); (*sustituir uno por otro*)
VAR
	pilaAux: TPila;
	e: TElem;
BEGIN
	CrearPilaVacia(pilaAux);
	WHILE NOT (EsPilaVacia(pila)) DO
	BEGIN
		Cima(e,pila);
		Desapilar(pila);
		Apilar(e,pilaAux)
	END;

	WHILE NOT (EsPilaVacia(pilaAux)) DO
	BEGIN
		Cima(e,pilaAux);
		Desapilar(pilaAux);
		IF(Igual(e,e1))THEN
			Apilar(e2,pila)
		ELSE
			Apilar(e,pila);
	END;
END;

VAR
	lista: TLista;
	pila: TPila;
	e1, e2, e3, eAux, eAux2: TElem;

BEGIN
	CrearVacia(lista);
	CrearPilaVacia(pila);
	Leer(e1);
	Leer(e2);
	Leer(e3);

	(* Ejercicio 1 *)
	Construir(e1, lista);
	Construir(e2, lista);
	Construir(e3, lista);
	ejercicio1(lista, pila);

	(* Ejercicio 2 *)
	Apilar(e1, pila);
	Apilar(e2, pila);
	Apilar(e3, pila);
	ejercicio2(pila);

	(* Ejercicio 3 *)
	Apilar(e1, pila);
	Apilar(e2, pila);
	Apilar(e3, pila);
	writeln('Se sustituye la aparicion del primer elemento por el segundo: ');
	Leer(eAux);
	Leer(eAux2);
	ejercicio3(pila,eAux,eAux2);

	WHILE NOT (EsPilaVacia(pila)) DO
	BEGIN
		cima(eAux, pila);
		Mostrar(eAux);
		desapilar(pila);
	END;

	writeln('Final');
	readln;
END.