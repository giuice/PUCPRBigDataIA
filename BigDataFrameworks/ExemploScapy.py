import pandas as pd

from scapy.all import *
from scapy.layers.inet import IP, TCP

columns = ['Timestamp'
          ,'SourceIP'
          ,'DestinationIP'
          ,'Source Port'
          ,'DestinationPort']

rows = []

pckNum = 0

# Carrega o arquivo em memoria
#with rdpcap('C:/EAD/Oficina/Datasets/PCAPs/Wednesday-WorkingHours.pcap') as packets:

# Le o arquivo, pacote por pacote
with PcapReader('C:/EAD/Oficina/Datasets/PCAPs/Wednesday-WorkingHours.pcap') as packets:
    for packet in packets:
        # print (packet.show())
        # print (packet.time)
        pckNum = pckNum + 1

        if (pckNum % 1000 == 0):
            print(pckNum, datetime.fromtimestamp(packet.time).strftime('%Y-%m-%d %H:%M:%S.%f'))

        if(TCP in packet):
            newRow = [packet.time
                    , packet[IP].src
                    , packet[IP].dst
                    , packet[TCP].sport
                    , packet[TCP].dport]
            rows.append(newRow)
    # end for


# salva o dataframe, em csv
df = pd.DataFrame(rows, columns = columns)
df.to_csv('C:/EAD/Oficina/Dados/exemplo.csv',index=False)


