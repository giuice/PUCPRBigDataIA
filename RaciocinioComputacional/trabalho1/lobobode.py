class FazendeiroEsperto:

    def __init__(self, estado=None):
        self.fazendeiro = 0
        self.lobo = 1
        self.bode = 2
        self.alfafa = 3
        self.start, self.objetivo = [[self.fazendeiro, self.lobo, self.bode, self.alfafa], [], []]  ,  [[], [], [self.fazendeiro, self.lobo, self.bode, self.alfafa]]
        self.estado = estado or self.start[:]
    
    def won(self): return self.estado == self.objetivo

    def possibilidades(self):
        for movimento in [[0, 1], [1, 0], [1, 2], [2, 1]]:
            for possibilidade in self.tranportar(*movimento):
                if not self.invalido(possibilidade): yield FazendeiroEsperto(possibilidade)

    def tranportar(self, s, d):
        origem = self.estado[s][:]
        if self.fazendeiro in origem: 
            estado = self.estado[:]
            estado[s], estado[d] = self.estado[s][:], self.estado[d][:]
            estado[s].remove(self.fazendeiro)
            estado[d].insert(0, self.fazendeiro)
            yield estado
        if self.fazendeiro in origem and len(origem) >= 2: 
            origem.remove(self.fazendeiro)
            for i in range(len(origem)):
                estado = self.estado[:]
                estado[s], estado[d] = origem[:], self.estado[d][:]
                estado[d] += [self.fazendeiro, estado[s].pop(i)]
                estado[d].sort()
                yield estado

    def invalido(self, s):
        if len(s[1]) > 2: return True
        for i in range(3):
            if self.bode in s[i] and self.alfafa in s[i] and not self.fazendeiro in s[i]:
                return True
            if self.lobo in s[i] and self.bode in s[i] and not self.fazendeiro in s[i]:
                return True

#algoritmo de busca
class Busca:
    estados_salvos, won = [], False

    def go(self, problema):
        self.proximo(problema, 0)
        return self.estados_salvos

    def proximo(self, problema, profundidade):
        self.estados_salvos.append(problema.estado)
        if problema.won():
            self.won = True
        else:
            for s in problema.possibilidades():
                if not self.won:
                    self.estados_salvos = self.estados_salvos[:profundidade+1]
                    if not s.estado in self.estados_salvos: self.proximo(s, profundidade+1)

class Print:
    
    def map_entity(self, it):
        dic = {0:'fazendeiro',1:'lobo', 2:'bode', 3:'alfafa'}
        return dic.get(it)
    
    def map_local(self, it):
        dic = {0:'margem esquerda',1:'barco', 2:'margem direita'}
        return dic.get(it)

    def Write(self, movimento):
        #print(movimento)
        concatenador = ''
        for idx, it in (enumerate(movimento)):
            if(idx == 0):
                print('---------começando movimento estados:--------------')
            if len(it) > 0:
                concatenador += self.map_local(idx) + ": ["
            for it1 in iter(it):
                concatenador += self.map_entity(it1) + " "
            if(len(it) > 0):
                concatenador += "]\n"

        print(concatenador)


def main():
    for s in Busca().go(FazendeiroEsperto()): Print().Write(s)

main()