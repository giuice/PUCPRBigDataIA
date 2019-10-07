from random import randint


class Matriz2:

    def print_menu(self):
        print("""
                1. - Crie uma matriz identidade de tamanho NxN,
                    sendo N informado pelo usuário.
                    Crie uma segunda matriz que seja o dobro da primeira.
                2. - Escreva um programa que leia duas matrizes:
                    A de dimensão m x n e B de dimensão n x p e
                    imprima a matriz C de dimensão m x p,
                    que é o produto de A por B.

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def create_identity(self, w):
        idt = [[0 for x in range(w)] for y in range(w)]
        for i in range(0, w):
            idt[i][i] = 1
        return idt

    def create_matrix(self, row, column):
        return [[0 for x in range(column)] for y in range(row)]

    def create_rand_matrix(self, row, column, randini, randfinal):
        return [[randint(randini, randfinal) for x in range(column)]
                for y in range(row)]

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

    def get_matrix_dim(self, matrix):
        return len(matrix), len(matrix[0])

    def double_matrix(self):
        tam = int(input('Entre com o tamanho da matriz identidade: '))
        idt = self.create_identity(tam)
        dblmatrix = self.create_matrix(tam, tam)
        dims = self.get_matrix_dim(idt)
        for i in range(dims[0]):
            for j in range(dims[1]):
                dblmatrix[i][j] = idt[i][j] * 2
        print('Matriz original: ', idt)
        print('Matriz ao quadrado', dblmatrix)

    ''' Cij = somatória(k=1)(Aik*Bkj) '''

    def multiply_matrix_dim(self):
        m = int(input('Entre com a dimensão "m": '))
        n = int(input('Entre com a dimensão "n": '))
        p = int(input('Entre com a dimensão "p": '))
        mxn = self.create_rand_matrix(m, n, 1, 4)
        nxp = self.create_rand_matrix(n, p, 1, 4)
        nxn = self.create_matrix(m, p)
        for i in range(m):
            for j in range(p):
                for k in range(n):
                    nxn[i][j] += mxn[i][k]*nxp[k][j]
        print('MxN', mxn)
        print('NxP', nxp)
        print('Multiplicação nxn: ', nxn)

    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.double_matrix()
            elif option == "2":
                self.multiply_matrix_dim()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()


m = Matriz2()
m.show_menu()
