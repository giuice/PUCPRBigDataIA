
#%%
import sys
import paho.mqtt.client as mqtt  # importa o pacote mqtt


#%%
def on_message(client, userdata, msg):
    message = str(msg.payload) # converte a mensagem recebida
    print("[MSG RECEBIDA] Topico: "+msg.topic+" / Mensagem: "+ message) # imprime no console a mensagem

def ligar(client):
    print('Raspberry ligado')
    client.publish('PUCPR/IA/Ligar', 1)

def desligar(client):
    print('raspberry desligado!')
    client.publish('PUCPR/IA/Desligar', '0')
#%%
broker = 'broker.hivemq.com' #"test.mosquitto.org" # define o host do broker mqtt'
port = 1883 # define a porta do broker
keppAlive = 60 # define o keepAlive da conexao
topic = 'PUCPR/IA'
if sys.argv[1] == '1':
    topic = 'PUCPR/IA/Ligar' # define o topico que este script assinara
client= mqtt.Client()
client.on_message = on_message
client.connect(broker, port, keppAlive) # inicia a conexao
client.subscribe(topic)
# flag = 1
# while flag > -1:
#     num = int(input('1 para ligar, 0 para desligar, -1 para sair.'))
#     if num == 1:
#         ligar(client)
#     else:
#         desligar(client)
client.loop_start()
if sys.argv[1] == '1':
    ligar(client)
else:
    desligar(client)

client.loop_start()
#client.disconnect()
#client.loop(2) # a conexao mqtt entra


#%%



