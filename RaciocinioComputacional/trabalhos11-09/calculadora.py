class Calculadora:
    def __init__(self):
        self.numbers = []

    def print_menu(self):
        print("""
                [1] Somar
                [2] Multiplicar
                [3] Maior
                [4] Novos Números
                [5] Sair do Programa

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def add(self, x, y):
        print('A soma é: ', x + y)

    def multiply(self, x, y):
        print('A multiplicação é: ', x * y)

    def bigger(self):
        if self.numbers[0] > self.numbers[1]:
            print('O numero maior é: ', self.numbers[0])
        elif self.numbers[0] < self.numbers[1]:
            print('O numero maior é: ', self.numbers[1])
        else:
            print('Os números são iguais!')

    def read_numbers(self):
        del self.numbers[:]
        self.numbers.append(int(input('Entre com o primeiro número: ')))
        self.numbers.append(int(input('Entre com o segundo número: ')))

    def show_menu(self):
        option = self.print_menu()
        while option != "5":
            if option == "1":
                self.add(self.numbers[0], self.numbers[1])
            elif option == "2":
                self.multiply(self.numbers[0], self.numbers[1])
            elif option == "3":
                self.bigger()
            elif option == "4":
                self.read_numbers()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()

calc = Calculadora()
calc.read_numbers()
calc.show_menu()
