{3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado, el cual se proporciona desde el teclado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}

program ejercicio3;
type
    empleado = record
        numero: integer;
        apellido: string[20];
        nombre: string[20];
        edad: integer;
        dni: integer;
    end;
    archivo = file of empleado;

procedure imprimirUnEmpleado(e: empleado);
begin
    writeln('Numero: ', e.numero, ', Apellido: ', e.apellido, ', Nombre: ', e.nombre, ', Edad: ', e.edad, ', DNI: ', e.dni);
end;
//---------------A-----------------
procedure leerEmpleado(var e: empleado);
begin
    writeln('Ingrese el apellido del empleado');
    readln(e.apellido);
    if(e.apellido<> 'fin') then
        begin
            writeln('Ingrese el nombre del empleado');
            readln(e.nombre);
            writeln('Ingrese el numero del empleado');
            readln(e.numero);
            writeln('Ingrese edad del empleado');
            readln(e.edad);
            writeln('Ingrese el DNI del empleado');
            readln(e.dni);
        end;
end;

procedure cargarEmpleados(var arch: archivo);
var
    e:empleado;
begin
    leerEmpleado(e);
    while(e.apellido <> 'fin') do begin
        write(arch, e);
        leerEmpleado(e);
    end;
    close(arch);
end;
//----------------------B-------------------------
function cumple(nombre, apellido, dato:string): boolean;
begin
    cumple:= ((nombre = dato) or (apellido = dato));
end;
procedure empleadosX(var arch: archivo);
var
    dato: string[20];
    e:empleado;
begin
    reset(arch);
    writeln('Ingrese nombre o apellido de empleado');
    readln(dato);
    writeln('Emleados que tienen nombre o apellido iguales a ', dato,': ');
    while(not EOF(arch)) do begin
        read(arch, e);
        if(cumple(e.nombre, e.apellido, dato)) then
            imprimirUnEmpleado(e);
    end;
    close(arch);
end;

procedure imprimirEmpleados(var arch: archivo);
var
    e:empleado;
begin
    reset(arch);
    writeln('Listado de empleados: ');
    while(not EOF(arch)) do begin
        read(arch, e);
        imprimirUnEmpleado(e);
    end;
    close(arch);
end;

procedure mayores70(var arch: archivo);
var
    e:empleado;
begin
    reset(arch);
    writeln('Lista de empleados mayores a 70 de anios, prontos a jubilarse: ');
    while(not EOF(arch)) do begin
        read(arch, e);
        if(e.edad > 70) then
            imprimirUnEmpleado(e);
    end;
    close(arch);
end;
//-------------------MENU--------------------------
procedure menuInicial(var arch:archivo);
var
    opcion: integer;
begin
    writeln('MENU PRINCIPAL: Ingrese una opcion');
    writeln('Opcion 1: Lista de empleados segun nombre o apellido elegido');
    writeln('Opcion 2: Lista de etodos los empleados de a uno por linea');
    writeln('Opcion 3: Lista de empleados mayores a 70 años');
    writeln('Opcion 4: Salir');
    readln(opcion);
    while(opcion<>4) do begin
        case opcion of
            1: empleadosX(arch);
            2: imprimirEmpleados(arch);
            3: mayores70(arch);
        else
            writeln('Opcion incorrecta');
        end;
        writeln();
        writeln('MENU PRINCIPAL: Ingrese una opcion');
        writeln('Opcion 1: Lista de empleados segun nombre o apellido elegido');
        writeln('Opcion 2: Lista de etodos los empleados de a uno por linea');
        writeln('Opcion 3: Lista de empleados mayores a 70 años');
        writeln('Opcion 4: Salir');
        readln(opcion);
    end;
end;

//-----------------Programa------------------

var
    arch: archivo;
    nombre: string[15];
begin
    writeln('Inrese nombre archivo');
    readln(nombre);
    assign(arch, nombre);
    rewrite(arch);
    cargarEmpleados(arch);
    //close(arch);
    //reset(arch);  //Lo reabre en modo lectura para usar en el menú
    menuInicial(arch);
    close(arch);
end.






