(* IMPLEMENTACIÓN PILA DINÁMICA *)

UNIT uPilaDinamica;

INTERFACE

USES uElem;

TYPE
	TPila = ^TNodo;
	TNodo = RECORD
		elemento: TElem;
		anterior: TPila;
	END;

	(* Constructoras generadoras *)
	PROCEDURE CrearPilaVacia(VAR pila: TPila);
	{PRE: Cierto}
	{POST: La pila esta vacía o se destruye}
	PROCEDURE Apilar(elem: TElem; VAR pila: TPila); {O(1)}
	{PRE: Hay espacio para almacenar elemento en la lista}
	{POST: "elemento" queda almacenado en la cima de la "pila"}
	{EXCEPCION: Si la pila esta llena no se inserta el elemento}

	(* Observadoras selectoras *)
	PROCEDURE Cima(VAR elem: TElem; pila: TPila);
	{PRE: "lista" no está vacía}
	{POST: devuelve el elemento que contiene la cima de la "pila"}
	{EXCEPCION: Si la pila esta vacía no devuelve nada}
	PROCEDURE Desapilar(VAR pila: TPila);
	{PRE: La pila no esta vacía}
	{POST: Elimina la cima de la pila}
	{EXCEPCIÓN: “Pila Vacía”}

	(* Observadoras no selectoras *)
	FUNCTION EsPilaVacia(pila: TPila): Boolean;
	{PRE: Cierto}
	{POST: devuelve TRUE si "pila" esta vacía}

	(* Constructoras no generadoras *)
	PROCEDURE Copiar(pila1: TPila; VAR pila2: TPila);
	{PRE: Queda memoria para almacenar “pila2”}
	{POST: Devuelve en “pila2” una copia de “pila1”}
	{EXCEPCIÓN: “Memoria Agotada”}
	PROCEDURE Destruir(VAR pila: TPila);
		{PRE: Cierto}
		{POST: Elimina los nodos de “pila”}

IMPLEMENTATION

	PROCEDURE CrearPilaVacia(VAR pila: TPila); {O(1)}
	BEGIN
		pila := NIL;
	END;
	
	
	PROCEDURE Apilar(elem: TElem; VAR pila: TPila); {O(1)}
	VAR
		nuevoNodo : ^TNodo;
	BEGIN
		NEW(nuevoNodo);
		Asignar(nuevoNodo^.elemento, elem);
		nuevoNodo^.anterior := pila;
		pila := nuevoNodo;
	END;
	
	PROCEDURE Cima(VAR elem: TElem; pila: TPila); {O(1)}
	BEGIN
		IF NOT(EsPilaVacia(pila)) THEN
			Asignar(elem, pila^.elemento);
	END;
	
	PROCEDURE Desapilar(VAR pila: TPila); {O(1)}
	VAR
		nodoAux : ^TNodo;
	BEGIN
		nodoAux := pila;
		pila := pila^.anterior;
		DISPOSE(nodoAux);
		nodoAux := NIL; {no haria falta xq al salir del metodo se libera solo}
	END;
	
	FUNCTION EsPilaVacia(pila: TPila): Boolean; {O(1)}
	BEGIN
		EsPilaVacia := (pila = NIL);
	END;
	
	PROCEDURE Copiar(pila1: TPila; VAR pila2: TPila); {O(n)}
	VAR
		nodoAux1, nodoAux2, nodoAuxPre2: TPila;
	BEGIN
	
		CrearPilaVacia(pila2);
	
		IF NOT EsPilaVacia(pila1) THEN
		BEGIN
			nodoAux1 := pila1;
			NEW(nodoAux2);
			Asignar(nodoAux2^.elemento, nodoAux1^.elemento);
			nodoAux2^.anterior := NIL;
			pila2 := nodoAux2;
			nodoAux1 := nodoAux1^.anterior; {Avance en pila1}
			WHILE (nodoAux1 <> NIL) DO
			BEGIN
				nodoAuxPre2 := nodoAux2;
				NEW(nodoAux2);
				Asignar(nodoAux2^.elemento,  nodoAux1^.elemento);
				nodoAux2^.anterior := NIL;
				nodoAuxPre2^.anterior := nodoAux2;
				nodoAux1 := nodoAux1^.anterior;
			END;
		END;
	END;
	
	PROCEDURE Destruir(VAR pila: TPila); {O(n)}
	BEGIN
		WHILE NOT (EsPilaVacia(pila)) DO
		BEGIN
			Desapilar(pila);
		END;
	END;

END.