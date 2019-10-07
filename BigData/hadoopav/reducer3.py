import sys

ocorrencia = {}
for linha in sys.stdin:
    chave, valor = linha.split('\t', 1)
    #print(chave, valor)
    if chave in ocorrencia:
        ocorrencia[chave] = ocorrencia[chave] + 1
    else:
        ocorrencia[chave] = 1

for ano in ocorrencia.keys():
    print('%s\t%s' % (ocorrencia[ano], ano))
