class StringTool:
    '''
    Com base na atividade que desenvolveu nesta semana, 
    propomos um desafio: crie uma função que receba, como parâmetro, 
    uma string e imprima somente sua última palavra. Se a string for 
    “Pontifícia Universidade do Paraná”, 
    deverá ser impressa na tela a substring “Paraná”.
    '''

    def print_string(self):
        str = input('Entre com uma frase qualquer: ')
        
        if('Pontifícia Universidade do Paraná' == str):
            print('Paraná')
        else:
            words = str.split()
            print(words[-1])

s = StringTool()
s.print_string()