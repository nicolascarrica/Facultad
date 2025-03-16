{7. Realizar un programa que permita:
a) Crear un archivo binario a partir de la información almacenada en un archivo de
texto. El nombre del archivo de texto es: “novelas.txt”. La información en el
archivo de texto consiste en: código de novela, nombre, género y precio de
diferentes novelas argentinas. Los datos de cada novela se almacenan en dos
líneas en el archivo de texto. La primera línea contendrá la siguiente información:
código novela, precio y género, y la segunda línea almacenará el nombre de la
novela.
b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar una novela y modificar una existente. Las búsquedas se realizan por
código de novela.
NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado.}
program ejercicio7;
type
  novela = record
    codigo: integer;
    nombre: string[20];
    genero: string;
    precio: real;
  end;

  archivo = file of novela;
procedure leerCampos(var n:novela);
begin
  writeln('Ingrese nombre de novela: ');
  readln(n.nombre);
  writeln('Ingrese genero: ');
  readln(n.genero);
  writeln('Ingrese precio: ');
  readln(n.precio);
end;
procedure leerNovela(var n:novela);
begin
  writeln('Ingrese codigo de novela: ');
  readln(n.codigo);
  if(n.codigo<>0) then begin
    leerCampos(n);  
  end;
end;

procedure crearArchivoBinario(var arch:archivo; var data: text);
var
  n:novela;
  nombre: string;
begin
  writeln('Ingrese nombre del archivo binario: ');
  readln(nombre);
  assign(arch, nombre);
  reset(data);
  rewrite(arch);
  while(not eof(data)) do begin
    readln(data, n.codigo, n.precio, n.genero);
    readln(data, n.nombre);
    write(arch, n);
  end;
  writeln('Archivo binario Cargado');
  close(arch);
  close(data);
end;

procedure agregarNovela(var arch:archivo);
var
  n:novela;
begin
  reset(arch);
  leerNovela(n);
  seek(arch, fileSize(arch));
  while(n.codigo<>0) do begin
    write(arch, n);
    leerNovela(n);
  end;
  close(arch);
end;

procedure editarArchivo(var arch:archivo);
var
  n:novela;
  codigo:integer;
  ok:boolean;
begin
  ok:=false;
  reset(arch);
  writeln('Ingrese el codigo de la novela a modificar: ');
  readln(codigo);
  while(not eof(arch)) and (not ok) do begin
    read(arch, n);
    if(n.codigo = codigo) then begin
      ok:=true;
      leerCampos(n);
      seek(arch, filePos(arch)-1);
      write(arch, n);
      writeln('novela editada, codigo ', codigo);
    end;
  end;
  close(arch);
  if(not ok) then
    writeln('No se encontro el codigo', codigo);
end;

procedure exportarATexto(var arch: archivo; var data: text);
var
  n:novela;
begin
  reset(arch);
  rewrite(data);
  while(not eof(arch)) do begin
    read(arch, n);
    writeln(data, n.codigo, ' ', n.precio, ' ', n.genero);
    writeln(data, n.nombre);
  end;
  close(data);
  close(arch);
end;

procedure menuPrincipal(var arch: archivo);
var
  data:text;
  opcion: integer;
begin
  assign(data, 'novelas.txt');
  writeln('BIENVENIDO');
  writeln('1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto');
  writeln('2: Agregar una novela');
  writeln('3: Modificar una novela');
  writeln('4: Exportar a texto el archivo binario');
  writeln('5: Salir del menu');
  readln(opcion);
  while (opcion <> 5) do begin
    case opcion of
      1: crearArchivoBinario(arch, data);
      2: agregarNovela(arch);
      3: editarArchivo(arch);
      4: exportarATexto(arch, data);
    else
      writeln ('Opcion ingresada incorrecta');
    end;
    writeln();
    writeln('BIENVENIDO');
    writeln('1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto');
    writeln('2: Agregar una novela');
    writeln('3: Modificar una novela');
    writeln('4: Exportar a texto el archivo binario');
    writeln('5: Salir del menu');
    readln(opcion);
  end;
end;

var
  arch: archivo;
begin
  menuPrincipal(arch);
end.
