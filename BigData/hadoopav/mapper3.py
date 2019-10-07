import sys

for linha in sys.stdin:
    campos = linha.split(",")
    pais = campos[0]
    ano = campos[1]
    codigo = campos[2]
    mercadoria = campos[3]
    fluxo = campos[4]
    valor = campos[5]
    print('%s\t%s' % (ano, "1"))
