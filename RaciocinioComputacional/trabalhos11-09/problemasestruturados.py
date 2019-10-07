from random import randint


class Problemas_Estruturados:

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
                1 - Faça um programa que peça uma nota, entre 0 e 10.
                Mostre uma mensagem caso o valor seja inválido e
                continue pedindo até que o usuário informe um valor válido.

                2 - Faça um programa que gere números inteiros aleatórios
                entre 1 e 10 e calcule a soma desses números, até que seja
                gerado um número num informado pelo usuário anteriormente.

                3 - Faça um programa que some x números gerados
                aleatoriamente no intervalo de 1 a 10,
                sendo x informado pelo usuário

                4 – Faça um programa que imprima a soma de todos
                os números pares entre dois números quaisquer, incluindo-os.

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def read_grade(self):
        try:
            grade = float(input('Entre com uma nota de 0 a 10: '))
            if grade in range(0, 11):
                print('A nota entrada foi: ', grade)
            else:
                print('Favor entrar com uma nota de 0 a 10!')
                self.read_grade()
        except ValueError:
            self.show_numeric_message()
            self.read_grade()

    def isEven(self, num):
        return num % 2 == 0

    def gera_numero_rand(self):
        try:
            counter = 1
            val = float(input('Entre com um valor de 0 a 10: '))
            if val in range(0, 11):
                num = randint(0, 10)
                while num != val:
                    print('Primeiro numero gerado: ', num)
                    num = randint(0, 10)
                    counter = counter + 1
                print('O programa achou seu número depois da ', counter,
                      ' tentativa.')
            else:
                print('Favor entrar com uma valor de 0 a 10!')
                self.gera_numero_rand()
        except ValueError:
            self.show_numeric_message()
            self.gera_numero_rand()

    def sum_x_values(self):
        try:
            quant = int(input('Entre com um valor inteiro:'))
            sum1 = 0
            for i in range(0, quant):
                sum1 = sum1 + randint(0, 11)
            print('Foram gerados ', quant, ' números. '
                  'A soma dos valores foi de: ', sum1)
        except ValueError:
            self.show_numeric_message()
            self.sum_x_values()

    def sum_x_values_between(self):
        try:
            quant1 = int(input('Entre com o primeiro valor inteiro:'))
            quant2 = int(input('Entre com o segundo valor inteiro:'))
            sum1 = 0
            for i in range(quant1, quant2+1):
                if self.isEven(i):
                    print(i)
        except ValueError:
            self.show_numeric_message()
            self.sum_x_values_between()

    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.read_grade()
            elif option == "2":
                self.gera_numero_rand()
            elif option == "3":
                self.sum_x_values()
            elif option == "4":
                self.sum_x_values_between()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()

p = Problemas_Estruturados()
p.show_menu()