// 3.-Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
// diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
// 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
// promedio otorgado por las críticas.
// Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
// a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
// género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
// código de la película -1.
// b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
// obtenido entre todas las críticas, a partir de la estructura generada en a)..
// c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
// métodos vistos en la teoría.
// d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
// del vector obtenido en el punto c).

program ejercicio3;
const 
  dimF = 8;
type
  r_genero = 1..dimF;

  pelicula = record
    cod_pelicula: integer;
    cod_genero: r_genero;
    puntaje: real;
  end;

  lista = ^nodo;
  nodo = record
    dato: pelicula;
    sig: lista;
  end;

  puntajesXGenero = record
    codigo: integer;
    puntaje: real;
  end;
  vector_genero = array [r_genero] of lista;
  vector_puntajes = array [r_genero] of puntajesXGenero;

procedure IniciarVectorGeneros(var vg:vector_genero);
var
  i:integer;
begin
  for i:=1 to dimF do
    vg[i]:=nil;
end;

procedure IniciarVectorPuntajes (var vp:vector_puntajes);
var i: integer;
begin
  for i:=1 to dimF do begin
    vp[i].codigo:=0;
    vp[i].puntaje:=0;
  end;
end;

procedure LeerPelicula (var p:pelicula);
begin
  writeln('ingrese codigo de pelicula');
  readln(p.cod_pelicula);
  if (p.cod_pelicula<>-1) then begin
    writeln('ingrese codigo de genero');
    readln(p.cod_genero);
    writeln('ingrese puntaje de 1 a 10');
    readln(p.puntaje);
  end;
end;

procedure AgregarAtras(var l: lista; peli: pelicula); // el puntero al ultimo me generaba un problema, no se me actualizaba al cambiar el genero de la pelicula.
var
  nue, act: lista;
begin
  new(nue);
  nue^.dato := peli;
  nue^.sig := nil;
  if (l = nil) then
    l := nue
  else begin
    act := l;
    while (act^.sig <> nil) do
      act := act^.sig;
    act^.sig := nue;
  end;
end;

procedure CargarPeliculas(var vg: vector_genero);
var
  peli: pelicula;
begin
  LeerPelicula(peli);
  while (peli.cod_pelicula <> -1) do begin
    AgregarAtras(vg[peli.cod_genero], peli);
    LeerPelicula(peli);
  end;
end;

procedure ImprimirPeliculas (vg :vector_genero);
var
  i:integer;
  l:lista;
begin
  for i:=1 to dimF do begin
    writeln('Genero ',i, ':');
    l:=vg[i];
    while l <> nil do begin
      writeln (' Codigo de pelicula: ', l^.dato.cod_pelicula);
      writeln (' Puntaje: ', l^.dato.puntaje);
      l:=l^.sig;
    end;
  end;
end;

procedure CargarPuntajesMaximos(vg:vector_genero; var vp:vector_puntajes);
var
  i: integer;
begin
  for i:=1 to dimF do begin
    while vg[i] <> nil do begin
      if (vg[i]^.dato.puntaje > vp[i].puntaje) then begin
        vp[i].puntaje:= vg[i]^.dato.puntaje;
        vp[i].codigo:= vg[i]^.dato.cod_pelicula;
      end;
      vg[i]:=vg[i]^.sig;
    end;
  end;
end;

procedure ImprimirVectorPuntaje (vp: vector_puntajes);
var
  i:integer;
begin
  for i:=1 to dimF do begin
    writeln('El puntaje maximo de la categoria ', i, ' es ', vp[i].puntaje:0:2, ' y es la pelicula ', vp[i].codigo);
  end;
end;

procedure OrdenarVectorPuntaje(var vp:vector_puntajes);
var
  i, j, pos: integer;
  item: venta;
begin
  for i:= 1 to dimF - 1 do begin
    pos:= i;
    for j:= i+1 to dimL do
      if (vp[j].puntaje < vp[pos].puntaje) then
        pos:= j;
    item:= vp[pos];
    vp[pos]:= vp[i];
    vp[i]:= item;
  end;
end;

var
  vg: vector_genero;
  vp: vector_puntajes;
begin
  IniciarVectorGeneros(vg);
  IniciarVectorPuntajes(vp);
  CargarPeliculas(vg);
  ImprimirPeliculas(vg);
  CargarPuntajesMaximos(vg,vp);
  ImprimirVectorPuntaje(vp);
  OrdenarVectorPuntaje(vp);
  writeln ('el codigo con mayor puntaje es ', vp[dimF].codigo);
  writeln ('el codigo con menor puntaje es ', vp[1].codigo);
end.



