
class Estruturas_Repeticao:

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
                1. Faça um programa para calcular o fatorial de um número,
                utilizando o laço de repetição “for”.

                2. Faça um programa para calcular o fatorial de um número, 
                utilizando o laço de repetição “while”.

                3. Faça um programa que leia um número inteiro qualquer 
                e mostre na tela sua tabuada.

                4. Faça um programa que calcule a soma entre todos os 
                números múltiplos de 3 e que se encontram no intervalo de 1 a 500.

                5. Desenvolva um programa que leia 6 números inteiros e mostre a 
                soma apenas daqueles que forem pares. 
                
                6. Desenvolva um programa que leia o primeiro termo e a razão de 
                uma progressão aritmética. 

                7. Faça um programa que leia um número inteiro e diga se ele é ou 
                não um número primo.

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def fatorial_for(self):
        try:
            num = int(input('Entre com o numero para calculo fatorial: '))
            aux = 1
            for i in range(2, int(num) + 1):
                aux *= i
            print('O fatorial do número ', num, ' é: ', aux)
        except ValueError:
            self.show_numeric_message()

    def fatorial_while(self):
        try:
            num = int(input('Entre com o numero para calculo fatorial: '))
            aux = 1
            num_temp = num
            while num >= 1:
                aux = aux * num
                num = num - 1
            print('O fatorial do número ', num_temp, ' é: ', aux)
        except ValueError:
            self.show_numeric_message()

    def calc_tabuada(self):
        try:
            num = int(input('Entre com qualquer número inteiro: '))
            for i in range(1, 11):
                print(num, ' * ', i, ' = ', num * i)
        except ValueError:
            self.show_numeric_message()

    def calc_multiple_3(self):
        num = sum(num for num in range(1, 501) if not num % 3)
        print('A soma de todos numeros multiplos de 3 de 1 a 500 é:', num)

    def sum_multiple_2(self):
        nums = []
        counter = 0
        while counter < 6:
            counter = counter + 1
            message = 'Entre com o ' + str(counter) + 'o. número: '
            num = int(input(message))
            if not num % 2:
                nums.append(num)
        print('A soma de todos números pares digitados é: ',
              sum(nums))
    
    def calc_arith_progression(self):
        termo = int(input('Entre com o termo: '))
        razao = int(input('Entre com a razão: '))
        print('Os 10 primeiros termos da progreção são:')
        proglist = []
        for i in range(0,10):
            termo = termo + razao
            proglist.append(termo)
        print(",".join(map(str, proglist)))

    def is_prime(self, num):
        for i in range(3, num):
            if not num % i:
                return False
        return True

    def calc_prime(self):
        num = int(input('Entre o número para checar se é primo: '))
        if self.is_prime(num):
            print('É primo!!!')
        else:
            print("Não é primo!!!")
        
    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.fatorial_for()
            elif option == "2":
                self.fatorial_while()
            elif option == "3":
                self.calc_tabuada()
            elif option == "4":
                self.calc_multiple_3()
            elif option == "5":
                self.sum_multiple_2()
            elif option == "6":
                self.calc_arith_progression()
            elif option == "7":
                self.calc_prime()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()

p = Estruturas_Repeticao()
p.show_menu()