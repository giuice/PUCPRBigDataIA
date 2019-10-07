#%%
class livros(object):
    def __init__(self):
        self.pilha = []

    def adicionarLivro(self, nome_livro):
        self.pilha.append(nome_livro)

    def listaLivros(self):
        print("A pilha contem: \n")
        [print("livro: " + livro + ".\n") for livro in self.pilha]

    def catalogarLivros(self):
        for i in range(len(self.pilha)):
            print("Catalogando livro: " + self.pilha.pop())

    def empilharLivros(self):
        self.adicionarLivro("Dom Quixote (Miguel de Cervantes)")
        self.adicionarLivro("O conde de Monte Cristo (Alexandre Dumas)")
        self.adicionarLivro("Um conto de duas cidades (Charles Dickens)")
        self.adicionarLivro("O pequeno príncipe. (Antoine de Saint-Exupéry)")
        self.adicionarLivro("O senhor dos anéis (J.R.R. Tolkien)")


#%%
liv = livros()
liv.empilharLivros()
liv.listaLivros()
liv.catalogarLivros()
