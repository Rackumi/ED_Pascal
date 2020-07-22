PROGRAM mainPunteros;

	CONST
		MAX = 10;

	TYPE
		rango = 1..MAX;
		TPuntEnt = ^INTEGER;
		pArray = ARRAY[rango] OF TPuntEnt;

		TPuntChar = ^char;
		pArrayChar = ARRAY[rango] OF TPuntChar;

	VAR
		punterArray : pArray;

		punterArrayChar : pArrayChar;

	PROCEDURE leer(a: pArray);
	VAR
		i : INTEGER;
	BEGIN
		FOR i:=1 TO MAX DO
		BEGIN
			writeln(a[i]^);
		END;
	END;

	PROCEDURE ejercicio1(VAR a: pArray);						{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EJERCICIO 1 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
	VAR
		i : INTEGER;
	BEGIN
		FOR i:=1 TO MAX DO
		BEGIN
			NEW(a[i]);
			a[i]^ := i;
			writeln(a[i]^);
		END;
	END;

	FUNCTION ejercicio2(a: pArray):INTEGER;						{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EJERCICIO 2 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
	VAR
		i, aux : INTEGER;

	BEGIN
		aux := 0;
		FOR i := 1 TO MAX DO
		BEGIN
			aux := aux + a[i]^;
		END;
		ejercicio2 := aux;
	END;

	PROCEDURE ejercicio3(a: pArray; b: INTEGER);				{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EJERCICIO 3 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
	VAR
		i : INTEGER;
	BEGIN
		FOR i := 1 TO MAX DO
		BEGIN
			IF(a[i]^ < b)THEN
			BEGIN
				DISPOSE(a[i]);
				a[i] := NIL;
			END;
		END;
	END;

	PROCEDURE ejercicio4(VAR arr: pArray; b: rango; c: rango);	{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EJERCICIO 4 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

	VAR
		aux : INTEGER;
	BEGIN
		aux := arr[b]^;
		arr[b]^ := arr[c]^;
		arr[c]^ := aux;
	END;

	FUNCTION ejercicio5(a: pArrayChar; b: CHAR): INTEGER;	{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EJERCICIO 5 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
	VAR
		i, aux: INTEGER;
	BEGIN
		aux := 0;
		FOR i := 1 TO MAX DO
		BEGIN
			NEW(a[i]);
			readln(a[i]^);
		END;

		a[1] := @b;
		a[2] := @b;

		FOR i := 1 TO MAX DO
		BEGIN
			IF(a[i] = @b)THEN
				aux := aux +1;
		END;

		ejercicio5 := aux;
	END;

	BEGIN														{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    MAIN    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

		writeln('Ejercicio 1');
		ejercicio1(punterArray);

		writeln('Ejercicio 2');
		writeln(ejercicio2(punterArray));

		writeln('Ejercicio 3');
		ejercicio3(punterArray,1);

		writeln('Ejercicio 4');
		ejercicio4(punterArray,1,2);

		writeln('Ejercicio 5');
		writeln(ejercicio5(punterArrayChar, 'a'));

		writeln('Leer');
		leer(punterArray);
		readln;

	END.