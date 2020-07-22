(* IMPLEMENTACI�N COLA DE PRIORIDAD LISTA DINAMICA SIMPLE *)

UNIT uColaPrioridadListaDinSimple;

INTERFACE

	USES uElem, uPrioridad;

	TYPE
		TEnlaceP = ^TNodoP;

		TNodoP = RECORD
			prioridad: TPrioridad;
			elemento: TElem;
			sig: TEnlaceP;
		END;

		TColaP = RECORD
			p, f: TEnlaceP;
		END;

	(*Constructoras generadoras*)
	PROCEDURE CrearColaVacia(VAR cola: TColaP);
	PROCEDURE Insertar(elem: TElem; VAR cola: TColaP);

	(*Observadoras selectoras*)
	PROCEDURE PrimeroCola(cola: TColaP; VAR elem: TElem);
	PROCEDURE Eliminar(VAR cola: TColaP);

	(*Observadoras no selectoras*)
	FUNCTION EsColaVacia (cola: TColaP): boolean;

	(* Extra *)
	PROCEDURE MostrarCola(cola: TColaP);

IMPLEMENTATION

	PROCEDURE CrearColaVacia(VAR cola: TColaP);
	BEGIN
		cola.p := NIL;
		cola.f := NIL;
	END;

	PROCEDURE Insertar(elem: TElem; VAR cola: TColaP);
	VAR
		nuevoNodo: ^TNodoP;
		pNodoAux1, pNodoAux2: ^TNodoP;
	BEGIN
		NEW(nuevoNodo);
		AsignarElem(nuevoNodo^.elemento, elem);
		AsignarPrioridad(nuevoNodo^.prioridad, getPrioridad(elem));
		IF EsColaVacia(cola) THEN
		BEGIN
			nuevoNodo^.sig := NIL;
			cola.p := nuevoNodo;
			cola.f := nuevoNodo;
		END
		ELSE
		BEGIN
			IF(Menor(nuevoNodo^.prioridad, cola.p^.prioridad)) THEN
			BEGIN
				pNodoAux1 := cola.p;
				cola.p := nuevoNodo;
				nuevoNodo^.sig := pNodoAux1;
			END
			ELSE IF(Mayor(nuevoNodo^.prioridad, cola.f^.prioridad) OR
				Igual(nuevoNodo^.prioridad, cola.f^.prioridad) ) THEN
			BEGIN
				pNodoAux1 := cola.f;
				cola.f := nuevoNodo;
				nuevoNodo^.sig := NIL;
				pNodoAux1^.sig := nuevoNodo;
			END
			ELSE
			BEGIN
				pNodoAux1 := cola.p^.sig;
				pNodoAux2 := cola.p;
				WHILE((pNodoAux1^.sig <> NIL) AND (NOT
				((Menor(nuevoNodo^.prioridad, pNodoAux2^.prioridad) OR Igual(nuevoNodo^.prioridad, pNodoAux2^.prioridad)) AND
				(Mayor(nuevoNodo^.prioridad, pNodoAux1^.prioridad))))) DO
				BEGIN
					pNodoAux1 := pNodoAux1^.sig;
					pNodoAux2 := pNodoAux2^.sig;
				END;
				nuevoNodo^.sig := pNodoAux1;
				pNodoAux2^.sig := nuevoNodo;
			END;
		END;
	END;

	PROCEDURE PrimeroCola(cola: TColaP; VAR elem: TElem);
	BEGIN
		IF NOT EsColaVacia(cola) THEN
		BEGIN
			AsignarElem(elem, cola.p^.elemento);
		END;
	END;

	PROCEDURE Eliminar(VAR cola: TColaP);
	VAR
		pAux: ^TNodoP;
	BEGIN
		IF NOT EsColaVacia(cola) THEN
		BEGIN
			pAux := cola.p;
			cola.p := cola.p^.sig;
			DISPOSE(pAux);
		END;
	END;

	FUNCTION EsColaVacia (cola: TColaP): boolean;
	BEGIN
		EsColaVacia := (cola.p = NIL);
	END;

	PROCEDURE MostrarCola(cola: TColaP);
	VAR
		pAux: ^TNodoP;
	BEGIN
		IF NOT EsColaVacia(cola) THEN
		BEGIN
			pAux := cola.p;
			WHILE pAux <> NIL DO
			BEGIN
				MostrarPaciente(pAux^.elemento);
				pAux := pAux^.sig;
			END;
		END;
	END;

END.