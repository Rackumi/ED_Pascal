{Unidad con el tipo que representa los pacientes}

UNIT uElem;

INTERFACE
	USES uDate, uPrioridad;

	TYPE
		TElem = RECORD
        	fechaIngreso: TDate;
        	nombre: string;
        	apellidos: string;
        	edad: integer;
        	motivoIngreso: string;
        	gravedad: TPrioridad;
		END;

	PROCEDURE AsignarElem(VAR elem1: TElem; elem2: TElem);
	PROCEDURE LeerPaciente(VAR paciente: TElem);
	PROCEDURE MostrarPaciente(paciente: TElem);
	FUNCTION getPrioridad(paciente: TElem): TPrioridad;
	PROCEDURE AsignarPrioridad(VAR p1: TPrioridad; p2: TPrioridad);

IMPLEMENTATION

	PROCEDURE AsignarElem(VAR elem1: TElem; elem2: TElem);
	BEGIN
		elem1.fechaIngreso := elem2.fechaIngreso;
		elem1.nombre := elem2.nombre;
		elem1.apellidos := elem2.apellidos;
		elem1.edad := elem2.edad;
		elem1.motivoIngreso := elem2.motivoIngreso;
		elem1.gravedad := elem2.gravedad;
	END;

	PROCEDURE LeerPaciente(VAR paciente: TElem);
	VAR
	   g: integer;
    BEGIN
    	writeln(' Introduce el nombre del paciente ');
			readln( paciente.nombre );
			writeln(' Introduce el apellido del paciente ');
			readln( paciente.apellidos );
			writeln(' Introduce la edad del paciente ');
			readln( paciente.edad );
			writeln(' Introduce la fecha del ingreso ');
			uDate.Leer(paciente.fechaIngreso);
			writeln(' Introduce el motivo del ingreso ');
			readln( paciente.motivoIngreso );
			writeln(' Introduce la gravedad ');
			readln(g);
			Crear(g,paciente.gravedad);
			writeln( '---------------- ')
    END;


    PROCEDURE MostrarPaciente(paciente: TElem);
    BEGIN
    	writeln(' Nombre del paciente: ', paciente.nombre );
    	writeln(' Apellidos del paciente: ', paciente.apellidos );
			writeln(' Edad: ',paciente.edad );
			write(' Fecha de ingreso: ');
			uDate.MostrarFecha(paciente.fechaIngreso);
			writeln(' Motivo de ingreso: ',paciente.motivoIngreso );
			write(' Gravedad: ');
			uPrioridad.Mostrar(paciente.gravedad);
			writeln( '---------------- ')
    END;

    FUNCTION getPrioridad(paciente: TElem): TPrioridad;
    BEGIN
    	getPrioridad := paciente.gravedad;
    END;

	PROCEDURE AsignarPrioridad(VAR p1: TPrioridad; p2: TPrioridad);
    BEGIN
    	p1 := p2;
    END;

END.