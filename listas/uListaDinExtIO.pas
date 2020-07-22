UNIT uListaDinExtIO;

INTERFACE

	USES
		uElem, uListaDinamica;

	(* Lee por teclado los alumnos con sus notas y los almacena en lista *)
	PROCEDURE LeerListaT(VAR lista: TLista);

	(* Escribe por pantalla los datos de los alumnos contenidos en lista *)
	PROCEDURE EscribirListaP(lista: TLista);

IMPLEMENTATION

	PROCEDURE LeerListaT(VAR lista: TLista);
	VAR
		e: TElem;
	BEGIN
		Leer(e);
		Construir(e,lista);
	END;

	PROCEDURE EscribirListaP(lista: TLista);
	VAR
		e: TElem;
		i: integer;
	BEGIN
		FOR i:=1 TO Longitud(lista) DO
		BEGIN
			Primero(lista, e);
			IF (GetNota(e) >= 1) THEN
			BEGIN
				Mostrar(e);
			END;
			Resto(lista,lista);
		END;
	END;

END.