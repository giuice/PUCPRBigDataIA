import java.io.IOException;
import java.util.Scanner;


public class imc {

    ///CONSTANTES DE COR DO TEXTO PARA EXIBI??O DA RESPOSTA DO IMC
    public static final String ANSI_RESET = "\u001B[0m";
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_GREEN = "\u001B[32m";
    public static final String ANSI_YELLOW = "\u001B[33m";


    public static void main(String[] args) throws IOException{
        callDoIMC();
    }

    protected static void callDoIMC() 
    throws IOException{
        double peso, altura;
        Scanner input = new Scanner(System.in);
        System.out.println("Entre com o Peso em kg(ex.'83,5'): ");
        peso = input.nextDouble();

        System.out.println("Entre com a Altura em mt(ex: 1,86): ");
        altura = input.nextDouble();
        input.close();
        double myimc = doIMC(peso, altura);
        /**
         * Abaixo de 18,5: abaixo do peso.
         * Entre 18,6 e 24,9: peso normal.
         * Entre 25,0 e 29,9: sobrepeso.
         * Acima de 30,0: obesidade.
         */
        String resultado = "O seu imc é %.2f, Avaliação: %s ";
        if(myimc < 18.5){
            System.out.print(ANSI_GREEN);
            System.out.format(resultado,myimc,"Abaixo do peso.\n");
            System.out.print(ANSI_RESET);
        }else if(isBetween(myimc, 18.6, 24.9)){
            System.out.print(ANSI_GREEN);
            System.out.format(resultado,myimc,"Peso normal.\n");
            System.out.print(ANSI_RESET);
        }else if(isBetween(myimc, 25.0, 29.9)){
            System.out.print(ANSI_YELLOW);
            System.out.format(resultado ,myimc,"Sobrepeso!!.\n");
            System.out.print(ANSI_RESET);
        }else{
            System.out.print(ANSI_RED);
            System.out.format(resultado ,myimc,"Cuidado! OBESIDADE.\n");
            System.out.print(ANSI_RESET);
        }

    }

    protected static boolean isBetween(double x, double lower, double upper) {
        return lower <= x && x <= upper;
    }

    protected static double doIMC(double peso, double altura) {
        return (peso / Math.pow(altura, 2));
    }

}
