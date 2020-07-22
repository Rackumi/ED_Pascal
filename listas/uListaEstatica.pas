(* IMPLEMENTACIÓN LISTA ESTÁTICA *)

UNIT uListaEstatica;

INTERFACE

	USES uElem;

	CONST
	   N = 100;

	TYPE
	   TAlmacen = ARRAY [1..N] OF TElem;
	   TLista = RECORD
			almacen: TAlmacen;
			ultimo: integer;
		END;

   (* Constructoras generadoras *)
   PROCEDURE CrearVacia (VAR lista: TLista);
   PROCEDURE Construir (elemento: TElem; VAR lista: TLista);

   (* Observadoras selectoras *)
   PROCEDURE Primero (lista: TLista; VAR elemento: TElem);
   PROCEDURE Resto (lista: TLista; VAR res: TLista);
   PROCEDURE Resto1 (VAR lista: TLista);

   (* Observadoras no selectoras *)
   FUNCTION EsVacia (lista: TLista): boolean;
   FUNCTION Longitud (lista: TLista): integer;
   FUNCTION Pertenece (elemento: TElem; lista: TLista): boolean;
   PROCEDURE Ultimo (l: Tlista; VAR e: TElem);

   (* Constructoras no generadoras *)
   PROCEDURE Concatenar (l1, l2: TLista; VAR l: TLista);
   PROCEDURE BorrarElemento (elem: TElem; VAR l: TLista);
   PROCEDURE InsertarFinal (elem: TElem; VAR l: TLista);

IMPLEMENTATION

	PROCEDURE CrearVacia (VAR lista: TLista);
	BEGIN
		lista.ultimo := 0;
	END;

	PROCEDURE Construir (elemento: TElem; VAR lista: TLista);
	VAR
		i: integer;
	BEGIN
		IF lista.ultimo<N THEN
			BEGIN
	        lista.ultimo := lista.ultimo + 1;
	        FOR i:= lista.ultimo DOWNTO 2 DO
	        BEGIN
	        	Asignar(lista.almacen[i], lista.almacen[i-1]);
	        END;
	        Asignar (lista.almacen[1], elemento);
		END
	END;

	PROCEDURE Primero (lista:TLista; VAR elemento:TElem);
	BEGIN
		IF NOT EsVacia(lista) THEN
	  		Asignar (elemento, lista.almacen[1]);
	END;

	PROCEDURE Resto (lista: TLista; VAR res: TLista);
	(* Crea una lista nueva *)
	VAR
		i: integer;
	BEGIN
		IF NOT EsVacia(lista) THEN
		BEGIN
	    	CrearVacia(res);
	        FOR i:=2 TO lista.ultimo DO
	        BEGIN
	        	Asignar (res.almacen[i-1], lista.almacen[i]);
	        END;
	        res.ultimo := lista.ultimo-1;
	     END;
	END;

	PROCEDURE Resto1 (VAR lista: TLista);
	(* Modifica la lista *)
	VAR
		i: integer;
	BEGIN
		IF NOT EsVacia(lista) THEN
		BEGIN
	    	FOR i:=2 TO lista.ultimo DO
	       	BEGIN
	           Asignar (lista.almacen[i-1], lista.almacen[i]);
	        END;
	        lista.ultimo := lista.ultimo-1;
		END;
	END;

	FUNCTION EsVacia (lista: TLista): boolean;
	BEGIN
		EsVacia := (lista.ultimo = 0);
	END;

	FUNCTION Longitud (lista: TLista): integer;
	BEGIN
		Longitud := lista.ultimo;
	END;

	FUNCTION Pertenece (elemento: TElem; lista: TLista): boolean;
	VAR
		i: integer;
	BEGIN
		IF (EsVacia(lista)) THEN
			Pertenece := FALSE
		ELSE
		BEGIN
			i:= 0;
			REPEAT
		    	i:= i + 1;
			UNTIL (Igual(lista.almacen[i],elemento)) OR (i=lista.ultimo);
			Pertenece := Igual(lista.almacen[i],elemento);
		END;
	END;

	PROCEDURE Ultimo (l:Tlista; VAR e:TElem);
	BEGIN
		IF NOT (EsVacia(l)) THEN
			Asignar(e, l.almacen[l.ultimo]);
	END;

	PROCEDURE Concatenar (l1,l2: TLista; VAR l: TLista);
	VAR
		prim: TElem;
	    i: integer;
	BEGIN
		IF (Longitud(l1) + Longitud(l2))<=N THEN
	    	BEGIN
	    	CrearVacia(l);
	    	FOR i:=1 TO l1.ultimo DO
	       	BEGIN
	            Primero (l1, prim);
	            InsertarFinal(prim, l);
	            Resto1(l1);
	        END;
	      	FOR i:=1 TO l2.ultimo DO
	        BEGIN
	             Primero (l2, prim);
	             InsertarFinal(prim, l);
	             Resto1(l2);
	        END;
		END;
	END;

	PROCEDURE BorrarElemento (elem:TElem; VAR l:TLista);
	VAR
		i, j: integer;
	BEGIN
	  	i:= 0;
	   	REPEAT
	    	i:= i + 1;
	  	UNTIL (Igual(l.almacen[i],elem)) OR (i=l.ultimo);
	   	IF Igual(l.almacen[i],elem) THEN
	    BEGIN
	    	FOR j:=i TO l.ultimo - 1 DO
	    	BEGIN
	        	l.almacen[j]:=l.almacen[j+1];
	        END;
	        l.ultimo := l.ultimo - 1;
		END;
	END;

	PROCEDURE InsertarFinal (elem:TElem; VAR l:TLista);
	BEGIN
		IF l.ultimo<N THEN
	    BEGIN
	    	Asignar(l.almacen[l.ultimo + 1], elem);
	    	l.ultimo := l.ultimo + 1;
	    END;
	END;

END.