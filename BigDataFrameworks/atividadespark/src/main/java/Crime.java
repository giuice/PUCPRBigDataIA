import java.io.Serializable;

public class Crime implements Serializable {

        public Integer dia;
        public Integer mes;
        public Integer ano;
        public String tipo;

    public Crime(Integer dia, Integer mes, Integer ano, String tipo) {
        this.dia = dia;
        this.mes = mes;
        this.ano = ano;
        this.tipo = tipo;
    }
}

