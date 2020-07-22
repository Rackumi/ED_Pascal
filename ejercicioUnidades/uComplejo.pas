UNIT uComplejo;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
{
INTERFACE

	TYPE
		tComplejo = RECORD
			pReal, pImag: real;
		END;

	PROCEDURE crearComplejo(r, i: real; VAR c: tComplejo);

	PROCEDURE sumarComplejo(c1, c2: tComplejo; VAR s: tComplejo);

	PROCEDURE escribirComplejo(c: tComplejo);

IMPLEMENTATION

	PROCEDURE crearComplejo(r, i: real; VAR c: tComplejo);

	BEGIN
		c.pReal := r;
		c.pImag := i;
	END;

	PROCEDURE sumarComplejo(c1, c2: tComplejo; VAR s: tComplejo);
	BEGIN
		s.pReal := c1.pReal + c2.pReal;
		s.pImag := c1.pImag+ c2.pImag;
	END;

	PROCEDURE escribirComplejo(c: tComplejo);
	BEGIN
		write('El numero complejo se compone de: ', c.pReal:0:2, ' ');
		IF (c.pImag <> 0) THEN
			write (c.pImag:0:2);

		writeln();
	END;
END.
}
{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

INTERFACE

	TYPE
		tComplejo = ARRAY[0..1] OF REAL;


	PROCEDURE crearComplejo(r, i: real; VAR c: tComplejo);

	PROCEDURE sumarComplejo(c1, c2: tComplejo; VAR s: tComplejo);

	PROCEDURE escribirComplejo(c: tComplejo);

IMPLEMENTATION

	PROCEDURE crearComplejo(r, i: real; VAR c: tComplejo);

	BEGIN
		c[0] := r;
		c[1] := i;
	END;

	PROCEDURE sumarComplejo(c1, c2: tComplejo; VAR s: tComplejo);
	BEGIN
		s[0] := c1[0] + c2[0];
		s[1] := c1[1] + c2[1];
	END;

	PROCEDURE escribirComplejo(c: tComplejo);
	BEGIN
		write('El numero complejo se compone de: ', c[0]:0:2, ' ');
		IF (c[1] <> 0) THEN
			write (c[1]:0:2);

		writeln();
	END;
END.