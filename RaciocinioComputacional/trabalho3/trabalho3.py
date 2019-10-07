# coding: utf-8


class Trabalho3:

    def __init__(self):
        self.salaries = []

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
            1 - Entre valor:
            (i) se o valor for 1, 2 ou 3,
            mostre o valor elevado ao quadrado,
            (ii) se o valor for o número 4 ou 9, mostre sua raiz quadrada,
            (iii) se o valor for 6, 7 ou 8, mostre o valor dividido por 9.

            2 - Entre valor:
            (i) se for um valor negativo, mostre seu módulo (valor sem sinal);
            (ii) se for um valor maior do que 10, solicite outro e mostre a diferença entre eles;
            (iii) caso o valor não seja de nenhuma condição anterior, mostre o valor dividido por 5.

            3 - Entre valor:
            (i) se o valor for 1 ou 2, mostre o valor elevado ao cubo;
            (ii) se o valor for múltiplo de 3, mostre seu fatorial;
            (iii) se o valor for 4, 5, 7 ou 8, mostre o valor dividido por 9;
            (iv) caso não seja nenhum dos valores, informe como "valor inválido".

            4 - Leia quanto dinheiro uma pessoa tem na carteira
            e mostre quantos dólares ela pode comprar.

            5 - Leia um número inteiro e mostre na tela se ele é PAR ou ÍMPAR.

            6 - Desenvolva um programa que pergunte a distância de uma viagem 
            em quilômetros. Calcule o preço da passagem, cobrando R$ 0,50 por
            quilômetro para viagens de até 200 km e R$ 0,45 para viagens mais longas.

            7 - Faça um programa que leia três números e mostre qual é o maior
             e qual é o menor.
            
            8 - Escreva um programa que leia dois números inteiros e compare-os, 
            mostrando na tela uma mensagem:
                O primeiro valor é maior.
                O segundo valor é maior.
                Não existe valor maior, os dois são iguais.

            9 - Sair.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def fatorial(self, num):
        aux = 1
        for i in range(2, int(num) + 1):
            aux *= i
        return aux

    def exercicio1(self):
        try:
            num = float(input('Entre com um valor para o exercício1: '))
            if num > 0 and num < 4:
                print('Elevando ao quadrado o número ', num, ': ',
                      round(num ** 2, 2))
            elif num == 4 or num == 9:
                print('Calculando a raiz de ', num, ': ',
                      round(num ** (1.0/2.0)))
            elif num > 5 or num < 9:
                print('Divindindo por 9 o número ', num, ': ',
                      round(num/9, 2))
        except ValueError:
            self.show_numeric_message()

    def exercicio2(self):
        try:
            num = float(input('Entre com um valor: '))
            if num < 0:
                print('O modulo é: ', round(abs(num)))
            elif num > 10:
                num1 = float(input('Entre com outro valor: '))
                print(num, ' menos ', num1, '=',
                      round(num - num1, 2))
            else:
                print('Valor dividido por 5: ', round(num/5.0, 2))

        except ValueError:
            self.show_numeric_message()

    def exercicio3(self):
        try:
            num = float(input('Entre com o valor: '))
            if num == 1 or num == 2:  # 1,2
                print('Valor ao cubo: ', ((num ** 3)))
            elif num % 3 == 0.0:  # 3,6,9...
                print('O fatorial de ', num, ' é: ', self.fatorial(num))
            elif num > 0 and num < 9:  # 4,5,7,8
                print('Valor dividido por 9: ', round(num/9, 2))
            else:
                print('Valor inválido!.')

        except ValueError:
            self.show_numeric_message()

    def reals_to_dolars(self):
        try:
            num = float(input('Quantos reais?: '))
            print('Vc pode comprar: ', round(num/4.1, 0), ' dólares.')
        except ValueError:
            self.show_numeric_message()

    def even_or_odd(self):
        try:
            num = float(input('Entre com um número: '))
            if(num % 2 == 0.0):
                print('O número é par.')
            else:
                print('O número é impar.')
        except ValueError:
            self.show_numeric_message()

    def calc_trip_price(self):
        try:
            num = float(input('Entre com a distância: '))
            tax = .50
            if(num > 200):
                tax = .45
            print('Preço da viagem é de: ', round(num*tax, 2), ' reais.')

        except ValueError:
            self.show_numeric_message()
        
    def calc_lower_higher_value(self, txt):
        try:
            numlist = [int(n) for n in txt.split()]
            lower = numlist[0]
            higher = numlist[0]
            print(lower)
            for i in numlist:
                if i > higher:
                    higher = i
                if i < lower:
                    lower = i
            return lower, higher
        except ValueError:
            self.show_numeric_message()

    def calc_3numbers(self):
        txt = input('Entre com 3 numeros separados por "espaço" Ex.: 1 2 3: ')
        lower, higher = self.calc_lower_higher_value(txt)
        print('Menor num: ', lower, ' Maior num: ', higher)
    
    def calc_high_lower_equal(self):
        txt = input('Entre com 2 números separados por "espaço" Ex.: 13 8: ')
        numlist = [int(n) for n in txt.split()]
        first = numlist[0]
        second = numlist[1]
        if first < second:
            print('O segundo valor é maior.')
        elif first == second:
            print('Os dois números são iguais!.')
        else:
            print('O primeiro valor é maior!')

    def show_menu(self):
        option = self.print_menu()
        while option != "9":
            if option == "1":
                self.exercicio1()
            elif option == "2":
                self.exercicio2()
            elif option == "3":
                self.exercicio3()
            elif option == "4":
                self.reals_to_dolars()
            elif option == "5":
                self.even_or_odd()
            elif option == "6":
                self.calc_trip_price()
            elif option == "7":
                self.calc_3numbers()
            elif option == "8":
                self.calc_high_lower_equal()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()


