UNIT uPrioridad;

INTERFACE

	TYPE
		TPrioridad = integer;
		(* prioridad max => 1 *)
		(* prioridad min => 5 *)

	FUNCTION Igual(prioridad1, prioridad2 : TPrioridad): boolean;
	FUNCTION Menor(prioridad1, prioridad2 : TPrioridad): boolean;
	FUNCTION Mayor(prioridad1, prioridad2 : TPrioridad): boolean;
	PROCEDURE Asignar(VAR pd: TPrioridad; po: TPrioridad);
	PROCEDURE Mostrar(p: TPrioridad);
	PROCEDURE Leer(VAR p: TPrioridad);
	PROCEDURE Crear(valor: integer; VAR p: TPrioridad);

IMPLEMENTATION

	FUNCTION Igual(prioridad1, prioridad2 : TPrioridad): boolean;
	BEGIN
		Igual:= prioridad1 = prioridad2
	END;

	FUNCTION Menor(prioridad1, prioridad2 : TPrioridad): boolean;
	BEGIN
		Menor:= prioridad1 < prioridad2
	END;

	FUNCTION Mayor(prioridad1, prioridad2 : TPrioridad): boolean;
	BEGIN
		Mayor:= prioridad1 > prioridad2
	END;

	PROCEDURE Asignar(VAR pd: TPrioridad; po: TPrioridad);
	BEGIN
		pd:= po
	END;

	PROCEDURE Mostrar(p: TPrioridad);
	BEGIN
		writeln('Prioridad: ',p);
	END;

	PROCEDURE Leer(VAR p: TPrioridad);
	BEGIN
		writeln('Introduce una prioridad (valor entero)');
		readln(p);
	END;

	PROCEDURE Crear(valor: integer; VAR p: TPrioridad);
	BEGIN
		p:= valor;
	END;

END.