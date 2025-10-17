package ar.edu.unlp.objetos.uno.ejercicio14;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Aca escribiremos los test de unidad para cada clase 
 * 
 */
public class ReporteDeConstruccionTest {
	
	private ReporteDeConstruccion reporte;
	private Cilindro cilindro;
	private Esfera esfera;
	private PrismaRectangular prismaRectangular;
	
	@BeforeEach
	void setUp() throws Exception {
		reporte = new ReporteDeConstruccion();
		cilindro = new Cilindro("Acero", "Negro", 10,20);
		esfera = new Esfera("Acero", "Rojo", 8);
		prismaRectangular = new PrismaRectangular("Madera", "Rojo",10 , 5, 30);
		reporte.agregarPiezas(cilindro);
		reporte.agregarPiezas(esfera);
		reporte.agregarPiezas(prismaRectangular);
	}
	
    @Test
    public void testCalcularVolumen() {
    	double volPrisma = 10*5*30;
    	double volEsfera = (4.0 / 3.0) * Math.PI * Math.pow(8, 3);
    	double volCilindro = Math.PI * Math.pow(10, 2) * 20;
        assertEquals(volPrisma, prismaRectangular.calcularVolumen());
        assertEquals(volEsfera, esfera.calcularVolumen());
        assertEquals(volCilindro, cilindro.calcularVolumen());
    }
    
    @Test
    public void testCalcularSuperficie() {
    	double supPrisma = 2 * (10*5 + 10*30 + 5*30);
    	double supEsfera = 4 * Math.PI * Math.pow(8, 2);
    	double supCilindro = (2 * Math.PI * 10 * 20) + (2 * Math.PI * Math.pow(10, 2));
        assertEquals(supPrisma, prismaRectangular.calcularSuperficie());
        assertEquals(supEsfera, esfera.calcularSuperficie());
        assertEquals(supCilindro, cilindro.calcularSuperficie());
    }
    
    @Test
	void testVolumenDeMaterial() {
		assertEquals(8428, Math.round(reporte.volumenDeMaterial("Acero")));
		assertEquals(0, reporte.volumenDeMaterial("XD"));
		assertEquals(0, reporte.volumenDeMaterial(null));
	}
    
    @Test
    void testSuperficieDeColor() {
		assertEquals(1804, Math.round(reporte.superficieDeColor("Rojo")));
		assertEquals(0, reporte.superficieDeColor("Verde"));
		assertEquals(0, reporte.superficieDeColor(null));
	}
}
