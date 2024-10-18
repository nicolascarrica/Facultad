/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recuperatorio41223;

/**
 *
 * @author nicol
 */
public class Recuperatorio41223 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Solicitud miSolicitud1 = new Solicitud("NC", "aa", "Belgica",500,500,50, 200, 5 );
        Solicitud miSolicitud2 = new Solicitud("AB", "PT2", "Alemania",550,500,40, 250, 6 );
        Solicitud miSolicitud3 = new Solicitud("DD", "pt3", "UK",700,800,60, 300, 6 );
        Solicitud miSolicitud4 = new Solicitud("JJ", "pt4", "Francia",400,350,50, 260, 5 );
        Solicitud miSolicitud5 = new Solicitud("KK", "pt5", "Japon",800,500,150, 500, 5 );
        Solicitud miSolicitud6 = new Solicitud("PP", "pt6", "Italia",500,500,50, 200, 8 );
        
        Version1 miVersion1 = new Version1(8);
        miVersion1.Agregarsubsidio(miSolicitud1);
        miVersion1.Agregarsubsidio(miSolicitud2);
        miVersion1.Agregarsubsidio(miSolicitud3);
        
        miVersion1.otorgarSubsidios(1500);
        System.out.println("version 1");
        System.out.println(miVersion1.toString());
        
        
        Version2 miVersion2 = new Version2(8);
        miVersion2.Agregarsubsidio(miSolicitud4);
        miVersion2.Agregarsubsidio(miSolicitud5);
        miVersion2.Agregarsubsidio(miSolicitud6);
        
        miVersion2.otorgarSubsidios(1800);
        System.out.println("version 2");
        System.out.println(miVersion2.toString());
    }   
    
}
