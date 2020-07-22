(* IMPLEMENTACIÓN LISTA DOBLEMENTE ENLAZADA *)

UNIT uListaDoblementeEnlazada;

INTERFACE

	USES uElem;

	TYPE
		TLista = ^TNodo;
		TNodo = RECORD
			elemento: TElem;
			anterior, siguiente: TLista;
		END;

	(* Constructoras generadoras *)
	PROCEDURE CrearVacia (VAR lista: TLista);
	PROCEDURE Construir (elem: TElem; VAR lista: TLista);

	(* Observadoras selectoras *)
	PROCEDURE Primero (lista: TLista; VAR elem: TElem);
	PROCEDURE Resto (lista: TLista; VAR restoLista: TLista);

	(* Observadoras no selectoras *)
	FUNCTION EsVacia (lista: TLista): boolean;
	FUNCTION Longitud (lista: TLista): integer;
	PROCEDURE Ultimo (lista: TLista; VAR elem: TElem);
	FUNCTION Pertenece (elem: TElem; lista: TLista): boolean;

	(* Constructoras no generadoras *)
	PROCEDURE Concatenar (l1: TLista; l2: TLista; VAR l3: TLista);
	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	PROCEDURE InsertarFinal (elem: TElem; VAR lista: TLista);
	PROCEDURE Borrar (VAR lista: TLista);

IMPLEMENTATION

	PROCEDURE CrearVacia (VAR lista: TLista);
	BEGIN
		lista := NIL;
	END;

	PROCEDURE Construir (elem: TElem; VAR lista: TLista);
	VAR
		pNuevo: TLista;
	BEGIN
		NEW(pNuevo);
		pNuevo^.anterior := NIL;
		Asignar(pNuevo^.elemento, elem);
		pNuevo^.siguiente := lista;
		IF (NOT EsVacia(lista)) THEN
			lista^.anterior := pNuevo;
		lista := pNuevo;
	END;

	PROCEDURE Primero (lista: TLista; VAR elem: TElem);
	BEGIN
		IF NOT EsVacia(lista) THEN
			Asignar(elem, lista^.elemento);
	END;

	PROCEDURE Resto (lista: TLista; VAR restoLista: TLista);
	BEGIN
		IF NOT EsVacia(lista) THEN
		BEGIN
			restoLista := lista^.siguiente;
			restoLista^.anterior := NIL;
		END;
	END;

	FUNCTION EsVacia (lista: TLista):  boolean;
	BEGIN
		EsVacia := (lista = NIL);
	END;

	FUNCTION Longitud (lista: TLista): integer;
	VAR
		long: integer;
	BEGIN
		long := 0;
		WHILE (lista <> NIL) DO
		BEGIN
			long := long + 1;
			lista := lista^.siguiente
		END;
		Longitud := long
	END;

	FUNCTION Longitud1 (lista: TLista): integer;
	VAR
		pNodo: ^TNodo;
		long: integer;
	BEGIN
		long := 0;
		pNodo := lista;
		WHILE (pNodo <> NIL) DO
		BEGIN
			long := long + 1;
			pNodo := pNodo^.siguiente;
		END;
		Longitud1 := long;
	END;

	PROCEDURE Ultimo (lista: TLista; VAR elem: TElem);
	VAR
		pNodo: ^TNodo;
	BEGIN
		IF (NOT EsVacia(lista)) THEN
		BEGIN
			pNodo := lista;
			WHILE (pNodo^.siguiente <> NIL) DO
			BEGIN
				pNodo:=pNodo^.siguiente;
			END;
			Asignar(elem, pNodo^.elemento);
		END;
	END;

	FUNCTION Pertenece (elem: TElem; lista: TLista): boolean;
	VAR
		pNodo: ^TNodo;
	BEGIN
		IF EsVacia(lista) THEN
			Pertenece := FALSE
		ELSE
		BEGIN
			pNodo:=lista;
			WHILE ((pNodo <> NIL) AND (NOT Igual(pNodo^.elemento, elem))) DO
			BEGIN
				pNodo:=pNodo^.siguiente;
			END;

			IF (pNodo = NIL) THEN
				Pertenece := FALSE
			ELSE
				Pertenece := Igual(pNodo^.elemento, elem);
		END;
	END;

	PROCEDURE Concatenar (l1: TLista; l2: TLista; VAR l3: TLista);
	VAR
		pNodo: ^TNodo;
	BEGIN
		CrearVacia(l3);

		pNodo := l1;
		WHILE (pNodo <> NIL) DO
		BEGIN
			InsertarFinal(pNodo^.elemento, l3);
			pNodo := pnodo^.siguiente;
		END;

		pNodo := l2;
		WHILE (pNodo <> NIL) DO
		BEGIN
			InsertarFinal(pNodo^.elemento, l3);
			pNodo := pnodo^.siguiente;
		END;
	END;

(*	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	VAR
		anterior: ^TNodo;
		actual: ^TNodo;
		posterior: ^TNodo;
	BEGIN
		actual := lista;
		anterior := lista;

		WHILE (actual<>NIL) AND (NOT Igual(actual^.elemento, elem)) DO
		BEGIN
			anterior := actual;
			actual := actual^.siguiente;
		END;

		IF (actual <> NIL) THEN
		BEGIN
			posterior := actual^.siguiente;
			anterior^.siguiente := posterior;
			IF (lista = actual) THEN
				lista := posterior;
			DISPOSE (actual);
		END;
	END; *)

	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	VAR
		aux: TLista;

	BEGIN
		aux := lista;

		WHILE NOT EsVacia(aux) AND NOT Igual(aux^.elemento, elem) DO
			aux := aux^.siguiente;
		IF NOT EsVacia(aux) THEN
		BEGIN
			IF NOT EsVacia(aux^.anterior) AND NOT EsVacia(aux^.siguiente) THEN
			BEGIN
				aux^.anterior^.siguiente := aux^.siguiente;
				aux^.siguiente^.anterior := aux^.anterior;
			END

			ELSE IF EsVacia(aux^.anterior) THEN
			BEGIN
				lista := aux^.siguiente;
				lista^.anterior := NIL
			END

			ELSE
				aux^.anterior^.siguiente := NIL;

			DISPOSE(aux);
		END;
	END;


	PROCEDURE InsertarFinal (elem: TElem; VAR lista: TLista);
	VAR
		pNodo: ^TNodo;
		pUltimo: ^TNodo;
	BEGIN
		NEW (pNodo);
		Asignar(pNodo^.elemento, elem);
		pNodo^.siguiente := NIL;

		IF EsVacia(lista) THEN
			lista := pNodo
		ELSE
		BEGIN
			pUltimo := lista;
			WHILE (NOT EsVacia(pUltimo^.siguiente)) DO
			BEGIN
				pUltimo := pUltimo^.siguiente;
			END;
			pUltimo^.siguiente := pNodo;
		END;
	END;

	PROCEDURE Borrar(VAR lista: TLista);
	VAR
		elem: TElem;
	BEGIN
		WHILE (NOT EsVacia(lista)) DO
		BEGIN
			Primero(lista, elem);
			BorrarElemento(elem, lista)
		END;
	END;

END.