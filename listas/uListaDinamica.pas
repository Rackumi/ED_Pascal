(* IMPLEMENTACIÓN LISTA DINÁMICA *)

UNIT uListaDinamica;

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
	PROCEDURE Concatenar (lista1: TLista; lista2: TLista; VAR lista3: TLista);
	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	PROCEDURE InsertarFinal (elem: TElem; VAR lista: TLista);
	PROCEDURE Borrar (VAR lista: TLista);

	(* Ejercicios extra *)
	FUNCTION Contenida (cadenaP: TLista; subcadenaP: TLista):boolean;
	PROCEDURE LeerInverso (lista: Tlista);

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

	PROCEDURE Concatenar (lista1: TLista; lista2: TLista; VAR lista3: TLista);
	VAR
		pNodo: ^TNodo;
	BEGIN
		CrearVacia(lista3);

		pNodo := lista1;
		WHILE (pNodo <> NIL) DO
		BEGIN
			InsertarFinal(pNodo^.elemento, lista3);
			pNodo := pnodo^.siguiente;
		END;

		pNodo:=lista2;
		WHILE (pNodo <> NIL) DO
		BEGIN
			InsertarFinal(pNodo^.elemento, lista3);
			pNodo := pnodo^.siguiente;
		END;
	END;

	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	VAR
		anterior: ^TNodo;
		actual: ^TNodo;
		posterior: ^TNodo;
	BEGIN
		actual := lista;
		anterior := lista;

		WHILE (actual<>NIL) AND (NOT Igual(actual^.elemento, elem)) DO
		BEGIN
			anterior:=actual;
			actual:=actual^.siguiente;
		END;

		IF (actual <> NIL) THEN
		BEGIN
			posterior:=actual^.siguiente;
			anterior^.siguiente:=posterior;
			IF (lista = actual) THEN
				lista := posterior;
			DISPOSE (actual);
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


	FUNCTION Contenida (cadenaP: TLista; subcadenaP: TLista):boolean;
		VAR
			punteroC, punteroS: ^TNodo;
			i, c, s, contador: integer;
			elemC, elemS: TElem;
		BEGIN
			Contenida := FALSE;
			c := Longitud (cadenaP) - 1;
			s := Longitud (SubcadenaP) - 1;
			punteroS := subcadenaP;
			writeln('2');
			readln;
			FOR i:=1 TO c-1 DO
				BEGIN
					punteroC := cadenaP;
					subcadenaP := punteroS;
					contador := s;
					Primero(cadenaP, elemC);
					Primero(subcadenaP, elemS);
					Mostrar(elemC);
					Mostrar(elemS);
					writeln('3');
					readln;
					IF (Igual(elemC, elemS)) THEN
						BEGIN
							writeln('4');
							readln;
							WHILE (Igual(elemC, elemS)) DO
								BEGIN
									writeln('5');
									readln;
									Resto(cadenaP,cadenaP);
									Resto(subcadenaP,subcadenaP);
									contador := contador-1;
									IF contador = 0 THEN
										BEGIN
											Contenida := TRUE;
										END
									ELSE
										BEGIN
											cadenaP := punteroC;
										END;
								END;
						END
					ELSE
						BEGIN
							Resto(cadenaP,cadenaP);
						END;
				END;
		END;

	PROCEDURE LeerInverso (lista: Tlista);
		VAR
			i, l: integer;
			elem: TElem;
		BEGIN
			WHILE NOT EsVacia(lista) DO
				BEGIN
					Primero(lista, elem);
					Resto(lista, lista);
					Mostrar(elem);
				END;
			readln;
		END;

END.