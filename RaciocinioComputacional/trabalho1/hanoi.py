def torre_hanoi(tamanho, origem, auxiliar, destino):
    if(tamanho > 0):
        torre_hanoi(tamanho-1,origem, destino, auxiliar)
        print("Moveu o disco ", tamanho, " de ", origem, " para ", destino)
        torre_hanoi(tamanho-1,auxiliar, origem, destino)

torre_hanoi(3, "Torre1", "Torre3", "Torre2")