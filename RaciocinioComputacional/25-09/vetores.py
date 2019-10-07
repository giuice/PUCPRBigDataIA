
class Vetores:

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
                1) Crie um programa que armazene a nota e nome de 40 estudantes. 
                Imprima o nome e a nota do estudante.

                2) Faça um programa que leia um vetor de 5 números inteiros e mostre-os.

                3) Faça um programa que leia um vetor de 10 números reais e mostre-os na ordem inversa.

                4) Faça um programa que leia 4 notas e mostre essas notas e a média na tela.

                5) Faça um programa que leia um vetor de 10 caracteres e 
                diga quantas consoantes foram lidas, imprimindo as consoantes.

                6) Faça um programa que leia 20 números inteiros e armazene-os num vetor. 
                Armazene os números pares no vetor PAR e os números ímpares no vetor ÍMPAR. 
                Imprima os três vetores.

                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def read_students(self):
        students = [[], []]
        for i in range(0, 2):
            students[0].append(input('Entre com o nome: '))
            students[1].append(float(input('Entre com a nota: ')))
        for i in range(0, len(students)):
            print('Nome: ', students[0][i], ' - Nota: ', students[1][i])
    
    def read_numbers(self):
        vetor = []
        try:
            for i in range(0, 10):
                vetor.append(int(input('Entre com o ' + str(i+1) + ' número: ')))
            print(' '.join(map(str, vetor)))
        except ValueError:
            self.show_numeric_message()

    def read_numbers_inverse(self):
        vetor = []
        try:
            for i in range(0, 10):
                vetor.append(int(input('Entre com o ' + str(i+1) + ' número: ')))
            print(' '.join(map(str, vetor[::-1])))
        except ValueError:
            self.show_numeric_message()

    def read_grades(self):
        grades = []
        for i in range(0, 4):
            grades.append(float(input('Entre com a nota: ')))
        print('As notas são:',  ' '.join(map(str, grades)))
        print('A média é:', sum(grades)/len(grades))
  
    def read_letters(self):
        letters = []
        for i in range(0, 10):
            letter = input('Entre com uma letra: ')[0]
            if letter not in 'aeiouáéíóúàãõ':
                letters.append(letter)
        print('Foram tecladas ', len(letters), ' consoantes. ', 
              ''.join(letters))
    
    def print_vectors(self):
        numbers, odds, evens = [], [], []
        for i in range(0, 20):
            number = int(input('Entre com um número inteiro: '))
            numbers.append(number)
            if not number % 2:
                evens.append(number)
            else:
                odds.append(number)
        print('Vetor completo: ', ' '.join(map(str, numbers)))
        print('Vetor de pares: ', ' '.join(map(str, evens)))
        print('Vetor de impares: ', ' '.join(map(str, odds)))
        
    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.read_students()
            elif option == "2":
                self.read_numbers()
            elif option == "3":
                self.read_numbers_inverse()
            elif option == "4":
                self.read_grades()
            elif option == "5":
                self.read_letters()
            elif option == "6":
                self.print_vectors()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()

p = Vetores()
p.show_menu()