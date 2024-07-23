program proyectos;
type
  str40 = string[40];
  // persona = record
  //   dni: integer;
  //   nombre: str40;
  //   apellido: str40;
  //   email: str40;
  // end;
  proyecto = record
    codigo: integer;
    titulo: str40;
    //docente: persona;
    alumno: integer;
    nombreEsc: str40;
    localidad: str40;
  end;

  // procedure LeerDocente(var docente: persona);
  // begin
  //   writeln('Ingrese el dni del docente');
  //   readln(docente.dni);
  //   writeln('Ingrese el nombre del docente');
  //   readln(docente.nombre);
  //   writeln('Ingrese el apellido del docente');
  //   readln(docente.apellido);
  //   writeln('Ingrese el email del docente');
  //   readln(docente.email);
  // end;

  procedure LeerProyecto(var proyecto: proyecto);
  begin
    writeln('Ingrese el codigo del proyecto');
    readln(proyecto.codigo);
    if (proyecto.codigo <> -1) then
    begin
      writeln('Ingrese el titulo del proyecto');
      readln(proyecto.titulo);
      // LeerDocente(proyecto.docente);
      writeln('Ingrese la cantidad de alumnos');
      readln(proyecto.alumno);
      writeln('Ingrese el nombre de la escuela');
      readln(proyecto.nombreEsc);
      writeln('Ingrese la localidad');
      readln(proyecto.localidad);
    end;
    writeln('-------------------------');
  end;

  procedure masAlumnos(alumno: integer; nombreEsc: str40; var max1, max2: integer; var esc1, esc2: str40);
  begin
    if (alumno > max1) then begin
      max2 := max1;
      esc2 := esc1;
      max1 := alumno;
      esc1 := nombreEsc;
    end
    else if (alumno > max2) then begin
      max2 := alumno;
      esc2 := nombreEsc;
    end;
  end;

  function paresImpares(codigo: integer): boolean;
  var
    digito, pares, impares: integer;
    ok: boolean;
  begin
    ok := true;
    pares := 0;
    impares := 0;
    while (codigo <> 0) do begin
      digito := codigo MOD 10;
      if (digito MOD 2 = 0) then
        pares := pares + 1
      else
        impares := impares + 1;
      codigo := codigo DIV 10;
    end;
    if (pares = impares) then
      ok := true
    else
      ok := false;
    paresImpares := ok;
  end;

  var 
    p: proyecto;
    max1, max2: integer;
    esc1, esc2: str40;
    totalEscuelas, escuelasLocalidad: integer;
    localidadActual, escuelaActual: str40;
    cantidadAlumnosEscuela: integer;

begin
  max1 := 0;
  max2 := 0;
  esc1 := '';
  esc2 := '';
  totalEscuelas := 0;
  LeerProyecto(p);
  while (p.codigo <> -1) do begin
    escuelasLocalidad := 0;
    localidadActual := p.localidad;
    while (p.localidad=localidadActual) and (p.codigo<>-1) do begin // localidad
      if (localidadActual = 'Daireaux') and (paresImpares(p.codigo)) then
      writeln('El proyecto de titulo ',p.titulo,' posee en su codigo la misma cantidad de digitos pares e impares');
      escuelaActual := p.nombreEsc;
      escuelasLocalidad := escuelasLocalidad + 1;
      cantidadAlumnosEscuela := 0;
      while (p.nombreEsc=escuelaActual) and (p.codigo<>-1) do begin // escuela
        cantidadAlumnosEscuela := cantidadAlumnosEscuela + p.alumno;
        masAlumnos(cantidadAlumnosEscuela,escuelaActual, max1, max2, esc1, esc2);
        LeerProyecto(p);
      end;
      totalEscuelas := totalEscuelas + 1;
    end;
    writeln('La localidad ',localidadActual,' tiene ',escuelasLocalidad,' escuelas');
  end;
  writeln('La comision tiene ',totalEscuelas,' escuelas');
  writeln('La escuela con mayor cantidad de alumno participantes es ',esc1,' con ',max1,' alumnos');
  writeln('La escuela con la segunda mayor cantidad de alumno participantes es ',esc2,' con ',max2,' alumnos');

end.





    