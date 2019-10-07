""" Algoritmos de ordenação

Esse programa apresenta um comparativo do tempo de execução dos métodos BubbleSort, InsertionSort, QuickSort e sort (método do python)

Nos testes, são ordenados números interios de 0 até 1000000

O programa deve ser executado com 500, 1.000 e 5.000 números. Com cada uma das três quantidades de números, deve-se testar o vetor com números aleatórios, ordenados em ordem crescente e ordenados em ordem decrescente.

Deverão ser realizados 9 testes, esses testes representam o melhor caso, pior caso e caso médio de todos os algoritmos. Armazene os resultados em uma tabela para facilitar a visualização.

"""
#%%
import random
import time
import sys
import math

sys.setrecursionlimit(1000000)

#%% definindo função de tempo
def showTime(fnc,arr):
    inicio = time.time()
    arr = fnc(arr)
    fim = time.time()
    print(arr)
    print("Tempo da função (s) -%.2gs" %  (fim - inicio))

#%% criando um array
myarr = [10, 4,3, 4, 2,40,50,42,31,55,22,23,16,17,33,9,8,9,13,98, 83,72, 65, 64,72,56]

#%% bubblesort
def bubbleSort(alistf):
    #cmpcount, swapcount = 0, 0
    n = len(alistf)
    
    while True:
        spd = False
        for i in range(1, n):
            #cmpcount += 1
            if alistf[i-1] > alistf[i]:
                #swapcount += 1
                alistf[i-1], alistf[i] = alistf[i], alistf[i-1]
                spd = True
        n -= 1
        if not spd:
            break
    return alistf

showTime(bubbleSort,myarr)


#%% InsertionSort
def insertionSort(alistf):
    #implemente aqui o InsertionSort
    for index in range(1,len(alistf)):

        currentvalue = alistf[index]
        position = index
        print('currentvalue', currentvalue)
        print('position', position)
        while position>0 and alistf[position-1]>currentvalue:
            alistf[position], position=alistf[position-1], position-1
            #position = position-1
        alistf[position]=currentvalue
    return alistf

showTime(insertionSort,myarr)


#%% QuickSort
def quickSort(alistf):
   quickSortHelper(alistf,0,len(alistf)-1)


def quickSortHelper(alistf,first,last):
   if first<last:

       splitpoint = partition(alistf,first,last)

       quickSortHelper(alistf,first,splitpoint-1)
       quickSortHelper(alistf,splitpoint+1,last)


def partition(alistf,first,last):
    pivotvalue = alistf[first]

    leftmark = first + 1
    rightmark = last

    done = False
    while not done:

        while leftmark <= rightmark and alistf[leftmark] <= pivotvalue:
            leftmark = leftmark + 1

        while alistf[rightmark] >= pivotvalue and rightmark >= leftmark:
            rightmark = rightmark - 1

        if rightmark < leftmark:
            done = True
        else:
            temp = alistf[leftmark]
            alistf[leftmark] = alistf[rightmark]
            alistf[rightmark] = temp

    temp = alistf[first]
    alistf[first] = alistf[rightmark]
    alistf[rightmark] = temp

    return rightmark

def myQuickSort(alistf):
    if alistf == []: 
        return []
    else:
        pivot = alistf[0]
        lesser = myQuickSort([x for x in alistf[1:] if x < pivot])
        greater = myQuickSort([x for x in alistf[1:] if x >= pivot])
        return lesser + [pivot] + greater

def bucketSort(alistf,  bucketSize=0):
    # Guardando o valor pra evitar processamentos desnecessario
    list_size = len(alistf)
    #li no artigo 
    if bucketSize == 0:
        bucketSize = math.ceil(math.sqrt(list_size))
    if(list_size == 0):
        print('Sem elementos no array.')
    maxValue = alistf[0]
    # For finding minimum and maximum values
    for i in range(0, list_size):
        if alistf[i] > maxValue:
            maxValue = alistf[i] 
    # Initialize buckets
    divider = math.ceil((maxValue +1) / bucketSize) 
    maxindex = math.floor(maxValue/divider)
    if(maxindex > divider):
        divider = maxindex
        
    buckets = [[] for _ in range(0,divider)]
    
    # For putting values in buckets
    for i in range(0, list_size):
        buckets[math.floor((alistf[i] / divider))].append(alistf[i])

    ''' python é maravilhoso! somando os arrays [1,2] + [3,4] =
        array de [1,2,3,4]

    '''
    sortedArray = []
    for i in range(0, divider):
        sortedArray += insertionSort(buckets[i])

    return sortedArray

#Chamada dos metodos
#%%
alist = random.sample(range(1000000), 900000) #cria uma lista com os valores do teste, usar 500, 1.000 e 5.000
#alist.sort() #utilize para testar com a lista ordenada em ordem crescente
#alist.sort(reverse=True) #utilize para testar com a lista em ordem decrescente

#%%
'''
alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
bubbleSort(alisttemp)
fim = time.time()
print("Tempo do BubbleSort (s) - " + str(fim - inicio))
print(alisttemp[0:5])

alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
insertionSort(alisttemp)
fim = time.time()
print("Tempo do InsertionSort (s) - " + str(fim - inicio))
print(alisttemp[0:5])
'''
#%%
alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
quickSort(alisttemp)
fim = time.time()
print("Tempo do QuickSort (s) - " + str(fim - inicio))
print(alisttemp[0:5])

alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
alisttemp.sort()
fim = time.time()
print("Tempo do método Sort (s) - " + str(fim - inicio))
print(alisttemp[0:5])

alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
mylist = myQuickSort(alisttemp)
fim = time.time()
print("Tempo do método myQuickSort (s) - " + str(fim - inicio))
print(mylist[0:5])

alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
mylist = bucketSort(alisttemp,2000)
fim = time.time()
print("Tempo do método bucketSort (s) - " + str(fim - inicio))
print(mylist[0:5])

#%%
math.sqrt(900000)