
class velha():
    posicoes = [0] + list(range(1, 10))
    players = {
        "X": "",
        "O": "",
        "winnerx": 0,
        "winnero": 0,
        "games": 0
    }

    goals = [
        (1, 2, 3),
        (4, 5, 6),
        (7, 8, 9),
        (1, 4, 7),
        (2, 5, 8),
        (3, 6, 9),
        (1, 5, 9),
        (3, 5, 7),
    ]

    def draw(self):
        print('     |     |')
        print(' ', self.posicoes[7], ' | ',
              self.posicoes[8], ' | ', self.posicoes[9])
        print('     |     |')
        print('------------------')
        print('     |     |')
        print(' ', self.posicoes[4], ' | ',
              self.posicoes[5], ' | ', self.posicoes[6])
        print('     |     |')
        print('-------------------')
        print('     |     |')
        print(' ',  self.posicoes[1], ' | ',
              self.posicoes[2], ' | ', self.posicoes[3])
        print('     |     |')

    def read_player(self):
        while True:
            try:
                num = int(input())
                if num in self.posicoes:
                    return num
                else:
                    print("\nNúmero inválido, escolha novamente.")
            except ValueError:
                print("\nFavor entrar com um número de 1 a 9!")

    def is_finished(self):
        for posx, posy, posz in self.goals:
            if self.posicoes[posx] == self.posicoes[posy] == self.posicoes[posz]:
                print("Jogador {0} venceu!\n".format(self.players[self.posicoes[posz]]))
                if self.posicoes[posx] == 'X':
                    self.players['winnerx'] += 1
                else:
                    self.players['winnero'] += 1
                self.players['games'] += 1
                return True
        if 9 == sum((pos == 'X' or pos == 'O') for pos in self.posicoes):
            print("Foi um empate!\n")
            return True

    def play(self):
        if self.players.get('X') == '':
            self.players['X'] = input('Entre com o nome do primeiro Jogador: ')
            self.players['O'] = input('Entre com o nome do segundo Jogador: ')
        while True:
            for player in 'XO' * 9:
                self.draw()
                if self.is_finished():
                    break
                print("{0} escolha sua jogada:".format(self.players[player]))
                self.posicoes[self.read_player()] = player
                print()
            if input("Jogar novamente? (s/n)\n") != "s":
                print('\nForam ', self.players['games'], ' partidas.')
                print(self.players['X'], ' ganhou ', self.players['winnerx'], ' vezes.')
                print(self.players['O'], ' ganhou ', self.players['winnero'], ' vezes.')
                break
            else:
                self.posicoes = [0] + list(range(1, 10))


velha().play()
