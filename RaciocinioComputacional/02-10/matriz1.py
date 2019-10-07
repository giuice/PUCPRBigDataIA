from random import randint


class Matriz1:

    def print_menu(self):
        print("""
               1. - Solicite ao usuário números e os armazene em uma matriz 6x6. 
               Em seguida, crie um vetor que armazene os elementos da diagonal principal da matriz.
               2. - Tendo uma matriz 10x10 preenchida com valores aleatórios entre 10 e 50, 
               mostre a média dos elementos da diagonal secundária.
               3. - Tendo uma matriz 10x10 preenchida com valores aleatórios entre 10 e 50, 
               mostre o maior valor existente desconsiderando os elementos da diagonal principal.
               4. - Tendo uma matriz 5x5 preenchida com valores aleatórios entre 0 e 99, 
               mostre o segundo maior valor existente.

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def create_identity(w):
        idt = [[0 for x in range(w)] for y in range(w)]
        for i in range(0, w):
            idt[i][i] = 1
        return idt

    def create_matrix(self, w, h):
        return [[0 for x in range(w)] for y in range(h)]

    def create_rand_matrix(self, w, h, randini, randfinal):
        return [[randint(randini, randfinal) for x in range(w)]
                for y in range(h)]

    def get_diag(self, matrix):
        return [row[i] for i, row in enumerate(matrix)]

    def get_diag_rl(self, matrix):
        return [row[-i-1] for i, row in enumerate(matrix)]

    def flatten_matrix(self, matrix):
        flat = []
        for i in matrix:
            for ii in i:
                flat.append(ii)
        return flat

    def create_matrix_diag(self):
        m = self.create_matrix(6, 6)
        for i in range(0, 6):
            for ii in range(0, 6):
                m[i][ii] = (int(input('entre com um número: ')))
        vetor = self.get_diag(m)
        print('A diagonal da matriz entrada é: ', vetor)

    def calculate_diag_rl_mean(self):
        m = self.create_rand_matrix(10, 10, 10, 50)
        print('A média dos elementos diagonais secundários é: ',
              sum(self.get_diag_rl(m))/10)

    def show_high_value_not_in_diag(self):
        m = self.create_rand_matrix(10, 10, 10, 50)
        diags = self.get_diag(m)
        no_diags = []
        for i in m:
            for ii in i:
                if ii not in diags:
                    no_diags.append(ii)
        print('O maior valor da matriz excluindo a diagonal é: ', max(no_diags))

    def show_second_highest_value(self):
        m = self.create_rand_matrix(5, 5, 0, 99)
        flatmatrix = self.flatten_matrix(m)
        print('A matrix original criada: ', flatmatrix)
        print('Segundo maior valor: ', sorted(flatmatrix)[-2])

    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.create_matrix_diag()
            elif option == "2":
                self.calculate_diag_rl_mean()
            elif option == "3":
                self.show_high_value_not_in_diag()
            elif option == "4":
                self.show_second_highest_value()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()


m = Matriz1()
m.show_menu()
