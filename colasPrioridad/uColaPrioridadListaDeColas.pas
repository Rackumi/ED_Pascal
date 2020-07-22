(* IMPLEMENTACIÓN COLA DE PRIORIDAD LISTA DE COLAS *)

UNIT uColaPrioridadListaDeColas;

INTERFACE

	USES uElem, uPrioridad;

	TYPE
		TEnlaceP = ^TNodoP;

		TNodoP = RECORD
			prioridad: TPrioridad;
		(*	cola: TColaC; *)
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
	BEGIN

	END;

	PROCEDURE PrimeroCola(cola: TColaP; VAR elem: TElem);
	BEGIN

	END;

	PROCEDURE Eliminar(VAR cola: TColaP);
	BEGIN

	END;

	FUNCTION EsColaVacia (cola: TColaP): boolean;
	BEGIN
		EsColaVacia := (cola.p = NIL);
	END;

	PROCEDURE MostrarCola(cola: TColaP);
	BEGIN

	END;

END.