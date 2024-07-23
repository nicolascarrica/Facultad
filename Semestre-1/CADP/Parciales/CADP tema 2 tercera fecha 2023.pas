{Tema 2
    
    Una revista deportiva dispone de informacion de los jugadores de basquet participantes de la liga profesional 2022.
    De cada jugador se conoce codigo de jugador, apellido y nombres, codigo de equipo (1..20), año de nacimiento y 
    la calificacion obtenida para cada una de las 18 fechas del toneo ya finalizado. La calificacion es numerica (0..10)
    donde 0 significa que el jugador no participo en la fecha.
    
    se solicita:
    
    A- informar para cada equipo la cantidad de jugadores menores de 30 años-
    B- Informar los codigos de los 2 jugadores con menor calificacion promedio en los partidos en los que participo. Solo
       se consideran a los jugadores que participaron en mas de 9 fechas
    C-(completo) Implementar e invocar un modulo que genere una lista con los jugadores cuyo codigo posee exactamente
                 2 digitos pares y haya nacido entre 1987 y 1991. La lista debe ordenarse por codigo del jugador.
}


program tema2;
const
    dimF=18;                    {constante de fechas del torneo}
    año=2022;                   {constante año (liga profesional 2022)}
type
    codigo = 1..20;             {rango equipos}
    calif = 0..10;              {rango calificaciones}
    
    vector = array [1..dimF] of calif;          {vector para las fechas}
    
    vectorEquipos = array [codigo] of integer;  {vector contador equipos} 
    {no es el mismo vector porque son dimensiones y rangos distintos, mas complicado}
    
    jugadores = record                  {registro por jugador}
        cod,añoNacimiento:integer;
        apellidoNombre:string;
        equipo:codigo;
        calificacion:vector;
    end;
    
    lista = ^nodo;
                                        {lista}
    nodo = record
        jugador:jugadores;
        sig:lista;
    end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////{Proceso para armar lista original, se dispone} 

procedure armarLista(var l:lista; j:jugadores); {se dispone}
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////{modulos para inciso A}
  
function menor30 (a:integer):boolean;
begin
    menor30:=((año-a)<30);          {retorna true si constante año menos a es menor a 30}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure cargarVectorE(var ve:vectorEquipos);
var
    i:integer;
begin
    for i:=1 to 20 do
        ve[i]:=0;           {inicializa los contadores en 0}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////{modulos para inciso B}

function promedio (v:vector):real;          {solo entra aqui si cumple con el requisito de haber jugado en mas de 9 fechas, esta mas adelante}
var
    i,totalCalif:integer;
begin
    totalCalif:=0;
    for i:=1 to dimF do
        totalCalif:= totalCalif + v[i];     {recorre el vector previamente cargado y suma todas las calificaciones}
    promedio:= (totalCalif/dimF);           {retorna el total de calificaciones entre dimF (18 fechas)}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

function fechas(v:vector):boolean;
var
    i,contador:integer;
begin
    contador:=0;
    for i:= 1 to dimF do
        if (v[i]<>0) then               {toma en cuenta solo las fechas con calificacion distinta de 0, es decir, donde participo el jugador}
            contador:=contador + 1;
    fechas:=(contador > 9);             {retorna true si el total de fechas jugadas es mayor a 9}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure menorCalificacion (var cod1,cod2:integer; j:jugadores);
var
    prom,prom1,prom2:real;
begin
    prom:=0;
    prom1:=0;
    prom2:=0;
    prom:=promedio(j.calificacion);     {obtener el promedio mediante la funcion promedio}
    if (prom < prom1) or (prom1=0) then begin
        prom2:=prom1;
        cod2:=cod1;
        prom1:=prom;
        cod1:=j.cod;
    end
    else if (prom < prom2) or (prom2=0) then begin
        prom2:=prom;
        cod2:=j.cod;
    end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////{modulos para inciso C}

function pares(a:integer):boolean;
var
    num,dig,cont:integer;
begin
    cont:=0;
    num:=a;
    while (num<>0) do begin
        dig:= num mod 10;
        if (dig mod 2 = 0) then     {descomponer el numero y contar solo los digitos pares}
            cont:=cont+1;
        num:= num div 10;
    end;
    pares:= (cont = 2); {retorna true si el codigo del jugador tiene exactamente 2 digitos pares}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure insertarOrdenado(var l2:lista; j:jugadores);
var
    nue,act,ant:lista;
begin
    new(nue);
    nue^.jugador:=j;
    act:=l2;
    ant:=l2;
    while (act <> nil) and (j.cod < act^.jugador.cod) do begin
        ant:=act;
        act:=act^.sig;
    end;
    if (act=ant) then
        l2:=nue;
    else
        ant^.sig:=nue;
    nue^.sig:=act;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////{procesar datos}

procedure procesarListas(var l,l2:lista);
var
    i,cod1,cod2:integer;
    ve:vectorEquipos;
begin
    cargarVectorE(ve);                                           {cargar vector contador por equipos}
    while (l<>nil) do begin     {recorrer lista original}
        if (menor30(l^.jugador.añoNacimiento)) then             {si cumple con ser menor a 30 años, suma al vector contador por equipos}
            v[l^.jugador.equipo]:=v[l^.jugador.equipo] + 1;
        if (fechas(l^.jugador.calificacion)) then               {si el jugador participo en mas de 9 fechas, evalua y compara cual tiene menor calificacion promedio}
            menor30(cod1,cod2,l^.jugador);                      
        if ((pares(l^.jugador.cod)) and (l^.jugador.añoNacimiento >=1987) and (l^.jugador.añoNacimiento <=1991)) then   {si el codigo del jugador tiene 2 pares exactamente y nacio entre 1987 y 1991}
                                                                                                                        {toma el registro cargado en la lista original y lo inserta ordenadamente en la nueva lista}
            insertarOrdenado(l2,l^.jugador);    {C}
        l:=l^.sig;  {siguiente nodo}
    end;
    for i:=1 to 20 do       {informar la cantidad de jugadores por equipo que tienen menos de 30 años} {A}
        writeln(ve[i]); 
    writeln(cod1,cod2);     {informar los codigos de los jugadores con menor calificacion promedio, que hayan participado mas de 9 veces} {B}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////{programa principal}

var
    l,l2:lista;
begin
    l:=nil;
    l2:=nil;
    armarLista(l); {se dispone}
    procesarListas(l,l2);
    {el enunciado dice invocar un modulo pero en mi aula dijeron que daba igual si lo invocabamos en el principal o en el recorrido}
end.