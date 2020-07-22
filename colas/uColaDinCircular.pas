(* IMPLEMENTACIÓN COLA DINAMICA CIRCULAR *)

UNIT uColaDinCircular;

INTERFACE

	USES uElem;

	TYPE
		TCola = ^TNodo;
		TNodo = RECORD
			elemento: TElem;
			siguiente: TCola;
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
		cola :=  NIL
	END;

	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);
	VAR
		nodoNuevo: ^TNodo;
	BEGIN
		NEW(nodoNuevo);
		Asignar(nodoNuevo^.elemento, elem);
		IF(EsColaVacia(cola))THEN
		BEGIN
			nodoNuevo^.siguiente := nodoNuevo;
			cola := nodoNuevo;
		END
		ELSE
		BEGIN
			nodoNuevo^.siguiente := cola^.siguiente;
			cola^.siguiente := nodoNuevo;
			cola := nodoNuevo;
		END
	END;

	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	BEGIN
		IF NOT EsColaVacia(cola) THEN
			Asignar(elem, cola^.siguiente^.elemento);
	END;

	PROCEDURE Eliminar(VAR cola: TCola);
	VAR
		aux : ^TNodo;
	BEGIN
		IF NOT EsColaVacia(cola) THEN
		BEGIN
			aux := cola^.siguiente;
			cola^.siguiente := aux^.siguiente;
			IF(aux = cola)THEN
				cola := NIL
			ELSE
				cola^.siguiente := aux^.siguiente;
			DISPOSE(aux);
			aux := NIL;
		END;
	END;

	FUNCTION EsColaVacia (cola: TCola): boolean;
	BEGIN
		EsColaVacia := (cola = NIL);
	END;

	FUNCTION IgualCola (cola1: TCola; cola2: TCola): boolean;
	VAR
		aux1, aux2: ^TNodo;
		bool: boolean;
	BEGIN
		IF(EsColaVacia(cola1) AND EsColaVacia(cola2)) THEN
			IgualCola := TRUE
		ELSE IF (EsColaVacia(cola1) AND NOT EsColaVacia(cola2)) THEN
			IgualCola := FALSE
		ELSE IF (EsColaVacia(cola2) AND NOT EsColaVacia(cola1)) THEN
			IgualCola := FALSE
		ELSE
		BEGIN
			bool := TRUE;
			aux1 := cola1^.siguiente;
			aux2 := cola2^.siguiente;
			WHILE ((bool) AND (aux1 <> cola1) AND (aux2 <> cola2)) DO
			BEGIN
				bool := Igual(aux1^.elemento, aux2^.elemento);
				aux1 := aux1^.siguiente;
				aux2 := aux2^.siguiente;
			END;

			IgualCola := (bool) AND Igual(cola1^.elemento, cola2^.elemento);
		END;
	END;

	PROCEDURE CopiarCola(cola1: TCola; VAR cola2: TCola);
	VAR
		aux: ^TNodo;
	BEGIN
		CrearColaVacia(cola2);
		aux := cola1^.siguiente;
		WHILE (aux <> cola1) DO
		BEGIN
			Insertar(aux^.elemento, cola2);
			aux := aux^.siguiente;
		END;
		Insertar(cola1^.elemento, cola2);
	END;

	PROCEDURE MostrarCola(cola: TCola);
	VAR
		aux: ^TNodo;
	BEGIN
		IF (NOT EsColaVacia(cola)) THEN
		BEGIN
			aux := cola^.siguiente;
			WHILE (aux <> cola) DO
			BEGIN
				Mostrar(aux^.elemento);
				aux := aux^.siguiente;
			END;
				Mostrar(aux^.elemento);
		END;
	END;

END.
