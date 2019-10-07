public class Exercicio {
    public String pergunta;
    public Object resposta;

    public Exercicio() {
    }

    public Exercicio(String pergunta, Object resposta) {
        this.pergunta = pergunta;
        this.resposta = resposta;
    }
    @Override
    public String toString(){
        return this.pergunta + " = " + this.resposta.toString();
    }
}
