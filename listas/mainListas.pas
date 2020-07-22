PROGRAM mainListas;

	USES
		(*uListaEstatica, uElem, uListaEstExtIO;*)
		(*uListaDinamica, uElem, uListaDinExtIO;*)
		uListaEstSimDin, uElem, uListaEstSimDinExtIO;

	VAR
		i : integer;
		listaAux, listaPrueba, listaVacia : TLista;
		e1, e2, e3, e4, eAux : TElem;

	BEGIN (* Este programa sirve prara probar el correcto funcionamiento de las listas *)
		Leer(e1);
		Leer(e2);
		Leer(e3);

		(* Constructoras generadoras *)
		CrearVacia (listaPrueba);
		CrearVacia (listaVacia);

		Construir (e1, listaPrueba);
		Construir (e2, listaPrueba);
		Construir (e3, listaPrueba);

		LeerListaT(listaPrueba);

		writeln('A contunuacion deberan aparecer los 4 elementos introducidos en orden inverso');
		(*EscribirListaP(listaPrueba);*)
		MostrarLista(listaPrueba);

		(* Observadoras selectoras *)
		writeln('A continuacion deberia aparecer e4');
		Primero (listaPrueba, eAux);
		Mostrar(eAux);

		writeln('A continuacion deberia aparecer la lista sin el elemento e4');
		Resto (listaPrueba, listaAux);
		(*EscribirListaP(listaAux);*)
		MostrarLista(listaAux);

		(* Observadoras no selectoras *)
	   	writeln('A continuacion deberia aparecer FALSE y TRUE en ese orden');
		writeln(EsVacia (listaPrueba));
		writeln(EsVacia (listaVacia));

	   	writeln('A continuacion deberia aparecer 4 y 0 en ese orden');
		writeln(Longitud (listaPrueba));
		writeln(Longitud (listaVacia));

		writeln('A continuacion deberia aparecer e1');
		Ultimo (listaPrueba, eAux);
		Mostrar(eAux);

		writeln('A continuacion deberia aparecer TRUE, FALSE, TRUE, FALSE en ese orden');
		writeln(Pertenece (e1, listaPrueba));
		writeln(Pertenece (e1, listaVacia));
		writeln(Pertenece (e1, listaAux));
		writeln(Pertenece (e4, listaAux));

		(* Constructoras no generadoras *)
		writeln('A continuacion deberia aparecer una concatenacion de dos listas como la introducida inicialmente');
		Concatenar (listaPrueba, listaPrueba, listaAux);
		(*EscribirListaP(listaAux);*)
		MostrarLista(listaAux);

		writeln('A continuacion deberia aparecer la lista pero sin e1');
		BorrarElemento (e1, listaPrueba);
		(*EscribirListaP(listaPrueba);*)
		MostrarLista(listaPrueba);

		writeln('A continuacion deberia aparecer la lista normal');
		InsertarFinal (e1, listaPrueba);
		(*EscribirListaP(listaPrueba);*)
		MostrarLista(listaPrueba);

		(* Borrar (listaPrueba); *)

		writeln('Final');
		readln;
	END.