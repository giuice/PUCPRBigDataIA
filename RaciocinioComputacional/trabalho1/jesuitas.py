import pydotplus
import os
os.environ["PATH"] += os.pathsep + 'D:/Program Files (x86)/Graphviz2.38/bin/'
graph = pydotplus.Dot(graph_type='graph')


class TransporteSeguro:
    """
O algoritmo resolve qualquer quantidade de jesuitas e canibais que seja jesuitas >=canibais, 
entretanto o numero de lugares no barco sobe se for > 3 = 3 lugares
se for > 5 então 4 lugares pode passar qq numero de pares(https://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem)
O estado inicial é representado por um array [x,y,1] x jesuitas, y canibais e 1 barco na esquerda
OBS. Para melhor visualização instalar o graphviz2.38, caso não queria instalar apenas comente as linhas do graph
    """

    def __init__(self, jesuitas, canibais):
        self.objetivo = [0, 0, 0]
        self.jesuitas = jesuitas
        self.canibais = canibais
        self.estadosFeitos = []
        self.esquerdo = 1
        self.direito = 0
        self.possibilidades = []

    def get_possibilidades(self):
        size = self.jesuitas
        aux = [[1, 1], [0, 1], [1, 0], [2, 0], [0, 2]]
        if size > 3:
            aux.extend([[2, 1], [3, 0], [0, 3]])
        if size > 5:
            aux.extend([[2, 2], [3, 1], [4, 0], [0, 4]])
        return aux

    def transportar(self, estado):
        while estado != self.objetivo:
            children = []
            # Salva os estados já feitos para evitar loops.
            self.estadosFeitos.append(estado)
            situacao = estado
            posicao_barco = estado[2]

            if not self.possibilidades:
                self.possibilidades = self.get_possibilidades()

            for acao in self.possibilidades:
                auxiliar = []
                # O barco está no lado esquerdo então movimentamos para o lado direito
                if posicao_barco == self.esquerdo:
                    posicao = self.direito
                    auxiliar = [x-y for x, y in zip(situacao[:2], acao)]
                    auxiliar.append(posicao)
                else:
                    posicao = self.esquerdo
                    auxiliar = [x+y for x, y in zip(situacao[:2], acao)]
                    auxiliar.append(posicao)

                jesuitas_a_direita = self.jesuitas-auxiliar[0]
                canibais_a_direita = self.canibais-auxiliar[1]

                if (auxiliar[1] <= auxiliar[0] or auxiliar[0] == 0) \
                    and (auxiliar[0] <= self.jesuitas and auxiliar[0] >= 0
                         and auxiliar[1] <= self.canibais and auxiliar[1] >= 0
                         and (canibais_a_direita <= jesuitas_a_direita or jesuitas_a_direita == 0)
                         and auxiliar not in self.estadosFeitos):
                    estado = auxiliar
                    children.append(estado)
                    print(estado,situacao)

            for child in children:
                # implementando jesuitas busca em profundidade
                edge = pydotplus.Edge(''.join(str(e) for e in situacao),
                                      ''.join(str(e) for e in child))
                graph.add_edge(edge)

                if child == self.objetivo:
                    print("resolvido!")
                estado = child


def main():
    jesuitas, canibais = 0, 0
    while jesuitas == 0 or jesuitas < canibais:
        jesuitas = int(input("Entre com o número de jesuitas: "))
        canibais = int(input("Entre com o numero de canibais: "))
        if (jesuitas < canibais):
            print("O numero de jesuitas não pode ser menor que o de canibais!")
    else:
        pr = TransporteSeguro(jesuitas, canibais)
        pr.transportar([jesuitas, canibais, 1])  # [x,x,1] estado inicial
        graph.write('jesuitas.png', format='png')


main()
