import time
#import RPi.GPIO as gpio
import paho.mqtt.client as mqtt  # importa o pacote mqtt
import sys  #fechar o programa


#%%
broker = 'broker.hivemq.com' #"test.mosquitto.org"  # define o host do broker mqtt'
port = 1883  # define a porta do broker
keppAlive = 60  # define o keepAlive da conexao
topic = 'PUCPR/IA'  # define o topico que este script assinara

# gpio.setwarnings(False)
# gpio.setmode(gpio.BOARD)
# gpio.setup(32, gpio.OUT)

def on_connect(client, userdata, flags, rc):
    print("[STATUS] Conectado ao Broker. Resultado de conexao: "+str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):

    message = str(msg.payload) 
    #print("[MSG RECEBIDA] Topico: "+msg.topic+" / Mensagem: "+ message) # imprime no console a mensagem
    # testara se o topico desta mensagem sera igual ao topico que queremos, que neste caso remete ao led
    #if msg.topic == 'PUCPR/IA':
    if int(message) == 1:
        print('[STATUS]: Luz acesa!')
        #gpio.output(32, 1)
    else:
        print('[STATUS]: Luz apagada')
        #gpio.output(32, 0)
try:
    print("[STATUS] Inicializando MQTT...")
    client = mqtt.Client()  # instancia a conexao
    client.on_connect = on_connect  # define o callback do evento on_connect
    client.on_message = on_message  # define o callback do evento on_message

    client.connect(broker, port, keppAlive)  # inicia a conexao
    print("[STATUS] connectado no MQTT...")
    client.loop_forever()  # a conexao mqtt entrara em loop ou seja, ficara escutando e processando todas mensagens recebidas

except KeyboardInterrupt:
    print (" \nScript finalizado.")
    #gpio.cleanup()
    client.disconnect()
    sys.exit()
