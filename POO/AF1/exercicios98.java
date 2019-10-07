
import java.util.Scanner;

public class exercicios98 {

    public static void main(String args[]) {
        char s = ' ';
        Scanner captura = new Scanner(System.in);
        captura.useDelimiter("");
        int count = 0;
        while (s != '.') {
            System.out.println("Entre com uma letra");

            char c = captura.next().charAt(0);
            if(c == '.') break;
            if(c >= 'a' && c <= 'z') {   
                c = (char)(c - 32);
            } else if(c >= 'A' && c <= 'Z') {   
                c = (char)(c + 32);
            }
            count++;
            System.out.println(c);
        }
        
        System.out.format("Número de alterações: %d .", count);
        captura.close();
    }

}