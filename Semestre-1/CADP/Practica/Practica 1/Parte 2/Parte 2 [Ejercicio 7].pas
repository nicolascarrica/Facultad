program ejercicio7;
var
	nombre, primero,segundo,anteultimo,ultimo: string;
	tiempo, tPri,tSeg,tAntUlt,tUlt: real;
	i: integer;

begin
	tPri:= MaxInt;
	tSeg:=MaxInt;
	tAntUlt:=0;
	tUlt:=0;

for i:= 0 to 99 do begin
	writeln ('ingrese nombre de un piloto');
	readln (nombre);
	writeln ('ingrese tiempo del piloto');
	readln (tiempo); 
	if (tiempo <tPri) then begin
	    tSeg:=tPri;
	    tPri:=tiempo;
	    segundo:=primero;
		primero:=nombre;
	end
	else 
	if (tiempo > tPri) and (tiempo <tSeg) then begin
        tSeg:=tiempo;
		segundo:= nombre;
	end
	else 
	if (tiempo >tUlt) then begin
		tAntUlt:=tUlt;
		tUlt:=tiempo;
		anteultimo:=ultimo;
		ultimo:= nombre;
	end
	else 
	if (tiempo <tUlt) and (tiempo >tAntUlt) then begin
	    tAntUlt:=tiempo;
		anteultimo:= nombre;
	end;
end;	
writeln ('el piloto ganador fue ', primero,' y el segundo puesto fue conseguido por ', segundo);
writeln ('el ultimo piloto fue ', ultimo,' y el anteultimo puesto fue para ', anteultimo);
end.