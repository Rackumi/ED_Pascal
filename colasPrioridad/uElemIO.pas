UNIT uElemIO;

INTERFACE

	USES uElem, uDate;

	TYPE
    	TArchivo = FILE OF TElem;

	FUNCTION ExisteArchivo(Nombre: string): boolean;
	PROCEDURE RellenarFichero(nombreFichero: string; size: integer);
	PROCEDURE LeerDatosPacienteFromFile(nombreFichero: string; pos: integer; VAR paciente: TElem);

	{Modificar esta operacion para que en lugar de mostrar todos los pacientes los inserte en una cola de prioridad}
	PROCEDURE MostrarTodosPacientes(nombreFichero: string);


IMPLEMENTATION

	FUNCTION ExisteArchivo(Nombre: string): boolean;
	VAR
		fichero: file;
	BEGIN
		Assign(fichero, Nombre);
		{$i-}
		Reset(fichero,1);
		{$i+}
		ExisteArchivo:= IOResult = 0;
		Close(fichero);
	END;

	PROCEDURE RellenarFichero(nombreFichero: string; size: integer);
	VAR
	 	i: integer;
	 	datoActual: TElem;
	 	fichero: TArchivo;
	BEGIN
		assign(fichero, nombreFichero ); (* Asignamos *)
		rewrite(fichero); (* Abrimos (escritura) *)
		writeln(' Te ire pidiendo los datos de diferentes pacientes...' );
		FOR i := 1 TO size DO (* Repetimos 4 veces *)
		BEGIN
			LeerPaciente(datoActual);
			write( fichero, datoActual ); (* Guardamos el dato *)
		END;
		close( fichero ); (* Cerramos el fichero *)
	END;

	PROCEDURE LeerDatosPacienteFromFile(nombreFichero: string; pos: integer; VAR paciente: TElem);
	VAR
		fichero: TArchivo;
	BEGIN
		assign( fichero, nombreFichero );
		reset( fichero ); (* Abrimos (lectura) *)
		seek( fichero, pos-1 ); (* <== Vamos al alumno en la posicion pos *)
		read( fichero, paciente ); (* Leemos *)
		close( fichero );
	END;

	PROCEDURE MostrarTodosPacientes(nombreFichero: string);
	VAR
		fichero: TArchivo;
		paciente: TElem;
	BEGIN
		Assign(fichero, nombreFichero);
		Reset(fichero);
		WHILE NOT eof(fichero) DO
		BEGIN
			read(fichero, paciente);
			MostrarPaciente(paciente);
		END;
	END;

END.