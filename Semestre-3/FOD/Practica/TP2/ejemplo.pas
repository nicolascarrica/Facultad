procedure actualizarMaestro(var aM:aMaestro; var vD:vDetalles);
var
    vR:vRegDet;
    min:regDet;
    rM:regMae;
    positivos:integer;
    i:integer;
begin
    reset(aM);
    for i := 1 to DIMF do begin
        reset(vD[i]);
        leerDetalle(vD[i],vR[i]);
    end;

    minimo(vD,vR,min);
    while(min.code <> VALOR_ALTO) do begin
        leerMaestro(aM,rM);
        while(rM.code <> min.code) do
            writeln('- MUNICIPIO CON MAS DE 15 POSITIVOS: Codigo: ',rM.code, ', Nombre: ',rM.nom)
            leerMaestro(aM,rM);
        positivos := 0;
        while(rM.code = min.code) do begin
            positivos := positivos + min.cantPos;
            minimo(vD,vR,min);
        end;
        rM.cantPos := rM.cantPos + positivos;
        seek(aM,filepos(aM)-1);
        write(aM,rM);
        if(rM.cantPos > 15) then
            writeln('- MUNICIPIO CON MAS DE 15 POSITIVOS: Codigo: ',rM.code, ', Nombre: ',rM.nom);
    end;

    for i := 1 to DIMF do
        close(vD[i]);
    close(aM);
end;