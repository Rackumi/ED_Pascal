(* IMPLEMENTACIÓN COLA ESTÁTICA *)

UNIT uColaEstatica;

INTERFACE

	USES uElem;

	CONST
		N = 100;

	TYPE
		TCola = RECORD
			almacen: ARRAY [1..N] OF TElem;
			p, f: integer
		END;

	(* Constructoras generadoras *)
	PROCEDURE CrearColaVacia(VAR cola: TCola);
	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);

	(* Observadoras selectoras *)
	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	PROCEDURE Eliminar(VAR cola: TCola);

	(* Observadoras no selectoras *)
	FUNCTION EsColaVacia (cola: TCola): boolean;
	FUNCTION IgualCola (cola1: TCola; cola2: TCola): boolean;

	(* Constructoras no generadoras *)
	PROCEDURE CopiarCola(cola1: TCola; VAR cola2: TCola);

	(* Extra *)
	PROCEDURE MostrarCola(cola: TCola);

IMPLEMENTATION

	PROCEDURE CrearColaVacia(VAR cola: TCola);
	BEGIN
		cola.p := 0;
		cola.f := 0;
	END;

	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);
	BEGIN
		IF (EsColaVacia(cola)) THEN
		BEGIN
			cola.p := 1;
			cola.f := 1;
			Asignar(cola.almacen[cola.p], elem);
		END
		ELSE IF(cola.f < N) THEN
		BEGIN
			Asignar(cola.almacen[cola.f+1], elem);
			cola.f := cola.f+1;
		END;
	END;

	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	BEGIN
		IF NOT (EsColaVacia(cola)) THEN
			Asignar(elem, cola.almacen[cola.p]);
	END;

	PROCEDURE Eliminar(VAR cola: TCola);
	VAR
		aux: integer;
	BEGIN
		IF(cola.p = cola.f) AND NOT(EsColaVacia(cola))THEN
		BEGIN
			cola.p := 0;
			cola.f := 0;
		END
		ELSE
		BEGIN
			aux := cola.p+1;
			WHILE aux <= cola.f DO
			BEGIN
				Asignar(cola.almacen[aux-1], cola.almacen[aux]);
				aux := aux +1;
			END;
			cola.f := cola.f-1;
		END;
	END;

	FUNCTION EsColaVacia (cola: TCola): boolean;
	BEGIN
		EsColaVacia := (cola.f = 0);
	END;

	FUNCTION IgualCola (cola1: TCola; cola2: TCola): boolean;
	VAR
		aux1, aux2: integer;
	BEGIN
		IF(EsColaVacia(cola1) AND EsColaVacia(cola2)) THEN
			IgualCola := TRUE
		ELSE IF (EsColaVacia(cola1) AND NOT EsColaVacia(cola2)) THEN
			IgualCola := FALSE
		ELSE IF (EsColaVacia(cola2) AND NOT EsColaVacia(cola1)) THEN
			IgualCola := FALSE
		ELSE
		BEGIN
			IgualCola := FALSE;
			aux1 := cola1.p;
			aux2 := cola2.p;
			WHILE (Igual(cola1.almacen[aux1], cola2.almacen[aux2]) AND (aux1 < cola1.f) AND (aux2 < cola2.f)) DO
			BEGIN
				aux1 := aux1 +1;
				aux2 := aux2 +1;
			END;
			IF((aux1=cola1.f) AND (aux2=cola2.f) AND (Igual(cola1.almacen[aux1],cola2.almacen[aux2])))THEN
			IgualCola := TRUE;
		END;
	END;

	PROCEDURE CopiarCola(cola1: TCola; VAR cola2: TCola);
	VAR
		elem: TElem;
	BEGIN
		CrearColaVacia(cola2);
		WHILE NOT EsColaVacia(cola1) DO
		BEGIN
			PrimeroCola(cola1, elem);
			Eliminar(cola1);
			Insertar(elem, cola2);
		END;
	END;

	PROCEDURE MostrarCola(cola: TCola);
	VAR
		elem: TElem;
	BEGIN
		WHILE NOT EsColaVacia(cola) DO
		BEGIN
			PrimeroCola(cola, elem);
			Eliminar(cola);
			Mostrar(elem);
		END;
	END;

END.
