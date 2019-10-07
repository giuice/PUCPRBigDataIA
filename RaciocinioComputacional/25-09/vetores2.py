
from functools import reduce


class Vetores2:

    def show_numeric_message(self):
        print('Favor entrar com valóres numéricos.')

    def print_menu(self):
        print("""
                1. Faça um programa que peça as quatro notas de 10 alunos, 
                calcule e armazene num vetor a média de cada um e imprima 
                o número de alunos com média maior ou igual a 7,0.
                2. Faça um programa que leia um vetor de 5 números inteiros e 
                mostre a soma, a multiplicação e os números.
                3. Faça um programa que leia um número indeterminado de valores, 
                correspondente a notas, encerrando a entrada de dados quando for 
                informado um valor igual a -1 (que não deve ser armazenado). 
                Após essa entrada de dados:
                    a.Mostre a quantidade de valores que foram lidos.
                    b.Exiba todos os valores na ordem em que foram informados, um ao lado do outro.
                    c.Exiba todos os valores na ordem inversa àquela em que foram informados, um abaixo do outro.
                    d.Calcule e mostre a soma dos valores.
                    e.Calcule e mostre a média dos valores.
                    f.Calcule e mostre a quantidade de valores acima da média calculada.
                    g.Calcule e mostre a quantidade de valores abaixo de 7.
                    h.Encerre o programa com uma mensagem.
                4.Faça um programa que receba a temperatura média de cada mês do ano e armazene-as em uma lista. 
                Após isso, calcule a média anual das temperaturas e mostre todas aquelas acima da média anual e 
                em que mês ocorreram (mostrar o mês por extenso: 1 – Janeiro, 2 – Fevereiro...).
                0 - Sair do programa.
            """)
        return input('Qual opção você gostaria de executar?: ')

    def calc_grade_mean(self):
        w, h = 4, 20
        grades = [[0 for x in range(w)] for y in range(h)]
        mean = []
        print(grades)
        for i in range(0, h):
            for j in range(0, w):
                idx = i+1
                grades[i][j]= (int(input('Entre com a nota ' + str(j+1) +  ' do aluno ' + str(idx) + ': ')))

        for i in range(0, 20):
            idx = i+1
            mean = sum(grades[i])/4
            print('Aluno: ', str(idx), ' - Media: ', str(mean))
    
    def read_numbers(self):
        vetor = []
        try:
            for i in range(0, 5):
                vetor.append(int(input('Entre com o ' + str(i+1) + ' número: ')))
            print('Os números: ', ', '.join(map(str, vetor)))
            print('A soma: ', sum(vetor))
            print('A multiplicação: ', reduce(lambda x, y: x * y, vetor, 1))
        except ValueError:
            self.show_numeric_message()

    def read_numbers2(self):
        vetor = []
        controle = 0
        try:
            while controle != -1:
                controle = int(input('Entre com um número inteiro: '))
                if controle != -1:
                    vetor.append(controle)
            print('Foram lidos ', str(len(vetor)), ' números.')
            print('Ao lado: ', ' '.join(map(str, vetor)))
            print('Inverso : ', '\n '.join(map(str, vetor[::-1])))
            soma = sum(vetor)
            media = sum(vetor)/len(vetor)
            maiorquemedia = [i for i in vetor if i > media]
            abaixode7 = [i for i in vetor if i < 7]
            print('A Soma: ', soma)
            print('A média: ', media)
            print('Quantidade de números maior que a média',  len(maiorquemedia))
            print('Abaixo de 7: ', len(abaixode7))
            print('*'*67)
            print('--'*8, 'MUITO OBRIGADO E VOLTE SEMPRE!', '--'*8)
            print('*'*67)
        except ValueError:
            self.show_numeric_message()

    def calc_temp_mean(self):
        meses = ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro',
        'Outubro','Novembro','Dezembro']
        temps = []
        for mes in meses:
            temps.append(int(input('entre com a temperatura do mês de ' + mes + ': ')))
        media = sum(temps)/12
        print('Média anual de temperatura: ', media)
        for i in range(0, 12):
            if temps[i] > media:
                print('No mês de ', meses[i], ' a temperatura foi de ', temps[i], '.')

     
    def show_menu(self):
        option = self.print_menu()
        while option != "0":
            if option == "1":
                self.calc_grade_mean()
            elif option == "2":
                self.read_numbers()
            elif option == "3":
                self.read_numbers2()
            elif option == "4":
                self.calc_temp_mean()
            else:
                print('Opção inválida, por favor escolha novamente:')
            option = self.print_menu()

p = Vetores2()
p.show_menu()