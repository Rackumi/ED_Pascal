(* IMPLEMENTACIÓN LISTA ESTÁTICA CON SIMULACIÓN DINÁMICA *)

UNIT uListaEstSimDin;

INTERFACE

	USES uElem;

	CONST
		MAX = 10;

	TYPE
		TPosition = 0..MAX; (* 0 = nulo *)

		TNodo = RECORD
			elemento: TElem;
			siguiente: TPosition;
		END;

		TLista = RECORD
			elementos: ARRAY [1..MAX] OF TNodo;
			pOcupadas: TPosition;
			pLibres: TPosition;
		END;

	(* Constructoras generadoras *)
	PROCEDURE CrearVacia (VAR lista: TLista);
	PROCEDURE Construir (elem: TElem; VAR lista: TLista);

	(* Observadoras selectoras *)
	PROCEDURE Primero (lista: TLista; VAR elem: TElem);
	PROCEDURE Resto  (lista: TLista; VAR restoLista: TLista);

	(* Observadoras no selectoras *)
	FUNCTION EsVacia (lista: TLista):  boolean;
	FUNCTION Longitud (lista: TLista): integer;
	PROCEDURE Ultimo (lista: TLista; VAR elem: TElem);
	FUNCTION Pertenece (elem: TElem; lista: TLista): boolean;

	(* Constructoras no generadoras *)
	PROCEDURE Concatenar (l1, l2: TLista; VAR l3: TLista);
	PROCEDURE BorrarElemento (elem: TElem; VAR lista: TLista);
	PROCEDURE InsertarFinal (elem: TElem; VAR lista: TLista);

	PROCEDURE MostrarLista(lista: TLista);

IMPLEMENTATION

	PROCEDURE CrearVacia (VAR lista: TLista);
	VAR
		i : TPosition;
	BEGIN
		lista.pOcupadas := 0;
		lista.pLibres := 1;

		FOR i:=1 TO MAX-1 DO
		BEGIN
			lista.elementos[i].siguiente := i+1;
		END;
		lista.elementos[MAX].siguiente := 0;

	END;

	PROCEDURE Construir (elem: TElem; VAR lista: TLista);
	VAR
		aux, aux2 : TPosition;
	BEGIN
		IF lista.pLibres <> 0 THEN
		BEGIN
			Asignar(lista.elementos[lista.pLibres].elemento, elem);
			aux := lista.elementos[lista.pLibres].siguiente;
			lista.elementos[lista.pLibres].siguiente := lista.pOcupadas;
			lista.pOcupadas := lista.pLibres;

			lista.pLibres := aux;
		END;
	END;

	PROCEDURE Primero (lista: TLista; VAR elem: TElem);
	BEGIN
		IF NOT (EsVacia(lista)) THEN
		BEGIN
			Asignar(elem, lista.elementos[lista.pOcupadas].elemento);
		END;
	END;

	PROCEDURE Resto (lista: tLista; VAR restoLista: tLista);
	VAR
		elemento: TElem;
		aux: integer;
	BEGIN
		IF NOT (EsVacia(lista)) THEN
		BEGIN
			CrearVacia(restoLista);
			aux := lista.pOcupadas;
			WHILE (aux <> 0) DO
			BEGIN
				InsertarFinal(lista.elementos[aux].elemento, restoLista);
				aux := lista.elementos[aux].siguiente;
			END;
			Primero(restolista, elemento);
			BorrarElemento(elemento, restoLista);
		END;
	END;

	FUNCTION EsVacia (lista: TLista):  boolean;
	BEGIN
		EsVacia := (lista.pOcupadas = 0);
	END;

	FUNCTION Longitud (lista: tLista): integer;
	VAR
		aux, long: integer;
	BEGIN
		long := 0;
		IF EsVacia(lista) THEN
			Longitud := 0
		ELSE
		BEGIN
			aux := lista.pOcupadas;
			WHILE (aux <> 0) DO
			BEGIN
				long := long +1;
				aux := lista.elementos[aux].siguiente;
			END;
			Longitud := long;
		END;
	END;

	PROCEDURE Ultimo (lista: tLista; VAR elem: tElem);
	VAR
		aux: integer;
	BEGIN
		IF NOT (EsVacia(lista)) THEN
		BEGIN
			aux := lista.pOcupadas;
			WHILE (lista.elementos[aux].siguiente <> 0) DO
			BEGIN
				aux := lista.elementos[aux].siguiente;
			END;
			Asignar(elem, lista.elementos[aux].elemento);
		END;
	END;

	FUNCTION Pertenece (elem:tElem; lista: tLista): boolean;
	VAR
		aux: integer;
	BEGIN
		IF (EsVacia(lista)) THEN
			Pertenece := FALSE
		ELSE
		BEGIN
			aux := lista.pOcupadas;
			WHILE ((lista.elementos[aux].siguiente<>0) AND (NOT(Igual(lista.elementos[aux].elemento, elem)))) DO
			BEGIN
				aux := lista.elementos[aux].siguiente;
			END;
			Pertenece := (Igual(lista.elementos[aux].elemento, elem));
		END;
	END;

	PROCEDURE Concatenar (l1, l2: tLista; VAR l3: tLista);
	VAR
		listaAux: TLista;
		elem: TElem;
		aux: integer;
	BEGIN
		CrearVacia(l3);
		IF(longitud(l1)+longitud(l2) <= MAX) THEN
		BEGIN
			aux := l1.pOcupadas; (*inic copiar*)
			WHILE (aux <> 0) DO
			BEGIN
				InsertarFinal(l1.elementos[aux].elemento, l3);
				aux := l1.elementos[aux].siguiente;
			END;				(*end copiar*)

			aux := l2.pOcupadas;
			WHILE (aux <> 0) DO
			BEGIN
				InsertarFinal(l2.elementos[aux].elemento, l3);
				aux := l2.elementos[aux].siguiente;
			END;
		END;
	END;

	PROCEDURE BorrarElemento (elem: tElem; VAR lista: tLista);
	VAR
		aux, anterior, x, y: integer;
	BEGIN
		IF NOT(EsVacia(lista)) THEN
		BEGIN
			IF	(Igual(lista.elementos[lista.pOcupadas].elemento, elem)) THEN
			BEGIN
				aux := lista.pOcupadas;
				lista.pOcupadas := lista.elementos[lista.pOcupadas].siguiente;
				lista.elementos[aux].siguiente := lista.pLibres;
				lista.pLibres := aux;
			END
			ELSE
			BEGIN
				aux := lista.pOcupadas;
				WHILE ((lista.elementos[aux].siguiente<>0) AND (NOT(Igual(lista.elementos[aux].elemento, elem)))) DO
				BEGIN
					anterior := aux;
					aux := lista.elementos[aux].siguiente;
				END;

				IF (Igual(lista.elementos[aux].elemento, elem)) THEN
				BEGIN
					x := lista.elementos[anterior].siguiente;
					lista.elementos[anterior].siguiente := lista.elementos[aux].siguiente;
					y := lista.pLibres;
					lista.pLibres := x;
					lista.elementos[lista.pLibres].siguiente := y;
				END;
			END;
		END;
	END;

	PROCEDURE InsertarFinal (elem: tElem; VAR lista: tLista);
	VAR
		aux, nuevo: integer;
	BEGIN
		IF (lista.pLibres <> 0) THEN
		BEGIN
			IF (EsVacia(lista)) THEN
				Construir(elem, lista)
			ELSE
			BEGIN
				aux := lista.pOcupadas;
				WHILE (lista.elementos[aux].siguiente <> 0) DO
				BEGIN
					aux := lista.elementos[aux].siguiente;
				END;

				nuevo := lista.pLibres;
				Asignar(lista.elementos[nuevo].elemento, elem);
				lista.pLibres := lista.elementos[lista.pLibres].siguiente;
				lista.elementos[nuevo].siguiente := 0;
				lista.elementos[aux].siguiente := nuevo;
			END;
		END;
	END;

	(*Contenido adicional para visualizar la lista*)
	PROCEDURE MostrarLista(lista: TLista);
	VAR
		pAux: integer;
	BEGIN
		Write('[');
		IF (NOT EsVacia(lista)) THEN
		BEGIN
			pAux := lista.pOcupadas;
			WHILE (lista.elementos[pAux].siguiente <> 0) DO
			BEGIN
				Mostrar(lista.elementos[pAux].elemento);
				Write(', ');

				pAux := lista.elementos[pAux].siguiente;
			END;
			Mostrar(lista.elementos[pAux].elemento);
		END;
		Writeln(']');
	END;

END.