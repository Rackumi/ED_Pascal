UNIT uMatriz;

INTERFACE

	USES
		uComplejo;

	CONST
		MAX = 2;
	TYPE
		rango = 1..MAX;

		tMatriz = ARRAY[rango, rango] OF tComplejo;

	PROCEDURE leerMatriz (VAR m: tMatriz);

	PROCEDURE sumarMatrices (m1, m2: tMatriz; VAR m3: tMatriz);

	PROCEDURE escribirMatriz (m: tMatriz);

IMPLEMENTATION

	PROCEDURE leerMatriz (VAR m: tMatriz);
	VAR
		i, j: integer;
		re, im: real;
	BEGIN
		FOR i:=1 TO MAX DO
		BEGIN
			FOR j:=1 TO MAX DO
			BEGIN
				writeln('Escribir parte real');
				readln(re);
				writeln('Escribir parte imaginaria');
				readln(im);
				crearComplejo(re, im, m[i][j]);
			END;
		END;
	END;

	PROCEDURE sumarMatrices (m1, m2: tMatriz; VAR m3: tMatriz);

	VAR
		 i, j: integer;
	BEGIN

		FOR i:=1 TO MAX DO
		BEGIN
			FOR j:=1 TO MAX DO
			BEGIN
				sumarComplejo(m1[i][j],m2[i][j],m3[i][j]);
			END;
		END;
	END;

	PROCEDURE escribirMatriz (m: tMatriz);
	VAR
		 i, j: integer;
	BEGIN

		FOR i:=1 TO MAX DO
		BEGIN
			FOR j:=1 TO MAX DO
			BEGIN
				writeln('La matriz se compone de: ');
				escribirComplejo(m[i][j]);
			END;
		END;
	END;
END.