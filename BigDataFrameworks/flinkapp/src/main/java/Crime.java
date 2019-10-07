import java.io.Serializable;

public class Crime implements Serializable {
    public Integer dia;
    public Integer mes;
    public Integer ano;
    public String tipo;
    public Integer count;

    public Crime() {
    }

    public Crime(Integer dia, Integer mes, Integer ano, String tipo, Integer count) {
        this.dia = dia;
        this.mes = mes;
        this.ano = ano;
        this.tipo = tipo;
        this.count = count;
    }

    @Override
    public String toString() {
        return tipo + " " + ano + "/" + mes + " = " + count;
    }

}
