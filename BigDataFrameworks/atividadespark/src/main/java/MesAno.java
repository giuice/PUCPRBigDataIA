import java.io.Serializable;

public class MesAno implements Serializable {
    public Integer ano;
    public Integer mes;
    public Integer count;


    public MesAno(Integer mes, Integer ano, Integer count) {
        this.mes = mes;
        this.ano = ano;
        this.count = count;
    }

    public Integer getAno() {
        return ano;
    }

    public Integer getMes() {
        return mes;
    }

    public Integer getCount() {
        return count;
    }
}