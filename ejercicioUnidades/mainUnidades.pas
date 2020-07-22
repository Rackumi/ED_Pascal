PROGRAM mainUnidades;

USES
	uMatriz;

VAR
	m1, m2, m3 : tMatriz;
BEGIN

	writeln('Crea una matriz_1: ');
	leerMatriz(m1);
	escribirMatriz(m1);

	writeln;

	writeln('Crea una matriz_2: ');
	leerMatriz(m2);
	escribirMatriz(m2);

	writeln;

	writeln('A continuacion se sumaran las matrices introducidas previamente: ');
	readln();
	sumarMatrices(m1,m2,m3);
	escribirMatriz(m3);

	readln;
	
END.