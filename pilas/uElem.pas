UNIT uElem;

INTERFACE

	TYPE
		TAlumno = RECORD
			nombre: string;
			nota: real;
	 	END;

		TElem = TAlumno;

	(* Asigna el valor de un TElemento2 a TElemento1  e1 <- e2 *)
	PROCEDURE Asignar(VAR elem1: TElem; elem2: TElem);

	(* Lee por teclado un TElemento *)
	PROCEDURE Leer (VAR elem: TElem);

	(* Comprueba si dos TElemento son iguales, se les supone iguales si tienen el mismo nombre y la misma nota *)
	FUNCTION Igual(elem1, elem2: TElem): boolean;

	(* Muestra por pantalla un TElemento *)
	PROCEDURE Mostrar(e: TElem);

	(* Devuelve la nota de un alumno *)
	FUNCTION GetNota(e: TElem): real;


IMPLEMENTATION

	PROCEDURE Asignar(VAR elem1: TElem; elem2: TElem);
	BEGIN
		elem1.nombre := elem2.nombre;
		elem1.nota := elem2.nota;
	END;

	PROCEDURE Leer (VAR elem: TElem);
	BEGIN
		write('Introduzca el nombre del alumno: ');
		readln(elem.nombre);
		write('Introduzca la nota del alumno: ');
		readln(elem.nota);
	END;

	FUNCTION Igual(elem1, elem2: TElem): boolean;
	BEGIN
		IF (elem1.nombre = elem2.nombre) AND (elem1.nota = elem2.nota) THEN
			Igual := TRUE
		ELSE
			Igual := FALSE;
	END;

	PROCEDURE Mostrar(e: TElem);
	BEGIN
		writeln('El nombre del alumno es: ',e.nombre,' y su nota es: ',e.nota:0:2);
	END;

	FUNCTION GetNota(e: TElem): real;
	BEGIN
		GetNota := e.nota;
	END;

END.