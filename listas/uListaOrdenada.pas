(* IMPLEMENTACIÓN LISTA ORDENADA *)

UNIT uListaOrdenada; {Se considera orden creciente de claves}

INTERFACE

	USES uElem;

	TYPE
		TLista = ^TNodo;
		TNodo = RECORD
			elemento: TElem;
			siguiente: TLista;
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
	PROCEDURE InsertarOrd (elem: tElem; VAR lista: tLista);				(* Ordenada *)
	PROCEDURE Mezclar(lista1, lista2: tLista; VAR lista3: tLista);		(* Ordenada *)
	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	PROCEDURE Borrar (VAR lista: TLista);

IMPLEMENTATION

	PROCEDURE CrearVacia (VAR lista: TLista);
	BEGIN
		lista := NIL;
	END;

	PROCEDURE Construir (elem: TElem; VAR lista: TLista);
	VAR
		nuevoNodo: ^TNodo;
	BEGIN
		NEW (nuevoNodo);
		Asignar(nuevoNodo^.elemento, elem);
		nuevoNodo^.siguiente := lista;
		lista := nuevoNodo;
	END;

	PROCEDURE Primero (lista: TLista; VAR elem: TElem);
	BEGIN
		IF NOT EsVacia(lista) THEN
			Asignar(elem, lista^.elemento);
	END;

	PROCEDURE Resto (lista: TLista; VAR restoLista: TLista);
	BEGIN
		IF NOT EsVacia(lista) THEN
			restoLista := lista^.siguiente;
	END;

	FUNCTION EsVacia (lista: TLista):  BOOLEAN;
	BEGIN
		EsVacia := (lista = NIL);
	END;

	FUNCTION Longitud (lista: TLista): integer;
	VAR
		long: integer;
	BEGIN
		long := 0;
		WHILE NOT EsVacia(lista) DO
		BEGIN
			long := long + 1;
			lista := lista^.siguiente
		END;
		Longitud := long
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
		aux: ^TNodo;
		encontrado: boolean;
		y: TElem;
	BEGIN
		aux := lista;
		encontrado := FALSE;
		WHILE NOT ((EsVacia(aux)) AND (NOT encontrado)) DO
    	BEGIN
	    	primero (aux,y);
	    	IF Menor(y, elem) THEN
	     		resto(aux,aux)
	     	ELSE
	     		encontrado := TRUE
    	END;
		Pertenece := Igual(y, elem);
	END;

	PROCEDURE InsertarOrd(elem: tElem; VAR lista: tLista);
	VAR
		nuevo, actual, anterior: ^tNodo;
	BEGIN
		NEW(nuevo);
		Asignar(nuevo^.elemento, elem);
		actual := lista;

		WHILE (NOT EsVacia(actual) AND Menor(actual^.elemento, elem)) DO
		BEGIN
			anterior := actual;
			actual := actual^.siguiente;
		END;

		IF actual = lista THEN
		BEGIN
			nuevo^.siguiente := lista;
			Lista := nuevo
		END
		ELSE
		BEGIN
			anterior^.siguiente := nuevo;
			nuevo^.siguiente := actual
		END;
	END;

	PROCEDURE Mezclar(lista1, lista2: tLista; VAR lista3: tLista);
	VAR
		aux: tLista;
	BEGIN
		CrearVacia(lista3);

		aux := lista1;
		WHILE (aux^.siguiente <> NIL) DO
		BEGIN
			InsertarOrd(aux^.elemento, lista3);
			aux := aux^.siguiente;
		END;

		aux := lista2;
		WHILE (aux^.siguiente <> NIL) DO
		BEGIN
			InsertarOrd(aux^.elemento, lista3);
			aux := aux^.siguiente;
		END;
	END;

	PROCEDURE BorrarElemento(elem: TElem; VAR lista: TLista);
	VAR
		anterior:^TNodo;
		actual:^TNodo;
	BEGIN
		anterior := lista;
		actual := lista;
		WHILE (actual <> NIL) AND (Menor(actual^.elemento, elem)) DO
		BEGIN
			anterior := actual;
			actual := actual^.siguiente;
		END;
		IF (actual <> NIL) AND Igual(actual^.elemento, elem) THEN
		BEGIN
			IF (lista=actual) THEN
				lista := lista^.siguiente
			ELSE
				anterior^.siguiente := actual^.siguiente;
			DISPOSE(actual);
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