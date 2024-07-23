program Arba;
const precio_soja=320;
type
  zona=1..3;
procedure leerDatos(var localidad: string; var hectareas: integer; var tipo_zona: zona);
begin
  writeln ('Ingrese Localidad: ');
  readln(localidad);
  writeln ('Ingrese Hectareas: ');
  readln(hectareas);
  writeln ('Ingrese Tipo de zona: ');
  writeln ('1: Zona muy fertil');
  writeln ('2: Zona estandar');
  writeln ('3: Zona arida');
  readln(tipo_zona);
end;

function calcular_rendimiento (localidad: string; hectareas: integer; tipo_zona: zona): real;
var
  rendimiento: real;
begin
  case (tipo_zona) of
    1: rendimiento := hectareas * 6 * precio_soja;
    2: rendimiento := hectareas * 2.6 * precio_soja;
    3: rendimiento := hectareas * 1.4 * precio_soja;
    else
      writeln ('Opcion invalida');
  end;

  calcular_rendimiento := rendimiento;
end;

procedure contador_campos (localidad: string; rendimiento: real; var contadorCampos: integer);
begin
  if (localidad = 'tres de febrero') and (rendimiento >= 10000) then
    contadorCampos := contadorCampos + 1;
end;

procedure rendimiento_maximo (localidad: string; var localidadMayor: string; var rendimiento: real; var rendimientoMayor: real);
begin
  if(rendimiento > rendimientoMayor) then
  begin
    rendimientoMayor := rendimiento;
    localidadMayor := localidad;
  end;
end;

procedure rendimiento_minimo (localidad: string; var localidadMenor: string; var rendimiento: real; var rendimientoMenor: real);
begin
  if(rendimiento < rendimientoMenor) then
  begin
    rendimientoMenor := rendimiento;
    localidadMenor := localidad;
  end;
end;

var
  localidad: string;
  hectareas: integer;
  tipo_zona: zona;
  rendimiento: real;
  contadorCampos: integer;
  localidadMayor: string;
  rendimientoMayor: real;
  localidadMenor: string;
  rendimientoMenor: real;
  sumaRendimientos: real;
  contadorDatosos: integer;
begin
  contadorCampos:=0;
  rendimientoMayor:=0;
  rendimientoMenor:=5000000;
  sumaRendimientos:=0;
  contadorDatosos:=0;
  repeat 
  leerDatos(localidad, hectareas, tipo_zona);
  rendimiento := calcular_rendimiento(localidad, hectareas, tipo_zona);
  writeln ('El rendimiento esperado es de ',rendimiento:0:2,' US$');
  contador_campos(localidad, rendimiento, contadorCampos);
  rendimiento_maximo(localidad, localidadMayor, rendimiento, rendimientoMayor);
  rendimiento_minimo(localidad, localidadMenor, rendimiento, rendimientoMenor);
  sumaRendimientos := sumaRendimientos + rendimiento;
  contadorDatosos := contadorDatosos + 1;
  until (hectareas = 900) and (localidad = 'saladillo');
  writeln ('Hay ', contadorCampos,' campos en Tres de Febrero con rendimiento estimado superior a 10000US$');
  writeln('La localidad de mayor rendimiento es: ',localidadMayor, ' con ', rendimientoMayor:0:2,' US$');
  writeln('La localidad de menor rendimiento es: ',localidadMenor, ' con ', rendimientoMenor:0:2,' US$');
  writeln('El promedio de rendimiento es: ',sumaRendimientos/contadorDatosos:0:2,' US$');
  
end.
