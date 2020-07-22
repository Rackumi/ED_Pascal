PROGRAM mainColas;

	USES
		{uColaEstatica, uElem;}
		{uColaEstaticaCircular, uElem;}
		{uColaEstaticaCircularVarAux, uElem;}
		{uColaDinamica, uElem;}
		uColaDinCircular, uElem;
	VAR
		colaP, colaVacia, colaCopia: TCola;
		e1, e2, e3, eAux : TElem;

	BEGIN
		Leer(e1);
		Leer(e2);
		Leer(e3);

		(* Constructoras generadoras *)
		CrearColaVacia(colaP);
		CrearColaVacia(colaVacia);
		CrearColaVacia(colaCopia);
		Insertar(e1, colaP);
		Insertar(e2, colaP);
		Insertar(e3, colaP);

		writeln('A continuacion se deberia mostrar la cola');
		MostrarCola(colaP);

		(* Observadoras selectoras *)
		writeln('A continuacion deberia aparecer e1');
		PrimeroCola (colaP, eAux);
		Mostrar(eAux);

		writeln('A continuacion deberia aparecer la lista sin el elemento e1');
		Eliminar(colaP);
		MostrarCola(colaP);

		(* Observadoras no selectoras *)
	   	writeln('A continuacion deberia aparecer FALSE y TRUE en ese orden');
		writeln(EsColaVacia (colaP));
		writeln(EsColaVacia (colaVacia));

	  	writeln('A continuacion deberia aparecer TRUE, TRUE, FALSE, TRUE y FALSE en ese orden');
		writeln(IgualCola (colaP, colaP));
		writeln(IgualCola (colaVacia, colaVacia));
		writeln(IgualCola (colaP, colaVacia));

		(* Constructoras no generadoras *)
		CopiarCola(colaP, colaCopia);
		writeln(IgualCola (colaP, colaCopia));
		writeln(IgualCola (colaVacia, colaCopia));

		writeln('A continuacion se deberia mostrar la cola sin el primer elemento');
		(*recordar que lo hemos eliminado anteriormente con Eliminar(colaP); *)
		MostrarCola(colaCopia);

		writeln('A continuacion se deberia mostrar la cola original pero con e1 al final');
		Insertar(e1, colaP);
		MostrarCola(colaP);

		writeln('Final');
		readln;
	END.