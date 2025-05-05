// 3- Escribir un programa que defina una estructura Fecha que tenga campos para el día, el 
// mes y el año. Para dicha estructura implemente los siguientes métodos: 
 
// ➢  new: que pasando los parámetros correspondientes, crea una Fecha y la retorna. 
// ➢  es_fecha_valida: retorna true si es una fecha válida, false caso contrario.//tenga en 
// cuenta los años bisiestos también. 
// ➢  es_bisiesto: retorna true si el año de la fecha pertenece a un año bisiesto. 
// ➢  sumar_dias(dias): suma la cantidad de días a la fecha, modificándose 
// ➢  restar_dias(dias): resta la cantidad de días a la fecha, modificándose 
// ➢  es_mayor(una_fecha): que retorna true si la fecha que recibe el mensaje es mayor a 
// la fecha pasada por parámetro. 

struct Fecha {
    dia: u32,
    mes: u32,
    anio: u32,
}

impl Fecha {
  fn new(dia: u32, mes: u32, anio: u32) -> Fecha {
    Fecha { dia, mes, anio }
  }

  fn es_bisiesto(&self) -> bool {
    let estado: bool = (self.anio % 4 == 0) && (self.anio % 100 != 0) || (self.anio % 400 == 0);
    return estado;
  }

  //helper para contar los dias que tiene el mes;
  fn cantidad_de_dias(&self, mes:u32) -> u32 {
    let dias_del_mes: u32 = match mes {
      1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
      4 | 6 | 9 | 11 => 30,
      2 => {
        if self.es_bisiesto() {
          29
        } else {
          28
        }
      }
      _=> 0,
    };

    dias_del_mes
  }

  fn es_fecha_valida(&self) -> bool {
    let mut estado: bool = false;
    if self.mes > 0 && self.mes < 13 && self.anio > 0 {
      let dias_del_mes: u32 = self.cantidad_de_dias(self.mes);
      estado = dias_del_mes !=0 && (self.dia >= 1 && self.dia <= dias_del_mes);
    }
    estado
  }

  fn sumar_dias(&mut self, dias: u32){
    let mut dias_del_mes = self.cantidad_de_dias(self.mes);
    self.dia += dias;

     // Mientras el dia actual sea mayor que la cantidad de dias en el mes actual
    while self.dia > dias_del_mes{
      // Se le restan la cantidad de dias al mes actual
      self.dia -= dias_del_mes;
      // avanza al siguiente mes
      self.mes+=1;
      // si pasamos el mes doce, se incrementa el año y se pasa al mes 1
      if self.mes > 12{
        self.mes=1;
        self.anio+=1;
      }
      // se actualizan los dias del nuevo mes
      dias_del_mes = self.cantidad_de_dias(self.mes);
    } 
  }

  fn restar_dias(&mut self, mut dias: u32){
    // Mientras haya días para restar
    while dias !=0 {
      // Si la cantidad de dias a restar es mayor o igual que el dia actual
      if dias >= self.dia {
        dias -= self.dia;
        // Retrocedemos al mes anterior
        self.mes -= 1;
        // Si el mes es menor que 1, retrocedemos al año anterior
        if self.mes < 1{
          self.mes = 12;
          self.anio -= 1;
        }
        // Actualizamos la cantidad de dias en el nuevo mes
        self.dia = self.cantidad_de_dias(self.mes);
      } else {
        // Si la cantidad de dias a restar es menor que el dia actual,
        // simplemente restamos esa cantidad de días
        self.dia -= dias;
        dias = 0; // Ya no quedan dias por restar
      }
    }
  }

  fn es_mayor(&self, otra_fecha: &Fecha) -> bool {
    let mut mayor: bool = false;
    if self.anio > otra_fecha.anio {
        mayor = true;
    } else if self.anio == otra_fecha.anio && self.mes > otra_fecha.mes {
        mayor = true;
    } else if self.anio == otra_fecha.anio
        && self.mes == otra_fecha.mes
        && self.dia > otra_fecha.dia
    {
        mayor = true;
    }
    mayor
  }

}

#[cfg(test)]
mod test_fecha{
  use super::*;

  #[test]
  fn test_new(){
    let fecha = Fecha::new(17,12,1990);
    assert_eq!(fecha.dia, 17);
    assert_eq!(fecha.mes, 12);
    assert_eq!(fecha.anio, 1990);
  }

  #[test]
  fn test_es_biciesto(){
    let fecha1 = Fecha::new(1, 1, 2020); //divisible x4 y no por 100
    assert_eq!(fecha1.es_bisiesto(), true);

    let fecha2 = Fecha::new(1, 1, 1900); //divisible x 100, no por 400. No bisiesto.
    assert_eq!(fecha2.es_bisiesto(), false);

    let fecha3 = Fecha::new(1, 1, 2000); // divisible x 400. biciesto.
    assert_eq!(fecha3.es_bisiesto(), true);

    let fecha4 = Fecha::new(1, 1, 2023); // no divisible x4. No biciesto.
    assert_eq!(fecha4.es_bisiesto(), false);
  }

  #[test]
  fn test_cantidad_dias(){
    let fecha = Fecha::new(1, 1, 2023);
    assert_eq!(fecha.cantidad_de_dias(1), 31); // enero
    assert_eq!(fecha.cantidad_de_dias(3), 31); // Marzo
    assert_eq!(fecha.cantidad_de_dias(5), 31); // Mayo
    assert_eq!(fecha.cantidad_de_dias(7), 31); // Julio
    assert_eq!(fecha.cantidad_de_dias(8), 31); // Agosto
    assert_eq!(fecha.cantidad_de_dias(10), 31); // Octubre
    assert_eq!(fecha.cantidad_de_dias(12), 31); // Diciembre

    assert_eq!(fecha.cantidad_de_dias(4), 30); // abril
    assert_eq!(fecha.cantidad_de_dias(6), 30); // Junio
    assert_eq!(fecha.cantidad_de_dias(9), 30); // Septiembre
    assert_eq!(fecha.cantidad_de_dias(11), 30); // Noviembre

    assert_eq!(fecha.cantidad_de_dias(2), 28); // Febrero

    // Febrero en año bisiesto
    let fecha3 = Fecha::new(1, 2, 2020);
    assert_eq!(fecha3.cantidad_de_dias(2), 29);

    // Mes inválido
    assert_eq!(fecha.cantidad_de_dias(13), 0);
  }

  #[test]
  fn test_es_fecha_valida(){
    let fecha1 = Fecha::new(15, 10, 2023);
    assert_eq!(fecha1.es_fecha_valida(), true);

    let fecha2 = Fecha::new(32, 1, 2023);
    assert_eq!(fecha2.es_fecha_valida(), false);

    let fecha3 = Fecha::new(1, 0, 2022);
    assert!(!fecha3.es_fecha_valida());
  }

  #[test]
  fn test_sumar_dias(){
    let mut fecha1 = Fecha::new(15, 10, 2023);
    fecha1.sumar_dias(5);
    assert_eq!(fecha1.dia,20);
    assert_eq!(fecha1.mes, 10);
    assert_eq!(fecha1.anio, 2023);

    // Sumar días para cambiar de mes
    let mut fecha2 = Fecha::new(28, 2, 2023);
    fecha2.sumar_dias(5);
    assert_eq!(fecha2.dia, 5);
    assert_eq!(fecha2.mes, 3);
    assert_eq!(fecha2.anio, 2023);

    // Sumar días para cambiar de año
    let mut fecha3 = Fecha::new(30, 12, 2023);
    fecha3.sumar_dias(5);
    assert_eq!(fecha3.dia, 4);
    assert_eq!(fecha3.mes, 1);
    assert_eq!(fecha3.anio, 2024);

    // Sumar muchos días (cruzando varios meses y años)
    let mut fecha4 = Fecha::new(1, 1, 2023);
    fecha4.sumar_dias(365 + 31 + 29);  // 1 año + enero y febrero de 2024 (año bisiesto)
    assert_eq!(fecha4.dia, 1);
    assert_eq!(fecha4.mes, 3);
    assert_eq!(fecha4.anio, 2024);
  }
  
  #[test]
  fn test_restar_dias() {
    // Restar días dentro del mismo mes
    let mut fecha1 = Fecha::new(15, 10, 2023);
    fecha1.restar_dias(5);
    assert_eq!(fecha1.dia, 10);
    assert_eq!(fecha1.mes, 10);
    assert_eq!(fecha1.anio, 2023);

    // Restar días para cambiar de mes
    let mut fecha2 = Fecha::new(3, 3, 2023);
    fecha2.restar_dias(5);
    assert_eq!(fecha2.dia, 26);
    assert_eq!(fecha2.mes, 2);
    assert_eq!(fecha2.anio, 2023);

    // Restar días para cambiar de año
    let mut fecha3 = Fecha::new(2, 1, 2023);
    fecha3.restar_dias(5);
    assert_eq!(fecha3.dia, 28);
    assert_eq!(fecha3.mes, 12);
    assert_eq!(fecha3.anio, 2022);

    // Restar muchos días (cruzando varios meses y años)
    let mut fecha4 = Fecha::new(1, 3, 2024);  // 1 de marzo de 2024 (año bisiesto)
    fecha4.restar_dias(365 + 31 + 29);  // 1 año + enero y febrero de 2024
    assert_eq!(fecha4.dia, 1);
    assert_eq!(fecha4.mes, 1);
    assert_eq!(fecha4.anio, 2023);
  }

  #[test]
    fn test_es_mayor() {
      // Fechas con años diferentes
      let fecha1 = Fecha::new(1, 1, 2023);
      let fecha2 = Fecha::new(1, 1, 2022);
      assert!(fecha1.es_mayor(&fecha2));
      assert!(!fecha2.es_mayor(&fecha1));

      // Fechas con mismo año pero diferentes meses
      let fecha3 = Fecha::new(1, 2, 2023);
      let fecha4 = Fecha::new(1, 1, 2023);
      assert!(fecha3.es_mayor(&fecha4));
      assert!(!fecha4.es_mayor(&fecha3));

      // Fechas con mismo año y mes pero diferentes días
      let fecha5 = Fecha::new(2, 1, 2023);
      let fecha6 = Fecha::new(1, 1, 2023);
      assert!(fecha5.es_mayor(&fecha6));
      assert!(!fecha6.es_mayor(&fecha5));

      // Fechas iguales
      let fecha7 = Fecha::new(1, 1, 2023);
      let fecha8 = Fecha::new(1, 1, 2023);
      assert!(!fecha7.es_mayor(&fecha8));
      assert!(!fecha8.es_mayor(&fecha7));
    }


}