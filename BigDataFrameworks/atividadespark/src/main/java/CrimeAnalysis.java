import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import org.apache.spark.api.java.function.Function2;
import scala.Tuple2;
import scala.Tuple3;

import java.util.*;
import java.util.stream.Collectors;

import static java.util.Comparator.comparingInt;


public class CrimeAnalysis {

    private static void log(String name, Object a) {
        System.out.println(name + ": " + a);
    }
    ///Função para simular o max
    private static Tuple2<Integer, Float> max(Tuple2<Integer, Float> x, Tuple2<Integer, Float> y) {
        if (x._2 > y._2) return x;
        return y;
    }

    public static void main(String[] args) {
        //get("/hello", (req, res) -> "Hello World");
        SparkConf conf = new SparkConf().setMaster("local[*]").setAppName("pratica");
        //conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer");
        //conf.registerKryoClasses(Array(classOf[org.apache.hadoop.hbase.client.Result]))
        JavaSparkContext sc = new JavaSparkContext(conf);
        sc.setLogLevel("ERROR");
        JavaRDD<String> lines = sc.textFile("city_of_chicago_crimes_2001_to_present.csv");
        String header = lines.first();
        //Como nosso dataset é diferente temos que tranformar o dataset
        /**/
        //removendo header
        lines = lines.filter(s -> {
            return !s.equals(header);
        });
        // transformando o dataset para o que precisamos
        JavaRDD<Crime> ds = lines.map(s -> {
            String[] campos = s.split(",");
            String[] data = campos[2].split("/");
            Integer dia = Integer.valueOf(data[1]);
            Integer mes = Integer.valueOf( data[0]);
            Integer ano = Integer.valueOf(data[2].substring(0, 4));
            String tipo = campos[5];
            //return dia + "," + mes + "," + ano + "," + tipo;
            return new Crime(dia, mes, ano, tipo);
        });
        ds.cache();
        long count = ds.count();
        //primeira operação
        //Quantidade de crimes por ano
        JavaRDD<Integer> byano = ds.map(crime -> {
            //String[] campos = s.split(",");
            return crime.ano;
        });
        log("Quantidade de crimes por ano: ", byano.countByValue());

        //filtrando somente narcoticos
        JavaRDD<Crime> narcotics = ds.filter(crime -> {
            return !crime.tipo.equals("NARCOTICS");
        });
        // Quantos crimes por ano  com narcóticos?
        log("Quantidade de crimes por ano que sejam do tipo NARCOTICS: ", narcotics.map(crime -> {
            return crime.ano;
        })
                .countByValue());

        //Quantos dias por ano em narcoticos com dias pares?
        log("Por narcoticos dias pares: ", narcotics.filter(crime -> {
            Integer dia = crime.dia;
            return (dia & 1) == 0;
        })
                .map(crime -> crime.ano)
                .countByValue());


        JavaPairRDD<Integer, Float> pairs = ds.mapToPair(crime -> new Tuple2<>(crime.mes, 1F));
        JavaPairRDD<Integer, Float> months = pairs.reduceByKey((a,b) -> a + b);
        log("Mes Com maior ocorrências de Crimes: ", months
                .reduce(CrimeAnalysis::max)
        );
        log("Mês com maior média de ocorrências de Crimes:",
                months.map(a -> new Tuple2<>(a._1, ((float) a._2 / count) * 100)).reduce(CrimeAnalysis::max));

        JavaRDD<Tuple3<Integer,Integer,Integer>> mesano = ds.map(crime -> new Tuple3<>(crime.ano,crime.mes,1));
        JavaPairRDD mesano2 = ds.mapToPair(crime -> new Tuple2<>(new Tuple2<>(crime.ano, crime.mes), 1));

        List<Tuple2> map1 = mesano2
                .reduceByKey((Function2<Integer, Integer, Integer>) Integer::sum)
                .collect();
        //Daqui pra frente não sei como fazer em map reduce mes por ano
        // Professor poderia ter dado dicas,não acho na internet nem ao
        //menos um Exemplo!! Obs. Em python fiz tudo em 1 hora
        // Java é um sacrificio!
        List<MesAno> mesAnoHashMap = new ArrayList<>() ;
        for (Tuple2<Tuple2<Integer,Integer>,Integer> o : map1) {
            MesAno m =new MesAno(o._1._2,o._1._1,o._2);
            mesAnoHashMap.add(m);
        }
        //hashmap para guardarmos os meses com mais ocorrencia de crimes POR ANO
        Map<Integer,Tuple2<Integer,Integer>> hashHelperMesAno = new HashMap<>();

        mesAnoHashMap.stream()
                .sorted(comparingInt(MesAno::getCount)
                    .reversed()) //sort decrescente
                .collect(Collectors.toList())
                .forEach(x -> {
                    Integer ano = x.getAno();
                    if(hashHelperMesAno.containsKey(x.ano)){
                         Tuple2<Integer,Integer>  cr =  hashHelperMesAno.get(ano);
                         if(x.getCount() > cr._2)
                             hashHelperMesAno.put(ano,cr);
                    }else {
                        hashHelperMesAno.put(x.getAno(), new Tuple2<>(x.getMes(), x.getCount()));
                    }
                });
        System.out.println("Mês por ano com a maior ocorrência de crimes:");
        hashHelperMesAno.entrySet().stream()
                .sorted(comparingInt(Map.Entry::getKey))
                .forEach(System.out::println);

        //Mês com a maior ocorrência de crimes do tipo “DECEPTIVE PRACTICE”
        Tuple2<Integer, Float> decMonths = ds.filter(crime -> {
            return !crime.tipo.equals("DECEPTIVE PRACTICE");
        })
                .mapToPair(crime -> new Tuple2<>(crime.mes, 1F))
                .reduceByKey(Float::sum)
                .reduce(CrimeAnalysis::max);
        log("Mês com a maior ocorrência de crimes do tipo “DECEPTIVE PRACTICE", decMonths);
        //Dia do ano com a maior ocorrência de crimes;
        Tuple2<Integer, Float> dias = ds
                .mapToPair(crime -> new Tuple2<>(crime.dia, 1F))
                .reduceByKey(Float::sum)
                .reduce(CrimeAnalysis::max);
        log("Dia do ano com a maior ocorrência de crimes", dias);



        sc.stop();

    }


}
