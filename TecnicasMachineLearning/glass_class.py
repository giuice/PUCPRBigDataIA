# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %% [markdown]
# # AV – Trabalho: Criação de um classificador

# %%
# Este exemplo carrega a base Wine da UCI, treina uma Arvore de decisao usando 
# holdout e outra usando validacao cruzada com 10 pastas. 

# Importa bibliotecas necessarias 
import numpy as np
import urllib
from sklearn import tree
from sklearn import  model_selection
from sklearn.tree import plot_tree
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import pandas as pd

# %% [markdown]
# #### A base consistem em 11 colunas:
# 1. Id number: 1 to 214
# 2. RI: refractive index
# 3. Na: Sodium (unit measurement: weight percent in corresponding oxide, as are attributes 4-10)
# 4. Mg: Magnesium
# 5. Al: Aluminum
# 6. Si: Silicon
# 7. K: Potassium
# 8. Ca: Calcium
# 9. Ba: Barium
# 10. Fe: Iron
# 11. Type of glass: (class attribute)
# - 1 building_windows_float_processed
# - 2 building_windows_non_float_processed
# - 3 vehicle_windows_float_processed
# - 4 vehicle_windows_non_float_processed (none in this database)
# - 5 containers
# - 6 tableware
# - 7 headlamps

# %%
data = pd.read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/glass/glass.data", header=None, names=['RI','Na','Mg','Al','Si','K','Ca','Ba','Fe','Glass_Type'], index_col=0)


# %%
names=['RI','Na','Mg','Al','Si','K','Ca','Ba','Fe']


# %%
data.head()


# %%
data.tail()


# %%
data.info()


# %%
data.describe()

# %% [markdown]
# #### A classe é composta de 7 tipos
# - 1 building_windows_float_processed
# - 2 building_windows_non_float_processed
# - 3 vehicle_windows_float_processed
# - 4 vehicle_windows_non_float_processed (none in this database)
# - 5 containers
# - 6 tableware
# - 7 headlamps

# %%
data[['Glass_Type']].value_counts()

# %% [markdown]
# <i> Uma nota é que caso não exite o valor 4 nessa base ou seja nosso algoritmo ficara perdido ao tentar prever uma base com valores 4.</i>

# %%
X = data.iloc[:,:9]
y = data.iloc[:,-1]

# %% [markdown]
# ## EXEMPLO USANDO HOLDOUT
# #### Holdout -> dividindo a base em treinamento (70%) e teste (30%), estratificada

# %%

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=.3, random_state=42, stratify=y)

# declara o classificador
clfa = tree.DecisionTreeClassifier(criterion='entropy')

# treina o classificador
clfa.fit(X_train, y_train)

# testa usando a base de testes
predicted=clfa.predict(X_test)

# calcula a acuracia na base de teste (taxa de acerto)
score=clfa.score(X_test, y_test)

# calcula a matriz de confusao
matrix = confusion_matrix(y_test, predicted)

# apresenta os resultados
print("\nResultados baseados em Holdout 70/30")
print("Taxa de acerto = %.2f " % score)
print("Matriz de confusao:")
print(matrix)

# %% [markdown]
# ## EXEMPLO USANDO VALIDACAO CRUZADA

# %%

clfb = tree.DecisionTreeClassifier(criterion='entropy')
folds=10
result = model_selection.cross_val_score(clfb, X, y, cv=folds)

print("\nResultados baseados em Validacao Cruzada")
print("Qtde folds: %d:" % folds)
print("Taxa de Acerto: %.2f" % result.mean())
print("Desvio padrao: %.2f" % result.std())

# matriz de confusÃ£o da validacao cruzada
Z = model_selection.cross_val_predict(clfb, X, y, cv=folds)
cm=confusion_matrix(y, Z)
print("Matriz de confusao:")
print(cm)


#imprime a arvore gerada
print("\nArvore gerada no experimento baseado em Holdout")
fig = plt.figure(figsize=(40,30))
clfb.fit(X_train, y_train)

#representacao em texto
text_representation = tree.export_text(clfb)
print(text_representation)

plot_tree(clfb, feature_names=names,  
                   class_names=['windows_f','windows','autowindows_f','autowindows','containers','table','headlamps'],
                   filled=True)
plt.show()


# %%
from dtreeviz.trees import dtreeviz

viz = dtreeviz(clfa,X,y,target_name='', feature_names=names,class_names=list(['windows_f','windows','autowindows_f','autowindows','containers','table','headlamps']))


# %%
viz.view()


#%%
import matplotlib as mpl
mpl.style.use('ggplot')
# %%
