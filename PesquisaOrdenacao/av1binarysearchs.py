
#%%
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

#%% [markdown]
# ## Lendo janeiro até dezembro(11)

#%%
dirtydata = pd.read_excel('giu.xls')


#%%
dirtydata['tipogasto'] = ''
dirtydata.head()

#%% [markdown]
# ### Precisamos tratar trazer o tipo de gasto para uma coluna acima

#%%
for index, row in dirtydata.iterrows():
    if row['data'] is not np.NaN:
        dirtydata.loc[index,['tipogasto']] = dirtydata['historico'].loc[index+1]


#%%
finaldata = dirtydata[np.isfinite(dirtydata['debito'])][['data','tipogasto', 'historico','debito']]


#%%
### Transformando o débito em valor positivo
finaldata.debito = -finaldata.debito

#%% [markdown]
# ## Estatísticas dos gastos

#%%
finaldata.describe()


#%%
## Quais foram os maiores gastos?

#%% [markdown]
# ### Categorizando supermercados(Deli delicia, mercado bambina, Zona sul)

#%%
mercados = 'zona|deli|merc|supermer'
finaldata['categoria'] = np.where(finaldata['tipogasto'].str.contains(mercados,case=False),'supermercado','outros')


#%%
#tranformando data em data
import datetime
finaldata['data'] = finaldata['data'].map(lambda x: datetime.datetime.strptime( x, '%d/%m/%y' ))
#pd.to_datetime(finaldata['data'], format='%d/%m/%Y')


#%%
#Criando uma coluna para mes 
meses = {1: 'jan', 2: 'fev', 3: 'mar', 4: 'abr',
        5:'mai', 6:'jun', 7:'jul', 8:'ago',9:'set',
         10:'out', 11:'nov',12:'dez'}
finaldata['mes_nomes'] = finaldata['data'].map(lambda x: x.month).map(meses)


#%%
# recuperando dados de apenas supermercados
superdf = finaldata[finaldata['categoria'] == 'supermercado']


#%%
sns.barplot(x="mes_nomes", y="debito", data=superdf, estimator=sum)


#%%
superdf = superdf.set_index(['data'])


#%%
superdf.groupby(['tipogasto']).sum()['debito']
#superdf.groupby(['tipogasto']).sum()['debito'].unstack().nlargest(10, 'debito')

#%% [markdown]
# ## TOTAL DE GASTO DE JANEIRO A NOVEMBRO

#%%
superdf.debito.sum()


#%%
my_colors = [(x/10.0, x/20.0, 0.75) for x in range(10)]
spmean = superdf.groupby(['tipogasto']).describe().unstack().loc['debito']['mean'].reset_index() #.plot.barh( stacked=True, colormap='Paired')
spstd = superdf.groupby(['tipogasto']).describe().unstack().loc['debito']['std'].reset_index()
spmax = superdf.groupby(['tipogasto']).describe().unstack().loc['debito']['max'].reset_index()

fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(26,10))
#spmean.plot(x = spmean.tipogasto, y=spmean[spmean.columns.values[1]], kind='barh', colormap='magma', ax=ax1)
sns.barplot(x =spmean[spmean.columns.values[1]] , y=spmean.tipogasto, ax=ax1, orient='h').set_title('Médias') 
sns.barplot(y = spstd.tipogasto, x=spstd[spstd.columns.values[1]], ax=ax2, orient='h').set_title('Desvio Padrão') 
sns.barplot(y = spmax.tipogasto, x=spmax[spmax.columns.values[1]], ax=ax3, orient='h').set_title('Máximas')  


#%%
#mapeando saques
finaldata.tipogasto = finaldata.tipogasto.map(lambda x: 'saque' if str(x).startswith('Ag0') else x)
finaldata.tipogasto = finaldata.tipogasto.map(lambda x: 'saque' if str(x).startswith('000') else x)
#mapeando 

#%% [markdown]
# ### Quanto forams os gastos totais divididos em supermercado etc...?

#%%
finaldata.groupby(['categoria']).sum()['debito']
#plt.show()
#.nlargest(10, 'debito').plot()

#%% [markdown]
# # Apenas de 2018 nos meses janeiro a novembro gastei 15000 reais... Vamos vizualizar isso

#%%
sns.barplot(x="categoria", y="debito", data=finaldata, estimator=sum)
plt.show()


#%%
fig, axs = plt.subplots(1,2,figsize=(15,6))
sns.barplot(x="mes", y="debito", data=finaldata, estimator=sum, ax=axs[0])
sns.barplot(x="mes", y="debito", data=finaldata[finaldata['categoria'] == 'supermercado'], estimator=sum, ax=axs[1])
fig

#%% [markdown]
# ### Setando o index a data

#%%
final = finaldata.set_index(['data'])


#%%
final[final['categoria'] == 'supermercado'].groupby(['mes']).sum().unstack().plot.bar()
#final.groupby([pd.Grouper(freq='M'),'categoria']).size().plot.bar()
#final.groupby([pd.Grouper(freq='M'),'categoria']).sum()['debito'].unstack().plot.bar()
#sns.barplot(final['mes'], final[])
plt.show()


#%%
finaldata.plot(x='categoria', y='debito')
plt.show()


#%%
def bogo_bubble(blist):
    cmpcount, swapcount = 0, 0
    n = 0
    while n < len(blist) - 1:
        cmpcount += 1
        if blist[n] > blist[n + 1]:
            swapcount += 1
            blist[n], blist[n+1] = blist[n+1], blist[n]
            n = 0
        else:
            n = n + 1
    return blist, cmpcount, swapcount


#%%



#%%
def wp1_bubble(blist):
    cmpcount, swapcount = 0, 0
    while True:
        swapped = False
        for i in range(1, len(blist)):
            cmpcount += 1
            if blist[i-1] > blist[i]:
                swapcount += 1
                blist[i-1], blist[i] = blist[i], blist[i-1]
                swapped = True
        if not swapped:
            break
    return blist, cmpcount, swapcount


#%%
def wp2_bubble(blist):
    cmpcount, swapcount = 0, 0
    n = len(blist)
    while True:
        swapped = False
        for i in range(1, n):
            cmpcount += 1
            if blist[i-1] > blist[i]:
                swapcount += 1
                blist[i-1], blist[i] = blist[i], blist[i-1]
                swapped = True
        n -= 1
        if not swapped:
            break
    return blist, cmpcount, swapcount

import random
alist = [random.randrange(100) for _ in range(100)]
bb, cb, sb = bogo_bubble(alist[:])
b1, c1, s1 = wp1_bubble(alist[:])
b2, c2, s2 = wp2_bubble(alist[:])
assert bb == b1 == b2
print('bogo_bubble: {} cmp, {} swap'.format(cb, sb))
print('wp1_bubble : {} cmp, {} swap'.format(c1, s1))
print('wp2_bubble : {} cmp, {} swap'.format(c2, s2))


