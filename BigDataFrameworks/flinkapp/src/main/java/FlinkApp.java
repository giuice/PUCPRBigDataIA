
import org.apache.flink.api.common.functions.*;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.tuple.Tuple3;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.AllWindowFunction;
import org.apache.flink.streaming.api.windowing.windows.GlobalWindow;
import org.apache.flink.util.Collector;
import org.apache.log4j.BasicConfigurator;
import scala.Int;

import java.util.HashSet;
import java.util.Set;

public class FlinkApp {

    public static void main(String[] args) throws Exception {
        BasicConfigurator.configure();
        org.apache.log4j.Logger.getRootLogger().setLevel(org.apache.log4j.Level.ERROR);
        StreamExecutionEnvironment see = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<String> file = see.readTextFile("crimes_nohead.csv");

        SingleOutputStreamOperator<Crime> crimeMap = file.map((String t) -> {
            String[] columns = t.split(",");
            String[] data = columns[2].split("/");
            Integer dia = Integer.parseInt(data[1]);
            Integer mes = Integer.parseInt(data[0]);
            Integer ano = Integer.parseInt(data[2].substring(0, 4));
            String tipo = columns[5];
            return new Crime(dia, mes, ano, tipo, 1);
        });
        crimeMap.countWindowAll(10000)
                .apply(new AllWindowFunction<Crime, Resposta, GlobalWindow>() {
                    @Override
                    public void apply(GlobalWindow w, Iterable<Crime> itrbl, Collector<Resposta> clctr) throws Exception {
                        int sumNarcotics = 0;
                        int sumNarcoticsDay1 = 0;
                        int sumDia1 = 0;
                        for(Crime c: itrbl){
                            if(c.tipo.contains("NARCOTICS")){
                                sumNarcotics++;
                            }
                        }
                        for (Crime c : itrbl) {
                            if (c.tipo.contains("NARCOTICS") && c.dia == 1) {
                                sumNarcoticsDay1++;
                            }
                        }
                        for (Crime c : itrbl) {
                            if (c.dia == 1) {
                                sumDia1++;
                            }
                        }
                        Set<Exercicio> exes = new HashSet<>();
                        Exercicio exe1 = new Exercicio("Crimes do tipo NARCOTICS", sumNarcotics);
                        Exercicio exe2 = new Exercicio("Crimes que ocorreram no dia 1, tipo NARCOTICS",sumNarcoticsDay1);
                        Exercicio exe3 = new Exercicio("Quantidade de crimes que ocorreram no dia 1",sumDia1);
                        exes.add(exe1);
                        exes.add(exe2);
                        exes.add(exe3);
                        Resposta resposta = new Resposta(exes);
                        clctr.collect(resposta);
                    }
                }).print();


        //A cada 10 mil crimes, a quantidade de crimes do tipo NARCOTICS que ocorreram no ano 2010
        crimeMap.filter(new FilterFunction<Crime>() {
            @Override
            public boolean filter(Crime crime) throws Exception {
                return crime.ano == 2010;
            }
        })
                .countWindowAll(10000)
                .apply(new AllWindowFunction<Crime, Resposta, GlobalWindow>() {
                    @Override
                    public void apply(GlobalWindow globalWindow, Iterable<Crime> iterable, Collector<Resposta> collector) throws Exception {
                        Integer count = 0;
                        for (Crime crime : iterable) {
                            if (crime.tipo.contains("NARCOTICS"))
                                count++;
                        }
                        Exercicio ex = new Exercicio("NARCOTICS em 2010", count);
                        Set<Exercicio> exercicios = new HashSet<>();
                        exercicios.add(ex);
                        Resposta resposta = new Resposta(exercicios);
                        collector.collect(resposta);
                    }
                }).print();*/


        //Para crimes do tipo NARCOTICS. A cada 10 mil crimes ocorridos no dia 1.
        // Agrupar os crimes de acordo com o mês. Gerar uma soma com os resultados obtidos;
        crimeMap.filter(new FilterFunction<Crime>() {
            @Override
            public boolean filter(Crime crime) throws Exception {
                return crime.tipo.contains("NARCOTICS");
            }
        }).keyBy("mes")
                .countWindowAll(10000)
                .apply(new AllWindowFunction<Crime, Tuple2<Integer,Integer>, GlobalWindow>() {
                    @Override
                    public void apply(GlobalWindow window, Iterable<Crime> values, Collector<Tuple2<Integer,Integer>> out) throws Exception {
                        int key = 0;
                        int count = 0;
                        for(Crime c :values){
                            if(c.dia == 1) {
                                key = c.mes;
                                count++;
                            }
                        }
                        out.collect(new Tuple2<>(key,count));
                    }
                }).print();

        //cada 10 mil crimes, a quantidade de crimes que ocorreram no dia 1,
        // que sejam do tipo NARCOTICS. Do resultado gerado obter uma média;

        crimeMap
                .countWindowAll(10000)
                .apply(new AllWindowFunction<Crime, Tuple3<String,Integer,Integer>, GlobalWindow>() {
                    @Override
                    public void apply(GlobalWindow window, Iterable<Crime> values, Collector<Tuple3<String,Integer,Integer>> out) throws Exception {

                        int count = 0;
                        for(Crime c :values){
                            if(c.dia == 1 && c.tipo.contains("NARCOTICS")) {
                                count++;
                            }
                        }
                        if(count> 0){out.collect(new Tuple3<String,Integer,Integer>("NARCOTICS",count,1));}

                    }
                }).keyBy(0)
                .reduce(new ReduceFunction<Tuple3<String, Integer, Integer>>() {
                    @Override
                    public Tuple3<String, Integer, Integer> reduce(Tuple3<String, Integer, Integer> t2, Tuple3<String, Integer, Integer> t1) throws Exception {
                        return new Tuple3<>(t1.f0,t1.f1 + t2.f1,t1.f2 + t2.f2);
                    }
                }).map(new MapFunction<Tuple3<String, Integer, Integer>, Object>() {
            @Override
            public Object map(Tuple3<String, Integer, Integer> t) throws Exception {
                return new Tuple2<String,Double>(t.f0, t.f1/(double)t.f2 );
            }
        })
                .print();

        crimeMap
                .countWindowAll(10000)
                .apply(new AllWindowFunction<Crime, Tuple3<String,Integer,Integer>, GlobalWindow>() {
                    @Override
                    public void apply(GlobalWindow window, Iterable<Crime> values, Collector<Tuple3<String,Integer,Integer>> out) throws Exception {

                        int count = 0;
                        for(Crime c :values){
                            if(c.dia == 1 && c.tipo.contains("NARCOTICS")) {
                                count++;
                            }
                        }
                        if(count> 0){out.collect(new Tuple3<String,Integer,Integer>("NARCOTICS",count,1));}

                    }
                }).keyBy(0).max(1).print();

//                .aggregate(new AggregateFunction<Tuple2<String,Integer>, Tuple2<Long,Long>, Double>() {
//            @Override
//            public Tuple2<Long,Long> createAccumulator() {
//                return new Tuple2<>();
//            }
//
//            @Override
//            public Tuple2<Long, Long> add(Tuple2<String,Integer> value, Tuple2<Long, Long> acc) {
//                acc.f1 += value.f1;
//                acc.f0++;
//                return acc;
//            }
//
//            @Override
//            public Double getResult(Tuple2<Long, Long> acc) {
//                return acc.f1/(double)acc.f0;
//            }
//
//            @Override
//            public Tuple2<Long, Long> merge(Tuple2<Long, Long> acc, Tuple2<Long, Long> acc1) {
//                acc.f0 += acc1.f0;
//                acc.f1 += acc1.f1;
//                return acc;
//            }
//        }).print();
        see.execute("Crimes Job");
        /* DataSet<Crime> crimes = lines.map(new MapFunction<Tuple4<Integer, Integer, Integer, String>, Crime>() {
            @Override
            public Crime map(Tuple4<Integer, Integer, Integer, String> csvLine) throws Exception {
                return new Crime(csvLine.f0, csvLine.f1, csvLine.f2, csvLine.f3);
            }
        });*/

    }


}


