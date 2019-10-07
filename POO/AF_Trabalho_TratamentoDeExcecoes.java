
package atividadera4;

import java.io.BufferedReader;
import java.io.FileReader;

public class AtividadeRA4 {
    public static void main(String[] args) {
        /*
         * Os métodos a seguir lançam algumas exceções que interropem a execução do
         * programa. Aplique os tratamentos adequados sem alterar os códigos já
         * existentes. O objetivo dessa atividade não é corrigir os problemas
         * apresentados, mas aplicar o tratamento de exceção correto para evitar a
         * interrupção do programa. Sua tarefa consiste em decidir qual a melhor opção
         * para cada situação (blocos try/catch/finally ou os comandos throw e throws)e
         * aplicar ela para gerar um retorno agradável ao usuário.
         */

        metodo1(); // Podem ocorrer duas exceções nesse método, a FileNotFoundException caso se
                   // tente abrir um arquivo que não existe e a IOException caso ocorra outro
                   // problema com a manipulação do arquivo. Essas exceções podem ser tratadas no
                   // próprio método, por isso podemos usar os blocos try/catch/finally (nem sempre
                   // a sugestão da sua IDE é a melhor opção). Use o comando
                   // System.err.println(""); para enviar uma mensagem ao usuário explicando o que
                   // aconteceu.
        metodo2(); // Identifique a exceção gerada e aplique o tratamento adequado para ela.
        metodo3(); // Esse método gera um ArithmeticException. Trate esse erro no método e envie
                   // uma mensagem para o usuário explicando o que aconteceu caso o erro tenha sido
                   // gerado.
        metodo4(); // O uso incorreto dos atributos também podem gerar exceções. Trate o problema
                   // apresentado.
        metodo5(); // Identifique a exceção gerada e aplique o tratamento adequado para ela.
    }

    static void metodo1() {
        System.out.println("M1 - Start");
        try {
            BufferedReader br = new BufferedReader(new FileReader("c:/arquivoinexistente.html"));
            while (br.ready()) {
                String linha = br.readLine();
                System.out.println(linha);
            }
            br.close();
        } catch (FileNotFoundException ex) {
            System.err.println("O arquivo não existe " + ex);
        } catch (IOException ex) {
            System.err.println("Ocorreu um erro ao acessar arquivo. " + ex);
        }
        System.out.println("M1 - End");
    }

    private static void metodo2() {
        System.out.println("M2 - Start");
        try {
            Integer[] numeros = new Integer[10];
            for (int i = 0; i < 10; i++) {
                System.out.println("número: " + i + " = " + numeros[i]);
            }
        } catch (ArrayIndexOutOfBoundsException ex) {
            System.err.println("Erro ao concatenar inteiro com string " + ex);
        }
        System.out.println("M2 - End");
    }

    private static void metodo3() {
        System.out.println("M3 - Start");
        try {
            Integer valor;
            valor = 15 / 0;
            System.out.println("Divisão = " + Integer.toString(valor));
        } catch (ArithmeticException ex) {
            System.err.println("Divisão inválida" + ex);
        }
        System.out.println("M3 - End");
    }

    private static void metodo4() {
        System.out.println("M4 - Start");
        try {
            String teste = "Nova String";
            teste = 5;
        } catch (RuntimeException ex) {
            System.err.println("O ocorreu um erro de cast. " + ex);
        }
        System.out.println("M4 - End");
    }

    private static void metodo5() {
        System.out.println("M5 - Start");
        try {
            String nome;
            nome = geraNome();
        } catch (RuntimeException ex) {
            System.err.println("Método inexistente. " + ex);
        }
        System.out.println("M5 - End");
    }

}
