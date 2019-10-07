import java.io.IOException;
import java.util.Scanner;
public class discount{
    public static void main(String args[])
    throws IOException{
        
        System.out.println("Favor entrar um número para o desconto de 11%");
        
        int controler = 1;
        Scanner captura = new Scanner(System.in);
        while (controler != 0) {
            
            int n1 = captura.nextInt();
            if(n1 == 0) break;
            System.out.format("O aplicado desconte em %d valor de %.2f \n",n1,n1*.89);
            System.out.println("Entre com o próximo numero ou tecle '0' para sair.");
        }
        captura.close();
    }
}