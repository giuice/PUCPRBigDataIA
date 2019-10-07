
class Vetores:

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
                1) - Dada uma sequência de números inteiros maiores que 1, 
                terminando por 0, determine quantos números primos há nela. 
                Crie uma função car para determinar os números primos.
                2) - Faça um algoritmo que solicite ao usuário números 
                e os armazene em um vetor de 20 posições. 
                Crie uma função que receba o vetor preenchido e substitua 
                todas as ocorrências de valores negativos por 0, 
                as de valores menores do que 10 por 1 e as demais por 2.
                3) - Crie um algoritmo que solicite 3 valores que representarão os 
                lados de um triângulo. Considere que não importa a ordem em que serão 
                fornecidos os valores, podendo ser fornecido primeiramente a hipotenusa e 
                depois os catetos ou os catetos e depois a hipotenusa etc. 
                Crie também uma função que recebe o vetor e retorne se os lados informados 
                formam um triângulo retângulo. 
                Você pode utilizar o teorema de Pitágoras para auxiliar na resolução: 
                hipotenusa2 = cateto12 + cateto22

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