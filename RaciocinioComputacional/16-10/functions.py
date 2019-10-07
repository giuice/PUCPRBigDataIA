class FunctionsAF:

    def print_menu(self):
        print('''
            1) - Faça um algoritmo que solicite ao usuário números e os armazene em um vetor de 30 posições. 
            Crie uma função que recebe o vetor preenchido e substitua todas as ocorrências de valores positivos por 1 
            e as de valores negativos por 0.
            2) - Crie uma função que retorne o valor da expressão: 
            2/3 + 3/5 + 4/7 + 5/9 + … + n/m, para um valor de n definido pelo usuário. 
            Verifique se esse valor de n é positivo e, caso não seja, 
            solicite outro até ser fornecido um valor positivo.
        ''')
        return input('Qual opção você gostaria de executar?: ')

    def change_vector(self, numbers):
        for idx, item in enumerate(numbers):
            num = item
            if num < 0:
                numbers[idx] = 0
            else:
                numbers[idx] = 1
        return numbers

    def print_vector(self):
        numbers = []
        for i in range(0, 30):
            numbers.append(
                int(input('Entre com um número inteiro qualquer: ')))
        print(numbers)
        print(self.change_vector(numbers))

    def calc_expression(self):
        n = 0
        while n <= 2:
            n = int(input('Entre com o valor de n(>2): '))

        for x in range(2, n+1):
            n += x/(x+(x-1))
        print(n)

    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.print_vector()
            elif option == "2":
                self.calc_expression()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()


f = FunctionsAF()
f.show_menu()
