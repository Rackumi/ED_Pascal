UNIT uDate;

INTERFACE

	USES dos;

	TYPE
		TDate = RECORD
			day, month, year: integer;
		END;

	PROCEDURE Init(VAR f: TDate; d,m,y: integer);
	PROCEDURE Leer(var f: TDate);
	FUNCTION Day(f: TDate): integer;
	FUNCTION Month(f: TDate): integer;
	FUNCTION Year(f: TDate): integer;
	PROCEDURE Today(VAR f: TDate);
	PROCEDURE MostrarFecha(f: TDate);

IMPLEMENTATION

	PROCEDURE Init(var f: TDate; d,m,y: integer);
	BEGIN
		f.day:= d;
		f.month:= m;
		f.year:= y
	END;

	PROCEDURE Leer(VAR f: TDate);
	BEGIN
		write('   Enter a day: ');
		readln(f.day);
		write('   Enter a month: ');
		readln(f.month);
		write('   Enter a year: ');
		readln(f.year);
	END;

	FUNCTION Day(f: TDate): integer;
	BEGIN
		Day:= f.day
	END;

	FUNCTION Month(f: TDate): integer;
	BEGIN
		Month:= f.month
	END;

	FUNCTION Year(f: TDate): integer;
	BEGIN
		Year:= f.year
	END;

	PROCEDURE Today(var f: TDate);
	VAR
		a,m,d,ds: Word;
	BEGIN
		getdate(a,m,d,ds);
		Init(f,d,m,a);
	END;

	PROCEDURE MostrarFecha(f: TDate);
	BEGIN
		writeln(f.day,'/',f.month,'/',f.year);
	END;

END.