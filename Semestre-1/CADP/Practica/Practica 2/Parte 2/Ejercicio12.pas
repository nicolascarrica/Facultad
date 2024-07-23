program ejercicio14;
type
    zona=1..3;
procedure ingresar_Datos(var hectariasF:integer;var Tipo_ZonaF:zona;var Precio_ToneladaF:real);
begin
    Writeln('Ingrese Hectarias: ');
    Readln(hectariasF);
    writeln('Ingrese tipo de zona:');
    writeln('1: Zona muy fertil');
    writeln('2: Zona estandar');
    writeln('3: Zona arida');
    ReadLn(Tipo_ZonaF);
    Writeln('Ingrece Precio por tonelada: ');
    ReadLn(Precio_ToneladaF);
end;
//___________________________________________________________________________________________
procedure Rendimiento_Economico(var hectariasR:integer;var Tipo_ZonaR:zona;var Precio_ToneladaR:real;RendimientoF:real);
begin
    case(Tipo_ZonaR) of
    1: RendimientoF:= 6 * hectariasR * Precio_ToneladaR;
    2: RendimientoF:= 2.6 * hectariasR * Precio_ToneladaR;
    3: RendimientoF:= 1.4 * hectariasR * Precio_ToneladaR;
    else
        write('Su opcion es invalida');
    end;
    writeln('El rendimiento economico es: ', RendimientoF:6:2,'$');
end;

//___________________________________________________________________________________________
var
  Hectarias:integer;
  Tipo_Zona:zona;
  Precio_Tonelada:real;
  Rendimiento:real;
begin
    Rendimiento:=0;
    ingresar_Datos(Hectarias,Tipo_Zona,Precio_Tonelada);
    Rendimiento_Economico(Hectarias,Tipo_Zona,Precio_Tonelada,Rendimiento);
end.