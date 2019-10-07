import java.util.Set;

public class Resposta {
    private Set<Exercicio> _exercicios;
    public Resposta(){

    }
    public Resposta(Set<Exercicio> exercicios){
        _exercicios = exercicios;
    }
    public void Add(Exercicio exercicio){
        _exercicios.add(exercicio);
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        for(Exercicio exe: _exercicios){
            sb.append(exe.pergunta + ": " + exe.resposta + "\n");
        }
        return sb.toString();
    }
}