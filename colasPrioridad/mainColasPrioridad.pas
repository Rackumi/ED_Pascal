PROGRAM mainColasPrioridad;

USES
	(*	uElem, uElemIO, uColaPrioridadListaDE; *)
		uElem, uElemIO, uColaPrioridadListaDinSimple;
		
VAR
	colaPPrueba, colaVacia: TColaP;
	e1, e2, e3, e4, eAux: TElem;

BEGIN
	LeerPaciente(e1);
	LeerPaciente(e2);
	LeerPaciente(e3);
	LeerPaciente(e4);

	(*Constructoras generadoras*)
	CrearColaVacia(colaPPrueba);
	CrearColaVacia(colaVacia);

	Insertar(e1, colaPPrueba);
	Insertar(e2, colaPPrueba);
	Insertar(e3, colaPPrueba);
	Insertar(e4, colaPPrueba);
	writeln('A continuacion se mostrara la lista');
	MostrarCola(colaPPrueba);

	(*Observadoras selectoras*)
	PrimeroCola(colaPPrueba, eAux);
	writeln('A continuacion se mostrara el primer elemento de la lista (e1)');
	MostrarPaciente(eAux);

	Eliminar(colaPPrueba);
	writeln('A continuacion se mostrara la lista sin e1');
	MostrarCola(colaPPrueba);

	(*Observadoras no selectoras*)
	writeln('A continuacion deberia aparecer FALSE y TRUE en ese orden');
	writeln(EsColaVacia(colaPPrueba));
	writeln(EsColaVacia(colaVacia));

	writeln('Final');
	readln;
END.