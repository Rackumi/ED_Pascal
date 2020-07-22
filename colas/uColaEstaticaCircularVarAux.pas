(* IMPLEMENTACIÓN COLA ESTÁTICA CIRCULAR CON VARIABLE AUXILIAR *)

UNIT uColaEstaticaCircularVarAux;

INTERFACE

	USES uElem;

	CONST
		N = 4;

	TYPE
		TCola = RECORD
			almacen: ARRAY [1..N] OF TElem;
			p, f, longitud: integer;
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

	(* funcion auxiliar y privada para uso interno *)
	FUNCTION Siguiente(x: integer): integer;
	BEGIN
		IF(x=N)THEN
		BEGIN
			Siguiente := 1;
		END
		ELSE
		BEGIN
			Siguiente := x + 1;
		END;
	END;

	PROCEDURE CrearColaVacia(VAR cola: TCola);
	BEGIN
		cola.p := 0;
		cola.f := 0;
	END;

	PROCEDURE Insertar(elem: TElem; VAR cola: TCola);
	BEGIN
		IF (EsColaVacia(cola)) THEN
		BEGIN
			cola.p := Siguiente(cola.p);
			cola.f := siguiente(cola.f);
			Asignar(cola.almacen[cola.p], elem);
			cola.longitud := cola.longitud + 1;
		END
		ELSE IF NOT (cola.longitud = N) THEN (*que no es llena*)
		BEGIN
			Asignar(cola.almacen[Siguiente(cola.f)], elem);
			cola.f := Siguiente(cola.f);
			cola.longitud := cola.longitud + 1;
		END;
	END;

	PROCEDURE PrimeroCola(cola: TCola; VAR elem: TElem);
	BEGIN
		IF NOT (EsColaVacia(cola)) THEN
			Asignar(elem, cola.almacen[cola.p]);
	END;

	PROCEDURE Eliminar(VAR cola: TCola);
	BEGIN
		IF (NOT EsColaVacia(cola)) THEN
		BEGIN
			cola.p := siguiente(cola.p);
			cola.longitud := cola.longitud - 1;
		END;
	END;

	FUNCTION EsColaVacia (cola: TCola): boolean;
	BEGIN
		EsColaVacia := (cola.longitud = 0);
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
				aux1 := Siguiente(aux1);
				aux2 := Siguiente(aux2);
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
