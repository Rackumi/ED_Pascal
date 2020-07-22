(* IMPLEMENTACIÓN COLA DINAMICA *)

UNIT uColaDinamica;

INTERFACE

	USES uElem;

	TYPE
		TEnlace = ^TNodo;
		TNodo = RECORD
			elemento: TElem;
			siguiente: TEnlace;
		END;

		TCola = RECORD
			p,f: TEnlace;
		END;

	(*Constructoras generadoras*)
	PROCEDURE CrearColaVacia(VAR cola: TCola);
	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);

	(*Observadoras selectoras*)
	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	PROCEDURE Eliminar(VAR cola: TCola);

	(*Observadoras no selectoras*)
	FUNCTION EsColaVacia (cola: TCola): boolean;
	FUNCTION IgualCola (cola1: TCola; cola2: TCola): boolean;

	(* Constructoras no generadoras *)
	PROCEDURE CopiarCola(cola1: TCola; VAR cola2: TCola);

	(* Extra *)
	PROCEDURE MostrarCola(cola: TCola);

IMPLEMENTATION

	PROCEDURE CrearColaVacia(VAR cola: TCola);
	BEGIN
		cola.p := NIL;
		cola.f := NIL;
	END;

	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);
	VAR
		nodoNuevo: ^TNodo;
	BEGIN
		NEW(nodoNuevo);
		Asignar(nodoNuevo^.elemento, elem);
		nodoNuevo^.siguiente := NIL;
		IF(EsColaVacia(cola))THEN
		BEGIN
			cola.p := nodoNuevo;
			cola.f := nodoNuevo;
		END
		ELSE
		BEGIN
			cola.f^.siguiente := nodoNuevo;
			cola.f := nodoNuevo;
		END
	END;

	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	BEGIN
		IF NOT EsColaVacia(cola) THEN
			Asignar(elem, cola.p^.elemento);
	END;

	PROCEDURE Eliminar(VAR cola: TCola);
	VAR
		aux : ^TNodo;
	BEGIN
		IF NOT EsColaVacia(cola) THEN
		BEGIN
			aux := cola.p;
			cola.p := cola.p^.siguiente;
			DISPOSE(aux);
			aux := NIL;
			IF(cola.p = NIL)THEN
				cola.f := NIL;
		END;
	END;

	FUNCTION EsColaVacia (cola: TCola): boolean;
	BEGIN
		EsColaVacia := ((cola.f = NIL) AND (cola.p = NIL));
	END;

	FUNCTION IgualCola (cola1: TCola; cola2: TCola): boolean;
	VAR
		aux1, aux2: ^TNodo;
		bool: boolean;
	BEGIN
		bool := TRUE;
		aux1 := cola1.p;
		aux2 := cola2.p;
		WHILE ((bool) AND (aux1 <> NIL) AND (aux2 <> NIL)) DO
		BEGIN
			bool := Igual(aux1^.elemento, aux2^.elemento);

			aux1 := aux1^.siguiente;
			aux2 := aux2^.siguiente;
		END;

		IgualCola := (bool) AND (aux1 = NIL) AND (aux2 = NIL);
	END;

	PROCEDURE CopiarCola(cola1: TCola; VAR cola2: TCola);
	VAR
		aux: ^TNodo;
	BEGIN
		CrearColaVacia(cola2);

		aux := cola1.p;
		WHILE (aux <> NIL) DO
		BEGIN
			Insertar(aux^.elemento, cola2);

			aux := aux^.siguiente;
		END;
	END;

	PROCEDURE MostrarCola(cola: TCola);
	VAR
		aux: ^TNodo;
	BEGIN
		IF (NOT EsColaVacia(cola)) THEN
		BEGIN
			aux := cola.p;
			WHILE (aux^.siguiente <> NIL) DO
			BEGIN
				Mostrar(aux^.elemento);

				aux := aux^.siguiente;
			END;
			Mostrar(aux^.elemento);
		END;
	END;

END.