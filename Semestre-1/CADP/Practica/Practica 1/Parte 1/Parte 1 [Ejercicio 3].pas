program ejercicio3;
var
    x,y,z:integer;
const
    text='En orden de mayor a menor: ';
begin
  writeln ('Introduzca el primer valor: ');
  readln(x);
  writeln ('Introduzca el primer valor: ');
  readln(y);
  writeln ('Introduzca el primer valor: ');
  readln(z);
  if ((x>y) and (x>z)) then
    if (y>z) then
        writeln(text,x,' ',y,' ',z)
    else
        writeln(text,x,' ',z,' ',y);
        
  if ((y>x) and (y>z)) then
    if (x>z) then
        writeln(text,y,' ',x,' ',z)
    else
        writeln(text,y,' ',z,' ',x);
        
  if ((z>x) and (z>y)) then
    if (x>y) then
        writeln(text,z,' ',x,' ',y)
    else
        writeln(text,z,' ',y,' ',x);
end.

