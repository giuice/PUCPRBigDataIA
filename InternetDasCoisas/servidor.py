
#%%
import paho.mqtt.client as mqtt  # importa o pacote mqtt
import sys  #fechar o programa


#%%
broker = 'broker.hivemq.com' #"test.mosquitto.org"  # define o host do broker mqtt'
port = 1883  # define a porta do broker
keppAlive = 60  # define o keepAlive da conexao
topic = 'PUCPR/IA'  # define o topico que este script assinara


def on_connect(client, userdata, flags, rc):
    print("[STATUS] Conectado ao Broker. Resultado de conexao: "+str(rc))
    client.subscribe(topic)


# possui o mesmo cenario que o on_connect, porem, ela sera atrelada ao loop
# do script, pois toda vez que receber uma nova mensagem do topico assinado, ela sera invocada
def on_message(client, userdata, msg):

    message = str(msg.payload)  # converte a mensagem recebida
    print("[MSG RECEBIDA] Topico: "+msg.topic+" / Mensagem: "+ message)  # imprime no console a mensagem
    #if msg.topic == PUCPR/IA':
    if message == '1':
        print('ligado')
    else:
        print('desligado')
        

try:
    print("[STATUS] Inicializando MQTT...")
    client = mqtt.Client()  # instancia a conexao
    client.on_connect = on_connect  # define o callback do evento on_connect
    client.on_message = on_message  # define o callback do evento on_message

    client.connect(broker, port, keppAlive)  # inicia a conexao
    client.loop_forever()  # a conexao mqtt entrara em loop ou seja, ficara escutando e processando todas mensagens recebidas

except KeyboardInterrupt:
    print (" \nScript finalizado.")
    client.disconnect()
    sys.exit()




